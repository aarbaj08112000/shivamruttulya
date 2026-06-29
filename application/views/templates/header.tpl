      
<!DOCTYPE html>
<html
   lang="en"
   class="light-style layout-menu-fixed layout-menu-collapsed  layout-navbar-fixed "
   dir="ltr"
   data-theme="theme-default"
   data-assets-path="<%$base_url%>public/assets/"
   data-template="vertical-menu-template-free"
   >
   <head>
      <meta charset="utf-8" />
      <meta
         name="viewport"
         content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
         />
      <title><%$config['company_name']%></title>
      <meta name="description" content="" />
      <base href="<%base_url()%>">
      <!-- Favicon -->
      <link rel="icon" type="image/x-icon" href="<%base_url()%><%$config['company_fav_icon']%>" />
      <!-- Fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com" />
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
      <link
         href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
         rel="stylesheet"
         />
      <!-- Icons. Uncomment required icon fonts -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/fonts/boxicons.css" />

      <!-- lineawesome --->
      <link rel="stylesheet" href="<%$base_url%>public/css/line-awesome/1.3.0/css/line-awesome.css">
      <link rel="stylesheet" href="<%$base_url%>public/css/line-awesome/1.3.0/css/line-awesome.min.css">

      <!-- lineawesome --->

      <!-- tabler css -->
      <link rel="stylesheet" href="<%$base_url%>public/css/plugin/tabler_css/tabler_icons.css">
      <!-- Core CSS -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/css/core.css?v=<%time()%>" class="template-customizer-core-css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/css/theme-default.css?v=<%time()%>" class="template-customizer-theme-css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/css/theme.css?v=<%time()%>" />
      <!-- Vendors CSS -->
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
      <link rel="stylesheet" href="<%$base_url%>public/assets/vendor/libs/apex-charts/apex-charts.css" />
      <link rel="stylesheet" href="<%$base_url%>public/css/common.css" />
      <!-- Page CSS -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
      <!-- <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css"> -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
      <!-- <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/select.dataTables.min.css"> -->
      <!-- <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/jquery.dataTables.min.css"> -->
      <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/searchPanes.dataTables.min.css">
      <!-- Helpers -->
      <!-- <script src="<%$base_url%>public/assets/vendor/js/helpers.js"></script> -->
      <script src="<%$base_url%>public/assets/js/config.js"></script>
      <script src="<%$base_url%>public/assets/vendor/js/bootstrap.js"></script>
      <script src="<%$base_url%>public/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
      <script src="<%$base_url%>public/js/admin/plugin/jquery.min.js"></script>
      <script src="<%$base_url%>public/js/admin/plugin/jquery.validate.js"></script>
      <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
      <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/pdfmake.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/vfs_fonts.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
      <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/fixedcolumns/3.3.3/js/dataTables.fixedColumns.min.js"></script>
      <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
      <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedcolumns/3.3.3/css/fixedColumns.dataTables.min.css">
      <link rel="stylesheet" type="text/css" href="<%$base_url%>public/css/data_table/datatable.css">
      <!-- select2 -->
      <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
      <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
      <!-- toastr -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" />
      <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
      <!-- toastr -->
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
      <!-- date picker  -->
      <!-- <script src="https://cdn.jsdelivr.net/npm/moment/min/moment.min.js"></script>
         <script src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
         <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"> -->
      <script type="text/javascript" src="<%base_url()%>public/plugin/datepicker/moment.min.js"></script>
      <script type="text/javascript" src="<%base_url()%>public/plugin/datepicker/daterangepicker.min.js"></script>
      <link rel="stylesheet" type="text/css" href="<%base_url()%>public/plugin/datepicker/daterangepicker.css" />
      <script type="text/javascript">
         var theme_color = "#ea1c31";
      </script>
    <!-- toaster -->
      <link rel="stylesheet" href="public/css/toaster/custom_toaster.css" />
      <link rel="stylesheet" href="public/css/fontawesome/font_awesome.css">
     <!-- toaster -->
     <script type="text/javascript">
        var default_page_view_type = <%json_decode($config['default_page_view_type'])|@json_encode%>;
        
        // Global listener to fix DataTables header alignment when sidebar toggles
        $(document).ready(function() {
            $(document).on('click', '.layout-menu-toggle, #close-vertical-btn', function() {
                setTimeout(function() {
                    if ($.fn.DataTable) {
                        $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
                    }
                }, 300); // 300ms matches most sidebar transition times
            });
        });
     </script>
     <script type="text/javascript" src="<%base_url()%>public/js/admin/grid_structure.js"></script>

     <style>
         /* Reduce overall application scale by 10% */
         html {
             font-size: 90% !important;
         }
         
         /* Override Bootstrap success color from #71dd37 to #006400 (dark green) */
         :root {
             --bs-green: #006400 !important;
             --bs-success: #006400 !important;
             --bs-success-rgb: 0, 100, 0 !important;
         }
         .text-success {
             color: #006400 !important;
         }
         .bg-success {
             background-color: #006400 !important;
         }
         .btn-success {
             background-color: #006400 !important;
             border-color: #006400 !important;
         }
         .badge.bg-label-success {
             color: #006400 !important;
         }
         .btn {
             border-radius: 20px !important;
         }
         .serarch-filter-input {
             border-radius: 16px !important;
         }
         
         /* Custom Select2 Theme Styling */
         .select2-container--default .select2-selection--single {
             border-radius: 16px !important;
             border: 1px solid var(--bs-theme-color) !important;
             height: 38px !important;
             padding: 4px 0 !important;
         }
         .select2-container--default .select2-selection--single .select2-selection__rendered {
             color: var(--bs-theme-color) !important;
             font-weight: 500 !important;
         }
         .select2-container--default .select2-selection--single .select2-selection__arrow b {
             border-color: var(--bs-theme-color) transparent transparent transparent !important;
         }
         .select2-container--default.select2-container--open .select2-selection--single .select2-selection__arrow b {
             border-color: transparent transparent var(--bs-theme-color) transparent !important;
         }
         /* The dropdown list */
         .theme-select2-dropdown {
             border-radius: 16px !important;
             border: 1px solid var(--bs-theme-color) !important;
             overflow: hidden !important;
             box-shadow: 0 4px 15px rgba(0,0,0,0.1) !important;
         }
         .theme-select2-dropdown .select2-results__option--highlighted[aria-selected] {
             background-color: var(--bs-theme-color) !important;
             color: white !important;
         }
         .theme-select2-dropdown .select2-results__option {
             color: #697a8d;
         }
         
         /* Hide Navbar brand and toggle icon when sidebar is expanded */
         html.layout-menu-expanded .navbar .app-brand-link.navbar-brand,
         html.layout-menu-expanded .navbar .layout-menu-toggle {
             opacity: 0 !important;
             pointer-events: none !important;
             width: 0 !important;
             overflow: hidden !important;
         }
         /* Side Menu Close Icon Visibility */
         html.layout-menu-collapsed #close-vertical-btn {
             display: none !important;
         }
         html.layout-menu-expanded #close-vertical-btn {
             display: block !important;
         }
         /* Make header consistent fixed height */
         .layout-navbar, .navbar-classic {
             min-height: 60px !important;
             height: 60px !important;
             max-height: 60px !important;
             padding-top: 0 !important;
             padding-bottom: 0 !important;
         }
         .navbar-classic .container-fluid {
             height: 100% !important;
             align-items: center !important;
         }
     </style>
     <script>
         // Global Image Fallback
         document.addEventListener('error', function (e) {
             if (e.target.tagName && e.target.tagName.toLowerCase() === 'img') {
                 var fallbackImage = 'data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22200%22%20height%3D%22200%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20200%20200%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder%20text%20%7B%20fill%3A%23999%3Bfont-weight%3Anormal%3Bfont-family%3A-apple-system%2CBlinkMacSystemFont%2C%26quot%3BSegoe%20UI%26quot%3B%2CRoboto%2C%26quot%3BHelvetica%20Neue%26quot%3B%2CArial%2C%26quot%3BNoto%20Sans%26quot%3B%2Csans-serif%3Bfont-size%3A20pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder%22%3E%3Crect%20width%3D%22200%22%20height%3D%22200%22%20fill%3D%22%23eeeeee%22%3E%3C%2Frect%3E%3Cg%3E%3Ctext%20x%3D%2250%25%22%20y%3D%2250%25%22%20text-anchor%3D%22middle%22%20dy%3D%22.3em%22%3ENo%20Image%3C%2Ftext%3E%3C%2Fg%3E%3C%2Fg%3E%3C%2Fsvg%3E';
                 if (e.target.src !== fallbackImage) {
                     e.target.src = fallbackImage;
                 }
             }
         }, true);
     </script>
   </head>
   <body>
      <!-- Layout wrapper -->
      <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container outer-div-box">
      <!-- Menu -->
      <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme ">
         <div class="app-brand demo ps-3">
            <a href="javascript:void(0)" class="app-brand-link" style="display: flex; align-items: center; gap: 10px;">
            <span class="app-brand-logo demo">
               <img src="<%base_url()%><%$config['company_logo']%>" alt="" style="width: 50px; height: 50px; border-radius: 50%; object-fit: cover;">
            </span>
            <span class="app-brand-text demo fw-bolder" style="font-family: 'Poppins', sans-serif; font-size: 16px !important; text-transform: capitalize; color: #8B5E3C;"><%$config['company_name']%></span>
             <i class="ti ti-x fs-3 close-vertical-btn" id="close-vertical-btn" title="Close"></i>
            </a>
            <a href="javascript:void(0);" class="layout-menu-toggle hide layout-menu-toggle-popup menu-link text-large ms-auto d-block">
            <i class="bx bx-chevron-right bx-sm align-middle"></i>
            </a>
         </div>
         <div class="menu-inner-shadow"></div>
         <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <%* <li class="menu-item active">
               <a href="home" class="menu-link">
                  <i class="menu-icon tf-icons bx bx-home-circle"></i>
                  <div data-i18n="Analytics">Dashboard</div>
               </a>
            </li>
            <!-- Layouts -->
            <li class="menu-item">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <i class="menu-icon tf-icons bx bx-layout"></i>
                  <div data-i18n="Layouts">Home</div>
               </a>
               <ul class="menu-sub">
                  <li class="menu-item">
                     <a href="sidemap" class="menu-link">
                       <i class="menu-icon tf-icons bx bx-cube-alt"></i> <div data-i18n="Without menu">Sitemap</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="form" class="menu-link">
                        <div data-i18n="Without navbar">Form</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="listing" class="menu-link">
                        <div data-i18n="Without navbar">Listing</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="form" class="menu-link">
                        <div data-i18n="Without navbar">Shortcuts</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="layouts-container.html" class="menu-link">
                        <div data-i18n="Container">Custom Dashboard</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="layouts-fluid.html" class="menu-link">
                        <div data-i18n="Fluid">Watchlist</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="layouts-blank.html" class="menu-link">
                        <div data-i18n="Blank">Smart Dashboard</div>
                     </a>
                  </li>
               </ul>
            </li> 
            
            <li class="menu-header small text-uppercase menu-item">
               <span class="menu-header-text">Management</span>
            </li>
            *%> 
            
            <li class="menu-item">
               <a href="<%$base_url%>dashboard" class="menu-link">
                  <i class="menu-icon tf-icons bx bx-home-circle"></i>
                  <div data-i18n="Dashboard">Dashboard</div>
               </a>
            </li>

            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Shop Management">Shop Management</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>shop_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-store"></i><div data-i18n="Shop Management">Shop Management</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>menu_master_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-food-menu"></i><div data-i18n="Menu Master">Menu Master</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>accessories_master_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-box"></i><div data-i18n="Accessories Master">Accessories Master</div>
                     </a>
                  </li>
               </ul>
            </li>
            
            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Grocery Management">Grocery Management</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>grocery_category_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-category"></i><div data-i18n="Grocery Categories">Grocery Categories</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>grocery_item_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-basket"></i><div data-i18n="Grocery Item Master">Grocery Item Master</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>grocery_purchase_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-cart"></i><div data-i18n="Monthly Grocery Purchase">Monthly Grocery Purchase</div>
                     </a>
                  </li>
               </ul>
            </li>
            
            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Collections">Collections & Payments</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>daily_collection_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-wallet"></i><div data-i18n="Daily Collection Management">Daily Collection Management</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>online_payment_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-credit-card"></i><div data-i18n="Online Payment Tracking">Online Payment Tracking</div>
                     </a>
                  </li>
               </ul>
            </li>

            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Expense Management">Expense Management</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>expense_category_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-category-alt"></i><div data-i18n="Expense Categories">Expense Categories</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>expense_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-money"></i><div data-i18n="Expense Management">Expense Management</div>
                     </a>
                  </li>
               </ul>
            </li>

            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Reports">Reports</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>reports" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-bar-chart-alt-2"></i><div data-i18n="Collection vs Expense">Collection vs Expense</div>
                     </a>
                  </li>
               </ul>
            </li>

            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Franchise">Franchise</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>franchise_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-buildings"></i><div data-i18n="Franchise">Franchise</div>
                     </a>
                  </li>
               </ul>
            </li>

            <li class="menu-item menu-item menu-header small text-uppercase p-0 open-menu">
               <a href="javascript:void(0);" class="menu-link menu-toggle">
                  <div data-i18n="Settings">Settings</div>
               </a>
               <ul class="menu-sub" style="display: block;">
                  <li class="menu-item">
                     <a href="<%$base_url%>user_list" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-user-circle"></i><div data-i18n="User Management">User Management</div>
                     </a>
                  </li>
                  <!-- <li class="menu-item">
                     <a href="<%$base_url%>group_master" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-group"></i><div data-i18n="Group Master">Group Master</div>
                     </a>
                  </li> -->
                  <li class="menu-item">
                     <a href="<%$base_url%>api_document" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-file"></i><div data-i18n="API Document">API Document</div>
                     </a>
                  </li>
                  <li class="menu-item">
                     <a href="<%$base_url%>app_version" class="menu-link" >
                        <i class="menu-icon tf-icons bx bx-mobile"></i><div data-i18n="App Version">App Version</div>
                     </a>
                  </li>
               </ul>
            </li>
         </ul>
      </aside>
      <div class="main-wrap main-wrap--white main-loader-box" style="display: none;">
         <div class="loader-div"></div>
      </div>
      <!-- / Menu -->
      <!-- Layout container -->
      <div class="layout-page">
      <!-- Navbar -->
      <!-- / Navbar -->

      <nav class="navbar navbar-expand-lg bg-navbar-theme navbar-classic py-0" style="min-height: 60px; height: 60px;">
         <div class="container-fluid">
            <div class="d-flex align-items-center">
               <a href="dashboard" class="app-brand-link navbar-brand" style="display: flex; align-items: center; gap: 10px; margin-right: 0;">
               <span class="app-brand-logo demo">
               <img src="<%base_url()%><%$config['company_logo']%>" alt="" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" title="<%$config['company_name']%>">
               </span>
               <span class="app-brand-text demo fw-bolder" style="font-family: 'Poppins', sans-serif; font-size: 18px; text-transform: capitalize; color: var(--bs-theme-color);"><%$config['company_name']%></span>
               </a>
               <!-- Hamburger Icon for Slide Menu Bar -->
               <i class="ti ti-menu-2 layout-menu-toggle" style="font-size: 24px; cursor: pointer; margin-left: 10px; color: var(--bs-theme-color);" title="Toggle Menu"></i>
            </div>

            <!-- for horizontal menu bar  -->

            <%if $config['menu_type'] eq 'horizontal'%>
            <p class="horizontal-line-header" style="
    border-left: 1px solid gray;
    padding: 0px;
    margin: 0px;
    height: 38px;
    padding-right: 4px;
