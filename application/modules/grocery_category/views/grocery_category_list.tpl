<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Grocery Categories
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Category Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Category</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addCategoryOffcanvas" aria-controls="addCategoryOffcanvas">
            <i class="ti ti-plus me-1"></i> Add Category
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
                         <table id="category_management_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                     <!-- Add Category Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="addCategoryOffcanvas" aria-labelledby="addCategoryOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="addCategoryOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add Category</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Enter category details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="addCategoryForm" action="<%base_url('grocery_category/grocery_category/add_grocery_category_action')%>" method="POST">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Category Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="category_name" placeholder="Enter category name" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Secondary Details</h6>
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
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addCategoryForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                        </div>
                     </div>
                     <!-- End Offcanvas -->

                     <!-- Edit Category Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editCategoryOffcanvas" aria-labelledby="editCategoryOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editCategoryOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit Category</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update category details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editCategoryForm" action="<%base_url('grocery_category/grocery_category/update_grocery_category_action')%>" method="POST">
                              <input type="hidden" name="category_id" id="edit_category_id">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Primary Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Category Name<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="category_name" id="edit_category_name" placeholder="Enter category name" required>
                                 </div>
                              </div>
                              
                              <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Secondary Details</h6>
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
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editCategoryForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
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
   .menu-form-row .form-label lable{
   font-style: normal !important;
   display: block;
   margin-top: 3px;
   font-size: 17px;
   color: #919396;
   font-family: 'GilroySemibold', sans-serif !important;
   }
   .menu-form-row .form-right-div {
   margin: 10px 6px 10px 13px;
   float: left;
   width: 100% !important;
   }
   .menu-form-row .margin-equilize {
   float: left;
   width: 20%;
   }
   .menu-form-row .margin-equilize label{
   font-size: 17px;
   color: #000;
   margin: 0px 0px 2px 8px;
   }
   .menu-form-row .margin-equilize input{
   width: 17px;
   height: 15px;
   cursor: pointer;
   }
   #accessGroups .modal-body {
   padding: 0 20px 0 20px;
   max-height: 433px !important;
   overflow-y: scroll;
   overflow-x: clip;
   }
   .pointer-none{
   pointer-events: none;
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
    var api_name =  <%$api_name|json_encode%>;
    var base_url = <%$base_url|json_encode%>;
    var start_date = <%$start_date|json_encode%>;
    var end_date = <%$end_date|json_encode%>;
</script>

  <script src="<%$base_url%>public/js/grocery_category/grocery_category_list.js"></script>
