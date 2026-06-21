<?php
class Daily_collection_model extends CI_Model {
    private $table = 'daily_collections';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0, $filters = []) {
        $this->db->select('d.*, s.shop_name, u.name as added_by_name');
        $this->db->from($this->table . ' d');
        $this->db->join('shops s', 's.id = d.shop_id', 'left');
        $this->db->join('users u', 'u.id = d.added_by', 'left');
        $this->db->where('d.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('d.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['collection_date'])) {
            $this->db->where('d.collection_date', $filters['collection_date']);
        }
        
        if (!empty($filters['from_date']) && !empty($filters['to_date'])) {
            $this->db->where('d.collection_date >=', $filters['from_date']);
            $this->db->where('d.collection_date <=', $filters['to_date']);
        }

        if (!empty($filters['search'])) {
            $search = $filters['search'];
            $this->db->group_start();
            $this->db->like('s.shop_name', $search);
            $this->db->or_like('d.cash_amount', $search);
            $this->db->or_like('d.online_amount', $search);
            $this->db->or_like('d.total_amount', $search);
            $this->db->group_end();
        }

        $this->db->order_by('d.collection_date', 'DESC');
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }

        return $this->db->get()->result_array();
    }

    public function get_count($filters = []) {
        $this->db->from($this->table . ' d');
        $this->db->join('shops s', 's.id = d.shop_id', 'left');
        $this->db->where('d.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('d.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['collection_date'])) {
            $this->db->where('d.collection_date', $filters['collection_date']);
        }
        
        if (!empty($filters['from_date']) && !empty($filters['to_date'])) {
            $this->db->where('d.collection_date >=', $filters['from_date']);
            $this->db->where('d.collection_date <=', $filters['to_date']);
        }

        if (!empty($filters['search'])) {
            $search = $filters['search'];
            $this->db->group_start();
            $this->db->like('s.shop_name', $search);
            $this->db->or_like('d.cash_amount', $search);
            $this->db->or_like('d.online_amount', $search);
            $this->db->or_like('d.total_amount', $search);
            $this->db->group_end();
        }

        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->select('d.*, s.shop_name, u.name as added_by_name');
        $this->db->from($this->table . ' d');
        $this->db->join('shops s', 's.id = d.shop_id', 'left');
        $this->db->join('users u', 'u.id = d.added_by', 'left');
        $this->db->where('d.id', $id);
        $this->db->where('d.is_delete', '0');
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
