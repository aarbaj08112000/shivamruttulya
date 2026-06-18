<?php defined('BASEPATH') or exit('No direct script access allowed');

class Daily_collection extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('daily_collection_model');
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
            'collection_date' => $this->get('collection_date'),
            'from_date' => $this->get('from_date'),
            'to_date' => $this->get('to_date')
        ];

        $collections = $this->daily_collection_model->get_all($limit, $offset, $filters);
        $total_records = $this->daily_collection_model->get_count($filters);
        
        return $this->response([
            'success' => 1,
            'message' => 'Daily collections fetched successfully',
            'data' => [
                'records' => $collections,
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
            return $this->response(['success' => 0, 'message' => 'Collection ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $collection = $this->daily_collection_model->get_by_id($id);
        
        if ($collection) {
            return $this->response(['success' => 1, 'message' => 'Daily collection details fetched successfully', 'data' => $collection], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Daily collection not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
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
        $this->form_validation->set_rules('collection_date', 'Collection Date', 'required|trim');
        $this->form_validation->set_rules('cash_amount', 'Cash Amount', 'required|numeric');
        $this->form_validation->set_rules('online_amount', 'Online Amount', 'required|numeric');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $cash_amount = (float)$input['cash_amount'];
        $online_amount = (float)$input['online_amount'];
        $total_amount = $cash_amount + $online_amount;

        $insert_data = [
            'shop_id' => $input['shop_id'],
            'collection_date' => $input['collection_date'],
            'cash_amount' => $cash_amount,
            'online_amount' => $online_amount,
            'total_amount' => $total_amount,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->daily_collection_model->insert($insert_data);
        
        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Daily collection added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add daily collection', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
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
            return $this->response(['success' => 0, 'message' => 'Collection ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['shop_id'])) $this->form_validation->set_rules('shop_id', 'Shop ID', 'numeric');
        if (isset($input['cash_amount'])) $this->form_validation->set_rules('cash_amount', 'Cash Amount', 'numeric');
        if (isset($input['online_amount'])) $this->form_validation->set_rules('online_amount', 'Online Amount', 'numeric');
        
        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];
        
        $fields = ['shop_id', 'collection_date', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        if (isset($input['cash_amount']) || isset($input['online_amount'])) {
            $existing = $this->daily_collection_model->get_by_id($id);
            if (!$existing) {
                return $this->response(['success' => 0, 'message' => 'Daily collection not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
            }
            
            $cash_amount = isset($input['cash_amount']) ? (float)$input['cash_amount'] : (float)$existing['cash_amount'];
            $online_amount = isset($input['online_amount']) ? (float)$input['online_amount'] : (float)$existing['online_amount'];
            
            $update_data['cash_amount'] = $cash_amount;
            $update_data['online_amount'] = $online_amount;
            $update_data['total_amount'] = $cash_amount + $online_amount;
        }

        $affected = $this->daily_collection_model->update($id, $update_data);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Daily collection updated successfully', 'data' => ['id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update daily collection or no changes made', 'data' => []], REST_Controller::HTTP_OK);
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
            return $this->response(['success' => 0, 'message' => 'Collection ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->daily_collection_model->delete($id, $this->current_user->id);
        
        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Daily collection deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete daily collection', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}

/* tests */
