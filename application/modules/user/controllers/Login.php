<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require_once BASEPATH . 'core/compat/password.php';
class Login extends MY_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->model('Login_model');
    }
    public function default(){
        redirect('login');
    }
	public function index() {
		$data['base_url'] = base_url();
		$this->smarty->loadView('login.tpl',$data,'No','No');
	}
	public function logout()
	{

		$user_data = array();
		$this->session->set_userdata($user_data);
		unset($_SESSION["userdata"]);
		session_destroy();
		redirect(base_url("login"));
	}
	function password_verify($password, $hash)
	{
		if (strlen($hash) !== 60 OR strlen($password = crypt($password, $hash)) !== 60)
		{
			return FALSE;
		}

		$compare = 0;
		for ($i = 0; $i < 60; $i++)
		{
			$compare |= (ord($password[$i]) ^ ord($hash[$i]));
		}

		return ($compare === 0);
	}
	public function signin()
	{
		$this->form_validation->set_rules('email', ' Email', 'trim|required|min_length[3]');
		$this->form_validation->set_rules('password', ' Password', 'trim|required|min_length[3]');

		$email = $this->input->post('email');
		$password = $this->input->post('password');
		$result = $this->Login_model->get_user_exist($email);
		$redirect_url = "";
		
		if (empty($result) || $password !== $result['password']) {
			$success = 0;
			$messages = "Invalid credentials!";
		} else {
			if ($result['status'] !== 'active') {
				$success = 0;
				$messages = "User account is inactive!";
			} else {
				$user_data = array(
					'user_id' => $result['id'],
					'user_email' => $result['email'],
					'user_login' => true,
					'user_name' => $result['name'],
					'role_id' => $result['role_id']
				);
				$this->session->set_userdata($user_data);

				// Temporarily bypass group rights as the tables don't exist in shiv_amruttulya
				$this->session->set_userdata('group_rights_arr', base64_encode(json_encode([])));
				
				$redirect_url = "dashboard"; // Default landing page
				$success = 1;
				$messages = "User Login successfully";
			}
		}
		$return_arr['redirect_url']= $redirect_url;
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
	}
	public function reset_password(){
		$username = $this->input->post('username');
		$result = $this->Login_model->get_user_exist_check($username);	
		if(is_valid_array($result)){
	        $success = 1;
			$messages = "Password sent successfully";
			$user_id = $result['user_id'];
			$email_data = [
				"time_stramp" => time(),
				"user_id" => $user_id,
				"email_name" => "Reset Password ",
				"email_subject" => "Reset Password Of ".$this->config->item("company_name")
			];
			$this->email_sender($email_data,$result['user_email'],"forgot_password");
		}else{
			$success = 0;
			$messages = "User not exist";
		}
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
		
	}
	public function reset_password_action(){
		$post_data = $this->input->post();
		$update_data = array(
	        'user_password' => $post_data['password']
	    );
	    $result = $this->Login_model->updateUserData($update_data, $post_data['user_id']);
	    $success = 0;
		$messages = "Password not reset";
	    if($result > 0){
	    	$success = 1;
			$messages = "Password reset successful!";
	    }
	    $return_arr['redirect_url'] = "login";
		$return_arr['success']=$success;
		$return_arr['messages']=$messages;
		echo json_encode($return_arr);
		exit;
	}
	public function forgot_password($timestamp="",$user_id){
		$current_time = time();
		$time_difference = $current_time - $timestamp;
		$expiry_time = $this->config->item("password_link_expiry")*60;
		$expired_link = "Yes";
		if ($time_difference <= $expiry_time) {
		    $expired_link = "No";
		}
		$data['base_url'] = base_url();
		$data['user_id'] = $user_id;
		$data['expired_link'] = $expired_link;
		$this->smarty->setTemplateDir(APPPATH.'modules/user/views/');
		$this->smarty->loadView('forgot_password.tpl',$data,'No','No');
	}
	public function dashboard(){
		$data['base_url'] = base_url();
        $data['dashboard_data'] = $this->Login_model->get_dashboard_data();
		$this->smarty->setTemplateDir(APPPATH.'modules/user/views/');
		$this->smarty->loadView('dashboard.tpl',$data,'Yes','Yes');
	}

	public function get_trend_data(){
		$range = $this->input->post('range');
		if(empty($range)) $range = 'weekly';
		$data = $this->Login_model->get_trend_data($range);
		echo json_encode(['success' => 1, 'data' => $data]);
		exit();
	}

	public function change_password() {
		$response = ['success' => 0, 'msg' => 'An error occurred.'];

		if ($this->input->server('REQUEST_METHOD') === 'POST') {
			$user_id = $this->session->userdata('user_id');

			if (empty($user_id)) {
				$response['msg'] = 'Session expired. Please login again.';
				echo json_encode($response);
				exit();
			}

			$old_password = $this->input->post('old_password', TRUE);
			$new_password = $this->input->post('new_password', TRUE);

			if (empty($old_password) || empty($new_password)) {
				$response['msg'] = 'All fields are required.';
				echo json_encode($response);
				exit();
			}

			// Get the current user record
			$this->db->select('password');
			$this->db->from('users');
			$this->db->where('id', $user_id);
			$query = $this->db->get();
			$user = $query->row_array();

			if (!$user || $old_password !== $user['password']) {
				$response['msg'] = 'Old password is incorrect.';
				echo json_encode($response);
				exit();
			}

			// Update with new password
			$updated = $this->Login_model->updateUserData(['password' => $new_password], $user_id);

			if ($updated > 0) {
				$response['success'] = 1;
				$response['msg'] = 'Password changed successfully!';
			} else {
				$response['msg'] = 'Failed to change password. Please try again.';
			}
		}

		echo json_encode($response);
		exit();
	}

	
}

/* tests */


