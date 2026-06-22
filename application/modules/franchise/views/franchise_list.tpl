<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Franchise List
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Franchise Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Franchise</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addFranchiseOffcanvas" aria-controls="addFranchiseOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Franchise
         </button>
      </div>
   </div>

   <div class="content-wrapper" >
      <!-- Main content -->
      <section class="content">
         <div>
            <!-- Small boxes (Stat box) -->
            <div class="row">
               <div class="col-lg-12">
                  <div class="card w-100 table-card">
                     <div class="table-responsive text-nowrap">
                         <table id="franchise_management_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
                            <thead>
                                <tr>
                                    <%foreach from=$data key=key item=val%>
                                        <th style="background-color: var(--bs-theme-color) !important; color: white !important; font-weight: bold; border-bottom: none;"><%$val['title']%></th>
                                    <%/foreach%>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        </div>
                     </div>

                     <!-- Add Franchise Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="addFranchiseOffcanvas" aria-labelledby="addFranchiseOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="addFranchiseOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Franchise</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Enter franchise details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="addFranchiseForm" action="<%base_url('franchise/franchise/add_franchise_action')%>" method="POST">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                              <div class="row mb-3">
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Franchise Code</label>
                                    <input type="text" class="form-control" name="franchise_code" placeholder="Enter code">
                                 </div>
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Joining Date</label>
                                    <input type="date" class="form-control" name="joining_date">
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Franchise Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="franchise_name" placeholder="Enter franchise name" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Owner Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="owner_name" placeholder="Enter owner name" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Contact Details</h6>
                              <div class="row mb-3">
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Mobile<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="mobile" placeholder="Enter mobile" required>
                                 </div>
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Email</label>
                                    <input type="email" class="form-control" name="email" placeholder="Enter email">
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Address</label>
                                    <textarea class="form-control" name="address" rows="3" placeholder="Enter address"></textarea>
                                 </div>
                                 <div class="col-12">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addFranchiseForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Offcanvas -->

                     <!-- Edit Franchise Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editFranchiseOffcanvas" aria-labelledby="editFranchiseOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editFranchiseOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Franchise</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update franchise details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editFranchiseForm" action="<%base_url('franchise/franchise/update_franchise_action')%>" method="POST">
                              <input type="hidden" name="franchise_id" id="edit_franchise_id">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                              <div class="row mb-3">
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Franchise Code</label>
                                    <input type="text" class="form-control" name="franchise_code" id="edit_franchise_code" placeholder="Enter code">
                                 </div>
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Joining Date</label>
                                    <input type="date" class="form-control" name="joining_date" id="edit_joining_date">
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Franchise Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="franchise_name" id="edit_franchise_name" placeholder="Enter franchise name" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Owner Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="owner_name" id="edit_owner_name" placeholder="Enter owner name" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Contact Details</h6>
                              <div class="row mb-3">
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Mobile<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="mobile" id="edit_mobile" placeholder="Enter mobile" required>
                                 </div>
                                 <div class="col-6 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Email</label>
                                    <input type="email" class="form-control" name="email" id="edit_email" placeholder="Enter email">
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Address</label>
                                    <textarea class="form-control" name="address" id="edit_address" rows="3" placeholder="Enter address"></textarea>
                                 </div>
                                 <div class="col-12">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status" id="edit_status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editFranchiseForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Edit Offcanvas -->
                  </div>
                                    <!-- ./col -->
                                 </div>
                              </div>
                              <!-- /.row -->
                              <!-- Main row -->
                              <!-- /.row (main row) -->
                           </div>
                           <!-- /.container-fluid -->
                        </section>
                        <!-- /.content -->
                     </div>
</div>
</div>
 <script>
    var column_details =  <%$data|json_encode%>;
    var page_length_arr = <%$page_length_arr|json_encode%>;
    var is_searching_enable = <%$is_searching_enable|json_encode%>;
    var is_top_searching_enable =  <%$is_top_searching_enable|json_encode%>;
    var is_paging_enable =  <%$is_paging_enable|json_encode%>;
    var is_serverSide =  <%$is_serverSide|json_encode%>;
    var no_data_message =  <%$no_data_message|json_encode%>;
    var is_ordering =  <%$is_ordering|json_encode%>;
    var sorting_column = <%$sorting_column%>;
    var api_name =  <%$api_name|json_encode%>;
    var base_url = <%$base_url|json_encode%>;
    var start_date = <%$start_date|json_encode%>;
    var end_date = <%$end_date|json_encode%>;
</script>

<script src="<%$base_url%>public/js/franchise/franchise_list.js"></script>
