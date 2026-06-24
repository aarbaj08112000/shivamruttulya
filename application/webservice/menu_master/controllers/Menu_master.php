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
        if ($this->authenticate() !== true)
            return;

        $page = $this->get('page') ? (int) $this->get('page') : 1;
        $limit = $this->get('limit') ? (int) $this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        $filters = [];
        if ($this->get('shop_id')) {
            $filters['shop_id'] = $this->get('shop_id');
        }
        if ($this->get('search')) {
            $filters['search'] = $this->get('search');
        }

        $menus = $this->menu_master_model->get_all($limit, $offset, $filters);
        $total_records = $this->menu_master_model->get_count($filters);

        foreach ($menus as &$menu) {
            $menu['image'] = !empty($menu['image']) ? base_url('public/uploads/menu/' . $menu['image']) : null;
        }

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
        if ($this->authenticate() !== true)
            return;

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
            $menu['image'] = !empty($menu['image']) ? base_url('public/uploads/menu/' . $menu['image']) : null;
            return $this->response(['success' => 1, 'message' => 'Menu details fetched successfully', 'data' => $menu], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Menu not found', 'data' => []], REST_Controller::HTTP_NOT_FOUND);
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
        $this->form_validation->set_rules('menu_title', 'Menu Title', 'required|trim');
        $this->form_validation->set_rules('price', 'Price', 'required|numeric');

        if ($this->form_validation->run() === FALSE) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $insert_data = [
            'menu_title' => $input['menu_title'],
            'price' => $input['price'],
            'description' => $input['description'] ?? null,
            'shop_id' => $input['shop_id'] ?? null,
            'status' => $input['status'] ?? 'active',
            'added_by' => $this->current_user->id
        ];

        // Handle multipart file upload for image using CI Upload Library
        if (isset($_FILES['image']) && !empty($_FILES['image']['name'])) {
            $upload_path = FCPATH . 'public/uploads/menu/';
            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            $config_upload = [
                'upload_path' => $upload_path,
                'allowed_types' => 'jpg|jpeg|png|webp|heic',
                'max_size' => 5120, // 5MB limit
                'encrypt_name' => TRUE
            ];

            $this->load->library('upload', $config_upload);
            $this->upload->initialize($config_upload);

            if ($this->upload->do_upload('image')) {
                $upload_data = $this->upload->data();
                $insert_data['image'] = $upload_data['file_name'];
            } else {
                return $this->response([
                    'success' => 0,
                    'message' => strip_tags($this->upload->display_errors()),
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }
        // Handle base64 image upload (fallback)
        else if (!empty($input['image']) && is_string($input['image'])) {
            $base64_string = $input['image'];

            // Strip data URI prefix if present
            if (strpos($base64_string, ';base64,') !== false) {
                list($type_part, $base64_string) = explode(';base64,', $base64_string);
                $ext = strtolower(str_replace('data:image/', '', $type_part));
                if ($ext === 'jpeg')
                    $ext = 'jpg';
            } else {
                $ext = 'jpg';
            }

            $image_data = base64_decode($base64_string);

            if ($image_data === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Invalid image data',
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }

            $encrypted_name = hash('sha256', $this->current_user->id . time() . mt_rand(1000, 9999)) . '.' . $ext;
            $upload_path = FCPATH . 'public/uploads/menu/';

            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            if (file_put_contents($upload_path . $encrypted_name, $image_data) === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Failed to save menu image',
                    'data' => []
                ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
            }

            $insert_data['image'] = $encrypted_name;
        }

        $insert_id = $this->menu_master_model->insert($insert_data);

        if ($insert_id) {
            $insert_data['menu_id'] = $insert_id;
            if (isset($insert_data['image'])) {
                $insert_data['file_path'] = base_url('public/uploads/menu/' . $insert_data['image']);
            }
            return $this->response(['success' => 1, 'message' => 'Menu added successfully', 'data' => $insert_data], REST_Controller::HTTP_CREATED);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to add menu', 'data' => []], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
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
            $id = $id['menu_id'] ?? $id['id'] ?? null;
        }
        if (empty($id))
            $id = $input['menu_id'] ?? $input['id'] ?? null;
        if (empty($id)) {
            return $this->response(['success' => 0, 'message' => 'Menu ID is required', 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $this->form_validation->set_data($input);
        if (isset($input['price'])) {
            $this->form_validation->set_rules('price', 'Price', 'numeric');
        }

        if ($this->form_validation->run() === FALSE && !empty($this->form_validation->error_array())) {
            return $this->response(['success' => 0, 'message' => 'Validation failed', 'errors' => $this->form_validation->error_array(), 'data' => []], REST_Controller::HTTP_BAD_REQUEST);
        }

        $update_data = [
            'updated_by' => $this->current_user->id
        ];

        $fields = ['menu_title', 'price', 'description', 'shop_id', 'status'];
        foreach ($fields as $field) {
            if (isset($input[$field])) {
                $update_data[$field] = $input[$field];
            }
        }

        // Handle multipart file upload for image using CI Upload Library
        if (isset($_FILES['image']) && !empty($_FILES['image']['name'])) {
            $upload_path = FCPATH . 'public/uploads/menu/';
            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            $config_upload = [
                'upload_path' => $upload_path,
                'allowed_types' => 'jpg|jpeg|png|webp|heic',
                'max_size' => 5120, // 5MB limit
                'encrypt_name' => TRUE
            ];

            $this->load->library('upload', $config_upload);
            $this->upload->initialize($config_upload);

            if ($this->upload->do_upload('image')) {
                $upload_data = $this->upload->data();
                $encrypted_name = $upload_data['file_name'];

                // Delete old image if exists
                $existing_menu = $this->menu_master_model->get_by_id($id);
                if ($existing_menu && !empty($existing_menu['image'])) {
                    $old_file = $upload_path . $existing_menu['image'];
                    if (file_exists($old_file)) {
                        @unlink($old_file);
                    }
                }
                $update_data['image'] = $encrypted_name;
            } else {
                return $this->response([
                    'success' => 0,
                    'message' => strip_tags($this->upload->display_errors()),
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }
        }
        // Handle base64 image upload (fallback)
        else if (!empty($input['image']) && is_string($input['image'])) {
            $base64_string = $input['image'];

            if (strpos($base64_string, ';base64,') !== false) {
                list($type_part, $base64_string) = explode(';base64,', $base64_string);
                $ext = strtolower(str_replace('data:image/', '', $type_part));
                if ($ext === 'jpeg')
                    $ext = 'jpg';
            } else {
                $ext = 'jpg';
            }

            $image_data = base64_decode($base64_string);

            if ($image_data === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Invalid image data',
                    'data' => []
                ], REST_Controller::HTTP_BAD_REQUEST);
            }

            $encrypted_name = hash('sha256', $this->current_user->id . time() . mt_rand(1000, 9999)) . '.' . $ext;
            $upload_path = FCPATH . 'public/uploads/menu/';

            if (!is_dir($upload_path)) {
                mkdir($upload_path, 0755, true);
            }

            if (file_put_contents($upload_path . $encrypted_name, $image_data) === false) {
                return $this->response([
                    'success' => 0,
                    'message' => 'Failed to save menu image',
                    'data' => []
                ], REST_Controller::HTTP_INTERNAL_SERVER_ERROR);
            }

            $existing_menu = $this->menu_master_model->get_by_id($id);
            if ($existing_menu && !empty($existing_menu['image'])) {
                $old_file = $upload_path . $existing_menu['image'];
                if (file_exists($old_file)) {
                    @unlink($old_file);
                }
            }

            $update_data['image'] = $encrypted_name;
        } else if (isset($input['image']) && empty($input['image'])) {
            $update_data['image'] = null; // Allow clearing the image if passed as empty
        }

        $affected = $this->menu_master_model->update($id, $update_data);

        if ($affected) {
            $response_data = ['menu_id' => $id];
            if (isset($update_data['image'])) {
                $response_data['file_name'] = $update_data['image'];
                $response_data['file_path'] = base_url('public/uploads/menu/' . $update_data['image']);
            }
            return $this->response(['success' => 1, 'message' => 'Menu updated successfully', 'data' => $response_data], REST_Controller::HTTP_OK);
        } else {
            return $this->response(['success' => 0, 'message' => 'Failed to update menu or no changes made', 'data' => []], REST_Controller::HTTP_OK);
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
            $id = $id['menu_id'] ?? $id['id'] ?? null;
        }
        if (empty($id))
            $id = $input['menu_id'] ?? $input['id'] ?? null;
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
