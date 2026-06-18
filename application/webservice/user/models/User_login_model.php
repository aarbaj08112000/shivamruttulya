<?php

class User_login_model extends CI_Model{

  private $table = 'users';

    public function __construct() {
        parent::__construct();
        $this->load->database();

        // Ensure required columns exist for API auth
        if (!$this->db->field_exists('api_token', $this->table)) {
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN api_token TEXT DEFAULT NULL;");
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN token_issued_at DATETIME DEFAULT NULL;");
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN device_id VARCHAR(255) DEFAULT NULL;");
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN device_type VARCHAR(50) DEFAULT NULL;");
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN otp VARCHAR(10) DEFAULT NULL;");
            $this->db->query("ALTER TABLE {$this->table} ADD COLUMN otp_validity INT(11) DEFAULT NULL;");
        }
    }

    public function register($data) {
        $data['added_date'] = date('Y-m-d H:i:s');
        if (isset($data['password'])) {
            // Using plain text as per shiv_amruttulya.sql (or hash if needed later)
            // For now, keeping plain text as existing admin is '123456'
            // $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);
        }
        $this->db->insert($this->table, $data);
        return $this->db->insert_id();
    }

    public function get_by_email($email) {
        return $this->db->get_where($this->table, ['email'=>$email, 'status'=>"active"])->row();
    }

    public function get_by_id($id) {
        return $this->db->get_where($this->table, ['id'=>$id])->row();
    }

    public function get_by_token($token) {
        return $this->db->get_where($this->table, ['api_token'=>$token])->row();
    }

    public function update_user($id, $data) {
        if (isset($data['password'])) {
            // plain text or hash
        }
        $data['updated_date'] = date('Y-m-d H:i:s');
        $this->db->where('id', $id)->update($this->table, $data);
        return $this->db->affected_rows() > 0;
    }

    public function set_token($id, $token, $device_id="", $device_type="") {
      $data = ['api_token'=>$token, 'token_issued_at'=>date('Y-m-d H:i:s')];
      if($device_id != "" && $device_type != ""){
        $data['device_id'] = $device_id;
        $data['device_type'] = $device_type;
      } 
      return $this->db->where('id', $id)->update($this->table, $data);
    }

    public function update_password_by_email($email, $new_password) {
        $this->db->where('email', $email)
                 ->where('status', 'active'); 

        return $this->db->update($this->table, [
            'password' => $new_password, // plain text for now, match existing logic
            'updated_date'  => date('Y-m-d H:i:s')
        ]);
    }

    public function update_password_by_id($id, $new_password) {
        $this->db->where('id', $id)
                 ->where('status', 'active');

        return $this->db->update($this->table, [
            'password' => $new_password,
            'updated_date'  => date('Y-m-d H:i:s')
        ]);
    }

    public function get_user_details($id=0) {
        $this->db->where('id', $id);
        $user = $this->db->get($this->table)->row();
        return (array) $user;
    }
}
