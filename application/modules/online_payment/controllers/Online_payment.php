<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Online_payment extends MY_Controller {

	public function __construct() {
        parent::__construct();
    }

    public function online_payment_list()
    {
        $data["base_url"] = base_url();
        $this->smarty->loadView('online_payment_list.tpl', $data,'Yes','Yes');
    }
}
