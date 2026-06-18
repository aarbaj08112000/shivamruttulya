<?php
class Expense_model extends CI_Model {
    private $table = 'expenses';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0, $filters = []) {
        $this->db->select('e.*, s.shop_name, c.category_name');
        $this->db->from($this->table . ' e');
        $this->db->join('shops s', 's.id = e.shop_id', 'left');
        $this->db->join('expense_categories c', 'c.id = e.category_id', 'left');
        $this->db->where('e.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('e.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['category_id'])) {
            $this->db->where('e.category_id', $filters['category_id']);
        }

        if (!empty($filters['expense_date'])) {
            $this->db->where('e.expense_date', $filters['expense_date']);
        }
        
        if (!empty($filters['from_date']) && !empty($filters['to_date'])) {
            $this->db->where('e.expense_date >=', $filters['from_date']);
            $this->db->where('e.expense_date <=', $filters['to_date']);
        }
        
        if (!empty($filters['month']) && !empty($filters['year'])) {
            $this->db->where('MONTH(e.expense_date)', $filters['month']);
            $this->db->where('YEAR(e.expense_date)', $filters['year']);
        }

        $this->db->order_by('e.expense_date', 'DESC');
        if ($limit > 0) {
            $this->db->limit($limit, $offset);
        }

        return $this->db->get()->result_array();
    }

    public function get_count($filters = []) {
        $this->db->from($this->table . ' e');
        $this->db->where('e.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('e.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['category_id'])) {
            $this->db->where('e.category_id', $filters['category_id']);
        }

        if (!empty($filters['expense_date'])) {
            $this->db->where('e.expense_date', $filters['expense_date']);
        }
        
        if (!empty($filters['from_date']) && !empty($filters['to_date'])) {
            $this->db->where('e.expense_date >=', $filters['from_date']);
            $this->db->where('e.expense_date <=', $filters['to_date']);
        }

        if (!empty($filters['month']) && !empty($filters['year'])) {
            $this->db->where('MONTH(e.expense_date)', $filters['month']);
            $this->db->where('YEAR(e.expense_date)', $filters['year']);
        }

        return $this->db->count_all_results();
    }

    public function get_summary_report($filters = []) {
        $this->db->select('e.shop_id, s.shop_name, SUM(e.amount) as total_amount');
        $this->db->from($this->table . ' e');
        $this->db->join('shops s', 's.id = e.shop_id', 'left');
        $this->db->where('e.is_delete', '0');

        if (!empty($filters['month']) && !empty($filters['year'])) {
            $this->db->where('MONTH(e.expense_date)', $filters['month']);
            $this->db->where('YEAR(e.expense_date)', $filters['year']);
        }
        
        if (!empty($filters['from_date']) && !empty($filters['to_date'])) {
            $this->db->where('e.expense_date >=', $filters['from_date']);
            $this->db->where('e.expense_date <=', $filters['to_date']);
        }

        $this->db->group_by('e.shop_id');
        $this->db->order_by('total_amount', 'DESC');
        return $this->db->get()->result_array();
    }

    public function get_by_id($id) {
        $this->db->select('e.*, s.shop_name, c.category_name');
        $this->db->from($this->table . ' e');
        $this->db->join('shops s', 's.id = e.shop_id', 'left');
        $this->db->join('expense_categories c', 'c.id = e.category_id', 'left');
        $this->db->where('e.id', $id);
        $this->db->where('e.is_delete', '0');
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
