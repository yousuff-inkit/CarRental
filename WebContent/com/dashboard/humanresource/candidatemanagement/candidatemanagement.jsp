<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<title>Candidate Management</title>           
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
	 
	
 	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');  
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");
          
     $("#processgroup").select2();
 	
    		 $('#btnsubmit').click(function(){   
    			document.getElementById('lblselectedrowlabel').innerHTML='';
    			$("#empdocno").val('');
    			$("#branchid").val('');
    	        loads();      
    	     });
    		 
    		 $('#btncreateemployee').click(function(){
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 } 
    			 
    			 Swal.fire({
 					title: 'Are you sure?',
 					text: "Do you want create an Employee?",
 					icon: 'warning',
 					showCancelButton: true,
 					confirmButtonColor: '#3085d6',
 					cancelButtonColor: '#d33',
 					confirmButtonText: 'Yes'
 				}).then((result) => {
 						if (result.isConfirmed) {
 							funOpenTab();
 						}
 				});
  		   });  
    		 
    		 $('#btnProcess').click(function(){   
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 }
     	       $('#modalstatusprocess').modal('toggle');
    	     });
    		 
    		 $('#rtastatus').dblclick(function(){    
    			 funStatusLoad();  
     	       $('#modalstatusupdatesearch').modal('toggle');
    	     });
    		 
    		 
    		 $('#visastatus').dblclick(function(){    
    			 funVisaLoad();  
     	       $('#modalvisaupdatesearch').modal('toggle');
    	     });
    		 
    		 
    		 $('#btnlogsheet').click(function(){    
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 }
    			 funLoadLog();
     	       $('#modallogsheet').modal('toggle');
     	     });
    		 
    		 $('#btnattach').click(function(){   
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 }
   			 	 funAttachs();  
    	     });

    		 $('#btnstatus').click(function(){  
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
    		
    		 $('#btnstatussave').click(function(){  
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
 
    		 
    		 $('#btnvisastatussave').click(function(){  
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
    			 				saveVisaStatus();
    						}
    				});
    	     });
    		 
    		 $('#btnmaildetails').click(function(){
     			//alert("Entered"); 
     			Swal.fire({
 					title: 'Are you sure?',
 					text: "Do you want to send a mail?",
 					icon: 'warning',
 					showCancelButton: true,
 					confirmButtonColor: '#3085d6',
 					cancelButtonColor: '#d33',
 					confirmButtonText: 'Yes'
 				}).then((result) => {
 						if (result.isConfirmed) {
 			 				funSendMail();
 						}
 				});
     		 });
    		
    		 //visa status button toggle 
    		 $('#btnvisastatus').click(function(){
    			 visaElementsClear();
    			 var emp = $('#empdocno').val();
    			 if(emp==""){
    				 Swal.fire({
 	        			icon: 'warning',
 						title: 'Warning',
 						text: 'Please select a document'
 					});
 	        		return false;
    			 }
    			 $('#modalvisaupdate').modal('toggle');
    	     });
    		
    		 
    		 $('#btnprocesssave').click(function(){  
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
    			 				saveRtaProcess();
    						}
    				});
    	     });
    		 
    		 $('#btnexcel').click(function(){  
    	        	$("#candidatediv").excelexportjs({ 
    	        		containerid: "candidatediv",       
    	        		datatype: 'json', 
    	        		dataset: null, 
    	        		gridId: "jqxCandidateManagementGrid",     
    	        		columns: getColumns("jqxCandidateManagementGrid") ,   
    	        		worksheetName:"Candidate Management"     
    	         	});  
    	        });
    		
    		 $('#btnchecklistsave').click(function(){   
    			 var brhid=document.getElementById("branchid").value;
    			 var gridarray=new Array();
    			 var rows=$('#jqxchecklistgrid').jqxGrid('getrows');
    			 var val=0,checksrno=0;
    			 for(var i=0;i<rows.length;i++){
    			    var chk=$('#jqxchecklistgrid').jqxGrid('getcellvalue',i,'chk');
    			    var mandatory=$('#jqxchecklistgrid').jqxGrid('getcellvalue',i,'mandatory');  
    				if(chk){  
    					 gridarray.push(rows[i].checksrno+" :: "+rows[i].remarks+" :: "+rows[i].path+" :: "+rows[i].upload+" :: ");            
    					 val++;
    				}else{
    					if(mandatory=="1"){      
    						checksrno=1;  
    					}
    				}
    			}
    			if(val==0){
    				$.messager.alert('Warning','Please select a checklist!');
    			    return false;
    			}

    			$.messager.confirm('Confirm', 'Do you want to save ?', function(r){
    				if (r){
    					var docNo = $("#empdocno").val() ;
    					funchecklistchanges(docNo,brhid,gridarray,checksrno,"CDM");  
    				}
    			});
    	     });
    		 
 });
    	
 			function funLoadLog(){
 				 var empdocno = $("#empdocno").val();
 				 $("#overlay, #PleaseWait").show();
 	       	     $('#logsheetdiv').load('logsheetgrid.jsp?check=1&docno='+empdocno);
 			}
	
    	   function loads(){   
    		   $("#overlay, #PleaseWait").show();
       	       $('#candidatediv').load('candidatemanagementgrid.jsp?check=1');
    	   }
    	   
    	   function funSendMail(){
    		   var userid = "<%= session.getAttribute("USERID").toString()%>";
    		   var branchid= "<%= session.getAttribute("BRANCHID").toString()%>";
    		   var docno=document.getElementById("empdocno").value;  
    		   var recipient = '';
    		   var msg = '';
    		   var  myWindow= window.open("<%=contextPath%>/com/emailnew/Email.jsp?recipient="+recipient+"&msg="+msg+"&dtype=CDM&formcode=CMG"+"&docno="+docno+"&brchid="+branchid+"&frmname=Candidate Master","_blank","Width=800,Height=730,resizable=1,meanubar=0");
			   myWindow.focus();
    	   }
    	   
    	   function funAttachs(){  
    		   var branchid=document.getElementById("branchid").value; 
    		   var docno=document.getElementById("empdocno").value;  
    		   var  myWindow= window.open("<%=contextPath%>/com/common/checklistmaster.jsp?formCode=CDM"+"&docno="+docno+"&brchid="+branchid+"&frmname=Candidate Master","_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			   myWindow.focus();
		   } 
    	   
    	   function funchecklistchanges(qottrno,brhid,checklist,checksrno,dtype){      
    			var x=new XMLHttpRequest();
    			x.onreadystatechange=function(){
    				if (x.readyState==4 && x.status==200){  
    					var items=x.responseText;
    						 if(parseInt(items.trim())==1){  	  
    							$('#checklistdiv').load('checklistgrid.jsp?check=1&docno='+qottrno+'&brhid='+brhid+'&dtype='+dtype);        
    							$.messager.alert('Success','Successfully Updated file');
    						 }else{
    							$.messager.alert('Warning','Please select a checklist!');
    						} 
    				}
    			}    
    			x.open("GET","<%=contextPath%>/com/common/checklistsavedata.jsp?qottrno="+qottrno+"&dtype="+dtype+"&brhid="+brhid+"&checklist="+encodeURIComponent(checklist),true);      
    			x.send();
    		}
    	   
    	   function funStatusLoad(){
				  $("#overlay, #PleaseWait").show();
				  $('#statusupdatediv').load('statusupdategrid.jsp?check=1');
			}
    	   
    	   function funVisaLoad(){
    		   $("#overlay, #PleaseWait").show();
			   $('#visaupdatediv').load('visaupdategrid.jsp?check=1');
    	   }
    	   
    	   function saveRtaStatus(){
    		    var empdocno = $('#empdocno').val();
				var rtastatusdocno = $('#rtastatusdocno').val();               
				var rtastatuscode = $('#rtastatus').val();               
				var rtastatusdesc = $('#rtastatusdesc').val();  
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
    						 $('#candidatediv').load('candidatemanagementgrid.jsp?check=1');
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
    			x.open("GET","savertastatusupdate.jsp?status="+rtastatusdocno+"&docno="+empdocno+"&description="+rtastatusdesc+"&statuscode="+rtastatuscode,true);
    			x.send();
    	    }
    	   
    	   function saveVisaStatus(){
   		    var empdocno = $('#empdocno').val();
				var visastatusdocno = $('#visastatusdocno').val();               
				var visastatuscode = $('#visastatus').val();               
				var visastatusdesc = $('#visastatusdesc').val();  
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
   						 $('#candidatediv').load('candidatemanagementgrid.jsp?check=1');
   						 $('#visastatusdesc').val('');
						 $('#visastatusdocno').val('');
						 $('#visastatus').val('');  
						 $('#modalvisaupdate').modal('hide'); 
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
   			x.open("GET","savevisastatusupdate.jsp?status="+visastatusdocno+"&docno="+empdocno+"&description="+visastatusdesc+"&statuscode="+visastatuscode,true);
   			x.send();
   	    }
    	   
    	   function funOpenTab(){
    		    var index =$('#rowid').val()
    		    var rowData = $("#jqxCandidateManagementGrid").jqxGrid('getrowdata', index);
    		   	var empname=rowData.name;
    			var dob=rowData.dob;
    			var nation=rowData.nation;
    			var nationid=rowData.ndocno;
    			var gender=rowData.gender;
    			var candidateid=rowData.docno;
    			var brch = $('#branchid').val();
    			
    			var path1="com/humanresource/setup/employeemaster/employeeMaster.jsp";  
   			 	var name="Employee Master";
   			 	var url=document.URL;
   				var reurl=url.split("com/");  

   		  		window.parent.formName.value="Employee Master";
   		  		window.parent.formCode.value="EMP";
   		  		window.parent.branchid.value=brch;
   		  		var detName="Employee Master";  
   		  		var mode="A";
   		   
   		  		var path= path1+"?mod="+mode+"&brhid="+brch+"&nationid="+nationid+"&nation="+nation+"&dob="+dob+"&name="+empname+"&gender="+gender+"&candidateid="+candidateid;     
   		   		top.addTab( detName,reurl[0]+""+path);
    	   }
    	   
    	   
    	   function saveRtaProcess(){
    		    var empdocno = $('#empdocno').val();
    		    var process = $('#processgroup option:selected').text();
    		    var processid = $('#processgroup').val(); 
    		    var remarks = $('#rtaprocessremarks').val(); 
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
   						 $('#candidatediv').load('candidatemanagementgrid.jsp?check=1');
   						 $('#rtastatus').val('');
					     $('#rtastatusdocno').val('');
					     $('#rtastatusdesc').val('');  
						 $('#modalstatusprocess').modal('hide'); 
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
   			x.open("GET","savertaprocess.jsp?processid="+processid+"&docno="+empdocno+"&process="+process+"&remarks="+remarks,true);
   			x.send();
    	   }
    	   
    	   function rtaElementsClear(){
    		   	$('#rtastatus').val('');
			    $('#rtastatusdocno').val('');
			    $('#rtastatusdesc').val('');  
    	   }
    	   
    	   function visaElementsClear(){
    		    $('#visastatusdesc').val('');
				$('#visastatusdocno').val('');
				$('#visastatus').val('');  
   	   	   }
 </script>
</head>
<body>
  <div class="container-fluid"> 
   
    <div class="row pad">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	       <div class="primarypanel custompanel1">
		       <button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
		       <button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
		       <button type="button" class="btn btn-default" id="btnattach"  data-toggle="tooltip" title="Attachment" data-placement="bottom"><i class="fa fa-paperclip" aria-hidden="true"></i></button>               
  			   		<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
  					<ul class="dropdown-menu">
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 1  -  Collect the document and send mail to training institute to book Induction Class</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 2  -  Follow up and get the Training Date</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 3  -  Inform the driver about training date, time and location (15 Days of Training)</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 4  -  Once training is complete collect the training certificate</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 5  -  once certificate is received, apply RTA etest on RTA portal and process the payment</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 6  -  Send the above given document along with training certificate & paymnet receipt to RTA to book E Test</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 7  -  Follow up with RTA to get E Test date</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 8  -  inform the driver about test date, time and location</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 9  -  If passed, ask the driver to complete RTA medical</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 10 -  Apply the RTA Card on RTA portal</a></li>
    					<li><a href=""><i class="fa fa-circle" style="margin-right:10px;color:#000814;"></i>Step 11 -  Inform the driver to download the RTA card from Dubai drive application and share with us to update the same in our record for system</a></li>
  						</ul>
	        </div>
	         <div class="primarypanel custompanel1">  
		       <button type="button" class="btn btn-default" id="btnstatus"  data-toggle="tooltip" title="RTA Status Update" data-placement="bottom"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button>        
		       <button type="button" class="btn btn-default" id="btnvisastatus"  data-toggle="tooltip" title="Visa Status Update" data-placement="bottom"><i class="fa fa-address-card-o" aria-hidden="true"></i></button>        
		       <button type="button" class="btn btn-default" id="btnProcess"  data-toggle="tooltip" title="Process" data-placement="bottom"><i class="fa fa-retweet" aria-hidden="true"></i></button>        
		       <button type="button" class="btn btn-default" id="btncreateemployee"  data-toggle="tooltip" title="Create Employee" data-placement="bottom"><i class="fa fa-user-plus" aria-hidden="true"></i></button>        
	           <button type="button" class="btn btn-default" id="btnmaildetails"  data-toggle="tooltip" title="Mail" data-placement="bottom"><i class="fa fa-envelope" aria-hidden="true"></i></button>        
	        </div>
	          <div class="primarypanel custompanel1">  
		       <button type="button" class="btn btn-default" id="btnlogsheet"  data-toggle="tooltip" title="Log" data-placement="bottom"><i class="fa fa-history" aria-hidden="true"></i></button>        
	        </div>
	        
	        <div class="textpanel custompanel">     
				<table>  
					<tr> 
					    <td align="left" width="80%"><label for="divid" id="lblselectedrowlabel" style="font-size:75%;"></label></td>  
					</tr>                                          
		  		</table>                      
        	</div>
        </div> 
     </div>
  	 <div class="row">
     	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      	 	<div id="candidatediv"><jsp:include page="candidatemanagementgrid.jsp"></jsp:include></div>  
      	</div>
     </div>
     <div class="row">
	     <input type="hidden" name="branchid" id="branchid">        
	     <input type="hidden" name="rowid" id="rowid">        
	     <input type="hidden" name="empdocno" id="empdocno"> 
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
        
        <div id="modalstatusprocess" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Process<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row"> 
		             				<label class="control-label col-md-1" for="processgroup">Process:</label>
	  								<div class="col-md-4 input-container">
	  						 	 		<select id="processgroup" class="form-control" name="processgroup" style="width: 80%">
	  						  				<option value="">--Select--</option>  
	  						  				<option value="1"> Client Approve </option>  
	  						  				<option value="2"> Decline </option> 
	  						  				<option value="3"> On Hold </option></select>  
	  								</div>
	  								<div class="col-md-1">
		    							<label class="control-label " for="rtaprocessremarks">Remarks:</label>
		             				</div>
		             				<div class="col-md-6">
		      								<input type="text" class="form-control" id="rtaprocessremarks" name="rtaprocessremarks"/>
		             				</div> 
  						</div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
             			<button type="button" class="btn btn-default btn-primary" id="btnprocesssave">Save Changes</button>    
             		</div>
             	</div>
             </div>
        </div> 
        
        
        <div id="modalchecklistattach" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Checklist<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="checklistdiv"><jsp:include page="../../../common/checklistgrid.jsp"></jsp:include></div>          
   		                   </div> 
   		                </div>
             		</div>
              		<div class="modal-footer">
          				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          				<button type="button" class="btn btn-default btn-primary" id="btnchecklistsave">Save Changes</button>  
          			</div>
             	</div>
         	</div>
        </div> 
 		<div id="modallogsheet" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Log Sheet<span></span></h4>  <label for="otherdetails2" id="lblotherdetails2"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     					   <div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="logsheetdiv"><jsp:include page="logsheetgrid.jsp"></jsp:include></div>          
   		                   </div> 
   		                </div>
             		</div>
              		<div class="modal-footer">
          				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div>
             	</div>
         	</div>
        </div>     
        
        <div id="modalvisaupdate" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Visa Status Update<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
             			<div class="row"> 
		             				<div class="col-md-1">
		    							<label class="control-label " for="rtastatus">Status:</label>
		             				</div>
		             				<div class="col-md-3">
		      								<input type="text" class="form-control" id="visastatus" name="visastatus" readonly placeholder="press F3 to search" />
		             				</div>
		             				<div class="col-md-8">
		      								<input type="text" class="form-control" id="visastatusdesc" name="visastatusdesc" readonly />
		    						</div>
		    						<input type="hidden" id="visastatusdocno" name="visastatusdocno"/> 
  						</div>
             		</div>
             		<div class="modal-footer"> 
             			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>  
             			<button type="button" class="btn btn-default btn-primary" id="btnvisastatussave">Save Changes</button>  
             		</div>
             	</div>
             </div>
        </div> 
        <div id="modalvisaupdatesearch" class="modal fade" role="dialog">  
       		<div class="modal-dialog modal-lg">
           		<div class="modal-content">
             		<div class="modal-header">
               			<button type="button" class="close" data-dismiss="modal">&times;</button>   
               			<h4 class="modal-title">Visa Status Search<span></span></h4>  <label for="otherdetails1" id="lblotherdetails1"></label>    
             		</div>
             		<div class="modal-body">
     					<div class="row">  
     						<div class="col-xs-12 col-sm-6 col-md-4 col-lg-12">  
   		        				<div id="visaupdatediv"><jsp:include page="visaupdategrid.jsp"></jsp:include></div>
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