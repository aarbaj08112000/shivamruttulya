<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Franchise Partner Enquiries
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Enquiries" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Franchise</em></a>
            </h1>
         </div>
      </nav>

      <div class="d-flex align-items-center gap-2">
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
      </div>
   </div>

   <div class="content-wrapper" >
      <section class="content">
         <div>
            <div class="row">
               <div class="col-lg-12">
                  <div class="card w-100 table-card">
                     <div class="table-responsive text-nowrap">
                         <table id="franchise_enquiries_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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

                     <!-- View Franchise Enquiry Offcanvas -->
                     <div class="offcanvas offcanvas-end" tabindex="-1" id="viewFranchiseEnquiryOffcanvas" aria-labelledby="viewFranchiseEnquiryOffcanvasLabel" style="width: 500px;">
                        <div class="offcanvas-header pb-2" style="border-bottom: 1px solid #eee;">
                           <div>
                              <h5 class="offcanvas-title mb-1" id="viewFranchiseEnquiryOffcanvasLabel" style="color: var(--bs-theme-color-dark); font-weight: bold;">View Enquiry</h5>
                              <p class="text-muted mb-0" style="font-size: 13px;">Franchise Partner details</p>
                           </div>
                           <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                           <h6 class="text-primary mb-3 mt-2" style="font-size: 13px; font-weight: bold;">Enquirer Information</h6>
                           <div class="row mb-3">
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Name</label>
                                 <div id="view_franchise_name" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Mobile</label>
                                 <div id="view_franchise_phone" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Email</label>
                                 <div id="view_franchise_email" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                           </div>
                           
                           <h6 class="text-warning mb-3 mt-4" style="font-size: 13px; font-weight: bold;">Proposal Details</h6>
                           <div class="row mb-3">
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Target City</label>
                                 <div id="view_franchise_city" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-6 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Investment Budget</label>
                                 <div id="view_franchise_budget" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Submitted On</label>
                                 <div id="view_franchise_date" class="fw-bold" style="font-size: 14px;"></div>
                              </div>
                              <div class="col-12 mb-3">
                                 <label class="form-label text-muted" style="font-size: 12px; margin-bottom: 2px;">Message</label>
                                 <div id="view_franchise_message" class="fw-bold p-3 bg-light rounded" style="font-size: 14px; white-space: pre-wrap;"></div>
                              </div>
                           </div>
                        </div>
                        <div class="offcanvas-footer p-3 border-top d-flex justify-content-end bg-white">
                           <button type="button" class="btn btn-outline-secondary px-4" data-bs-dismiss="offcanvas">Close</button>
                        </div>
                     </div>
                     <!-- End View Offcanvas -->
                  </div>
               </div>
            </div>
         </section>
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
</script>

<script src="<%$base_url%>public/js/enquiries/franchise_enquiries.js?v=<%time()%>"></script>
