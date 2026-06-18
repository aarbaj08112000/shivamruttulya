<?php defined('BASEPATH') or exit('No direct script access allowed');

class Home extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('home_model');
    }

    public function dashboard_get()
    {
        if ($this->authenticate() !== true) return;

        $grand_total = $this->home_model->get_grand_total();
        
        $data = [
            'grand_total' => [
                'total_collection' => (float)($grand_total['total_collection'] ?? 0),
                'cash_collection' => (float)($grand_total['cash_collection'] ?? 0),
                'online_collection' => (float)($grand_total['online_collection'] ?? 0)
            ],
            'time_based_summary' => (array)$this->home_model->get_time_based_summary(),
            'shop_wise_collection' => (array)$this->home_model->get_shop_wise_collection(),
            'daily_collection_trend' => (array)$this->home_model->get_daily_collection_trend(),
            'monthly_collection_comparison' => (array)$this->home_model->get_monthly_collection_comparison(),
            'shop_wise_summary' => (array)$this->home_model->get_shop_wise_summary()
        ];

        // Format floats appropriately
        foreach($data['time_based_summary'] as $key => &$vals) {
            $vals['total'] = (float)$vals['total'];
            $vals['cash'] = (float)$vals['cash'];
            $vals['online'] = (float)$vals['online'];
        }

        foreach($data['shop_wise_collection'] as &$row) {
            $row['shop_id'] = (int)$row['shop_id'];
            $row['total_collection'] = (float)$row['total_collection'];
            $row['percentage'] = (float)$row['percentage'];
        }

        foreach($data['daily_collection_trend'] as &$row) {
            $row['day'] = (int)$row['day'];
            $row['total'] = (float)$row['total'];
        }

        foreach($data['monthly_collection_comparison'] as &$row) {
            $row['month_number'] = (int)$row['month_number'];
            $row['year'] = (int)$row['year'];
            $row['total'] = (float)$row['total'];
        }

        foreach($data['shop_wise_summary'] as &$row) {
            $row['shop_id'] = (int)$row['shop_id'];
            $row['amount'] = (float)($row['amount'] ?? 0);
        }

        return $this->response([
            'success' => 1,
            'message' => 'Dashboard data fetched successfully',
            'data' => $data
        ], REST_Controller::HTTP_OK);
    }
}
