$(document).ready(function() {
    page.init();
});

var table = '';
var file_name = "expense_list";
var pdf_title = "Expense List";

const page = {
    init: function() {
        this.dataTable();
        this.filter();
        this.formValidation();
        this.editExpense();
        this.deleteExpense();
    },
    dataTable: function(){
        table = new DataTable("#expense_management_table", {
            dom: "Bfrtilp",
            buttons: [
              {     
                    extend: 'csv',
                    text: '<i class="ti ti-file-type-csv"></i>',
                    init: function(api, node, config) {
                        $(node).attr('title', 'Download CSV');
                    },
                    filename : file_name,
                    exportOptions: {
                        columns: ':visible:not(:last-child)'
                    }
              },  
              {
                    extend: 'pdf',
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    init: function(api, node, config) {
                        $(node).attr('title', 'Download Pdf');
                    },
                    filename: file_name,
                    exportOptions: {
                        columns: ':visible:not(:last-child)'
                    },
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = pdf_title;
                        if(doc.content[1] && doc.content[1].table) {
                            doc.content[1].table.body[0].forEach(function(cell) {
                                cell.fillColor = '#8B5E3C';
                            });
                        }
                    }
              },
            ],
            orderCellsTop: true,
            fixedHeader: true,
            lengthMenu: page_length_arr,
            columns: column_details,
            processing: true,
            serverSide: is_serverSide,
            searching: is_searching_enable,
            ordering: is_ordering,
            bSort: true,
            orderMulti: false,
            pagingType: "full_numbers",
            scrollCollapse: true,
            scrollX: true,
            scrollY: true,
            paging: is_paging_enable,
            info: true,
            autoWidth: true,
            lengthChange: true,
            order: sorting_column,
            ajax: {
                url: "expense/expense/get_expense_list",
                type: "POST",
            }
        });
        
        $('.dataTables_length').find('label').contents().filter(function() {
            return this.nodeType === 3;
        }).remove();
        
        table.on('init.dt', function() {
            $(".dataTables_length select").select2({
                minimumResultsForSearch: Infinity
            });
        });
        
        $('#serarch-filter-input').on('keyup', function() {
            table.search(this.value).draw();
        });

        $('#downloadCSVBtn').off('click').on('click', function() {
            table.button('.buttons-csv').trigger();
        });
        
        $('#downloadPDFBtn').off('click').on('click', function() {
            table.button('.buttons-pdf').trigger();
        });

        $('.dt-buttons').hide();
        $('.dataTables_filter').hide();
    },
    filter: function(){
        let that = this;
        $(".search-filter").on("click",function(){
            table.destroy(); 
            that.dataTable();
            $(".close-filter-btn").trigger( "click" )
        })
        $(".reset-filter").on("click",function(){
            that.resetFilter();
        })
    },
    resetFilter: function(){
        $("#serarch-filter-input").val("");
        table.destroy(); 
        this.dataTable();
    },
    formValidation: function() {
        $("#addExpenseForm").validate({
            rules: {
                shop_id: "required",
                category_id: "required",
                amount: "required",
                expense_date: "required"
            },
            messages: {
                shop_id: "Select a shop",
                category_id: "Select a category",
                amount: "Enter amount",
                expense_date: "Select date"
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("invalid-feedback");
                element.closest(".col-12, .col-6").append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass("is-invalid");
            },
            submitHandler: function(form) {
                var url = $(form).attr('action');
                var formData = $(form).serialize();
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer .btn-primary, .offcanvas-footer button:contains("Save")');
                var originalText = submitBtn.html();
                
                submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

                $.ajax({
                    type: "POST",
                    url: url,
                    data: formData,
                    dataType: "json",
                    success: function(response) {
                        submitBtn.html(originalText).prop('disabled', false);
                        
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            $('#addExpenseOffcanvas').offcanvas('hide');
                            form.reset();
                            table.ajax.reload(null, false);
                        } else {
                            toaster("error", response.msg);
                        }
                    },
                    error: function() {
                        submitBtn.html(originalText).prop('disabled', false);
                        toaster("error", "An error occurred while processing your request.");
                    }
                });
            }
        });

        $("#editExpenseForm").validate({
            rules: {
                shop_id: "required",
                category_id: "required",
                amount: "required",
                expense_date: "required"
            },
            messages: {
                shop_id: "Select a shop",
                category_id: "Select a category",
                amount: "Enter amount",
                expense_date: "Select date"
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("invalid-feedback");
                element.closest(".col-12, .col-6").append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass("is-invalid");
            },
            submitHandler: function(form) {
                var url = $(form).attr('action');
                var formData = $(form).serialize();
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer .btn-primary, .offcanvas-footer button:contains("Save")');
                var originalText = submitBtn.html();
                
                submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

                $.ajax({
                    type: "POST",
                    url: url,
                    data: formData,
                    dataType: "json",
                    success: function(response) {
                        submitBtn.html(originalText).prop('disabled', false);
                        
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            $('#editExpenseOffcanvas').offcanvas('hide');
                            form.reset();
                            table.ajax.reload(null, false);
                        } else {
                            toaster("error", response.msg);
                        }
                    },
                    error: function() {
                        submitBtn.html(originalText).prop('disabled', false);
                        toaster("error", "An error occurred while processing your request.");
                    }
                });
            }
        });
    },
    editExpense: function() {
        $(document).on('click', '.edit-expense', function() {
            var expense_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'expense/expense/get_expense_details',
                type: 'POST',
                data: { id: expense_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#edit_expense_id').val(data.id);
                        $('#edit_shop_id').val(data.shop_id);
                        $('#edit_category_id').val(data.category_id);
                        $('#edit_amount').val(data.amount);
                        $('#edit_expense_date').val(data.expense_date);
                        $('#edit_description').val(data.description);
                        $('#edit_status').val(data.status);
                        
                        // Clear validation states
                        var form = $('#editExpenseForm');
                        form.validate().resetForm();
                        form.find('.is-invalid').removeClass('is-invalid');
                        
                        // Show offcanvas
                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('editExpenseOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching expense details.');
                }
            });
        });
    },
    deleteExpense: function() {
        $(document).on('click', '.delete-expense', function() {
            var expense_id = $(this).data('id');
            
            swal({
                title: 'Are you sure?',
                text: "You want to delete this expense?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: base_url + 'expense/expense/delete_expense_action',
                        type: 'POST',
                        data: { id: expense_id },
                        dataType: 'json',
                        success: function(response) {
                            if (response.success == 1) {
                                swal(
                                    'Deleted!',
                                    response.msg,
                                    'success'
                                );
                                table.ajax.reload(null, false);
                            } else {
                                swal(
                                    'Failed!',
                                    response.msg,
                                    'error'
                                );
                            }
                        },
                        error: function() {
                            swal(
                                'Error!',
                                'An error occurred while processing your request.',
                                'error'
                            );
                        }
                    });
                }
            });
        });
    }
};