">&nbsp;</p>
            <button class="navbar-toggler collapsed " id="toggle-horizontal-menu-bar" type="button" style="display:block; " title="Menu">
            <span class="ti ti-menu-2 h3"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
               <ul class="navbar-nav">
               </ul>
            </div>
            <%/if%>
           

            <!-- vertical menu bar -->
            <%if $config['menu_type'] eq 'vertical'%>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span> <label>Menu</label>
            </button>
            <%/if%>


            <div class="navbar-right-wrap ms-2 d-flex align-items-center nav-top-wrap navbar-nav login-nav-block login-nav-block-mobile">
               <div class="header_userprofile_blk">
                   <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 35px; height: 35px; font-size: 16px;">
                       <%$session_data['user_name']|substr:0:1|upper%>
                   </div>
               </div>
               <span class="profile-name" >
                <%$session_data['user_name']%>
               <em title="Admin []" ><%$session_data['role']%></em>
               </span>
               <ul class="navbar-right-wrap ms-auto d-flex nav-top-wrap navbar-nav">
                  <li class="ms-2 dropdown">
                     <a class="dropdownUser inactive" id="dropdownUser" aria-expanded="false">
                        <i class="las la-angle-down"></i>
                     </a>
                     <div data-bs-popper="static" class="dropdown-menu dropdown-menu-end  dropdown-menu dropdown-menu-end dropdownUserNav" aria-labelledby="dropdownUser" id="dropdownUserNav">
                        <div data-rr-ui-dropdown-item="" class=" ">
                           <ul class="top-menu ps-0">
                              <li class="top-child-menu">
                                    <a hijacked="yes" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#resetPasswordModal" title="Reset Password" class="top-menu-link">
                                        <span class="las la-key"></span>Reset Password
                                    </a>
                              </li>
                              <li class="top-child-menu">
                                    <a hijacked="yes" href="<%base_url('logout')%>" title="" class="top-menu-link">
                                        <span class="las la-sign-in-alt"></span>Sign Out
                                    </a>
                              </li>

                           </ul>
                           <!-- <div class="lh-1 ">
                              <h5 class="mb-1">  <%$session_data['user_name']%></h5>
                              <a class="text-inherit fs-6" href="javascript:void(0)"><%$session_data['user_email']%></a>
                              <h6 class="mt-2">(<%$session_data['clientUnitName']%>)</h6>
                           </div>
                           <div class=" dropdown-divider mt-3 mb-2"></div> -->
                        </div>
                        <!-- <a data-rr-ui-dropdown-item="" class="dropdown-item" role="button" tabindex="0" href="<%base_url('logout')%>"><i class="ti ti-power me-2" ti></i>Sign Out</a> -->
                     </div>
                  </li>
               </ul>
            </div>
            <%if $config['menu_type'] eq 'vertical'%>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
               <ul class="navbar-nav">
                  <li class="nav-item">
                     <a class="nav-link" href="<%$base_url%>dashboard">Dashboard</a>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkShop" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Shop Management
                     </a>
                      <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkShop">
                        <li>
                           <a href="<%$base_url%>shop_list" class="dropdown-item">Shops</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>menu_master_list" class="dropdown-item">Menu Master</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>accessories_master_list" class="dropdown-item">Accessories Master</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkGrocery" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Grocery Management
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkGrocery">
                        <li>
                           <a href="<%$base_url%>grocery_category_list" class="dropdown-item">Grocery Categories</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>grocery_item_list" class="dropdown-item">Grocery Item Master</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>grocery_purchase_list" class="dropdown-item">Monthly Grocery Purchase</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkCollection" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Collections & Payments
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkCollection">
                        <li>
                           <a href="<%$base_url%>daily_collection_list" class="dropdown-item">Daily Collection Management</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>online_payment_list" class="dropdown-item">Online Payment Tracking</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkExpenses" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Expense Management
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkExpenses">
                        <li>
                           <a href="<%$base_url%>expense_list" class="dropdown-item">Expense Management</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkReports" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Reports
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkReports">
                        <li>
                           <a href="<%$base_url%>reports" class="dropdown-item">Collection vs Expense</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkFranchise" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Franchise
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkFranchise">
                        <li>
                           <a href="<%$base_url%>franchise_list" class="dropdown-item">Franchise</a>
                        </li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="javascript:void(0)" id="navbarDropdownMenuLinkSettings" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     Settings
                     </a>
                     <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLinkSettings">
                        <li>
                           <a href="<%$base_url%>user_list" class="dropdown-item">User Management</a>
                        </li>
                        <!-- <li>
                           <a href="<%$base_url%>group_master" class="dropdown-item">Group Master</a>
                        </li> -->
                        <li>
                           <a href="<%$base_url%>api_document" class="dropdown-item">API Document</a>
                        </li>
                        <li>
                           <a href="<%$base_url%>app_version" class="dropdown-item">App Version</a>
                        </li>
                     </ul>
                  </li>
               </ul>
            </div>
            <%/if%>
            <div class="navbar-right-wrap ms-auto d-flex align-items-center nav-top-wrap navbar-nav login-nav-block web-login-nav-block justify-content-end w-100">
               <div class="header_userprofile_blk">
                   <div class="text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 35px; height: 35px; font-size: 16px; margin-right: 8px;
    background: var(--bs-theme-color) !important;">
                       <%$session_data['user_name']|substr:0:1|upper%>
                   </div>
               </div>
               <span class="profile-name" >
                <%$session_data['user_name']%>
               <em title="Admin []" ><%$session_data['role']%></em>
               </span>
               <ul class="navbar-right-wrap ms-auto d-flex nav-top-wrap navbar-nav">
                  <li class="ms-2 dropdown">
                     <a class="dropdownUser inactive" id="dropdownUser" aria-expanded="false">
                        <i class="las la-angle-down"></i>
                     </a>
                     <div data-bs-popper="static" class="dropdown-menu dropdown-menu-end  dropdown-menu dropdown-menu-end dropdownUserNav" aria-labelledby="dropdownUser" id="dropdownUserNav">
                        <div data-rr-ui-dropdown-item="" class=" ">
                           <ul class="top-menu ps-0">
                              <li class="top-child-menu">
                                    <a hijacked="yes" href="javascript:void(0);" data-bs-toggle="modal" data-bs-target="#resetPasswordModal" title="Reset Password" class="top-menu-link">
                                        <span class="las la-key"></span>Reset Password
                                    </a>
                              </li>
                              <li class="top-child-menu">
                                    <a hijacked="yes" href="<%base_url('logout')%>" title="" class="top-menu-link">
                                        <span class="las la-sign-in-alt"></span>Sign Out
                                    </a>
                              </li>

                           </ul>
                           <!-- <div class="lh-1 ">
                              <h5 class="mb-1">  <%$session_data['user_name']%></h5>
                              <a class="text-inherit fs-6" href="javascript:void(0)"><%$session_data['user_email']%></a>
                              <h6 class="mt-2">(<%$session_data['clientUnitName']%>)</h6>
                           </div>
                           <div class=" dropdown-divider mt-3 mb-2"></div> -->
                        </div>
                        <!-- <a data-rr-ui-dropdown-item="" class="dropdown-item" role="button" tabindex="0" href="<%base_url('logout')%>"><i class="ti ti-power me-2" ti></i>Sign Out</a> -->
                     </div>
                  </li>
               </ul>
            </div>

         </div>
      </nav>
      <!-- Content wrapper -->
      <div class="content-wrapper">
      <!-- Content -->
      <script>
      document.addEventListener("DOMContentLoaded", function() {
          var toggles = document.querySelectorAll(".layout-menu-toggle, #close-vertical-btn");
          toggles.forEach(function(toggle) {
              toggle.addEventListener("click", function(e) {
                  e.preventDefault();
                  var html = document.documentElement;
                  if(html.classList.contains("layout-menu-expanded")) {
                      html.classList.remove("layout-menu-expanded");
                      html.classList.add("layout-menu-collapsed");
                  } else {
                      html.classList.remove("layout-menu-collapsed");
                      html.classList.add("layout-menu-expanded");
                  }
              });
          });

          // --- Active Menu Highlighting ---
          var currentPath = window.location.pathname;
          // Get the last segment of the URL (e.g., "shop_list" from "/shiv_amruttulya/shop_list")
          var segments = currentPath.replace(/\/+$/, '').split('/');
          var currentPage = segments[segments.length - 1] || 'dashboard';

          var menuLinks = document.querySelectorAll('#layout-menu .menu-inner .menu-link[href]');
          menuLinks.forEach(function(link) {
              var href = link.getAttribute('href');
              if (!href || href === 'javascript:void(0);' || href === 'javascript:void(0)') return;

              // Extract the last segment from the link href
              var linkSegments = href.replace(/\/+$/, '').split('/');
              var linkPage = linkSegments[linkSegments.length - 1];

              if (linkPage === currentPage) {
                  // Mark the child <li> as active
                  var childLi = link.closest('li.menu-item');
                  if (childLi) {
                      childLi.classList.add('active');
                  }

                  // Mark the parent group <li> as active and open
                  var parentSub = link.closest('ul.menu-sub');
                  if (parentSub) {
                      var parentLi = parentSub.closest('li.menu-item');
                      if (parentLi) {
                          parentLi.classList.add('active', 'open');
                      }
                      parentSub.style.display = 'block';
                  }
              }
          });
      });
      </script>
      <style>
          /* Active menu item highlighting */
          #layout-menu .menu-inner > li.menu-item.active > .menu-link.menu-toggle {
              color: var(--bs-theme-color-dark) !important;
              font-weight: 700 !important;
          }
          #layout-menu .menu-inner .menu-sub li.menu-item.active > .menu-link {
              background-color: var(--bs-theme-color) !important;
              color: #fff !important;
              border-radius: 6px;
              font-weight: 600;
          }
          #layout-menu .menu-inner .menu-sub li.menu-item.active > .menu-link .menu-icon {
              color: #fff !important;
          }
          #layout-menu .menu-inner .menu-sub li.menu-item.active > .menu-link div {
              color: #fff !important;
          }
          /* Dashboard direct link active */
          #layout-menu .menu-inner > li.menu-item.active > a.menu-link:not(.menu-toggle) {
              background-color: var(--bs-theme-color) !important;
              color: #fff !important;
              border-radius: 6px;
              font-weight: 600;
          }
          #layout-menu .menu-inner > li.menu-item.active > a.menu-link:not(.menu-toggle) .menu-icon {
              color: #fff !important;
          }
          #layout-menu .menu-inner > li.menu-item.active > a.menu-link:not(.menu-toggle) div {
              color: #fff !important;
          }
      </style>

      <!-- Reset Password Modal -->
      <div class="modal fade" id="resetPasswordModal" tabindex="-1" aria-labelledby="resetPasswordModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
               <div class="modal-header" style="background-color: var(--bs-theme-color); color: white;">
                  <h5 class="modal-title" id="resetPasswordModalLabel">Reset Password</h5>
                  <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
               </div>
               <div class="modal-body">
                  <form id="resetPasswordForm">
                     <div class="mb-3">
                        <label for="old_password" class="form-label" style="font-size: 12px;">Old Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" id="old_password" name="old_password" placeholder="Enter old password" required>
                     </div>
                     <div class="mb-3">
                        <label for="new_password" class="form-label" style="font-size: 12px;">New Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" id="new_password" name="new_password" placeholder="Enter new password" required>
                     </div>
                     <div class="mb-3">
                        <label for="confirm_password" class="form-label" style="font-size: 12px;">Confirm Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirm new password" required>
                     </div>
                  </form>
               </div>
               <div class="modal-footer d-flex justify-content-between">
                  <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                  <button type="button" class="btn text-white px-4" id="btnResetPassword" style="background-color: var(--bs-theme-color-dark) !important;">
                     <i class="ti ti-device-floppy me-2"></i> Save
                  </button>
               </div>
            </div>
         </div>
      </div>

      <script>
      $(document).ready(function() {
          $('#resetPasswordForm').validate({
              rules: {
                  old_password: "required",
                  new_password: {
                      required: true,
                      minlength: 6
                  },
                  confirm_password: {
                      required: true,
                      equalTo: "#new_password"
                  }
              },
              messages: {
                  old_password: "Please enter your old password",
                  new_password: {
                      required: "Please enter a new password",
                      minlength: "Password must be at least 6 characters"
                  },
                  confirm_password: {
                      required: "Please confirm your new password",
                      equalTo: "Passwords do not match"
                  }
              },
              errorElement: "span",
              errorPlacement: function (error, element) {
                  error.addClass("invalid-feedback");
                  element.closest(".mb-3").append(error);
              },
              highlight: function (element, errorClass, validClass) {
                  $(element).addClass("is-invalid");
              },
              unhighlight: function (element, errorClass, validClass) {
                  $(element).removeClass("is-invalid");
              }
          });

          $('#btnResetPassword').on('click', function() {
              if ($('#resetPasswordForm').valid()) {
                  var btn = $(this);
                  var originalText = btn.html();
                  btn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

                  $.ajax({
                      url: '<%$base_url%>user/login/change_password',
                      type: 'POST',
                      data: {
                          old_password: $('#old_password').val(),
                          new_password: $('#new_password').val()
                      },
                      dataType: 'json',
                      success: function(response) {
                          btn.html(originalText).prop('disabled', false);
                          
                          if (response.success == 1) {
                              toaster('success', response.msg);
                              $('#resetPasswordModal').modal('hide');
                              $('#resetPasswordForm')[0].reset();
                              $('#resetPasswordForm').validate().resetForm();
                              $('#resetPasswordForm').find('.is-invalid').removeClass('is-invalid');
                          } else {
                              toaster('error', response.msg);
                          }
                      },
                      error: function() {
                          btn.html(originalText).prop('disabled', false);
                          toaster('error', 'An error occurred. Please try again.');
                      }
                  });
              }
          });
      });
      </script>