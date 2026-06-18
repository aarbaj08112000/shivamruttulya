<?php
defined('BASEPATH') OR exit('No direct script access allowed');
class Restaurant extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Restaurant_model');
    }
    public function restaurant_list()
    {
        /* datatable */
        $column[] = [
            "data" => "id",
            "title" => "Id",
            "width" => "7%",
            "className" => "dt-center",
            "visible" => false
        ];
        $column[] = [
            "data" => "shop_code",
            "title" => "Branch Code",
            "width" => "10%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "shop_name",
            "title" => "Shop Name",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "contact_person",
            "title" => "Owner/Manager",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "mobile",
            "title" => "Mobile",
            "width" => "10%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "address",
            "title" => "Address",
            "width" => "18%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
            "width" => "10%",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Shop data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $this->smarty->loadView('restaurant_list.tpl', $data,'Yes','Yes');
    }
    public function get_restaurant_list()
    {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            if ($key == 0) {
                $order_by .= $column_index[$val["column"]] . " " . $val["dir"];
            } else {
                $order_by .=
                    "," . $column_index[$val["column"]] . " " . $val["dir"];
            }
        }
        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        $base_url = $this->config->item("base_url");
        
        $data = $this->Restaurant_model->get_restaurant_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';
            $data[$key]['added_date'] = date("d-M-Y", strtotime($value['added_date']));
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-primary me-2 edit-shop" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-shop" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Restaurant_model->get_restaurant_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_shop_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the shop.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'shop_name' => $this->input->post('shop_name', TRUE),
                'shop_code' => $this->input->post('branch_code', TRUE),
                'contact_number' => $this->input->post('mobile', TRUE),
                'contact_person' => $this->input->post('owner_manager', TRUE),
                'status' => $this->input->post('status', TRUE),
                'address' => $this->input->post('address', TRUE),
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Restaurant_model->insert_shop($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Shop added successfully!';
            } else {
                $response['msg'] = 'Failed to add shop. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_shop_details() {
        $shop_id = $this->input->post('id');
        $shop = $this->Restaurant_model->get_shop_by_id($shop_id);
        
        if ($shop) {
            echo json_encode(['success' => 1, 'data' => $shop]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Shop not found.']);
        }
        exit();
    }

    public function update_shop_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the shop.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $shop_id = $this->input->post('shop_id', TRUE);
            
            $data = array(
                'shop_name' => $this->input->post('shop_name', TRUE),
                'shop_code' => $this->input->post('branch_code', TRUE),
                'contact_number' => $this->input->post('mobile', TRUE),
                'contact_person' => $this->input->post('owner_manager', TRUE),
                'status' => $this->input->post('status', TRUE),
                'address' => $this->input->post('address', TRUE),
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Restaurant_model->update_shop($shop_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Shop updated successfully!';
            } else {
                $response['msg'] = 'Failed to update shop. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_shop_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the shop.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $shop_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Restaurant_model->delete_shop($shop_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Shop deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete shop. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}

/* tests */
