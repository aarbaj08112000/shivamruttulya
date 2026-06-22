$(document).ready(function() { page.init(); });

var table = '';
var file_name = "collection_vs_expense_report";
var pdf_title = "Collection vs Expense Report";

const page = {
    init: function() {
        this.dataTable();
    },
    dataTable: function(){
        table = new DataTable("#report_table", {
            dom: "Bfrtilp",
            buttons: [
              { extend: 'csv', text: '<i class="ti ti-file-type-csv"></i>', filename: file_name },
              { extend: 'pdf', text: '<i class="ti ti-file-type-pdf"></i>', filename: file_name,
                customize: function(doc) { 
                    doc.pageMargins = [15,15,15,15]; 
                    doc.content[0].text = pdf_title; 
                    if(doc.content[1]&&doc.content[1].table){
                        doc.content[1].table.body[0].forEach(function(c){c.fillColor='#8B5E3C';});
                    } 
                }
              }
            ],
            orderCellsTop: true, fixedHeader: true, lengthMenu: page_length_arr,
            columns: column_details, processing: true, serverSide: is_serverSide,
            searching: is_searching_enable, ordering: is_ordering, bSort: true,
            orderMulti: false, pagingType: "full_numbers", scrollCollapse: true,
            scrollX: true, scrollY: true, paging: is_paging_enable, info: true,
            autoWidth: true, lengthChange: true, order: sorting_column,
            ajax: { 
                url: base_url + "reports/reports/get_collection_vs_expense_list", 
                type: "POST",
                data: function(d) {
                    d.month_filter = $('#month-filter-input').val();
                }
            }
        });
        $('.dataTables_length').find('label').contents().filter(function() { return this.nodeType === 3; }).remove();
        table.on('init.dt', function() { $(".dataTables_length select").select2({ minimumResultsForSearch: Infinity }); });
        $('#serarch-filter-input').on('keyup', function() { table.search(this.value).draw(); });
        $('#month-filter-input').on('change', function() { table.ajax.reload(); });
        $('#downloadCSVBtn').off('click').on('click', function() { table.button('.buttons-csv').trigger(); });
        $('#downloadPDFBtn').off('click').on('click', function() { table.button('.buttons-pdf').trigger(); });
        $('.dt-buttons').hide();
        $('.dataTables_filter').hide();
    }
};
