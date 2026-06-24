<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class App_version extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('App_version_model');
    }

    public function index() {
        $latest = $this->App_version_model->get_latest_version();

        $data = array();
        
        if ($latest) {
            // Split the version by dots, increment the last part, and join back
            $version_parts = explode('.', $latest['latest_version']);
            $last_index = count($version_parts) - 1;
            if ($last_index >= 0 && is_numeric($version_parts[$last_index])) {
                $version_parts[$last_index] = (int)$version_parts[$last_index] + 1;
                $data['latest_version'] = implode('.', $version_parts);
            } else {
                // Fallback if the string does not end in a number
                $data['latest_version'] = $latest['latest_version'] . '.1';
            }
            $data['minimum_version'] = $latest['minimum_version'];
        } else {
            $data['latest_version'] = "1.0.0";
            $data['minimum_version'] = "1.0.0";
        }
        
        $this->smarty->loadView('app_version.tpl', $data, 'Yes', 'Yes');
    }

    public function upload_apk() {
        $response = ['success' => 0, 'msg' => 'An error occurred while uploading APK.'];

        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $latest_version = $this->input->post('latest_version', TRUE);
            $minimum_version = $this->input->post('minimum_version', TRUE);
            $force_update = $this->input->post('force_update', TRUE) !== null ? $this->input->post('force_update', TRUE) : 1;
            $update_message = $this->input->post('update_message', TRUE);

            if (empty($latest_version) || empty($minimum_version)) {
                $response['msg'] = 'Version fields are required.';
                echo json_encode($response);
                exit;
            }

            // File upload logic
            if (isset($_FILES['apk_file']['name']) && !empty($_FILES['apk_file']['name'])) {
                $file_name = 'shiv-amruttulya-v' . $latest_version . '.apk';
                
                // create directory if not exists
                if (!is_dir('public/uploads/apk/')) {
                    mkdir('public/uploads/apk/', 0777, true);
                }

                $config['upload_path'] = 'public/uploads/apk/';
                $config['allowed_types'] = '*'; // Allow all types since we validate by extension via HTML accept attribute and CodeIgniter MIME checking can be overly strict
                $config['max_size'] = 50000; // 50MB
                $config['file_name'] = $file_name;
                $config['overwrite'] = TRUE;

                $this->load->library('upload', $config);
                $this->upload->initialize($config);

                if ($this->upload->do_upload('apk_file')) {
                    $uploadData = $this->upload->data();
                    
                    $apk_url = base_url('public/uploads/apk/' . $uploadData['file_name']);

                    $data = array(
                        'latest_version' => $latest_version,
                        'minimum_version' => $minimum_version,
                        'force_update' => $force_update,
                        'update_message' => $update_message,
                        'apk_url' => $apk_url,
                        'file_name' => $uploadData['file_name'],
                        'uploaded_date' => date('Y-m-d H:i:s')
                    );

                    $insert_id = $this->App_version_model->insert_version($data);

                    if ($insert_id) {
                        $response['success'] = 1;
                        $response['msg'] = 'App version updated and APK uploaded successfully!';
                    } else {
                        $response['msg'] = 'Failed to save version to database.';
                    }
                } else {
                    $response['msg'] = strip_tags($this->upload->display_errors());
                }
            } else {
                $response['msg'] = 'Please select an APK file to upload.';
            }
        }

        echo json_encode($response);
        exit();
    }
}
