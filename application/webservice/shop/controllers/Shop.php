<?php defined('BASEPATH') or exit('No direct script access allowed');

class Shop extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('shop_model');
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

        $shops = $this->shop_model->get_all($limit, $offset, $search);

        $total_records = $this->shop_model->get_total_count($search);
        $total_pages = $limit ? ceil($total_records / $limit) : 1;

        $response_data = [
            'current_page' => $page ? (int) $page : 1,
            'per_page' => $per_page ? (int) $per_page : $total_records,
            'total_records' => $total_records,
            'total_pages' => $total_pages,
            'data' => $shops
        ];

        return $this->response([
            'success' => 1,
            'message' => 'Shops fetched successfully',
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
            return $this->response(['success' => 0, 'message' => 'Shop ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $shop = $this->shop_model->get_by_id($id);

        if ($shop) {
            return $this->response(['success' => 1, 'message' => 'Shop details fetched successfully', 'data' => $shop], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Shop not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
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
        $this->form_validation->set_rules('shop_name', 'Shop Name', 'required|trim');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $opening_date = null;
        if (!empty($input['opening_date'])) {
            $date_parts = explode('/', $input['opening_date']);
            if (count($date_parts) == 3) {
                $opening_date = $date_parts[2] . '-' . $date_parts[1] . '-' . $date_parts[0];
            } else {
                $opening_date = $input['opening_date'];
            }
        }

        $shop_code = $input['shop_code'] ?? null;
        if (empty($shop_code)) {
            $shop_code = $this->shop_model->get_next_shop_code();
        }

        $insert_data = [
            'shop_name' => $input['shop_name'],
            'shop_code' => $shop_code,
            'address' => $input['address'] ?? null,
            'contact_person' => $input['contact_person'] ?? null,
            'contact_number' => $input['contact_number'] ?? null,
            'email' => $input['email'] ?? null,
            'opening_date' => $opening_date,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        $insert_id = $this->shop_model->insert($insert_data);

        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            return $this->response(['success' => 1, 'message' => 'Shop added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add shop', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
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
            return $this->response(['success' => 0, 'message' => 'Shop ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        $this->form_validation->set_rules('shop_name', 'Shop Name', 'trim');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];

        $fields = ['shop_name', 'shop_code', 'address', 'contact_person', 'contact_number', 'email', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        if (isset($input['opening_date'])) {
            if (!empty($input['opening_date'])) {
                $date_parts = explode('/', $input['opening_date']);
                if (count($date_parts) == 3) {
                    $update_data['opening_date'] = $date_parts[2] . '-' . $date_parts[1] . '-' . $date_parts[0];
                } else {
                    $update_data['opening_date'] = $input['opening_date'];
                }
            } else {
                $update_data['opening_date'] = null;
            }
        }

        $affected = $this->shop_model->update($id, $update_data);

        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Shop updated successfully', 'data' => ['id' => $id]], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update shop or no changes made', 'data' => []], REST_Controller::HTTP_OK);
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
            return $this->response(['success' => 0, 'message' => 'Shop ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->shop_model->delete($id, $this->current_user->id);

        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Shop deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete shop', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}

/* tests */
