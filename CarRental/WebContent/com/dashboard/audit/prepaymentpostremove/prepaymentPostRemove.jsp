<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Floor Management</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<jsp:include page="../../../../includes.jsp"></jsp:include>

<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.min.css">

<%-- <jsp:include page="../../../../includeswithoutcss.jsp"></jsp:include> --%>
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />

  <style type="text/css">
  	body {
		font: 12px Tahoma;
		background: #E0ECF8;
	}
	input[type="text"]{
		height: 34px;
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
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
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
	#modalequip .modal-body{
		background: #E0ECF8;
	}		
  </style>
</head>
<body>
	<div class="load-wrapp">
    	<div class="load-9">
        	<div class="spinner">
            	<div class="bubble-1"></div>
                <div class="bubble-2"></div>
            </div>
        </div>
    </div>
    <form autocomplete="off">
    <div class="container-fluid">
    	<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      		
      		<div class="primarypanel custompanel">
	                       <div class="col-md-4">
	                       <div class="col-md-11">
    						<div >
				           <label for="cmbpriority">Branch:</label>
      							<select name="cmbbranch" id="cmbbranch" style="min-width:125px;"><option value="">--Select--</option></select>
    						</div>  
    						</div>  
    						</div>
    						 <div class="col-md-3">
    						<label for="cmbpriority">From:</label>
    						<div>
      							<div id='fromdate' name='fromdate'></div>
    						</div> 
    						</div>
    					<div class="col-md-3">
    						<label for="cmbpriority">To:</label>
    						<div>
      							<div id='todate' name='todate'></div>      
			               </div> 	
			             </div>
			    </div>		
			      
				<div class="primarypanel custompanel">
  					<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
  				</div>
  				
        		<div class="otherpanel custompanel">
        			<button type="button" class="btn btn-default" id="btnunpost" data-target="#modalunpost"><i class="fa fa-times" aria-hidden="true" data-toggle="tooltip" title="Unpost" data-placement="bottom"></i></button>
        		</div> 
      
        	</div>
        </div>
        <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="masterdiv"><jsp:include page="masterGrid.jsp"></jsp:include></div>
        	</div>
        </div>
        <div class="row rowgap">
        	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div>
        	</div>
        </div>
        
        <div id="modalunpost" class="modal fade" role="dialog">
	    	<div class="modal-dialog">
	        	<div class="modal-content">
	          		<div class="modal-header">
	            		<button type="button" class="close" data-dismiss="modal">&times;</button>
	            		<h4 class="modal-title">Remove PrePayment Post</h4>
	          		</div>
	          		<div class="modal-body">
	            		<div class="container-fluid">
	            			<div class="form-horizontal">
  								<div class="form-group">
    								<label class="control-label col-sm-2" for="email">Remarks:</label>
    								<div class="col-sm-10">
      									<input type="text" name="remarks" id="remarks" class="form-control">
    								</div>
  								</div>
	            			</div>
	            		</div>
	            	</div>
	            	<div class="modal-footer text-right">
		            	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		            	<button type="button" class="btn btn-default btn-primary" id="btnunpostsave">Update</button>
		          	</div>
	          	</div>
	        </div>
	      </div>
	      
	</div>
	</form>
	
<script src="../../../../vendors/bootstrap-v3/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/select2.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			 
			var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
		    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
		    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
		    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
			
			$('[data-toggle="tooltip"]').tooltip(); 
			$('.load-wrapp').hide();
			
			getInitData();
			
			$('#btnsubmit').click(function(){
				$('.modal.fade.in').find('input:text').val('');
				$('.modal.fade.in').modal('hide');
				$('#detailGrid').jqxGrid('clear');
				
	        	var brhid=$('#cmbbranch').val();
	        	var fromdate=$('#fromdate').jqxDateTimeInput('val');
	        	var todate=$('#todate').jqxDateTimeInput('val');
	        	$('#masterdiv').load('masterGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
	        });
	        
			$('#btnunpost').click(function(){
				var selectedrows=$("#masterGrid").jqxGrid('selectedrowindexes');
	        	
	        	if(selectedrows.length<=0){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select any valid documents'
					});
					return false;
	        	}
	        	
				$("#modalunpost").modal('show');
			});
			
	        $('#btnunpostsave').click(function(){
	        	var selectedrows=$("#masterGrid").jqxGrid('selectedrowindexes');
	        	
	        	if(selectedrows.length<=0){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please select any valid documents'
					});
					return false;
	        	}
	        	if($('#remarks').val().trim()==''){
	        		Swal.fire({
						icon: 'error',
						title: 'Warning',
						text: 'Please enter remarks'
					});
					return false;
	        	}
	        	
	        	var docarray=new Array();
	        	for (i = 0; i < selectedrows.length; i++) {
	        		var doc_no=$('#masterGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
	        		var tr_no=$('#masterGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
					var brhid=$('#masterGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
					docarray.push(doc_no+"::"+tr_no+"::"+brhid);
				}
	        	
	        	Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to Unpost selected documents? \n Transactions cannot be rolled back!",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Yes'
				}).then((result) => {
					if (result.isConfirmed) {
						var remarks=$('#remarks').val();
						
						funSaveData(docarray,remarks)
						
					}
				});
	        });
		});
		
		function funSaveData(docarray,remarks){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = parseInt(x.responseText.trim());
					if(items==0){
						Swal.fire({
							icon: 'success',
							title: 'Success',
							text: 'Successfully Unposted'
						});
						$('#remarks').val('');
						$("#modalunpost").modal('hide');
						$('#btnsubmit').trigger('click');		
					}
					else{
						Swal.fire({
							icon: 'error',
							title: 'Warning',
							text: 'Not Unposted'
						});
					}
				}
			}
			x.open("GET","saveData.jsp?docarray="+docarray+"&remarks="+remarks, true);
			x.send();
		}
		
		$('#btnexcel').click(function(){
			$("#masterdiv").excelexportjs({  
				containerid: "masterdiv",
				datatype: 'json',
				dataset: null,
				gridId: "masterGrid",
				columns: getColumns("masterGrid"),
				worksheetName: "Remove Prepayment Post"
			});
			
			$("#detaildiv").excelexportjs({  
				containerid: "detaildiv",
				datatype: 'json',
				dataset: null,
				gridId: "detailGrid",
				columns: getColumns("detailGrid"),
				worksheetName: "Remove Prepayment Post Details"
			});
		});
		
		function getInitData(){
			$.get('getInitData.jsp',function(data){
				data=JSON.parse(data);
				var htmldata='';
				$.each(data.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			$('#cmbbranch').select2({'placeholder':'Select Branch','allowClear':true});
	  		});
		}
		
	</script>
</body>
</html>