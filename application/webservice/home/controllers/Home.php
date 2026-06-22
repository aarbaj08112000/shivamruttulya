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

        $month_year = $this->get('month_year');
        
        $month = null;
        $year = null;

        if (!empty($month_year)) {
            $timestamp = strtotime("1 " . $month_year);
            if ($timestamp) {
                $month = date('m', $timestamp);
                $year = date('Y', $timestamp);
            }
        }

        if (empty($month) || empty($year)) {
            $month = date('m');
            $year = date('Y');
        }

        $current_month = $this->home_model->get_current_month_collection($month, $year);
        $time_summary = $this->home_model->get_time_based_summary($month, $year);
        $profit_summary = $this->home_model->get_profit_summary($month, $year);
        
        $daily_trend = $this->home_model->get_daily_collection_trend($month, $year);
        $monthly_comparison = $this->home_model->get_monthly_collection_comparison($month, $year);
        $shop_ranking = $this->home_model->get_shop_wise_ranking();

        // Formatting
        foreach ($daily_trend as &$row) {
            $row['amount'] = (float)$row['amount'];
        }
        foreach ($monthly_comparison as &$row) {
            $row['month_value'] = (int)$row['month_value'];
            $row['year'] = (int)$row['year'];
            $row['amount'] = (float)$row['amount'];
        }
        foreach ($shop_ranking as &$row) {
            $row['shop_id'] = (int)$row['shop_id'];
            $row['today_collection'] = (float)$row['today_collection'];
        }

        $data = [
            'current_month_collection' => [
                'total_amount' => (float)($current_month['total_amount'] ?? 0),
                'cash_collection' => (float)($current_month['cash_collection'] ?? 0),
                'online_collection' => (float)($current_month['online_collection'] ?? 0)
            ],
            'collection_summary' => [
                'today' => [
                    'total' => (float)$time_summary['today']['total'],
                    'cash' => (float)$time_summary['today']['cash'],
                    'online' => (float)$time_summary['today']['online']
                ],
                'weekly' => [
                    'total' => (float)$time_summary['weekly']['total'],
                    'cash' => (float)$time_summary['weekly']['cash'],
                    'online' => (float)$time_summary['weekly']['online']
                ],
                'monthly' => [
                    'total' => (float)$time_summary['monthly']['total'],
                    'cash' => (float)$time_summary['monthly']['cash'],
                    'online' => (float)$time_summary['monthly']['online']
                ]
            ],
            'this_month_profit_summary' => $profit_summary,
            'charts' => [
                'daily_collection_trend' => (array)$daily_trend,
                'monthly_collection_comparison' => (array)$monthly_comparison,
                'expense_vs_collection_comparison' => [
                    'collection_amount' => $profit_summary['collection'],
                    'expenses_excl_grocery' => $profit_summary['expense'],
                    'grocery' => $profit_summary['grocery']
                ]
            ],
            'shop_wise_ranking' => (array)$shop_ranking
        ];

        return $this->response([
            'success' => 1,
            'message' => 'Dashboard data retrieved successfully',
            'data' => $data
        ], REST_Controller::HTTP_OK);
    }
}

/* tests */
