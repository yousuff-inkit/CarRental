<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>Document Expiry</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../../../../js/animate/animate.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>            
<link rel="stylesheet" type="text/css" href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="../../../../vendors/select2/select2.min.css">
 
 <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="../../../../vendors/cookie/cookie.min.js"></script>
 
 <style>
 .pad{
 padding:10px;
 }
 .textpanel{
        color: blue;    
  		overflow:auto; 
  		width:250px;            
  }   
  .textpanel1{
        color: #00008B;    
  }   
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 10px; 
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 8px;  
    }
    .custompanel1{  
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
 </style>
 <script type="text/javascript">
 
 	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();
 	    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
        
        $("#uptodate").jqxDateTimeInput({
            width: '110px',
            height: '24px',
            formatString: "dd.MM.yyyy"
        });
        
        $("#tempDateInput").jqxDateTimeInput({
            formatString: 'dd.MM.yyyy',
            showCalendarButton: false
        });
       
        $("#pdate").jqxDateTimeInput({
            width: '110px',
            height: '24px',
            formatString: "dd.MM.yyyy"
        });
 	
    	$('#btnsubmit').click(function(){   
    		$('#showlabel').text('');
    		$('#empdocno').val('');
    		var branchval = 'a';
    		var uptodate = $('#uptodate').val();
    		$("#documentDetailsGrid").jqxGrid('clear');
    		$("#docexpdiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
    	});

    	$('#btnrenewalsave').click(function(){    
    		 Swal.fire({
					title: 'Are you sure?',
					text: "Do you want Update Changes?",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
						if (result.isConfirmed) {
			 				saveRenewalStatus();
						}
				});
    	});
    	
    	 $('#btnrenewallogsheet').click(function(){    
			 var emp = $('#empdocno').val();
			 if(emp==""){
				 Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
			 }
			 funLoadRenewalLog();
 	       $('#modalrenewallogsheet').modal('toggle');
 	     });
    		 
    		 
    	$('#btnprocessdoc').click(function(){  
    		 var emp = $('#empdocno').val();
			 if(emp==""){
				 Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
			 }
    		 getProcess()
    		 $('#modalexpiryprocess').modal('toggle');
    	});
    	
    	$('#renewalstatus').dblclick(function(){    
			funRenewalLoad();  
	       $('#modalrenewalprocessgrid').modal('toggle');
	     });
    	
    	$('#btnrenewal').click(function(){  
    		 var emp = $('#empdocno').val();
			 if(emp==""){
				 Swal.fire({
	        			icon: 'warning',
						title: 'Warning',
						text: 'Please select a document'
					});
	        		return false;
			 }
    		 $('#modalrenewalprocess').modal('toggle');
    	});

    	$('#btnsaveprocess').click(function(){  
    		funUpdate();
    	});
    		 
    	$('#btnexcel').click(function(){  
    		$("#docexpdiv").excelexportjs({ 
    	    	containerid: "docexpdiv",       
    	        datatype: 'json', 
    	        dataset: null, 
    	        gridId: "jqxdocumentsexpiry",     
    	        columns: getColumns("jqxdocumentsexpiry") ,   
    	        worksheetName:"Document Expiry"     
    	 	});  
    	 });
 	});
 	
 	function funRenewalLoad(){
 		var rowindex1=$('#selectrowid').val();
		var doct =  $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "doct");
		$("#overlay, #PleaseWait").show();
		$('#renewalprocessdiv').load('renewalgrid.jsp?check=1&doct='+encodeURIComponent(doct));
	}
 	
 	function saveRenewalStatus(){
 		var rowindex1=$('#selectrowid').val();
 		var empid = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "empdocno");
		var documentid = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "docid");
		var doct = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "doct");
		var rtastatusdocno = $('#renewalstatusdocno').val();               
		var rtastatuscode = $('#renewalstatus').val();               
		var rtastatusdesc = $('#renewalstatusdesc').val();  
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				if(parseInt(items)>0){
					 swal.fire({  
						    icon: 'success',
							title: 'Success',
							text: 'Successfully Updated'  
						});
					 var branchval = 'a';
			    	 var uptodate = $('#uptodate').val();
			    	 $("#documentDetailsGrid").jqxGrid('clear');
					 $("#docexpdiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
					 $('#renewalstatus').val('');
					 $('#renewalstatusdocno').val('');
					 $('#renewalstatusdesc').val('');  
					 $('#empdocno').val('');
					 $('#showlabel').text('');
					 $('#modalrenewalprocess').modal('hide'); 
				} else {
					swal.fire({  
					    icon: 'warning',
						title: 'Warning',
						text: 'Not Updated'  
					});
				}
			}
			else
			{
			}  
		}
		x.open("GET","saverenewalstatus.jsp?doct="+doct+"&docno="+empid+"&description="+rtastatusdesc+"&statuscode="+rtastatuscode+"&status="+rtastatusdocno+"&docId="+documentid,true);
		x.send();
 	}
 	
 	function funLoadRenewalLog(){
		 var empdocno = $("#empdocno").val();
		 $("#overlay, #PleaseWait").show();
   	     $('#renewallogsheetdiv').load('renewallogsheetgrid.jsp?check=1&docno='+empdocno);
	}
 	
 	function getProcess() {
 		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var categoryItems = items[0].split(",");
				var categoryIdItems = items[1].split(",");
				var optionscategory = '<option value="">--Select--</option>';
				for (var i = 0; i < categoryItems.length; i++) {
					optionscategory += '<option value="' + categoryIdItems[i] + '">'
							+ categoryItems[i] + '</option>';
				}
				//$("#cmbcategory").html(optionscategory);
				$('#processdropdown').html($.parseHTML(optionscategory));
	  			$('#processdropdown').select2({
	  				placeholder:"Select Category",
	  				allowClear:true
	  			});
				
			} else {
			}
		}
		x.open("GET", "getProcess.jsp", true);  
		x.send();
    }
 	
 	function funUpdate(){
 		var rowindex1=$('#selectrowid').val();
		var process = $('#processdropdown option:selected').text();
		var date =  $('#pdate').val();
		var branchid = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "brhid");
		var empdocno = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "empdocno");
		$('#tempDateInput').val($('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "expirydate"));
		var expirydate = $('#tempDateInput').val();
		var remarks = $('#txtremarks').val();
		var empid = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "empid");
		var documentid = $('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "docid");
		var document =$('#jqxdocumentsexpiry').jqxGrid('getcellvalue', rowindex1, "document");
		if(process==''){
			swal.fire({  
			    icon: 'warning',
				title: 'Warning',
				text: 'Please choose a process!'    
			});
			 return 0;
		 }

		 if(remarks==''){
			 swal.fire({  
				    icon: 'warning',
					title: 'Warning',
					text: 'Please Enter Remarks!'    
				});
			 return 0;
		 }
		 
		 Swal.fire({
				title: 'Are you sure?',
				text: "Do you want Update Changes?",
				icon: 'warning',
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: 'Yes'
			}).then((result) => {
					if (result.isConfirmed) {
						saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid);	
					}
			});
		
	}
	
	function saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200){
					var items=x.responseText;
					var process = $('#processdropdown').val('');
					$('#pdate').val(new Date());
					var remarks = $('#txtremarks').val('');
					$("#documentDetailsGrid").jqxGrid('clear');
					 swal.fire({  
						    icon: 'success',
							title: 'Success',
							text: 'Successfully Updated'  
					});
					var branchval = 'a';
		    		var uptodate = $('#uptodate').val();
		    		$('#empdocno').val('');
		    		$('#showlabel').text('');
					$("#docexpdiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
					$('#modalexpiryprocess').modal('hide');
			}
		}
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&empdocno="+empdocno+"&expirydate="+expirydate+"&remarks="+remarks+"&empid="+empid+"&document="+document+"&documentid="+documentid,true);
	x.send();
			
	}
 </script>
