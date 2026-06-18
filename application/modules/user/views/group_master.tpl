
<div class="content-wrapper">
  <!-- Content -->

  <div class="container-xxl flex-grow-1 container-p-y">
 

   <div class="d-flex justify-content-between align-items-center mb-4">
      <!-- Left Side: Breadcrumb -->
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
              User Management
              <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Group Master Listing" >
              <i class="ti ti-chevrons-right" ></i>
              <em style="color: var(--bs-theme-color-dark) !important;">Group Master</em></a>
            </h1>
         </div>
      </nav>

      <!-- Right Side: Actions -->
      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
         <button type="button" class="btn" style="background-color: var(--bs-theme-color-dark) !important; color: white !important; border: none;" data-bs-toggle="modal" data-bs-target="#addPromo" title="Add process">
            <i class="ti ti-plus me-1"></i> Add Group
         </button>
      </div>
   </div>

   <div class="modal fade" id="addPromo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog  modal-dialog-centered" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">Add Group</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
               </button>
            </div>
            <form action="<%base_url('user/user/addGroupMaster')%>" method="POST" enctype="multipart/form-data" id="add_group" class="add_group custom-form">
            <div class="modal-body">
               <div class="form-group">
               </div>
               <div class="form-group">
                  <label for="on click url">Group Name<span class="text-danger">*</span></label> <br>
                  <input  type="text" name="group_name" placeholder="Enter Group Name" class="form-control required-input" value="" >
               </div>
               <div class="form-group">
                  <label for="on click url">Group Code<span class="text-danger">*</span></label> <br>
                  <input  type="text" name="group_code" id="group_code" placeholder="Enter Group Code" class="form-control required-input" value="" >
               </div>
               <div class="form-group">
                  <label for="on click url">Status<span class="text-danger">*</span></label> <br>
                  <select name="status" class="form-control select2 required-input" id="status">
                     <option value="Active">Active</option>
                     <option value="Inactive">Inactive</option>
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

      <!-- Main content -->
      <div class="card p-0 mt-4 w-100">
        <div class="">

          <div class="table-responsive text-nowrap">
            <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table table-striped" style="border-collapse: collapse;" border-color="#e1e1e1" id="process">
              <thead>
                 <tr>
                    <!-- <th>Sr No</th> -->
                    <th>Group Name</th>
                    <th>Group Code</th>
                    <th>Status</th>
                    <th>Action</th>
                 </tr>
              </thead>
              <tbody>
                 <%if ($groups) %>
                      <%assign var='i' value= 1 %>
                      <%foreach from=$groups item=u %>
                     <tr>
                        <!-- <td><%$i %></td> -->
                        <td><a href="<%base_url('group_menu')%>?id=<%$u['group_master_id']%>"><%$u['group_name'] %></a></td>
                        <td><%$u['group_code'] %></td>
                        <td style="color: <%if $u['status']|lower eq 'active'%>#006400<%else%>#C6011F<%/if%>; font-weight: bold;"><%$u['status']|capitalize %></td>
                        <td>
                          
                        	<a type="button" class="text-primary me-2" data-bs-toggle="modal" data-bs-target="#updateGroup<%$i %>" title="Edit">
					       		<i class="bx bx-edit-alt fs-4" ></i>
					        </a>
                            <a href="javascript:void(0)" class="text-danger" title="Delete"><i class="bx bx-trash fs-4"></i></a>
                        	
                        	<div class="modal fade" id="updateGroup<%$i %>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
						         <div class="modal-dialog  modal-dialog-centered" role="document">
						            <div class="modal-content">
						               <div class="modal-header">
						                  <h5 class="modal-title" id="exampleModalLabel">Update Group</h5>
						                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">

						                  </button>
						               </div>
						               <form action="<%base_url('user/user/updateGroupMaster')%>" method="POST" enctype="multipart/form-data" id="update_group<%$i %>" class="update_group update_group<%$i %> custom-form">
						               	<input type="hidden" name="group_master_id" value="<%$u['group_master_id']%>">
						               <div class="modal-body">
						                  <div class="form-group">
						                  </div>
						                  <div class="form-group">
						                  	<label for="on click url">Group Name<span class="text-danger">*</span></label> <br>
						                  	<input  type="text" name="group_name" placeholder="Enter Group Name" class="form-control required-input" value="<%$u['group_name'] %>" >
						                  </div>
						                  <div class="form-group">
						                  	<label for="on click url">Group Code<span class="text-danger">*</span></label> <br>
						                  	<input  type="text" name="group_code" id="group_code" placeholder="Enter Group Code" class="form-control required-input" value="<%$u['group_code'] %>" disabled>
						                  </div>

										   <div class="form-group">
						                  		<label for="on click url">Status<span class="text-danger">*</span></label> <br>
						                  	 	<select name="status" class="form-control select2 required-input" id="status">
								                	<option value="Active" <%if $u['status'] eq 'Active'%>selected<%/if%>>Active</option>
								                	<option value="Inactive" <%if $u['status'] eq 'Inactive'%>selected<%/if%>>Inactive</option>
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
                        </td>
                     </tr>
                  <%assign var='i' value=$i+1 %>
                  <%/foreach%>
                  <%/if%>
              </tbody>
           </table>
          </div>
        </div>
        <!--/ Responsive Table -->
      </div>
      <!-- /.col -->


      <div class="content-backdrop fade"></div>
    </div>


    <script type="text/javascript">
    var base_url = <%$base_url|@json_encode%>
    </script>

    <script src="<%$base_url%>public/js/admin/group_master.js"></script>
