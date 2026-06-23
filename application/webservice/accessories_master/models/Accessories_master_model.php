<?php
class Accessories_master_model extends CI_Model {
    private $table = 'accessories_master';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0) {
        $this->db->select('a.*, u.name as added_by_name');
        $this->db->from($this->table . ' a');
        $this->db->join('users u', 'u.id = a.added_by', 'left');
        $this->db->where('a.is_delete', '0');
        $this->db->order_by('a.accessory_id', 'DESC');
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }
        return $this->db->get()->result_array();
    }

    public function get_count() {
        $this->db->from($this->table);
        $this->db->where('is_delete', '0');
        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->select('a.*, u.name as added_by_name');
        $this->db->from($this->table . ' a');
        $this->db->join('users u', 'u.id = a.added_by', 'left');
        $this->db->where('a.accessory_id', $id);
        $this->db->where('a.is_delete', '0');
        return $this->db->get()->row_array();
    }

    public function insert($data) {
        $data['added_date'] = date('Y-m-d H:i:s');
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function update($id, $data) {
        $data['updated_date'] = date('Y-m-d H:i:s');
        $this->db->where('accessory_id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete($id, $updated_by) {
        $data = [
            'is_delete' => '1',
            'updated_by' => $updated_by,
            'updated_date' => date('Y-m-d H:i:s')
        ];
        $this->db->where('accessory_id', $id);
        return $this->db->update($this->table, $data);
    }
}
