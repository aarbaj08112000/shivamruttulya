<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Restaurant_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
	/* aaded for datable */
    public function get_restaurant_view_data(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            's.id, s.shop_code, s.shop_name, s.contact_person, s.contact_number, s.address, s.status, s.added_date'
        );
        $this->db->from("shops as s");
        $this->db->where("s.is_delete", "0");
        
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
                $this->db->or_like('s.shop_code', $search);
                $this->db->or_like('s.contact_person', $search);
                $this->db->or_like('s.contact_number', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_restaurant_view_count(
        $condition_arr = [],
        $search_params = ""
    ) {
        $this->db->select(
            'COUNT(s.id) as total_record'
        );
        $this->db->from("shops as s");
        $this->db->where("s.is_delete", "0");
        
        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params["value"] != "") {
                $search = $search_params["value"];
                $this->db->group_start();
                $this->db->like('s.shop_name', $search);
                $this->db->or_like('s.shop_code', $search);
                $this->db->or_like('s.contact_person', $search);
                $this->db->or_like('s.contact_number', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->row_array() : [];
        return $ret_data;
    }

    public function insert_shop($data) {
        $this->db->insert('shops', $data);
        return $this->db->insert_id();
    }

    public function get_shop_by_id($id) {
        $this->db->select('*');
        $this->db->from('shops');
        $this->db->where('id', $id);
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }

    public function update_shop($id, $data) {
        $this->db->where('id', $id);
        $this->db->update('shops', $data);
        return $this->db->affected_rows() > 0;
    }

    public function delete_shop($id) {
        $this->db->where('id', $id);
        $this->db->update('shops', ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')]);
        return $this->db->affected_rows() > 0;
    }
}
