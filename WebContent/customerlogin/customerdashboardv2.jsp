<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Customer Dashboard</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="../gatelogo.ico">
<link rel="stylesheet" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../vendors/animate/animate.min.css">
<%-- <jsp:include page="../includes.jsp"></jsp:include> --%>
<jsp:include page="../reportincludes.jsp"></jsp:include>
<link href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../vendors/select2/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />
<style>
	/* @import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
	@import url(https://fonts.googleapis.com/css?family=Teko:700); */
	:root {
  		/*--main-bg-color:#5867dd;
  			rgba(88,103,221,1)
  		*/
  		--main-bg-color:#0c447f;
  		--main-sec-color:#fff;
	}
	@font-face {
		font-family: Poppins-Regular;
	  	src: url('../vendors/poppins/Poppins-Regular.ttf'); 
	}
	
	@font-face {
	  	font-family: Poppins-Medium;
	  	src: url('../vendors/poppins/Poppins-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-Medium;
	  	src: url('../vendors/montserrat/Montserrat-Medium.ttf'); 
	}
	
	@font-face {
	  	font-family: Montserrat-SemiBold;
	  	src: url('../vendors/montserrat/Montserrat-SemiBold.ttf'); 
	}
	* {
		margin: 0px; 
		padding: 0px; 
		box-sizing: border-box;
	}
	html,body{
		width:100%;
		height:100%;
		background-color:#E9E9E9;
		font-family: Poppins-Regular, sans-serif;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	
	.txt2 {
	  	font-family: Poppins-Regular;
	  	font-size: 14px;
	  	color: #999999;
	  	line-height: 1.5;
	}
	.rowgap{
    	margin-bottom:6px;
    }
	.page-loader{
		width:100vw;
		height:100vh;
		background-color:rgba(255,255,255,0.5);
		position:relative;
		z-index:9999999;
	}
	.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
		background-color: var(--main-bg-color);
    	border-color: var(--main-bg-color);
		color:#fff;
		position:fixed;
		top:50%;
		left:50%;
		transform:translate(-50%,-50%);
		
	}
	.custom-tabs li a,.custom-tabs li{
		color:rgba(0,0,0,0.5);
	}
	.custom-tabs li.active a,.custom-tabs li.active,.custom-tabs li.focus a,.custom-tabs li.focus{
		color:var(--main-bg-color);
	}
	.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-bottom: 5px;
	}
	.card-container .card-header{
		width: 100%;
		text-align: center;
		padding-top: 10px;
		padding-bottom: 5px;
	}
	.card-container .card-body{
		width: 100%;
		padding-left: 10px;
		padding-right: 10px;
	}
	.card-container .card-body .list-group .list-group-item{
		margin-bottom: 10px;
		border-radius: 25px;
	}
	.card-container .card-body .list-group .list-group-item .badge{
		background-color: rgba(0,0,0,.05);
		color: #000;
	}
	.txt1 {
	  	font-family: Montserrat-SemiBold;
	  	font-size: 16px;
	  	color: #555555;
	  	line-height: 1.5;
	}
	.card-body h1.txt1{
		font-size: 26px;
		margin-top: 5px;
	}
	.primary{
		color:var(--main-bg-color);
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
    .datepanel div{
    	display:inline-block;
    }
    .datepanel{
    	/* height:54px;*/
    	padding-top:20px;
    }
    
     .monthpanel div{
    	display:inline-block;
    }
    .monthpanel{
    	/*height:54px;*/
    	
    }
    .stmtpanel{
    	/*height:54px;*/
    	padding-top:15px;
    }
    .textpanel p.h4{
   		margin-top: 8px;
    	margin-bottom: 6px;
    }
	
.admin-cover .panel-body{
	border:none;
}

.card-container{
		width: 100%;
		background-color: #fff;
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
		padding-top: 10px;
	}
	.card-container .card-icon-wrapper{
		width: 30%;
		display: inline-block;
		clear: both;
		float: left;
		padding-left: 10px;
		padding-right: 10px;
		
	}
	.card-container .card-detail-wrapper{
		width: 70%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-detail-wrapper{
		width: 50%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container.card-expand .card-expand-wrapper{
		width: 18%;
		display: inline-block;
		padding-left: 10px;
	}
	.card-container .card-detail-wrapper p:nth-child(1){
		margin-top: 5px;
		margin-bottom: 2px;
	}
	.centered{
	    margin: 0 auto;
	}
	.custom-tabs li.active a, .custom-tabs li.active, .custom-tabs li.focus a, .custom-tabs li.focus {
    	color: #fff;
	}
	.nav-pills>li.active>a, .nav-pills>li.active>a:focus, .nav-pills>li.active>a:hover {
	    color: #fff;
	    background-color: var(--main-bg-color);
	}
	.contact-container{
		width:100%;
		background-color:#fff;
	}
	.contact-header{
		background-image:url("images/bg-02.jpg");
		background-size:cover;
		background-repeat:no-repeat;
		background-position:center top;
	}
	.boxshadow1{
		box-shadow: 0 9px 16px 0 rgba(153,153,153,.25);
	}
	#tblexenq tbody tr.active td,#tblexend tbody tr.active td{
		color: #fff;
	    background-color: var(--main-bg-color);
	}
	#tblexend tbody tr.active td span.badge{
		background-color:#fff;
		color:var(--main-bg-color);
	}
	#tblexenq tbody tr{
		cursor:pointer;
	}
	.btn-outline-primary{
	    color: var(--main-bg-color);
	    background-color: transparent;
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	.btn-outline-primary:hover,.btn-outline-primary:focus,.btn-outline-primary:active{
	    color: #fff;
	    background-color: var(--main-bg-color);
	    background-image: none;
	    border-color: var(--main-bg-color);
	}
	
	#tblcontracts .btn-group .btn {  
	    float: none;
	    display: inline-block;
	}
	
	#tblcontracts .table-responsive {
	  overflow-y: visible !important;
	}
	.custom-navbar{
		background-color:var(--main-bg-color);
		color:var(--main-sec-color);
	}
	.custom-navbar .navbar-brand,.custom-navbar .navbar-brand:hover,.custom-navbar .navbar-brand:active,.custom-navbar .navbar-brand:focus{
		color:var(--main-sec-color);
	}
	.custom-navbar .user-dropdown-text,#myNavbar .fa-user,#myNavbar .caret{
		color:var(--main-sec-color);
	}
	.contact-header-img .img-thumbnail{
		background-color:var(--main-bg-color);
		border-color:var(--main-bg-color);
	}
	.custom-navbar .dropdown.open .user-dropdown-text,#myNavbar .dropdown.open .fa-user,#myNavbar .dropdown.open .caret{
		color:var(--main-bg-color);
	}
	:not(#feeddate) .jqx-datetimeinput .jqx-icon{
		top: 20%;
    	left: 10%;
	}
	.tblfeed tbody tr.active td{
		background-color:var(--main-bg-color);
		color:var(--main-sec-color);
	}
	
	.primarypanel{
		text-align:center;
	}
	@media (max-width: 767px) {
		.primarypanel{
			width:100%;

		}
		.primarypanel button{
			text-align:center;
		}
    	.primarypanel label{
    		margin-top:0.5rem;
    		margin-bottom:0.5rem;
    		display:block;
    	}
    	.datepanel{
    		padding-bottom:0.5rem;
    	}
    	.primarypanel .dropdown{
    		display:block;
    	}
	}
</style>
<script type="text/javascript">
	function preventBack() { window.history.forward(); }
    setTimeout("preventBack()", 0);
    window.onunload = function () { null };
