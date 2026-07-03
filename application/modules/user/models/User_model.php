<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }
	public function getClientData(){
        $this->db->select('u.*');
        $this->db->from('users as u');
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function getUserData(){
        $this->db->select('u.*');
        $this->db->from('users as u');
        $this->db->order_by('u.id','desc');
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }

    /* Server-side DataTable methods */
    public function get_user_list_data($condition_arr = [], $search_params = '') {
        $this->db->select('u.id, u.name as user_name, u.email as user_email, u.mobile, u.status, u.role_id as user_role, u.added_date, u.profile_image, r.role_name');
        $this->db->from('users as u');
        $this->db->join('roles as r', 'r.id = u.role_id', 'left');
        $this->db->where('u.is_delete', '0');

        if (count($condition_arr) > 0) {
            $this->db->limit($condition_arr['length'], $condition_arr['start']);
            if ($condition_arr['order_by'] != '') {
                $this->db->order_by($condition_arr['order_by']);
            }
        }

        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params['value'] != '') {
                $search = $search_params['value'];
                $this->db->group_start();
                $this->db->like('u.name', $search);
                $this->db->or_like('u.email', $search);
                $this->db->or_like('u.mobile', $search);
                $this->db->or_like('r.role_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }

    public function get_user_list_count($search_params = '') {
        $this->db->select('COUNT(u.id) as total_record');
        $this->db->from('users as u');
        $this->db->join('roles as r', 'r.id = u.role_id', 'left');
        $this->db->where('u.is_delete', '0');

        if (is_array($search_params) && count($search_params) > 0) {
            if ($search_params['value'] != '') {
                $search = $search_params['value'];
                $this->db->group_start();
                $this->db->like('u.name', $search);
                $this->db->or_like('u.email', $search);
                $this->db->or_like('u.mobile', $search);
                $this->db->or_like('r.role_name', $search);
                $this->db->group_end();
            }
        }

        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->row_array() : [];
    }
    public function getRoles(){
        $this->db->select('r.*');
        $this->db->from('roles as r');
        $this->db->where('r.is_delete', '0');
        $this->db->where('r.status', 'active');
        $result_obj = $this->db->get();
        return is_object($result_obj) ? $result_obj->result_array() : [];
    }
    public function insertUser($insert_date = array()){
        $this->db->insert("users", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function updateUserData($update_date = array(),$user_id = 0){
        $this->db->where('user_id', $user_id);
        $this->db->update('users', $update_date);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }

	public function getGroupData($group_id = 0){
        $this->db->select('g.*');
        $this->db->from('group_master as g');
        if($group_id > 0){
             $this->db->where("g.group_master_id",$group_id);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function checkGroupCodeExist($group_code = 0){
        $this->db->select('g.*');
        $this->db->from('group_master as g');
        $this->db->where("g.group_code",$group_code);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function checkGroupNameExist($group_name= 0){
        $this->db->select('g.*');
        $this->db->from('group_master as g');
        $this->db->where("g.group_name",$group_name);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function insertGroup($insert_date = array()){
        $this->db->insert("group_master", $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function insertGroupRights($insert_date = array()){
        $this->db->insert_batch('group_rights', $insert_date);
        $insert_id = $this->db->insert_id();
        return  $insert_id;
    }
    public function updateGroupMasterData($update_date = array(),$group_master_id = 0){
        $this->db->where('group_master_id', $group_master_id);
        $this->db->update('group_master', $update_date);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }
    public function getAllMenuData(){
        $this->db->select('m.*,mc.menu_category_name ');
        $this->db->from('menu_master as m');
        $this->db->join("menu_category as mc","mc.menu_category_id = m.menu_category_id");
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function getGroupRightsData($group_id = 0){
        $this->db->select('g.*,m.diaplay_name');
        $this->db->from('group_rights as g');
        $this->db->join("menu_master as m","m.menu_master_id = g.menu_master_id");
        $this->db->where("g.group_master_id",$group_id);
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function deleteGroupRights($group_id = 0){
        $this->db->where('group_master_id', $group_id);
        $this->db->delete('group_rights');
    }
    public function getGroupRightData($group_id = [],$menu_url = ''){
        $group_id = explode(",",$group_id);
        $this->db->select('g.*,m.diaplay_name,m.url');
        $this->db->from('group_rights as g');
        $this->db->join("menu_master as m","m.menu_master_id = g.menu_master_id");
        $this->db->where_in("g.group_master_id",$group_id);
        if($menu_url != ""){
            $this->db->where("m.url",$menu_url);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
}
