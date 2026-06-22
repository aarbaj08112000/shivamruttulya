<?php defined('BASEPATH') or exit('No direct script access allowed');

class Report extends My_Api_Controller
{
    public function __construct()
    {
        parent::__construct();
        $this->load->model('report_model');
    }

    public function monthly_collection_get()
    {
        if ($this->authenticate() !== true) return;

        $month = $this->get('month');
        $year = $this->get('year');

        // Defaults to current month and year if not provided
        if (empty($month)) {
            $month = date('m');
        }
        if (empty($year)) {
            $year = date('Y');
        }

        $page = $this->get('page') ? (int)$this->get('page') : 1;
        $limit = $this->get('limit') ? (int)$this->get('limit') : 10;
        $offset = ($page - 1) * $limit;

        // Fetch overall summary
        $overall_summary = $this->report_model->get_overall_summary($month, $year);

        // Fetch shop wise collections with pagination
        $shop_wise_data = $this->report_model->get_shop_wise_collection($limit, $offset, $month, $year);
        $total_shops = $this->report_model->get_shop_wise_count($month, $year);

        return $this->response([
            'success' => 1,
            'message' => 'Monthly collection report fetched successfully',
            'data' => [
                'current_month_data' => [
                    'total_collection' => $overall_summary['total_collection'],
                    'total_cash' => $overall_summary['total_cash'],
                    'total_online' => $overall_summary['total_online'],
                    'month' => $month,
                    'year' => $year
                ],
                'shop_wise_collection' => $shop_wise_data,
                'pagination' => [
                    'total_records' => $total_shops,
                    'current_page' => $page,
                    'per_page' => $limit,
                    'total_pages' => $limit > 0 ? ceil($total_shops / $limit) : 1
                ]
            ]
        ], REST_Controller::HTTP_OK);
    }

    public function transaction_summary_get()
    {
        if ($this->authenticate() !== true) return;

        $date = $this->get('date'); // Format: YYYY-MM-DD
        if (empty($date)) {
            $date = date('Y-m-d');
        }

        $timestamp = strtotime($date);
        $month = date('m', $timestamp);
        $year = date('Y', $timestamp);

        $daily_summary = $this->report_model->get_date_summary($date);
        $monthly_summary = $this->report_model->get_month_summary($month, $year);
        $active_dates = $this->report_model->get_active_dates($month, $year);

        return $this->response([
            'success' => 1,
            'message' => 'Transaction summary fetched successfully',
            'data' => [
                'selected_date' => $date,
                'active_dates' => $active_dates,
                'daily_summary' => $daily_summary,
                'monthly_summary' => $monthly_summary
            ]
        ], REST_Controller::HTTP_OK);
    }
}

/* tests */
