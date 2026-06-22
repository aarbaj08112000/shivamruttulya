<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Daily Collections
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Collection Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Collection</em></a>
            </h1>
         </div>
      </nav>
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addCollectionOffcanvas" aria-controls="addCollectionOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Collection
         </button>
      </div>
   </div>

   <div class="content-wrapper">
      <section class="content">
         <div>
            <div class="row">
               <div class="col-lg-12">
                  <div class="card w-100 table-card">
                     <div class="table-responsive text-nowrap">
                         <table id="collection_management_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                  <!-- Add Collection Offcanvas -->
                  <div class="offcanvas offcanvas-end" tabindex="-1" id="addCollectionOffcanvas" aria-labelledby="addCollectionOffcanvasLabel" style="width: 500px;">
                     <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                        <div>
                           <h5 class="offcanvas-title mb-1" id="addCollectionOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Collection</h5>
                           <p class="text-muted mb-0" style="font-size: 13px;">Enter collection details</p>
                        </div>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                     </div>
                     <div class="offcanvas-body">
                        <form id="addCollectionForm" action="<%base_url('daily_collection/daily_collection/add_daily_collection_action')%>" method="POST">
                           <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Shop<span class="text-danger">*</span></label>
                                 <select class="form-select" name="shop_id" required>
                                    <option value="">Select Shop</option>
                                    <%foreach from=$shops item=shop%>
                                    <option value="<%$shop['id']%>"><%$shop['shop_name']%></option>
                                    <%/foreach%>
                                 </select>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Collection Date<span class="text-danger">*</span></label>
                                 <input type="date" class="form-control" name="collection_date" value="<%$smarty.now|date_format:'%Y-%m-%d'%>" required>
                              </div>
                           </div>
                           <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Amount Details</h6>
                           <div class="row mb-3">
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Cash (₹)<span class="text-danger">*</span></label>
                                 <input type="number" step="0.01" class="form-control calc-add" id="add_cash_amount" name="cash_amount" required>
                              </div>
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Online (₹)<span class="text-danger">*</span></label>
                                 <input type="number" step="0.01" class="form-control calc-add" id="add_online_amount" name="online_amount" required>
                              </div>
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Total (₹)</label>
                                 <input type="number" step="0.01" class="form-control" id="add_total_amount" name="total_amount" readonly>
                              </div>
                           </div>
                           <div class="row mb-3">
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
                        <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addCollectionForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                     </div>
                  </div>

                  <!-- Edit Collection Offcanvas -->
                  <div class="offcanvas offcanvas-end" tabindex="-1" id="editCollectionOffcanvas" aria-labelledby="editCollectionOffcanvasLabel" style="width: 500px;">
                     <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                        <div>
                           <h5 class="offcanvas-title mb-1" id="editCollectionOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Collection</h5>
                           <p class="text-muted mb-0" style="font-size: 13px;">Update collection details</p>
                        </div>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                     </div>
                     <div class="offcanvas-body">
                        <form id="editCollectionForm" action="<%base_url('daily_collection/daily_collection/update_daily_collection_action')%>" method="POST">
                           <input type="hidden" name="collection_id" id="edit_collection_id">
                           <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Shop<span class="text-danger">*</span></label>
                                 <select class="form-select" name="shop_id" id="edit_shop_id" required>
                                    <option value="">Select Shop</option>
                                    <%foreach from=$shops item=shop%>
                                    <option value="<%$shop['id']%>"><%$shop['shop_name']%></option>
                                    <%/foreach%>
                                 </select>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Collection Date<span class="text-danger">*</span></label>
                                 <input type="date" class="form-control" name="collection_date" id="edit_collection_date" required>
                              </div>
                           </div>
                           <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Amount Details</h6>
                           <div class="row mb-3">
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Cash (₹)<span class="text-danger">*</span></label>
                                 <input type="number" step="0.01" class="form-control calc-edit" id="edit_cash_amount" name="cash_amount" required>
                              </div>
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Online (₹)<span class="text-danger">*</span></label>
                                 <input type="number" step="0.01" class="form-control calc-edit" id="edit_online_amount" name="online_amount" required>
                              </div>
                              <div class="col-4">
                                 <label class="form-label" style="font-size: 12px;">Total (₹)</label>
                                 <input type="number" step="0.01" class="form-control" id="edit_total_amount" name="total_amount" readonly>
                              </div>
                           </div>
                           <div class="row mb-3">
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
                        <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editCollectionForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </section>
   </div>
</div>
</div>
<script>
    var column_details = <%$data|json_encode%>;
    var page_length_arr = <%$page_length_arr|json_encode%>;
    var is_searching_enable = <%$is_searching_enable|json_encode%>;
    var is_top_searching_enable = <%$is_top_searching_enable|json_encode%>;
    var is_paging_enable = <%$is_paging_enable|json_encode%>;
    var is_serverSide = <%$is_serverSide|json_encode%>;
    var no_data_message = <%$no_data_message|json_encode%>;
    var is_ordering = <%$is_ordering|json_encode%>;
    var sorting_column = <%$sorting_column%>;
    var api_name = <%$api_name|json_encode%>;
    var base_url = <%$base_url|json_encode%>;
    var start_date = <%$start_date|json_encode%>;
    var end_date = <%$end_date|json_encode%>;
</script>
<script src="<%$base_url%>public/js/daily_collection/daily_collection_list.js"></script>
