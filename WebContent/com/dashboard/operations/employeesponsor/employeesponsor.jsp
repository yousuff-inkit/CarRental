<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<% String contextPath=request.getContextPath();%>
<head>
<title>Employee Sponsor</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../floorMgmtIncludes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 



  <style type="text/css">
  	:root {
	    --theme-deafult: #7366ff;
	    --theme-secondary: #f73164;
	}
	@font-face {
  		font-family: Poppins;
  		src: url('../../../../vendors/fonts/Poppins/Poppins-Regular.ttf')  format('truetype');
	}
	body{
		font-family:Poppins;
		font-size:12px;
	}
	input.form-control{
		height:34px !important;
		font-size:12px !important;
	}
	p{
		margin-bottom:0;
		
	}
	.panel-body{
		border:0;
	}
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;
    }
    /*.custompanel .buttoncontainer{
    	clear:both;
    	float:left;
    	display:inline-block;
    }
     .custompanel div{
    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel button{
       border:none;
    }*/
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;
	   background-color:red;
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
	} 
	.comment{
      background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
      color: #000;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
    .textpanel p.h8{
   		margin-top: 4px;
    	margin-bottom: 3px;
    	text-size:10;
    }
    .load-wrapp {
	    float: left;
	    width: 100px;
	    height: 100px;
	    margin: 0 10px 10px 0;
	    padding: 20px 20px 20px;
	    border-radius: 5px;
	    text-align: center;
	    background-color: #fff;
	    position:absolute;
	    z-index:9999;
	    top:50%;
	    left:50%;
	    transform:translate(-50%,-50%);
	    border:1px solid #000;
	}
	.spinner {
	    position: relative;
	    width: 45px;
	    height: 45px;
	    margin: 0 auto;
	}
	
	.bubble-1,
	.bubble-2 {
	    position: absolute;
	    top: 0;
	    width: 25px;
	    height: 25px;
	    border-radius: 100%;
	    
	    background-color: #000;
	}
	
	.bubble-2 {
	    top: auto;
	    bottom: 0;
	}
	.load-9 .spinner {border:none;animation: loadingI 2s linear infinite;}
	.load-9 .bubble-1, .load-9 .bubble-2 {animation: bounce 2s ease-in-out infinite;}
	.load-9 .bubble-2 {animation-delay: -1.0s;}
	@keyframes loadingI {
	    100% {transform: rotate(360deg);}
	}
	
	@keyframes bounce  {
	  0%, 100% {transform: scale(0.0);}
	  50% {transform: scale(1.0);}
	}
	
	.card-item{
		background-color: #fff;
	    padding-left: 10px;
	    padding-right: 10px;
	    border-radius: 4px;
	    padding-top: 1px;
	    padding-bottom: 4px;
	    margin-bottom:8px;
	    box-shadow:0 5px 10px rgba(154,160,185,.05), 0 15px 40px rgba(166,173,201,.2);
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
		box-shadow: 0 2px 4px 0 rgb(62 57 107 / 13%);
		position:relative;
		transition:all 0.3s ease;
		cursor:pointer;
		
	}
	
	.card-item:hover,.card-item.active{
		transform:scale(1.1);
	}
	.card-item.active{
		border-bottom: 5px solid #08ad13;
	}
	.card-item:hover svg,.card-item.active svg {
		transform:rotate(12deg);
	}
	.card-item h2{
		margin-top: 5px;
    	margin-bottom: 5px;
    	color:#fff;
    	display:inline-block;
	}
	.card-item h6{
		color:#fff;
		letter-spacing:0.2px;
		font-weight:200;
		display:inline-block;
	}
	.card-item .progress{
		height: 6px;
    	margin-bottom: 6px;
		background-color:#fff;
	}
	.card-item .progress .progress-bar{
		background-color:var(--theme-secondary);
		opacity:0.7;
	}
	.card-item small{
		color: #f8f9fa;
		display:block;
	}
	.card-item svg.icon-bg{
		position: absolute;right: 2px;
		width: 48px;height:48px;opacity: 0.5;
		transition:all 0.3s ease;
		stroke:#fff;
	}
	button[data-dismiss="modal"] {
		background-color:#fff;
	}
	.modal .well{
		padding:15px;
		margin-bottom:10px;
	}
	.modal .well fieldset legend{
		margin-bottom:10px;
	}
	.help-block{
		margin-bottom:0;
	}
.custom-file-upload {
    padding: 4px 10px;
    background-color: #aeb6bf;
    color: black;
    border-radius: 5px;
    cursor: pointer;
    font-size: 14px;
}

.custom-file-upload:hover {
    /* background-color: #0056b3; */
}

.file-name {
    margin-left: 10px; /* Space between button and file name */
    font-size: 14px;
    color: #333; /* Customize text color */
    font-weight: normal;
}

.rolling-id {
    display: inline-block;
    max-width: 150px;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    vertical-align: middle;
  }
  
  .only-decimals::placeholder {
    direction: ltr;            /* Placeholder left-aligned */
    text-align: left;          /* Placeholder left-aligned */
}
  
  </style>
</head>
<body >
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
  <div class="container-fluid">
    	<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div class=" primarypanel custompanel">
        			<div class="form-group"  style="display:flex; align-items:center; margin: 0px 0px;">
        				<div style="margin-left:4px;">
	        				<select name="cmbtable" id="cmbtable" class="form-control" style="width:250px;"><option value="">--Select--</option></select>
        				</div>
	        			<div style="margin-left:4px;">
	  						<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
	          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	          				<button type="button" class="btn btn-default" id="btnguidlines" data-toggle="tooltip" title="Guidelines" data-placement="bottom"><i class="fa fa-info-circle" aria-hidden="true"></i></button>
	        			</div>
        			</div>
        		</div>
        		<div class="detailpanel custompanel">
          			<button type="button" class="btn btn-default" id="btnlink" ><i class="fa fa-link" aria-hidden="true" data-toggle="tooltip" title="Link Vendor" data-placement="bottom"></i></button>          			
          			<button type="button" class="btn btn-default" id="btndelink" ><i class="fa fa-chain-broken" aria-hidden="true" data-toggle="tooltip" title="Delink Vendor" data-placement="bottom"></i></button>          			
          			<button type="button" class="btn btn-default" id="btntrfset" ><i class="fa fa-sliders" aria-hidden="true" data-toggle="tooltip" title="Tariff Setting" data-placement="bottom"></i></button>          			
        		</div>
        		<div class="textpanel custompanel" style="max-width:300px;height:55px;display:flex;justify-content:center;align-items:center;">
					<p style="word-wrap: break-word;font-size:1.2rem;color:blue;">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="empsponsordiv"><jsp:include page="employeesponsorgrid.jsp"></jsp:include></div>
        		<div id="empsponsortariffdiv"><jsp:include page="employeesponsortariffgrid.jsp"></jsp:include></div>
      		</div>
    	</div>
    	
		<!-- vendor modal -->
    	<div id="modalAssignVendor" class="modal fade " role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Assign Vendor to Emp#<span class="empid rolling-id" ></span></h4>
					</div>
					<div class="modal-body">
						<div class="container-fluid form-horizontal">
    						<div class="form-group">
		    					<label class="control-label col-sm-3" for="cmbvendor">Vendor:</label>
		    					<div class="col-sm-9 control-container">
		      						<select name="cmbvendor" id="cmbvendor" class="form-control" style="width:99%;"><option value="">Please Choose Vendor</option></select>
		    					</div>
		  					</div>
    					</div>
					</div>
					<div class="modal-footer text-right">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            		<button type="button" class="btn btn-default btn-primary" id="btnsaveassignvendor">Save Changes</button>
	          		</div>
				</div>
			</div>
		</div>
		
		<!-- Tariff modal -->
    	<div id="modalTariffSetting" class="modal fade " role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Tariff Setting</h4>
					</div>
					<div class="modal-body">
						<div class="container-fluid form-horizontal">
    						<div class="form-group">
		    					<label class="control-label col-sm-4" for="cmbvendortf">Vendor:</label>
		    					<div class="col-sm-8 control-container">
		      						<select name="cmbvendortf" id="cmbvendortf" class="form-control" style="width:99%;"><option value="">Please Choose Vendor</option></select>
		    					</div>
		  					</div>
		  					<div class="form-group">
		    					<label class="control-label col-sm-4" for="cmbmcr">Monthly car rent:</label>
		    					<div class="col-sm-8 control-container">
		      						<input type="text" name="cmbmcr" id="cmbmcr" class="form-control only-decimals" style="width:99%;text-align: right;" placeholder="Please Enter Monthly car rent">
		    					</div>
		  					</div>
		  					<div class="form-group">
		    					<label class="control-label col-sm-4" for="cmbmbrp">Bike rent(pick up):</label>
		    					<div class="col-sm-8 control-container">
		      						<input type="text" name="cmbmbrp" id="cmbmbrp" class="form-control only-decimals" style="width:99%;text-align: right;" placeholder="Please Enter bike rent(pick up)">
		    					</div>
		  					</div>
		  					<div class="form-group">
		    					<label class="control-label col-sm-4" for="cmbmbrd">Bike rent(drop off):</label>
		    					<div class="col-sm-8 control-container">
		      						<input type="text" name="cmbmbrd" id="cmbmbrd" class="form-control only-decimals"  style="width:99%;text-align: right;" placeholder="Please Enter bike rent(drop off)">
		    					</div>
		  					</div>
		  					<div class="form-group">
		    					<label class="control-label col-sm-4" for="cmbdescp">Description:</label>
		    					<div class="col-sm-8 control-container">
		      						<input type="text" name="cmbdescp" id="cmbdescp" class="form-control"  style="width:99%;" placeholder="Please Enter Description">
		    					</div>
		  					</div>
    					</div>
					</div>
					<div class="modal-footer text-right">
	            		<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	            		<button type="button" class="btn btn-default btn-primary" id="btnsavevendortariff">Save Changes</button>
	          		</div>
				</div>
			</div>
		</div>
  </div>
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	
        $('[data-toggle="tooltip"]').tooltip();
        
      //  getInitData();
        getGridData();
        $('#empsponsortariffdiv').hide();

        $('.load-wrapp').hide();
        
        $('#cmbtable').on('change', function () {
            const val = $(this).val();
            if (val === '2') {
                $("#jqxemployeesponsorgrid").jqxGrid('clear');
                $('#empsponsordiv').hide();
                $('#empsponsortariffdiv').show();
            } else {
                $("#jqxemployeesponsortariffgrid").jqxGrid('clear');
                $('#empsponsortariffdiv').hide();
                $('#empsponsordiv').show();
            }
        });
        
        // vendor assignement save button trigger
        $('#btnsaveassignvendor').click(function(){

        	// to pass the selected employees	
        	var selectedRowIndexes = $('#jqxemployeesponsorgrid').jqxGrid('getselectedrowindexes');
    		var selectedEmployees = "";
    		selectedRowIndexes.forEach(function(index) {
    			var rowData = $('#jqxemployeesponsorgrid').jqxGrid('getrowdata', index);
    			selectedEmployees += rowData.empdocno+",";
    		});
        	
        	// checking if vendor is selected or not
        	var vendor=$('#cmbvendor').val();
        	if(vendor==""){
        		$('#cmbvendor').closest('.form-group').addClass('has-error');
        		$('#cmbvendor').closest('.form-group').find('.control-container').append('<span class="help-block">Vendor is mandatory</span>')
        		return false;
        	}
        	else{
        		$('#cmbvendor').closest('.form-group').removeClass('has-error');
        		$('#cmbvendor').closest('.form-group').find('.control-container .help-block').remove();
        	}
        	
    		// calling ajax function 
    		funLinkVendor(selectedEmployees.slice(0, -1),vendor);
        })
        
        
         // vendor assignement save button trigger
        $('#btndelink').click(function(){

        	// to pass the selected employees	
        	var selectedRowIndexes = $('#jqxemployeesponsorgrid').jqxGrid('getselectedrowindexes');
        	if(selectedRowIndexes.length<=0){
        		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Please select employees'
				});
        	    return false;
        	}
    		var selectedEmployees = "";
    		selectedRowIndexes.forEach(function(index) {
    			var rowData = $('#jqxemployeesponsorgrid').jqxGrid('getrowdata', index);
    			selectedEmployees += rowData.empdocno+",";
    		});
        	
    		// calling ajax function 
    		funDeLinkVendor(selectedEmployees.slice(0, -1));
        })
        
        
        
        // tariff save button trigger
         $('#btnsavevendortariff').click(function(){
        	 
        	// validation for vendor selection 
        	var vendor=$('#cmbvendortf').val();
        	if(vendor==""){
        		$('#cmbvendortf').closest('.form-group').addClass('has-error');
        		$('#cmbvendortf').closest('.form-group').find('.control-container').append('<span class="help-block">Vendor is mandatory</span>')
        		return false;
        	}
        	else{
        		$('#cmbvendortf').closest('.form-group').removeClass('has-error');
        		$('#cmbvendortf').closest('.form-group').find('.control-container .help-block').remove();
        	}
    		
    		funSaveTariff();
        })
        
        
        $('#btnsubmit').click(function(){
        	loadGrid();
        });
        
        
        $('#btntrfset').click(function(){
        	funGetFilterDataTf();
        	$('#modalTariffSetting').modal('show');
        });
        
        $('#btnlink').click(function(){
        	var selectedRowIndexes = $('#jqxemployeesponsorgrid').jqxGrid('getselectedrowindexes');
        	let empids="";
        	if (selectedRowIndexes.length === 0) {
        		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Please select an employee'
				});
        	    return false;
        	} 
        	selectedRowIndexes.forEach(function(index) {
    			var rowData = $('#jqxemployeesponsorgrid').jqxGrid('getrowdata', index);
    		    empids+=rowData.empid+",";
    		});
        	funGetFilterData();
        	$('.empid').text(empids.slice(0, -1));
        	$('#modalAssignVendor').modal('show');
        });

        $('#modalTariffSetting').on('hidden.bs.modal', function () {
            // Clear all input, textarea, and select fields inside the modal
            $(this).find('input, textarea, select').val('');
            
            // Optionally clear checkboxes or radio buttons
            $(this).find('input:checkbox, input:radio').prop('checked', false);
            
        });
        
        $('input.only-decimals').on('input', function () {
            let val = $(this).val();
            val = val.replace(/[^0-9.]/g, '');
            let parts = val.split('.');
            if (parts.length > 2) {
                val = parts[0] + '.' + parts[1];
            }
            $(this).val(val);
        });
        
        $('.only-decimals').on('blur', function () {
            let val = parseFloat($(this).val());

            if (!isNaN(val)) {
                $(this).val(val.toFixed(2));
            } else {
                $(this).val("0.00");
            }
        });
        
        $('#btnexcel').click(function(){
        	var val=$('#cmbtable').val();
			
    		if (val === '2') {
    			$("#jqxemployeesponsortariffgrid").excelexportjs({
					containerid: "jqxemployeesponsortariffgrid",
					datatype: 'json',
					dataset: null,
					gridId: "jqxemployeesponsortariffgrid",
					columns: getColumns("jqxemployeesponsortariffgrid"),
					worksheetName: "Tariff Data"
				});
    		} else {
	        	$("#jqxemployeesponsorgrid").excelexportjs({
					containerid: "jqxemployeesponsorgrid",
					datatype: 'json',
					dataset: null,
					gridId: "jqxemployeesponsorgrid",
					columns: getColumns("jqxemployeesponsorgrid"),
					worksheetName: "Employee0-Vendor Data"
				});
    		}
        });
        
       
        
        
    }); 
    	
    
	function loadGrid(){
		var val=$('#cmbtable').val();
			
		if (val === '2') {
			$("#empsponsortariffdiv").load("employeesponsortariffgrid.jsp?chk=1");
        } else {
			$("#empsponsordiv").load("employeesponsorgrid.jsp?&chk=1");
        }
		
	}	
		

	function getInitData(){
		$.get('getinitdata.jsp',function(data){
			data=JSON.parse(data);
			var htmldata="";
			$.each(data.branchdata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#cmbbranch').html($.parseHTML(htmldata));
		});
	}
	
	function getGridData(){
		var htmldata="";
		htmldata+='<option value="1">Employee-Vendor Link</option>';
		htmldata+='<option value="2">Tariff Setting</option>';
		$('#cmbtable').html($.parseHTML(htmldata));
	}
	
	function funGetFilterData(){
		$.get('getFilterData.jsp', {}, function(data) {
   			data=JSON.parse(data);
   			var htmldata='<option value="">Choose Vendor</option>';
   			$.each(data.vendordata,function(index,value){
   				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
   			});
   			
   			$('#cmbvendor').html($.parseHTML(htmldata));
   			$('#cmbvendor').select2({
   				placeholder:"Choose Vendor",
   				allowClear:true
   			});
   			
		});
	}
	
	
	function funGetFilterDataTf(){
		$.get('getFilterData.jsp', {}, function(data) {
   			data=JSON.parse(data);
   			var htmldata='<option value="">Choose Vendor</option>';
   			$.each(data.vendordata,function(index,value){
   				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
   			});
   			
   			$('#cmbvendortf').html($.parseHTML(htmldata));
   			$('#cmbvendortf').select2({
   				placeholder:"Choose Vendor",
   				allowClear:true
   			});
   			
		});
	}
	
	
	function funLinkVendor(employees,vendordocno){
		Swal.fire({
    		title: 'Are you sure?',
    		text: "Do you want to assign Vendor for selected Employees",
    		icon: 'warning',
    		showCancelButton: true,
    		confirmButtonColor: '#3085d6',
    		cancelButtonColor: '#d33',
    		confirmButtonText: 'Yes'
    	}).then((result) => {
    		if (result.isConfirmed) {
    			$.post('assignvendor.jsp',{'employeedocnos':employees,'vendordocno':vendordocno},function(data,status){
    				data=JSON.parse(data);
    				if(data.errorstatus=="0"){
    					Swal.fire({
    						icon:'success',
    						title: 'Success',
    						text: 'Vendor Assigned Successfully'
    					});
    					$('#modalAssignVendor').modal('hide');
    					$('#empdocno,#rowindex').val('');
    					$('#cmbvendor').val('').trigger('change');
    					$('.empid').text('');
    					$('#btnsubmit').trigger('click');
    				}
    				else{
    					Swal.fire({
    						icon:'warning',
    						title: 'Warning',
    						text: 'Not Updated'
    					});
    				}
    			});
    		}
    	});
		
	}
	
	function funDeLinkVendor(employees){
		Swal.fire({
    		title: 'Are you sure?',
    		text: "Do you want to delink Vendor for selected Employees",
    		icon: 'warning',
    		showCancelButton: true,
    		confirmButtonColor: '#3085d6',
    		cancelButtonColor: '#d33',
    		confirmButtonText: 'Yes'
    	}).then((result) => {
    		if (result.isConfirmed) {
    			$.post('delinkvendor.jsp',{'employeedocnos':employees},function(data,status){
    				data=JSON.parse(data);
    				if(data.errorstatus=="0"){
    					Swal.fire({
    						icon:'success',
    						title: 'Success',
    						text: 'Vendor Delinked Successfully'
    					});
    					$('#empdocno,#rowindex').val('');
    					$('.empid').text('');
    					$('#btnsubmit').trigger('click');
    				}
    				else{
    					Swal.fire({
    						icon:'warning',
    						title: 'Warning',
    						text: 'Not Updated'
    					});
    				}
    			});
    		}
    	});
		
	}
	
	function validateDecimal(value) {
	    var num = parseFloat(value);
	    return (value === null || value === undefined || value === '' || isNaN(num)) ? 0 : num;
	}
	
	
	function funSaveTariff(){
		var vendordocno=$('#cmbvendortf').val();
		var monthlycarrent=validateDecimal($('#cmbmcr').val());
		var monthlybikerentp=validateDecimal($('#cmbmbrp').val());
		var monthlybikerentd=validateDecimal($('#cmbmbrd').val());
		var description=$('#cmbdescp').val();
		console.log(monthlycarrent,monthlybikerentp,monthlybikerentd);
		Swal.fire({
    		title: 'Are you sure?',
    		text: "Do you want to save the tariff",
    		icon: 'warning',
    		showCancelButton: true,
    		confirmButtonColor: '#3085d6',
    		cancelButtonColor: '#d33',
    		confirmButtonText: 'Yes'
    	}).then((result) => {
    		if (result.isConfirmed) {
    			$.post('savetariff.jsp',{'monthlycarrent':monthlycarrent,'monthlybikerentp':monthlybikerentp,'monthlybikerentd':monthlybikerentd,'description':description,'vendordocno':vendordocno},function(data,status){
    				data=JSON.parse(data);
    				if(data.errorstatus=="0"){
    					Swal.fire({
    						icon:'success',
    						title: 'Success',
    						text: 'Tariff Saved Successfully'
    					});
    					$('#modalTariffSetting').modal('hide');
    					$('#btnsubmit').trigger('click');
    				}
    				else{
    					Swal.fire({
    						icon:'warning',
    						title: 'Warning',
    						text: 'Not Updated'
    					});
    					$('#modalTariffSetting').modal('hide');
    				}
    			});
    		}
    	});
	}
	
</script>
</body>
</html>
