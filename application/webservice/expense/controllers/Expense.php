<?php defined('BASEPATH') or exit('No direct script access allowed');

class Expense extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('expense_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true) return;

        $page = $this->get('page') ? (int)$this->get('page') : 1;
        $limit = $this->get('limit') ? (int)$this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $filters = [
            'shop_id' => $this->get('shop_id'),
            'category_id' => $this->get('category_id'),
            'expense_date' => $this->get('expense_date'),
            'from_date' => $this->get('from_date'),
            'to_date' => $this->get('to_date'),
            'month' => $this->get('month'),
            'year' => $this->get('year')
        ];

        $expenses = $this->expense_model->get_all($limit, $offset, $filters);
        $total_records = $this->expense_model->get_count($filters);
        
        return $this->response([
            'success' => 1,
            'message' => 'Expenses fetched successfully',
            'data' => [
                'records' => $expenses,
                'pagination' => [
                    'total_records' => $total_records,
                    'current_page' => $page,
                    'per_page' => $limit,
                    'total_pages' => $limit > 0 ? ceil($total_records / $limit) : 1
                ]
            ]
        ], REST_Controller::HTTP_OK);
    }

    public function report_get()
    {
        if ($this->authenticate() !== true) return;

        $filters = [
            'month' => $this->get('month'),
            'year' => $this->get('year'),
            'from_date' => $this->get('from_date'),
            'to_date' => $this->get('to_date')
        ];

        $report = $this->expense_model->get_summary_report($filters);
        
        return $this->response([
            'success' => 1,
            'message' => 'Expense report fetched successfully',
            'data' => $report
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
            return $this->response(['success' => 0, 'message' => 'Expense ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $expense = $this->expense_model->get_by_id($id);
        
        if ($expense) {
            return $this->response(['success' => 1, 'message' => 'Expense details fetched successfully', 'data' => $expense], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Expense not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function add_post()
    {
        if ($this->authenticate() !== true) return;
        
        $input = $this->post();
        if (empty($input)) $input = json_decode($this->input->raw_input_stream, true);
        if (!is_array($input)) $input = [];

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('shop_id', 'Shop ID', 'required|numeric');
        $this->form_validation->set_rules('category_id', 'Category ID', 'required|numeric');
        $this->form_validation->set_rules('amount', 'Amount', 'required|numeric');
        $this->form_validation->set_rules('expense_date', 'Expense Date', 'required|trim');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'shop_id' => $input['shop_id'],
            'category_id' => $input['category_id'],
            'amount' => $input['amount'],
            'expense_date' => $input['expense_date'],
            'description' => $input['description'] ?? null,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->expense_model->insert($insert_data);
        
        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Expense added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add expense', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
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
            return $this->response(['success' => 0, 'message' => 'Expense ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['shop_id'])) $this->form_validation->set_rules('shop_id', 'Shop ID', 'numeric');
        if (isset($input['category_id'])) $this->form_validation->set_rules('category_id', 'Category ID', 'numeric');
        if (isset($input['amount'])) $this->form_validation->set_rules('amount', 'Amount', 'numeric');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];
        
        $fields = ['shop_id', 'category_id', 'amount', 'expense_date', 'description', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        $affected = $this->expense_model->update($id, $update_data);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Expense updated successfully', 'data' => ['id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update expense or no changes made', 'data' => []], REST_Controller::HTTP_OK);
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
            return $this->response(['success' => 0, 'message' => 'Expense ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->expense_model->delete($id, $this->current_user->id);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Expense deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete expense', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}
