<?php
class Home_model extends CI_Model {
    
    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_current_month_collection($month, $year) {
        $this->db->select_sum('total_amount');
        $this->db->select_sum('cash_amount', 'cash_collection');
        $this->db->select_sum('online_amount', 'online_collection');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $query = $this->db->get('daily_collections');
        return $query->row_array();
    }

    public function get_time_based_summary($month, $year) {
        $today = date('Y-m-d');
        // Weekly range (start of week to end of week)
        $start_of_week = date('Y-m-d', strtotime('monday this week'));
        $end_of_week = date('Y-m-d', strtotime('sunday this week'));

        // Today
        $this->db->select_sum('total_amount', 'total');
        $this->db->select_sum('cash_amount', 'cash');
        $this->db->select_sum('online_amount', 'online');
        $this->db->where('collection_date', $today);
        $today_data = $this->db->get('daily_collections')->row_array();

        // Weekly
        $this->db->select_sum('total_amount', 'total');
        $this->db->select_sum('cash_amount', 'cash');
        $this->db->select_sum('online_amount', 'online');
        $this->db->where('collection_date >=', $start_of_week);
        $this->db->where('collection_date <=', $end_of_week);
        $weekly_data = $this->db->get('daily_collections')->row_array();

        // Monthly
        $this->db->select_sum('total_amount', 'total');
        $this->db->select_sum('cash_amount', 'cash');
        $this->db->select_sum('online_amount', 'online');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $monthly_data = $this->db->get('daily_collections')->row_array();

        return [
            'today' => [
                'total' => $today_data['total'] ?? 0,
                'cash' => $today_data['cash'] ?? 0,
                'online' => $today_data['online'] ?? 0
            ],
            'weekly' => [
                'total' => $weekly_data['total'] ?? 0,
                'cash' => $weekly_data['cash'] ?? 0,
                'online' => $weekly_data['online'] ?? 0
            ],
            'monthly' => [
                'total' => $monthly_data['total'] ?? 0,
                'cash' => $monthly_data['cash'] ?? 0,
                'online' => $monthly_data['online'] ?? 0
            ]
        ];
    }

    public function get_profit_summary($month, $year) {
        $this->db->select_sum('total_amount');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $collection = $this->db->get('daily_collections')->row()->total_amount ?? 0;

        $this->db->select_sum('total_amount');
        $this->db->where('MONTH(purchase_date)', $month);
        $this->db->where('YEAR(purchase_date)', $year);
        $this->db->where('is_delete', '0');
        $grocery = $this->db->get('grocery_purchases')->row()->total_amount ?? 0;

        $this->db->select_sum('amount');
        $this->db->where('MONTH(expense_date)', $month);
        $this->db->where('YEAR(expense_date)', $year);
        $this->db->where('is_delete', '0');
        $expense = $this->db->get('expenses')->row()->amount ?? 0;

        return [
            'total_profit' => (float)($collection - $grocery - $expense),
            'collection' => (float)$collection,
            'grocery' => (float)$grocery,
            'expense' => (float)$expense
        ];
    }

    public function get_daily_collection_trend($month, $year) {
        $this->db->select('DAY(collection_date) as day, collection_date as date, SUM(total_amount) as amount', FALSE);
        $this->db->from('daily_collections');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $this->db->group_by('collection_date');
        $this->db->order_by('collection_date', 'ASC');
        return $this->db->get()->result_array();
    }

    public function get_monthly_collection_comparison($month, $year) {
        $end_date = "$year-$month-" . date('t', strtotime("$year-$month-01"));
        $start_date = date('Y-m-01', strtotime("$end_date - 5 months")); // last 6 months

        $this->db->select('LEFT(MONTHNAME(collection_date), 3) as month_name, MONTH(collection_date) as month_value, YEAR(collection_date) as year, SUM(total_amount) as amount', FALSE);
        $this->db->from('daily_collections');
        $this->db->where('collection_date >=', $start_date);
        $this->db->where('collection_date <=', $end_date);
        $this->db->group_by('YEAR(collection_date), MONTH(collection_date), MONTHNAME(collection_date)');
        $this->db->order_by('year', 'ASC');
        $this->db->order_by('month_value', 'ASC');
        return $this->db->get()->result_array();
    }

    public function get_shop_wise_ranking() {
        $today = date('Y-m-d');
        $this->db->select("s.id as shop_id, s.shop_name, COALESCE(SUM(d.total_amount), 0) as today_collection", FALSE);
        $this->db->from('shops s');
        $this->db->join('daily_collections d', "s.id = d.shop_id AND d.collection_date = '$today'", 'left');
        $this->db->where("s.status", 'active');
        $this->db->group_start();
        $this->db->where("s.is_delete", '0');
        $this->db->or_where("s.is_delete IS NULL", null, false);
        $this->db->group_end();
        $this->db->group_by('s.id');
        $this->db->order_by('today_collection', 'DESC');
        return $this->db->get()->result_array();
    }
}
