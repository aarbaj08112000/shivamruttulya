<?php
class Expense_category_model extends CI_Model {
    private $table = 'expense_categories';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_expense_category_view_data($condition_arr, $search) {
        $this->db->select('id, category_name, status, added_date');
        $this->db->from($this->table);
        $this->db->where('is_delete', '0');

        if (!empty($search['value'])) {
            $this->db->like('category_name', $search['value']);
        }

        if (isset($condition_arr['order_by']) && !empty($condition_arr['order_by'])) {
            $this->db->order_by($condition_arr['order_by']);
        } else {
            $this->db->order_by('id', 'DESC');
        }

        if (isset($condition_arr['length']) && $condition_arr['length'] != -1) {
            $this->db->limit($condition_arr['length'], $condition_arr['start']);
        }

        return $this->db->get()->result_array();
    }

    public function get_expense_category_view_count($condition_arr, $search) {
        $this->db->select('count(*) as total_record');
        $this->db->from($this->table);
        $this->db->where('is_delete', '0');

        if (!empty($search['value'])) {
            $this->db->like('category_name', $search['value']);
        }

        return $this->db->get()->row_array();
    }

    public function insert_expense_category($data) {
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function get_expense_category_by_id($id) {
        $this->db->where('id', $id);
        $this->db->where('is_delete', '0');
        return $this->db->get($this->table)->row_array();
    }

    public function update_expense_category($id, $data) {
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete_expense_category($id) {
        $data = ['is_delete' => '1', 'updated_date' => date('Y-m-d H:i:s')];
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }
}
