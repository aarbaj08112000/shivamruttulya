<?php
class Grocery_purchase_model extends CI_Model
{
    private $table = 'grocery_purchases';

    public function __construct()
    {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = 10, $offset = 0, $filters = [])
    {
        $this->db->select('p.*, s.shop_name, i.item_name, i.unit, u.name as added_by_name');
        $this->db->from($this->table . ' p');
        $this->db->join('shops s', 's.id = p.shop_id', 'left');
        $this->db->join('grocery_items i', 'i.id = p.grocery_item_id', 'left');
        // $this->db->join('vendors v', 'v.id = p.vendor_id', 'left');
        $this->db->join('users u', 'u.id = p.added_by', 'left');
        $this->db->where('p.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('p.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['month']) && !empty($filters['year'])) {
            $this->db->where('MONTH(p.purchase_date)', $filters['month']);
            $this->db->where('YEAR(p.purchase_date)', $filters['year']);
        } else if (!empty($filters['month'])) {
            $this->db->where('MONTH(p.purchase_date)', $filters['month']);
        }

        if (!empty($filters['search'])) {
            $this->db->group_start();
            $this->db->like('s.shop_name', $filters['search']);
            $this->db->or_like('i.item_name', $filters['search']);
            $this->db->or_like('p.vendor_name', $filters['search']);
            $this->db->group_end();
        }

        $this->db->order_by('p.purchase_date', 'DESC');
        $this->db->limit($limit, $offset);

        return $this->db->get()->result_array();
    }

    public function get_count($filters = [])
    {
        $this->db->from($this->table . ' p');
        $this->db->join('shops s', 's.id = p.shop_id', 'left');
        $this->db->join('grocery_items i', 'i.id = p.grocery_item_id', 'left');
        $this->db->where('p.is_delete', '0');

        if (!empty($filters['shop_id'])) {
            $this->db->where('p.shop_id', $filters['shop_id']);
        }

        if (!empty($filters['month']) && !empty($filters['year'])) {
            $this->db->where('MONTH(p.purchase_date)', $filters['month']);
            $this->db->where('YEAR(p.purchase_date)', $filters['year']);
        } else if (!empty($filters['month'])) {
            $this->db->where('MONTH(p.purchase_date)', $filters['month']);
        }

        if (!empty($filters['search'])) {
            $this->db->group_start();
            $this->db->like('s.shop_name', $filters['search']);
            $this->db->or_like('i.item_name', $filters['search']);
            $this->db->or_like('p.vendor_name', $filters['search']);
            $this->db->group_end();
        }

        return $this->db->count_all_results();
    }

    public function get_by_id($id)
    {
        $this->db->select('p.*, s.shop_name, i.item_name, i.unit, u.name as added_by_name');
        $this->db->from($this->table . ' p');
        $this->db->join('shops s', 's.id = p.shop_id', 'left');
        $this->db->join('grocery_items i', 'i.id = p.grocery_item_id', 'left');
        // $this->db->join('vendors v', 'v.id = p.vendor_id', 'left');
        $this->db->join('users u', 'u.id = p.added_by', 'left');
        $this->db->where('p.id', $id);
        $this->db->where('p.is_delete', '0');
        return $this->db->get()->row_array();
    }

    public function insert($data)
    {
        $data['added_date'] = date('Y-m-d H:i:s');
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function update($id, $data)
    {
        $data['updated_date'] = date('Y-m-d H:i:s');
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }

    public function delete($id, $updated_by)
    {
        $data = [
            'is_delete' => '1',
            'updated_by' => $updated_by,
            'updated_date' => date('Y-m-d H:i:s')
        ];
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }
}
