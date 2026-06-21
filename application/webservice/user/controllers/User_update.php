<?php defined('BASEPATH') or exit('No direct script access allowed');

class User_update extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('user_login_model');
        $this->load->library('form_validation');
    }

    public function index_post()
    {
        if ($this->authenticate() !== true) {
            return;
        }

        $user_id = $this->current_user->id; // ID loaded from JWT token payload -> user table

        $input = $this->post();
        if (empty($input)) {
            $input = json_decode($this->input->raw_input_stream, true);
        }
        if (!is_array($input)) {
            $input = [];
        }

        $this->form_validation->set_data($input);

        $config = array(
            array(
                'field' => 'name',
                'label' => 'Name',
                'rules' => 'trim|required'
            ),
            array(
                'field' => 'mobile',
                'label' => 'Mobile Number',
                'rules' => 'trim|required'
            )
        );

        $this->form_validation->set_rules($config);

        if ($this->form_validation->run() === FALSE) {
            return $this->response([
                'success' => 0,
                'message' => 'Validation failed',
                'errors' => $this->form_validation->error_array(),
                'data' => (object) []
            ], REST_Controller::HTTP_BAD_REQUEST);
        }

        $name = $this->security->xss_clean($input['name']);
        $mobile = $this->security->xss_clean($input['mobile']);

        $update_arr = [
            'name' => $name,
            'mobile' => $mobile,
            'updated_by' => $user_id,
        ];

        // Handle multipart file upload for profile image using CI Upload Library
        if (isset($_FILES['profile_image']) && !empty($_FILES['profile_image']['name'])) {
            $upload_path = FCPATH . 'public/uploads/users/';
            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            $config_upload = [
                'upload_path' => $upload_path,
                'allowed_types' => 'jpg|jpeg|png|webp',
                'max_size' => 5120, // 5MB limit
                'encrypt_name' => TRUE
            ];

            $this->load->library('upload', $config_upload);
            $this->upload->initialize($config_upload);

            if ($this->upload->do_upload('profile_image')) {
                $upload_data = $this->upload->data();
                $encrypted_name = $upload_data['file_name'];

                // Delete old profile image if exists
                $existing_user = $this->user_login_model->get_by_id($user_id);
                if ($existing_user && !empty($existing_user->profile_image)) {
                    $old_file = $upload_path . $existing_user->profile_image;
                    if (file_exists($old_file)) {
                        @unlink($old_file);
                    }
                }
                $update_arr['profile_image'] = $encrypted_name;
            } else {
                return $this->response([
                    'success' => 0,
                    'message' => strip_tags($this->upload->display_errors()),
                    'data' => (object) []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }
        // Handle base64 profile image upload (fallback)
        else if (!empty($input['profile_image']) && is_string($input['profile_image'])) {
            $base64_string = $input['profile_image'];

            // Strip data URI prefix if present (e.g. "data:image/jpeg;base64,...")
            if (strpos($base64_string, ';base64,') !== false) {
                list($type_part, $base64_string) = explode(';base64,', $base64_string);
                $ext = strtolower(str_replace('data:image/', '', $type_part)); // jpg/png/jpeg
                if ($ext === 'jpeg')
                    $ext = 'jpg';
            } else {
                $ext = 'jpg'; // default
            }

            $image_data = base64_decode($base64_string);

            if ($image_data === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Invalid image data',
                    'data' => (object) []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }

            // Encrypted filename: sha256(user_id + timestamp + random)
            $encrypted_name = hash('sha256', $user_id . time() . mt_rand(1000, 9999)) . '.' . $ext;

            // Upload path: FCPATH = public/
            $upload_path = FCPATH . 'uploads/users/';

            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            if (file_put_contents($upload_path . $encrypted_name, $image_data) === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Failed to save profile image',
                    'data' => (object) []
                ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
            }

            // Delete old profile image if exists
            $existing_user = $this->user_login_model->get_by_id($user_id);
            if ($existing_user && !empty($existing_user->profile_image)) {
                $old_file = $upload_path . $existing_user->profile_image;
                if (file_exists($old_file)) {
                    @unlink($old_file);
                }
            }

            $update_arr['profile_image'] = $encrypted_name;
        }

        $affected = $this->user_login_model->update_user($user_id, $update_arr);
        if ($affected) {
            $message = 'User details updated successfully';
        } else {
            $message = 'No changes made to user details';
        }

        $response_data = ['id' => $user_id];
        if (isset($update_arr['profile_image'])) {
            $response_data['file_name'] = $update_arr['profile_image'];
            $response_data['file_path'] = base_url('uploads/users/' . $update_arr['profile_image']);
        }

        return $this->response([
            'success' => 1,
            'message' => $message,
            'data' => $response_data
        ], REST_Controller::HTTP_OK);
    }
}

/* tests */
