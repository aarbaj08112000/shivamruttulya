<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Franchise_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_franchise_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('id, franchise_code, franchise_name, owner_name, mobile, email, joining_date, status');
        $this->db->from("franchises");
        $this->db->where("is_delete", "0");
        
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
                $this->db->like('franchise_code', $search);
                $this->db->or_like('franchise_name', $search);
                $this->db->or_like('owner_name', $search);
                $this->db->or_like('mobile', $search);
                $this->db->or_like('email', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_franchise_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('COUNT(id) as total_record');
        $this->db->from("franchises");
        $this->db->where("is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('franchise_code', $search);
                $this->db->or_like('franchise_name', $search);
                $this->db->or_like('owner_name', $search);
                $this->db->or_like('mobile', $search);
                $this->db->or_like('email', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_franchise($data) {
        $this->db->insert('franchises', $data);
        return $this->db->insert_id();
    }

    public function get_franchise_by_id($id) {
        $this->db->select('*');
        $this->db->from('franchises');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_franchise($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('franchises', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_franchise($id) {
        $this->db->where('id', $id);
        $this->db->update('franchises', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }
}
