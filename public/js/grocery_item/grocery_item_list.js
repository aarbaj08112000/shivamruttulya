$(document).ready(function() {
    page.init();
});

var table = '';
var file_name = "grocery_item_list";
var pdf_title = "Grocery Item List";

const page = {
    init: function() {
        this.dataTable();
        this.filter();
        this.formValidation();
        this.editItem();
        this.deleteItem();
    },
    dataTable: function(){
        table = new DataTable("#item_management_table", {
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
                        // doc.content[0].color = theme_color;
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
                url: "grocery_item/grocery_item/get_grocery_item_list",
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

        // Hide default DataTables buttons and search since we have custom ones
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
        $("#addItemForm").validate({
            rules: {
                item_name: "required",
                category_id: "required",
                unit: "required"
            },
            messages: {
                item_name: "Please enter the item name",
                category_id: "Please select a category",
                unit: "Please enter the unit"
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
                            $('#addItemOffcanvas').offcanvas('hide');
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

        $("#editItemForm").validate({
            rules: {
                item_name: "required",
                category_id: "required",
                unit: "required"
            },
            messages: {
                item_name: "Please enter the item name",
                category_id: "Please select a category",
                unit: "Please enter the unit"
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
                            $('#editItemOffcanvas').offcanvas('hide');
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
    editItem: function() {
        $(document).on('click', '.edit-item', function() {
            var item_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'grocery_item/grocery_item/get_grocery_item_details',
                type: 'POST',
                data: { id: item_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#edit_item_id').val(data.id);
                        $('#edit_item_name').val(data.item_name);
                        $('#edit_category_id').val(data.category_id);
                        $('#edit_unit').val(data.unit);
                        $('#edit_status').val(data.status);
                        
                        // Clear validation states
                        var form = $('#editItemForm');
                        form.validate().resetForm();
                        form.find('.is-invalid').removeClass('is-invalid');
                        
                        // Show offcanvas
                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('editItemOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching item details.');
                }
            });
        });
    },
    deleteItem: function() {
        $(document).on('click', '.delete-item', function() {
            var item_id = $(this).data('id');
            
            swal({
                title: 'Are you sure?',
                text: "You want to delete this item?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: base_url + 'grocery_item/grocery_item/delete_grocery_item_action',
                        type: 'POST',
                        data: { id: item_id },
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
