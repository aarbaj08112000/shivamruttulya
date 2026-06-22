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
                            <h2 class="font-weight-bold mb-2">₹<%$dashboard_data['today']['total']|number_format:2%></h2>
                            <small class="fw-bold" style="color: var(--bs-theme-color-dark) !important;"><i class="bx bx-money"></i> Cash: ₹<%$dashboard_data['today']['cash']|number_format:2%> | Online: ₹<%$dashboard_data['today']['online']|number_format:2%></small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-theme-color-dark) !important;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Weekly Collection</h5>
                            <h2 class="font-weight-bold mb-2">₹<%$dashboard_data['weekly']['total']|number_format:2%></h2>
                            <small class="text-secondary"><i class="bx bx-wallet"></i> Cash: ₹<%$dashboard_data['weekly']['cash']|number_format:2%> | Online: ₹<%$dashboard_data['weekly']['online']|number_format:2%></small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-theme-light1-color) !important;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Monthly Collection</h5>
                            <h2 class="font-weight-bold mb-2">₹<%$dashboard_data['monthly']['total']|number_format:2%></h2>
                            <small class="text-secondary"><i class="bx bx-calendar"></i> Cash: ₹<%$dashboard_data['monthly']['cash']|number_format:2%> | Online: ₹<%$dashboard_data['monthly']['online']|number_format:2%></small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
                    <div class="card shadow-sm border-0" style="border-left: 5px solid var(--bs-opposite-color) !important; background-color: #fcf5ec;">
                        <div class="card-body">
                            <h5 class="card-title text-muted mb-0">Grand Total</h5>
                            <h2 class="font-weight-bold mb-2">₹<%$dashboard_data['grand_total']['total']|number_format:2%></h2>
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
                                    <%if !empty($dashboard_data['shop_today'])%>
                                        <%foreach from=$dashboard_data['shop_today'] item=shop%>
                                        <tr>
                                            <td class="fw-bold"><%$shop['shop_name']%></td>
                                            <td>₹<%$shop['cash']|number_format:2%></td>
                                            <td>₹<%$shop['online']|number_format:2%></td>
                                            <td class="text-success fw-bold">₹<%$shop['total']|number_format:2%></td>
                                        </tr>
                                        <%/foreach%>
                                    <%else%>
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">No collections recorded today</td>
                                        </tr>
                                    <%/if%>
                                </tbody>
                                <tfoot>
                                    <tr style="background-color: #f8f9fa;">
                                        <td class="fw-bold text-dark">Grand Total</td>
                                        <td class="fw-bold text-dark">₹<%$dashboard_data['today']['cash']|number_format:2%></td>
                                        <td class="fw-bold text-dark">₹<%$dashboard_data['today']['online']|number_format:2%></td>
                                        <td class="text-primary fw-bolder fs-5">₹<%$dashboard_data['today']['total']|number_format:2%></td>
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

<script>
    var trendData = <%$dashboard_data['trends']|json_encode%>;
    var shopWiseData = <%$dashboard_data['shop_wise']|json_encode%>;
</script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="<%$base_url%>public/js/dashboard.js"></script>
