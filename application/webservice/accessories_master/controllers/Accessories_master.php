<?php defined('BASEPATH') or exit('No direct script access allowed');

class Accessories_master extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('accessories_master_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true) return;

        $page = $this->get('page') ? (int)$this->get('page') : 1;
        $limit = $this->get('limit') ? (int)$this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $filters = [];
        if ($this->get('shop_id')) {
            $filters['shop_id'] = $this->get('shop_id');
        }
        if ($this->get('search')) {
            $filters['search'] = $this->get('search');
        }

        $accessories = $this->accessories_master_model->get_all($limit, $offset, $filters);
        $total_records = $this->accessories_master_model->get_count($filters);
        
        return $this->response([
            'success' => 1,
            'message' => 'Accessories fetched successfully',
            'data' => [
                'records' => $accessories,
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
            $id = $id['accessory_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) {
            $id = $this->get('accessory_id') ?? $this->get('id');
        }

        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Accessory ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $accessory = $this->accessories_master_model->get_by_id($id);
        
        if ($accessory) {
            return $this->response(['success' => 1, 'message' => 'Accessory details fetched successfully', 'data' => $accessory], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Accessory not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function add_post()
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('name', 'Name', 'required|trim');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'name' => $input['name'],
            'description' => $input['description'] ?? null,
            'total_number' => isset($input['total_number']) ? (int)$input['total_number'] : 0,
            'shop_id' => $input['shop_id'] ?? null,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->accessories_master_model->insert($insert_data);
        
        if ($insert_id) {
            $insert_data['accessory_id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Accessory added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add accessory', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function update_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['accessory_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['accessory_id'] ?? $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Accessory ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['name'])) {
            $this->form_validation->set_rules('name', 'Name', 'trim');
        }
        
        if ($this->form_validation->run() === FALSE && !empty($this->form_validation->error_array())) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];
        
        $fields = ['name', 'description', 'total_number', 'shop_id', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        $affected = $this->accessories_master_model->update($id, $update_data);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Accessory updated successfully', 'data' => ['accessory_id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update accessory or no changes made', 'data' => []], REST_Controller::HTTP_OK);
        }
    }

    public function delete_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['accessory_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['accessory_id'] ?? $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Accessory ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->accessories_master_model->delete($id, $this->current_user->id);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Accessory deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete accessory', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
