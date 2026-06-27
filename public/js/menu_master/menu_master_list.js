$(document).ready(function() {
    page.init();
});

var table = '';
var file_name = "menu_master_list";
var pdf_title = "Menu Master List";

const page = {
    init: function() {
        this.dataTable();
        this.filter();
        this.formValidation();
        this.editMenu();
        this.deleteMenu();
        this.viewMenu();
    },
    dataTable: function(){
        table = new DataTable("#menu_master_table", {
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
                url: "menu_master/menu_master/get_menu_list",
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
        $("#addMenuForm").validate({
            rules: {
                menu_title: "required",
                price: {
                    required: true,
                    number: true,
                    min: 0
                }
            },
            messages: {
                menu_title: "Please enter the menu title",
                price: {
                    required: "Please enter the price",
                    number: "Please enter a valid number",
                    min: "Price must be zero or greater"
                }
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("invalid-feedback");
                element.closest(".col-6, .col-12").append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass("is-invalid");
            },
            submitHandler: function(form) {
                var url = $(form).attr('action');
                var formData = new FormData(form);
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer button:last');
                var originalText = submitBtn.html();
                
                submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

                $.ajax({
                    type: "POST",
                    url: url,
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function(response) {
                        submitBtn.html(originalText).prop('disabled', false);
                        
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            $('#addMenuOffcanvas').offcanvas('hide');
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

        $("#editMenuForm").validate({
            rules: {
                menu_title: "required",
                price: {
                    required: true,
                    number: true,
                    min: 0
                }
            },
            messages: {
                menu_title: "Please enter the menu title",
                price: {
                    required: "Please enter the price",
                    number: "Please enter a valid number",
                    min: "Price must be zero or greater"
                }
            },
            errorElement: "span",
            errorPlacement: function (error, element) {
                error.addClass("invalid-feedback");
                element.closest(".col-6, .col-12").append(error);
            },
            highlight: function (element, errorClass, validClass) {
                $(element).addClass("is-invalid");
            },
            unhighlight: function (element, errorClass, validClass) {
                $(element).removeClass("is-invalid");
            },
            submitHandler: function(form) {
                var url = $(form).attr('action');
                var formData = new FormData(form);
                var submitBtn = $(form).closest('.offcanvas').find('.offcanvas-footer button:last');
                var originalText = submitBtn.html();
                
                submitBtn.html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...').prop('disabled', true);

                $.ajax({
                    type: "POST",
                    url: url,
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: "json",
                    success: function(response) {
                        submitBtn.html(originalText).prop('disabled', false);
                        
                        if (response.success == 1) {
                            toaster("success", response.msg);
                            $('#editMenuOffcanvas').offcanvas('hide');
                            form.reset();
                            $('#edit_image_preview_box').hide();
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
    viewMenu: function() {
        $(document).on('click', '.view-menu', function() {
            var menu_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'menu_master/menu_master/get_menu_details',
                type: 'POST',
                data: { id: menu_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#view_menu_title').text(data.menu_title || '-');
                        $('#view_price').text('₹ ' + parseFloat(data.price).toFixed(2));
                        $('#view_shop_name').text(data.shop_name || 'All Shops');
                        
                        var statusColor = data.status === 'active' ? '#006400' : '#C6011F';
                        $('#view_status').html('<span style="color: '+statusColor+'; font-weight: bold;">'+data.status.charAt(0).toUpperCase() + data.status.slice(1)+'</span>');
                        
                        $('#view_description').text(data.description || '-');
                        $('#view_added_date').text(data.added_date ? new Date(data.added_date).toLocaleDateString('en-GB', {day:'2-digit', month:'short', year:'numeric'}) : '-');
                        
                        if (data.image_url) {
                            $('#view_image').attr('src', data.image_url);
                            $('#view_image_box').show();
                        } else {
                            $('#view_image_box').hide();
                        }
                        
                        var modal = new bootstrap.Modal(document.getElementById('viewMenuModal'));
                        modal.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching menu details.');
                }
            });
        });
    },
    editMenu: function() {
        $(document).on('click', '.edit-menu', function() {
            var menu_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'menu_master/menu_master/get_menu_details',
                type: 'POST',
                data: { id: menu_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#edit_menu_id').val(data.menu_id);
                        $('#edit_menu_title').val(data.menu_title);
                        $('#edit_price').val(data.price);
                        $('#edit_shop_id').val(data.shop_id || '');
                        $('#edit_status').val(data.status);
                        $('#edit_description').val(data.description);
                        
                        if (data.image_url) {
                            $('#edit_image_preview').attr('src', data.image_url);
                            $('#edit_image_preview_box').show();
                        } else {
                            $('#edit_image_preview_box').hide();
                        }
                        
                        // Clear validation states
                        var form = $('#editMenuForm');
                        form.validate().resetForm();
                        form.find('.is-invalid').removeClass('is-invalid');
                        
                        // Show offcanvas
                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('editMenuOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching menu details.');
                }
            });
        });
    },
    deleteMenu: function() {
        $(document).on('click', '.delete-menu', function() {
            var menu_id = $(this).data('id');
            
            swal({
                title: 'Are you sure?',
                text: "You want to delete this menu item?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: base_url + 'menu_master/menu_master/delete_menu_action',
                        type: 'POST',
                        data: { id: menu_id },
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
