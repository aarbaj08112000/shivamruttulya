<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Daily_collection_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_daily_collection_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'dc.id, s.shop_name, dc.collection_date, dc.cash_amount, dc.online_amount, dc.total_amount, dc.status'
        );
        $this->db->from("daily_collections as dc");
        $this->db->join("shops as s", "s.id = dc.shop_id", "left");
        $this->db->where("dc.is_delete", "0");
        
        if (count($condition_arr) > 0) {
            $this->db->limit($condition_arr["length"], $condition_arr["start"]);
            if ($condition_arr["order_by"] != "") {
                $this->db->order_by($condition_arr["order_by"]);
            }
        }

        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('s.shop_name', $search);
                $this->db->or_like('dc.collection_date', $search);
                $this->db->or_like('dc.cash_amount', $search);
                $this->db->or_like('dc.online_amount', $search);
                $this->db->or_like('dc.total_amount', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_daily_collection_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('COUNT(dc.id) as total_record');
        $this->db->from("daily_collections as dc");
        $this->db->join("shops as s", "s.id = dc.shop_id", "left");
        $this->db->where("dc.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('s.shop_name', $search);
                $this->db->or_like('dc.collection_date', $search);
                $this->db->or_like('dc.cash_amount', $search);
                $this->db->or_like('dc.online_amount', $search);
                $this->db->or_like('dc.total_amount', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_daily_collection($data) {
        $this->db->insert('daily_collections', $data);
        return $this->db->insert_id();
    }

    public function get_daily_collection_by_id($id) {
        $this->db->select('*');
        $this->db->from('daily_collections');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_daily_collection($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('daily_collections', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_daily_collection($id) {
        $this->db->where('id', $id);
        $this->db->update('daily_collections', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }

    public function get_active_shops() {
        $this->db->select('id, shop_name');
        $this->db->from('shops');
        $this->db->where('is_delete', '0');
        $this->db->where('status', 'active');
        $this->db->order_by('shop_name', 'ASC');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
}
