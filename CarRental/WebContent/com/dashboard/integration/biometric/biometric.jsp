<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
<title>GIP Mgmt</title>
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
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;
	   background-color:red;
		background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);	
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
        		<div class="primarypanel custompanel">
        			<div style="display:flex;align-items:center;">
        				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
	          			<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
	        			<div class="dropdown" style="display:inline-block;">
	        				<button type="button" class="btn btn-default dropdown-toggle" id="btninfo" data-toggle="dropdown"><i class="fa fa-info-circle " data-toggle="tooltip" title="Info" data-placement="bottom" aria-hidden="true"></i></button>
		        			<ul class="dropdown-menu">
		    					<!-- <li style="padding-left:10px;"><span class="badge redClass" style="margin-right:10px;">&nbsp;</span>Back Jobs</a></li> -->
		  					</ul>
	        			</div>
	        			<select name="cmbbranch" id="cmbbranch" style="min-width:125px;" class="form-control"><option value="">--Select--</option></select>	
        			</div>
  					
        		</div>
        		<div class="actionpanel custompanel">
        			<div style="display:flex;align-items:center;">
        				<div>
        					<label style="margin-right:0.2rem;">From</label>
        					<div id="fromdate" style="margin-right:0.2rem;"></div>
        				</div>
        				<div>
        					<label style="margin-right:0.2rem;">To</label>
        					<div id="todate" style="margin-right:0.2rem;"></div>
        				</div>
        				
        				<button style="align-self:stretch;" type="button" class="btn btn-default" id="btnimport" data-toggle="tooltip" title="Import Data" data-placement="bottom"><i class="fa fa-download" aria-hidden="true"></i></button>
        				<button style="align-self:stretch;" type="button" class="btn btn-default" id="btnupload" data-toggle="tooltip" title="Mark Attendance" data-placement="bottom"><i class="fa fa-upload" aria-hidden="true"></i></button>
        			</div>
        			
        		</div>
        		<div class="otherpanel custompanel">
        			<div class="btn-group">
        				<button type="button" class="btn btn-default" id="btnpendingcheckout" data-toggle="tooltip" title="Pending Out" data-placement="bottom"><i class="fa fa-print" aria-hidden="true" ></i></button>
        				<span class="badge badge-notify">0</span>
        			</div>
        		</div>
        		<div class="textpanel custompanel">
        			<p class="h8"></p>
        		</div>
        	</div>
  		</div>
  		<div class="row">
  			<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  				<div id="importgriddiv"><jsp:include page="importGrid.jsp"></jsp:include></div>
  			</div>
  		</div>
  	</div>
  	<script src="../../../../js/sweetalert2.all.min.js"></script>
	<script src="../../../../vendors/select2/js/select2.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var oneMonthBefore=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
			$('#fromdate').jqxDateTimeInput('setDate', new Date(oneMonthBefore));
			getInitData();
			$('.page-loader').hide();
			$('#btnimport').click(function(){
				var fromdate=$('#fromdate').jqxDateTimeInput('val');
				var todate=$('#todate').jqxDateTimeInput('val');
				$('.page-loader').show();
				$.post('downloadData.jsp',{'fromdate':fromdate,'todate':todate},function(data,status){
					data=JSON.parse(data);
					$('.page-loader').hide();	
					if(data.errorstatus=="0"){
						Swal.fire({
							icon:'success',
							title: 'Success',
							text: 'Successfully imported'
						});
						$('#btnsubmit').trigger('click');
					}
					else{
						Swal.fire({
							icon:'warning',
							title: 'Warning',
							text: 'Not imported'
						});
						return false;
					}
				});
			});
			
			$('#btnupload').click(function(){
				var selectedrows=$('#importGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					Swal.fire({
						icon:'warning',
						title: 'Warning',
						text: 'Please select valid documents'
					});
					return false;
				}
				var attarray=new Array();
				for(var i=0;i<selectedrows.length;i++){
					var checkoutdate=$('#importGrid').jqxGrid('getcelltext',selectedrows[i],'checkoutdate');
					var checkindate=$('#importGrid').jqxGrid('getcelltext',selectedrows[i],'checkindate');
					var checkouttime=$('#importGrid').jqxGrid('getcelltext',selectedrows[i],'checkouttime');
					var checkintime=$('#importGrid').jqxGrid('getcelltext',selectedrows[i],'checkintime');
					var empid=$('#importGrid').jqxGrid('getcellvalue',selectedrows[i],'empid');
					var punchdocno=$('#importGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
					if(checkoutdate==null || checkoutdate=="undefined" || checkoutdate=="" || typeof(checkoutdate)=="undefined"){
						Swal.fire({
							icon:'warning',
							title: 'Warning',
							text: 'Please update checkout details'
						});
						return false;	
					}
					else{
						attarray.push({'empid':empid,'checkindate':checkindate,'checkintime':checkintime,'checkoutdate':checkoutdate,'checkouttime':checkouttime,'gridindex':selectedrows[i],'punchdocno':punchdocno});
					}
				}
				
				Swal.fire({
					  title: "Are you sure?",
					  text: "Do you want to mark attendance?",
					  icon: "warning",
					  showCancelButton: true,
					  confirmButtonColor: "#3085d6",
					  cancelButtonColor: "#d33",
					  confirmButtonText: "Yes"
					}).then((result) => {
					  if (result.isConfirmed) {
					    markAtt(attarray);
					  }
					});
			});
			$('#btnsubmit').click(function(){
				var fromdate=$('#fromdate').jqxDateTimeInput('val');
				var todate=$('#todate').jqxDateTimeInput('val');
				var brhid="";
				$('#importgriddiv').load('importGrid.jsp?id=1&brhid='+brhid+'&fromdate='+fromdate+'&todate='+todate);
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
	  			//$('#cmbbranch').select2();
			});
		}
		
		async function markAtt(attArray){
			for(var i=0;i<attArray.length;i++){
				var empid=attArray[i].empid;
				var checkindate=attArray[i].checkindate;
				var checkintime=attArray[i].checkintime;
				var checkoutdate=attArray[i].checkoutdate;
				var checkouttime=attArray[i].checkouttime;
				var gridindex=attArray[i].gridindex;
				var punchdocno=attArray[i].punchdocno;
				var url='markAtt.jsp?empid='+empid+'&checkindate='+checkindate+'&checkintime='+checkintime+'&checkoutdate='+checkoutdate+'&checkouttime='+checkouttime+'&punchdocno='+punchdocno;
	            const response = await fetch(url);
	          	const data = await response.json();
				console.log(data);
	          	if(data.errorstatus=="1"){
					$('.page-loader').hide();
					Swal.fire({
						icon:'warning',
						title: 'Warning',
						text: 'Not Updated'
					});
	        		return false;
				}
				else{
					$('#importGrid').jqxGrid('setcellvalue',gridindex,'attstatus',1);
	        		$('#importGrid').jqxGrid('refresh');
				}
				if(i==(attArray.length-1) && data.errorstatus=="0"){
					$('.page-loader').hide();
					Swal.fire({
						icon:'success',
						title: 'Success',
						text: 'Attendance Marked'
					});
				}
			}
		}
	</script>
  </body>
  </html>