</script>
</head>
<body>
	<div class="page-loader">
		<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
	</div>
	<nav class="navbar navbar-default navbar-fixed-top custom-navbar">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span>
        			<span class="icon-bar"></span> 
      			</button>
      			<a class="navbar-brand" href="#" style="padding-top: 2px;padding-bottom: 2px;padding-left: 15px;padding-right: 15px;">
      				<span style="margin-right:10px;">
      					<img alt="" src="images/comp-logo.jpg" style="width:auto; height: 100%;">
      				</span>
      				CRM Dashboard
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
      				<li class="dropdown">
        				<a class="dropdown-toggle client-dropdown" data-toggle="dropdown" href="#"><i class="fa fa-user-plus"></i> <span class="user-dropdown-text" id="clientid">Switch User</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu client-dropdownlist" >
        				
        				</ul>
    	        	</li>
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="">Account</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">	
          					<%
          					String redirect=request.getParameter("redirect")==null?"":request.getParameter("redirect");
          					if(redirect.equalsIgnoreCase("1")){%>
          					<li><a href="#" onclick="location.replace('https://alhabtoor.fly7c.com');">Sign Out</a></li>
          					<%}else{%>
          					<li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li>
							<%}%>
          					<!-- <li><a href="#">Change Password</a></li> -->
        				</ul>
      				</li>
      				
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60">
    		<li class="active"><a data-toggle="pill" href="#menu-dashboard"><i class="fa fa-home p-r-5"></i>Dashboard</a></li>
    		<li><a data-toggle="pill" href="#menu1"><i class="fa fa-credit-card p-r-5" id="accsts"></i>Account Statement</a></li>
    		<li><a data-toggle="pill" href="#menu2"><i class="fa fa-file-text p-r-5" id="invlist" ></i>Invoice List</a></li>
    		<li><a data-toggle="pill" href="#menutrafficinv"><i class="fa fa-exclamation-circle p-r-5"></i>Document Expiry List</a></li>
    		<li><a data-toggle="pill" href="#menufeedback"><i class="fa fa-comments p-r-5"></i>Customer Queries</a></li>
    		<li><a data-toggle="pill" href="#menu4"><i class="fa fa-users p-r-5"></i>Customer Helpdesk</a></li>
  		</ul>

  		<div class="tab-content">
  			<div id="menufeedback" class="tab-pane fade">
  				<div class="container-fluid">
  					<div class="row m-t-10">
  						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  							<div class="panel panel-default">
  								<div class="panel-heading">
  									<strong class="panel-title" style="font-size:14px;">Existing Queries</strong>
  								</div>
  								<div class="panel-body">
  									<div class="form-horizontal form-feed">
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="cmbfeedregno">Reg No:</label>
		    								<div class="col-sm-9">
		      									<%-- <select class="form-control" name="cmbfeedregno" id="cmbfeedregno" style="width:100%;">
		      										<option value="">--Select--</option>
		      									</select> --%>
		      									<div class="dropdown">
		      										<input type="text" id="feedregno" name="feedregno" placeholder="Reg No" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('feedregno');">
		      										<ul class="dropdown-menu" id="regnoid" style="width:100%;">
		      											
		      										</ul>
		      										
		      									</div>
		      									
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedcalledby">Called By:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedcalledby" id="feedcalledby" class="form-control" placeholder="Called By">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedmobile">Mobile:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedmobile" id="feedmobile" class="form-control" placeholder="Mobile No">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    							 	<label class="control-label col-sm-3" for="cmbfeedtype">Type:</label>
		    								<div class="col-sm-9">
		      									<%-- <select class="form-control" name="cmbfeedtype" id="cmbfeedtype" style="width:100%;">
		      										<option value="">--Select--</option>
		      									</select> --%>
		    									
		    								<div class="dropdown">
		      										<input type="text" id="feedtypee" name="feedtypee" placeholder="Type" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('feedtypee');">
		      										<ul class="dropdown-menu" id="typeid" style="width:100%;">
		      											
		      										</ul>
		      										
		      									</div>
		    								</div> 
		    								
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedplace">Place:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedplace" id="feedplace" class="form-control" placeholder="Place">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feedremarks">Remarks:</label>
		    								<div class="col-sm-9">
		      									<input type="text" name="feedremarks" id="feedremarks" class="form-control" placeholder="Remarks">
		    								</div>
		  								</div>
		  								<div class="form-group">
		    								<label class="control-label col-sm-3" for="feeddate">Date &amp; Time:</label>
		    								<div class="col-sm-9">
		      									<div id="feeddate"></div>
		    								</div>
		  								</div>
		  							</div>		
  								</div>
  								<div class="panel-footer text-right">
  									<button type="button" class="btn btn-default" id="btnfeedclear">Clear</button>
      								<button type="button" class="btn btn-default btn-primary" id="btnfeedsave">Save Changes</button>
  								</div>
  							</div>
  							
  						</div>
  						<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  							<div class="panel panel-default">
  								<div class="panel-heading">
  									<strong class="panel-title" style="font-size:14px;">Existing Queries</strong>
  								</div>
  								<div class="panel-body table-responsive" style="height:400px;overflow-y:auto;">
  									<table class="table tblfeed">
  										<thead>
  											<tr>
  												<th>Reg.No</th>
  												<th>Date</th>
  												<th>Called By</th>
  												<th>Type</th>
  												<th>Status</th>
  												<th>Attach</th>
  											</tr>
  										</thead>
  										<tbody>
  										</tbody>
  									</table>
  								</div>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
    		<div id="menutrafficinv" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btndocexpsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btndocexpexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				  				<div id="traffictodate"></div>
				        	</div>
				        </div>
					</div>
					
					<div class="row rowgap">
						<div class="table-responsive">
							<table class="table tbl-docexlist">
								<thead>
									<tr>
										<th>Name</th>
										<th>Mobile No</th>
										<th>Salesman</th>
										<th>Document</th>
										<th>Expiry Date</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					
					
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="docexpdiv"><jsp:include page="documentExpiryGridv2.jsp"></jsp:include></div> 
						</div>
					</div>
				</div>
    		</div>
    		<div id="menu-dashboard" class="tab-pane fade in active">
    			<div class="container-fluid m-t-20">
    				<div class="panel panel-default admin-cover animated fadeInDown" id="admin-cover">
	  					<div class="panel-body">
	    					<p style="margin-bottom:0;display:inline-block;" class="fs-12"><strong>Hi User</strong>, Your Analytics are all set</p>
	    					<button type="button" class="close" data-target="#admin-cover" data-dismiss="alert"  style="display:inline-block;">
	    						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        	</button>
	  					</div>
					</div>
    				<div class="row">
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn advance" id="accsum"> 
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/total.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Account Summary</p>
									<span class="value">0.00</span>
								</div>
							</div>
						</div>
						<!--<div class="col-xs-12 col-sm-6 col-md-3 col-lg-2">
							<div class="card-container img-rounded m-b-10 animated zoomIn pdcinhand">
								<div class="card-icon-wrapper text-center">
									<img src="images/icons/pdcinhand.png">
								</div>
								<div class="card-detail-wrapper">
									<p>PDC In Hand</p>
									<p><strong>AED <span class="value">15245.56</span></strong></p>
								</div>
							</div>
						</div>-->
						<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
							<div class="card-container img-rounded m-b-10 animated zoomIn total" id="invoicelst">
								<div class="card-icon-wrapper text-center">
									<!-- <img src="https://img.icons8.com/color/48/000000/total-sales-1.png"> -->
									<img src="images/icons/advance.png">
								</div>
								<div class="card-detail-wrapper">
									<p>Invoice</p>
									<span class="value">0.00</span>
								</div>
							</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn unapplied" id="docexp">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/unapplied.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Document Expiry</p>
							    <span class="value">0</span>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3">
						<div class="card-container img-rounded m-b-10 animated zoomIn balance" id="atchmt">
							<div class="card-icon-wrapper text-center">
								<img src="images/icons/balance.png">
							</div>
							<div class="card-detail-wrapper">
								<p>Attachment</p>
								
								<span class="value">0</span>
								
							</div>
						</div>
					</div>
				</div>
				<div class="row m-t-10">
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
						<div class="panel panel-default chart-panel widget-fleetdistchart">
							<div class="panel-heading">
			                    <h4 class="panel-title">
			                       <%--  <div class="btn-group pull-right" style="margin-top:-7px;margin-right:-7px;">
			                            <button class="btn dropdown-toggle" data-toggle="dropdown">
			                                <span class="filter-text p-r-5"></span><i class="caret"></i>
			                            </button>
			                            <ul class="dropdown-menu dropdown-menu-right">
			                                <li><a data-target="#" data-filter="brandname">Brand wise</a></li>
			                                <li><a data-target="#" data-filter="modelname">Model wise</a></li>
			                                <li><a data-target="#" data-filter="groupname">Group wise</a></li>
			                                <li><a data-target="#" data-filter="yom">YoM wise</a></li>
			                            </ul>
			                        </div> --%>
			                        <span class="panel-title-text fs-12"><strong>Monthwise Transactions</strong></span>
			                    </h4>
			                </div>
							<div class="panel-body" style="overflow-y:auto;border:none;">
								<div class="chart-container">
									<canvas id="chartfleetdist"></canvas>
								</div>
								<div class="chartfleetdist-legend-container"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
						<div class="panel panel-default chart-panel widget-livefleet">
			  				<div class="panel-heading">
			                    <h4 class="panel-title">
			                         <div class="btn-group pull-right" style="margin-top:-7px;margin-right:-7px;">
			                            <button class="btn dropdown-toggle" data-toggle="dropdown">
			                                <span class="filter-text p-r-5"></span><i class="caret"></i>
			                            </button>
			                            <ul class="dropdown-menu dropdown-menu-right">
			                                <li><a data-target="#" data-filter="brandname">Brand wise</a></li>
			                                <li><a data-target="#" data-filter="modelname">Model wise</a></li>
			                                <li><a data-target="#" data-filter="groupname">Group wise</a></li>
			                                <li><a data-target="#" data-filter="yom">YoM wise</a></li>
			                            </ul>
			                        </div> 
			                        <span class="panel-title-text fs-12"><strong>Live Fleets</strong><span class="custom-badge1 badge" style="margin-left: 10px;border-radius: 4px;margin-top: -3px;"></span></span>
			                    </h4>
			                </div>
			  				<div class="panel-body" style="height:310px;overflow:auto;border:none;">
			  					<div class="widget fleetlist">
			  						<ul class="list-group">
		  								 
									</ul>
			  					</div>
			  				</div>
						</div>		
					</div>
				</div>
    		</div>
    		
    	</div>
    		<div id="menu1" class="tab-pane fade">
      			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	
				        	
				        		<div class="primarypanel custompanel datepanel">
				        		<label class="checkbox-inline" style="margin-top: -10px;"><input type="checkbox" value="" id="chkbtwdtacc" onclick="setaccdtecheck();">Use Between Dates</label>
				  				<div id="fromdate"></div>
				  				<div id="todate"></div>
				  				</div>
				  				
				  			<div class="primarypanel custompanel monthpanel m-t-5 m-b-5">
				  			      <label class="checkbox-inline" style="margin-top: -10px;"><input type="checkbox" value="" id="chkaccmonthyear" onclick="setacccheck();">Use Between Month & Year</label>
				  				
				  			      <div class="dropdown">
				  			      <button type="button" id="accmonth" name="accmonth" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Choose Month</button>
				  			      <!-- <input type="text" id="accmonth" name="accmonth" placeholder="Month" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('accmonth');"> -->
		      					  <ul class="dropdown-menu" id="accmonthid" style="width:100%;">
		      						<li><a data-target="#" data-month="1">January</a></li><li><a data-target="#" data-month="2">February</a></li><li><a data-target="#" data-month="3">March</a></li><li><a data-target="#" data-month="4">April</a></li><li><a data-target="#" data-month="5">May</a></li><li><a data-target="#" data-month="6">June</a></li>
		      						<li><a data-target="#" data-month="7">July</a></li><li><a data-target="#" data-month="8">August</a></li><li><a data-target="#" data-month="9">September</a></li><li><a data-target="#" data-month="10">October</a></li><li><a data-target="#" data-month="11">November</a></li><li><a data-target="#" data-month="12">December</a></li>																											
		      					  </ul>
		      					   <input type="hidden" id="hidaccmonth" name="hidaccmonth" >
		      					  </div>
		      					   <div class="dropdown">
		      					   <button type="button" id="accyr" name="accyr" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Choose Year</button>
				  			      <input type="hidden" id="hidaccyr" name="hidaccyr" >
		      					  
		      					   <!-- <input type="text" id="accyr" name="accyr" placeholder="Year" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('accyr');">
		      					    --><ul class="dropdown-menu" id="accyrid" style="width:100%;">
		      											
		      					   </ul>
		      					   </div>
		      				       </div>
		      				 
				        	
				        		<div class="primarypanel custompanel">
				        	<button class="btn btn-default" id="btnacstmt">Statement Print</button>
				        		<button class="btn btn-default" id="btnoutstanding">Outstanding Statement</button>
				        		 <button class="btn btn-default hidden" id="btnstmtprint" data-toggle="tooltip" title="Document Print"><i class="fa fa-print"></i></button> 
				        		<button class="btn btn-default hidden" id="btnstmtattach"><i class="fa fa-paperclip"></i></button>
				        	</div>
				        	
				        </div>
					</div>
					<div class="row rowgap">
						<div class="table-responsive">
							<table class="table tbl-acstmt" id="tblacstmt">
								<thead>
									<tr>
										<th>Date</th>
										<th>Type</th>
										<th>Doc No</th>
										<th>Branch</th>
										<th>Branch ID</th>
										<th>Description</th>
										<th align="right" class="text-right">Dr</th>
										<th align="right" class="text-right">Cr</th>
									</tr>
								</thead>
								<tbody></tbody>
								
							</table>
						</div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="accountsStatementDiv"><jsp:include page="accountsStatementTypeGridv2.jsp"></jsp:include></div> 
						</div>
					</div>
					<%-- <div class="row">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<table width="100%">
								 
								 
								 <tr>
								 
								 <td width="5%"  align="right" style="font-size: 12px;font-weight: bold;">Dr Amount :&nbsp;</td>
			        			 <td width="10%" align="left"><input class="textbox form-control" id="dramount" name="dramount" style="width:90%;text-align: left;" value='<s:property value="dramount"/>'/></td>
							
							    <td width="30%"  align="right" style="font-size: 12px;font-weight: bold;">Cr Amount :&nbsp;</td>
			        			<td width="10%" align="left"><input class="textbox form-control" id="cramount" name="cramount" style="width:90%;text-align: left;" value='<s:property value="cramount"/>'/></td>
							
									<td width="36%"  align="right" style="font-size: 12px;font-weight: bold;">Net Amount :&nbsp;</td>
			        				<td width="10%" align="left"><input class="textbox form-control" id="txtnetamount" name="txtnetamount" style="width:90%;text-align: right;" value='<s:property value="txtnetamount"/>'/></td>
								</tr> 
							</table>
						</div>
					</div> --%>
				</div>
    		</div>
    		<div id="menu2" class="tab-pane fade">
    			<div class="container-fluid">
				    <div class="row">
				    	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
				        	<div class="primarypanel custompanel m-t-5 m-b-5">
				  				<button type="button" class="btn btn-default" id="btninvsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
				          		<button type="button" class="btn btn-default" id="btninvexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
				        		<button type="button" class="btn btn-default" id="btninvinfo" data-toggle="tooltip" title="Info" data-placement="bottom"><i class="fa fa-info-circle " aria-hidden="true"></i></button>
				        	</div>
				        	<div class="primarypanel custompanel datepanel">
				        		<label class="checkbox-inline" style="margin-top: -10px;"><input type="checkbox" value="" id="chkbetweendates" onclick="setinvdtecheck();">Use Between Dates</label>
				  				<div id="invfromdate"></div>
				  				<div id="invtodate"></div>
				  				
				  				<%-- <select id="cmbstatus" name="cmbstatus" class="form-control" style="width:150px;margin-top: -20px;">
				  					<option value="">--Select--</option>
				  					<option value="0" selected>Open</option>
				  					<option value="1">Closed</option>
				  				</select> --%>
				        	</div>
				        	
				        	
				        	<div class="primarypanel custompanel monthpanel m-t-5 m-b-5">
				        		    <label class="checkbox-inline" style="margin-top: -10px;"><input type="checkbox" value="" id="chkinvmonthyear" onclick="setinvcheck();">Use Between Month & Year</label>
				  				
				        		  <div class="dropdown">
		      					  <button type="button" id="invmonth" name="invmonth" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Choose Month</button>
				  			    <!--  <input type="text" id="invmonth" name="invmonth" placeholder="Month" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('invmonth');">
		      					 -->  <ul class="dropdown-menu" id="invmonthid" style="width:100%;">
		      						<li><a data-target="#" data-month="1">January</a></li><li><a data-target="#" data-month="2">February</a></li><li ><a data-target="#" data-month="3">March</a></li><li><a data-target="#" data-month="4">April</a></li><li><a data-target="#" data-month="5">May</a></li><li><a data-target="#" data-month="6">June</a></li>
		      						<li><a data-target="#" data-month="7">July</a></li><li><a data-target="#" data-month="8">August</a></li><li><a data-target="#" data-month="9">September</a></li><li><a data-target="#" data-month="10">October</a></li><li><a data-target="#" data-month="11">November</a></li><li><a data-target="#" data-month="12">December</a></li>																											
		      					  </ul>
		      					  <input type="hidden" id="hidinvmonth" name="hidinvmonth" >
		      				       </div>
		      				       <div class="dropdown">
		      					    <button type="button" id="invyr" name="invyr" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Choose Year</button>
		      					   <input type="hidden" id="hidinvyr" name="hidinvyr" >
		      					  <!--  <input type="text" id="invyr" name="invyr" placeholder="Year" class="form-control dropdown-toggle" data-toggle="dropdown" onkeyup="funFilterDropdown('invyr');">
		      					   --> <ul class="dropdown-menu" id="invyrid" style="width:100%;">
		      											
		      					   </ul>
		      					   </div></div>
		      				
				        </div>
					</div>
					<div class="row rowgap">
						<div class="table-responsive" style="height:70vh;">   
							<table class="table tbl-ivlist">
								<thead>
									<tr>
										<th>Doc No</th>
										<th>Branch</th>
										<th>Doc No</th>
										<th>Date</th>
										<th>Type</th>
										<th>Remarks</th>
										<th align="right" class="text-right">Amount</th>
										
									</tr>
								</thead>
								<tbody></tbody>
							</table>
						</div>
					</div>
					<div class="row rowgap">
						<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
							<div id="invListDiv"><jsp:include page="invoiceListGridv2.jsp"></jsp:include></div>
						</div>
					</div>
				</div>
    		</div>
  			<div id="menu4" class="tab-pane fade">
  				<div class="container m-t-10">
  					<div class="contact-container img-rounded boxshadow1">
  						<div class="contact-header">
  							<div class="row">
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-img p-t-15 p-l-15 p-r-15 p-b-15">
		  								<a href="http://www.gatewayerp.com" target="_blank">
		  									<img alt="Company Logo" src="images/comp-logo.jpg" style="width:auto;height:150px;" class="img-responsive img-thumbnail img-responsive boxshadow1"></a>
		  							</div>		
  								</div>
  								<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
  									<div class="contact-header-detail pull-right p-r-20 p-t-25">
  										<h4> Rent-A-Car</h4>
  										<p>Let's start exploring the world together with us</p>
  									</div>		
  								</div>
  							</div>
  						</div>
  						<div class="contact-body">
  							<div class="container-fluid">
  								<div class="panel panel-default m-t-15">
  									<table class="table tblhelpdesk">
		  								<thead>
		  									<tr>
		  										<th>Sr No</th>
		  										<th>Employee</th>
		  										<th>Department</th>
		  										<th>Email</th>
		  										<th>Mobile</th>
		  									</tr>
		  								</thead>
										<tbody>
											
										</tbody>
		  							</table>
  								</div>
  							</div>
  						</div>
  					</div>
  				</div>
  			</div>
  		</div>
	</div>
	
	<input type="hidden" name="clientacno" id="clientacno">
	<input type="hidden" name="cldocno" id="cldocno">
	<script src="../../../../vendors/chartjs/chart.js"></script>
	<script src="../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<script src="../js/sweetalert2.all.min.js"></script>
	<script src="../vendors/select2/select2.min.js"></script>
	<script src="../js/Chart.min.js"></script>


	<!-- <script type="text/javascript" src="../js/dashboard/chartjs-plugin-colorschemes.min.js"></script>
	 --><%-- <script src="../../js/dashboard/d3.min.js" charset="utf-8"></script> --%>
	<%-- <script src="../../js/chartutils.js"></script> --%>
	<%-- <script src="../../js/dashboard/jquery.knob.min.js"></script> --%>
	
	 <script src="../vendors/waypoints/waypoints.min.js"></script> 
	<script src="../js/dashboard/jquery.counterup.min.js"></script>
	 <script src="../vendors/underscore/underscore.js"></script>
	<script src="../vendors/datatables/jquery.dataTables.min.js"></script>
	<script src="../vendors/datatables/dataTables.bootstrap.min.js"></script>
	 
	<script type="text/javascript" src="../vendors/daterangepicker/moment.min.js"></script> 
  
    <script type="text/javascript" src="../vendors/daterangepicker/daterangepicker.min.js"></script>
    
        <script>
    	var rawdata={};
    	var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    	var fleetdistconfig = {
    			type: 'bar',
    			data: {
    				labels:['January', 'February', 'March', 'April', 'May', 'June'],
    				datasets: [{
    					data: [
    						5,
    						10,
    						15,
    						20,
    						30,
    						35
    					],
    					backgroundColor: '#06d6a0',
    					label:'Earning'
    				},
    				{
    					data: [
    						5,
    						10,
    						15,
    						20,
    						30,
    						35
    					],
    					backgroundColor: '#ef476f',
    					label:'Charges'
    				}]
    			},
    			options: {
    				scales:{
    					y:{
    						beginAtZero:true
    					}
    				}
    			}
    		};
    	window.chartColors = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
			color1:'rgb(255, 15, 0)',
			color2:'rgb(255, 102, 0)',
			color3:'rgb(255, 158, 1)',
			color4:'rgb(252, 210, 2)',
			color5:'rgb(248, 255, 1)',
			color6:'rgb(176, 222, 9)',
			color7:'rgb(4, 210, 21)',
			color8:'rgb(13, 142, 207)',
			color9:'rgb(13, 82, 209)',
			color10:'rgb(42, 12, 208)',
			color11:'rgb(138, 12, 207)',
			color12:'rgb(205, 13, 116)',
			color13:'rgb(117, 77, 235)',
			color14:'rgb(221, 221, 221)',
			color15:'rgb(153, 153, 153)',
			color16:'rgb(51, 51, 51)'
		};
    	/*document.getElementById("chartfleetdist").onclick = function(evt){
            var activePoints = window.chartfleetdist.getElementsAtEvent(evt);
            var firstPoint = activePoints[0];
            var grouptype=document.querySelector(".widget-fleetdistchart .panel-heading .panel-title .btn-group .dropdown-toggle span.filter-text").getAttribute("data-filtertype");
            if(grouptype=="undefined" || grouptype=="" || grouptype==null){
            	grouptype="brandname";
            }
            var label = window.chartfleetdist.data.datasets[firstPoint._datasetIndex].labels[firstPoint._index];
            var value = window.chartfleetdist.data.datasets[firstPoint._datasetIndex].data[firstPoint._index];
        	window.chartfleetdist.data.datasets[1].data=funSetRawData(rawdata.fleetdistdata,label,"count",grouptype);
			window.chartfleetdist.data.datasets[1].labels=funSetRawData(rawdata.fleetdistdata,label,"group",grouptype);
			window.chartfleetdist.update();
			var legendhtml='<ul class="list-group">';
			for(var i=0;i<window.chartfleetdist.data.datasets[1].data.length;i++){
				legendhtml+='<li class="list-group-item">'+window.chartfleetdist.data.datasets[1].labels[i]+' <span class="badge" style="border-radius:4px;">'+window.chartfleetdist.data.datasets[1].data[i]+'</span></li>';
			}
			legendhtml+='</ul>';
			$('.chartfleetdist-legend-container').html($.parseHTML(legendhtml));
        };*/
        
		window.onload = function() {
			var ctxchartfleetdist = document.getElementById('chartfleetdist').getContext('2d');
			window.chartfleetdist = new Chart(ctxchartfleetdist, fleetdistconfig);
		};
    	$(document).ready(function(){
    		$("#fromdate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#todate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#invfromdate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#invtodate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#traffictodate").jqxDateTimeInput({ width: '125px', height: '20px', formatString:"dd.MM.yyyy"});
    		$("#feeddate").jqxDateTimeInput({ width: '150px', height: '20px', formatString:"dd.MM.yyyy HH:mm",value:new Date()});
    		
    		var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 		var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1)); 
     		$('#fromdate,#invfromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
     		
     	 		var basedate=new Date();
     		var currmonth=basedate.getMonth()+1;
     		var curryear=basedate.getFullYear();
     		//alert(currmonth+"::"+curryear)
     		
     		  
     		var acc = document.querySelector("[data-month='" + currmonth + "']");
     		//alert(acc.textContent)
     	
			 $('#accmonth').text(acc.textContent); 
     		 $('#invmonth').text(acc.textContent); 
			 $('#hidaccmonth').val(currmonth);
			 $('#hidinvmonth').val(currmonth);
   			 $("#accyr").text(curryear); 
     		 $("#invyr").text(curryear); 
     		 $("#hidinvyr").val(curryear); 
     		 $("#hidaccyr").val(curryear); 
         	 
         	 
     		document.getElementById('chkaccmonthyear').checked=true;
     		document.getElementById('chkinvmonthyear').checked=true;

     		var minOffset = 0, maxOffset = 10; // Change to whatever you want // minOffset = 0 for current year 
     		var thisYear = (new Date()).getFullYear();
        	for (var i = minOffset; i <= maxOffset; i++) { var year = thisYear - i; $('<li>', {'data-accyear': year, text: year}).appendTo("#accyrid");} 
			
        	var minOffset1 = 0, maxOffset1 = 10; // Change to whatever you want // minOffset = 0 for current year 
     		var thisYear1 = (new Date()).getFullYear();
        	for (var i = minOffset1; i <= maxOffset1; i++) { var year1 = thisYear1 - i; $('<li>', {'data-invyear': year1, text: year1}).appendTo("#invyrid");} 
			
     		/* $('#cmbstatus').select2({
				placeholder:"Select Status",
				allowClear:true
			}); */
			/* $('#cmbfeedregno').select2({
				placeholder:"Select Reg No",
				allowClear:true
			}); */
			/* $('#cmbfeedtype').select2({
				placeholder:"Select Type",
				allowClear:true
			}); */
			
			//getmultiuser();
		
			 $('#accmonthid li').each(function(){
				   $(this).on('click',function(e){
			          e.preventDefault();
				   var monthno=$(this).find('a').attr('data-month');
				   var monthname=$(this).find('a').text();
				   $('#accmonth').text(monthname);
				   $('#hidaccmonth').val(monthno);
				  });
	           });
			 
			 $('#invmonthid li').each(function(){
				   $(this).on('click',function(e){
			          e.preventDefault();
				   var monthno=$(this).find('a').attr('data-month');
				   var monthname=$(this).find('a').text();
				   $('#invmonth').text(monthname);
				   $('#hidinvmonth').val(monthno);
				  });
	           });
			 
			 $('#accyrid li').each(function(){
				   $(this).on('click',function(e){
			       e.preventDefault();
				   var year=$(this).attr('data-accyear');
				   $('#accyr').text(year);
				   $('#hidaccyr').val(year);
				  });
	           });
			 
			 $('#invyrid li').each(function(){
				   $(this).on('click',function(e){
			       e.preventDefault();
				   var year=$(this).attr('data-invyear');
				   $('#invyr').text(year);
				   $('#hidinvyr').val(year);
				  });
	           });
			 
			$('.card-container').click(function(){
				if($(this).attr('id')=='accsum'){
					$('#btnsubmit').trigger('click');
					$('.custom-tabs').find('li').eq(1).find('a').trigger('click');	
				}
				if($(this).attr('id')=='invoicelst'){
					$('#btninvsubmit').trigger('click');
					$('.custom-tabs').find('li').eq(2).find('a').trigger('click');	
				}
				if($(this).attr('id')=='docexp'){
					$('#btndocexpsubmit').trigger('click');
					$('.custom-tabs').find('li').eq(3).find('a').trigger('click');	
				}
				if($(this).attr('id')=='atchmt'){
				var acno = $('#clientacno').val();
    			
    			 if (acno!="") {
   				   var  myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode=CRM&docno="+acno+"&branch=a","_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
 				   myWindow.focus();
 			
				}
			}	
				
			});
			$('#btnfeedclear').click(function(){
				$('.tblfeed tbody tr').removeClass('active');
				$('.form-feed input').val('');
				$('.form-feed select').val(null).trigger('change');
				$('#feeddate').jqxDateTimeInput('setDate',new Date());
			});
			$('#btnfeedsave').click(function(){

				if($('.tblfeed tbody tr.active').length>0){
					Swal.fire({
						type: 'error',
						title: 'Warning',
						text: 'Please clear the document before proceeding'
					});
					return false;
				}
				var invalid=0;
				$('#feedregno,#feedcalledby,#feedmobile,#feedtypee,#feeddate').each(function(){
					
					if(($(this).val()=='' && $(this).attr('id')!='feeddate') || ($(this).attr('id')=='feeddate' && $(this).jqxDateTimeInput('getDate')==null)){
						$(this).closest('.form-group').find('span.help-block').remove();
						$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Mandatory</span>'));
						invalid=1;
						return false;
					}
					else{
						$(this).closest('.form-group').find('span.help-block').remove();
						$(this).closest('.form-group').removeClass('has-error');
					}
					if($(this).attr('id')=='feedmobile'){
						var mobileno=$(this).val();
						let isnum = /^\d+$/.test(mobileno);
						if(mobileno.length>12){
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Max 12 Digits Allowed</span>'));
							invalid=1;
							return false;
						}
						else if(!isnum){
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').addClass('has-error').find('div.col-sm-9').append($.parseHTML('<span class="help-block">Only Digits Allowed</span>'));
							invalid=1;
							return false;
						}
						else{
							$(this).closest('.form-group').find('span.help-block').remove();
							$(this).closest('.form-group').removeClass('has-error');
						}
					}
				});
				if(invalid==1){
					return false;
				}
				
				Swal.fire({
					title: 'Are you sure?',
					text: "Do you want to save changes",
					icon: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: 'Save Changes'
				}).then((result) => {
						if(result.isConfirmed) {
					   		$('.page-loader button').show();
					   		var cldocno=$("#cldocno").val();
					   		$.post('saveClientQueries.jsp?&cldocno='+cldocno,{
					   			//'regno':$('#feedregno').val(),
					   			'regno':$("#feedregno").attr("data-fleetno"),
					   			'calledby':$('#feedcalledby').val(),
					   			'mobile':$('#feedmobile').val(),
					   			'type':$("#feedtypee").attr("data-docno"),
					   			'place':$('#feedplace').val(),
					   			'remarks':$('#feedremarks').val(),
					   			'date':$('#feeddate').jqxDateTimeInput('val')},
					   			function(data,status){
					   				console.log('RAW:'+data);
					   				data=JSON.parse(data.trim());
					   				console.log('JSON:'+data);
					   				$('.page-loader button').hide();
					   				if(data.errorstatus=="0"){
					   					Swal.fire({
											type: 'success',
											title: 'Success',
											text: 'Saved Successfully'
										});
					   					$('.form-feed input').val('');
					   					$('.form-feed select').val(null).trigger('change');
					   					$('#feeddate').jqxDateTimeInput('setDate',new Date());
					   					getInitData();
					   				}
					   				else{
					   					Swal.fire({
											type: 'error',
											title: 'Warning',
											text: 'Not Saved'
										});
					   					return false;
					   				}
					   			});
					  	}
					});
			});
	
			
		
			
			
			$('.widget-fleetdistchart .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filter');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').attr('data-filtertype',filtertype);
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				$('.chartfleetdist-legend-container').html('');
				window.chartfleetdist.data.datasets[1].data=[];
				window.chartfleetdist.data.datasets[1].labels=[];
				window.chartfleetdist.update();
			});
			
			$('.widget-livefleet .panel-heading .dropdown-menu li a').click(function(){
				var filtertype=$(this).attr('data-filter');
				var filtertext=$(this).text();
				$(this).closest('.panel-heading').find('.filter-text').text(filtertext);
				var livefleetcountdata=_.countBy(rawdata.livefleetdata, function(num) {
  					return num[filtertype];
  					//return num % 2 == 0 ? 'even': 'odd';
				});
				
				$('.widget-livefleet .panel-body div').html('');
				var sum=0;
				var fleetlisthtml='<ul class="list-group">';
				_.map(livefleetcountdata, function(value, key){
					sum+=value;
					fleetlisthtml+='<li class="list-group-item">'+key+'<span class="badge">'+value+'</span></li>';
			    	/*return {
			        	name: key,
			        	y: value
			    	};*/
				});
				fleetlisthtml+='</ul>';
				$('.widget-livefleet .panel-body div').html($.parseHTML(fleetlisthtml));
				$('.widget-livefleet').find('.panel-title-text').find('.custom-badge1').text(sum);
			});
			
			$('#btnacstmt').click(function(){
				clickExEnqHandler();
				// var gridrows=$('#accountsStatement').jqxGrid('getrows');
 				var gridrows=$('.tbl-acstmt  tbody tr.active');
 				
			 		<%--  var fromdate=$('#fromdate').jqxDateTimeInput('val');
					var todate=$('#todate').jqxDateTimeInput('val');
					var clientacno=document.getElementById("clientacno").value;
					var netamount=document.getElementById("txtnetamount").value;
			        win.focus(); --%>
			        if(document.getElementById("chkaccmonthyear").checked){
		     			 
		     			 
		     		
			        // Get the month and year values from your input fields
		     		const inputMonth = $('#hidaccmonth').val(); // Replace with the actual input field ID
		     		const inputYear = $('#hidaccyr').val(); // Replace with the actual input field ID
                    
		     		// Create a JavaScript Date object with the input month and year
		     		const selectedDate = new Date(inputYear, inputMonth - 1, 1);
		     		
		     		// Calculate the first date of the month
		     		const firstDateOfMonth = new Date(selectedDate);
		     		 firstDateOfMonth.setDate(1);
		     		 
		     		// Calculate the last date of the month
		     		const lastDateOfMonth = new Date(selectedDate);
		            lastDateOfMonth.setMonth(lastDateOfMonth.getMonth() + 1);
		     		lastDateOfMonth.setDate(0);
		     		
		     		// Format the dates as strings (e.g., "YYYY-MM-DD")
		     	    const firstDateFormatted = firstDateOfMonth.toLocaleString();
		     		const lastDateFormatted = lastDateOfMonth.toLocaleString();
		     		var fstdts=firstDateFormatted.split('/');
		     		var f1=fstdts[1]+"."+fstdts[0]+"."+fstdts[2];
		     		var fromdate=f1.split(',');
		     		
		     		var lstdts=lastDateFormatted.split('/');
		     		var l1=lstdts[1]+"."+lstdts[0]+"."+lstdts[2];
		     		var todate=l1.split(',');
		     		
			        }else{   
			        	
			       
			        var fromdate=$('#fromdate').jqxDateTimeInput('val');
				    var todate=$('#todate').jqxDateTimeInput('val');
					  
			        }	
		     		
			        var netamount=$('.tbl-acstmt tbody tr.active').attr('data-netamount');
			        var clientacno=document.getElementById("clientacno").value;
			        var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus();
			
		});
			$('#btnoutstanding').click(function(){
				clickExEnqHandler();
				//var gridrows=$('#accountsStatement').jqxGrid('getrows');
				var gridrows=$('.tbl-acstmt  tbody tr.active');
				
			
					<%-- var fromdate=$('#fromdate').jqxDateTimeInput('val');
					var todate=$('#todate').jqxDateTimeInput('val');
					var clientacno=document.getElementById("clientacno").value;
					var netamount=document.getElementById("txtnetamount").value;
					var win= window.open("<%=contextPath%>/com/dashboard/accounts/ageingstatement/printAgeingOutstandingsStatement?&acno="+clientacno+"&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch=a&uptoDate="+todate+"&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        //var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        win.focus(); --%>
			        if(document.getElementById("chkaccmonthyear").checked){
		     			 
		     			 
			     		
				        // Get the month and year values from your input fields
			     		const inputMonth = $('#hidaccmonth').val(); // Replace with the actual input field ID
			     		const inputYear = $('#hidaccyr').val(); // Replace with the actual input field ID
	                    
			     		// Create a JavaScript Date object with the input month and year
			     		const selectedDate = new Date(inputYear, inputMonth - 1, 1);
			     		
			     		// Calculate the first date of the month
			     		const firstDateOfMonth = new Date(selectedDate);
			     		 firstDateOfMonth.setDate(1);
			     		 
			     		// Calculate the last date of the month
			     		const lastDateOfMonth = new Date(selectedDate);
			            lastDateOfMonth.setMonth(lastDateOfMonth.getMonth() + 1);
			     		lastDateOfMonth.setDate(0);
			     		
			     		// Format the dates as strings (e.g., "YYYY-MM-DD")
			     	    const firstDateFormatted = firstDateOfMonth.toLocaleString();
			     		const lastDateFormatted = lastDateOfMonth.toLocaleString();
			     		var fstdts=firstDateFormatted.split('/');
			     		var f1=fstdts[1]+"."+fstdts[0]+"."+fstdts[2];
			     		var fromdate=f1.split(',');
			     		
			     		var lstdts=lastDateFormatted.split('/');
			     		var l1=lstdts[1]+"."+lstdts[0]+"."+lstdts[2];
			     		var todate=l1.split(',');
			     		
				        }else{   
				        	
				       
				        var fromdate=$('#fromdate').jqxDateTimeInput('val');
					    var todate=$('#todate').jqxDateTimeInput('val');
						  
				        }	
			     	var clientacno=document.getElementById("clientacno").value;
					var netamount=$('.tbl-acstmt tbody tr.active').attr('data-netamount');
				    var win= window.open("<%=contextPath%>/com/dashboard/accounts/ageingstatement/printAgeingOutstandingsStatement?&acno="+clientacno+"&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch=a&uptoDate="+todate+"&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				    win.focus();
				    <%--  var win= window.open("<%=contextPath%>/com/dashboard/accounts/accountsstatement/printAccountsStatement?acno="+clientacno+"&netamount="+netamount+"&branch=a&fromDate="+fromdate+"&toDate="+todate+"&chckopn=1&email=Nil&print=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			        --%>
			       
				
			}); 
			
			$('#btnstmtprint').click(function(){
				clickExEnqHandler();
				var gridrows=$('.tbl-acstmt  tbody tr.active');
				alert(gridrows.length)
				//var rowindex=$('#stmtrowindex').val();
				var dtype=$('.tbl-acstmt tbody tr.active').attr('data-transtype');
				var docno=$('.tbl-acstmt tbody tr.active').attr('data-transno');
				var brhid=$('.tbl-acstmt tbody tr.active').attr('data-brhid');
				/* var dtype=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transtype");
           		var docno=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transno");
           		var brhid=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"brhid");
           		 */
           		 
           		 if(dtype=="TINV"){
           			var win= window.open("<%=contextPath%>/com/operations/commtransactions/travelinvoice/printtravelinvoice?docno="+docno+"&branch="+brhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();
           		}
           		else if(dtype=="INS" || dtype=="INV" || dtype=="INT"){
           			var win= window.open("<%=contextPath%>/com/operations/commtransactions/invoice/printManualInvoice?tono="+docno+"&fromno="+docno+"&branch="+brhid+"&printdocno=&hidheader=1&chkdeletedinvprint=0&bankdocno=","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();
           		}
           		else if(dtype=="CRV"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/cashreceipt/printCashReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="BRV"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/bankreceipt/printBankReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="CNO"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/creditnote/printCreditNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		else if(dtype=="DNO"){
           			var win= window.open("<%=contextPath%>/com/finance/transactions/debitnote/printDebitNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        			win.focus();
        			win.print();	
           		}
           		
			});
			
			
			$('#btnstmtattach').click(function(){
				var rowBoundIndex=$('#stmtrowindex').val();
				var brhid=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'brhid');  
 				var docno="";
				docno=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'docno');
    			if(docno!="" && docno!="0"){             
					var frmdet=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'transtype');
					var fname="";
					var x = new XMLHttpRequest();
 					x.onreadystatechange = function() {
 						if (x.readyState == 4 && x.status == 200) {
 							var items = x.responseText.trim();
 							fname=items;
	   						var myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
		  					myWindow.focus();
 						}
 					}
 					x.open("GET", "getFormname.jsp?formtype="+frmdet, true);
 					x.send();
 					
				}
				else{  
					Swal.fire({
						type: 'error',
						title: 'Empty Document',
						text: 'Please select a document'
					});
					return false;
    			}
			});
    		$('#btnsubmit').click(function(){
    			var acno=$('#clientacno').val();
    			var hidaccyr=$('#hidaccyr').val();
    			var hidaccmonth=$('#hidaccmonth').val();
    			var fromdate=$('#fromdate').jqxDateTimeInput('val');
    			var todate=$('#todate').jqxDateTimeInput('val');
    			$('#txtnetamount').val('');
    			$('.page-loader button').show();
    			var chkbtwdtacc=$("#chkbtwdtacc:checked" ).length;
    			var chkaccmonthyear=$("#chkaccmonthyear:checked" ).length;
    			$('#accountsStatementDiv').load('accountsStatementTypeGridv2.jsp?fromdate='+fromdate+'&todate='+todate+'&accdocno='+acno+'&check=1&branchval=a'+'&chkbtwdtacc='+chkbtwdtacc+'&chkaccmonthyear='+chkaccmonthyear+'&hidaccmonth='+hidaccmonth+'&hidaccyr='+hidaccyr);
    		});
    		$('#btnexcel').click(function(){
    			/* var excelname="Account Statement of "+$('.user-dropdown-text').text()+" dated from "+$('#fromdate').jqxDateTimeInput('val')+" to "+$('#todate').jqxDateTimeInput('val');
    			$("#accountsStatementDiv").excelexportjs({
					containerid: "accountsStatementDiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "accountsStatement", 
					columns: getColumns("accountsStatement") , 
					worksheetName:excelname 
				}); */
				JSONToCSVCon(data, "Account Statement", true);
    		});
			$('#btninvsubmit').click(function(){
				var fromdate=$('#invfromdate').jqxDateTimeInput('val');
				var todate=$('#invtodate').jqxDateTimeInput('val');
				var acno=$('#clientacno').val();
				var hidinvyr=$('#hidinvyr').val();
    			var hidinvmonth=$('#hidinvmonth').val();
    			$('.page-loader button').show();
				var status=$('#cmbstatus').val();
				var chkbetweendates=$("#chkbetweendates:checked" ).length;
				var chkinvmonthyear=$("#chkinvmonthyear:checked" ).length;
				$('#invListDiv').load('invoiceListGridv2.jsp?fromdate='+fromdate+'&todate='+todate+'&acno='+acno+'&id=1&branch=a&status='+status+'&chkbetweendates='+chkbetweendates+'&chkinvmonthyear='+chkinvmonthyear+'&hidinvmonth='+hidinvmonth+'&hidinvyr='+hidinvyr);
			}); 
			$('#btndocexpsubmit').click(function(){
				var todate=$('#traffictodate').jqxDateTimeInput('val');
				var acno=$('#clientacno').val();
				$('.page-loader button').show();
				$('#docexpdiv').load('documentExpiryGridv2.jsp?todate='+todate+'&acno='+acno+'&id=1&branchval=a');
			}); 
			$('#btndocexpexcel').click(function(){
				/* var excelname="Document Expiry List of "+$('.user-dropdown-text').text()+" dated  upto "+$('#traffictodate').jqxDateTimeInput('val');
    			$("#docexpdiv").excelexportjs({
					containerid: "docexpdiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "documentExpiry", 
					columns: getColumns("documentExpiry") , 
					worksheetName:excelname
				});	 */
				
				JSONToCSVCon(docexpdata, "Document Expiry List", true);
    		});
			$('#btninvexcel').click(function(){
		/* 		var chkbetweendates=$("#chkbetweendates:checked" ).length;
				var excelname="";
				if(chkbetweendates==0){
					excelname="InvoiceList of "+$('.user-dropdown-text').text()+" dated till "+$('#invtodate').jqxDateTimeInput('val');
				}
				else{
					excelname="Invoice List of "+$('.user-dropdown-text').text()+" dated from "+$('#invfromdate').jqxDateTimeInput('val')+" to "+$('#invtodate').jqxDateTimeInput('val');
				}
    			$("#invListDiv").excelexportjs({
					containerid: "invListDiv",
					datatype: 'json', 
					dataset: null, 
					gridId: "invoiceListGrid", 
					columns: getColumns("invoiceListGrid") , 
					worksheetName:excelname
				});	 */
				
				JSONToCSVCon(invoicedatav2, "Invoice List", true);
    		});

    	}); 
    	$(window).ready(function(){
    		//getInitData();
    		getmultiuser();
		});
    	
    	
    	function setacccheck(){
   		 if(document.getElementById("chkaccmonthyear").checked){
   			var uncheckacc= document.getElementById("chkbtwdtacc");
   		    uncheckacc.checked = false;
   		 }
   	 }
   	 
    	function setaccdtecheck(){
    	 if(document.getElementById("chkbtwdtacc").checked){
 			var uncheckdte= document.getElementById("chkaccmonthyear");
    		uncheckdte.checked = false;
    		   
    		 }
    	}
    	
    	
    	function setinvcheck(){
      		 if(document.getElementById("chkinvmonthyear").checked){
      			var uncheckacc= document.getElementById("chkbetweendates");
      		    uncheckacc.checked = false;
      		 }
      	 }
      	 
       	function setinvdtecheck(){
       	 if(document.getElementById("chkbetweendates").checked){
    			var uncheckdte= document.getElementById("chkinvmonthyear");
       		uncheckdte.checked = false;
       		   
       		 }
       	}
  		  function funFilterDropdown(id){
  			var input=document.getElementById(id);
  			var filter = input.value.toUpperCase();
  			
  			$('#'+id).closest('.dropdown').find('.dropdown-menu li').each(function(){
  				var listvalue=$(this).find('a').text();
  				if (listvalue.toUpperCase().indexOf(filter) > -1) {
  					$(this).css('display','');
  				}
  				else{
  					$(this).css('display','none');
  				}
  			});
  		}
  		function clickExEnqHandler() {
		    // Here, `this` refers to the element the event was hooked on
		    $(this).closest('tbody').find('tr').removeClass('active');
			$(this).closest('tr').addClass('active');
		}
         function getmultiuser(){
			$.get('multipleclient.jsp',function(data){
				data=JSON.parse(data.trim());
				var htmldata='';
				var autocldocno=0,autoacno=0;
				$.each(data.vendordata,function(index,value){
	  				htmldata+='<li ><a href="#!" data-cldocno="'+value.cldocno+'" data-acno="'+value.acno+'">'+value.refname+'</a></li>';
	  				autocldocno=value.cldocno;
	  				autoacno=value.acno;
				});
				$('.client-dropdownlist').html($.parseHTML(htmldata));
				$('#cldocno').val(autocldocno);
				$('#clientacno').val(autoacno);
				getInitData();
				$('.client-dropdownlist li').on('click',function(e){
					//e.preventDefault();
					var acno=$(this).find('a').attr('data-acno');
					var cldocno=$(this).find('a').attr('data-cldocno');
					$('#cldocno').val(cldocno);
					$('#clientacno').val(acno);
					$('.client-dropdown .user-dropdown-text').text($(this).find('a').text());
					getInitData();
				});
			
	  			$('.load-wrapp').hide();
    	
			});
		}
		
		function getInitData(){
			$('.page-loader,.page-loader button').show();
			$('body').css('overflow','hidden');
			var cldocno=$('#cldocno').val();
			var fromdate=$('#fromdate').jqxDateTimeInput('val');
			var todate=$('#todate').jqxDateTimeInput('val');
			var clientacno=$('#clientacno').val();
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				
	  				var items = x.responseText.trim();
	  				
	  		     	$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.client-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				$('#clientacno').val(items.split("::")[3].trim());
	  				$('.pdcinhand .card-detail-wrapper .value').text(items.split("::")[4].trim());
	  				$('.subreceipt .card-detail-wrapper .value').text(items.split("::")[5].trim());
	  				$('#accsum .card-detail-wrapper .value').text(items.split("::")[6].trim());
	  				$('#invoicelst .card-detail-wrapper .value').text(items.split("::")[7].trim());
	  				$('#docexp .card-detail-wrapper .value').text(items.split("::")[8].trim());
	  				$('#atchmt .card-detail-wrapper .value').text(items.split("::")[9].trim());
	  				var policynodata=JSON.parse(items.split("::")[13].trim());
					var helpdeskdata='';
					var helpddeskdata1='';
					$.each(policynodata.helpdeskdata, function( index, value ) {
	  					helpdeskdata+='<tr data-docno="'+value.split("***")[1]+'">';
	  					helpdeskdata+='<td>'+value.split("***")[0]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[2]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[3]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[4]+'</td>';
	  					helpdeskdata+='<td>'+value.split("***")[5]+'</td>';
	  					helpdeskdata+='</tr>';
					});
					$('.tblhelpdesk tbody').html($.parseHTML(helpdeskdata));
					
					helpdeskdata='';
					
					$.each(policynodata.feedvehdata,function(index,value){
						//helpdeskdata+='<option value="'+value.fleetno+'">'+value.refname+'</option>';
					
					helpdeskdata+='<li ><a href="#!" data-fleetno="'+value.fleetno+'" data-refname="'+value.refname+'" >'+value.refname+'</a></li>';
			  			
					});
				
					//$('#cmbfeedregno').html($.parseHTML(helpdeskdata));
					$('#feedregno').closest('.dropdown').find('#regnoid').html($.parseHTML(helpdeskdata));
					
					$('#feedregno').closest('.dropdown').find('#regnoid li').each(function(){
						$(this).on('click',function(e){
							e.preventDefault();
							var fleetno=$(this).find('a').attr('data-fleetno');
							var refname=$(this).find('a').text();
							//alert(fleetno+"::"+refname);
							$('#feedregno').val(refname);
							$('#feedregno').attr('data-fleetno',fleetno);
							$("#feedregno").dropdown('toggle');
							
						});
					});
					/*document.getElementById("regnoid").addEventListener("click",function(e){
					
						var fleetno=$(this).find('a').attr('data-fleetno');
						var refname=$(this).find('a').attr('data-refname');
						alert("fleetno"+fleetno);	
						alert("refname"+refname);
						$('#feedregno').text(refname);
						$('.client-dropdown .user-dropdown-text').text($(this).find('a').text());
						
						
					});*/
					/* $('#cmbfeedregno').select2({
						placeholder:"Select Reg No",
						allowClear:true
					});
					helpdeskdata='<option value="">--Select--</option>';
					 */
					 helpdeskdata='';
					$.each(policynodata.feedtypedata,function(index,value){
						//helpdeskdata+='<option value="'+value.docno+'">'+value.refname+'</option>';
						helpdeskdata+='<li ><a href="#!" data-docno="'+value.docno+'" >'+value.refname+'</a></li>';
				  		
					});
					
				//	$('#cmbfeedtype').html($.parseHTML(helpdeskdata));
					$('#feedtypee').closest('.dropdown').find('#typeid').html($.parseHTML(helpdeskdata));
					
					$('#feedtypee').closest('.dropdown').find('#typeid li').each(function(){
						$(this).on('click',function(e){
							e.preventDefault();
							var docno=$(this).find('a').attr('data-docno');
							var refname=$(this).find('a').text();
							//alert(docno+"::"+refname);
							$('#feedtypee').val(refname);
							$('#feedtypee').attr('data-docno',docno);
							$("#feedtypee").dropdown('toggle');
							
						});
					});
			
                  
					/* $('#cmbfeedtype').select2({
						placeholder:"Select Type",
						allowClear:true
					}); */
					
					
					
					helpdeskdata='';
					$.each(policynodata.feeddata,function(index,value){
						helpdeskdata+='<tr data-cldocno="'+value.cldocno+'" data-fleetno="'+value.fleetno+'" data-datetime="'+value.datetime+'" data-mobile="'+value.mobile+'" data-type="'+value.type+'" data-place="'+value.place+'" data-remarks="'+value.remarks+'">';
						helpdeskdata+='<td>'+value.regno+'</td>';
						helpdeskdata+='<td>'+value.date+'</td>';
						helpdeskdata+='<td>'+value.calledby+'</td>';
						helpdeskdata+='<td>'+value.typename+'</td>';
						helpdeskdata+='<td>'+value.statusname+'</td>';
						helpdeskdata+='<td><button type="button" class="btn btn-default"><i class="fa fa-cloud-upload"></i></button></td>';
						
						helpdeskdata+='</tr>';
					});
					$('.tblfeed tbody').html($.parseHTML(helpdeskdata));
					
					$('.tblfeed tbody tr').on('click',function(){
						$('.tblfeed tbody tr').removeClass('active');
						$(this).addClass('active');
						$('#feedregno').val($(this).attr('data-fleetno')).trigger('change');
						$('#feedcalledby').val($(this).find('td').eq(2).text());
						$('#feedmobile').val($(this).attr('data-mobile'));
						$('#feedtypee').val($(this).attr('data-type')).trigger('change');
						$('#feedplace').val($(this).attr('data-place'));
						$('#feedremarks').val($(this).attr('data-remarks'));
						$('#feeddate').jqxDateTimeInput('val',$(this).attr('data-datetime'));
						return false;
					});
					
					$('.tblfeed tbody tr').each(function(){
						$(this).find('td').eq(5).find('button').on('click',function(){
							var querydocno=$(this).closest('tr').attr('data-docno');
							var  myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode=ECR&docno="+querydocno+"&branch=a","_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			 				myWindow.focus();
						});
					});
					
					rawdata.fleetdistdata=JSON.parse(items.split("::")[14]);
					rawdata.livefleetdata=JSON.parse(items.split("::")[15]);
					rawdata.fleetsalesdata=JSON.parse(items.split("::")[15]);
					rawdata.fleetsalescombo=rawdata.livefleetdata.labelsvalues;
					rawdata.livefleetdata=rawdata.livefleetdata.livefleets;
					$('.widget-livefleet .panel-heading .dropdown-menu li:nth-child(2) a').trigger('click');
					window.chartfleetdist.data.datasets[0].data=policynodata.acchartdata.debitarray;
					window.chartfleetdist.data.datasets[1].data=policynodata.acchartdata.creditarray;
					window.chartfleetdist.data.labels=policynodata.acchartdata.monthdata;
					window.chartfleetdist.update();

					$('.widget-fleetdistchart .panel-heading .dropdown-menu li:nth-child(2) a').trigger('click');
					/* chart.data.labels=rawdata.fleetsalesdata.labels;
					chart.data.datasets[0].data=rawdata.fleetsalesdata.purchasemonthcount;
					chart.data.datasets[1].data=rawdata.fleetsalesdata.salesmonthcount;
					chart.options.title.text=rawdata.fleetsalesdata.fleetstatustitle;
					chart.update(); */
	  				$('.page-loader,.page-loader .btn').hide();
	  				$('body').css('overflow','auto');
	  			}
	  		}
	  		x.open("GET", "getClientInitDatav2.jsp?fromdate="+fromdate+"&todate="+todate+"&cldocno="+cldocno+"&clientacno="+clientacno, true);
	  		x.send();
		}
		
		
		function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

		    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		    
		   // alert("arrData");
		    var CSV = '';    
		    //Set Report title in first row or line
		    
		    CSV += ReportTitle + '\r\n\n';

		    //This condition will generate the Label/Header
		    if (ShowLabel) {
		        var row = "";
		        
		        //This loop will extract the label from 1st index of on array
		        for (var index in arrData[0]) {
		            
		            //Now convert each value to string and comma-seprated
		            row += index + ',';
		        }

		        row = row.slice(0, -1);
		        
		        //append Label row with line break
		        CSV += row + '\r\n';
		    }
		    
		    //1st loop is to extract each row
		    for (var i = 0; i < arrData.length; i++) {
		        var row = "";
		        
		        //2nd loop will extract each column and convert it in string comma-seprated
		        for (var index in arrData[i]) {
		            row += '"' + arrData[i][index] + '",';
		        }

		        row.slice(0, row.length - 1);
		        
		        //add a line break after each row
		        CSV += row + '\r\n';
		    }

		    if (CSV == '') {        
		        alert("Invalid data");
		        return;
		    }   
		    
		    //Generate a file name
		    var fileName = "";
		    //this will remove the blank-spaces from the title and replace it with an underscore
		    fileName += ReportTitle.replace(/ /g,"_");   
		    
			 // newly added 
		    var temp = CSV;
		    blob = new Blob([temp],{type: 'text/csv'});
		    var bigcsv= window.webkitURL.createObjectURL(blob);
		   
			
		    //Initialize file format you want csv or xls
		  //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		    
		    // Now the little tricky part.
		    // you can use either>> window.open(uri);
		    // but this will not work in some browsers
		    // or you will not get the correct file extension    
		    
		    //this trick will generate a temp <a /> tag
		    var link = document.createElement("a");    
		     //  link.href = uri;
		      link.href = bigcsv;
		    
		    //set the visibility hidden so it will not effect on your web-layout
		    link.style = "visibility:hidden";
		    link.download = fileName + ".csv";
		    
		    //this part will append the anchor tag and remove it after automatic click
		    document.body.appendChild(link);
		    link.click();
		    document.body.removeChild(link);
		}
		
		function funSetRawData(rawdata,filtername,grouptype,groupname){
			var result;
			if(grouptype=="count"){
				if(filtername!=""){
					result=_.chain(rawdata.fleetdistdata)
						.filter(function(stooge){
							return stooge.trancode==filtername;
						})
						.countBy(function(stooge){return stooge[groupname]})
						.map(function(stooge){return stooge})
						.value();
				}
				else{
					result=_.chain(rawdata.fleetdistdata)
						.countBy(function(stooge){return stooge[groupname]})
						.map(function(stooge){return stooge})
						.value();	
				}
				
			}
			else if(grouptype=="group"){
				if(filtername!=""){
					result=_.chain(rawdata.fleetdistdata)
						.filter(function(stooge){
							return stooge.trancode==filtername;
						})
						.groupBy(function(obj){
							return obj[groupname];
						})
						.map(function(obj,y){
							return y;
						})
						.value();	
				}
				else{
					result=_.chain(rawdata.fleetdistdata)
						.groupBy(function(obj){
							return obj[groupname];
						})
						.map(function(obj,y){
							return y;
						})
						.value();	
				}
				
			}
			return result;
		}
		function SaveToDisk(fileURL, fileName) {
	   		var host = window.location.origin;
	   		var splt = fileURL.split("webapps"); 
	   		var repl = splt[1].replace( /;/g, "/");
	   		fileURL=host+repl;
	    	
	    	if (!window.ActiveXObject) {
	        	var save = document.createElement('a');
	        	save.href = fileURL;
	        	save.target = '_blank';
	        	save.download = fileName || 'unknown';
	        	window.open(save.href,"mywindow","menubar=1,resizable=1,width=500,height=500");
	    	}

	    	// for IE
	    	else if ( !! window.ActiveXObject && document.execCommand){
	        	var _window = window.open(fileURL, '_blank');
	        	_window.document.close();
	        	_window.document.execCommand('SaveAs', true, fileName || fileURL)
	       	 	_window.close();
	    	}
		}
    	function funRoundAmt(value,id){
    		var res=parseFloat(value).toFixed(2);
    		var res1=(res=='NaN'?"0":res);
    		document.getElementById(id).value=res1;  
   		}
   		
    </script>    
</body>
</html>