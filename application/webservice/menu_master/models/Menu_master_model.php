<?php
class Menu_master_model extends CI_Model {
    private $table = 'menu_master';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0, $filters = []) {
        $this->db->select('m.*, u.name as added_by_name, s.shop_name');
        $this->db->from($this->table . ' m');
        $this->db->join('users u', 'u.id = m.added_by', 'left');
        $this->db->join('shops s', 's.id = m.shop_id', 'left');
        $this->db->where('m.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('m.shop_id', $filters['shop_id']);
        }
        if (!empty($filters['search'])) {
            $this->db->group_start();
            $this->db->like('m.menu_title', $filters['search']);
            $this->db->or_like('m.description', $filters['search']);
            $this->db->group_end();
        }

        $this->db->order_by('m.menu_id', 'DESC');
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }
        return $this->db->get()->result_array();
    }

    public function get_count($filters = []) {
        $this->db->from($this->table . ' m');
        $this->db->where('m.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('m.shop_id', $filters['shop_id']);
        }
        if (!empty($filters['search'])) {
            $this->db->group_start();
            $this->db->like('m.menu_title', $filters['search']);
            $this->db->or_like('m.description', $filters['search']);
            $this->db->group_end();
        }

        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->select('m.*, u.name as added_by_name, s.shop_name');
        $this->db->from($this->table . ' m');
        $this->db->join('users u', 'u.id = m.added_by', 'left');
        $this->db->join('shops s', 's.id = m.shop_id', 'left');
        $this->db->where('m.menu_id', $id);
        $this->db->where('m.is_delete', '0');
        return $this->db->get()->row_array();
    }

    public function insert($data) {
        $data['added_date'] = date('Y-m-d H:i:s');
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function update($id, $data) {
        $data['updated_date'] = date('Y-m-d H:i:s');
        $this->db->where('menu_id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete($id, $updated_by) {
        $data = [
            'is_delete' => '1',
            'updated_by' => $updated_by,
            'updated_date' => date('Y-m-d H:i:s')
        ];
        $this->db->where('menu_id', $id);
        return $this->db->update($this->table, $data);
    }
}
