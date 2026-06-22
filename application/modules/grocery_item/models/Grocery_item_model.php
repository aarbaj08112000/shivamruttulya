<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Grocery_item_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_grocery_item_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'i.id, i.item_name, i.unit, c.category_name, i.status, i.added_date'
        );
        $this->db->from("grocery_items as i");
        $this->db->join("grocery_categories as c", "c.id = i.category_id", "left");
        $this->db->where("i.is_delete", "0");
        
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
                $this->db->like('i.item_name', $search);
                $this->db->or_like('c.category_name', $search);
                $this->db->or_like('i.unit', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_grocery_item_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'COUNT(i.id) as total_record'
        );
        $this->db->from("grocery_items as i");
        $this->db->join("grocery_categories as c", "c.id = i.category_id", "left");
        $this->db->where("i.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('i.item_name', $search);
                $this->db->or_like('c.category_name', $search);
                $this->db->or_like('i.unit', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_grocery_item($data) {
        $this->db->insert('grocery_items', $data);
        return $this->db->insert_id();
    }

    public function get_grocery_item_by_id($id) {
        $this->db->select('*');
        $this->db->from('grocery_items');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_grocery_item($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('grocery_items', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_grocery_item($id) {
        $this->db->where('id', $id);
        $this->db->update('grocery_items', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }

    public function get_active_categories() {
        $this->db->select('id, category_name');
        $this->db->from('grocery_categories');
        $this->db->where('is_delete', '0');
        $this->db->where('status', 'active');
        $this->db->order_by('category_name', 'ASC');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
}