</head>
<body>
  <div class="container-fluid"> 
    <div class="row pad">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        	<div class="primarypanel custompanel1" style="">
        		<div class="form-group" style="display:flex; align-items:center; margin: 4px 0px; " >
        			<label>Upto Date :&nbsp;</label>
					<div id="uptodate"></div>
				</div>
        	
        	</div>
	       <div class="primarypanel custompanel1">
	        <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	     </div>
	     <div class="primarypanel custompanel1">  
	        <button type="button" class="btn btn-default" id="btnprocessdoc"  data-toggle="tooltip" title="Process" data-placement="bottom"><i class="fa fa-retweet" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnrenewal"  data-toggle="tooltip" title="Renewal" data-placement="bottom"><i class="fa fa-id-card-o" aria-hidden="true"></i></button>        
	     </div>
	       <div class="primarypanel custompanel1">  
		       <button type="button" class="btn btn-default" id="btnrenewallogsheet"  data-toggle="tooltip" title="Log" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>        
	        </div>
	     <div class="textpanel custompanel">       
			<p id="showlabel" style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        </div>
        </div> 
     </div>
  	 <div class="row">
     	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
       	 	<div id="docexpdiv"><jsp:include page="documentExpiryGrid.jsp"></jsp:include></div> 
      	</div>
     </div>
  	 <div class="row" style="margin-top:10px;">
      	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      		<div id="docexpdetaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div> 
      	</div>
     </div>
     
     
     <div class="row">
	     <input type="hidden" name="branchid" id="branchid">        
	     <input type="hidden" name="empdocno" id="empdocno"> 
	     <input type="hidden" name="selectrowid" id="selectrowid"> 
	      <div id="tempDateInput" style="display: none;"></div>
     </div>
     </div>
     <div id="modalexpiryprocess" class="modal fade" role="dialog">  
       	<div class="modal-dialog modal-lg">
           	<div class="modal-content">
             		<div class="modal-header">
               		<button type="button" class="close" data-dismiss="modal">&times;</button>   
               		<h4 class="modal-title">Process<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
	             		<div class="row">
	     					<div class="form-group">
	                    		<label class="col-sm-1 control-label" for="uptodate"> Date:</label>
	                    		<div class="col-sm-3">
	                        		<div id="pdate" style="border: 1px solid black" placeholder="" style="width:69%;"></div>
	                            	<span class="help-block hidden"></span>
	                    		</div>
                    			<label class="col-sm-1 control-label" for="cmbprocess" >Process:</label>
                    			<div class="col-sm-7">
                    				<select id="processdropdown" class="form-control" style="width: 75%">
                                        <option value="">--Select--</option>
                                    </select>
                    				<span class="help-block hidden"></span>
                    			</div>
                  			</div>
	             		</div>
	             		<div class="row-gap">&nbsp;</div>
	             		<div class="row">
	             			<div class="form-group">
	    						<label class="control-label col-sm-1" for="desc">Remarks:</label>    
	    						<div class="col-sm-11 input-container">
	      							<input type="text" id="txtremarks" class="form-control" name="txtremarks" style="width:85%;"  >     
	    						</div>
  							</div>
	             		</div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             			<button type="button" class="btn btn-default btn-primary" id="btnsaveprocess">Save Changes</button>
             		</div>
        	</div>
     	</div>
     </div>
     
     <div id="modalrenewalprocess" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Renewal<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
             			<div class="row"> 
		             				<div class="col-md-1">
		    							<label class="control-label " for="rtastatus">Status:</label>
		             				</div>
		             				<div class="col-md-3">
		      								<input type="text" class="form-control" id="renewalstatus" name="renewalstatus" readonly placeholder="press F3 to search" />
		             				</div>
		             				<div class="col-md-8">
		      								<input type="text" class="form-control" id="renewalstatusdesc" name="renewalstatusdesc" readonly />
		    						</div>
		    						<input type="hidden" id="renewalstatusdocno" name="renewalstatusdocno"/> 
  						</div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             			<button type="button" class="btn btn-default btn-primary" id="btnrenewalsave">Save Changes</button>  
             		</div>
             	</div>
             </div>
        </div> 
     
     	<div id="modalrenewalprocessgrid" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Renewal Search<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="renewalprocessdiv"><jsp:include page="renewalgrid.jsp"></jsp:include></div>
   		                    </div> 
   		                </div> 
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             		</div>
             	</div>
             </div>
        </div> 
        <div id="modalrenewallogsheet" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Log Sheet<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="renewallogsheetdiv"><jsp:include page="renewallogsheetgrid.jsp"></jsp:include></div>          
   		                   </div> 
   		                </div>
             		</div>
              		<div class="modal-footer">
          				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div>
             	</div>
         	</div>
        </div>     
</body>
</html>