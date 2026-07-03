<?php
// Script to test get_user_list endpoint with search
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, "http://localhost/shiv_amruttulya/user/user/get_user_list");
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query([
    'draw' => 1,
    'start' => 0,
    'length' => 10,
    'columns' => [
        ['data' => 'id'],
        ['data' => 'user_name']
    ],
    'order' => [
        ['column' => 0, 'dir' => 'asc']
    ],
    'search' => ['value' => 'test', 'regex' => 'false']
]));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
$output = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

echo "HTTP Code: $http_code\n";
echo "Output: \n$output\n";
