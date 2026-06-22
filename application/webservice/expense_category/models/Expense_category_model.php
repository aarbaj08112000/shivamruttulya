<?php
class Expense_category_model extends CI_Model {
    private $table = 'expense_categories';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = null, $offset = null, $search = null) {
        $this->db->select('id, category_name, status');
        $this->db->from($this->table);
        $this->db->group_start();
        $this->db->where('is_delete', '0');
        $this->db->or_where('is_delete', 0);
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();

        if (!empty($search)) {
            $this->db->like('category_name', $search);
        }

        if ($limit !== null && $offset !== null) {
            $this->db->limit($limit, $offset);
        }

        return $this->db->get()->result_array();
    }

    public function get_total_count($search = null) {
        $this->db->from($this->table);
        $this->db->group_start();
        $this->db->where('is_delete', '0');
        $this->db->or_where('is_delete', 0);
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();

        if (!empty($search)) {
            $this->db->like('category_name', $search);
        }

        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->select('id, category_name, status');
        $this->db->from($this->table);
        $this->db->where('id', $id);
        $this->db->group_start();
        $this->db->where('is_delete', '0');
        $this->db->or_where('is_delete', 0);
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();
        $result = $this->db->get()->row_array();

        if ($result) {
            $required_keys = ['category_name', 'status'];
            foreach ($required_keys as $key) {
                if (!array_key_exists($key, $result)) {
                    $result[$key] = null;
                }
            }
        }
        return $result;
    }

    public function insert($data) {
        $data['added_date'] = date('Y-m-d H:i:s');
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function update($id, $data) {
        $data['updated_date'] = date('Y-m-d H:i:s');
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete($id, $updated_by) {
        $data = [
            'is_delete' => '1',
            'updated_by' => $updated_by,
            'updated_date' => date('Y-m-d H:i:s')
        ];
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }
}
