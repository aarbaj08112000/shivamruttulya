<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               User Management
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="User Listing" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">User</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn btn-danger me-2" id="logoutAllUsersBtn" title="Logout All Users" onclick="logoutAllUsers()">
            <i class="ti ti-power me-1"></i> Logout All Users
         </button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="offcanvas" data-bs-target="#addPromoOffcanvas" aria-controls="addPromoOffcanvas">
            <i class="ti ti-plus me-1"></i> Add User
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
                  <!-- Add User Offcanvas -->
                  <div class="offcanvas offcanvas-end" tabindex="-1" id="addPromoOffcanvas" aria-labelledby="addPromoOffcanvasLabel" style="width: 500px;">
                     <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                        <div>
                           <h5 class="offcanvas-title mb-1" id="addPromoOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Add User</h5>
                           <p class="text-muted mb-0" style="font-size: 13px;">Enter user details</p>
                        </div>
                        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                     </div>
                     <div class="offcanvas-body">
                        <form action="<%base_url('user/user/addUsersData') %>" method="POST" enctype="multipart/form-data" id="addTransporterForm">
                           <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">User Information</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Full Name<span class="text-danger">*</span></label>
                                 <input required type="text" name="user_name" placeholder="Enter Full Name" class="form-control" value="">
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Email<span class="text-danger">*</span></label>
                                 <input required type="email" name="user_email" placeholder="Enter Email" class="form-control" value="">
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Password<span class="text-danger">*</span></label>
                                 <input required type="password" name="user_password" placeholder="Enter Password" class="form-control" value="">
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Profile Image</label>
                                 <input type="file" name="profile_image" class="form-control" accept="image/*">
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Mobile<span class="text-danger">*</span></label>
                                 <input required type="text" name="mobile" placeholder="Enter Mobile" class="form-control" value="">
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label" style="font-size: 12px;">Role<span class="text-danger">*</span></label>
                                 <select name="user_role" class="form-select" required>
                                    <option value="">Select Role</option>
                                    <%foreach from=$roles item=role%>
                                       <option value="<%$role['id']%>"><%$role['role_name']%></option>
                                    <%/foreach%>
                                 </select>
                              </div>
                           </div>
                        </form>
                     </div>
                     <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                        <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                        <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#addTransporterForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
                     </div>
                  </div>
                  <!-- End Offcanvas -->

                  <div class="card w-100 table-card">
                     <!-- /.card-header -->
                     <div class="table-responsive text-nowrap">
                        <table id="erp_users" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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
                     <!-- /.card-body -->
                     
                     <!-- View User Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="viewUserOffcanvas" aria-labelledby="viewUserOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="viewUserOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">View User</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">User details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">User Information</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Full Name</label>
                                 <div id="view_user_name" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Profile Image</label>
                                 <div id="view_user_profile_image" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Email</label>
                                 <div id="view_user_email" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Mobile</label>
                                 <div id="view_user_mobile" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Status</label>
                                 <div id="view_user_status" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                           </div>

                           <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Additional Details</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Role</label>
                                 <div id="view_user_role" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Added Date</label>
                                 <div id="view_user_added_date" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                           </div>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-end bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Close</button>
                        </div>
                     </div>
                     <!-- End View Offcanvas -->

                     <!-- Edit User Offcanvas (shared, populated via JS) -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="editUserOffcanvas" aria-labelledby="editUserOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="editUserOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">Edit User</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Update user details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <form id="editUserForm" action="<%base_url('user/user/update_user_action')%>" method="POST" enctype="multipart/form-data">
                              <input type="hidden" name="user_id" id="edit_user_id">
                              <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">User Information</h6>
                              <div class="row mb-3">
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Full Name <span class="text-danger">*</span></label>
                                    <input type="text" name="user_name" id="edit_user_name" placeholder="Enter Full Name" class="form-control" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Email</label>
                                    <input type="email" name="user_email" id="edit_user_email" class="form-control" disabled>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Profile Image</label>
                                    <input type="file" name="profile_image" class="form-control" accept="image/*">
                                    <div id="edit_profile_image_preview" class="mt-2"></div>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Mobile <span class="text-danger">*</span></label>
                                    <input type="text" name="mobile" id="edit_user_mobile" placeholder="Enter Mobile" class="form-control" required>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Role <span class="text-danger">*</span></label>
                                    <select name="user_role" id="edit_user_role" class="form-select" required>
                                       <option value="">Select Role</option>
                                       <%foreach from=$roles item=role%>
                                          <option value="<%$role['id']%>"><%$role['role_name']%></option>
                                       <%/foreach%>
                                    </select>
                                 </div>
                                 <div class="col-12 mb-3">
                                    <label class="form-label" style="font-size: 12px;">Status <span class="text-danger">*</span></label>
                                    <select name="status" id="edit_user_status" class="form-select" required>
                                       <option value="active">Active</option>
                                       <option value="inactive">Inactive</option>
                                    </select>
                                 </div>
                              </div>
                           </form>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-between bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Cancel</button>
                           <button type="button" class="btn text-white px-4" style="background-color: var(--bs-theme-color-dark) !important;" onclick="$('#editUserForm').submit();"><i class="ti ti-device-floppy me-2"></i> Save</button>
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
   <div class="modal fade" id="accessGroups" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">Page Access</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
               </button>
            </div>
            <div class="modal-body">
               <div class="row">
               </div>
            </div>
         </div>
      </div>
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
<script type="text/javascript">
   var column_details    = <%$data|json_encode%>;
   var page_length_arr   = <%$page_length_arr|json_encode%>;
   var is_searching_enable  = <%$is_searching_enable|json_encode%>;
   var is_top_searching_enable = <%$is_top_searching_enable|json_encode%>;
   var is_paging_enable  = <%$is_paging_enable|json_encode%>;
   var is_serverSide     = <%$is_serverSide|json_encode%>;
   var no_data_message   = <%$no_data_message|json_encode%>;
   var is_ordering       = <%$is_ordering|json_encode%>;
   var sorting_column    = <%$sorting_column%>;
   var base_url          = <%$base_url|json_encode%>;
</script>
<script src="<%$base_url%>public/js/admin/user_list.js"></script>