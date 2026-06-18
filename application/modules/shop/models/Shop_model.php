<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Shop_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
	/* added for datatable */
    public function get_shop_view_data(
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
    public function get_shop_view_count(
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

    public function get_next_shop_code() {
        $this->db->select('shop_code');
        $this->db->from('shops');
        $this->db->where('shop_code LIKE', 'SA-%');
        $this->db->order_by('id', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            $last_code = $query->row()->shop_code;
            $number = intval(substr($last_code, 3));
            $next_number = $number + 1;
        } else {
            $next_number = 1;
        }
        return 'SA-' . str_pad($next_number, 3, '0', STR_PAD_LEFT);
    }
}
