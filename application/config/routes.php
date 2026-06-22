<?php
defined('BASEPATH') or exit('No direct script access allowed');

#------------ Login -----------------------------
$route['default_controller'] = 'user/login/default';
// $route['login'] = 'LogonDashboard/login';
/* login & forgot password */
$route['login'] = 'user/login/index';
$route['forgot_password/(:any)/(:any)'] = 'user/login/forgot_password/$1/$2';
$route['logout'] = 'user/login/logout';
$route['login1'] = 'login_old';

/* admin */
$route['dashboard'] = 'user/login/dashboard';
$route['user_list'] = 'user/user/user_list';
$route['group_master'] = 'user/user/groupMaster';
$route['group_menu'] = 'user/user/groupMenu';

$route['group_menu'] = 'user/user/groupMenu';
$route['api_document'] = 'user/user/api_document';

/* shops */
$route['shop_list'] = 'shop/shop/shop_list';
$route['grocery_category_list'] = 'grocery_category/grocery_category/grocery_category_list';
$route['grocery_item_list'] = 'grocery_item/grocery_item/grocery_item_list';
$route['grocery_purchase_list'] = 'grocery_purchase/grocery_purchase/grocery_purchase_list';
$route['expense_list'] = 'expense/expense/expense_list';
$route['franchise_list'] = 'franchise/franchise/franchise_list';
$route['daily_collection_list'] = 'daily_collection/daily_collection/daily_collection_list';
$route['online_payment_list'] = 'online_payment/online_payment/online_payment_list';
$route['reports'] = 'reports/reports/collection_vs_expense';

// /*   api execute */
// $route['WS'] = "wsengine/api_execute/wscontroller";
// $route['WS/(:any)'] = "wsengine/api_execute/wscontroller/$1";
// $route['WS/(:any)/(:any)'] = "wsengine/api_execute/wscontroller/$1/$2";
// $route['WS/(:any)/(:any)/(:any)/(:any)'] = "wsengine/api_execute/wscontroller/$1/$2";
$route['WS/(.*)'] = "wsengine/api_execute/wscontroller/$1";

$GLOBALS['is_ws'] = false;
if (($this->uri->segments[1] == "WS" )) {
$GLOBALS['is_ws'] = true;
}