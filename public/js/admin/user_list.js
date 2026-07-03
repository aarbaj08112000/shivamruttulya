$(document).ready(function () {
    page.init();
});

var table = '';
var file_name = 'user_list';
var pdf_title = 'User List';

const page = {
    init: function () {
        this.dataTable();
        this.filter();
        this.viewUser();
        this.editUser();
    },

    dataTable: function () {
        table = new DataTable('#erp_users', {
            dom: 'Bfrtilp',
            buttons: [
                {
                    extend: 'csv',
                    text: '<i class="ti ti-file-type-csv"></i>',
                    init: function (api, node, config) {
                        $(node).attr('title', 'Download CSV');
                    },
                    filename: file_name,
                    exportOptions: {
                        columns: ':visible:not(:last-child)'
                    }
                },
                {
                    extend: 'pdf',
                    text: '<i class="ti ti-file-type-pdf"></i>',
                    init: function (api, node, config) {
                        $(node).attr('title', 'Download PDF');
                    },
                    filename: file_name,
                    exportOptions: {
                        columns: ':visible:not(:last-child)'
                    },
                    customize: function (doc) {
                        doc.pageMargins = [15, 15, 15, 15];
                        doc.content[0].text = pdf_title;
                        if (doc.content[1] && doc.content[1].table) {
                            doc.content[1].table.body[0].forEach(function (cell) {
                                cell.fillColor = '#8B5E3C';
                            });
                        }
                    }
                }
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
            pagingType: 'full_numbers',
            scrollCollapse: true,
            scrollX: true,
            scrollY: true,
            paging: is_paging_enable,
            info: true,
            autoWidth: true,
            lengthChange: true,
            order: sorting_column,
            ajax: {
                url: base_url + 'user/user/get_user_list',
                type: 'POST'
            }
        });

        // Remove extra label text from length dropdown
        $('.dataTables_length').find('label').contents().filter(function () {
            return this.nodeType === 3;
        }).remove();

        table.on('init.dt', function () {
            $('.dataTables_length select').select2({
                minimumResultsForSearch: Infinity
            });
        });

        // Custom search input
        $('#serarch-filter-input').on('keyup', function () {
            table.search(this.value).draw();
        });

        // CSV / PDF buttons
        $('#downloadCSVBtn').off('click').on('click', function () {
            table.button('.buttons-csv').trigger();
        });

        $('#downloadPDFBtn').off('click').on('click', function () {
            table.button('.buttons-pdf').trigger();
        });

        // Hide default DT controls
        $('.dt-buttons').hide();
        $('.dataTables_filter').hide();
    },

    filter: function () {
        let that = this;
        $('.search-filter').on('click', function () {
            table.destroy();
            that.dataTable();
            $('.close-filter-btn').trigger('click');
        });
        $('.reset-filter').on('click', function () {
            that.resetFilter();
        });
    },

    resetFilter: function () {
        $('#serarch-filter-input').val('');
        table.destroy();
        this.dataTable();
    },

    viewUser: function () {
        $(document).on('click', '.view-user', function () {
            var user_id = $(this).data('id');

            $.ajax({
                url: base_url + 'user/user/get_user_details',
                type: 'POST',
                data: { id: user_id },
                dataType: 'json',
                success: function (response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#view_user_name').text(data.user_name || '-');
                        $('#view_user_email').text(data.user_email || '-');
                        $('#view_user_mobile').text(data.mobile || '-');
                        $('#view_user_role').text(data.role_name || '-');
                        $('#view_user_added_date').text(
                            data.added_date
                                ? new Date(data.added_date).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
                                : '-'
                        );

                        var statusColor = data.status === 'active' ? '#006400' : '#C6011F';
                        var statusText  = data.status
                            ? data.status.charAt(0).toUpperCase() + data.status.slice(1).toLowerCase()
                            : '-';
                        $('#view_user_status').html('<span style="color:' + statusColor + '; font-weight:bold;">' + statusText + '</span>');

                        if (data.profile_image) {
                            $('#view_user_profile_image').html(
                                '<img src="' + base_url + 'public/uploads/users/' + data.profile_image +
                                '" alt="Profile Image" width="80" height="80" style="object-fit:cover; border-radius:50%;">'
                            );
                        } else {
                            $('#view_user_profile_image').html('-');
                        }

                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('viewUserOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg || 'Error loading user details.');
                    }
                },
                error: function () {
                    toaster('error', 'An error occurred while loading user details.');
                }
            });
        });
    },

    editUser: function () {
        $(document).on('click', '.edit-user', function () {
            var user_id = $(this).data('id');

            $.ajax({
                url: base_url + 'user/user/get_user_details',
                type: 'POST',
                data: { id: user_id },
                dataType: 'json',
                success: function (response) {
                    if (response.success == 1) {
                        var data = response.data;
                        $('#edit_user_id').val(data.id);
                        $('#edit_user_name').val(data.user_name);
                        $('#edit_user_email').val(data.user_email);
                        $('#edit_user_mobile').val(data.mobile);
                        $('#edit_user_role').val(data.user_role);
                        $('#edit_user_status').val(data.status);

                        // Show profile image preview
                        if (data.profile_image) {
                            $('#edit_profile_image_preview').html(
                                '<img src="' + base_url + 'public/uploads/users/' + data.profile_image +
                                '" alt="Profile" width="50" height="50" style="object-fit:cover; border-radius:50%;" class="mt-2">'
                            );
                        } else {
                            $('#edit_profile_image_preview').html('');
                        }

                        var bsOffcanvas = new bootstrap.Offcanvas(document.getElementById('editUserOffcanvas'));
                        bsOffcanvas.show();
                    } else {
                        toaster('error', response.msg || 'Error loading user details.');
                    }
                },
                error: function () {
                    toaster('error', 'An error occurred while loading user details.');
                }
            });
        });

        // Edit form submit
        $('#editUserForm').on('submit', function (e) {
            e.preventDefault();
            var formData = new FormData(this);

            $.ajax({
                url: $(this).attr('action'),
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function (response) {
                    var res = JSON.parse(response);
                    if (res.success == 1) {
                        toaster('success', res.messages || 'User updated successfully.');
                        bootstrap.Offcanvas.getInstance(document.getElementById('editUserOffcanvas')).hide();
                        table.ajax.reload(null, false);
                    } else {
                        toaster('error', res.messages || 'Failed to update user.');
                    }
                },
                error: function () {
                    toaster('error', 'An error occurred while updating user.');
                }
            });
        });
    }
};

function logoutUser(user_id) {
    swal({
        title: 'Are you sure?',
        text: 'This will log out the user from both web and mobile applications.',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'var(--bs-theme-color-dark)',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, log out!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                url: base_url + 'user/user/logout_user',
                type: 'POST',
                data: { user_id: user_id },
                success: function (response) {
                    let res = JSON.parse(response);
                    if (res.success == 1) {
                        toaster('success', res.message);
                    } else {
                        toaster('error', res.message);
                    }
                }
            });
        }
    });
}

function logoutAllUsers() {
    swal({
        title: 'Are you sure?',
        text: 'This will log out ALL users from both web and mobile applications.',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'var(--bs-theme-color-dark)',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, log out all!'
    }).then((result) => {
        if (result.value) {
            $.ajax({
                url: base_url + 'user/user/logout_all_users',
                type: 'POST',
                success: function (response) {
                    let res = JSON.parse(response);
                    if (res.success == 1) {
                        toaster('success', res.message);
                        setTimeout(function () {
                            window.location.reload();
                        }, 1000);
                    } else {
                        toaster('error', res.message);
                    }
                }
            });
        }
    });
}
