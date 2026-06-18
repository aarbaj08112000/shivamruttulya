<?php defined('BASEPATH') or exit('No direct script access allowed');
class Test_db extends CI_Controller {
    public function index() {
        $this->load->database();
        $query = $this->db->query("SHOW TABLES LIKE 'shop%'");
        $tables = $query->result_array();
        foreach ($tables as $table) {
            $tableName = array_values($table)[0];
            echo "Table: " . $tableName . "<br>";
            $query2 = $this->db->query("SELECT * FROM " . $tableName);
            echo "Count: " . $query2->num_rows() . "<br>";
            if ($query2->num_rows() > 0) {
                echo "<pre>";
                print_r($query2->row_array());
                echo "</pre>";
            }
        }
    }
}
