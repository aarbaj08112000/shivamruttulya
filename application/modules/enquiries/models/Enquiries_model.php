<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Enquiries_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    /* Contact Us Enquiries */
    public function get_contact_enquiries_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('*');
        $this->db->from("enquiries");
        
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
                $this->db->like('name', $search);
                $this->db->or_like('phone', $search);
                $this->db->or_like('email', $search);
                $this->db->or_like('created_at', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_contact_enquiries_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('COUNT(id) as total_record');
        $this->db->from("enquiries");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('name', $search);
                $this->db->or_like('phone', $search);
                $this->db->or_like('email', $search);
                $this->db->or_like('created_at', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function get_contact_enquiry_by_id($id) {
        $this->db->select('*');
        $this->db->from('enquiries');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }


    /* Franchise Partner Enquiries */
    public function get_franchise_enquiries_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('*');
        $this->db->from("franchise_enquiries");
        
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
                $this->db->like('name', $search);
                $this->db->or_like('phone', $search);
                $this->db->or_like('city', $search);
                $this->db->or_like('investment_budget', $search);
                $this->db->or_like('created_at', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    public function get_franchise_enquiries_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select('COUNT(id) as total_record');
        $this->db->from("franchise_enquiries");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('name', $search);
                $this->db->or_like('phone', $search);
                $this->db->or_like('city', $search);
                $this->db->or_like('investment_budget', $search);
                $this->db->or_like('created_at', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function get_franchise_enquiry_by_id($id) {
        $this->db->select('*');
        $this->db->from('franchise_enquiries');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }
}
