<div class="container-xxl flex-grow-1 container-p-y">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">App Version & APK Upload</h5>
                </div>
                <div class="card-body mt-4">
                    <form id="apkUploadForm" enctype="multipart/form-data">
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label" for="latest_version">Latest Version <span class="text-danger">*</span></label>
                                <input type="text" id="latest_version" name="latest_version" class="form-control" value="<%$latest_version%>" required />
                                <small class="text-muted">Auto-incremented from last release.</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="minimum_version">Minimum Version <span class="text-danger">*</span></label>
                                <input type="text" id="minimum_version" name="minimum_version" class="form-control" value="<%$minimum_version%>" required />
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label">Force Update</label>
                                <div class="mt-2">
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="force_update" id="force_update_yes" value="1" checked />
                                        <label class="form-check-label" for="force_update_yes">True</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="force_update" id="force_update_no" value="0" />
                                        <label class="form-check-label" for="force_update_no">False</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="apk_file">Upload APK File <span class="text-danger">*</span></label>
                                <input class="form-control" type="file" id="apk_file" name="apk_file" accept=".apk" required />
                                <small class="text-muted">Filename will be saved as: shiv-amruttulya-v&lt;latest_version&gt;.apk</small>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-12">
                                <label class="form-label" for="update_message">Update Message</label>
                                <textarea class="form-control" id="update_message" name="update_message" rows="3" placeholder="Enter release notes or update details...">A new version is available. Please update to continue.</textarea>
                            </div>
                        </div>

                        <div class="text-end">
                            <button type="button" id="btnUpload" class="btn btn-success">Upload & Save</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $('#btnUpload').on('click', function(e) {
            e.preventDefault();
            
            // Basic validation
            if ($('#latest_version').val() === '') {
                toastr.error('Latest Version is required.');
                return;
            }
            if ($('#minimum_version').val() === '') {
                toastr.error('Minimum Version is required.');
                return;
            }
            if ($('#apk_file')[0].files.length === 0) {
                toastr.error('Please select an APK file.');
                return;
            }

            var formData = new FormData($('#apkUploadForm')[0]);
            
            // Show loader if any
            $('.main-loader-box').show();

            $.ajax({
                url: '<%$base_url%>app_version/upload_apk',
                type: 'POST',
                data: formData,
                contentType: false,
                processData: false,
                dataType: 'json',
                success: function(response) {
                    $('.main-loader-box').hide();
                    if (response.success == 1) {
                        toastr.success(response.msg);
                        setTimeout(function() {
                            window.location.reload();
                        }, 1500);
                    } else {
                        toastr.error(response.msg);
                    }
                },
                error: function() {
                    $('.main-loader-box').hide();
                    toastr.error('An unexpected error occurred. Please try again.');
                }
            });
        });
    });
</script>
