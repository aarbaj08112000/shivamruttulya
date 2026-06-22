<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Reports_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_collection_vs_expense_data($condition_arr = [], $search_params = "") {
        // Base query using UNION ALL for combined collections and expenses
        $base_query = "
            SELECT 
                s.shop_name,
                t.month_year,
                SUM(t.collection_amount) AS total_collection,
                SUM(t.expense_amount) AS total_expense,
                SUM(t.grocery_amount) AS total_grocery,
                (SUM(t.collection_amount) - (SUM(t.expense_amount) + SUM(t.grocery_amount))) AS net_profit
            FROM (
                SELECT shop_id, DATE_FORMAT(collection_date, '%M %Y') AS month_year, STR_TO_DATE(DATE_FORMAT(collection_date, '%Y-%m-01'), '%Y-%m-%d') as sort_date, total_amount AS collection_amount, 0 AS expense_amount, 0 AS grocery_amount
                FROM daily_collections WHERE is_delete = '0'
                UNION ALL
                SELECT shop_id, DATE_FORMAT(expense_date, '%M %Y') AS month_year, STR_TO_DATE(DATE_FORMAT(expense_date, '%Y-%m-01'), '%Y-%m-%d') as sort_date, 0 AS collection_amount, amount AS expense_amount, 0 AS grocery_amount
                FROM expenses WHERE is_delete = '0'
                UNION ALL
                SELECT shop_id, DATE_FORMAT(purchase_date, '%M %Y') AS month_year, STR_TO_DATE(DATE_FORMAT(purchase_date, '%Y-%m-01'), '%Y-%m-%d') as sort_date, 0 AS collection_amount, 0 AS expense_amount, total_amount AS grocery_amount
                FROM grocery_purchases WHERE is_delete = '0'
            ) t
            JOIN shops s ON s.id = t.shop_id
            WHERE 1=1
        ";

        $search_condition = "";
        if (is_array($search_params) && isset($search_params["value"]) && $search_params["value"] != "") {
            $search = $this->db->escape_like_str($search_params["value"]);
            $search_condition .= " AND (s.shop_name LIKE '%$search%' ESCAPE '!' OR t.month_year LIKE '%$search%' ESCAPE '!')";
        }
        
        if (isset($condition_arr["month_filter"]) && $condition_arr["month_filter"] != "") {
            $month_filter = $this->db->escape_str($condition_arr["month_filter"]);
            $search_condition .= " AND t.month_year = '$month_filter'";
        }

        $group_by = " GROUP BY t.shop_id, t.month_year, t.sort_date";
        
        $order_by = " ORDER BY t.sort_date DESC, s.shop_name ASC"; // default
        if (isset($condition_arr["order_by"]) && $condition_arr["order_by"] != "") {
            $order_by = " ORDER BY " . $condition_arr["order_by"];
        }

        $limit = "";
        if (isset($condition_arr["length"]) && $condition_arr["length"] > 0) {
            $limit = " LIMIT " . $condition_arr["start"] . ", " . $condition_arr["length"];
        }

        $final_query = $base_query . $search_condition . $group_by . $order_by . $limit;
        $result_obj = $this->db->query($final_query);
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    public function get_collection_vs_expense_count($search_params = "") {
        $base_query = "
            SELECT 
                COUNT(*) as total_record
            FROM (
                SELECT t.shop_id, t.month_year
                FROM (
                    SELECT shop_id, DATE_FORMAT(collection_date, '%M %Y') AS month_year
                    FROM daily_collections WHERE is_delete = '0'
                    UNION ALL
                    SELECT shop_id, DATE_FORMAT(expense_date, '%M %Y') AS month_year
                    FROM expenses WHERE is_delete = '0'
                    UNION ALL
                    SELECT shop_id, DATE_FORMAT(purchase_date, '%M %Y') AS month_year
                    FROM grocery_purchases WHERE is_delete = '0'
                ) t
                JOIN shops s ON s.id = t.shop_id
                WHERE 1=1
        ";

        $search_condition = "";
        if (is_array($search_params) && isset($search_params["value"]) && $search_params["value"] != "") {
            $search = $this->db->escape_like_str($search_params["value"]);
            $search_condition .= " AND (s.shop_name LIKE '%$search%' ESCAPE '!' OR t.month_year LIKE '%$search%' ESCAPE '!')";
        }
        
        if (isset($search_params["month_filter"]) && $search_params["month_filter"] != "") {
            $month_filter = $this->db->escape_str($search_params["month_filter"]);
            $search_condition .= " AND t.month_year = '$month_filter'";
        }

        $group_by = " GROUP BY t.shop_id, t.month_year) AS grouped_data";

        $final_query = $base_query . $search_condition . $group_by;
        $result_obj = $this->db->query($final_query);
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return isset($ret_data['total_record']) ? $ret_data : ['total_record' => 0];
    }
    public function get_available_months() {
        $months = [];
        for ($i = 0; $i <= 6; $i++) {
            $months[] = [
                'month_year' => date('F Y', strtotime("-$i months")),
                'sort_date' => date('Y-m-01', strtotime("-$i months"))
            ];
        }
        return $months;
    }
}
