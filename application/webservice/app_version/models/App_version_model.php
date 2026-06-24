<?php
class App_version_model extends CI_Model {
    public function __construct() {
        parent::__construct();
        $this->load->database();
    }

    public function get_latest() {
        $this->db->order_by('id', 'DESC');
        $this->db->limit(1);
        $query = $this->db->get('app_version');
        return $query->row_array();
    }
}
