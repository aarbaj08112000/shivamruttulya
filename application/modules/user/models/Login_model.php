<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Login_model extends CI_Model {

    public function __construct() {
        parent::__construct();
    }

    public function get_user_details($email ="",$password="")
	{
		$this->db->select('*');
		$this->db->from('users u');
		$this->db->where('u.email', $email);
		$this->db->where('u.password', $password);
		$this->db->where('u.status', 'active');
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function get_user_exist($email ="")
	{
		$this->db->select('*');
		$this->db->from('users u');
		$this->db->where('u.email', $email);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function updateUserData($update_date = array(),$user_id = 0){
        $this->db->where('id', $user_id);
        $this->db->update('users', $update_date);
        $affected_rows = $this->db->affected_rows() == 0 ? 1 : $this->db->affected_rows();
        return $affected_rows;
    }
	public function get_company_details($company_id)
	{
		$this->db->select('*');
		$this->db->from('users u');
		$this->db->where('u.user_email', $email);
		$this->db->where('u.user_password', $password);
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function getGroupRightData($group_id = [],$menu_url = ''){
        $group_id = explode(",",$group_id);
        $this->db->select('g.*,m.diaplay_name,m.url');
        $this->db->from('group_rights as g');
        $this->db->join("menu_master as m","m.menu_master_id = g.menu_master_id");
        $this->db->where_in("g.group_master_id",$group_id);
        if($menu_url != ""){
            $this->db->where("m.url",$menu_url);
        }
        $result_obj = $this->db->get();
        $ret_data = is_object($result_obj) ? $result_obj->result_array() : [];
        return $ret_data;
    }
    public function get_user_exist_check($usename="")
	{
		$this->db->select('*');
		$this->db->from('users u');
		$this->db->where('u.email', $usename);
		$this->db->where('u.status', 'active');
		$query = $this->db->get();
		$data = is_object($query) ? $query->row_array() : [];
        return $data;
	}
	public function get_dashboard_data() {
        $data = [];
        
        // 1. Today's Collection
        $today = date('Y-m-d');
        $query_today = $this->db->query("SELECT IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online, IFNULL(SUM(total_amount), 0) as total FROM daily_collections WHERE collection_date = '$today' AND is_delete = '0'");
        $data['today'] = $query_today->row_array();
        
        // 2. Weekly Collection (Last 7 days)
        $last_week = date('Y-m-d', strtotime('-7 days'));
        $query_weekly = $this->db->query("SELECT IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online, IFNULL(SUM(total_amount), 0) as total FROM daily_collections WHERE collection_date >= '$last_week' AND collection_date <= '$today' AND is_delete = '0'");
        $data['weekly'] = $query_weekly->row_array();
        
        // 3. Monthly Collection (Current Month)
        $first_day = date('Y-m-01');
        $query_monthly = $this->db->query("SELECT IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online, IFNULL(SUM(total_amount), 0) as total FROM daily_collections WHERE collection_date >= '$first_day' AND collection_date <= '$today' AND is_delete = '0'");
        $data['monthly'] = $query_monthly->row_array();
        
        // 4. Grand Total
        $query_total = $this->db->query("SELECT IFNULL(SUM(total_amount), 0) as total FROM daily_collections WHERE is_delete = '0'");
        $data['grand_total'] = $query_total->row_array();
        
        // 5. Chart Trends (Last 7 Days - Weekly default)
        $query_trends = $this->db->query("
            SELECT collection_date, IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online 
            FROM daily_collections 
            WHERE collection_date >= '$last_week' AND collection_date <= '$today' AND is_delete = '0'
            GROUP BY collection_date 
            ORDER BY collection_date ASC
        ");
        $data['trends'] = $query_trends->result_array();
        
        // 6. Shop Wise Comparison (Lifetime)
        $query_shop_wise = $this->db->query("
            SELECT s.shop_name, IFNULL(SUM(d.total_amount), 0) as total 
            FROM daily_collections d
            JOIN shops s ON s.id = d.shop_id
            WHERE d.is_delete = '0'
            GROUP BY d.shop_id
            ORDER BY total DESC
        ");
        $data['shop_wise'] = $query_shop_wise->result_array();
        
        // 7. Shop Wise Summary (Today)
        $query_shop_today = $this->db->query("
            SELECT s.shop_name, IFNULL(SUM(d.cash_amount), 0) as cash, IFNULL(SUM(d.online_amount), 0) as online, IFNULL(SUM(d.total_amount), 0) as total 
            FROM daily_collections d
            JOIN shops s ON s.id = d.shop_id
            WHERE d.collection_date = '$today' AND d.is_delete = '0'
            GROUP BY d.shop_id
            ORDER BY total DESC
        ");
        $data['shop_today'] = $query_shop_today->result_array();
        
        return $data;
    }

    /**
     * Get trend data for a specific range (AJAX)
     * @param string $range - 'daily', 'weekly', or 'monthly'
     */
    public function get_trend_data($range = 'weekly') {
        $today = date('Y-m-d');
        
        switch($range) {
            case 'daily':
                // Today only - hourly not possible, so show last 1 day's data
                $start_date = $today;
                $query = $this->db->query("
                    SELECT collection_date, IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online 
                    FROM daily_collections 
                    WHERE collection_date = '$today' AND is_delete = '0'
                    GROUP BY collection_date 
                    ORDER BY collection_date ASC
                ");
                break;
            case 'monthly':
                // Current month
                $first_day = date('Y-m-01');
                $query = $this->db->query("
                    SELECT collection_date, IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online 
                    FROM daily_collections 
                    WHERE collection_date >= '$first_day' AND collection_date <= '$today' AND is_delete = '0'
                    GROUP BY collection_date 
                    ORDER BY collection_date ASC
                ");
                break;
            case 'weekly':
            default:
                // Last 7 days
                $last_week = date('Y-m-d', strtotime('-7 days'));
                $query = $this->db->query("
                    SELECT collection_date, IFNULL(SUM(cash_amount), 0) as cash, IFNULL(SUM(online_amount), 0) as online 
                    FROM daily_collections 
                    WHERE collection_date >= '$last_week' AND collection_date <= '$today' AND is_delete = '0'
                    GROUP BY collection_date 
                    ORDER BY collection_date ASC
                ");
                break;
        }
        
        return $query->result_array();
    }
}
