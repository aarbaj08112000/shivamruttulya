<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Grocery Purchases
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Purchase Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Purchase</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addPurchaseOffcanvas" aria-controls="addPurchaseOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Purchase
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
                         <table id="purchase_management_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                     <!-- Add Purchase Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="addPurchaseOffcanvas" aria-labelledby="addPurchaseOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="addPurchaseOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Purchase</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Enter purchase details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="addPurchaseForm" action="<%base_url('grocery_purchase/grocery_purchase/add_grocery_purchase_action')%>" method="POST">
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
                                    <label class="form-label" style="font-size: 12px;">Grocery Item<span class="text-danger">*</span></label>
                                    <select class="form-select" name="grocery_item_id" required>
                                       <option value="">Select Item</option>
                                       <%foreach from=$items item=item%>
                                       <option value="<%$item['id']%>"><%$item['item_name']%> (<%$item['unit']%>)</option>
                                       <%/foreach%>
                                    </select>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Vendor Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="vendor_name" placeholder="Enter vendor name" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Purchase Date<span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="purchase_date" value="<%$smarty.now|date_format:'%Y-%m-%d'%>" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Calculation Details</h6>
                              <div class="row mb-3">
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Quantity<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control calc-input" id="add_quantity" name="quantity" required>
                                 </div>
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Rate (₹)<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control calc-input" id="add_rate" name="rate" required>
                                 </div>
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Total (₹)</label>
                                    <input type="number" step="0.01" class="form-control" id="add_total_amount" name="total_amount" readonly>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addPurchaseForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Offcanvas -->

                     <!-- Edit Purchase Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editPurchaseOffcanvas" aria-labelledby="editPurchaseOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editPurchaseOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Purchase</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update purchase details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editPurchaseForm" action="<%base_url('grocery_purchase/grocery_purchase/update_grocery_purchase_action')%>" method="POST">
                              <input type="hidden" name="purchase_id" id="edit_purchase_id">
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
                                    <label class="form-label" style="font-size: 12px;">Grocery Item<span class="text-danger">*</span></label>
                                    <select class="form-select" name="grocery_item_id" id="edit_grocery_item_id" required>
                                       <option value="">Select Item</option>
                                       <%foreach from=$items item=item%>
                                       <option value="<%$item['id']%>"><%$item['item_name']%> (<%$item['unit']%>)</option>
                                       <%/foreach%>
                                    </select>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Vendor Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="vendor_name" id="edit_vendor_name" placeholder="Enter vendor name" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Purchase Date<span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" name="purchase_date" id="edit_purchase_date" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Calculation Details</h6>
                              <div class="row mb-3">
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Quantity<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control calc-input-edit" id="edit_quantity" name="quantity" required>
                                 </div>
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Rate (₹)<span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control calc-input-edit" id="edit_rate" name="rate" required>
                                 </div>
                                 <div class="col-4">
                                    <label class="form-label" style="font-size: 12px;">Total (₹)</label>
                                    <input type="number" step="0.01" class="form-control" id="edit_total_amount" name="total_amount" readonly>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editPurchaseForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
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

<script src="<%$base_url%>public/js/grocery_purchase/grocery_purchase_list.js"></script>
