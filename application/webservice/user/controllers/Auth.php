<?php
class Auth extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_login_model');
    }

    public function login()
    {
        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }
        if (!is_array($input)) {
            $input = [];
        }

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
        $this->form_validation->set_rules('password', 'Password', 'required');
        
        if ($this->form_validation->run() === false) {
            return $this->response(['success' => 0, 'errors' => $this->form_validation->error_array(), "data" => (object)[]], REST_Controller::HTTP_BAD_REQUEST);
        }
        
        $user = $this->user_login_model->get_by_email($input['email']);
        
        // Match plain text password
        if (!$user || $input['password'] !== $user->password) {
            return $this->response(['success' => 0, 'message' => 'Invalid credentials', "data" => (object)[]], REST_Controller::HTTP_OK);
        }
        
        $payload = ['uid' => $user->id, 'iat' => time(), 'exp' => time() + $this->jwt_exp];
        $token = $this->jwt_encode($payload);
        
        $device_id = $input['device_id'] ?? 'unknown';
        $device_type = $input['device_type'] ?? 'unknown';
        
        $this->user_login_model->set_token($user->id, $token, $device_id, $device_type);
        
        $data['token'] = $token;
        $data['id'] = $user->id;
        unset($user->password);
        $data['user_details'] = $user;
        
        return $this->response(['success' => 1, 'message' => 'Login successfully', 'data' => $data], REST_Controller::HTTP_OK);
    }

    public function logout()
    {
        if ($this->authenticate() !== true) {
            return;
        }

        $this->user_login_model->set_token($this->current_user->id, null);
        return $this->response(['success' => 1, 'message' => 'Logged out', 'data' => []], REST_Controller::HTTP_OK);
    }

    public function forgot_password()
    {
        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }
        if (!is_array($input)) {
            $input = [];
        }

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
        $this->form_validation->set_rules('new_password', 'New Password', 'required');

        if ($this->form_validation->run() === false) {
            return $this->response(['success' => 0, 'errors' => $this->form_validation->error_array(), "data" => (object)[]], REST_Controller::HTTP_BAD_REQUEST);
        }

        $user = $this->user_login_model->get_by_email($input['email']);

        if (!$user) {
            return $this->response(['success' => 0, 'message' => 'Email not found.', 'data' => (object)[]], REST_Controller::HTTP_OK);
        }

        $updated = $this->user_login_model->update_password_by_email($input['email'], $input['new_password']);

        if ($updated) {
            return $this->response(['success' => 1, 'message' => 'Password updated successfully.', 'data' => (object)[]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update password.', 'data' => (object)[]], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function reset_password()
    {
        if ($this->authenticate() !== true) return;

        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }
        if (!is_array($input)) {
            $input = [];
        }
        
        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('old_password', 'Old password', 'required');
        $this->form_validation->set_rules('new_password', 'New password', 'required');
        
        if ($this->form_validation->run() === false) {
            return $this->response(['success' => 0, 'errors' => $this->form_validation->error_array(), 'data' => (object)[]], REST_Controller::HTTP_BAD_REQUEST);
        }
        
        $user = $this->current_user; // loaded by authenticate()

        if ($input['old_password'] !== $user->password) {
            return $this->response(['success' => 0, 'message' => 'Old password does not match.', 'data' => (object)[]], REST_Controller::HTTP_OK);
        }

        $updated = $this->user_login_model->update_password_by_id($user->id, $input['new_password']);
        
        if ($updated) {
            return $this->response(['success' => 1, 'message' => 'Password reset successfully.', 'data' => (object)[]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to reset password.', 'data' => (object)[]], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}

/* tests */