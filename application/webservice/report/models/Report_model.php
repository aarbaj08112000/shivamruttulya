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
}
