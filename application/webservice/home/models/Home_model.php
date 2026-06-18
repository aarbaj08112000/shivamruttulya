<?php
class Home_model extends CI_Model {
    
    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_grand_total() {
        $this->db->select_sum('total_amount', 'total_collection');
        $this->db->select_sum('cash_amount', 'cash_collection');
        $this->db->select_sum('online_amount', 'online_collection');
        $query = $this->db->get('daily_collections');
        return $query->row_array();
    }

    public function get_time_based_summary() {
        $today = date('Y-m-d');
        // Weekly range (start of week to end of week)
        $start_of_week = date('Y-m-d', strtotime('monday this week'));
        $end_of_week = date('Y-m-d', strtotime('sunday this week'));
        // Monthly range
        $start_of_month = date('Y-m-01');
        $end_of_month = date('Y-m-t');

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
        $this->db->where('collection_date >=', $start_of_month);
        $this->db->where('collection_date <=', $end_of_month);
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

    public function get_shop_wise_collection() {
        // Calculate total overall first
        $this->db->select_sum('total_amount');
        $grand_total = $this->db->get('daily_collections')->row()->total_amount;
        if (!$grand_total) $grand_total = 1; // prevent division by zero

        $this->db->select('s.id as shop_id, s.shop_name, SUM(d.total_amount) as total_collection', FALSE);
        $this->db->from('daily_collections d');
        $this->db->join('shops s', 's.id = d.shop_id', 'left');
        $this->db->group_by('s.id');
        $this->db->order_by('total_collection', 'DESC');
        $result = $this->db->get()->result_array();

        foreach ($result as &$row) {
            $row['percentage'] = round(($row['total_collection'] / $grand_total) * 100, 1);
        }
        return $result;
    }

    public function get_daily_collection_trend() {
        $this->db->select('DAY(collection_date) as day, collection_date as date, SUM(total_amount) as total', FALSE);
        $this->db->from('daily_collections');
        $this->db->where('collection_date >=', date('Y-m-d', strtotime('-7 days')));
        $this->db->group_by('collection_date');
        $this->db->order_by('collection_date', 'ASC');
        return $this->db->get()->result_array();
    }

    public function get_monthly_collection_comparison() {
        $this->db->select('MONTHNAME(collection_date) as month, MONTH(collection_date) as month_number, YEAR(collection_date) as year, SUM(total_amount) as total', FALSE);
        $this->db->from('daily_collections');
        $this->db->where('collection_date >=', date('Y-m-01', strtotime('-6 months')));
        $this->db->group_by('YEAR(collection_date), MONTH(collection_date), MONTHNAME(collection_date)');
        $this->db->order_by('year', 'ASC');
        $this->db->order_by('month_number', 'ASC');
        return $this->db->get()->result_array();
    }

    public function get_shop_wise_summary() {
        $today = date('Y-m-d');
        $this->db->select("s.id as shop_id, s.shop_name, 'Today''s Collection' as description, SUM(d.total_amount) as amount", FALSE);
        $this->db->from('shops s');
        $this->db->join('daily_collections d', "s.id = d.shop_id AND d.collection_date = '$today'", 'left');
        $this->db->group_by('s.id');
        return $this->db->get()->result_array();
    }
}
