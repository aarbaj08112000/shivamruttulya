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
            $this->response([
                'success' => 0,
                'message' => 'Validation failed',
                'errors'  => $this->form_validation->error_array(),
                'data' => (object)[]
            ], REST_Controller::HTTP_BAD_REQUEST);
            return;
        } else {
            $name = $this->security->xss_clean($input["name"]);
            $mobile = $this->security->xss_clean($input["mobile"]);

            $update_arr = [
                "name" => $name,
                "mobile" => $mobile,
                "updated_by" => $user_id,
                "updated_date" => date("Y-m-d H:i:s")
            ];
            
            if (isset($input["profile_image"])) {
                $update_arr["profile_image"] = $this->security->xss_clean($input["profile_image"]);
            }
            
            $affected = $this->user_login_model->update_user($user_id, $update_arr);
            
            if ($affected) {
                $success = 1;
                $message = "User details updated successfully";
            } else {
                $success = 1; // It's still success if nothing changed
                $message = "No changes made to user details";
            }
            
            $data['id'] = $user_id;
            
            return $this->response([
                "success" => $success,
                "message" => $message,
                'data' => $data
            ], REST_Controller::HTTP_OK);
        }
    }
}

/* tests */
