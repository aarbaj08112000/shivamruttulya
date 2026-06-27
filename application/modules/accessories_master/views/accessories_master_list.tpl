<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Accessories Master
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Accessories Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Accessories Items</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addAccessoryOffcanvas" aria-controls="addAccessoryOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Accessory
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
                         <table id="accessories_master_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                     <!-- Add Accessory Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="addAccessoryOffcanvas" aria-labelledby="addAccessoryOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="addAccessoryOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Accessory</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Enter accessory details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="addAccessoryForm" action="<%base_url('accessories_master/accessories_master/add_accessory_action')%>" method="POST">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Accessory Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Accessory Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="name" placeholder="Enter accessory name" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Total Number<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="total_number" placeholder="0" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Shop</label>
                                    <select class="form-select" name="shop_id">
                                       <option value="">All Shops</option>
                                       <%foreach from=$shops item=shop%>
                                          <option value="<%$shop.id%>"><%$shop.shop_name%></option>
                                       <%/foreach%>
                                    </select>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Additional Details</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                                 <div class="col-12 mt-3">
                                    <label class="form-label" style="font-size: 12px;">Description</label>
                                    <textarea class="form-control" name="description" rows="3" placeholder="Enter description"></textarea>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addAccessoryForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Add Offcanvas -->

                     <!-- Edit Accessory Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editAccessoryOffcanvas" aria-labelledby="editAccessoryOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editAccessoryOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Accessory</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update accessory details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editAccessoryForm" action="<%base_url('accessories_master/accessories_master/update_accessory_action')%>" method="POST">
                              <input type="hidden" name="accessory_id" id="edit_accessory_id">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Accessory Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Accessory Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="name" id="edit_name" placeholder="Enter accessory name" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Total Number<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" name="total_number" id="edit_total_number" placeholder="0" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Shop</label>
                                    <select class="form-select" name="shop_id" id="edit_shop_id">
                                       <option value="">All Shops</option>
                                       <%foreach from=$shops item=shop%>
                                          <option value="<%$shop.id%>"><%$shop.shop_name%></option>
                                       <%/foreach%>
                                    </select>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Additional Details</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status" id="edit_status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                                 <div class="col-12 mt-3">
                                    <label class="form-label" style="font-size: 12px;">Description</label>
                                    <textarea class="form-control" name="description" id="edit_description" rows="3" placeholder="Enter description"></textarea>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editAccessoryForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Edit Offcanvas -->

                     <!-- View Accessory Modal -->
                     <div class="modal fade" id="viewAccessoryModal" tabindex="-1" aria-labelledby="viewAccessoryModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                           <div class="modal-content">
                              <div class="modal-header" style="background-color: var(--bs-theme-color); color: white;">
                                 <h5 class="modal-title" id="viewAccessoryModalLabel">Accessory Details</h5>
                                 <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                 <table class="table table-borderless mb-0">
                                    <tbody>
                                       <tr><td class="text-muted fw-bold" style="width:40%;">Accessory Name</td><td id="view_name"></td></tr>
                                       <tr><td class="text-muted fw-bold">Total Number</td><td id="view_total_number"></td></tr>
                                       <tr><td class="text-muted fw-bold">Shop</td><td id="view_shop_name"></td></tr>
                                       <tr><td class="text-muted fw-bold">Status</td><td id="view_status"></td></tr>
                                       <tr><td class="text-muted fw-bold">Description</td><td id="view_description"></td></tr>
                                       <tr><td class="text-muted fw-bold">Added Date</td><td id="view_added_date"></td></tr>
                                    </tbody>
                                 </table>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- End View Modal -->

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
<style type="text/css">
   input.check-box{
   width: 18px;
   height: 15px;
   cursor: pointer;
   }
   .menu-form-row {
   margin-top: 5px;
   padding-top: 5px;
   padding-bottom: 5px;
   width: 100%;
   position: relative;
   }
   .menu-form-row .form-label{
   float: left;
   width: 100% !important;
   }
   .select2-container--default .select2-selection--multiple .select2-selection__choice {
   background-color: var(--bs-theme-light4-color) !important;
   }
</style>
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
    var base_url = <%$base_url|json_encode%>;
</script>

  <script src="<%$base_url%>public/js/accessories_master/accessories_master_list.js"></script>
