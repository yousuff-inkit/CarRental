<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<title>Employee Analysis</title>           
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8"> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css"/>
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
 
 <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>
<script src="../../../../js/sweetalert2.all.min.js"></script>  
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
 
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
 	
    		 $('#btnsubmit').click(function(){    
    	        loads();      
    	        });
    		 
    		 $('#rtastatus').dblclick(function(){    
    			 funStatusLoad();  
     	       $('#modalstatusupdatesearch').modal('toggle');
    	     });
    		 
    		 $('#btnrtastatus').click(function(){  
    			 rtaElementsClear();
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 }
    			 $("#modalstatusupdate").modal('toggle'); 
    	     });
    		 
    		 $('#btnattach').click(function(){   
    	         	funAttachs(event);      
    	         });
    		 
    		 $('#btnstatussave').click(function(){  
    				console.log("Entered");
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
    					 				saveRtaStatus();
    								}
    						});
    			   });
    		 
    		 $('#btnexcel').click(function(){  
    	        	$("#empdiv").excelexportjs({ 
    	        		containerid: "empdiv",       
    	        		datatype: 'json', 
    	        		dataset: null, 
    	        		gridId: "employeeanalysis",     
    	        		columns: getColumns("employeeanalysis") ,   
    	        		worksheetName:"Employee Analysis"     
    	         	});  
    	        });
    		
    		 $('#btnleave').click(function(){    
    			 loadleavelist();
    			 $("#modalleavedetail").modal('toggle'); 
    	 	
    	     });
    		 
    		 $('#btndoc').click(function(){    
    			 loaddoclist();
    			 $("#modalexpirystatus").modal('toggle'); 
    	 	
    	     });
    		  
    		 $('#btnexpiry').click(function(){  
    			 $("#overlay, #PleaseWait").show(); 	
       		    $('#empdiv').load('employeeanalysisgrid.jsp?check=2');
    	     });
    		 
    		 $('#btnletter').click(function(){   
    			 var docno=document.getElementById("empdocno").value;
    			 if(docno==null || docno==""){
    				 swal.fire({
 					    icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document!'
 					});
    				return false;
    			 }
    			 letterOpen();
 	         });
        });

    	   function loads(){   
    		   $("#overlay, #PleaseWait").show();
       	       $('#empdiv').load('employeeanalysisgrid.jsp?check=1');
    	   }
    	   
    	   function loadleavelist(){
    		   var empdocno = $("#empdocno").val();
    		   $('#leavediv').load('leavelistgrid.jsp?empdocno='+empdocno+'&id='+1);
    	   }
    	   
    	   function loaddoclist(){
    		   var empdocno = $("#empdocno").val();
    		   $('#expirydiv').load('expirydetailsgrid.jsp?empdocno='+empdocno+'&check=1');
    	   }
    	   
    	   function loadexpirylist(){
    		   var empdocno = $("#empdocno").val();
    		   $('#empdiv').load('employeeanalysisgrid.jsp?empdocno='+empdocno+'&check=2');

    	   }
    	   
    	 function funAttachs(event){  
   			var branchid=document.getElementById("branchid").value; 
   	   		var docno=document.getElementById("empdocno").value;  
   	   		var url=document.URL;
   			var reurl=url.split("com/");
   	 		if(docno!="" && docno!="0"){                
   	   			var frmdet="EMP"; 
   	   			var fname="Employee Analysis";
   	   		    var  myWindow= window.open(reurl[0]+"com/common/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+branchid,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
   				myWindow.focus();
   	   		}else{   
   	   		swal.fire({
				    icon: 'warning',
					title: 'Warning',
					text: 'Please select a document!'
				});
				return;
		    }  
   }
    	   
   function letterOpen(){
	     var branchid=document.getElementById("branchid").value; 
	   	 var docno=document.getElementById("empdocno").value;
	   	 var dtype="EMP";  
	   	 var screenWidth = window.screen.width;
	   	 var screenHeight = window.screen.height; 
    	 window.open("<%=contextPath%>/com/letter/letter.jsp?formcode="+dtype+"&docno="+docno+"&brchid="+branchid,"E-Mail","menubar=0,resizable=1,width="+screenWidth+",height="+screenHeight);     
   }
   
   function funStatusLoad(){
		  $("#overlay, #PleaseWait").show();
		  var rtaavailable = $('#rtacardavailable').prop('checked')?1:0;
		  $('#statusupdatediv').load('statusupdategrid.jsp?check=1&isrtaavail='+rtaavailable);
	}
   
   
     
   function saveRtaStatus(){
	    var empdocno = $('#empdocno').val();
		var rtastatusdocno = $('#rtastatusdocno').val();               
		var rtastatuscode = $('#rtastatus').val();               
		var rtastatusdesc = $('#rtastatusdesc').val();  
		var rtaavailable = $('#rtacardavailable').prop('checked')?1:0;
		
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
					 $('#candidatediv').load('employeeanalysisgrid.jsp?check=1');
					 $('#rtastatus').val('');
					 $('#rtastatusdocno').val('');
					 $('#rtastatusdesc').val('');  
					 $('#modalstatusupdate').modal('hide'); 
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
		x.open("GET","savertastatusupdate.jsp?status="+rtastatusdocno+"&docno="+empdocno+"&description="+rtastatusdesc+"&statuscode="+rtastatuscode+"&isrtaavail="+rtaavailable,true);
		x.send();
   }
   
   function rtaElementsClear(){
	   	$('#rtastatus').val('');
	    $('#rtastatusdocno').val('');
	    $('#rtastatusdesc').val('');  
  }
   
  function funloadrtashow(){
	  var x=new XMLHttpRequest();
	  x.onreadystatechange=function(){
	  	if (x.readyState==4 && x.status==200)
		{
		  var items=x.responseText.trim();
			if(parseInt(items)>0){
				$('#btnrtastatus').show();
			} else {
				$('#btnrtastatus').hide();
			}
		}else{
		}  
	  }
		x.open("GET","showrtastatus.jsp",true);
		x.send();
   }
 </script>
</head>
<body onload="funloadrtashow();">
  <div class="container-fluid"> 
    <div class="row pad">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	       <div class="primarypanel custompanel1">
	        <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	     </div>
	     <div class="primarypanel custompanel1">  
	        <button type="button" class="btn btn-default" id="btnattach"  data-toggle="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btndoc"  data-toggle="tooltip" title="DocumentDetails" data-placement="bottom"><i class="fa fa-file-text" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnleave"  data-toggle="tooltip" title="LeaveDetails" data-placement="bottom"><i class="fa fa-user-times" aria-hidden="true"></i></button>        
	        <button type="button" class="btn btn-default" id="btnexpiry"  data-toggle="tooltip" title="ExpiryDetails" data-placement="bottom"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></button>   
	        <button type="button" class="btn btn-default" id="btnletter"  data-toggle="tooltip" title="Letter" data-placement="bottom"><i class="fa fa-envelope-o" aria-hidden="true"></i></button>                
	     	<button type="button" class="btn btn-default" id="btnrtastatus"  data-toggle="tooltip" title="RTA Status Update" data-placement="bottom"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>        
	     </div>
	     <div class="textpanel custompanel">       
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;width:75%">&nbsp;</p>                            
        </div>
        </div> 
     </div>
  <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      	 <div id="empdiv"><jsp:include page="employeeanalysisgrid.jsp"></jsp:include></div>          
      </div>
     </div>
     <div class="row">
	     <input type="hidden" name="branchid" id="branchid">        
	     <input type="hidden" name="empdocno" id="empdocno"> 
     </div>
     </div>
     
     	 
           <div id="modalleavedetail" class="modal fade" role="dialog">  
       	<div class="modal-dialog modal-lg">
           	<div class="modal-content">
             		<div class="modal-header">
               		<button type="button" class="close" data-dismiss="modal">&times;</button>   
               		<h4 class="modal-title">Leave Details<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
     					   <div class="row">  
     					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        					 <div id="leavediv"><jsp:include page="leavelistgrid.jsp"></jsp:include></div>          
   		                   </div> 
   		               </div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             			</div>
             		</div>
             		</div>
             		</div> 
             		<div id="modalexpirystatus" class="modal fade" role="dialog">  
       	<div class="modal-dialog modal-lg">
           	<div class="modal-content">
             		<div class="modal-header">
               		<button type="button" class="close" data-dismiss="modal">&times;</button>   
               		<h4 class="modal-title">Document Details<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
             		</div>
             		<div class="modal-body">
     					   <div class="row">  
     					      <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        					 <div id="expirydiv"><jsp:include page="expirydetailsgrid.jsp"></jsp:include></div>          
   		                   </div> 
   		               </div>
             		</div>
              		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             		</div>
             		 </div>
         </div>
        </div> 
        <div id="modalstatusupdate" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">RTA Status Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
             			<div class="row" > 
	             						<div class="col-md-3">
			    							<label class="control-label " for="rtacardavailable">RTA Card Available:</label>
			             				</div>
			    							<input type="checkbox" id="rtacardavailable" name="rtacardavailable"/>
		             	</div>
             			<div class="row"> 
		             				<div class="col-md-1">
		    							<label class="control-label " for="rtastatus">Status:</label>
		             				</div>
		             				<div class="col-md-3">
		      								<input type="text" class="form-control" id="rtastatus" name="rtastatus" readonly placeholder="press F3 to search" />
		             				</div>
		             				<div class="col-md-8">
		      								<input type="text" class="form-control" id="rtastatusdesc" name="rtastatusdesc" readonly />
		    						</div>
		    						<input type="hidden" id="rtastatusdocno" name="rtastatusdocno"/> 
  						</div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             			<button type="button" class="btn btn-default btn-primary" id="btnstatussave">Save Changes</button>  
             		</div>
             	</div>
             </div>
        </div> 
         <div id="modalstatusupdatesearch" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">RTA Status Search<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="statusupdatediv"><jsp:include page="statusupdategrid.jsp"></jsp:include></div>
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