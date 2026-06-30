<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Expense_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_expense_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'e.id, s.shop_name, c.category_name, e.amount, e.expense_date, e.description, e.status'
        );
        $this->db->from("expenses as e");
        $this->db->join("shops as s", "s.id = e.shop_id", "left");
        $this->db->join("expense_categories as c", "c.id = e.category_id", "left");
        $this->db->where("e.is_delete", "0");
        
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
                $this->db->or_like('c.category_name', $search);
                $this->db->or_like('e.expense_date', $search);
                $this->db->or_like('e.description', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_expense_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'COUNT(e.id) as total_record'
        );
        $this->db->from("expenses as e");
        $this->db->join("shops as s", "s.id = e.shop_id", "left");
        $this->db->join("expense_categories as c", "c.id = e.category_id", "left");
        $this->db->where("e.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('s.shop_name', $search);
                $this->db->or_like('c.category_name', $search);
                $this->db->or_like('e.expense_date', $search);
                $this->db->or_like('e.description', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_expense($data) {
        $this->db->insert('expenses', $data);
        return $this->db->insert_id();
    }

    public function get_expense_by_id($id) {
        $this->db->select('e.*, s.shop_name, c.category_name');
        $this->db->from('expenses as e');
        $this->db->join("shops as s", "s.id = e.shop_id", "left");
        $this->db->join("expense_categories as c", "c.id = e.category_id", "left");
        $this->db->where('e.id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_expense($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('expenses', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_expense($id) {
        $this->db->where('id', $id);
        $this->db->update('expenses', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
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

    public function get_active_expense_categories() {
        $this->db->select('id, category_name');
        $this->db->from('expense_categories');
        $this->db->where('is_delete', '0');
        $this->db->where('status', 'active');
        $this->db->order_by('category_name', 'ASC');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
}
