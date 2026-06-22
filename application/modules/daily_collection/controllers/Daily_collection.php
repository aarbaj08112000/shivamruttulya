<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Daily_collection extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Daily_collection_model');
    }

    public function daily_collection_list()
    {
        $column[] = ["data" => "id", "title" => "Id", "width" => "5%", "className" => "dt-center", "visible" => false];
        $column[] = ["data" => "shop_name", "title" => "Shop Name", "width" => "20%", "className" => "dt-left"];
        $column[] = ["data" => "collection_date", "title" => "Date", "width" => "12%", "className" => "dt-center"];
        $column[] = ["data" => "cash_amount", "title" => "Cash (₹)", "width" => "12%", "className" => "dt-right"];
        $column[] = ["data" => "online_amount", "title" => "Online (₹)", "width" => "12%", "className" => "dt-right"];
        $column[] = ["data" => "total_amount", "title" => "Total (₹)", "width" => "12%", "className" => "dt-right"];
        $column[] = ["data" => "status", "title" => "Status", "width" => "10%", "className" => "dt-center"];
        $column[] = ["data" => "action", "title" => "Action", "width" => "10%", "className" => "dt-center", "orderable" => false];
        
        $data["data"] = $column;
        $data["is_searching_enable"] = true;
        $data["is_paging_enable"] = true;
        $data["is_serverSide"] = true;
        $data["is_ordering"] = true;
        $data["is_heading_color"] = "#a18f72";
        $data["no_data_message"] = '<div class="p-3 no-data-found-block"><img class="p-2" src="' . base_url() . 'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Collection data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $data['shops'] = $this->Daily_collection_model->get_active_shops();
        
        $this->smarty->loadView('daily_collection_list.tpl', $data,'Yes','Yes');
    }

    public function get_daily_collection_list()
    {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        foreach ($post_data["order"] as $key => $val) {
            $order_by .= ($key == 0 ? "" : ",") . $column_index[$val["column"]] . " " . $val["dir"];
        }
        $condition_arr = ["order_by" => $order_by, "start" => $post_data["start"], "length" => $post_data["length"]];
        
        $data = $this->Daily_collection_model->get_daily_collection_view_data($condition_arr, $post_data["search"]);

        foreach ($data as $key => $value) {
            $data[$key]['collection_date'] = date("d-M-Y", strtotime($value['collection_date']));
            $data[$key]['cash_amount'] = '₹' . number_format($value['cash_amount'], 2);
            $data[$key]['online_amount'] = '₹' . number_format($value['online_amount'], 2);
            $data[$key]['total_amount'] = '₹' . number_format($value['total_amount'], 2);
            $data[$key]['status'] = ($value['status'] == 'active') ? '<span class="badge bg-success rounded-pill">Active</span>' : '<span class="badge bg-danger rounded-pill">Inactive</span>';
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-primary me-2 edit-collection" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a><a href="javascript:void(0)" class="text-danger delete-collection" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        
        $total_record = $this->Daily_collection_model->get_daily_collection_view_count([], $post_data["search"]);
        echo json_encode(["data" => $data, "recordsTotal" => $total_record['total_record'], "recordsFiltered" => $total_record['total_record']]);
        exit();
    }

    public function add_daily_collection_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred.'];
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $cash = floatval($this->input->post('cash_amount', TRUE));
            $online = floatval($this->input->post('online_amount', TRUE));
            $data = [
                'shop_id' => $this->input->post('shop_id', TRUE),
                'collection_date' => $this->input->post('collection_date', TRUE),
                'cash_amount' => $cash, 'online_amount' => $online,
                'total_amount' => $cash + $online,
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            ];
            $insert_id = $this->Daily_collection_model->insert_daily_collection($data);
            if ($insert_id) { $response = ['success' => 1, 'msg' => 'Collection added successfully!']; }
            else { $response['msg'] = 'Failed to add collection.'; }
        }
        echo json_encode($response); exit();
    }

    public function get_daily_collection_details() {
        $id = $this->input->post('id');
        $collection = $this->Daily_collection_model->get_daily_collection_by_id($id);
        echo json_encode($collection ? ['success' => 1, 'data' => $collection] : ['success' => 0, 'msg' => 'Collection not found.']);
        exit();
    }

    public function update_daily_collection_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred.'];
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $collection_id = $this->input->post('collection_id', TRUE);
            $cash = floatval($this->input->post('cash_amount', TRUE));
            $online = floatval($this->input->post('online_amount', TRUE));
            $data = [
                'shop_id' => $this->input->post('shop_id', TRUE),
                'collection_date' => $this->input->post('collection_date', TRUE),
                'cash_amount' => $cash, 'online_amount' => $online,
                'total_amount' => $cash + $online,
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            ];
            $updated = $this->Daily_collection_model->update_daily_collection($collection_id, $data);
            if ($updated) { $response = ['success' => 1, 'msg' => 'Collection updated successfully!']; }
            else { $response['msg'] = 'Failed to update collection.'; }
        }
        echo json_encode($response); exit();
    }

    public function delete_daily_collection_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred.'];
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $id = $this->input->post('id', TRUE);
            $deleted = $this->Daily_collection_model->delete_daily_collection($id);
            if ($deleted) { $response = ['success' => 1, 'msg' => 'Collection deleted successfully!']; }
            else { $response['msg'] = 'Failed to delete collection.'; }
        }
        echo json_encode($response); exit();
    }
}
