<?php defined('BASEPATH') or exit('No direct script access allowed');

class Menu_master extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('menu_master_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true) return;

        $page = $this->get('page') ? (int)$this->get('page') : 1;
        $limit = $this->get('limit') ? (int)$this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $menus = $this->menu_master_model->get_all($limit, $offset);
        $total_records = $this->menu_master_model->get_count();
        
        return $this->response([
            'success' => 1,
            'message' => 'Menus fetched successfully',
            'data' => [
                'records' => $menus,
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
            $id = $id['menu_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) {
            $id = $this->get('menu_id') ?? $this->get('id');
        }

        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Menu ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $menu = $this->menu_master_model->get_by_id($id);
        
        if ($menu) {
            return $this->response(['success' => 1, 'message' => 'Menu details fetched successfully', 'data' => $menu], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Menu not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function add_post()
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('menu_title', 'Menu Title', 'required|trim');
        $this->form_validation->set_rules('price', 'Price', 'required|numeric');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'menu_title' => $input['menu_title'],
            'price' => $input['price'],
            'description' => $input['description'] ?? null,
            'image' => $input['image'] ?? null,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->menu_master_model->insert($insert_data);
        
        if ($insert_id) {
            $insert_data['menu_id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Menu added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add menu', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function update_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['menu_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['menu_id'] ?? $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Menu ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['price'])) {
            $this->form_validation->set_rules('price', 'Price', 'numeric');
        }
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];
        
        $fields = ['menu_title', 'price', 'description', 'image', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        $affected = $this->menu_master_model->update($id, $update_data);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Menu updated successfully', 'data' => ['menu_id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update menu or no changes made', 'data' => []], REST_Controller::HTTP_OK);
        }
    }

    public function delete_post($id = null)
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        if (is_array($id)) {
            $id = $id['menu_id'] ?? $id['id'] ?? null;
        }
        if (empty($id)) $id = $input['menu_id'] ?? $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Menu ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->menu_master_model->delete($id, $this->current_user->id);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Menu deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete menu', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
