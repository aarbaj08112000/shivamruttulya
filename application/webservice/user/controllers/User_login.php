<?php defined('BASEPATH') or exit('No direct script access allowed');

class User_login extends My_Api_Controller
{
    public function index_post()
    {
        $this->response([
            'success' => 0,
            'message' => 'This endpoint is deprecated. Please use WS/auth/login instead.',
            'data' => []
        ], REST_Controller::HTTP_MOVED_PERMANENTLY);
    }
}
