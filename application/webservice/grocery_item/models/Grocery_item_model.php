<?php
class Grocery_item_model extends CI_Model {
    private $table = 'grocery_items';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all() {
        $this->db->select('g.*, c.category_name');
        $this->db->from($this->table . ' g');
        $this->db->join('grocery_categories c', 'c.id = g.category_id', 'left');
        $this->db->where('g.is_delete', '0');
        return $this->db->get()->result_array();
    }

    public function get_by_id($id) {
        $this->db->select('g.*, c.category_name');
        $this->db->from($this->table . ' g');
        $this->db->join('grocery_categories c', 'c.id = g.category_id', 'left');
        $this->db->where('g.id', $id);
        $this->db->where('g.is_delete', '0');
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
