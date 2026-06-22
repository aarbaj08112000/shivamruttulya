<div class="wrapper container-xxl flex-grow-1 container-p-y">
   <div class="d-flex justify-content-between align-items-center mb-4">
      <nav aria-label="breadcrumb">
         <div class="sub-header-left pull-left breadcrumb m-0">
            <h1 class="mb-0">
               Online Payments
               <a hijacked="yes" href="javascript:void(0)" class="backlisting-link" title="Online Payments">
               <i class="ti ti-chevrons-right"></i>
               <em style="color: var(--bs-theme-color-dark) !important;">Payments</em></a>
            </h1>
         </div>
      </nav>
   </div>

   <div class="content-wrapper">
      <section class="content">
         <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
               <div class="card w-100" style="border: none; border-radius: 16px; overflow: hidden; box-shadow: 0 10px 40px rgba(0,0,0,0.08);">
                  <div class="card-body text-center py-5 px-4">
                     <!-- Animated Gears Icon -->
                     <div class="wip-icon-wrapper mb-4">
                        <div class="wip-gears">
                           <i class="ti ti-settings" style="font-size: 64px; color: var(--bs-theme-color); animation: spin 4s linear infinite;"></i>
                           <i class="ti ti-settings-2" style="font-size: 40px; color: var(--bs-theme-color-dark); animation: spin-reverse 3s linear infinite; position: relative; top: -20px; left: -10px;"></i>
                        </div>
                     </div>

                     <!-- Title -->
                     <h2 style="font-weight: 700; color: var(--bs-theme-color-dark); margin-bottom: 12px; font-size: 28px;">
                        Work in Progress
                     </h2>

                     <!-- Subtitle -->
                     <p style="color: #7c8293; font-size: 16px; max-width: 480px; margin: 0 auto 30px auto; line-height: 1.7;">
                        The <strong>Online Payments</strong> module is currently under development. We're working hard to bring you a seamless payment tracking experience.
                     </p>

                     <!-- Progress Bar -->
                     <div class="mx-auto mb-4" style="max-width: 360px;">
                        <div class="d-flex justify-content-between mb-2">
                           <small style="color: #7c8293; font-weight: 600;">Development Progress</small>
                           <small style="color: var(--bs-theme-color-dark); font-weight: 700;">30%</small>
                        </div>
                        <div class="progress" style="height: 10px; border-radius: 20px; background: #f0ebe4;">
                           <div class="progress-bar progress-bar-striped progress-bar-animated" role="progressbar"
                                style="width: 30%; background: linear-gradient(135deg, var(--bs-theme-color), var(--bs-theme-color-dark)); border-radius: 20px;"
                                aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                     </div>

                     <!-- Feature Chips -->
                     <div class="d-flex flex-wrap justify-content-center gap-2 mb-4">
                        <span class="badge rounded-pill px-3 py-2" style="background: rgba(161,143,114,0.12); color: var(--bs-theme-color-dark); font-size: 12px; font-weight: 600;">
                           <i class="ti ti-check me-1" style="color: #28a745;"></i> Database Schema Ready
                        </span>
                        <span class="badge rounded-pill px-3 py-2" style="background: rgba(161,143,114,0.12); color: var(--bs-theme-color-dark); font-size: 12px; font-weight: 600;">
                           <i class="ti ti-loader me-1" style="color: #ffc107;"></i> API Integration
                        </span>
                        <span class="badge rounded-pill px-3 py-2" style="background: rgba(161,143,114,0.12); color: var(--bs-theme-color-dark); font-size: 12px; font-weight: 600;">
                           <i class="ti ti-clock me-1" style="color: #6c757d;"></i> UI Components
                        </span>
                        <span class="badge rounded-pill px-3 py-2" style="background: rgba(161,143,114,0.12); color: var(--bs-theme-color-dark); font-size: 12px; font-weight: 600;">
                           <i class="ti ti-clock me-1" style="color: #6c757d;"></i> Payment Gateway
                        </span>
                     </div>

                     <!-- Back Button -->
                     <a href="<%$base_url%>dashboard" class="btn px-4 py-2" style="background-color: var(--bs-theme-color-dark); color: white; border: none; border-radius: 8px; font-weight: 600;">
                        <i class="ti ti-arrow-left me-2"></i> Back to Dashboard
                     </a>
                  </div>
               </div>
            </div>
         </div>
      </section>
   </div>
</div>
</div>

<style>
@keyframes spin {
   from { transform: rotate(0deg); }
   to { transform: rotate(360deg); }
}
@keyframes spin-reverse {
   from { transform: rotate(360deg); }
   to { transform: rotate(0deg); }
}
.wip-gears {
   display: inline-block;
   position: relative;
   padding: 20px;
}
</style>
