<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends MY_Controller
{

    public function index()
    {
        $this->load->view('home');
    }

    public function send_message()
    {
        $this->load->library('email');
        $this->load->database();

        $name = trim($this->input->post('name'));
        $phone = trim($this->input->post('phone'));
        $email = trim($this->input->post('email'));
        $message = trim($this->input->post('message'));

        // Server-side validation
        if (empty($name) || empty($phone) || empty($email) || empty($message)) {
            echo json_encode(['status' => 'error', 'message' => 'Please fill in all required fields.']);
            return;
        }

        if (!empty($email) && !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode(['status' => 'error', 'message' => 'Please enter a valid email address.']);
            return;
        }

        // Save to Database
        $data = array(
            'name' => $name,
            'phone' => $phone,
            'email' => $email,
            'message' => $message,
            'created_at' => date('Y-m-d H:i:s')
        );

        $inserted = $this->db->insert('enquiries', $data);

        if (!$inserted) {
            echo json_encode(['status' => 'error', 'message' => 'Failed to save your enquiry. Please try again later.']);
            return;
        }

        // SMTP Configuration
        $config = array(
            'protocol' => 'smtp',
            'smtp_host' => 'ssl://smtp.gmail.com',
            'smtp_port' => 465,
            'smtp_user' => 'codecrafter.help@gmail.com',
            'smtp_pass' => 'fleb drah mxbj yuim',
            'mailtype' => 'html',
            'charset' => 'utf-8',
            'newline' => "\r\n",
            'wordwrap' => TRUE
        );

        $this->email->initialize($config);

        // 1. Send Notification Email to Admin
        $this->email->from('codecrafter.help@gmail.com', 'Shiv Amruttulya Website');
        $this->email->to('codecrafter.help@gmail.com');
        if (!empty($email)) {
            $this->email->reply_to($email, $name);
        }

        $this->email->subject('New Contact Inquiry from ' . $name);

        $admin_email_body = "<h3>New Inquiry Received from Shiv Amruttulya Website</h3>
                       <p><strong>Name:</strong> {$name}</p>
                       <p><strong>Phone:</strong> {$phone}</p>
                       <p><strong>Email:</strong> {$email}</p>
                       <p><strong>Message:</strong><br/>" . nl2br(htmlspecialchars($message)) . "</p>";

        $this->email->message($admin_email_body);
        $admin_sent = $this->email->send();

        // 2. Send Confirmation Email to User (if email provided)
        $user_sent = false;
        if (!empty($email) && $admin_sent) {
            $this->email->clear(TRUE);
            $this->email->initialize($config);
            $this->email->from('codecrafter.help@gmail.com', 'Shiv Amruttulya');
            $this->email->to($email);
            $this->email->subject('Thank you for contacting Shiv Amruttulya');

            $user_email_body = "<h3>Dear {$name},</h3>
                           <p>Thank you for reaching out to us. We have received your inquiry and will get back to you shortly.</p>
                           <p><strong>Your Message:</strong><br/>" . nl2br(htmlspecialchars($message)) . "</p>
                           <br/>
                           <p>Best Regards,<br/><strong>Shiv Amruttulya Team</strong></p>";

            $this->email->message($user_email_body);
            $user_sent = $this->email->send();
        }

        if ($admin_sent) {
            echo json_encode(['status' => 'success', 'message' => 'Thank you! Your message has been sent successfully.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Sorry, there was an error sending your message. Please try again later.']);
        }
    }

    public function franchise_enquiry()
    {
        $this->load->library('email');
        $this->load->database();

        $name = trim($this->input->post('name'));
        $phone = trim($this->input->post('phone'));
        $email = trim($this->input->post('email'));
        $city = trim($this->input->post('city'));
        $investment_budget = trim($this->input->post('investment_budget'));
        $message = trim($this->input->post('message'));

        // Server-side validation
        if (empty($name) || empty($phone) || empty($email) || empty($city) || empty($investment_budget)) {
            echo json_encode(['status' => 'error', 'message' => 'Please fill in all required fields.']);
            return;
        }

        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            echo json_encode(['status' => 'error', 'message' => 'Please enter a valid email address.']);
            return;
        }

        // Save to Database
        $data = array(
            'name' => $name,
            'phone' => $phone,
            'email' => $email,
            'city' => $city,
            'investment_budget' => $investment_budget,
            'message' => $message,
            'created_at' => date('Y-m-d H:i:s')
        );

        $inserted = $this->db->insert('franchise_enquiries', $data);

        if (!$inserted) {
            echo json_encode(['status' => 'error', 'message' => 'Failed to save your enquiry. Please try again later.']);
            return;
        }

        // SMTP Configuration
        $config = array(
            'protocol' => 'smtp',
            'smtp_host' => 'ssl://smtp.gmail.com',
            'smtp_port' => 465,
            'smtp_user' => 'codecrafter.help@gmail.com',
            'smtp_pass' => 'fleb drah mxbj yuim',
            'mailtype' => 'html',
            'charset' => 'utf-8',
            'newline' => "\r\n",
            'wordwrap' => TRUE
        );

        $this->email->initialize($config);

        // 1. Send Notification Email to Admin
        $this->email->from('codecrafter.help@gmail.com', 'Shiv Amruttulya Website');
        $this->email->to('codecrafter.help@gmail.com');
        $this->email->reply_to($email, $name);
        
        $this->email->subject('New Franchise Application from ' . $name);
        
        $admin_email_body = "<h3>New Franchise Application Received</h3>
                       <p><strong>Name:</strong> {$name}</p>
                       <p><strong>Phone:</strong> {$phone}</p>
                       <p><strong>Email:</strong> {$email}</p>
                       <p><strong>City:</strong> {$city}</p>
                       <p><strong>Investment Budget:</strong> {$investment_budget}</p>
                       <p><strong>Message:</strong><br/>" . nl2br(htmlspecialchars($message)) . "</p>";

        $this->email->message($admin_email_body);
        $admin_sent = $this->email->send();

        // 2. Send Confirmation Email to User
        if ($admin_sent) {
            $this->email->clear(TRUE);
            $this->email->initialize($config);
            $this->email->from('codecrafter.help@gmail.com', 'Shiv Amruttulya Franchise');
            $this->email->to($email);
            $this->email->subject('Thank you for your interest in Shiv Amruttulya Franchise');
            
            $user_email_body = "<h3>Dear {$name},</h3>
                           <p>Thank you for your interest in opening a Shiv Amruttulya franchise in {$city}. We have received your application successfully.</p>
                           <p>Our franchise team will review your details (Investment Budget: {$investment_budget}) and get in touch with you shortly.</p>
                           <br/>
                           <p>Best Regards,<br/><strong>Shiv Amruttulya Team</strong></p>";
                           
            $this->email->message($user_email_body);
            $this->email->send();
            
            echo json_encode(['status' => 'success', 'message' => 'Thank you! Your franchise application has been submitted successfully.']);
        } else {
            echo json_encode(['status' => 'error', 'message' => 'Sorry, there was an error submitting your application. Please try again later.']);
        }
    }
}
