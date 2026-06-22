$(document).ready(function() { page.init(); });

var table = '';
var file_name = "daily_collection_list";
var pdf_title = "Daily Collection List";

const page = {
    init: function() {
        this.dataTable();
        this.filter();
        this.formValidation();
        this.editCollection();
        this.deleteCollection();
        this.calculations();
    },
    calculations: function() {
        $('.calc-add').on('input', function() {
            var cash = parseFloat($('#add_cash_amount').val()) || 0;
            var online = parseFloat($('#add_online_amount').val()) || 0;
            $('#add_total_amount').val((cash + online).toFixed(2));
        });
        $('.calc-edit').on('input', function() {
            var cash = parseFloat($('#edit_cash_amount').val()) || 0;
            var online = parseFloat($('#edit_online_amount').val()) || 0;
            $('#edit_total_amount').val((cash + online).toFixed(2));
        });
    },
    dataTable: function(){
        table = new DataTable("#collection_management_table", {
            dom: "Bfrtilp",
            buttons: [
              { extend: 'csv', text: '<i class="ti ti-file-type-csv"></i>', filename: file_name, exportOptions: { columns: ':visible:not(:last-child)' } },
              { extend: 'pdf', text: '<i class="ti ti-file-type-pdf"></i>', filename: file_name, exportOptions: { columns: ':visible:not(:last-child)' },
                customize: function(doc) { doc.pageMargins = [15,15,15,15]; doc.content[0].text = pdf_title; if(doc.content[1]&&doc.content[1].table){doc.content[1].table.body[0].forEach(function(c){c.fillColor='#8B5E3C';});} }
              }
            ],
            orderCellsTop: true, fixedHeader: true, lengthMenu: page_length_arr,
            columns: column_details, processing: true, serverSide: is_serverSide,
            searching: is_searching_enable, ordering: is_ordering, bSort: true,
            orderMulti: false, pagingType: "full_numbers", scrollCollapse: true,
            scrollX: true, scrollY: true, paging: is_paging_enable, info: true,
            autoWidth: true, lengthChange: true, order: sorting_column,
            ajax: { url: "daily_collection/daily_collection/get_daily_collection_list", type: "POST" }
        });
        $('.dataTables_length').find('label').contents().filter(function() { return this.nodeType === 3; }).remove();
        table.on('init.dt', function() { $(".dataTables_length select").select2({ minimumResultsForSearch: Infinity }); });
        $('#serarch-filter-input').on('keyup', function() { table.search(this.value).draw(); });
        $('#downloadCSVBtn').off('click').on('click', function() { table.button('.buttons-csv').trigger(); });
        $('#downloadPDFBtn').off('click').on('click', function() { table.button('.buttons-pdf').trigger(); });
        $('.dt-buttons').hide();
        $('.dataTables_filter').hide();
    },
    filter: function(){
        let that = this;
        $(".search-filter").on("click", function(){ table.destroy(); that.dataTable(); $(".close-filter-btn").trigger("click"); });
        $(".reset-filter").on("click", function(){ that.resetFilter(); });
    },
    resetFilter: function(){ $("#serarch-filter-input").val(""); table.destroy(); this.dataTable(); },
    formValidation: function() {
        var validationConfig = {
            rules: { shop_id: "required", collection_date: "required", cash_amount: "required", online_amount: "required" },
            messages: { shop_id: "Select a shop", collection_date: "Select date", cash_amount: "Enter cash amount", online_amount: "Enter online amount" },
            errorElement: "span",
            errorPlacement: function(error, element) { error.addClass("invalid-feedback"); element.closest(".col-12, .col-4").append(error); },
            highlight: function(element) { $(element).addClass("is-invalid"); },
            unhighlight: function(element) { $(element).removeClass("is-invalid"); }
        };

        $("#addCollectionForm").validate($.extend({}, validationConfig, {
            submitHandler: function(form) {
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer button:last');
                var originalText = submitBtn.html();
                submitBtn.html('<span class="spinner-border spinner-border-sm"></span> Saving...').prop('disabled', true);
                $.ajax({ type: "POST", url: $(form).attr('action'), data: $(form).serialize(), dataType: "json",
                    success: function(r) {
                        submitBtn.html(originalText).prop('disabled', false);
                        if (r.success == 1) { toaster("success", r.msg); $('#addCollectionOffcanvas').offcanvas('hide'); form.reset(); table.ajax.reload(null, false); }
                        else { toaster("error", r.msg); }
                    },
                    error: function() { submitBtn.html(originalText).prop('disabled', false); toaster("error", "An error occurred."); }
                });
            }
        }));

        $("#editCollectionForm").validate($.extend({}, validationConfig, {
            submitHandler: function(form) {
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer button:last');
                var originalText = submitBtn.html();
                submitBtn.html('<span class="spinner-border spinner-border-sm"></span> Saving...').prop('disabled', true);
                $.ajax({ type: "POST", url: $(form).attr('action'), data: $(form).serialize(), dataType: "json",
                    success: function(r) {
                        submitBtn.html(originalText).prop('disabled', false);
                        if (r.success == 1) { toaster("success", r.msg); $('#editCollectionOffcanvas').offcanvas('hide'); form.reset(); table.ajax.reload(null, false); }
                        else { toaster("error", r.msg); }
                    },
                    error: function() { submitBtn.html(originalText).prop('disabled', false); toaster("error", "An error occurred."); }
                });
            }
        }));
    },
    editCollection: function() {
        $(document).on('click', '.edit-collection', function() {
            var id = $(this).data('id');
            $.ajax({ url: base_url + 'daily_collection/daily_collection/get_daily_collection_details', type: 'POST', data: { id: id }, dataType: 'json',
                success: function(r) {
                    if (r.success == 1) {
                        var d = r.data;
                        $('#edit_collection_id').val(d.id);
                        $('#edit_shop_id').val(d.shop_id);
                        $('#edit_collection_date').val(d.collection_date);
                        $('#edit_cash_amount').val(d.cash_amount);
                        $('#edit_online_amount').val(d.online_amount);
                        $('#edit_total_amount').val(d.total_amount);
                        $('#edit_status').val(d.status);
                        var form = $('#editCollectionForm');
                        form.validate().resetForm();
                        form.find('.is-invalid').removeClass('is-invalid');
                        new bootstrap.Offcanvas(document.getElementById('editCollectionOffcanvas')).show();
                    } else { toaster('error', r.msg); }
                },
                error: function() { toaster('error', 'Failed to fetch details.'); }
            });
        });
    },
    deleteCollection: function() {
        $(document).on('click', '.delete-collection', function() {
            var id = $(this).data('id');
            swal({ title: 'Are you sure?', text: "You want to delete this collection?", type: 'warning', showCancelButton: true, confirmButtonColor: '#3085d6', cancelButtonColor: '#d33', confirmButtonText: 'Yes, delete it!' }).then((result) => {
                if (result.value) {
                    $.ajax({ url: base_url + 'daily_collection/daily_collection/delete_daily_collection_action', type: 'POST', data: { id: id }, dataType: 'json',
                        success: function(r) { if (r.success == 1) { swal('Deleted!', r.msg, 'success'); table.ajax.reload(null, false); } else { swal('Failed!', r.msg, 'error'); } },
                        error: function() { swal('Error!', 'An error occurred.', 'error'); }
                    });
                }
            });
        });
    }
};
