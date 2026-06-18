<div class="wrapper container-xxl flex-grow-1 container-p-y">
    <nav aria-label="breadcrumb">
      <div class="sub-header-left pull-left breadcrumb">
         <h1>
            Dashboard
         </h1>
         <br>
         <span >Analytics & Summary</span>
      </div>
    </nav>
    <div class="content-wrapper">
        <section class="content">
            <!-- Summary Cards Row -->
            <div class="row mb-4">
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-theme-color) !important; background: linear-gradient(135deg, #F5F7FA 0%, #E6B17A 100%);">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Today's Collection</h5>
                            <h2 class="font-weight-bold mb-2">₹4,500</h2>
                            <small class="fw-bold" style="color: var(--bs-theme-color-dark) !important;"><i class="bx bx-money"></i> Cash: ₹3,000 | Online: ₹1,500</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-theme-color-dark) !important;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Weekly Collection</h5>
                            <h2 class="font-weight-bold mb-2">₹32,450</h2>
                            <small class="text-secondary"><i class="bx bx-wallet"></i> Cash: ₹20,050 | Online: ₹12,400</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-theme-light1-color) !important;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Monthly Collection</h5>
                            <h2 class="font-weight-bold mb-2">₹1,45,000</h2>
                            <small class="text-secondary"><i class="bx bx-calendar"></i> Cash: ₹80,000 | Online: ₹65,000</small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-opposite-color) !important; background-color: #fcf5ec;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Grand Total</h5>
                            <h2 class="font-weight-bold mb-2">₹8,90,500</h2>
                            <small class="text-secondary"><i class="bx bx-rupee"></i> Total Lifetime Business</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row mb-4">
                <div class="col-lg-8 col-md-12 mb-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-white border-0 pt-4 pb-0 d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Collection Trends</h5>
                            <select class="form-select form-select-sm w-auto">
                                <option>Daily</option>
                                <option selected>Weekly</option>
                                <option>Monthly</option>
                            </select>
                        </div>
                        <div class="card-body">
                            <canvas id="collectionTrendChart" height="100"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12 mb-4">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-header bg-white border-0 pt-4 pb-0">
                            <h5 class="card-title mb-0">Shop Wise Comparison</h5>
                        </div>
                        <div class="card-body d-flex align-items-center justify-content-center">
                            <canvas id="shopWiseChart" height="200"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Shop Wise Summary Table -->
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm border-0 table-card">
                        <div class="card-header bg-white border-bottom pt-4 pb-3">
                            <h5 class="card-title mb-0">Shop Wise Summary (Today)</h5>
                        </div>
                        <div class="table-responsive text-nowrap">
                            <table class="table table-hover w-100 mb-0">
                                <thead>
                                    <tr>
                                        <th>Shop Name</th>
                                        <th>Cash Collection</th>
                                        <th>Online Collection</th>
                                        <th>Total Collection</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="fw-bold">Shiv Amruttulya Chinchwad</td>
                                        <td>₹3,000</td>
                                        <td>₹1,500</td>
                                        <td class="text-success fw-bold">₹4,500</td>
                                    </tr>
                                    <tr>
                                        <td class="fw-bold">Shiv Amruttulya Akurdi</td>
                                        <td>₹2,500</td>
                                        <td>₹1,200</td>
                                        <td class="text-success fw-bold">₹3,700</td>
                                    </tr>
                                </tbody>
                                <tfoot>
                                    <tr style="background-color: #f8f9fa;">
                                        <td class="fw-bold text-dark">Grand Total</td>
                                        <td class="fw-bold text-dark">₹5,500</td>
                                        <td class="fw-bold text-dark">₹2,700</td>
                                        <td class="text-primary fw-bolder fs-5">₹8,200</td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="<%$base_url%>public/js/dashboard.js"></script>
