<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Reports extends MY_Controller {

	public function __construct() {
        parent::__construct();
        $this->load->model('Reports_model');
    }

    public function collection_vs_expense()
    {
        /* datatable */
        $column[] = [
            "data" => "month_year",
            "title" => "Month",
            "width" => "15%",
            "className" => "dt-center",
        ];
        $column[] = [
            "data" => "shop_name",
            "title" => "Shop Name",
            "width" => "25%",
            "className" => "dt-left",
        ];
        $column[] = [
            "data" => "total_collection",
            "title" => "Total Collection (₹)",
            "width" => "15%",
            "className" => "dt-right fw-bold",
            "style" => "color: #006400;" // dark green
        ];
        $column[] = [
            "data" => "total_expense",
            "title" => "Total Expense (₹)",
            "width" => "15%",
            "className" => "dt-right text-danger fw-bold",
        ];
        $column[] = [
            "data" => "total_grocery",
            "title" => "Grocery Purchases (₹)",
            "width" => "15%",
            "className" => "dt-right text-warning fw-bold",
        ];
        $column[] = [
            "data" => "net_profit",
            "title" => "Net Profit (₹)",
            "width" => "20%",
            "className" => "dt-right fw-bold",
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
            'public/assets/images/images/no_data_found_new.png" height="150" width="150"><br> No Report Data Found!</div>';
        $data["is_top_searching_enable"] = true;
        $data["sorting_column"] = json_encode([]); // Default handled by query
        $data["page_length_arr"] = [[10,50,100,200], [10,50,100,200]];
        $data["admin_url"] = base_url();
        $data["base_url"] = base_url();
        $data["months"] = $this->Reports_model->get_available_months();
        
        $this->smarty->loadView('collection_vs_expense.tpl', $data,'Yes','Yes');
    }

    public function get_collection_vs_expense_list()
    {
        $post_data = $this->input->post();
        $column_index = array_column($post_data["columns"], "data");
        $order_by = "";
        
        // Handle sorting if requested by datatable
        if (isset($post_data["order"]) && count($post_data["order"]) > 0) {
            foreach ($post_data["order"] as $key => $val) {
                $col_name = $column_index[$val["column"]];
                // Map column names to query aliases if needed
                if ($col_name == 'month_year') {
                    $col_name = 't.sort_date';
                } elseif ($col_name == 'shop_name') {
                    $col_name = 's.shop_name';
                } else {
                    $col_name = $col_name; // the alias works in ORDER BY for MySQL
                }

                if ($key == 0) {
                    $order_by .= $col_name . " " . $val["dir"];
                } else {
                    $order_by .= "," . $col_name . " " . $val["dir"];
                }
            }
        }

        $condition_arr["order_by"] = $order_by;
        $condition_arr["start"] = $post_data["start"];
        $condition_arr["length"] = $post_data["length"];
        $condition_arr["month_filter"] = isset($post_data["month_filter"]) ? $post_data["month_filter"] : "";
        
        $search_params = $post_data["search"];
        $search_params["month_filter"] = $condition_arr["month_filter"];
        
        $data = $this->Reports_model->get_collection_vs_expense_data(
            $condition_arr,
            $search_params
        );

        foreach ($data as $key => $value) {
            $profit = floatval($value['net_profit']);
            
            $data[$key]['total_collection'] = '<span style="color: #006400;">₹' . number_format($value['total_collection'], 2) . '</span>';
            $data[$key]['total_expense'] = '₹' . number_format($value['total_expense'], 2);
            $data[$key]['total_grocery'] = '₹' . number_format($value['total_grocery'], 2);
            
            if ($profit >= 0) {
                $data[$key]['net_profit'] = '<span class="text-success">₹' . number_format($profit, 2) . '</span>';
            } else {
                $data[$key]['net_profit'] = '<span class="text-danger">-₹' . number_format(abs($profit), 2) . '</span>';
            }
        }
        
        $response = array();
        $response["data"] = $data;
        $total_record = $this->Reports_model->get_collection_vs_expense_count($search_params);
        $response["recordsTotal"] = $total_record['total_record'];
        $response["recordsFiltered"] = $total_record['total_record'];
        echo json_encode($response);
        exit();
    }
}
