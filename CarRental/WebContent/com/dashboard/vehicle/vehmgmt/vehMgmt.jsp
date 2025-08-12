<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
<title>Vehicle Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">

<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
<style type="text/css">
	.badge-notify{
		position:absolute;right:-5px;top:-8px;z-index:2;
	   	background-color:red;
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
	}
	body{
		height:82vh;
		overflow-y:auto;
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
    .custompanel>div{

    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    .custompanel1{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-right: 10px;
      padding:5px;
      border-radius: 8px;
    }
    .custompanel1>div{

    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    
    .custompanel2{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-right: 10px;
      padding:4px;
      border-radius: 8px;
    }
    .custompanel2>div{

    	float: left;
      	display: inline-block;
      	margin:0;
      	padding:0;
      	width:auto;
    }
    
    
</style>
</head>
<body>
	<div class="load-wrapp page-loader">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    
    <div class="container-fluid">
    	<div class="row" style="margin-bottom:1rem;">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
    			<div class="primarypanel custompanel">
  					<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			<div class="dropdown info-dropdown" style="display:inline-block;">
        				<button type="button" class="btn btn-default dropdown-toggle" id="btninfo" data-toggle="dropdown"><i class="fa fa-info-circle " data-toggle="tooltip" title="Info" data-placement="bottom" aria-hidden="true"></i></button>
	        			<ul class="dropdown-menu">
	    					<li style="padding-left:10px;cursor:pointer;"><span class="badge insurExpiryClass" id="insexpdetails"  style="margin-right:10px; ">&nbsp;</span>Insur.Expiry</li>
	    					<li style="padding-left:10px;cursor:pointer;"><span class="badge regExpiryClass" id="regexpdetails"  style="margin-right:10px;">&nbsp;</span>Reg.Expiry</li>
	  					</ul>
        			</div>
        			<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
        		</div>
        		<div class="primarypanel custompanel" >
    				<div class="btn-veh-count"></div>
    			</div>
    			<div class="actionpanel custompanel">
    				<button type="button" class="btn btn-default" id="btnstatuschange" data-toggle="tooltip" title="Change Fleet Status" data-placement="bottom"><i class="fa fa-exchange" aria-hidden="true"></i></button>
    				<button type="button" class="btn btn-default" id="btnrelease" data-toggle="tooltip" title="To Be Released" data-placement="bottom"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
    				<button type="button" class="btn btn-default" id="btnupdateexpiry" data-toggle="tooltip" title="Update Expiry Dates" data-placement="bottom"><i class="fa fa-retweet" aria-hidden="true"></i></button>
    				<button type="button" class="btn btn-default" id="btnupdaterent" data-toggle="tooltip" title="Change Rent Status" data-placement="bottom"><i class="fa fa-arrows-h" aria-hidden="true"></i></button>
    			    <button type="button" class="btn btn-default" id="btnvehmovement" data-toggle="tooltip" title="Vehicle Movement" data-placement="bottom"><i class="fa fa-car" aria-hidden="true"></i></button>
    			  <button type="button" class="btn btn-default" id="btntariffdetails" data-toggle="tooltip" title="Tariff Details" data-placement="bottom"><i class="fa fa-list" aria-hidden="true"></i></button>
    			
    			</div>
    		<div>
    		<table><tr><td colspan="2" >&nbsp;</td></tr>
    		 <tr><td colspan="2">&nbsp;<font size="3" color="Blue"><b><label id="fleetshow"></label></b></font></td></tr>
   </table>
    		</div>	

   			
    		</div>
    	</div>
    	<div class="row">
    		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 col-xl-12">
    			<div class="vehdiv"><jsp:include page="vehGrid.jsp"></jsp:include></div>
    		</div>
    	</div>
    	
    	<!--  vehicle fleet status -->
    	 
    	<div id="modalstatuschange" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Vehicle Status Change of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<div class="row">
            					<div class="col-sm-4">
            						<label class="form-label">Status</label>
            						<select class="form-control" id="cmbstatuschange"><option value="">--Select--</option></select>
            					</div>
            					<div class="col-sm-4">
            						<label class="form-label">Date</label>
            						<div id="statuschangedate"></div>
            					</div>
            					<div class="col-sm-4">
            						<label class="form-label">Time</label>
            						<div id="statuschangetime"></div>
            					</div>
            				</div>
            				<div class="row">
            					<div class="col-sm-12">
            						<label class="form-label">Reason</label>
            						<input type="text" name="statuschangereason" id="statuschangereason" style="height:31px;"  class="form-control" placeholder="Reason">
            					</div>
            				</div>
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnsavestatuschange">Save Changes</button>
          			</div>
        		</div>
      		</div>
    	</div>
    	
    	
    	<!-- rent status -->
    	
    	<div id="modalrentstatus" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Rent Status Change of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<div class="row">
            					<div class="col-sm-12">
            						<label class="form-label">Status</label>
            						<select class="form-control" id="rentstatuschange">
            						<option value="" selected>--Select--</option>
                                    <option value="R" selected>Rental</option>
		                            <option value="L">Lease</option>
		                            <option value="LM">Limousine</option>
		                            <option value="A">All</option></select>
            					</div>
            				
            				</div>
            				
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnsaverentstatuschange">Save Changes</button>
          			</div>
        		</div>
      		</div>
    	</div>
    	
    	<!--  reg/ins expiry update -->
    	
    	<div id="modalexpupdate" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Registration / Insurance Expiry Update Change of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<mark><b>Registration Expiry Update</b></mark>
            				  <br>
            				<div class="row">
            				   <div class="col-sm-4">
            						<label class="form-label">Date</label>
            						<div id="regexpdate"></div>
            					</div>
            					<div class="col-sm-8">
            						<label class="form-label">Remarks</label>
            						<input type="text" name="regremarks" id="regremarks" style="height:31px;" class="form-control" placeholder="Remarks">
            					</div>
            				</div>
            				  <br>  <br>
            			   	<mark><b>Insurance Expiry Update</b></mark>
            			   	  <br>
            				<div class="row">
            					
            					<div class="col-sm-4">
            						<label class="form-label">Ins. Company</label>
            						<select class="form-control" id="inscpmy">
            						<option value="" selected>--Select--</option>
                                  </select>
            					</div>
            					<div class="col-sm-4">
            						<label class="form-label">Ins. Type</label>
            						<select class="form-control" id="instype">
            						<option value="" selected>--Select--</option>
                                    <option value="Comprehensive">Comprehensive</option>
		                            <option value="3rd Party">3rd Party</option>
		                            </select>
            					</div>
            					<div class="col-sm-4">
            						<label class="form-label">Policy No.</label>
            						<input type="text" name="inspono" id="inspono" style="height:31px;"  class="form-control" placeholder="Policy No">
            					</div>
            					</div>
            					<div class="row">
            					<div class="col-sm-4">
            						<label class="form-label">Date</label>
            						<div id="insuexpdate"></div>
            					</div>
            					
            					<div class="col-sm-8">
            						<label class="form-label">Remarks</label>
            						<input type="text" name="insuremarks" id="insuremarks" style="height:31px;" class="form-control" placeholder="Remarks">
            					</div>
            				            				
            				</div>
            				
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnsaveexpdate">Save Changes</button>
          			</div>
        		</div>
      		</div>
    	</div> 
    	
    	<!-- to be released -->
    	
    	<div id="modalrelease" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">To be Released status of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				
            				<div class="row">
            				   <div class="col-sm-4">
            						<label class="form-label">Date</label>
            						<div id="reldate"></div>
            					</div>
            					
            					<div class="col-sm-4">
            						<label class="form-label">Time</label>
            						<div id="reltime"></div>
            					</div> 
            					
            					<div class="col-sm-4">
            						<label class="form-label">Rental Status</label>
            						<select class="form-control" id="rentsts">
            						<option value="R" selected>Rental</option>
		                            <option value="L">Lease</option>
		                            <option value="LM">Limousine</option>
		                            <option value="A">All</option>
                                  </select>
            					</div>
            				</div>
            				  
            				  
            				<div class="row">
            					
            					<div class="col-sm-3">
            						<label class="form-label">Branch</label>
            						<select class="form-control" id="brch" onchange="getloc();">
            						<option value="" selected>--Select--</option>
                                  </select>
            					</div>
            					<div class="col-sm-3">
            						<label class="form-label">Location</label>
            						<select class="form-control" id="locn">
            						<option value="" selected>--Select--</option>
		                            </select>
            					</div>
            					<div class="col-sm-3">
            						<label class="form-label">Fuel</label>
            						<select class="form-control" id="fuel">
            						<option value="">--Select--</option>
		     <option value=0.000 selected>Level 0/8</option>
		     <option value=0.125>Level 1/8</option>
		     <option value=0.250>Level 2/8</option>
		     <option value=0.375>Level 3/8</option>
		     <option value=0.500>Level 4/8</option>
		     <option value=0.625>Level 5/8</option>
		     <option value=0.750>Level 6/8</option>
		     <option value=0.875>Level 7/8</option>
		     <option value=1.000>Level 8/8</option></select></div>
            					<div class="col-sm-3">
            						<label class="form-label">Km</label>
            						<input type="text" name="kms" id="kms" style="height:31px;"  class="form-control" placeholder="Enter Km">
            					</div>
            					
            					
            				            				
            				</div>
            				
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			<button type="button" class="btn btn-default btn-primary" id="btnsaverelease">Save Changes</button>
          			</div>
        		</div>
      		</div>
    	</div> 
    	
    	<!-- vehicle movement -->
    	
    		<div id="modalvehmom" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg" style="width:90%">
        		<div class="modal-content" style="width:100%">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Vehicle Movement of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<div  class="row" >
            					<div class="primarypanel custompanel1">
            				 	<table><tr><td>
            				 	 
            						<label class="form-label" style="padding-top:2px;">From : </label></td>
            						<td><div id="fromdate"></div></td>
            					
            						<td> &nbsp; <label class="form-label" style="padding-top:2px;">To : </label></td>
            						<td><div id="todate"></div></td></tr>
            					
            				 		</table>
            						</div>
            						<div class="primarypanel custompanel2">
            				 	
            		<button type="button" class="btn btn-default" id="btnvehsubmit"  style="line-height: 0.5rem; padding: 7px;" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnvehexcel" style="line-height: 0.5rem; padding: 7px;" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			</div>	
        		
    	       
            		</div>	
            		<br>
            		<table width="100%">
		<tr>
			 <td><div id="vehmovdiv"><jsp:include page="vehiclemovementGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>	
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			</div>
        		</div>
      		</div>
      		
      	</div>	
      	
      	
      	<!-- ready to rent -->
    	
    		<div id="modalreadytorent" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-lg" style="width:90%">
        		<div class="modal-content" style="width:100%">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Tariff Details of <span class="fleetdet"></span></h4>
          			</div>
          			<div class="modal-body">
            			<div class="container-fluid">
            				<div  class="row" >
            				<div class="primarypanel custompanel2">
            				 	
            	<button type="button" class="btn btn-default" id="btnrtrexcel" style="line-height: 0.5rem; padding: 7px;" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			</div>	
        		
    	       
            		</div>	
            		<br>
       <table width="100%">
<tr>
<td width="20%">
	
                <div id="tariffdiv"><jsp:include page="masterTariffgrid.jsp"></jsp:include>
            </div></td>
              
   <td width="80%">
	
                <div id="tariffshowdiv"><jsp:include page="tariffShowgrid.jsp"></jsp:include></div>
             </td> 
</tr>
	</table>	
            			</div>
          			</div>
          			<div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            			</div>
        		</div>
      		</div>
      		
      	</div>	
    	</div>
    	
    
    
    <script src="../../../../js/sweetalert2.all.min.js"></script>
	<script src="../../../../vendors/select2/js/select2.min.js"></script>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#statuschangedate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
            $("#statuschangetime").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});  
          
 /* $("#regexpdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
 $("#insuexpdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
  */
  $("#regexpdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy",value:null});
  $("#insuexpdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy",value:null});
  
  $("#reldate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
 $("#reltime").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"HH:mm",value:new Date(),showCalendarButton:false});  
 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
 $("#todate").jqxDateTimeInput({ width: '125px', height: '20px',formatString:"dd.MM.yyyy"});
 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    
 $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
 
 
 $('#todate').on('change', function (event) {
		
	   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  }   
 });

 
    		$('[data-toggle="tooltip"]').tooltip();
    		getInitData();
    		
    		
    		$('#btnsubmit').on('click',function(){
    			funreload();
    		});
    		
    		 
    		$('#btnvehmovement').on('click',function(){
    			
    			funvehmomreload();
    		});
    		
	       $('#btnvehsubmit').on('click',function(){
    			
    			funvehmomreload();
    		});
    		
	       
	       $('#btntariffdetails').on('click',function(){
   			
   			funtariffreload();
   		});
   		
	      /*  $('#btnrtrsubmit').on('click',function(){
   			
	    	   funtariffreload();
   		}); */
   		
    		
    		$('#btnexcel').on('click',function(){
        		
    		  
    			$(".vehdiv").excelexportjs({
    				containerid: ".vehdiv", 
    				datatype: 'json', 
    				dataset: null, 
    				gridId: "vehGrid", 
    				columns: getColumns("vehGrid") ,   
    				worksheetName:"Vehicle Management"
    				});
    			
    		
    		});
    		
    		$('#btnvehexcel').on('click',function(){
        		
      		  
    			$("#vehmovdiv").excelexportjs({
    				containerid: "vehmovdiv", 
    				datatype: 'json', 
    				dataset: null, 
    				gridId: "vehmovement", 
    				columns: getColumns("vehmovement") ,   
    				worksheetName:"Vehicle Movement"
    				});
    			
    		
    		});
    		
    		$('#btnrtrexcel').on('click',function(){
        		
        		  
    			$("#tariffdiv").excelexportjs({
    				containerid: "tariffdiv", 
    				datatype: 'json', 
    				dataset: null, 
    				gridId: "jqxgridtarifrr", 
    				columns: getColumns("jqxgridtarifrr") ,   
    				worksheetName:"Ready To Rent"
    				});
    			
    		
    		});
    		
    		//vehicle status
    		
    		$('#btnstatuschange').click(function(){
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			var rowindex=$('#rowindex').val();
    			var sts=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'status');
    			
    			if(sts!='IN'){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Cannot Change Fleet Status'
    				});
    				return false;
    			}
    			$('#modalstatuschange').modal('show');
    		});
    		
    		$('#btnsavestatuschange').click(function(){
    			var rowindex=$('#rowindex').val();
    			var movstatus=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movstatus');
    			var status=$('#cmbstatuschange').val();
    			var reason=$('#statuschangereason').val();
    			
    			if(movstatus==status){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Cannot change to same status'
    				});
    				return false;
    			}
    			
    			var din=new Date($('#vehGrid').jqxGrid('getcellvalue',rowindex,'din'));
    			var tin=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'tin');
    			
    			var statusdate=new Date($('#statuschangedate').jqxDateTimeInput('getDate'));
    			var statustime=$('#statuschangedate').jqxDateTimeInput('val');
    			var fleetdets=$('#fleetdets').val();
   			 
    			din.setHours(0,0,0,0);
    			statusdate.setHours(0,0,0,0);
    			
    			if(statusdate-din<0){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Date cannot be less than last In.Date'
    				});
    				return false;
    			}
    			else if(statusdate-din==0){
    				if(parseInt(statustime.split(":")[0])<parseInt(tin.split(":")[0])){
    					Swal.fire({
        					icon:'warning',
        					title: 'Warning',
        					text: 'Time cannot be less than last In.Time'
        				});
        				return false;	
    				}
    				else if(parseInt(statustime.split(":")[0])==parseInt(tin.split(":")[0])){
    					if(parseInt(statustime.split(":")[1])<parseInt(tin.split(":")[1])){
        					Swal.fire({
            					icon:'warning',
            					title: 'Warning',
            					text: 'Time cannot be less than last In.Time'
            				});
            				return false;	
        				}	
    				}
    			}
    			
    			
          
        		 if(status==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Choose Status'
		 				});
		 				return false; 
				 } 
        		 
        		 if(reason==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Enter a Reason'
		 				});
		 				return false; 
				 } 
    		
    		
    			Swal.fire({
    				title: 'Are you sure?',
    				text: "Do you want to update status for "+fleetdets,
    				icon: 'warning',
    				showCancelButton: true,
    				confirmButtonColor: '#3085d6',
    				cancelButtonColor: '#d33',
    				confirmButtonText: 'Yes'
    			}).then((result) => {
    				if (result.isConfirmed) {
    					funSaveData("VSC");	
    				}
    			});
    		});
    		
    		//rent status 
    	  	
        	$('#btnupdaterent').click(function(){
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			$('#modalrentstatus').modal('show');
    		});
    		
        	$('#btnsaverentstatuschange').click(function(){
    			var rowindex=$('#rowindex').val();
    			var movstatus=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movstatus');
    			var status=$('#rentstatuschange').val();
    			var fleetdets=$('#fleetdets').val();
   			 
    			if(movstatus==status){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Cannot change to same status'
    				});
    				return false;
    			}
    			
    			Swal.fire({
    				title: 'Are you sure?',
    				text: "Do you want to update status for "+fleetdets,
    				icon: 'warning',
    				showCancelButton: true,
    				confirmButtonColor: '#3085d6',
    				cancelButtonColor: '#d33',
    				confirmButtonText: 'Yes'
    			}).then((result) => {
    				if (result.isConfirmed) {
    					funSaveData("RS");	
    				}
    			});
    		});
        	
        	// expiry update 
        	
        	
        	$('#btnupdateexpiry').click(function(){
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			$('#modalexpupdate').modal('show');
    		});
    		
        	$('#btnsaveexpdate').click(function(){
        		 
        		var regdate=$('#regexpdate').jqxDateTimeInput('getDate');
        		var insdate=$('#insuexpdate').jqxDateTimeInput('getDate');
    			var curdate=new Date();
    			if(regdate!=null){
    				regdate.setHours(0,0,0,0);
    			}
    			
    			if(insdate!=null){
    			insdate.setHours(0,0,0,0);
    			}
    			
    			curdate.setHours(0,0,0,0);
    			if(regdate-curdate<0 && regdate!=null){
    				swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Registration Date cannot be lesser than Current Date'
    				});
    				return false;
    			}
    			
    			if(insdate-curdate<0 && insdate!=null){
    				swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Insurance Date cannot be lesser than Current Date'
    				});
    				return false;
    			}
    			
    			if(insdate==null && regdate==null){
    				swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Select Registration / Insurance Expiry to update'
    				});
    				return false;
    			}
        			
			 var regremarks=$('#regremarks').val();
			 var regsexpdate=$('#regsexpdate').val();
			 
 			 var policyno=$('#inspono').val();
			 var inscompany=$('#inscpmy').val();
			 var instype=$('#instype').val();
			 var insexpdate=$('#insexpdate').val();
			 var insremarks=$('#insuremarks').val();
			 var fleetdets=$('#fleetdets').val();
			 
			 if(insdate!=null){
				 if(inscompany==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Select Insurance Company'
		 				});
		 				return false; 
				 }
				 if(instype==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Select Insurance Type'
		 				});
		 				return false; 
				 }
				 if(policyno==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Enter Policy No'
		 				});
		 				return false; 
				 }
				 
				 
				 
			 }
   			    
    		    Swal.fire({
    				title: 'Are you sure?',
    				text: "Do you want to update status for "+fleetdets,
    				icon: 'warning',
    				showCancelButton: true,
    				confirmButtonColor: '#3085d6',
    				cancelButtonColor: '#d33',
    				confirmButtonText: 'Yes'
    			}).then((result) => {
    				if (result.isConfirmed) {
    					funSaveData("EXP");	
    				}
    			});
    		});
        	
        	
        	
        	
                // to be released
        	
        	
        	$('#btnrelease').click(function(){
        		
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			
    			var rowindex=$('#rowindex').val();
    			var fstatus=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fstatus');
    		if(fstatus!='I'){
    			
    			Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Already Released'
				});
				return false;	
    		}
    			$('#modalrelease').modal('show');
    		});
                
                
        	$('#btnsaverelease').click(function(){
    			var rowindex=$('#rowindex').val();
    			var doc_no=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movstatus');
    		
    			
    			var reldate=new Date($('#reldate').jqxDateTimeInput('getDate'));
    			var curdate=new Date();
    			reldate.setHours(0,0,0,0);
    			curdate.setHours(0,0,0,0);
    			if(reldate-curdate<0){
    				swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Date cannot be lesser than Current Date'
    				});
    				return false;
    			}
     			 var rentsts=$('#rentsts').val();
     			 var relkm=$('#kms').val();
     			 var relfuel=$('#fuel').val();
     			 var relloc=$('#locn').val();
     			  var relbrch=$('#brch').val();
     			 var fleetdets=$('#fleetdets').val();
    			 
          
          
        		 if(rentsts==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Choose Rent Status'
		 				});
		 				return false; 
				 } 
        		 if(relbrch==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Choose Branch'
		 				});
		 				return false; 
				 } 
        		 if(relloc==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Choose Location'
		 				});
		 				return false; 
				 } 
        		 if(relfuel==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Choose Fuel'
		 				});
		 				return false; 
				 } 
        		
        		 
        		 if(relkm==''){
					 swal.fire({
		 					icon:'warning',
		 					title: 'Warning',
		 					text: 'Enter Km'
		 				});
		 				return false; 
				 } 
        		 
        		
    		
    		
    		
    			Swal.fire({
    				title: 'Are you sure?',
    				text: "Do you want to update status for "+fleetdets,
    				icon: 'warning',
    				showCancelButton: true,
    				confirmButtonColor: '#3085d6',
    				cancelButtonColor: '#d33',
    				confirmButtonText: 'Yes'
    			}).then((result) => {
    				if (result.isConfirmed) {
    					funSaveData("TBR");	
    				}
    			});
    		});
    		
    		
    		//vehicle movement
    		
        	$('#btnvehmovement').click(function(){
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			$('#modalvehmom').modal('show');
    		});
    		
    		
    		//ready to rent
    		
    		
    			
        	$('#btntariffdetails').click(function(){
    			if($('#rowindex').val()==""){
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Please choose a fleet'
    				});
    				return false;
    			}
    			$('#modalreadytorent').modal('show');
    		});
        	
        	
        	
        	
    	
    		$('.info-dropdown .dropdown-menu li').each(function(){
    			$(this).on('click',function(){
    				
    				     
    				     if(this.textContent.trim()=='Insur.Expiry'){
    				    	 if($(this).hasClass('active')){
    		        				$(this).removeClass('active');
    		        				$('#vehGrid').jqxGrid('removefilter','chkinsurexpiry', true);
    		        			}
    		        			else{
    		        				$(this).addClass('active');
    		        			}
    				    	 if($(this).hasClass('active')){
     	        				$('#vehGrid').jqxGrid('removefilter','chkinsurexpiry', true);
     	        				var filtergroup = new $.jqx.filter();
     	        		    	var filter_or_operator = 1;
     	        		    	var filtervalue="1"; 
     	        		    	var filtercondition = 'EQUAL';
     	        		    	var filter1 = filtergroup.createfilter("stringfilter", filtervalue, filtercondition);
     	        				filtergroup.addfilter(filter_or_operator, filter1);
     	        		    	$("#vehGrid").jqxGrid('addfilter', 'chkinsurexpiry', filtergroup);
     	        		    	// apply the filters.
     	        		    	$("#vehGrid").jqxGrid('applyfilters');
     	        			}
    				     } else if (this.textContent.trim()=='Reg.Expiry'){
    				    	 if($(this).hasClass('active')){
 		        				$(this).removeClass('active');
 		        				$('#vehGrid').jqxGrid('removefilter','chkregexpiry', true);
 		        			}
 		        			else{
 		        				$(this).addClass('active');
 		        			}
    				    	 if($(this).hasClass('active')){
     	        				$('#vehGrid').jqxGrid('removefilter','chkregexpiry', true);
     	        				var filtergroup = new $.jqx.filter();
     	        		    	var filter_or_operator = 1;
     	        		    	var filtervalue="1"; 
     	        		    	var filtercondition = 'EQUAL';
     	        		    	var filter1 = filtergroup.createfilter("stringfilter", filtervalue, filtercondition);
     	        				filtergroup.addfilter(filter_or_operator, filter1);
     	        		    	$("#vehGrid").jqxGrid('addfilter', 'chkregexpiry', filtergroup);
     	        		    	// apply the filters.
     	        		    	$("#vehGrid").jqxGrid('applyfilters');
     	        			}
    				    	 
    				     }
    				    	 
    				     
    				     
    				        });
    			
    			});
    	
    	});	
    	
    	
  
    	
    	function funSaveData(savecode){
    		$('.page-loader').show();
    		var savedata={};
    		//vehicle status
    		
    		if(savecode=="VSC"){
    			var rowindex=$('#rowindex').val();
    			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
    			var trancode=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movtrancode');
    			var date=$('#statuschangedate').jqxDateTimeInput('val');
    			var time=$('#statuschangetime').jqxDateTimeInput('val');
    			var status=$('#cmbstatuschange').val();
    			var reason=$('#statuschangereason').val();
    			 var brhid=0;
                 var branch=$('#cmbbranch').val();
     			var brchgrid=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
      			if(branch==0){
      		        brhid=brchgrid;
      			}else{
      			   brhid=$('#cmbbranch').val();
      			}
    			savedata={"fleetno":fleetno,"date":date,"time":time,"savecode":savecode,"status":status,"brhid":brhid,"trancode":trancode,"reason":reason};
    		}
    		// rent status
    		
    		if(savecode=="RS"){
    			var rowindex=$('#rowindex').val();
    			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
    			var trancode=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movtrancode');
    			 var status=$('#rentstatuschange').val();
    			 var brhid=0;
                 var branch=$('#cmbbranch').val();
     			var brchgrid=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
      			if(branch==0){
      		        brhid=brchgrid;
      			}else{
      			   brhid=$('#cmbbranch').val();
      			}
    			 savedata={"fleetno":fleetno,"savecode":savecode,"status":status,"brhid":brhid,"trancode":trancode};
    		}
    		
    		// insurance / registration expiry update
    		
    		if(savecode=="EXP"){
    			var rowindex=$('#rowindex').val();
    			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
    			var trancode=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movtrancode');
    			 var regdate=$('#regexpdate').val();
    			 var regremarks=$('#regremarks').val();
    			 var regsexpdate=$('#vehGrid').jqxGrid('getcelltext',rowindex,'regexpdate');
    			 
    			 var insdate=$('#insuexpdate').val();
     			 var policyno=$('#inspono').val();
    			 var inscompany=$('#inscpmy').val();
    			 var instype=$('#instype').val();
    			 var insremarks=$('#insuremarks').val();
    			 var insexpdate=$('#vehGrid').jqxGrid('getcelltext',rowindex,'insexpdate');
                var brhid=0;
                var branch=$('#cmbbranch').val();
    			var brchgrid=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
     			if(branch==0){
     		        brhid=brchgrid;
     			}else{
     			   brhid=$('#cmbbranch').val();
     			}
    			 savedata={"fleetno":fleetno,"savecode":savecode,"brhid":brhid,"trancode":trancode,"regdate":regdate,"regremarks":regremarks,"regsexpdate":regsexpdate,"insdate":insdate,"policyno":policyno,"inscompany":inscompany,"instype":instype,"insexpdate":insexpdate,"insremarks":insremarks};
    		}
    		
    		if(savecode=="TBR"){
    			var rowindex=$('#rowindex').val();
    			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
    			var trancode=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'movtrancode');
    			var reldate=$('#reldate').jqxDateTimeInput('val');
    			var reltime=$('#reltime').jqxDateTimeInput('val');
    			 var rentsts=$('#rentsts').val();
    			 var relkm=$('#kms').val();
    			 var relfuel=$('#fuel').val();
    			 var relloc=$('#locn').val();
    			  var relbrch=$('#brch').val();
    			  var doc_no=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'doc_no');;
    			  var brhid=0;
                  var branch=$('#cmbbranch').val();
      			var brchgrid=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
       			if(branch==0){
       		        brhid=brchgrid;
       			}else{
       			   brhid=$('#cmbbranch').val();
       			}
    			  
    		   savedata={"fleetno":fleetno,"savecode":savecode,"brhid":brhid,"trancode":trancode,"reldate":reldate,"reltime":reltime,"rentsts":rentsts,"relkm":relkm,"relfuel":relfuel,"relloc":relloc,"relbrch":relbrch,"doc_no":doc_no};
    	  	}
    		
    		console.log(savedata);
    		$.post('saveData.jsp',savedata,function(data,status){
    			data=JSON.parse(data);
    			
    			$('.page-loader').hide();
    			if(data.errorstatus=="0"){
    				Swal.fire({
    					icon:'success',
    					title: 'Success',
    					text: 'Updated Successfully'
    				});
    				$('.modal.fade.in').modal('hide');
    				$('#btnsubmit').trigger('click');
    				$('#cmbstatuschange').val("");
    				$('#statuschangereason').val("");
    				$('#rentstatuschange').val("");
    				$('#regremarks').val("");$('#inscpmy').val("");$('#instype').val("");
    				$('#inspono').val("");$('#insuremarks').val("");
    				$('#regexpdate').val("");$('#insuexpdate').val("");
    			}
    			else{
    				Swal.fire({
    					icon:'warning',
    					title: 'Warning',
    					text: 'Not Updated'
    				});
    				return false;
    			}
    		});
    	}
    	function funreload(){
    		getCount();
    		var brhid=$('#cmbbranch').val();
    		$('.vehdiv').load('vehGrid.jsp?id=1&brhid='+brhid);
    	}
    	
    	function funvehmomreload(){
    		
    		var rowindex=$('#rowindex').val();
    		var brhid=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
			var fromdate=$('#fromdate').val();var todate=$('#todate').val();
    		$('#vehmovdiv').load('vehiclemovementGrid.jsp?brhid='+brhid+'&fleetno='+fleetno+'&fromdate='+fromdate+'&todate='+todate);
    	}
    	
    	
