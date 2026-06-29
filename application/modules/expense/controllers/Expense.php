<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Expense extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Expense_model');
    }

    public function expense_list()
    {
        /* datatable */
        $column[] = [
            "data" => "id",
            "title" => "Id",
            "width" => "5%",
            "className" => "dt-center",
            "visible" => false
        ];
        $column[] = [
            "data" => "shop_name",
            "title" => "Shop Name",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "category_name",
            "title" => "Category",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "amount",
            "title" => "Amount",
            "width" => "10%",
            "className" => "dt-right",
        ];
        $column[] = [
            "data" => "expense_date",
            "title" => "Date",
            "width" => "15%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "description",
            "title" => "Description",
            "width" => "25%",
            "className" => "dt-left",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Expense data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $data['shops'] = $this->Expense_model->get_active_shops();
        $data['categories'] = $this->Expense_model->get_active_expense_categories();
        
        $this->smarty->loadView('expense_list.tpl', $data,'Yes','Yes');
    }

    public function get_expense_list()
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
        
        $data = $this->Expense_model->get_expense_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $data[$key]['expense_date'] = date("d-M-Y", strtotime($value['expense_date']));
            $data[$key]['amount'] = '₹' . number_format($value['amount'], 2);
            $data[$key]['description'] = !empty($value['description']) ? $value['description'] : '-';
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-expense" data-id="'.$value['id'].'" title="View"><i class="bx bx-show fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-primary me-2 edit-expense" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-expense" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Expense_model->get_expense_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_expense_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the expense.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'shop_id' => $this->input->post('shop_id', TRUE),
                'category_id' => $this->input->post('category_id', TRUE),
                'amount' => $this->input->post('amount', TRUE),
                'expense_date' => $this->input->post('expense_date', TRUE),
                'description' => $this->input->post('description', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Expense_model->insert_expense($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Expense added successfully!';
            } else {
                $response['msg'] = 'Failed to add expense. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_expense_details() {
        $expense_id = $this->input->post('id');
        $expense = $this->Expense_model->get_expense_by_id($expense_id);
        
        if ($expense) {
            echo json_encode(['success' => 1, 'data' => $expense]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Expense not found.']);
        }
        exit();
    }

    public function update_expense_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the expense.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $expense_id = $this->input->post('expense_id', TRUE);
            
            $data = array(
                'shop_id' => $this->input->post('shop_id', TRUE),
                'category_id' => $this->input->post('category_id', TRUE),
                'amount' => $this->input->post('amount', TRUE),
                'expense_date' => $this->input->post('expense_date', TRUE),
                'description' => $this->input->post('description', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Expense_model->update_expense($expense_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Expense updated successfully!';
            } else {
                $response['msg'] = 'Failed to update expense. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_expense_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the expense.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $expense_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Expense_model->delete_expense($expense_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Expense deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete expense. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
