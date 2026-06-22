<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Expense_category extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Expense_category_model');
    }

    public function expense_category_list()
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
            "data" => "category_name",
            "title" => "Category Name",
            "width" => "35%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
            "width" => "15%",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Category data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('expense_category_list.tpl', $data,'Yes','Yes');
    }

    public function get_expense_category_list()
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
        
        $data = $this->Expense_category_model->get_expense_category_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';
            $data[$key]['added_date'] = date("d-M-Y", strtotime($value['added_date']));
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-primary me-2 edit-category" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-category" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Expense_category_model->get_expense_category_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_expense_category_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the category.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'category_name' => $this->input->post('category_name', TRUE),
                'status' => $this->input->post('status', TRUE),
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Expense_category_model->insert_expense_category($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Category added successfully!';
            } else {
                $response['msg'] = 'Failed to add category. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_expense_category_details() {
        $category_id = $this->input->post('id');
        $category = $this->Expense_category_model->get_expense_category_by_id($category_id);
        
        if ($category) {
            echo json_encode(['success' => 1, 'data' => $category]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Category not found.']);
        }
        exit();
    }

    public function update_expense_category_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the category.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $category_id = $this->input->post('category_id', TRUE);
            
            $data = array(
                'category_name' => $this->input->post('category_name', TRUE),
                'status' => $this->input->post('status', TRUE),
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Expense_category_model->update_expense_category($category_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Category updated successfully!';
            } else {
                $response['msg'] = 'Failed to update category. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_expense_category_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the category.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $category_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Expense_category_model->delete_expense_category($category_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Category deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete category. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