function funtariffreload(){
    		
    		var rowindex=$('#rowindex').val();
			var fleetno=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'fleet_no');
			var groupval=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'groupid');
			var barchval=$('#vehGrid').jqxGrid('getcellvalue',rowindex,'brchgrid');
			 
			 $('#jqxgridtarifrr').jqxGrid('clear');		
			$('#tariffdiv').load('masterTariffgrid.jsp?barchval='+barchval+'&fleetno='+fleetno+'&groupval='+groupval);
    	}
    	
    	
    	function getCount(){
    		  var brhid=$('#cmbbranch').val();
            
  			
               $.get('getCount.jsp?brhid='+brhid,function(data){
    			
    			data=JSON.parse(data);
    			var htmldata='';
    			$.each(data.vehcountdata,function(index,value){
    				htmldata+='<div class="btn-group" style="margin-right:0.5rem;">';
            		htmldata+='<button type="button" class="btn btn-default" data-toggle="tooltip" title="'+value.refname+'" data-placement="bottom">'+value.status+'</button>';
            		htmldata+='<span class="badge badge-notify">'+value.itemcount+'</span>';
            		htmldata+='</div>';
    			});
    			$('.btn-veh-count').html($.parseHTML(htmldata));
    			$('[data-toggle="tooltip"]').tooltip();
    			
    			$('.btn-veh-count .btn-group button').on('click',function(){
        			if($(this).hasClass('active')){
        				$(this).removeClass('active');
        				$('#vehGrid').jqxGrid('removefilter','tran_code', true);
        			}
        			else{
        				$('.btn-veh-count .btn-group button').removeClass('active');
        				$(this).addClass('active');
        			}
        			
        			if($(this).hasClass('active')){
        				$('#vehGrid').jqxGrid('removefilter','tran_code', true);
        				var filtergroup = new $.jqx.filter();
        		    	var filter_or_operator = 1;
        		    	var filtervalue=$(this).text(); 
        		    	var filtercondition = 'EQUAL';
        		    	var filter1 = filtergroup.createfilter("stringfilter", filtervalue, filtercondition);
        				filtergroup.addfilter(filter_or_operator, filter1);
        		    	$("#vehGrid").jqxGrid('addfilter', 'tran_code', filtergroup);
        		    	// apply the filters.
        		    	$("#vehGrid").jqxGrid('applyfilters');
        			}
        		});
    		
});
    	}
    	
    	
    	function getloc(){
  		  var brch=$('#brch').val();
			
             $.get('getreleaselocation.jsp?brch='+brch,function(data){
  			
  			data=JSON.parse(data);
  			var htmldata='';
  			htmldata='<option value="">--Select--</option>';
			$.each(data.tbrlocdata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#locn').html($.parseHTML(htmldata));  		
});
  	}
  	
    	
    	function getInitData(){
    		
           
    		$.get('getInitData.jsp',function(data){
    			
    			data=JSON.parse(data);
    			
        		var htmldata='';
    			htmldata='';
    			$.each(data.branchdata,function(index,value){
    				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
    			});
    			$('#cmbbranch').html($.parseHTML(htmldata));
    			$('#cmbbranch').select2({
    				placeholder:"Choose Branch",
    				allowClear:true
    			});
    			
    			htmldata='<option value="">--Select--</option>';
    			$.each(data.statuschangedata,function(index,value){
    				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
    			});
    			$('#cmbstatuschange').html($.parseHTML(htmldata));
    			
    			htmldata='<option value="">--Select--</option>';
    			$.each(data.inscompanydata,function(index,value){
    				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
    			});
    			$('#inscpmy').html($.parseHTML(htmldata));
    			
    			htmldata='<option value="">--Select--</option>';
    			$.each(data.tbrbranchdata,function(index,value){
    				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
    			});
    			$('#brch').html($.parseHTML(htmldata));
    			
    			
    			
    		getCount();
    		});
    	}
    </script>
</body>
</html>