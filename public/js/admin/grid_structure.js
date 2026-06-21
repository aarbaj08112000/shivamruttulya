$(document).ready(function(){
	 grid.init();
})

const grid = {
	init: function(){

	},
	setDefaultView: function(module_name){
		 var default_page_dispay = (typeof default_page_view_type !== 'undefined' && default_page_view_type !== null) ? default_page_view_type[module_name] : 'Table';
		 if(default_page_dispay == "Grid"){
		 	$(".toggle-grid-btn .table").removeClass("active");
		 	$(".toggle-grid-btn .grid").addClass("active");
		 }else{
		 	$(".toggle-grid-btn .grid").removeClass("active");
		 	$(".toggle-grid-btn .table").addClass("active");
		 }
	},
	gridStructure: function(module_name = "",row_data = [],no_data_message){
		let that = this;
		grid_html = "";
		switch (module_name) {
		    case "User":
		    	grid_html = `<div class="container grid-block-container"><div class="row w-100">`;
		    	if(row_data.length > 0){
			        for (var i = 0; i < row_data.length; i++) {
			        	var row_details = row_data[i]._aData;
						var user_details = JSON.parse(row_details[6]);
			        	var status = row_details[4].toLowerCase().includes("active") ? "active" : "inactive";
			        	let row_html = `<div class="col-3">
									        <div class="card mb-4">
									            <div class="grid_view_warehouse">
									               <div class="grid_view_warehouse_box h-auto">
									               		<div class="grid_view_warehouse_title mb-0">
										                    <div class="grid_view_warehouse_title_lt">
										                        <div class="grid_view_warehouse_title_icon">
										                           <div class="status-radius ${status}"></div>
										                           <div class="list-image ma_profile_image d-flex justify-content-center align-items-center" style="width:62px;height:62px;background:#e9ecef;border-radius:50%;"><i class="bx bx-user fs-3"></i></div>
										                        </div>
										                        <div class="grid_view_warehouse_title_cnt p-3">
											                           <h5 class="trim-characters"><a title="${row_details[1]}" href="javascript:void(0)">${row_details[1]}</a></h5>
											                           <h6 class="trim-characters">${row_details[2]}</h6>
											                    </div>
										                    </div>
										                </div>
										            	<div class="grid-types pb-3">
										                     <div class="request_type"><strong>Mobile:</strong> ${row_details[3]}</div>
										                     <div class="other-actions-list-btn mt-0 mr-2">
										                        ${row_details[5]}
										                     </div>
										                </div>
										            </div>
									          	</div>
									        </div>
									    </div>`;
			        	grid_html += row_html;
			        }
		        }else{
		        	grid_html += that.noDataFound(no_data_message);
		        }
		        grid_html += `</div></div>`;
		        break;

		    default:
		        break;
		}

		return grid_html;
	},
	noDataFound: function(no_data_message){
			no_data_html = `<div class="col-12 text-center grid-no-message mt-5 pt-5">${no_data_message}</div>`;
		return no_data_html;
	}
}