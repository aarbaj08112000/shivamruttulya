<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Menu_master_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_menu_view_data($condition_arr = [], $search_params = "") {
        $this->db->select(
            'm.menu_id, m.menu_title, m.price, m.description, m.image, m.status, m.added_date, m.shop_id, s.shop_name'
        );
        $this->db->from("menu_master as m");
        $this->db->join("shops as s", "s.id = m.shop_id", "left");
        $this->db->where("m.is_delete", "0");
        
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
                $this->db->like('m.menu_title', $search);
                $this->db->or_like('m.description', $search);
                $this->db->or_like('m.price', $search);
                $this->db->or_like('s.shop_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_menu_view_count($condition_arr = [], $search_params = "") {
        $this->db->select('COUNT(m.menu_id) as total_record');
        $this->db->from("menu_master as m");
        $this->db->join("shops as s", "s.id = m.shop_id", "left");
        $this->db->where("m.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('m.menu_title', $search);
                $this->db->or_like('m.description', $search);
                $this->db->or_like('m.price', $search);
                $this->db->or_like('s.shop_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_menu($data) {
        $this->db->insert('menu_master', $data);
        return $this->db->insert_id();
    }

    public function get_menu_by_id($id) {
        $this->db->select('m.*, s.shop_name');
        $this->db->from('menu_master as m');
        $this->db->join('shops as s', 's.id = m.shop_id', 'left');
        $this->db->where('m.menu_id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_menu($id, $data) {
        $this->db->where('menu_id', $id);
        $this->db->update('menu_master', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_menu($id) {
        $this->db->where('menu_id', $id);
        $this->db->update('menu_master', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
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
