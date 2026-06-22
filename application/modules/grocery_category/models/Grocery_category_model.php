<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Grocery_category_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_grocery_category_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'c.id, c.category_name, c.status, c.added_date'
        );
        $this->db->from("grocery_categories as c");
        $this->db->where("c.is_delete", "0");
        
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
                $this->db->like('c.category_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_grocery_category_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'COUNT(c.id) as total_record'
        );
        $this->db->from("grocery_categories as c");
        $this->db->where("c.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('c.category_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_grocery_category($data) {
        $this->db->insert('grocery_categories', $data);
        return $this->db->insert_id();
    }

    public function get_grocery_category_by_id($id) {
        $this->db->select('*');
        $this->db->from('grocery_categories');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_grocery_category($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('grocery_categories', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_grocery_category($id) {
        $this->db->where('id', $id);
        $this->db->update('grocery_categories', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }
}
