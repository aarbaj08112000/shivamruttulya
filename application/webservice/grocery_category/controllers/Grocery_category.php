<?php defined('BASEPATH') or exit('No direct script access allowed');

class Grocery_category extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('Grocery_category_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true)
            return;

        $page = $this->get('page');
        $per_page = $this->get('per_page');
        $search = $this->get('search');

        $limit = null;
        $offset = null;

        if (!empty($page) && !empty($per_page)) {
            $limit = (int) $per_page;
            $offset = ((int) $page - 1) * $limit;
        }

        $categories = $this->Grocery_category_model->get_all($limit, $offset, $search);
        
        $total_records = $this->Grocery_category_model->get_total_count($search);
        $total_pages = $limit ? ceil($total_records / $limit) : 1;

        $response_data = [
            'current_page' => $page ? (int)$page : 1,
            'per_page' => $per_page ? (int)$per_page : $total_records,
            'total_records' => $total_records,
            'total_pages' => $total_pages,
            'data' => $categories
        ];

        return $this->response([
            'success' => 1,
            'message' => 'Grocery categories fetched successfully',
            'data' => $response_data
        ], REST_Controller::HTTP_OK);
    }

    public function details_get($id = null)
    {
        if ($this->authenticate() !== true)
            return;

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id)) {
            $id = $this->get('id');
        }

        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Category ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $category = $this->Grocery_category_model->get_by_id($id);

        if ($category) {
            return $this->response(['success' => 1, 'message' => 'Category details fetched successfully', 'data' => $category], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Category not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function add_post()
    {
        if ($this->authenticate() !== true)
            return;

        $input = $this->post();
        if (empty($input))
            $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input))
            $input = [];

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('category_name', 'Category Name', 'required|trim');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'category_name' => $input['category_name'],
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->Grocery_category_model->insert($insert_data);

        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Category added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add category', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function update_post($id = null)
    {
        if ($this->authenticate() !== true)
            return;

        $input = $this->post();
        if (empty($input))
            $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input))
            $input = [];

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id))
            $id = $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Category ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('category_name', 'Category Name', 'trim');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];

        $fields = ['category_name', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        $affected = $this->Grocery_category_model->update($id, $update_data);

        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Category updated successfully', 'data' => ['id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update category or no changes made', 'data' => []], REST_Controller::HTTP_OK);
        }
    }

    public function delete_post($id = null)
    {
        if ($this->authenticate() !== true)
            return;

        $input = $this->post();
        if (empty($input))
            $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input))
            $input = [];

        if (is_array($id)) {
            $id = $id['id'] ?? null;
        }
        if (empty($id))
            $id = $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Category ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->Grocery_category_model->delete($id, $this->current_user->id);

        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Category deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete category', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
