<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<% String contextPath=request.getContextPath();%>
<head>
<title>Rider Management</title>
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
        				<div style="display:flex; align-items:center;">
 		       				<label for="todate" >Date : &nbsp; </label>
        					<div id="todate"></div>
        				</div>
        				<div style="margin-left:4px;">
	        				<select name="cmbbranch" id="cmbbranch" class="form-control" style="width:200px;"><option value="">--Select--</option></select>
        				</div>
	        			<div style="margin-left:4px;">
	  						<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
	          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	        			</div>
        			</div>
        		</div>
        		<div class="detailpanel custompanel">
          			<button type="button" class="btn btn-default" id="btnpost" ><i class="fa fa-file-text-o" aria-hidden="true" data-toggle="tooltip" title="Post" data-placement="bottom"></i></button>          			
          			<button type="button" class="btn btn-default" id="btnviewhr" ><i class="fa fa-external-link" aria-hidden="true" data-toggle="tooltip" title="Navigate to HR Statement" data-placement="bottom"></i></button>          			
          			<button type="button" class="btn btn-default" id="btnprintps" ><i class="fa fa-print" aria-hidden="true" data-toggle="tooltip" title="Print Payslip" data-placement="bottom"></i></button>          			
        		</div>
        		<div class="textpanel custompanel" style="max-width:300px;height:55px;display:flex;justify-content:center;align-items:center;">
					<p style="word-wrap: break-word;font-size:1.2rem;color:blue;">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="rpayrolldiv"><jsp:include page="riderpayrollgrid.jsp"></jsp:include></div>
      		</div>
    	</div>
  </div>
  <input type="hidden" name="empdocno" id="empdocno">
  <input type="hidden" name="rowindex" id="rowindex">
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
    	
    	
    	 $("#todate").jqxDateTimeInput({
             width: '110px',
             height: '30px',
             formatString:"dd.MM.yyyy",
             dropDownHorizontalAlignment: 'left', // Align dropdown
         });

    	
        $('[data-toggle="tooltip"]').tooltip();
        
        getInitData();
        $('.load-wrapp').hide();
        
       
        $('#btnsubmit').click(function(){
        	//$('.page-loader').show();
        	loadGrid();
        	var brhid=$('#cmbbranch').val();
        	//$('#maingriddiv').load('riderGrid.jsp?id=1&brhid='+brhid);
        });
        $('#btnviewhr').click(function(){
        	gethrstatementsetdetails()
        });
        
        $('#btnpost').click(function(){
        	Swal.fire({
	    		  title: "Are you sure?",
	    		  text: "Do you want to post data for selected rows",
	    		  icon: "warning",
	    		  showCancelButton: true,
	    		  confirmButtonColor: "#3085d6",
	    		  cancelButtonColor: "#d33",
	    		  confirmButtonText: "Update"
	    		}).then((result) => {
	    		  if (result.isConfirmed) {
		        	postData();
	    		  }
	    		});
        });
        
        $('#btnprintps').click(function(){
        	var date = $('#todate').jqxDateTimeInput('getDate');
    	    let month = date.getMonth() + 1;
    	    let year = date.getFullYear();
        	
	       	let selectedRowIndexes = $('#jqxriderpayroll').jqxGrid('getselectedrowindexes');
	       	
	        if(selectedRowIndexes.length<=0){
	   			  Swal.fire({
	   				  title: "Warning",
	   				  text: "No rows selected!",
	   				  icon: "warning"
	   				});
	      		  return false;
	   		  }	
	   		 
	 	    // Clear the array before adding new rows
	 		let updoc = "";
	 		let validselectedrows=0; 
	 		 selectedRowIndexes.forEach(index => {
	 	 	// Get row data by index
	 		let rowData = $('#jqxriderpayroll').jqxGrid('getrowdata', index);
	 		 //   let data = rowData.acno + "::" + "Rider Payroll of " + rowData.rider_name + "::" + rowData.curid + "::" + rowData.rate + "::" + rowData.netsalary*-1 + "::" + rowData.netsalary*-1 + "::" + "0" + "::" + "-1" + "::" + "0" + "::" + "JVT";
	 	 	if(rowData.ispayroll>0 && !(rowData.acno==null || rowData.acno=='null' || rowData.acno=='' || typeof(rowData.acno)=='undefined')){
	 		     updoc+=rowData.doc_no+","; 
	 		    validselectedrows++;
	 		}
	 		});
	 		if(selectedRowIndexes.length<=0 || validselectedrows<=0){
	   			  Swal.fire({
	   				  title: "Warning",
	   				  text: "No valid rows selected, please select posted documents!",
	   				  icon: "warning"
	   				});
	      		  return false;
	   		} else {
   			Swal.fire({
	    		  title: "Are you sure?",
	    		  text: "Do you want to print payslip for selected rows",
	    		  icon: "warning",
	    		  showCancelButton: true,
	    		  confirmButtonColor: "#3085d6",
	    		  cancelButtonColor: "#d33",
	    		  confirmButtonText: "Print"
	    		}).then((result) => {
	    		  if (result.isConfirmed) {
		        	printpayroll(updoc,month,year);
	    		  }
	    		});
   		  }	  
        	
        });
        
        
        $('#btnexcel').click(function(){
        	$("#jqxriderpayroll").excelexportjs({
				containerid: "jqxriderpayroll",
				datatype: 'json',
				dataset: null,
				gridId: "jqxriderpayroll",
				columns: getColumns("jqxriderpayroll"),
				worksheetName: "Rider Payroll Data"
			});
        });
        
       
        
        
    }); 
    	
    
    function printpayroll(updoc,month,year){ 
		var brchid=$('#cmbbranch').val();
   	 	var url=document.URL;
	 	var reurl=url.split("riderpayroll.jsp");
	 	var win= window.open(reurl[0]+"payrollprint?docnos="+updoc+"&branch="+brchid+"&year="+year+"&month="+month+"&formdetailcode=RPR","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    win.focus();   
    }
    
	function loadGrid(){
		var date = $('#todate').jqxDateTimeInput('getDate');
	    let month = date.getMonth() + 1;
	    let year = date.getFullYear();
		var brchid=$('#cmbbranch').val();
		if(brchid==null || brchid==0){
			   $.messager.show({
                   title: 'Message',
                   msg: 'Select Branch',
                   showType: 'show',
                   style: {
                       left: '',
                       right: 27,
                       top: document.body.scrollTop + document.documentElement.scrollTop,
                       bottom: ''
                   }
               });
			   return false;
		}
		$("#rpayrolldiv").load("riderpayrollgrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
	}
	
	function resetGrid() {
		  const selectedRowIndexes = $("#jqxriderpayroll").jqxGrid('getselectedrowindexes');
		  const selectedRowIds = selectedRowIndexes.map(index =>
		    $("#jqxriderpayroll").jqxGrid('getrowid', index)
		  );

		  $("#jqxriderpayroll").jqxGrid('updatebounddata', 'data'); // Refresh with original data

		  // Reapply selection
		  setTimeout(() => {
		    selectedRowIds.forEach(rowId => {
		      const index = $("#jqxriderpayroll").jqxGrid('getrowboundindexbyid', rowId);
		      if (index !== -1) {
		        $("#jqxriderpayroll").jqxGrid('selectrow', index);
		      }
		    });
		  }, 200);
	}
	
	function postData(){
		resetGrid();
		 let date =  $("#todate").val();
		// let sum = $("#jqxriderpayroll").jqxGrid('getcolumnaggregateddata', 'netsalary', ['sum']);
		let sum = 0; 
		
		 // Iterate over each row in the grid
		  let selectedRowIndexes = $('#jqxriderpayroll').jqxGrid('getselectedrowindexes');
    
    // Clear the array before adding new rows
    	  selectedRowsArray = [];
    
    // Loop through the selected row indexes
        let updoc = "";
    	  selectedRowIndexes.forEach(index => {
        // Get row data by index
        let rowData = $('#jqxriderpayroll').jqxGrid('getrowdata', index);
		  //   let data = rowData.acno + "::" + "Rider Payroll of " + rowData.rider_name + "::" + rowData.curid + "::" + rowData.rate + "::" + rowData.netsalary*-1 + "::" + rowData.netsalary*-1 + "::" + "0" + "::" + "-1" + "::" + "0" + "::" + "JVT";
        	if(rowData.ispayroll<=0 && !(rowData.acno==null || rowData.acno=='null' || rowData.acno=='' || typeof(rowData.acno)=='undefined')){
	     		sum+=rowData.netsalary;
	     		updoc+=rowData.doc_no+",";
	    		selectedRowsArray.push(rowData);	    	 
	     	}
		 });
    	  
    	  if(selectedRowsArray.length<=0){
    		  Swal.fire({
				  title: "Warning",
				  text: "Please select valid data",
				  icon: "error"
				});
    		  return false;
    	  }
    	  
		 // Log the resulting array
		  var brchid=$('#cmbbranch').val();
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
				var items=x.responseText.trim();
				items=JSON.parse(items);
				if(items>0){	
					loadGrid()
				//	$("#rpayrolldiv").load("riderpayrollgrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
					Swal.fire({
					      title: "Updated",
					      text: "Your data has been posted.",
					      icon: "success"
					    });
				} else {
					loadGrid()
					//$("#rpayrolldiv").load("riderpayrollgrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
					Swal.fire({
						  title: "Warning",
						  text: "Not posted",
						  icon: "error"
						});
				}
			} else{
			  }
			}
			x.open("POST","postpayroll.jsp?docno="+updoc+"&total="+sum+"&date="+date,true);
			x.send(JSON.stringify(selectedRowsArray));
		    
	}
	
	function funupdateremarks(month, year, remarks, adjustments, docno, fine, salik, extrasimused, insurance, advance, nsalary, rtaclass, fineperformance, labourcard, llogns,reason){
		var brchid=$('#cmbbranch').val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items=x.responseText.trim();
			items=JSON.parse(items);
			if(items>0){	
				$("#rpayrolldiv").load("riderpayrollgrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
				Swal.fire({
				      title: "Updated",
				      text: "Your data has been updated.",
				      icon: "success"
				    });
			} else {
				$("#rpayrolldiv").load("riderpayrollgrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
				Swal.fire({
					  title: "Warning",
					  text: "Not Updated",
					  icon: "error"
					});
			}
		} else{
		  }
		}
		x.open("GET","updateremarksandadjustment.jsp?docno="+docno+"&reason="+encodeURIComponent(reason)+"&adjustment="+encodeURIComponent(adjustments)+"&remarks="+encodeURIComponent(remarks)+"&year="+year+"&month="+month+"&brchid="+brchid+"&fine="+fine+"&salik="+salik+"&extrasimused="+extrasimused+"&insurance="+insurance+"&advance="+advance+"&nsalary="+nsalary+"&rtaclass="+rtaclass+"&fineperformance="+fineperformance+"&labourcard="+labourcard+"&llogns="+llogns+"&isupdated=1",true);
		x.send();
	}
	
	
	function funsetpanel(acno,name){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
			var items=x.responseText.trim();
			 $('.textpanel p').text(name+" - "+items.trim());
		}else{
			$('.textpanel p').text(name);
		}
		}
		x.open("GET","getbalanceforpanel.jsp?acno="+acno,true);
		x.send();
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
	
	
	function gethrstatementsetdetails(){
		 let selectedRowIndexes = $('#jqxriderpayroll').jqxGrid('getselectedrowindexes');
		  if(selectedRowIndexes.length>1){
			  Swal.fire({
				  title: "Warning",
				  text: "You have selected multiple rider, please select one!",
				  icon: "error"
				});
   		  return false;
		  }		  
		  
		  let rowData = $('#jqxriderpayroll').jqxGrid('getrowdata',selectedRowIndexes[0]);
		  let acno = rowData.acno;
		  
		  var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
				var items=x.responseText.split("::");
				let name = items[1].trim();
				let account = items[0].trim();
				
				funOpenHRStatement(acno,account,name);
			}else{
			}
			}
			x.open("GET","gethrstatementdatadetails.jsp?acno="+acno,true);
			x.send();
	}
	
	
	 function funOpenHRStatement(acno,account,acname){      
	
		 
    	  var path1="com/dashboard/accounts/accountsstatementtype/accountsStatementType.jsp";  
    	  var name="Accounts Statement HR";
    	  var url=document.URL;
    	  var reurl=url.split("com/");    
    	  var brhid = $("#cmbbranch").val();
    	  
    	  window.parent.formName.value = "Accounts Statement HR"; 
    	  window.parent.formCode.value = "ASHR";
    	  window.parent.branchid.value = brhid;  
    	  var detName = "Accounts Statement HR";  
    	  var mode = "A";
    	  var path= path1+"?acno="+acno+"&account="+account+"&acname="+acname+"&mod=A";          
    	  //console.log("path==="+path)
    	  top.addTab( detName,reurl[0]+""+path);  
        }
</script>
</body>
</html>
