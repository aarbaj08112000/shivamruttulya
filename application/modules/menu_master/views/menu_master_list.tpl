<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Menu Master
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Menu Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Menu Items</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addMenuOffcanvas" aria-controls="addMenuOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Menu
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
                         <table id="menu_master_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                     <!-- Add Menu Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="addMenuOffcanvas" aria-labelledby="addMenuOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="addMenuOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Menu Item</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Enter menu item details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="addMenuForm" action="<%base_url('menu_master/menu_master/add_menu_action')%>" method="POST" enctype="multipart/form-data">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Menu Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Menu Title<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="menu_title" placeholder="Enter menu title" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Price (₹)<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control" name="price" placeholder="0.00" required>
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
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Image</label>
                                    <input type="file" class="form-control" name="image" accept=".jpg,.jpeg,.png,.webp">
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
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addMenuForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Add Offcanvas -->

                     <!-- Edit Menu Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editMenuOffcanvas" aria-labelledby="editMenuOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editMenuOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Menu Item</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update menu item details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editMenuForm" action="<%base_url('menu_master/menu_master/update_menu_action')%>" method="POST" enctype="multipart/form-data">
                              <input type="hidden" name="menu_id" id="edit_menu_id">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Menu Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Menu Title<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="menu_title" id="edit_menu_title" placeholder="Enter menu title" required>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Price (₹)<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control" name="price" id="edit_price" placeholder="0.00" required>
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
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Status</label>
                                    <select class="form-select" name="status" id="edit_status">
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                                 <div class="col-6">
                                    <label class="form-label" style="font-size: 12px;">Image</label>
                                    <input type="file" class="form-control" name="image" accept=".jpg,.jpeg,.png,.webp">
                                 </div>
                                 <div class="col-12 mt-3" id="edit_image_preview_box" style="display:none;">
                                    <label class="form-label" style="font-size: 12px;">Current Image</label>
                                    <div><img id="edit_image_preview" src="" class="rounded border" style="max-height: 80px;" /></div>
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
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editMenuForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Edit Offcanvas -->

                     <!-- View Menu Modal -->
                     <div class="modal fade" id="viewMenuModal" tabindex="-1" aria-labelledby="viewMenuModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                           <div class="modal-content">
                              <div class="modal-header" style="background-color: var(--bs-theme-color); color: white;">
                                 <h5 class="modal-title" id="viewMenuModalLabel">Menu Item Details</h5>
                                 <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                 <div class="text-center mb-3" id="view_image_box" style="display:none;">
                                    <img id="view_image" src="" class="rounded border" style="max-height: 150px;" />
                                 </div>
                                 <table class="table table-borderless mb-0">
                                    <tbody>
                                       <tr><td class="text-muted fw-bold" style="width:35%;">Menu Title</td><td id="view_menu_title"></td></tr>
                                       <tr><td class="text-muted fw-bold">Price (₹)</td><td id="view_price"></td></tr>
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

  <script src="<%$base_url%>public/js/menu_master/menu_master_list.js"></script>
