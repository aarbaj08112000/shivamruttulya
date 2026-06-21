<style>
    /* Allow text selection inside accordion buttons so users can copy API URLs */
    .accordion-button {
        user-select: auto !important;
        -webkit-user-select: auto !important;
        -moz-user-select: auto !important;
        -ms-user-select: auto !important;
    }
</style>
<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               API Documentation
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Settings" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Settings</em></a>
            </h1>
         </div>
      </nav>
   </div>

   <div class="content-wrapper">
        <!-- 1. User Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">1. User Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionUser">
                    
                    <!-- Login API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingLogin">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLogin" aria-expanded="false" aria-controls="collapseLogin">
                                <span class="badge bg-primary me-2">POST</span> Login
                            </button>
                        </h2>
                        <div id="collapseLogin" class="accordion-collapse collapse" aria-labelledby="headingLogin" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/auth/login </h6>
                                <h6>Description</h6>
                                <p>Authenticates a user and returns a JWT token for subsequent requests.</p>
                                
                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "email": "admin@test.com",
  "password": "123456"
}</code></pre>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Login successfully",
  "data": {
    "token": "eyJ0eXAi...",
    "id": "1",
    "user_details": {
      "id": "1",
      "name": "Admin",
      "email": "admin@test.com",
      "mobile": "1234567890"
    }
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Get User Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingUserDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUserDetails" aria-expanded="false" aria-controls="collapseUserDetails">
                                <span class="badge bg-success me-2">GET</span> User Details
                            </button>
                        </h2>
                        <div id="collapseUserDetails" class="accordion-collapse collapse" aria-labelledby="headingUserDetails" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/user_details </h6>
                                <h6>Description</h6>
                                <p>Fetches the profile details of the currently logged-in user.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "User data fetched successfully.",
  "data": {
    "id": "1",
    "name": "Admin",
    "email": "admin@test.com",
    "mobile": "1234567890"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update User API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingUserUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseUserUpdate" aria-expanded="false" aria-controls="collapseUserUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update User
                            </button>
                        </h2>
                        <div id="collapseUserUpdate" class="accordion-collapse collapse" aria-labelledby="headingUserUpdate" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/user_update </h6>
                                <h6>Description</h6>
                                <p>Updates the name, mobile number, and profile image of the logged-in user.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "name": "New Admin Name",
  "mobile": "9999999999",
  "profile_image": "base64_string_or_url"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "User details updated successfully",
  "data": {
    "id": "1"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Forgot Password API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingForgotPassword">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseForgotPassword" aria-expanded="false" aria-controls="collapseForgotPassword">
                                <span class="badge bg-primary me-2">POST</span> Forgot Password
                            </button>
                        </h2>
                        <div id="collapseForgotPassword" class="accordion-collapse collapse" aria-labelledby="headingForgotPassword" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/auth/forgot_password </h6>
                                <h6>Description</h6>
                                <p>Allows a user to reset their password via email (unauthenticated request).</p>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "email": "admin@test.com",
  "new_password": "mynewpassword123"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Password updated successfully.",
  "data": {}
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Reset Password API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingResetPassword">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseResetPassword" aria-expanded="false" aria-controls="collapseResetPassword">
                                <span class="badge bg-primary me-2">POST</span> Reset Password
                            </button>
                        </h2>
                        <div id="collapseResetPassword" class="accordion-collapse collapse" aria-labelledby="headingResetPassword" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/auth/reset_password </h6>
                                <h6>Description</h6>
                                <p>Allows a logged-in user to change their password.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "old_password": "123456",
  "new_password": "newpass123"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Password reset successfully.",
  "data": {}
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Logout API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingLogout">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseLogout" aria-expanded="false" aria-controls="collapseLogout">
                                <span class="badge bg-success me-2">GET</span> Logout
                            </button>
                        </h2>
                        <div id="collapseLogout" class="accordion-collapse collapse" aria-labelledby="headingLogout" data-bs-parent="#apiAccordionUser">
                            <div class="accordion-body">
                                <h6>URL: /WS/auth/logout </h6>
                                <h6>Description</h6>
                                <p>Invalidates the current session token for the user.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Logged out",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- 2. Home Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">2. Home Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionHome">
                    
                    <!-- Home Dashboard API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingHomeDashboard">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseHomeDashboard" aria-expanded="false" aria-controls="collapseHomeDashboard">
                                <span class="badge bg-success me-2">GET</span> Home Dashboard
                            </button>
                        </h2>
                        <div id="collapseHomeDashboard" class="accordion-collapse collapse" aria-labelledby="headingHomeDashboard" data-bs-parent="#apiAccordionHome">
                            <div class="accordion-body">
                                <h6>URL: /WS/home/dashboard </h6>
                                <h6>Description</h6>
                                <p>Fetches the dashboard statistics including total collection, time-based summary, shop-wise collection, daily collection trend, monthly collection comparison, and shop-wise summary.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 400px; overflow-y: auto;"><code>{
  "status": true,
  "message": "Dashboard data fetched successfully",
  "data": {
    "grand_total": {
      "total_collection": 124500.00,
      "cash_collection": 84500.00,
      "online_collection": 40000.00
    },
    "time_based_summary": {
      "today": {
        "total": 4500.00,
        "cash": 3000.00,
        "online": 1500.00
      },
      "weekly": {
        "total": 32400.00,
        "cash": 20000.00,
        "online": 12400.00
      },
      "monthly": {
        "total": 124500.00,
        "cash": 84500.00,
        "online": 40000.00
      }
    },
    "shop_wise_collection": [
      {
        "shop_id": 1,
        "shop_name": "Chinchwad",
        "total_collection": 84500.00,
        "percentage": 67.9
      }
    ],
    "daily_collection_trend": [
      {
        "day": 1,
        "date": "2026-06-01",
        "total": 3500.00
      }
    ],
    "monthly_collection_comparison": [
      {
        "month": "April",
        "month_number": 4,
        "year": 2026,
        "total": 98000.00
      }
    ],
    "shop_wise_summary": [
      {
        "shop_id": 1,
        "shop_name": "Shiv Amruttulya Chinchwad",
        "description": "Today's Collection",
        "amount": 4500.00
      }
    ]
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
        <!-- 3. Shop Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">3. Shop Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionShop">
                    
                    <!-- List Shops API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingShopList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopList" aria-expanded="false" aria-controls="collapseShopList">
                                <span class="badge bg-success me-2">GET</span> Shop List
                            </button>
                        </h2>
                        <div id="collapseShopList" class="accordion-collapse collapse" aria-labelledby="headingShopList" data-bs-parent="#apiAccordionShop">
                            <div class="accordion-body">
                                <h6>URL: /WS/shop/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of all active (non-deleted) shops with optional search.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>per_page</code>: Items per page</li>
                                    <li><code>search</code>: Filter by shop name or code</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Shops fetched successfully",
  "data": {
    "current_page": 1,
    "per_page": 10,
    "total_records": 50,
    "total_pages": 5,
    "data": [
      {
        "id": "1",
        "shop_code": "SA-001",
        "shop_name": "Shiv Amruttulya Chinchwad",
        "contact_person": "Rahul",
        "contact_number": "9876543210",
        "email": "rahul@example.com",
        "address": "Chinchwad Station",
        "opening_date": "2026-06-18",
        "status": "active"
      }
    ]
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Shop Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingShopDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopDetails" aria-expanded="false" aria-controls="collapseShopDetails">
                                <span class="badge bg-success me-2">GET</span> Shop Details
                            </button>
                        </h2>
                        <div id="collapseShopDetails" class="accordion-collapse collapse" aria-labelledby="headingShopDetails" data-bs-parent="#apiAccordionShop">
                            <div class="accordion-body">
                                <h6>URL: /WS/shop/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific shop by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/shop/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Shop details fetched successfully",
  "data": {
    "id": "1",
    "shop_code": "SA-001",
    "shop_name": "Shiv Amruttulya Chinchwad",
    "contact_person": "Rahul",
    "contact_number": "9876543210",
    "email": "rahul@example.com",
    "address": "Chinchwad Station",
    "opening_date": "2026-06-18",
    "status": "active"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Shop API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingShopAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopAdd" aria-expanded="false" aria-controls="collapseShopAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Shop
                            </button>
                        </h2>
                        <div id="collapseShopAdd" class="accordion-collapse collapse" aria-labelledby="headingShopAdd" data-bs-parent="#apiAccordionShop">
                            <div class="accordion-body">
                                <h6>URL: /WS/shop/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new shop.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "shop_name": "Shiv Amruttulya Wakad 12",
  "shop_code": "SA-012",
  "contact_person": "Amit",
  "contact_number": "9998887776",
  "email": "amit@sac.com",
  "address": "Wakad Bridge",
  "opening_date": "18/06/2026",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Shop added successfully",
  "data": {
    "shop_name": "Shiv Amruttulya Wakad 12",
    "shop_code": "SA-012",
    "address": "Wakad Bridge",
    "contact_person": "Amit",
    "contact_number": "9998887776",
    "email": "amit@sac.com",
    "opening_date": "2026-06-18",
    "status": "active",
    "added_by": "1",
    "id": 4
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Shop API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingShopUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopUpdate" aria-expanded="false" aria-controls="collapseShopUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Shop
                            </button>
                        </h2>
                        <div id="collapseShopUpdate" class="accordion-collapse collapse" aria-labelledby="headingShopUpdate" data-bs-parent="#apiAccordionShop">
                            <div class="accordion-body">
                                <h6>URL: /WS/shop/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing shop details.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "4",
  "shop_name": "Shiv Amruttulya Wakad Updated",
  "contact_person": "Amit Updated",
  "contact_number": "9998887776",
  "email": "amit@sac.com",
  "address": "Wakad Bridge",
  "opening_date": "18/06/2026",
  "status": "inactive"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Shop updated successfully",
  "data": {
    "id": "4"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Shop API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingShopDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseShopDelete" aria-expanded="false" aria-controls="collapseShopDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Shop
                            </button>
                        </h2>
                        <div id="collapseShopDelete" class="accordion-collapse collapse" aria-labelledby="headingShopDelete" data-bs-parent="#apiAccordionShop">
                            <div class="accordion-body">
                                <h6>URL: /WS/shop/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a shop (it will no longer appear in the list endpoint).</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "4"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Shop deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        <!-- 4. Grocery Category Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">4. Grocery Category Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionGroceryCategory">
                    
                    <!-- List Categories API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingCategoryList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategoryList" aria-expanded="false" aria-controls="collapseCategoryList">
                                <span class="badge bg-success me-2">GET</span> Category List
                            </button>
                        </h2>
                        <div id="collapseCategoryList" class="accordion-collapse collapse" aria-labelledby="headingCategoryList" data-bs-parent="#apiAccordionGroceryCategory">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_category/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of all active (non-deleted) grocery categories.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>per_page</code>: Items per page</li>
                                    <li><code>search</code>: Filter by category name</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Grocery categories fetched successfully",
  "data": {
    "current_page": 1,
    "per_page": 10,
    "total_records": 5,
    "total_pages": 1,
    "data": [
      {
        "id": "1",
        "category_name": "Tea & Coffee",
        "status": "active"
      }
    ]
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Category Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingCategoryDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategoryDetails" aria-expanded="false" aria-controls="collapseCategoryDetails">
                                <span class="badge bg-success me-2">GET</span> Category Details
                            </button>
                        </h2>
                        <div id="collapseCategoryDetails" class="accordion-collapse collapse" aria-labelledby="headingCategoryDetails" data-bs-parent="#apiAccordionGroceryCategory">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_category/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific grocery category by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/grocery_category/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Category details fetched successfully",
  "data": {
    "id": "1",
    "category_name": "Tea & Coffee",
    "status": "active"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Category API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingCategoryAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategoryAdd" aria-expanded="false" aria-controls="collapseCategoryAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Category
                            </button>
                        </h2>
                        <div id="collapseCategoryAdd" class="accordion-collapse collapse" aria-labelledby="headingCategoryAdd" data-bs-parent="#apiAccordionGroceryCategory">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_category/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new grocery category.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "category_name": "Dairy Products",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Category added successfully",
  "data": {
    "category_name": "Dairy Products",
    "status": "active",
    "added_by": "1",
    "id": 2
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Category API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingCategoryUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategoryUpdate" aria-expanded="false" aria-controls="collapseCategoryUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Category
                            </button>
                        </h2>
                        <div id="collapseCategoryUpdate" class="accordion-collapse collapse" aria-labelledby="headingCategoryUpdate" data-bs-parent="#apiAccordionGroceryCategory">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_category/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing grocery category details.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2",
  "category_name": "Dairy Products Updated",
  "status": "inactive"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Category updated successfully",
  "data": {
    "id": "2"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Category API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingCategoryDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseCategoryDelete" aria-expanded="false" aria-controls="collapseCategoryDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Category
                            </button>
                        </h2>
                        <div id="collapseCategoryDelete" class="accordion-collapse collapse" aria-labelledby="headingCategoryDelete" data-bs-parent="#apiAccordionGroceryCategory">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_category/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a grocery category.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Category deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">5. Grocery Item Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionGroceryItem">
                    
                    <!-- List Grocery Items API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryItemList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryItemList" aria-expanded="false" aria-controls="collapseGroceryItemList">
                                <span class="badge bg-success me-2">GET</span> List Grocery Items
                            </button>
                        </h2>
                        <div id="collapseGroceryItemList" class="accordion-collapse collapse" aria-labelledby="headingGroceryItemList" data-bs-parent="#apiAccordionGroceryItem">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_item/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a list of all active (non-deleted) grocery items, including their category names.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Grocery items fetched successfully",
  "data": [
    {
      "id": "1",
      "category_id": "1",
      "item_name": "Tea Powder",
      "unit": "Kg",
      "status": "active",
      "category_name": "Tea & Coffee"
    }
  ]
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Grocery Item Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryItemDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryItemDetails" aria-expanded="false" aria-controls="collapseGroceryItemDetails">
                                <span class="badge bg-success me-2">GET</span> Grocery Item Details
                            </button>
                        </h2>
                        <div id="collapseGroceryItemDetails" class="accordion-collapse collapse" aria-labelledby="headingGroceryItemDetails" data-bs-parent="#apiAccordionGroceryItem">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_item/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific grocery item by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/grocery_item/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery item details fetched successfully",
  "data": {
    "id": "1",
    "category_id": "1",
    "item_name": "Tea Powder",
    "unit": "Kg",
    "status": "active",
    "category_name": "Tea & Coffee"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Grocery Item API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryItemAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryItemAdd" aria-expanded="false" aria-controls="collapseGroceryItemAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Grocery Item
                            </button>
                        </h2>
                        <div id="collapseGroceryItemAdd" class="accordion-collapse collapse" aria-labelledby="headingGroceryItemAdd" data-bs-parent="#apiAccordionGroceryItem">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_item/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new grocery item.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "category_id": "1",
  "item_name": "Sugar",
  "unit": "Kg",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery item added successfully",
  "data": {
    "category_id": "1",
    "item_name": "Sugar",
    "unit": "Kg",
    "status": "active",
    "id": 4
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Grocery Item API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryItemUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryItemUpdate" aria-expanded="false" aria-controls="collapseGroceryItemUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Grocery Item
                            </button>
                        </h2>
                        <div id="collapseGroceryItemUpdate" class="accordion-collapse collapse" aria-labelledby="headingGroceryItemUpdate" data-bs-parent="#apiAccordionGroceryItem">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_item/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing grocery item's details.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "4",
  "item_name": "Brown Sugar",
  "status": "inactive"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery item updated successfully",
  "data": {
    "id": "4"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Grocery Item API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryItemDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryItemDelete" aria-expanded="false" aria-controls="collapseGroceryItemDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Grocery Item
                            </button>
                        </h2>
                        <div id="collapseGroceryItemDelete" class="accordion-collapse collapse" aria-labelledby="headingGroceryItemDelete" data-bs-parent="#apiAccordionGroceryItem">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_item/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a grocery item (it will no longer appear in the list endpoint).</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "4"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery item deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
        <!-- 6. Monthly Grocery Purchase Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">6. Monthly Grocery Purchase Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionGroceryPurchase">
                    
                    <!-- List Grocery Purchases API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryPurchaseList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryPurchaseList" aria-expanded="false" aria-controls="collapseGroceryPurchaseList">
                                <span class="badge bg-success me-2">GET</span> List Grocery Purchases
                            </button>
                        </h2>
                        <div id="collapseGroceryPurchaseList" class="accordion-collapse collapse" aria-labelledby="headingGroceryPurchaseList" data-bs-parent="#apiAccordionGroceryPurchase">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_purchase/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of grocery purchases with optional filters for shop and month.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>limit</code>: Items per page (default: 10)</li>
                                    <li><code>shop_id</code>: Filter by Shop ID</li>
                                    <li><code>month</code>: Filter by Month (1-12)</li>
                                    <li><code>year</code>: Filter by Year (e.g., 2026)</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Grocery purchases fetched successfully",
  "data": {
    "records": [
      {
        "id": "1",
        "shop_id": "1",
        "grocery_item_id": "1",
        "vendor_id": "1",
        "purchase_date": "2026-06-01",
        "quantity": "5.00",
        "rate": "450.00",
        "total_amount": "2250.00",
        "status": "active",
        "shop_name": "Shiv Amruttulya Chinchwad",
        "item_name": "Tea Powder",
        "unit": "Kg",
        "vendor_name": "Local Supplier",
        "added_by_name": "User 123"
      }
    ],
    "pagination": {
      "total_records": 1,
      "current_page": 1,
      "per_page": 10,
      "total_pages": 1
    }
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Grocery Purchase Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryPurchaseDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryPurchaseDetails" aria-expanded="false" aria-controls="collapseGroceryPurchaseDetails">
                                <span class="badge bg-success me-2">GET</span> Grocery Purchase Details
                            </button>
                        </h2>
                        <div id="collapseGroceryPurchaseDetails" class="accordion-collapse collapse" aria-labelledby="headingGroceryPurchaseDetails" data-bs-parent="#apiAccordionGroceryPurchase">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_purchase/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific grocery purchase by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/grocery_purchase/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery purchase details fetched successfully",
  "data": {
    "id": "1",
    "shop_id": "1",
    "grocery_item_id": "1",
    "vendor_id": "1",
    "purchase_date": "2026-06-01",
    "quantity": "5.00",
    "rate": "450.00",
    "total_amount": "2250.00",
    "shop_name": "Shiv Amruttulya Chinchwad",
    "item_name": "Tea Powder",
    "unit": "Kg",
    "vendor_name": "Local Supplier",
    "added_by_name": "User 123"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Grocery Purchase API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryPurchaseAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryPurchaseAdd" aria-expanded="false" aria-controls="collapseGroceryPurchaseAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Grocery Purchase
                            </button>
                        </h2>
                        <div id="collapseGroceryPurchaseAdd" class="accordion-collapse collapse" aria-labelledby="headingGroceryPurchaseAdd" data-bs-parent="#apiAccordionGroceryPurchase">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_purchase/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new grocery purchase entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "shop_id": "1",
  "grocery_item_id": "2",
  "vendor_name": "Local Supplier",
  "purchase_date": "2026-06-15",
  "quantity": "10",
  "rate": "50",
  "total_amount": "500",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery purchase added successfully",
  "data": {
    "shop_id": "1",
    "grocery_item_id": "2",
    "id": 2
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Grocery Purchase API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryPurchaseUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryPurchaseUpdate" aria-expanded="false" aria-controls="collapseGroceryPurchaseUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Grocery Purchase
                            </button>
                        </h2>
                        <div id="collapseGroceryPurchaseUpdate" class="accordion-collapse collapse" aria-labelledby="headingGroceryPurchaseUpdate" data-bs-parent="#apiAccordionGroceryPurchase">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_purchase/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing grocery purchase entry details.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2",
  "vendor_name": "New Vendor",
  "quantity": "12",
  "total_amount": "600"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery purchase updated successfully",
  "data": {
    "id": "2"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Grocery Purchase API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingGroceryPurchaseDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseGroceryPurchaseDelete" aria-expanded="false" aria-controls="collapseGroceryPurchaseDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Grocery Purchase
                            </button>
                        </h2>
                        <div id="collapseGroceryPurchaseDelete" class="accordion-collapse collapse" aria-labelledby="headingGroceryPurchaseDelete" data-bs-parent="#apiAccordionGroceryPurchase">
                            <div class="accordion-body">
                                <h6>URL: /WS/grocery_purchase/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a grocery purchase entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Grocery purchase deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
        <!-- 7. Daily Collection Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">7. Daily Collection Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionDailyCollection">
                    
                    <!-- List Daily Collections API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingDailyCollectionList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDailyCollectionList" aria-expanded="false" aria-controls="collapseDailyCollectionList">
                                <span class="badge bg-success me-2">GET</span> List Daily Collections
                            </button>
                        </h2>
                        <div id="collapseDailyCollectionList" class="accordion-collapse collapse" aria-labelledby="headingDailyCollectionList" data-bs-parent="#apiAccordionDailyCollection">
                            <div class="accordion-body">
                                <h6>URL: /WS/daily_collection/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of daily collections with optional filters for shop and date range.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>limit</code>: Items per page (default: 10)</li>
                                    <li><code>shop_id</code>: Filter by Shop ID</li>
                                    <li><code>collection_date</code>: Filter by exact Date (YYYY-MM-DD)</li>
                                    <li><code>from_date</code> & <code>to_date</code>: Filter by Date Range (YYYY-MM-DD)</li>
                                    <li><code>search</code>: Plain text search by shop name or amount</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Daily collections fetched successfully",
  "data": {
    "records": [
      {
        "id": "1",
        "shop_id": "1",
        "collection_date": "2026-06-10",
        "cash_amount": "2500.00",
        "online_amount": "1800.00",
        "total_amount": "4300.00",
        "status": "active",
        "shop_name": "Shiv Amruttulya Chinchwad",
        "added_by_name": "User 123"
      }
    ],
    "pagination": {
      "total_records": 1,
      "current_page": 1,
      "per_page": 10,
      "total_pages": 1
    }
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Daily Collection Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingDailyCollectionDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDailyCollectionDetails" aria-expanded="false" aria-controls="collapseDailyCollectionDetails">
                                <span class="badge bg-success me-2">GET</span> Daily Collection Details
                            </button>
                        </h2>
                        <div id="collapseDailyCollectionDetails" class="accordion-collapse collapse" aria-labelledby="headingDailyCollectionDetails" data-bs-parent="#apiAccordionDailyCollection">
                            <div class="accordion-body">
                                <h6>URL: /WS/daily_collection/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific daily collection by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/daily_collection/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Daily collection details fetched successfully",
  "data": {
    "id": "1",
    "shop_id": "1",
    "collection_date": "2026-06-10",
    "cash_amount": "2500.00",
    "online_amount": "1800.00",
    "total_amount": "4300.00",
    "status": "active",
    "shop_name": "Shiv Amruttulya Chinchwad",
    "added_by_name": "User 123"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Daily Collection API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingDailyCollectionAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDailyCollectionAdd" aria-expanded="false" aria-controls="collapseDailyCollectionAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Daily Collection
                            </button>
                        </h2>
                        <div id="collapseDailyCollectionAdd" class="accordion-collapse collapse" aria-labelledby="headingDailyCollectionAdd" data-bs-parent="#apiAccordionDailyCollection">
                            <div class="accordion-body">
                                <h6>URL: /WS/daily_collection/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new daily collection entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "shop_id": "1",
  "collection_date": "2026-06-16",
  "cash_amount": "3000",
  "online_amount": "1500",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Daily collection added successfully",
  "data": {
    "shop_id": "1",
    "collection_date": "2026-06-16",
    "cash_amount": 3000,
    "online_amount": 1500,
    "total_amount": 4500,
    "id": 2
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Daily Collection API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingDailyCollectionUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDailyCollectionUpdate" aria-expanded="false" aria-controls="collapseDailyCollectionUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Daily Collection
                            </button>
                        </h2>
                        <div id="collapseDailyCollectionUpdate" class="accordion-collapse collapse" aria-labelledby="headingDailyCollectionUpdate" data-bs-parent="#apiAccordionDailyCollection">
                            <div class="accordion-body">
                                <h6>URL: /WS/daily_collection/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing daily collection entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2",
  "cash_amount": "3200",
  "online_amount": "1600"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Daily collection updated successfully",
  "data": {
    "id": "2"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Daily Collection API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingDailyCollectionDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseDailyCollectionDelete" aria-expanded="false" aria-controls="collapseDailyCollectionDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Daily Collection
                            </button>
                        </h2>
                        <div id="collapseDailyCollectionDelete" class="accordion-collapse collapse" aria-labelledby="headingDailyCollectionDelete" data-bs-parent="#apiAccordionDailyCollection">
                            <div class="accordion-body">
                                <h6>URL: /WS/daily_collection/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a daily collection entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Daily collection deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
        <!-- 8. Expense Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">8. Expense Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionExpense">
                    
                    <!-- List Expenses API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseList" aria-expanded="false" aria-controls="collapseExpenseList">
                                <span class="badge bg-success me-2">GET</span> List Expenses
                            </button>
                        </h2>
                        <div id="collapseExpenseList" class="accordion-collapse collapse" aria-labelledby="headingExpenseList" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of expenses with optional filters for shop, category, and date range.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>limit</code>: Items per page (default: 10)</li>
                                    <li><code>shop_id</code>: Filter by Shop ID</li>
                                    <li><code>category_id</code>: Filter by Expense Category ID</li>
                                    <li><code>expense_date</code>: Filter by exact Date (YYYY-MM-DD)</li>
                                    <li><code>month</code> & <code>year</code>: Filter by Month and Year</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Expenses fetched successfully",
  "data": {
    "records": [
      {
        "id": "1",
        "shop_id": "1",
        "category_id": "1",
        "amount": "15000.00",
        "expense_date": "2026-06-01",
        "description": "Monthly Rent",
        "status": "active",
        "shop_name": "Shiv Amruttulya Chinchwad",
        "category_name": "Rent",
        "added_by_name": "User 123"
      }
    ],
    "pagination": {
      "total_records": 1,
      "current_page": 1,
      "per_page": 10,
      "total_pages": 1
    }
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Expense Report API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseReport">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseReport" aria-expanded="false" aria-controls="collapseExpenseReport">
                                <span class="badge bg-success me-2">GET</span> Expense Report
                            </button>
                        </h2>
                        <div id="collapseExpenseReport" class="accordion-collapse collapse" aria-labelledby="headingExpenseReport" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/report </h6>
                                <h6>Description</h6>
                                <p>Fetches an aggregated expense report, grouped by shop, summing up the total amounts.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>month</code> & <code>year</code>: Filter by Month and Year</li>
                                    <li><code>from_date</code> & <code>to_date</code>: Filter by Date Range</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Expense report fetched successfully",
  "data": [
    {
      "shop_id": "1",
      "shop_name": "Shiv Amruttulya Chinchwad",
      "total_amount": "18500.00"
    }
  ]
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Expense Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseDetails" aria-expanded="false" aria-controls="collapseExpenseDetails">
                                <span class="badge bg-success me-2">GET</span> Expense Details
                            </button>
                        </h2>
                        <div id="collapseExpenseDetails" class="accordion-collapse collapse" aria-labelledby="headingExpenseDetails" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific expense entry by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/expense/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Expense details fetched successfully",
  "data": {
    "id": "1",
    "shop_id": "1",
    "category_id": "1",
    "amount": "15000.00",
    "expense_date": "2026-06-01",
    "description": "Monthly Rent",
    "status": "active",
    "shop_name": "Shiv Amruttulya Chinchwad",
    "category_name": "Rent",
    "added_by_name": "User 123"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Expense API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseAdd" aria-expanded="false" aria-controls="collapseExpenseAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Expense
                            </button>
                        </h2>
                        <div id="collapseExpenseAdd" class="accordion-collapse collapse" aria-labelledby="headingExpenseAdd" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new expense entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "shop_id": "1",
  "category_id": "2",
  "amount": "1500",
  "expense_date": "2026-06-16",
  "description": "Electricity Bill",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Expense added successfully",
  "data": {
    "shop_id": "1",
    "category_id": "2",
    "id": 3
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Expense API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseUpdate" aria-expanded="false" aria-controls="collapseExpenseUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Expense
                            </button>
                        </h2>
                        <div id="collapseExpenseUpdate" class="accordion-collapse collapse" aria-labelledby="headingExpenseUpdate" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing expense entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "3",
  "amount": "1600",
  "description": "Updated Electricity Bill"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Expense updated successfully",
  "data": {
    "id": "3"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Expense API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingExpenseDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExpenseDelete" aria-expanded="false" aria-controls="collapseExpenseDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Expense
                            </button>
                        </h2>
                        <div id="collapseExpenseDelete" class="accordion-collapse collapse" aria-labelledby="headingExpenseDelete" data-bs-parent="#apiAccordionExpense">
                            <div class="accordion-body">
                                <h6>URL: /WS/expense/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes an expense entry.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "3"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Expense deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
        <!-- 9. Franchise Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">9. Franchise Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionFranchise">
                    
                    <!-- List Franchises API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingFranchiseList">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFranchiseList" aria-expanded="false" aria-controls="collapseFranchiseList">
                                <span class="badge bg-success me-2">GET</span> List Franchises
                            </button>
                        </h2>
                        <div id="collapseFranchiseList" class="accordion-collapse collapse" aria-labelledby="headingFranchiseList" data-bs-parent="#apiAccordionFranchise">
                            <div class="accordion-body">
                                <h6>URL: /WS/franchise/list </h6>
                                <h6>Description</h6>
                                <p>Fetches a paginated list of franchises.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>page</code>: Page number (default: 1)</li>
                                    <li><code>limit</code>: Items per page (default: 10)</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 300px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Franchises fetched successfully",
  "data": {
    "records": [
      {
        "id": "1",
        "franchise_code": "FR001",
        "franchise_name": "Shiv Amruttulya",
        "owner_name": "Shivaji Patil",
        "mobile": "9876543211",
        "email": "shiv@gmail.com",
        "joining_date": "2026-06-15 00:00:00",
        "address": "Pune",
        "status": "active"
      }
    ],
    "pagination": {
      "total_records": 1,
      "current_page": 1,
      "per_page": 10,
      "total_pages": 1
    }
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Franchise Details API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingFranchiseDetails">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFranchiseDetails" aria-expanded="false" aria-controls="collapseFranchiseDetails">
                                <span class="badge bg-success me-2">GET</span> Franchise Details
                            </button>
                        </h2>
                        <div id="collapseFranchiseDetails" class="accordion-collapse collapse" aria-labelledby="headingFranchiseDetails" data-bs-parent="#apiAccordionFranchise">
                            <div class="accordion-body">
                                <h6>URL: /WS/franchise/details </h6>
                                <h6>Description</h6>
                                <p>Fetches details of a specific franchise by ID.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters</h6>
                                <ul><li><code>id</code> (e.g., /WS/franchise/details?id=1)</li></ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Franchise details fetched successfully",
  "data": {
    "id": "1",
    "franchise_code": "FR001",
    "franchise_name": "Shiv Amruttulya",
    "owner_name": "Shivaji Patil",
    "mobile": "9876543211",
    "email": "shiv@gmail.com",
    "joining_date": "2026-06-15 00:00:00",
    "address": "Pune",
    "status": "active"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Add Franchise API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingFranchiseAdd">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFranchiseAdd" aria-expanded="false" aria-controls="collapseFranchiseAdd">
                                <span class="badge bg-primary me-2">POST</span> Add Franchise
                            </button>
                        </h2>
                        <div id="collapseFranchiseAdd" class="accordion-collapse collapse" aria-labelledby="headingFranchiseAdd" data-bs-parent="#apiAccordionFranchise">
                            <div class="accordion-body">
                                <h6>URL: /WS/franchise/add </h6>
                                <h6>Description</h6>
                                <p>Creates a new franchise.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "franchise_name": "Shiv Amruttulya Mumbai",
  "owner_name": "Ramesh",
  "mobile": "9998887776",
  "email": "mumbai@shiv.com",
  "joining_date": "2026-06-20",
  "address": "Dadar, Mumbai",
  "status": "active"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Franchise added successfully",
  "data": {
    "franchise_code": "FR002",
    "franchise_name": "Shiv Amruttulya Mumbai",
    "joining_date": "2026-06-20",
    "id": 2
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Update Franchise API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingFranchiseUpdate">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFranchiseUpdate" aria-expanded="false" aria-controls="collapseFranchiseUpdate">
                                <span class="badge bg-primary me-2">POST</span> Update Franchise
                            </button>
                        </h2>
                        <div id="collapseFranchiseUpdate" class="accordion-collapse collapse" aria-labelledby="headingFranchiseUpdate" data-bs-parent="#apiAccordionFranchise">
                            <div class="accordion-body">
                                <h6>URL: /WS/franchise/update </h6>
                                <h6>Description</h6>
                                <p>Updates an existing franchise.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2",
  "mobile": "9998881111",
  "joining_date": "2026-06-20",
  "status": "inactive"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Franchise updated successfully",
  "data": {
    "id": "2"
  }
}</code></pre>
                            </div>
                        </div>
                    </div>

                    <!-- Delete Franchise API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingFranchiseDelete">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFranchiseDelete" aria-expanded="false" aria-controls="collapseFranchiseDelete">
                                <span class="badge bg-primary me-2">POST</span> Delete Franchise
                            </button>
                        </h2>
                        <div id="collapseFranchiseDelete" class="accordion-collapse collapse" aria-labelledby="headingFranchiseDelete" data-bs-parent="#apiAccordionFranchise">
                            <div class="accordion-body">
                                <h6>URL: /WS/franchise/delete </h6>
                                <h6>Description</h6>
                                <p>Soft deletes a franchise.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>

                                <h6>Input JSON / Form-Data</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "id": "2"
}</code></pre>
                                
                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded"><code>{
  "success": 1,
  "message": "Franchise deleted successfully",
  "data": []
}</code></pre>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
        </div>
        <!-- 10. Report Module -->
        <div class="card mb-4">
            <h5 class="card-header border-bottom bg-light">10. Report Module</h5>
            <div class="card-body mt-3">
                <div class="accordion" id="apiAccordionReport">
                    
                    <!-- Monthly Collection Report API -->
                    <div class="accordion-item card mb-3 border shadow-none">
                        <h2 class="accordion-header" id="headingReportMonthlyCollection">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseReportMonthlyCollection" aria-expanded="false" aria-controls="collapseReportMonthlyCollection">
                                <span class="badge bg-success me-2">GET</span> Monthly Collection
                            </button>
                        </h2>
                        <div id="collapseReportMonthlyCollection" class="accordion-collapse collapse" aria-labelledby="headingReportMonthlyCollection" data-bs-parent="#apiAccordionReport">
                            <div class="accordion-body">
                                <h6>URL: /WS/report/monthly_collection </h6>
                                <h6>Description</h6>
                                <p>Fetches the "Reports" screen data, including overall month totals and a paginated list of shop-wise collections.</p>

                                <h6>Headers Required</h6>
                                <ul><li><code>Authorization: Bearer &lt;token&gt;</code></li></ul>
                                
                                <h6>URL Parameters (Optional)</h6>
                                <ul>
                                    <li><code>month</code>: Filter by Month (default: current month)</li>
                                    <li><code>year</code>: Filter by Year (default: current year)</li>
                                    <li><code>page</code>: Page number for shop-wise list (default: 1)</li>
                                    <li><code>limit</code>: Shops per page (default: 10)</li>
                                </ul>

                                <h6>Output Response (Success)</h6>
                                <pre class="bg-dark text-white p-3 rounded" style="max-height: 400px; overflow-y: auto;"><code>{
  "success": 1,
  "message": "Monthly collection report fetched successfully",
  "data": {
    "current_month_data": {
      "total_collection": "80000.00",
      "total_cash": "47000.00",
      "total_online": "33000.00",
      "month": "06",
      "year": "2026"
    },
    "shop_wise_collection": [
      {
        "shop_id": "1",
        "shop_name": "Main Branch",
        "shop_total": "25000.00",
        "shop_cash": "15000.00",
        "shop_online": "10000.00"
      },
      {
        "shop_id": "2",
        "shop_name": "Station Road",
        "shop_total": "20000.00",
        "shop_cash": "12000.00",
        "shop_online": "8000.00"
      }
    ],
    "pagination": {
      "total_records": 2,
      "current_page": 1,
      "per_page": 10,
      "total_pages": 1
    }
  }
}</code></pre>
                            </div>
                        </div>
                   
</div>
