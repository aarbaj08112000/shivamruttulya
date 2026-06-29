<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Accessories_master extends MY_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->model('Accessories_master_model');
    }

    public function accessories_master_list()
    {
        /* datatable columns */
        $column[] = [
            "data" => "accessory_id",
            "title" => "Id",
            "width" => "5%",
            "className" => "dt-center",
            "visible" => false
        ];
        $column[] = [
            "data" => "name",
            "title" => "Name",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "description",
            "title" => "Description",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "total_number",
            "title" => "Total Number",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "shop_name",
            "title" => "Shop",
            "width" => "15%",
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
            "width" => "15%",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Accessory data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $data["shops"] = $this->Accessories_master_model->get_all_shops();
        
        $this->smarty->loadView('accessories_master_list.tpl', $data, 'Yes', 'Yes');
    }

    public function get_accessory_list()
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
        
        $data = $this->Accessories_master_model->get_accessory_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            // Status column
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';
            
            // Added date
            $data[$key]['added_date'] = date("d-M-Y", strtotime($value['added_date']));
            
            // Description truncation
            $data[$key]['description'] = !empty($value['description']) ? (strlen($value['description']) > 50 ? substr($value['description'], 0, 50) . '...' : $value['description']) : '-';
            
            // Shop name
            $data[$key]['shop_name'] = !empty($value['shop_name']) ? $value['shop_name'] : '<span class="text-muted">All Shops</span>';
            
            // Action buttons
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-accessory" data-id="'.$value['accessory_id'].'" title="View"><i class="bx bx-show fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-primary me-2 edit-accessory" data-id="'.$value['accessory_id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-accessory" data-id="'.$value['accessory_id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Accessories_master_model->get_accessory_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        
        echo json_encode($response);
        exit();
    }

    public function add_accessory_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the accessory.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $name = $this->input->post('name', TRUE);

            if (empty($name)) {
                $response['msg'] = 'Accessory Name is required.';
                echo json_encode($response);
                exit();
            }

            $data = array(
                'name' => $name,
                'description' => $this->input->post('description', TRUE),
                'total_number' => $this->input->post('total_number', TRUE) ?: 0,
                'shop_id' => $this->input->post('shop_id', TRUE) ?: null,
                'status' => $this->input->post('status', TRUE) ?: 'active',
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1,
                'added_date' => date('Y-m-d H:i:s')
            );

            $insert_id = $this->Accessories_master_model->insert_accessory($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Accessory added successfully!';
            } else {
                $response['msg'] = 'Failed to add accessory. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_accessory_details() {
        $accessory_id = $this->input->post('id');
        $accessory = $this->Accessories_master_model->get_accessory_by_id($accessory_id);
        
        if ($accessory) {
            echo json_encode(['success' => 1, 'data' => $accessory]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Accessory not found.']);
        }
        exit();
    }

    public function update_accessory_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the accessory.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $accessory_id = $this->input->post('accessory_id', TRUE);
            
            if (empty($accessory_id)) {
                $response['msg'] = 'Accessory ID is required.';
                echo json_encode($response);
                exit();
            }
            
            $name = $this->input->post('name', TRUE);
            
            if (empty($name)) {
                $response['msg'] = 'Accessory Name is required.';
                echo json_encode($response);
                exit();
            }

            $data = array(
                'name' => $name,
                'description' => $this->input->post('description', TRUE),
                'total_number' => $this->input->post('total_number', TRUE) ?: 0,
                'shop_id' => $this->input->post('shop_id', TRUE) ?: null,
                'status' => $this->input->post('status', TRUE),
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Accessories_master_model->update_accessory($accessory_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Accessory updated successfully!';
            } else {
                $response['msg'] = 'Failed to update accessory. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_accessory_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the accessory.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $accessory_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Accessories_master_model->delete_accessory($accessory_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Accessory deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete accessory. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
