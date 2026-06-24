<?php
class Report_model extends CI_Model {
    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_overall_summary($month = null, $year = null) {
        $this->db->select('
            COALESCE(SUM(total_amount), 0) as total_collection,
            COALESCE(SUM(cash_amount), 0) as total_cash,
            COALESCE(SUM(online_amount), 0) as total_online
        ');
        $this->db->from('daily_collections');
        $this->db->where('is_delete', '0');

        if (!empty($month) && !empty($year)) {
            $this->db->where('MONTH(collection_date)', $month);
            $this->db->where('YEAR(collection_date)', $year);
        }

        return $this->db->get()->row_array();
    }

    public function get_shop_wise_collection($limit = 10, $offset = 0, $month = null, $year = null) {
        $this->db->select('
            d.shop_id,
            s.shop_name,
            COALESCE(SUM(d.total_amount), 0) as shop_total,
            COALESCE(SUM(d.cash_amount), 0) as shop_cash,
            COALESCE(SUM(d.online_amount), 0) as shop_online
        ');
        $this->db->from('daily_collections d');
        $this->db->join('shops s', 's.id = d.shop_id', 'left');
        $this->db->where('d.is_delete', '0');

        if (!empty($month) && !empty($year)) {
            $this->db->where('MONTH(d.collection_date)', $month);
            $this->db->where('YEAR(d.collection_date)', $year);
        }

        $this->db->group_by('d.shop_id');
        $this->db->order_by('shop_total', 'DESC');
        
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }

        return $this->db->get()->result_array();
    }

    public function get_shop_wise_count($month = null, $year = null) {
        $this->db->select('COUNT(DISTINCT d.shop_id) as total_shops');
        $this->db->from('daily_collections d');
        $this->db->where('d.is_delete', '0');

        if (!empty($month) && !empty($year)) {
            $this->db->where('MONTH(d.collection_date)', $month);
            $this->db->where('YEAR(d.collection_date)', $year);
        }

        $result = $this->db->get()->row_array();
        return isset($result['total_shops']) ? (int)$result['total_shops'] : 0;
    }

    public function get_date_summary($date, $shop_id = null) {
        $this->db->select_sum('total_amount');
        $this->db->where('collection_date', $date);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $collection = $this->db->get('daily_collections')->row()->total_amount ?? 0;

        $this->db->select_sum('total_amount');
        $this->db->where('purchase_date', $date);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $grocery = $this->db->get('grocery_purchases')->row()->total_amount ?? 0;

        $this->db->select_sum('amount');
        $this->db->where('expense_date', $date);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $expense = $this->db->get('expenses')->row()->amount ?? 0;

        return [
            'profit' => (float)($collection - $grocery - $expense),
            'collection' => (float)$collection,
            'expense' => (float)$expense,
            'grocery' => (float)$grocery
        ];
    }

    public function get_month_summary($month, $year, $shop_id = null) {
        $this->db->select_sum('total_amount');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $collection = $this->db->get('daily_collections')->row()->total_amount ?? 0;

        $this->db->select_sum('total_amount');
        $this->db->where('MONTH(purchase_date)', $month);
        $this->db->where('YEAR(purchase_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $grocery = $this->db->get('grocery_purchases')->row()->total_amount ?? 0;

        $this->db->select_sum('amount');
        $this->db->where('MONTH(expense_date)', $month);
        $this->db->where('YEAR(expense_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $expense = $this->db->get('expenses')->row()->amount ?? 0;

        return [
            'total_profit' => (float)($collection - $grocery - $expense),
            'total_collection' => (float)$collection,
            'total_expense' => (float)$expense,
            'total_grocery' => (float)$grocery
        ];
    }

    public function get_active_dates($month, $year, $shop_id = null) {
        $this->db->select('DATE(collection_date) as date');
        $this->db->where('MONTH(collection_date)', $month);
        $this->db->where('YEAR(collection_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $q1 = $this->db->get_compiled_select('daily_collections');

        $this->db->select('DATE(purchase_date) as date');
        $this->db->where('MONTH(purchase_date)', $month);
        $this->db->where('YEAR(purchase_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $q2 = $this->db->get_compiled_select('grocery_purchases');

        $this->db->select('DATE(expense_date) as date');
        $this->db->where('MONTH(expense_date)', $month);
        $this->db->where('YEAR(expense_date)', $year);
        $this->db->where('is_delete', '0');
        if (!empty($shop_id)) $this->db->where('shop_id', $shop_id);
        $q3 = $this->db->get_compiled_select('expenses');

        $query = $this->db->query("$q1 UNION $q2 UNION $q3");
        $dates = [];
        foreach($query->result_array() as $row) {
            if (!empty($row['date'])) {
                $dates[] = $row['date'];
            }
        }
        return $dates;
    }
}
