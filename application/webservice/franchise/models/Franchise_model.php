<?php
class Franchise_model extends CI_Model {
    private $table = 'franchises';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0) {
        $this->db->from($this->table);
        $this->db->where('is_delete', '0');
        $this->db->order_by('id', 'DESC');
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }
        return $this->db->get()->result_array();
    }

    public function generate_franchise_code() {
        $this->db->select('franchise_code');
        $this->db->from($this->table);
        $this->db->order_by('id', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get();
        
        if ($query->num_rows() > 0) {
            $last_code = $query->row()->franchise_code;
            $number = (int) preg_replace('/[^0-9]/', '', $last_code);
            $new_number = $number + 1;
            return 'FR' . str_pad($new_number, 3, '0', STR_PAD_LEFT);
        } else {
            return 'FR001';
        }
    }

    public function get_count() {
        $this->db->from($this->table);
        $this->db->where('is_delete', '0');
        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->from($this->table);
        $this->db->where('id', $id);
        $this->db->where('is_delete', '0');
        return $this->db->get()->row_array();
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
