<?php
class Shop_model extends CI_Model {
    private $table = 'shops';

    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_all($limit = null, $offset = null, $search = null) {
        $this->db->select('id, shop_name, shop_code, contact_person, contact_number, email, address, opening_date, status');
        $this->db->from($this->table);
        $this->db->group_start();
        $this->db->where('is_delete', 0);
        $this->db->or_where('is_delete', '0');
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();

        if (!empty($search)) {
            $this->db->like('shop_name', $search);
        }

        if ($limit !== null && $offset !== null) {
            $this->db->limit($limit, $offset);
        }

        return $this->db->get()->result_array();
    }

    public function get_total_count($search = null) {
        $this->db->from($this->table);
        $this->db->group_start();
        $this->db->where('is_delete', 0);
        $this->db->or_where('is_delete', '0');
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();

        if (!empty($search)) {
            $this->db->like('shop_name', $search);
        }

        return $this->db->count_all_results();
    }

    public function get_by_id($id) {
        $this->db->select('id, shop_name, shop_code, contact_person, contact_number, email, address, opening_date, status');
        $this->db->where('id', $id);
        $this->db->group_start();
        $this->db->where('is_delete', 0);
        $this->db->or_where('is_delete', '0');
        $this->db->or_where('is_delete IS NULL', null, false);
        $this->db->group_end();
        $result = $this->db->get($this->table)->row_array();

        if ($result) {
            // Ensure all fields are present even if empty or null
            $required_keys = ['shop_name', 'shop_code', 'contact_person', 'contact_number', 'email', 'address', 'opening_date', 'status'];
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
            'is_delete' => 1,
            'updated_by' => $updated_by,
            'updated_date' => date('Y-m-d H:i:s')
        ];
        $this->db->where('id', $id);
        return $this->db->update($this->table, $data);
    }

    public function get_next_shop_code() {
        $this->db->select('shop_code');
        $this->db->from($this->table);
        $this->db->where('shop_code LIKE', 'SA-%');
        $this->db->order_by('id', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get();
        if ($query->num_rows() > 0) {
            $last_code = $query->row()->shop_code;
            $number = intval(substr($last_code, 3));
            $next_number = $number + 1;
        } else {
            $next_number = 1;
        }
        return 'SA-' . str_pad($next_number, 3, '0', STR_PAD_LEFT);
    }
}
