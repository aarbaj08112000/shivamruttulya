<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Accessories_master_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_accessory_view_data($condition_arr = [], $search_params = "") {
        $this->db->select(
            'a.accessory_id, a.name, a.description, a.total_number, a.status, a.added_date, a.shop_id, s.shop_name'
        );
        $this->db->from("accessories_master as a");
        $this->db->join("shops as s", "s.id = a.shop_id", "left");
        $this->db->where("a.is_delete", "0");
        
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
                $this->db->like('a.name', $search);
                $this->db->or_like('a.description', $search);
                $this->db->or_like('s.shop_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_accessory_view_count($condition_arr = [], $search_params = "") {
        $this->db->select('COUNT(a.accessory_id) as total_record');
        $this->db->from("accessories_master as a");
        $this->db->join("shops as s", "s.id = a.shop_id", "left");
        $this->db->where("a.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('a.name', $search);
                $this->db->or_like('a.description', $search);
                $this->db->or_like('s.shop_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_accessory($data) {
        $this->db->insert('accessories_master', $data);
        return $this->db->insert_id();
    }

    public function get_accessory_by_id($id) {
        $this->db->select('a.*, s.shop_name');
        $this->db->from('accessories_master as a');
        $this->db->join('shops as s', 's.id = a.shop_id', 'left');
        $this->db->where('a.accessory_id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_accessory($id, $data) {
        $this->db->where('accessory_id', $id);
        $this->db->update('accessories_master', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_accessory($id) {
        $this->db->where('accessory_id', $id);
        $this->db->update('accessories_master', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }

    public function get_all_shops() {
        $this->db->select('id, shop_name');
        $this->db->from('shops');
        $this->db->where('is_delete', '0');
        $this->db->where('status', 'active');
        $this->db->order_by('shop_name', 'ASC');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
}
