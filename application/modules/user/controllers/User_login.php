<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once(APPPATH.'webservice/wsengine/controllers/Api_response.php');

class User_login extends MX_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('user/Login_model');
    }

    public function index_post() {
        $api_response = new Api_response();
        
        $email = $this->input->post('email');
        $password = $this->input->post('password');

        if (empty($email) || empty($password)) {
            $return_arr = [
                "success" => 0,
                "message" => "Email and password are required.",
                "data" => []
            ];
            $api_response->response_return($return_arr, REST_Controller::HTTP_OK);
            return;
        }

        $result = $this->Login_model->get_user_exist($email);

        if (empty($result) || $password !== $result['password']) {
            $return_arr = [
                "success" => 0,
                "message" => "Invalid credentials!",
                "data" => []
            ];
            $api_response->response_return($return_arr, REST_Controller::HTTP_OK);
            return;
        }

        if ($result['status'] !== 'active') {
            $return_arr = [
                "success" => 0,
                "message" => "User account is inactive!",
                "data" => []
            ];
            $api_response->response_return($return_arr, REST_Controller::HTTP_OK);
            return;
        }

        $user_data = [
            'id' => $result['id'],
            'name' => $result['name'],
            'email' => $result['email'],
            'mobile' => $result['mobile'],
            'role_id' => $result['role_id'],
        ];

        $return_arr = [
            "success" => 1,
            "message" => "Login successful",
            "data" => $user_data
        ];
        
        $api_response->response_return($return_arr, REST_Controller::HTTP_OK);
    }
}
