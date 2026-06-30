<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Enquiries extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Enquiries_model');
    }

    public function contact_enquiries()
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
            "data" => "name",
            "title" => "Name",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "phone",
            "title" => "Mobile",
            "width" => "15%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "email",
            "title" => "Email",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "created_at",
            "title" => "Submitted On",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Enquiry data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('contact_enquiries.tpl', $data,'Yes','Yes');
    }

    public function get_contact_enquiries()
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
        
        $data = $this->Enquiries_model->get_contact_enquiries_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $data[$key]['created_at'] = !empty($value['created_at']) ? date("d-M-Y H:i A", strtotime($value['created_at'])) : '-';
            
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-contact" data-id="'.$value['id'].'" title="View"><i class="bx bx-show fs-4"></i></a>';
        }
        
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Enquiries_model->get_contact_enquiries_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function get_contact_details() {
        $id = $this->input->post('id');
        $enquiry = $this->Enquiries_model->get_contact_enquiry_by_id($id);
        
        if ($enquiry) {
            echo json_encode(['success' => 1, 'data' => $enquiry]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Enquiry not found.']);
        }
        exit();
    }

    public function franchise_partner_enquiries()
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
            "data" => "name",
            "title" => "Name",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "phone",
            "title" => "Mobile",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "city",
            "title" => "City",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "investment_budget",
            "title" => "Budget",
            "width" => "15%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "created_at",
            "title" => "Submitted On",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Enquiry data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('franchise_enquiries.tpl', $data,'Yes','Yes');
    }

    public function get_franchise_enquiries()
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
        
        $data = $this->Enquiries_model->get_franchise_enquiries_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $data[$key]['created_at'] = !empty($value['created_at']) ? date("d-M-Y H:i A", strtotime($value['created_at'])) : '-';
            
            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-franchise-enquiry" data-id="'.$value['id'].'" title="View"><i class="bx bx-show fs-4"></i></a>';
        }
        
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Enquiries_model->get_franchise_enquiries_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function get_franchise_enquiry_details() {
        $id = $this->input->post('id');
        $enquiry = $this->Enquiries_model->get_franchise_enquiry_by_id($id);
        
        if ($enquiry) {
            echo json_encode(['success' => 1, 'data' => $enquiry]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Enquiry not found.']);
        }
        exit();
    }
}
