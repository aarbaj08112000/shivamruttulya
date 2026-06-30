$(document).ready(function() {
    page.init();
});

var table = '';
var file_name = "franchise_list";
var pdf_title = "Franchise List";

const page = {
    init: function() {
        this.dataTable();
        this.filter();
        this.formValidation();
        this.editFranchise();
        this.deleteFranchise();
        this.viewFranchise();
    },
    dataTable: function(){
        table = new DataTable("#franchise_management_table", {
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
                url: "franchise/franchise/get_franchise_list",
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
        $("#addFranchiseForm").validate({
            rules: {
                franchise_name: "required",
                owner_name: "required",
                mobile: "required"
            },
            messages: {
                franchise_name: "Enter franchise name",
                owner_name: "Enter owner name",
                mobile: "Enter mobile"
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
                            $('#addFranchiseOffcanvas').offcanvas('hide');
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

        $("#editFranchiseForm").validate({
            rules: {
                franchise_name: "required",
                owner_name: "required",
                mobile: "required"
            },
            messages: {
                franchise_name: "Enter franchise name",
                owner_name: "Enter owner name",
                mobile: "Enter mobile"
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
                            $('#editFranchiseOffcanvas').offcanvas('hide');
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
    editFranchise: function() {
        $(document).on('click', '.edit-franchise', function() {
            var franchise_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'franchise/franchise/get_franchise_details',
                type: 'POST',
                data: { id: franchise_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#edit_franchise_id').val(data.id);
                        $('#edit_franchise_code').val(data.franchise_code);
                        $('#edit_franchise_name').val(data.franchise_name);
                        $('#edit_owner_name').val(data.owner_name);
                        $('#edit_mobile').val(data.mobile);
                        $('#edit_email').val(data.email);
                        $('#edit_joining_date').val(data.joining_date);
                        $('#edit_address').val(data.address);
                        $('#edit_status').val(data.status);
                        
                        // Clear validation states
                        var form = $('#editFranchiseForm');
                        form.validate().resetForm();
                        form.find('.is-invalid').removeClass('is-invalid');
                        
                        // Show offcanvas
                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('editFranchiseOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching franchise details.');
                }
            });
        });
    },
    deleteFranchise: function() {
        $(document).on('click', '.delete-franchise', function() {
            var franchise_id = $(this).data('id');
            
            swal({
                title: 'Are you sure?',
                text: "You want to delete this franchise?",
                type: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.value) {
                    $.ajax({
                        url: base_url + 'franchise/franchise/delete_franchise_action',
                        type: 'POST',
                        data: { id: franchise_id },
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
    },
    viewFranchise: function() {
        $(document).on('click', '.view-franchise', function() {
            var franchise_id = $(this).data('id');
            
            $.ajax({
                url: base_url + 'franchise/franchise/get_franchise_details',
                type: 'POST',
                data: { id: franchise_id },
                dataType: 'json',
                success: function(response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#view_franchise_code').text(data.franchise_code || '-');
                        $('#view_joining_date').text(data.joining_date ? new Date(data.joining_date).toLocaleDateString('en-GB', {day:'2-digit', month:'short', year:'numeric'}) : '-');
                        $('#view_franchise_name').text(data.franchise_name || '-');
                        $('#view_owner_name').text(data.owner_name || '-');
                        $('#view_mobile').text(data.mobile || '-');
                        $('#view_email').text(data.email || '-');
                        $('#view_address').text(data.address || '-');
                        
                        var statusHtml = (data.status == 'active') ? '<span class="text-success fw-bold">Active</span>' : '<span class="text-danger fw-bold">Inactive</span>';
                        $('#view_status').html(statusHtml);
                        
                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('viewFranchiseOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg);
                    }
                },
                error: function() {
                    toaster('error', 'An error occurred while fetching franchise details.');
                }
            });
        });
    }
};
