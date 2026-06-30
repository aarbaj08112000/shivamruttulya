<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Collection vs Expense Report
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Reports" >
               <i class="ti ti-chevrons-right" ></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Reports</em></a>
            </h1>
         </div>
      </nav>
      <div class="d-flex align-items-center gap-2">
         <select class="form-select theme-dropdown" id="month-filter-input" style="width: 200px; border-color: var(--bs-theme-color); color: var(--bs-theme-color); border-radius: 16px; font-weight: 500;">
            <%foreach from=$months item=m%>
                <option value="<%$m.month_year%>" <%if $m.month_year == $current_month%>selected<%/if%>><%$m.month_year%></option>
            <%/foreach%>
         </select>
         <input type="text" name="reason" placeholder="Filter Search" class="form-control serarch-filter-input m-0" id="serarch-filter-input" style="width: 250px;">
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadCSVBtn" title="Download CSV"><i class="ti ti-file-type-csv fs-4"></i></button>
         <button class="btn" style="background-color: var(--bs-theme-color) !important; color: white !important; border: none;" type="button" id="downloadPDFBtn" title="Download PDF"><i class="ti ti-file-type-pdf fs-4"></i></button>
      </div>
   </div>

   <div class="content-wrapper">
      <section class="content">
         <div>
            <div class="row">
               <div class="col-lg-12">
                  <div class="card w-100 table-card">
                     <div class="table-responsive text-nowrap">
                         <table id="report_table" class="table table-striped table-hover w-100" style="border-collapse: collapse;">
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
               </div>
            </div>
         </div>
      </section>
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
    var base_url = <%$base_url|json_encode%>;
</script>
<script src="<%$base_url%>public/js/reports/collection_vs_expense.js?v=<%time()%>"></script>
