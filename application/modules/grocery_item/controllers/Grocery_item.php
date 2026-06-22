<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Grocery_item extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Grocery_item_model');
    }

    public function grocery_item_list()
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
            "data" => "item_name",
            "title" => "Item Name",
            "width" => "25%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "category_name",
            "title" => "Category",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "unit",
            "title" => "Unit",
            "width" => "10%",
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
            "width" => "15%",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Item data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $data['categories'] = $this->Grocery_item_model->get_active_categories();
        
        $this->smarty->loadView('grocery_item_list.tpl', $data,'Yes','Yes');
    }

    public function get_grocery_item_list()
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
        
        $data = $this->Grocery_item_model->get_grocery_item_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';
            $data[$key]['added_date'] = date("d-M-Y", strtotime($value['added_date']));
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-primary me-2 edit-item" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-item" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Grocery_item_model->get_grocery_item_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_grocery_item_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'item_name' => $this->input->post('item_name', TRUE),
                'category_id' => $this->input->post('category_id', TRUE),
                'unit' => $this->input->post('unit', TRUE),
                'status' => $this->input->post('status', TRUE),
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Grocery_item_model->insert_grocery_item($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Item added successfully!';
            } else {
                $response['msg'] = 'Failed to add item. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_grocery_item_details() {
        $item_id = $this->input->post('id');
        $item = $this->Grocery_item_model->get_grocery_item_by_id($item_id);
        
        if ($item) {
            echo json_encode(['success' => 1, 'data' => $item]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Item not found.']);
        }
        exit();
    }

    public function update_grocery_item_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $item_id = $this->input->post('item_id', TRUE);
            
            $data = array(
                'item_name' => $this->input->post('item_name', TRUE),
                'category_id' => $this->input->post('category_id', TRUE),
                'unit' => $this->input->post('unit', TRUE),
                'status' => $this->input->post('status', TRUE),
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Grocery_item_model->update_grocery_item($item_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Item updated successfully!';
            } else {
                $response['msg'] = 'Failed to update item. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_grocery_item_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the item.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $item_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Grocery_item_model->delete_grocery_item($item_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Item deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete item. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
