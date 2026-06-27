<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Menu_master extends MY_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('Menu_master_model');
    }

    public function menu_master_list()
    {
        /* datatable columns */
        $column[] = [
            "data" => "menu_id",
            "title" => "Id",
            "width" => "5%",
            "className" => "dt-center",
            "visible" => false
        ];
        $column[] = [
            "data" => "image_display",
            "title" => "Image",
            "width" => "8%",
            "className" => "dt-center",
            "orderable" => false
        ];
        $column[] = [
            "data" => "menu_title",
            "title" => "Menu Title",
            "width" => "18%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "price",
            "title" => "Price (₹)",
            "width" => "10%",
            "className" => "dt-right",
        ];
        $column[] = [
            "data" => "description",
            "title" => "Description",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "shop_name",
            "title" => "Shop",
            "width" => "12%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
            "width" => "8%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "added_date",
            "title" => "Added Date",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "action",
            "title" => "Action",
            "width" => "10%",
            "className" => "dt-center",
            "orderable" => false
        ];
        
        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] =
            '<div class="p-3 no-data-found-block"><img class="p-2" src="' .
            base_url() .
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Menu data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $data["shops"] = $this->Menu_master_model->get_all_shops();
        $this->smarty->loadView('menu_master_list.tpl', $data, 'Yes', 'Yes');
    }

    public function get_menu_list()
    {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .= "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        
        $data = $this->Menu_master_model->get_menu_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            // Image column
            if (!empty($value['image'])) {
                $img_url = base_url('public/uploads/menu/' . $value['image']);
                $data[$key]['image_display'] = '<img src="'.$img_url.'" alt="menu" class="rounded" style="width:40px; height:40px; object-fit:cover; cursor:pointer;" onclick="window.open(\''.$img_url.'\', \'_blank\')" />';
            } else {
                $data[$key]['image_display'] = '<span class="text-muted"><i class="bx bx-image fs-4"></i></span>';
            }
            // Status column
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';
            // Added date
            $data[$key]['added_date'] = date("d-M-Y", strtotime($value['added_date']));
            // Description truncation
            $data[$key]['description'] = !empty($value['description']) ? (strlen($value['description']) > 50 ? substr($value['description'], 0, 50) . '...' : $value['description']) : '-';
            // Shop name
            $data[$key]['shop_name'] = !empty($value['shop_name']) ? $value['shop_name'] : '<span class="text-muted">All Shops</span>';
            // Price formatting
            $data[$key]['price'] = number_format($value['price'], 2);
            // Action buttons
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-menu" data-id="'.$value['menu_id'].'" title="View"><i class="bx bx-show fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-primary me-2 edit-menu" data-id="'.$value['menu_id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-menu" data-id="'.$value['menu_id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Menu_master_model->get_menu_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_menu_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the menu item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $menu_title = $this->input->post('menu_title', TRUE);
            $price = $this->input->post('price', TRUE);

            if (empty($menu_title) || $price === '' || $price === null) {
                $response['msg'] = 'Menu Title and Price are required.';
                echo json_encode($response);
                exit();
            }

            $data = array(
                'menu_title' => $menu_title,
                'price' => $price,
                'description' => $this->input->post('description', TRUE),
                'shop_id' => $this->input->post('shop_id', TRUE) ?: null,
                'status' => $this->input->post('status', TRUE) ?: 'active',
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1,
                'added_date' => date('Y-m-d H:i:s')
            );

            // Handle image upload
            if (isset($_FILES['image']['name']) && !empty($_FILES['image']['name'])) {
                $upload_path = FCPATH . 'public/uploads/menu/';
                if (!is_dir($upload_path)) {
                    mkdir($upload_path, 0755, true);
                }
                $config_upload = [
                    'upload_path' => $upload_path,
                    'allowed_types' => 'jpg|jpeg|png|webp',
                    'max_size' => 5120,
                    'encrypt_name' => TRUE
                ];
                $this->load->library('upload', $config_upload);
                $this->upload->initialize($config_upload);

                if ($this->upload->do_upload('image')) {
                    $upload_data = $this->upload->data();
                    $data['image'] = $upload_data['file_name'];
                } else {
                    $response['msg'] = strip_tags($this->upload->display_errors());
                    echo json_encode($response);
                    exit();
                }
            }

            $insert_id = $this->Menu_master_model->insert_menu($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Menu item added successfully!';
            } else {
                $response['msg'] = 'Failed to add menu item. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_menu_details() {
        $menu_id = $this->input->post('id');
        $menu = $this->Menu_master_model->get_menu_by_id($menu_id);
        
        if ($menu) {
            $menu['image_url'] = !empty($menu['image']) ? base_url('public/uploads/menu/' . $menu['image']) : '';
            echo json_encode(['success' => 1, 'data' => $menu]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Menu item not found.']);
        }
        exit();
    }

    public function update_menu_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the menu item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $menu_id = $this->input->post('menu_id', TRUE);
            
            if (empty($menu_id)) {
                $response['msg'] = 'Menu ID is required.';
                echo json_encode($response);
                exit();
            }

            $data = array(
                'menu_title' => $this->input->post('menu_title', TRUE),
                'price' => $this->input->post('price', TRUE),
                'description' => $this->input->post('description', TRUE),
                'shop_id' => $this->input->post('shop_id', TRUE) ?: null,
                'status' => $this->input->post('status', TRUE),
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            // Handle image upload
            if (isset($_FILES['image']['name']) && !empty($_FILES['image']['name'])) {
                $upload_path = FCPATH . 'public/uploads/menu/';
                if (!is_dir($upload_path)) {
                    mkdir($upload_path, 0755, true);
                }
                $config_upload = [
                    'upload_path' => $upload_path,
                    'allowed_types' => 'jpg|jpeg|png|webp',
                    'max_size' => 5120,
                    'encrypt_name' => TRUE
                ];
                $this->load->library('upload', $config_upload);
                $this->upload->initialize($config_upload);

                if ($this->upload->do_upload('image')) {
                    $upload_data = $this->upload->data();
                    // Delete old image
                    $existing = $this->Menu_master_model->get_menu_by_id($menu_id);
                    if ($existing && !empty($existing['image'])) {
                        $old_file = $upload_path . $existing['image'];
                        if (file_exists($old_file)) {
                            @unlink($old_file);
                        }
                    }
                    $data['image'] = $upload_data['file_name'];
                } else {
                    $response['msg'] = strip_tags($this->upload->display_errors());
                    echo json_encode($response);
                    exit();
                }
            }

            $updated = $this->Menu_master_model->update_menu($menu_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Menu item updated successfully!';
            } else {
                $response['msg'] = 'Failed to update menu item. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_menu_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the menu item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $menu_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Menu_master_model->delete_menu($menu_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Menu item deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete menu item. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}

/* tests */
