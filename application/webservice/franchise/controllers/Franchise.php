<?php defined('BASEPATH') or exit('No direct script access allowed');

class Franchise extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('franchise_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true) return;

        $page = $this->get('page') ? (int)$this->get('page') : 1;
        $limit = $this->get('limit') ? (int)$this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $franchises = $this->franchise_model->get_all($limit, $offset);
        $total_records = $this->franchise_model->get_count();
        
        return $this->response([
            'success' => 1,
            'message' => 'Franchises fetched successfully',
            'data' => [
                'records' => $franchises,
                'pagination' => [
                    'total_records' => $total_records,
                    'current_page' => $page,
                    'per_page' => $limit,
                    'total_pages' => $limit > 0 ? ceil($total_records / $limit) : 1
                ]
            ]
        ], REST_Controller::HTTP_OK);
    }

    public function details_get($id = null)
    {
        if ($this->authenticate() !== true) return;

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id)) {
            $id = $this->get('id');
        }

        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Franchise ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $franchise = $this->franchise_model->get_by_id($id);
        
        if ($franchise) {
            return $this->response(['success' => 1, 'message' => 'Franchise details fetched successfully', 'data' => $franchise], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Franchise not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function add_post()
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('franchise_code', 'Franchise Code', 'required|trim');
        $this->form_validation->set_rules('franchise_name', 'Franchise Name', 'required|trim');
        $this->form_validation->set_rules('owner_name', 'Owner Name', 'required|trim');
        $this->form_validation->set_rules('mobile', 'Mobile', 'required|trim');
        $this->form_validation->set_rules('email', 'Email', 'valid_email|trim');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'franchise_code' => $input['franchise_code'],
            'franchise_name' => $input['franchise_name'],
            'owner_name' => $input['owner_name'],
            'mobile' => $input['mobile'],
            'email' => $input['email'] ?? null,
            'address' => $input['address'] ?? null,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->franchise_model->insert($insert_data);
        
        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Franchise added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add franchise', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function update_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Franchise ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['email'])) $this->form_validation->set_rules('email', 'Email', 'valid_email|trim');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];
        
        $fields = ['franchise_code', 'franchise_name', 'owner_name', 'mobile', 'email', 'address', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        $affected = $this->franchise_model->update($id, $update_data);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Franchise updated successfully', 'data' => ['id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update franchise or no changes made', 'data' => []], REST_Controller::HTTP_OK);
        }
    }

    public function delete_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Franchise ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->franchise_model->delete($id, $this->current_user->id);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Franchise deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete franchise', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
