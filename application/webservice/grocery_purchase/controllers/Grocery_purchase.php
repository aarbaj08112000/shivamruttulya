<?php defined('BASEPATH') or exit('No direct script access allowed');

class Grocery_purchase extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('grocery_purchase_model');
        $this->load->library('form_validation');
    }

    public function list_get()
    {
        if ($this->authenticate() !== true)
            return;

        $page = $this->get('page') ? (int) $this->get('page') : 1;
        $limit = $this->get('limit') ? (int) $this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $month = null;
        $year = null;
        $month_year = $this->get('month_year');

        if (!empty($month_year)) {
            $timestamp = strtotime("1 " . $month_year);
            if ($timestamp) {
                $month = date('m', $timestamp);
                $year = date('Y', $timestamp);
            }
        }

        if (empty($month) && empty($year)) {
            $month = date('m');
            $year = date('Y');
        }

        $filters = [
            'shop_id' => $this->get('shop_id'),
            'month' => $month,
            'year' => $year,
            'search' => $this->get('search')
        ];

        $purchases = $this->grocery_purchase_model->get_all($limit, $offset, $filters);
        $total_records = $this->grocery_purchase_model->get_count($filters);

        return $this->response([
            'success' => 1,
            'message' => 'Grocery purchases fetched successfully',
            'data' => [
                'records' => $purchases,
                'pagination' => [
                    'total_records' => $total_records,
                    'current_page' => $page,
                    'per_page' => $limit,
                    'total_pages' => ceil($total_records / $limit)
                ]
            ]
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
            return $this->response(['success' => 0, 'message' => 'Purchase ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $purchase = $this->grocery_purchase_model->get_by_id($id);

        if ($purchase) {
            // Build full attachment URL if attachment exists
            if (!empty($purchase['attachement'])) {
                $purchase['attachement_url'] = base_url('public/uploads/grocery_purchases/' . $purchase['attachement']);
            } else {
                $purchase['attachement'] = null;
                $purchase['attachement_url'] = null;
            }
            return $this->response(['success' => 1, 'message' => 'Grocery purchase details fetched successfully', 'data' => $purchase], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Grocery purchase not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
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
        $this->form_validation->set_rules('shop_id', 'Shop ID', 'required|numeric');
        $this->form_validation->set_rules('grocery_item_id', 'Grocery Item ID', 'required|numeric');
        $this->form_validation->set_rules('vendor_name', 'Vendor Name', 'required|trim');
        $this->form_validation->set_rules('purchase_date', 'Purchase Date', 'required|trim');
        $this->form_validation->set_rules('quantity', 'Quantity', 'required|numeric');
        $this->form_validation->set_rules('rate', 'Rate', 'required|numeric');
        $this->form_validation->set_rules('total_amount', 'Total Amount', 'required|numeric');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $vendor_name = trim($input['vendor_name']);

        $insert_data = [
            'shop_id' => $input['shop_id'],
            'grocery_item_id' => $input['grocery_item_id'],
            'vendor_name' => $vendor_name,
            'purchase_date' => $input['purchase_date'],
            'quantity' => $input['quantity'],
            'rate' => $input['rate'],
            'total_amount' => $input['total_amount'],
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        // Handle attachment file upload
        if (isset($_FILES['attachment']) && !empty($_FILES['attachment']['name'])) {
            $upload_path = FCPATH . 'public/uploads/grocery_purchases/';
            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            $config_upload = [
                'upload_path' => $upload_path,
                'allowed_types' => 'png|jpg|jpeg|heic|pdf',
                'max_size' => 5120, // 5MB limit
                'encrypt_name' => TRUE
            ];

            $this->load->library('upload', $config_upload);
            $this->upload->initialize($config_upload);

            if ($this->upload->do_upload('attachment')) {
                $upload_data = $this->upload->data();
                $insert_data['attachement'] = $upload_data['file_name'];
            } else {
                return $this->response([
                    'success' => 0,
                    'message' => strip_tags($this->upload->display_errors()),
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }

        $insert_id = $this->grocery_purchase_model->insert($insert_data);

        if ($insert_id) {
            $insert_data['id'] = $insert_id;
            if (!empty($insert_data['attachement'])) {
                $insert_data['attachement_url'] = base_url('public/uploads/grocery_purchases/' . $insert_data['attachement']);
            }
            return $this->response(['success' => 1, 'message' => 'Grocery purchase added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add grocery purchase', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
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
            return $this->response(['success' => 0, 'message' => 'Purchase ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        // Apply rules only if fields are present since it's an update
        $this->form_validation->set_data($input);
        if (isset($input['shop_id']))
            $this->form_validation->set_rules('shop_id', 'Shop ID', 'numeric');
        if (isset($input['grocery_item_id']))
            $this->form_validation->set_rules('grocery_item_id', 'Grocery Item ID', 'numeric');
        if (isset($input['vendor_name']))
            $this->form_validation->set_rules('vendor_name', 'Vendor Name', 'trim');
        if (isset($input['quantity']))
            $this->form_validation->set_rules('quantity', 'Quantity', 'numeric');
        if (isset($input['rate']))
            $this->form_validation->set_rules('rate', 'Rate', 'numeric');
        if (isset($input['total_amount']))
            $this->form_validation->set_rules('total_amount', 'Total Amount', 'numeric');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];

        $fields = ['shop_id', 'grocery_item_id', 'purchase_date', 'quantity', 'rate', 'total_amount', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        if (isset($input['vendor_name']) && !empty($input['vendor_name'])) {
            $update_data['vendor_name'] = trim($input['vendor_name']);
        }

        // Handle attachment file upload
        if (isset($_FILES['attachment']) && !empty($_FILES['attachment']['name'])) {
            $upload_path = FCPATH . 'public/uploads/grocery_purchases/';
            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            $config_upload = [
                'upload_path' => $upload_path,
                'allowed_types' => 'png|jpg|jpeg|heic|pdf',
                'max_size' => 5120, // 5MB limit
                'encrypt_name' => TRUE
            ];

            $this->load->library('upload', $config_upload);
            $this->upload->initialize($config_upload);

            if ($this->upload->do_upload('attachment')) {
                $upload_data = $this->upload->data();

                // Delete old attachment if exists
                $existing = $this->grocery_purchase_model->get_by_id($id);
                if ($existing && !empty($existing['attachement'])) {
                    $old_file = FCPATH . 'public/uploads/grocery_purchases/' . $existing['attachement'];
                    if (file_exists($old_file)) {
                        @unlink($old_file);
                    }
                }

                $update_data['attachement'] = $upload_data['file_name'];
            } else {
                return $this->response([
                    'success' => 0,
                    'message' => strip_tags($this->upload->display_errors()),
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }

        $affected = $this->grocery_purchase_model->update($id, $update_data);

        if ($affected) {
            $response_data = ['id' => $id];
            if (!empty($update_data['attachement'])) {
                $response_data['attachement'] = $update_data['attachement'];
                $response_data['attachement_url'] = base_url('public/uploads/grocery_purchases/' . $update_data['attachement']);
            }
            return $this->response(['success' => 1, 'message' => 'Grocery purchase updated successfully', 'data' => $response_data], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update grocery purchase or no changes made', 'data' => []], REST_Controller::HTTP_OK);
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
            return $this->response(['success' => 0, 'message' => 'Purchase ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $affected = $this->grocery_purchase_model->delete($id, $this->current_user->id);

        if ($affected) {
            return $this->response(['success' => 1, 'message' => 'Grocery purchase deleted successfully', 'data' => []], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to delete grocery purchase', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}

/* tests */
