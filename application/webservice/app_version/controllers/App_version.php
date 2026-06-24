<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class App_version extends My_Api_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('app_version_model');
    }

    public function latest_get() {
        $latest = $this->app_version_model->get_latest();

        if ($latest) {
            return $this->response([
                'success' => true,
                'latest_version' => $latest['latest_version'],
                'minimum_version' => $latest['minimum_version'],
                'force_update' => (bool)$latest['force_update'],
                'update_message' => $latest['update_message'],
                'apk_url' => $latest['apk_url']
            ], REST_Controller::HTTP_OK);
        } else {
            return $this->response([
                'success' => false,
                'message' => 'No app version found.'
            ], REST_Controller::HTTP_OK);
        }
    }
}
