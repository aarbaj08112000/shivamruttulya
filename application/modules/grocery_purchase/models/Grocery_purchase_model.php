<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Grocery_purchase_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_grocery_purchase_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'p.id, s.shop_name, i.item_name, i.unit, p.vendor_name, p.purchase_date, p.quantity, p.rate, p.total_amount, p.status'
        );
        $this->db->from("grocery_purchases as p");
        $this->db->join("shops as s", "s.id = p.shop_id", "left");
        $this->db->join("grocery_items as i", "i.id = p.grocery_item_id", "left");
        $this->db->where("p.is_delete", "0");
        
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
                $this->db->or_like('i.item_name', $search);
                $this->db->or_like('p.vendor_name', $search);
                $this->db->or_like('p.purchase_date', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_grocery_purchase_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'COUNT(p.id) as total_record'
        );
        $this->db->from("grocery_purchases as p");
        $this->db->join("shops as s", "s.id = p.shop_id", "left");
        $this->db->join("grocery_items as i", "i.id = p.grocery_item_id", "left");
        $this->db->where("p.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('s.shop_name', $search);
                $this->db->or_like('i.item_name', $search);
                $this->db->or_like('p.vendor_name', $search);
                $this->db->or_like('p.purchase_date', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_grocery_purchase($data) {
        $this->db->insert('grocery_purchases', $data);
        return $this->db->insert_id();
    }

    public function get_grocery_purchase_by_id($id) {
        $this->db->select('p.*, s.shop_name, i.item_name, i.unit');
        $this->db->from('grocery_purchases as p');
        $this->db->join("shops as s", "s.id = p.shop_id", "left");
        $this->db->join("grocery_items as i", "i.id = p.grocery_item_id", "left");
        $this->db->where('p.id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_grocery_purchase($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('grocery_purchases', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_grocery_purchase($id) {
        $this->db->where('id', $id);
        $this->db->update('grocery_purchases', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
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

    public function get_active_items() {
        $this->db->select('id, item_name, unit');
        $this->db->from('grocery_items');
        $this->db->where('is_delete', '0');
        $this->db->where('status', 'active');
        $this->db->order_by('item_name', 'ASC');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
}
