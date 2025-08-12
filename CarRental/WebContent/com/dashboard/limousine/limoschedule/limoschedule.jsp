<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
    <title>Booking</title>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
    <link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">
    <jsp:include page="../../../../bookingIncludes.jsp"></jsp:include>
    <link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />

    <style type="text/css">
        @media (min-width: 900px) {
            .modal-xl {
                width: 100%;
                max-width: 1300px;
            }
        }
        
        .branch {
            font-weight: normal;
        }
        
        .tabling {
            border: 1px solid red;
            padding-right: 10px;
            padding-left: 10px;
            padding-top: 10px;
            padding-bottom: 10px;
        }
        
        .textpanel {
            color: blue;
        }
        
        .custompanel {
            float: left;
            display: inline-block;
            margin-top: 10px;
            padding:10px;
            border-radius: 8px;
        	border:1px solid #ccc;
        	margin-bottom:4px;
        	
        }
        .custompanel:not(:last-child){
        	margin-right:10px;
        }
        .badge-notify {
            position: absolute;
            right: -5px;
            top: -8px;
            z-index: 2;
            background-color: red;
        }
        
        .comment {
            background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #fff;
            clear: both;
            float: right;
            display: block;
            padding-top: 8px;
            padding-bottom: 2px;
            padding-left: 10px;
            padding-right: 5px;
            border-radius: 12px;
            border-top-right-radius: 0;
            margin-bottom: 8px;
            transition: all 0.5s ease-in;
        }
        
        .msg-details {
            text-align: right;
        }
        
        .comments-container {
            height: 400px;
            overflow-y: auto;
            margin-bottom: 8px;
            padding-right: 5px;
        }
        
        .comments-outer-container {
            width: 100%;
            height: 100%;
        }
        
        .msg {
            word-break: break-all;
        }
        
        .rowgap {
            margin-bottom: 6px;
        }
        .div-inline{
		    display:inline-block;
		}
		.badge-bg{
			background: #a8c0ff;  /* fallback for old browsers */
			background: -webkit-linear-gradient(to right, #3f2b96, #a8c0ff);  /* Chrome 10-25, Safari 5.1-6 */
			background: linear-gradient(to right, #3f2b96, #a8c0ff); /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
			color:#fff;
		}
		.pl-1{
			padding-left:1rem;
		}
		.pr-0{
			padding-right:0;
		}
		.d-flex{
			display:flex;align-items:center;
		}
		.d-flex label{
			margin-right:1rem;
		}
		.d-flex label:not(:first-child){
			margin-left:1rem;
		}
    </style>
</head>
<body onload="getBranch();">
	 <form autocomplete="off">
         <div class="container-fluid">
         	<div class="row">
         		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                    <div class="primarypanel custompanel form-inline">
                    	<div class="d-flex">
                    	<label>From:</label>
                    	<div id="fromdate"></div>
                    	<label>To:</label>
                    	<div id="todate" ></div>
                    	<div class="form-group" style="margin-left:1rem;">
							<select id="cmbbranch" name="cmbbranch" value='<s:property value="cmbbranch"/>' style="width:min-width:125px;">
	                        	<option value="">--Select--</option>
	                        </select>
						 	<input type="hidden" id="hidcmbbranch" name="hidcmbbranch" value='<s:property value="hidcmbbranch"/>' />
						</div>
                    	<div class="form-group" style="margin-left:1rem;">
							<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
                        	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
						</div>
                    	</div>
                    </div>
                    <div class="actionpanel custompanel">
                    	 <button type="button" class="btn btn-default" id="btnschedule"  data-toggle="tooltip" title="Service Schedule" data-placement="bottom"><i class="fa fa-calendar-check-o "  aria-hidden="true"></i></button>
                    </div>
            	</div>
         	</div>
         	<!-- main grid -->
         	 <div class="row">      
      			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">        
        			<div id="limogriddiv"><jsp:include page="limoschedulegrid.jsp"></jsp:include></div>          
      			</div>
    		</div>
    		 <!-- schedule modal --> 
    		 <div id="modalschedule" class="modal fade" role="dialog">
    			<div class="modal-dialog modal-xl">
        			<div class="modal-content">
        	    		<div id="loadingoverlay"> 
				        	<div class="cv-spinner">
				            	<span class="spinner"></span>
				        	</div>
						</div>
          			<div class="modal-header leftright-padding">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Limo Schedule<span></span></h4>  <label for="otherdetails" id="lblotherdetails"></label>   
          			</div>
          			<div class="modal-body">
          				<div class="row">
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
          						<div class="form-group">
		        					<label for="cmbtype">Details Type</label>  
		        					<div>
			        					<select class="form-control select2" id="cmbtype" style="width:100%;" name="cmbtype">
			        					<option value="1">Transfer Details</option>
			        					<option value="2">Limousine Details</option>
			        					</select>   
		        					</div> 
	                     	    </div>  
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
          						<div class="form-group">
          							<label for="pickuploc">PickUp Location</label>
          							<div><input type="text" id="pickuploc" readonly/></div>
          							<input type="hidden" id="hidpickuploc"/>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
          						<div class="form-group">
          							<label for="pickupad">Pick Up Address</label>
          							<div><input type="text" id="pickupad" /></div>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2" id="dropoffdiv">
          						<div class="form-group">
          							<label for="dropoffloc">Drop Off Location</label>
          							<div><input type="text" id="dropoffloc" readonly/></div>
          							<input type="hidden" id="hiddropoffloc"/>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2" id="dropoffadddiv">
          						<div class="form-group">
          							<label for="dropoffad">Drop Off Address</label>
          							<div><input type="text" id="dropoffad" /></div>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2" id="blockhrsdiv">
          						<div class="form-group">
          							<label for="blockhrs">Block Hours</label>
          							<div><input type="text" id="blockrs" class="onlydecnum" /></div>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
          						<div class="form-group">
          							<label for="type">Type</label>
          							<div>
			        					<select class="form-control select2" id="type" style="width:100%;" name="type">
			        					<option value="Private">Private</option>
			        					<option value="Sharing">Sharing</option>
			        					</select>   
		        					</div>
          						</div>
          					</div>
          					<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2" id="exhrratediv">
          						<div class="form-group">
          							<label for="exhrrate">Ex. Hour Rate</label>
          							<div><input type="text" id="exhrrate" class="onlydecnum" /></div>
          						</div>
          					</div>
          				</div>
          				<div class="row">
          					<div class="col-xs-3 col-sm-3 col-md-3 col-lg-2">
  					         	<div class="form-inline">
  					         		<label for="triptype">Trip Type</label>
          							<div>
          								<select class="form-control select2" id="triptype" style="width:100%;" name="triptype">	</select>
          							</div>
  					         	</div>
  					         </div>
          					<div class="col-xs-3 col-sm-3 col-md-3 col-lg-2">
  					         	<div class="form-inline">
  					         		<label for="brand">Brand</label>
          							<div><input type="text" id="brand" readonly/></div>
          							<input type="hidden" id="hidbrandid"/>
  					         	</div>
  					         </div>
  					         <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2">
  					         	<div class="form-inline">
  					         		<label for="model">Model</label>
          							<div><input type="text" id="model" readonly/></div>
          							<input type="hidden" id="hidmodelid" />
  					         	</div>
  					         </div>
  					         <div class="col-xs-12 col-sm-6 col-md-4 col-lg-1">    
		        				<div class="form-group">
		        					<label for="nos">Nos</label>                   
		        					<div><input type="text" id="nos" style="width:70%;" class="onlynum" /></div>          
	                     	    </div>  
		                   	</div>
  					         <div class="col-xs-3 col-sm-3 col-md-3 col-lg-1">
  					         	<div class="form-inline">
  					         		<label for="pax">Pax</label>
          							<div><input type="text" id="pax" style="width:70%;"class="onlynum"/></div>
  					         	</div>
  					         </div>
  					         <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2">
  					         	<div class="form-inline">
  					         		<label for="tariffdocno">Tariff Docno</label>
          							<div><input type="text" id="tariffdocno" readonly/></div>
  					         	</div>
  					         </div>
  					         <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2">
  					         	<div class="form-inline">
  					         		<label for="tariff">Tariff</label>
          							<div><input type="text" id="tariff" readonly/></div>
  					         	</div>
  					         </div>
          				</div>
  						<div class="row"> 
  							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-2" id="ntariffdiv">
  					         	<div class="form-inline">
  					         		<label for="ntariff">Night Tariff</label>
          							<div><input type="text" id="ntariff" class="onlydecnum"/></div>
  					         	</div>
  					         </div>
  					          <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2" id="nehourdiv">
  					         	<div class="form-inline">
  					         		<label for="nehour">Night Extra Hour</label>
          							<div><input type="text" id="nehour" class="onlydecnum"/></div>
  					         	</div>
  					         </div>
  					          <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2" id="etratediv">
  					         	<div class="form-inline">
  					         		<label for="etrate">Extra Time Rate</label>
          							<div><input type="text" id="etrate" class="onlydecnum" /></div>
  					         	</div>
  					         </div>
  					          <div class="col-xs-3 col-sm-3 col-md-3 col-lg-2" id="edratediv">
  					         	<div class="form-inline">
  					         		<label for="edrate">Extra Distance Rate</label>
          							<div><input type="text" id="edrate" class="onlydecnum"/></div>
  					         	</div>
  					         </div>
  					    	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					         	<div class="form-inline">
  					            	<label for="AlternateDays" class="col-sm-11 col-form-label">Alternate Days</label>
							    	<div class="col-sm-1"> <input type="checkbox" id="alternativechk" name="alternativechk"></div>
							  	</div>  
		                   	</div>  
		                   	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">    
		        				<div class="form-group">
		        					<label for="Days">Days</label>   
		        					<select class="form-control select2" id="cmbdays" multiple="multiple" style="width:100%;" name="cmbdays"></select>   
	                     	    </div>  
		                   </div> 
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">       
		        				<div class="form-group">
		        					<label for="Date">Date</label>         
		        					<select class="form-control select2" id="cmbdates" multiple="multiple" style="width:100%;" name="cmbdates"></select>         
	                     	    </div>  
		                   </div> 
		              </div>
		              <div class="row">      
		                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
		        				<div class="form-group">
		        					<label for="Date">Start Date</label>     
		        					<div id="servdate" style="border: 1px solid black" style="width:69%;"></div>       
	                     	    </div>  
		                   	</div> 
		                   	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
  					       		<div class="form-inline" >
  					             	<label for="preferredTime" class="col-sm-11 col-form-label">preferred Time</label> 
							    	<div class="col-sm-1"> <input type="checkbox" id="preferredtimechk" name="preferredtimechk"></div>
							  	</div>  
		                   	</div>
		                   	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">  
		        				<div class="form-group">
		        					<label for="Time">Time</label>   
		        					<div id="servtime" style="border: 1px solid black" style="width:69%;"></div>      
	                     	    </div>  
		                   	</div>	
		                     <div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
		        				<div class="form-group">
		        					<label for="enddate">End Date</label>  
		        					<div class="row" style="display:flex;align-items:center;">
		        					<input type="checkbox" id="occend" name="occend"> &nbsp;&nbsp; <div id="enddate" style="border: 1px solid black" style="width:69%;"></div>       
		        					</div>   
	                     	    </div>  
		                   	</div> 
		                   	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">   
		        				<div class="form-group">
		        					<label for="endocc">End After Occurrence</label>     
		        					<div ><input type="text" id="endocc"/> </div>       
	                     	    </div>  
		                   	</div> 
		                   	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-2">
		                       <div style="padding-top:17px;">  
		        			   		<button type="button" class="btn btn-default btn-primary" id="btnfill" onclick="funfill()">Fill</button>
		                       </div>
		                   </div>  
  						</div>
            		 	<div class="row">      
				      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				       			<div id="schdiv"><jsp:include page="schedulegrid.jsp"></jsp:include></div>         
				      		</div>
				    	</div>  
          			</div>
          			<div class="modal-footer">
          				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          				<button type="button" class="btn btn-default btn-primary" id="btnschedulesave">Save Changes</button>
          			</div>
        		</div>
      		</div>
   		 </div>
   		 <input type="hidden" id="cldocno">
   		 <input type="hidden" id="selectedrow">
   		 <input type="hidden" id="tarifdetaildocno">
   		 <input type="hidden" id="gid">
   		<div id="locationwindow"><div></div></div>
   		<div id="brandwindow"><div></div></div>
   		<div id="modelwindow"><div></div></div>
   		<div id="tarifwindow"><div></div></div>
   		<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
		<script src="../../../../vendors/select2/select2.min.js"></script>
		<script src="../../../../js/sweetalert2.all.min.js"></script>  
		<script type="text/javascript"> 
		$(document).ready(function(){
			$("#occend").prop("checked", true);
			$("#endocc").prop("disabled", true);
			$('#nehourdiv').css('display','none');
			$('#ntariffdiv').css('display','none');
			$('#blockhrsdiv').css('display','none');
			$('#exhrratediv').css('display','none');
			$("#fromdate").jqxDateTimeInput({width: '125px',height: '15px',formatString: "dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({width: '125px',height: '15px',formatString: "dd.MM.yyyy"});
			$("#servdate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
			$("#enddate").jqxDateTimeInput({ width: '110px', height: '22px',formatString:"dd.MM.yyyy",enableBrowserBoundsDetection:true});  
	      	$("#servtime").jqxDateTimeInput({ width: '60px', height: '22px',formatString:"HH:mm",showCalendarButton: false});
	      	$('#locationwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Location Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	      	$('#locationwindow').jqxWindow('close');
	    	$('#brandwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	      	$('#brandwindow').jqxWindow('close');
	      	$('#modelwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	      	$('#modelwindow').jqxWindow('close');
	      	$('#tarifwindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '55%' ,maxWidth: '30%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	      	$('#tarifwindow').jqxWindow('close');
	      	$("#cmbbranch").select2({
                placeholder: "Select Branch",
                allowClear: true
            });
	      	$('#cmbtype').select2({
	      		 placeholder: "Select Details Type"
	      	});
	      	$('#type').select2({
	      		 placeholder: "Select Type"
	      	});
	      	
	      	$('#triptype').select2({
	      		placeholder: "Select Trip Type"
	      	});
	      	
	      	 $('.onlynum').on('input', function() {
	             let value = $(this).val();
	             value = value.replace(/[^0-9]/g, '');
	             $(this).val(value);
	         });
	      	 
	      	$('.onlydecnum').on('input', function() {
	      		 let value = $(this).val();
	             // Replace any non-numeric characters except decimal point with an empty string
	             value = value.replace(/[^0-9.]/g, '');
	             // Ensure that there's only one decimal point
	             value = value.replace(/(\..*)\./g, '$1');
	             // Update the input field with the cleaned value
	             $(this).val(value);
	         });
	      	
	      	getDays();getDates();getTripTypes();
	      	
			 $('#btnschedule').click(function(){
				 var docno = $("#selectedrow").val();
				 if(docno==''|| docno==null || docno=='undefined'){
					 Swal.fire({
			    			icon: 'warning',
							title: 'Warning',
							text: 'Please select a document'   
						});
			    		return false;
				 }
				 /*clearfields();
		        	 var enqno=$('#hidrowno').val(); 
			    	if(enqno==""){
			    		Swal.fire({
			    			icon: 'warning',
							title: 'Warning',
							text: 'Please select a document'   
						});
			    		return false;
			    	} 
			    	getDeliveries();   
			    	$("#jqxScheduleGrid").jqxGrid('clear');     
			    	var statusid=$('#hidstatusid').val(); 
			    	if(parseInt(statusid)<3){                    
			    		Swal.fire({
							icon: 'warning',
							title: 'Warning',
							text: 'Delivery not updated'          
						});
			    		return false;
			    	}   */
			    	$("#modalschedule").modal('toggle');  
		        });
			 $('#btnsubmit').click(function() {
	             reload();
	         });
			 
			 $('#btnschedulesave').click(function (){
				 getdocname();
				// saveValidations();
			 });
			 
			 $('#pickuploc').dblclick(function(){
				$('#locationwindow').jqxWindow('open');
				$('#locationwindow').jqxWindow('focus');
				var id=$(this).attr('id');
				locationSearchContent('locationSearchGrid.jsp?id='+id, $('#locationwindow'));
			 });
			 
			 $('#brand').dblclick(function(){
		    	$('#brandwindow').jqxWindow('open');
				$('#brandwindow').jqxWindow('focus');
				brandSearchContent('brandSearchGrid.jsp?', $('#brandwindow'));
			 })
			 
			 
			 $('#dropoffloc').dblclick(function(){
					$('#locationwindow').jqxWindow('open');
					$('#locationwindow').jqxWindow('focus');
					var id=$(this).attr('id');
					locationSearchContent('locationSearchGrid.jsp?id='+id, $('#locationwindow'));
				 });
			 
			 $('#model').dblclick(function(){
				 var bid=$('#hidbrandid').val()
				 if(bid=="" || bid=="undefined" || bid==null || typeof(bid)=="undefined"){
 		    		document.getElementById("errormsg").innerText="";
 		    		document.getElementById("errormsg").innerText="Please select a valid brand";
 		    		return false;
 		    	}
 		    	else{
     		    	$('#modelwindow').jqxWindow('open');
 					$('#modelwindow').jqxWindow('focus');
 					modelSearchContent('modelSearchGrid.jsp?brandid='+bid, $('#modelwindow'));            		    		
 		    	}
				 
			 });
			 
			 $('#tariffdocno').dblclick(function(){
				 if($('#pickuploc').val()=="" || $('#pickuploc').val()=="undefined" || $('#pickuploc').val()==null || typeof($('#pickuploc').val())=="undefined"){
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Pick up location is mandatory!'    
						});
   		    		return false;
   		    		}
    			   
 			   /* if($('#dropoffloc').val()=="" || $('#dropoffloc').val()=="undefined" || $('#dropoffloc').val()==null || typeof($('#dropoffloc').val())=="undefined"){
  		    		document.getElementById("errormsg").innerText="";
  		    		document.getElementById("errormsg").innerText="Drop off location is mandatory";
  		    		return false;
  		    		}
   			   else{
   				   document.getElementById("errormsg").innerText="";
   			   } */ 
 			   if($('#brand').val()=="" || $('#brand').val()=="undefined" || $('#brand').val()==null || typeof($('#brand').val())=="undefined"){
 				  swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a valid brand!'    
					});
		    		return false;
		    		}
 			   else{
 				//   document.getElementById("errormsg").innerText="";
 			   }
 			   if($('#model').val()=="" || $('#model').val()=="undefined" || $('#model').val()==null || typeof($('#model').val())=="undefined"){
 				  swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a valid model!'    
					});
   		    		return false;
   		    	}
 			   else{
 				//   document.getElementById("errormsg").innerText="";
 			   }
 			   if($('#type').val()=="" || $('#type').val()=="undefined" || $('#type').val()==null || typeof($('#type').val())=="undefined"){
 				  swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Please select a valid type!'    
					});
   		    		return false;
   		    	}
 			   else{
 				
 			   }
 		
            	    var brandid=$('#hidbrandid').val();
            		var modelid=$('#hidmodelid').val();
            		var pickuplocid=$('#hidpickuploc').val();
            		var dropofflocid=$('#hiddropoffloc').val();
            		var blockhrs=$('#blockrs').val();
            		var transfertype=$('#type').val();
            		var cldocno=$('#cldocno').val();
            		var tarifmode = $('#cmbtype').val()==='1'?'transferGrid':'hoursGrid';
            		$('#tarifwindow').jqxWindow('open');
					$('#tarifwindow').jqxWindow('focus');
													                                //+document.getElementById("transferrowindex").value+
					tarifSearchContent('tarifSearchGrid.jsp?gridname='+tarifmode+'&brandid='+brandid+'&modelid='+modelid+'&pickuplocid='+pickuplocid+'&dropofflocid='+dropofflocid+'&client='+cldocno+'&transfertype='+transfertype+'&blockhrs='+blockhrs, $('#tarifwindow'));            		   	   
			 });
			 
			 $('#cmbtype').on('change', function(){
				 if($('#cmbtype').val()==1){
					 $('#nehourdiv').css('display','none');
					 $('#exhrratediv').css('display','none');
					 $('#ntariffdiv').css('display','none');
					 $('#blockhrsdiv').css('display','none');
					 $('#dropoffdiv').css('display','block');
					 $('#dropoffadddiv').css('display','block');
					 $('#etratediv').css('display','block');
					 $('#edratediv').css('display','block');
				 } else if($('#cmbtype').val()==2) {
					 $('#dropoffdiv').css('display','none');
					 $('#dropoffadddiv').css('display','none');
					 $('#etratediv').css('display','none');
					 $('#edratediv').css('display','none');
					 $('#blockhrsdiv').css('display','block');
					 $('#ntariffdiv').css('display','block');
					 $('#nehourdiv').css('display','block');
					 $('#exhrratediv').css('display','block');
			 	 }
			 });
			 $("#occend").on('change', function() {
				 if ($(this).prop("checked")) {
					 $("#endocc").prop("disabled", true);
					 $("#enddate").jqxDateTimeInput({ disabled: false });
				 } else {
					 $("#endocc").prop("disabled", false); 
					 $("#enddate").jqxDateTimeInput({ disabled: true });
				 }
			 });
		});
		
		function locationSearchContent(url) {
		    $.get(url).done(function (data) {
		    $('#locationwindow').jqxWindow('setContent', data);
		}); 
		}
		
		 function brandSearchContent(url) {
		   $.get(url).done(function (data) {
		   $('#brandwindow').jqxWindow('setContent', data);
		}); 
		}
		 
		function modelSearchContent(url) {
		   $.get(url).done(function (data) {
		   $('#modelwindow').jqxWindow('setContent', data);
		}); 
		}
		
		function tarifSearchContent(url) {
		     $.get(url).done(function (data) {
		   $('#tarifwindow').jqxWindow('setContent', data);
		}); 
		}
		
		function reload(){
			  $("#overlay, #PleaseWait").show();
              var branch = $('#cmbbranch').val();
              var fromdate=$('#fromdate').jqxDateTimeInput('val');
              var todate=$('#todate').jqxDateTimeInput('val');
              $('#limogriddiv').load('limoschedulegrid.jsp?branch=' + branch + '&id=1&fromdate='+fromdate+'&todate='+todate);
		}
		
		
		function getBranch() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    //alert(items);
                    items = items.split('####');

                    var branchIdItems = items[0].split(",");
                    var branchItems = items[1].split(",");
                    var perm = items[2];
                    var optionsbranch;
                    if (perm == 0) {
                        optionsbranch = '<option value="a" selected>All</option>';
                    } else {

                    }
                    for (var i = 0; i < branchItems.length; i++) {
                        optionsbranch += '<option value="' + branchIdItems[i].trim() + '">' + branchItems[i] + '</option>';
                    }
                    $("select#cmbbranch").html(optionsbranch);
                    /* if ($('#hidcmbbranch').val() != null) {
                    	$('#cmbbranch').val($('#hidcmbbranch').val());
                    } */
                } else {
                    //alert("Error");
                }
            }
            x.open("GET", "<%=contextPath%>/com/dashboard/getBranch.jsp", true);
            x.send();
        }
		function getDays() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="8" selected>All</option>';
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbdays').html($.parseHTML(optionsbranch));
		  			$('#cmbdays').select2({
		  				placeholder:"Please select a Day",    
		  				allowClear:true,
		  			});
				} else {}
			}
			x.open("GET","getDays.jsp", true);  
			x.send();
		}
		
		function getTripTypes() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items =JSON.parse(x.responseText);
					var optionsbranch = '<option value="" selected></option>';
					for (var i = 0; i < items.triptypedata.length; i++) {
						optionsbranch += '<option  value="' + items.triptypedata[i].triptype +'">'
						+ items.triptypedata[i].triptype + '</option>';
						
					}
					$('#triptype').html($.parseHTML(optionsbranch));
		  			$('#triptype').select2({
		  				placeholder:"Please select Trip Type",    
		  				allowClear:true,
		  			});
				} else {}
			}
			x.open("GET","getData.jsp", true);  
			x.send();
		}
		
		
		function getDates() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {   
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					
					var srno  = items[0].split(",");
					var process = items[1].split(",");
					var optionsbranch = '<option value="0" selected>All</option>';   
					for (var i = 0; i < process.length; i++) {
						optionsbranch += '<option  value="' + srno[i].trim() +'">'
						+ process[i] + '</option>';
						
					}
					$('#cmbdates').html($.parseHTML(optionsbranch));  
		  			$('#cmbdates').select2({
		  				placeholder:"Please select a Date",    
		  				allowClear:true,
		  			});
				} else {}
			}
			x.open("GET","getDates.jsp", true);  
			x.send();
		}
		
		function funfill(){  
			let scheduleMap = new Map();
			scheduleMap.set('detailstype',$('#cmbtype').val());
			scheduleMap.set('pickuploc',$('#pickuploc').val());
			scheduleMap.set('pickuplocid',$('#hidpickuploc').val());
			scheduleMap.set('pickupad',$('#pickupad').val());
			scheduleMap.set('dropoffloc',$('#dropoffloc').val());
			scheduleMap.set('dropofflocid',$('#hiddropoffloc').val());
			scheduleMap.set('dropoffad',$('#dropoffad').val());
			scheduleMap.set('type',$('#type').val());
			scheduleMap.set('triptype',$('#triptype').val());
			scheduleMap.set('brand',$('#brand').val());
			scheduleMap.set('brandid',$('#hidbrandid').val());
			scheduleMap.set('model',$('#model').val());
			scheduleMap.set('modelid',$('#hidmodelid').val());
			scheduleMap.set('nos',$('#nos').val());
			scheduleMap.set('pax',$('#pax').val());
			scheduleMap.set('tariffdocno',$('#tariffdocno').val());
			scheduleMap.set('tariff',$('#tariff').val());
			scheduleMap.set('blockhours',$('#blockrs').val()==""?'0':$('#blockrs').val());
			scheduleMap.set('exhourrate',$('#exhrrate').val()==""?'0':$('#exhrrate').val());
			scheduleMap.set('nighttariff',$('#ntariff').val()==""?'0':$('#ntariff').val());
			scheduleMap.set('nightextrahour',$('#nehour').val()==""?'0':$('#nehour').val());
			scheduleMap.set('extradistancerate',$('#edrate').val());
			scheduleMap.set('extratimerate',$('#etrate').val());
			scheduleMap.set('gid',$('#gid').val());
			scheduleMap.set('tarifdetaildocno',$('#tarifdetaildocno').val());
			
			const mapArray = Array.from(scheduleMap.entries());
			const jsonString = JSON.stringify(mapArray);
			var alternatedays=0;
			if(document.getElementById("alternativechk").checked){
				 alternatedays=1;
			}
			var startdate=$("#servdate").val();  
			
			if(!document.getElementById("occend").checked){
				var noofvisit=$("#endocc").val();
			} else {
				var enddate=$("#enddate").val();
				var eddt =enddate.split('.');  
				var d2 = eddt[2] +"/"+ eddt[1] +"/"+ eddt[0];   
				var end_date = new Date(d2);
				if(start_date>end_date){  
					 swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Start date is greater than contract end date!!!'    
						});
					 return false;
				}
			}

			var stdt =startdate.split('.');  
			var d1 = stdt[2] +"/"+ stdt[1] +"/"+ stdt[0];
			
			var start_date = new Date(d1);
			
			var days=$("#cmbdays").val();
			var time="00:00";
			var daynos=$("#cmbdates").val();         
			if(document.getElementById("preferredtimechk").checked){
				time=$("#servtime").val();  
			}
			var serviceterm=$("#hidserviceterm").val(); 
			$("#loadingoverlay").fadeIn();
			
		  	$("#schdiv").load("schedulegrid.jsp?startdate="+startdate+"&enddate="+enddate+"&alternatedays="+alternatedays+"&days="+encodeURIComponent(days)+"&daynos="+encodeURIComponent(daynos)+"&time="+time+"&noofoccurrence="+noofvisit+"&serviceterm="+encodeURIComponent(serviceterm)+"&schdetails="+encodeURIComponent(jsonString)+"&id=1"); 
		}
		
		function saveValidations(maxdocname){
			var dataArray = new Array();
			var max = parseInt(maxdocname);
			 var data = $('#transferGrid').jqxGrid('getrows');
			 for (var i = 0; i < data.length; i++) {
				 if($('#cmbtype').val()==1){
					 var chksrvc = data[i].chkothersrvc=="undefined"||data[i].chkothersrvc==null||data[i].chkothersrvc==""?"0":data[i].chkothersrvc;
					 var estdist = data[i].estdistance=="undefined"||data[i].estdistance==null||data[i].estdistance==""?"0":data[i].estdistance;
					 var esttime = data[i].esttime=="undefined"||data[i].esttime==null||data[i].esttime==""?"0":data[i].esttime;
					 var tariff = data[i].tarif=="undefined"||data[i].tarif==null||data[i].tarif==""?"0":data[i].tarif;
					 var nos = data[i].nos=="undefined"||data[i].nos==null||data[i].nos==""?"1":data[i].nos;
					 var pax = data[i].pax=="undefined"||data[i].pax==null||data[i].pax==""?"0":data[i].pax;
					dataArray.push("T"+max+"::"+data[i].pickupdate+"::"+data[i].pickuptime+"::"+data[i].pickuplocationid+"::"+data[i].pickupaddress+"::"+data[i].dropofflocationid+"::"+data[i].dropoffaddress+"::"+data[i].brandid+"::"+data[i].modelid+"::"+nos+"::"+data[i].tarifdocno+"::"+chksrvc+"::"+data[i].gid+"::"+data[i].tarifdetaildocno+"::"+data[i].transfertype+"::"+estdist+"::"+esttime+"::"+tariff+"::"+data[i].exdistancerate+"::"+data[i].extimerate+"::"+data[i].triptype+"::"+pax);
				 } else if($('#cmbtype').val()==2){
					 var pdate = $('#transferGrid').jqxGrid('getcelltext',i,"pickupdate");
					 var tariff = data[i].tarif=="undefined"||data[i].tarif==null||data[i].tarif==""?"0":data[i].tarif;
					 var tariffdetaildocno = data[i].tarifdetaildocno=="undefined"||data[i].tarifdetaildocno==null||data[i].tarifdetaildocno==""?" ":data[i].tarifdetaildocno;
					 var tarifdocno = data[i].tarifdocno=="undefined"||data[i].tarifdocno==null||data[i].tarifdocno==""?" ":data[i].tarifdocno;
					 var gid = data[i].gid=="undefined"||data[i].gid==null||data[i].gid==""?" ":data[i].gid;
					 var nos = data[i].nos=="undefined"||data[i].nos==null||data[i].nos==""?"1":data[i].nos;
					 var chksrvc = data[i].chkothersrvc=="undefined"||data[i].chkothersrvc==null||data[i].chkothersrvc==""?"0":data[i].chkothersrvc;
					 dataArray.push("L"+max+"::"+pdate+"::"+data[i].pickuptime+"::"+data[i].pickuplocationid+"::"+data[i].pickupaddress+"::"+data[i].brandid+"::"+data[i].modelid+"::"+nos+"::"+tarifdocno+"::"+chksrvc+"::"+gid+"::"+data[i].blockhrs+"::"+tariffdetaildocno+"::"+data[i].transfertype+"::"+tariff+"::"+data[i].exhrrate+"::"+data[i].nighttarif+"::"+data[i].nightexhrrate); 
				 }
				 max++;
			 }
			savedata(dataArray);
		} 
		
		function savedata(dataArray){
			var bookdocno = $('#selectedrow').val();
			var typess = $('#cmbtype').val();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {   
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					if(parseInt(items)>0){
						 swal.fire({  
							    icon: 'success',
								title: 'Successful',
								text: 'Successfully Scheduled'    
							});
						 clearfields();
						 $('#modalschedule').modal('hide');
					}
				} else {}
			}
			x.open("GET","saveschedulegriddetails.jsp?data="+encodeURIComponent(dataArray)+"&bookdocno="+bookdocno+"&type="+typess, true);  
			x.send();
		}
		
		function clearfields(){
			
			$('#cmbtype').val("");
			$('#pickuploc').val("");
			$('#hidpickuploc').val("")
			$('#pickupad').val("");
			$('#dropoffloc').val("");
			$('#hiddropoffloc').val("");
			$('#dropoffad').val("");
			$('#type').val("");
			$('#triptype').val("");
			$('#brand').val("");
			$('#hidbrandid').val("");
			$('#model').val("");
			$('#hidmodelid').val("");
			$('#nos').val("");
			$('#pax').val("");
			$('#tariffdocno').val("");
			$('#tariff').val("");
			$('#blockrs').val("");
			$('#exhrrate').val("");
			$('#ntariff').val("");
			$('#nehour').val("");
			$('#edrate').val("");
			$('#etrate').val("");
			$('#gid').val("");
			$('#tarifdetaildocno').val("");
			$('#transferGrid').jqxGrid('clear');
			
		}
		
		function getdocname(){
			var bookdocno = $('#selectedrow').val();
			var cmbtypess = $('#cmbtype').val();
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {   
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					saveValidations(items);
				} else {}
			}
			x.open("GET","getmaxdocname.jsp?bookdocno="+bookdocno+"&type="+cmbtypess, true);  
			x.send();
		}
		</script>
        </div>
     </form>
</body>
</html>