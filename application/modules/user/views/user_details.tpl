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
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="modal" data-bs-target="#addPromo">
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
                  <!-- Modal -->
                  <div class="modal fade" id="addPromo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                     <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                           <div class="modal-header">
                              <h5 class="modal-title" id="exampleModalLabel">Add User</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                              </button>
                           </div>
                           <form action="<%base_url('user/user/addUsersData') %>" method="POST" enctype="multipart/form-data" id="addTransporterForm">
                              <div class="modal-body">
                                <div class="row">
                                 <div class="form-group">
                                    <label>Full Name<span class="text-danger">*</span></label> <br>
                                    <input required type="text" name="user_name" placeholder="Enter Full Name" class="form-control" value="">
                                 </div>
                                 <div class="form-group">
                                    <label>Email<span class="text-danger">*</span></label> <br>
                                    <input required type="email" name="user_email" placeholder="Enter Email" class="form-control" value="">
                                 </div>
                                 <div class="form-group">
                                    <label>Password<span class="text-danger">*</span></label> <br>
                                    <input required type="password" name="user_password" placeholder="Enter Password" class="form-control" value="">
                                 </div>
                                 <div class="form-group">
                                    <label>Mobile<span class="text-danger">*</span></label> <br>
                                    <input required type="text" name="mobile" placeholder="Enter Mobile" class="form-control" value="">
                                 </div>
                                 </div>
                                 <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Save changes</button>
                                </div>
                              </div>
                           </form>
                           </div>
                           </div>
                        </div>
                     </div>
                  </div>

                  <div class="card w-100 table-card">
                     <!-- /.card-header -->
                     <div class="table-responsive text-nowrap">
                        <table id="erp_users" class="table table-striped w-100">
                           <thead>
                              <tr>
                                 <th class="hide">Sr No</th> 
                                 <th>Full Name</th>
                                 <th>Email</th>
                                 <th>Mobile</th>
                                 <th>Status</th>
                                 <th>Action</th>
                              </tr>
                           </thead>
                           <tbody>
                              <%if (true) %>
                              <%assign var='i' value=1 %>
                              <%foreach from=$user_info item=u %>
                              <tr>
                                 <td class="hide"><%$i %></td>
                                 <td><%$u['name'] %></td>
                                 <td><%$u['email'] %></td>
                                 <td><%$u['mobile'] %></td>
                                 <td style="color: <%if $u['status']|lower eq 'active'%>#006400<%else%>#C6011F<%/if%>; font-weight: bold;"><%$u['status']|capitalize %></td>
                                 <td>
                                    <a data-bs-toggle="modal" data-bs-target="#updatePromo<%$i%>" class="text-primary me-2" title="Edit"><i class="bx bx-edit-alt fs-4"></i></a>
                                    <a href="javascript:void(0)" class="text-danger" title="Delete"><i class="bx bx-trash fs-4"></i></a>
                                    <div class="modal fade" id="updatePromo<%$i%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                       <div class="modal-dialog  modal-dialog-centered" role="document">
                                          <div class="modal-content">
                                             <div class="modal-header">
                                                <h5 class="modal-title" id="exampleModalLabel">Update User</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
                                                </button>
                                             </div>
                                             <form action="<%base_url('user/user/updateUsersData') %>" method="POST" enctype="multipart/form-data" id="update_users_data<%$i%>" class="update_users_data update_users_data<%$i%> custom-form">
                                                <div class="modal-body">
                                                  <div class="row">
                                                     <div class="form-group">
                                                        <input type="hidden" name="user_id" value="<%$u['id']%>">
                                                     </div>
                                                     <div class="form-group">
                                                        <label for="on click url">Full Name<span class="text-danger">*</span></label> <br>
                                                        <input  type="text" name="user_name" placeholder="Enter Full Name" class="form-control required-input" value="<%$u['name'] %>">
                                                     </div>
                                                     <div class="form-group">
                                                        <label for="on click url">Email<span class="text-danger">*</span></label> <br>
                                                        <input  type="email" name="user_email" placeholder="Enter Email" class="form-control required-input" value="<%$u['email'] %>" disabled>
                                                     </div>
                                                     <div class="form-group">
                                                        <label for="on click url">Mobile<span class="text-danger">*</span></label> <br>
                                                        <input  type="text" name="mobile" placeholder="Enter Mobile" class="form-control required-input" value="<%$u['mobile'] %>">
                                                     </div>
                                                     <div class="form-group" >
                                                        <label for="on click url" class="w-100">Status<span class="text-danger">*</span> </label> <br>
                                                        <select name="status" class="form-control select2 required-input">
                                                           <option value="active" <%if $u['status'] eq 'active'%>selected<%/if%>>Active</option>
                                                           <option value="inactive" <%if $u['status'] eq 'inactive'%>selected<%/if%>>Inactive</option>
                                                        </select>
                                                     </div>
                                                    </div>
                                                     <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                             </form>
                                             </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </td>
                                 <td style="display: none;"><%json_encode($u)%></td>
                              </tr>
                              <%assign var='i' value=$i+1 %>
                              <%/foreach%>
                              <%/if%>
                           </tbody>
                        </table>
                     </div>
                     <!-- /.card-body -->
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
   var base_url = <%$base_url|@json_encode%>;
   var no_data_message = <%$no_data_message|@json_encode%>;
   var module_name = "User";
</script>
<script src="<%$base_url%>public/js/admin/user_list.js"></script>