<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Grocery_purchase extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Grocery_purchase_model');
    }

    public function grocery_purchase_list()
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
            "data" => "item_name",
            "title" => "Item",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "vendor_name",
            "title" => "Vendor",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "purchase_date",
            "title" => "Date",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "qty_rate",
            "title" => "Qty x Rate",
            "width" => "15%",
            "className" => "dt-center",
            "orderable" => false
        ];
        $column[] = [
            "data" => "total_amount",
            "title" => "Total Amount",
            "width" => "10%",
            "className" => "dt-right",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Purchase data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $data['shops'] = $this->Grocery_purchase_model->get_active_shops();
        $data['items'] = $this->Grocery_purchase_model->get_active_items();
        
        $this->smarty->loadView('grocery_purchase_list.tpl', $data,'Yes','Yes');
    }

    public function get_grocery_purchase_list()
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
        
        $data = $this->Grocery_purchase_model->get_grocery_purchase_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $data[$key]['purchase_date'] = date("d-M-Y", strtotime($value['purchase_date']));
            $data[$key]['qty_rate'] = $value['quantity'] . ' ' . $value['unit'] . ' x ₹' . $value['rate'];
            $data[$key]['total_amount'] = '₹' . number_format($value['total_amount'], 2);
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-purchase" data-id="'.$value['id'].'" title="View"><i class="bx bx-show fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-primary me-2 edit-purchase" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-purchase" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Grocery_purchase_model->get_grocery_purchase_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_grocery_purchase_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the purchase.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'shop_id' => $this->input->post('shop_id', TRUE),
                'grocery_item_id' => $this->input->post('grocery_item_id', TRUE),
                'vendor_name' => $this->input->post('vendor_name', TRUE),
                'purchase_date' => $this->input->post('purchase_date', TRUE),
                'quantity' => $this->input->post('quantity', TRUE),
                'rate' => $this->input->post('rate', TRUE),
                'total_amount' => $this->input->post('total_amount', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Grocery_purchase_model->insert_grocery_purchase($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Purchase added successfully!';
            } else {
                $response['msg'] = 'Failed to add purchase. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_grocery_purchase_details() {
        $purchase_id = $this->input->post('id');
        $purchase = $this->Grocery_purchase_model->get_grocery_purchase_by_id($purchase_id);
        
        if ($purchase) {
            echo json_encode(['success' => 1, 'data' => $purchase]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Purchase not found.']);
        }
        exit();
    }

    public function update_grocery_purchase_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the purchase.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $purchase_id = $this->input->post('purchase_id', TRUE);
            
            $data = array(
                'shop_id' => $this->input->post('shop_id', TRUE),
                'grocery_item_id' => $this->input->post('grocery_item_id', TRUE),
                'vendor_name' => $this->input->post('vendor_name', TRUE),
                'purchase_date' => $this->input->post('purchase_date', TRUE),
                'quantity' => $this->input->post('quantity', TRUE),
                'rate' => $this->input->post('rate', TRUE),
                'total_amount' => $this->input->post('total_amount', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Grocery_purchase_model->update_grocery_purchase($purchase_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Purchase updated successfully!';
            } else {
                $response['msg'] = 'Failed to update purchase. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_grocery_purchase_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the purchase.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $purchase_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Grocery_purchase_model->delete_grocery_purchase($purchase_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Purchase deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete purchase. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
