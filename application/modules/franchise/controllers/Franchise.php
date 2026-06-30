<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Franchise extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Franchise_model');
    }

    public function franchise_list()
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
            "data" => "franchise_code",
            "title" => "Code",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "franchise_name",
            "title" => "Franchise Name",
            "width" => "20%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "owner_name",
            "title" => "Owner",
            "width" => "15%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "mobile",
            "title" => "Mobile",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "joining_date",
            "title" => "Joined",
            "width" => "10%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "status",
            "title" => "Status",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Franchise data found..!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([[0, 'desc']]);
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        
        $this->smarty->loadView('franchise_list.tpl', $data,'Yes','Yes');
    }

    public function get_franchise_list()
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
        
        $data = $this->Franchise_model->get_franchise_view_data(
            $condition_arr,
            $post_data["search"]
        );

        foreach ($data as $key => $value) {
            $data[$key]['joining_date'] = !empty($value['joining_date']) ? date("d-M-Y", strtotime($value['joining_date'])) : '-';
            
            $status_color = ($value['status'] == 'active') ? '#006400' : '#C6011F';
            $data[$key]['status'] = '<span style="color: '.$status_color.'; font-weight: bold;">'.ucfirst($value['status']).'</span>';

            $data[$key]['action'] = '<a href="javascript:void(0)" class="text-info me-2 view-franchise" data-id="'.$value['id'].'" title="View"><i class="bx bx-show fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-primary me-2 edit-franchise" data-id="'.$value['id'].'" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                     <a href="javascript:void(0)" class="text-danger delete-franchise" data-id="'.$value['id'].'" title="Delete"><i class="bx bx-trash fs-4"></i></a>';
        }
        
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Franchise_model->get_franchise_view_count([], $post_data["search"]);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }

    public function add_franchise_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while adding the franchise.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $data = array(
                'franchise_code' => $this->input->post('franchise_code', TRUE),
                'franchise_name' => $this->input->post('franchise_name', TRUE),
                'owner_name' => $this->input->post('owner_name', TRUE),
                'mobile' => $this->input->post('mobile', TRUE),
                'email' => $this->input->post('email', TRUE),
                'joining_date' => $this->input->post('joining_date', TRUE),
                'address' => $this->input->post('address', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'added_date' => date('Y-m-d H:i:s'),
                'added_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $insert_id = $this->Franchise_model->insert_franchise($data);

            if ($insert_id) {
                $response['success'] = 1;
                $response['msg'] = 'Franchise added successfully!';
            } else {
                $response['msg'] = 'Failed to add franchise. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function get_franchise_details() {
        $franchise_id = $this->input->post('id');
        $franchise = $this->Franchise_model->get_franchise_by_id($franchise_id);
        
        if ($franchise) {
            echo json_encode(['success' => 1, 'data' => $franchise]);
        } else {
            echo json_encode(['success' => 0, 'msg' => 'Franchise not found.']);
        }
        exit();
    }

    public function update_franchise_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while updating the franchise.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $franchise_id = $this->input->post('franchise_id', TRUE);
            
            $data = array(
                'franchise_code' => $this->input->post('franchise_code', TRUE),
                'franchise_name' => $this->input->post('franchise_name', TRUE),
                'owner_name' => $this->input->post('owner_name', TRUE),
                'mobile' => $this->input->post('mobile', TRUE),
                'email' => $this->input->post('email', TRUE),
                'joining_date' => $this->input->post('joining_date', TRUE),
                'address' => $this->input->post('address', TRUE),
                'status' => $this->input->post('status', TRUE) ?? 'active',
                'updated_date' => date('Y-m-d H:i:s'),
                'updated_by' => $this->session->userdata('user_id') ? $this->session->userdata('user_id') : 1
            );

            $updated = $this->Franchise_model->update_franchise($franchise_id, $data);

            if ($updated) {
                $response['success'] = 1;
                $response['msg'] = 'Franchise updated successfully!';
            } else {
                $response['msg'] = 'Failed to update franchise. Please try again.';
            }
        }
        
        echo json_encode($response);
        exit();
    }

    public function delete_franchise_action() {
        $response = ['success' => 0, 'msg' => 'An error occurred while deleting the franchise.'];
        
        if ($this->input->server('REQUEST_METHOD') === 'POST') {
            $franchise_id = $this->input->post('id', TRUE);
            
            $deleted = $this->Franchise_model->delete_franchise($franchise_id);

            if ($deleted) {
                $response['success'] = 1;
                $response['msg'] = 'Franchise deleted successfully!';
            } else {
                $response['msg'] = 'Failed to delete franchise. It may have already been deleted.';
            }
        }
        
        echo json_encode($response);
        exit();
    }
}
