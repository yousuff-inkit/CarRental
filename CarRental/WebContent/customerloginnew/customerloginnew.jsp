<!DOCTYPE html>
<html lang="en">
<head>
<title>User Dashboard</title>          
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="../gatelogo.ico">
<link rel="stylesheet" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
<link rel="stylesheet" href="../vendors/animate/animate.min.css">
<jsp:include page="../includes.jsp"></jsp:include>
<link href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../vendors/select2/select2.min.css" rel="stylesheet" />
<link href="css/util.css" rel="stylesheet" />
<style>
/* 	@import url(https://fonts.googleapis.com/css?family=Source+Sans+Pro);
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
      				<span style="margin-right:10px;"><img alt="" src="images/epic.jpg" style="width:auto; height: 100%;" class="img-responsive img-thumbnail"></span>
      				 Dashboard     
      			</a>
    		</div>
    		<div class="collapse navbar-collapse" id="myNavbar">
      			<ul class="nav navbar-nav navbar-right">
        			<li class="dropdown">
        				<a class="dropdown-toggle user-dropdown" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> <span class="user-dropdown-text">USER</span>
        					<span class="caret"></span>
        				</a>
        				<ul class="dropdown-menu">
          					<!-- <li><a href="#" onclick="location.replace('index.jsp');">Sign Out</a></li> -->
          					<li><a href="#" onclick="funLogout();">Sign Out</a></li>
        				</ul>
      				</li>
      			</ul>
    		</div>
  		</div>
	</nav> 
	
	<div class="container-fluid">
		<ul class="nav nav-pills custom-tabs nav-justified m-t-60 m-b-10">               
    		<li class="active"><a class="fs-12" data-toggle="pill" href="#menu1" id="dashboard"><i class="fa fa-tachometer p-r-5"></i>Dashboard</a></li> 
    		<li><a class="fs-12" data-toggle="pill" href="#menu2" id="accounts"><i class="fa fa-file-text p-r-5"></i>Accounts</a></li>
    	</ul>  
  	</div>
	
	<input type="hidden" name="address" id="address">
    <input type="hidden" name="exval" id="exval">
	<input type="hidden" name="tsrowno" id="tsrowno">
	<input type="hidden" name="latittude" id="latittude">
	<input type="hidden" name="longitude" id="longitude">                     
	<input type="hidden" name="clientacno" id="clientacno">
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
    	
   function funLogout(){
	   $.post('portalLogout.jsp',function(data,status){
		   data=JSON.parse(data);
	   		if(data.errorstatus=="0"){
	   			window.location.replace('index.jsp');
	   		}		
	   });
   }
    	$(document).ready(function(){ 
    		 
    		getInitData(); 
    		
    		var url=document.URL; 
			    var reurl=url.split("customerloginnew");  
			       var fpath=reurl[0]+'com/v2/dashBoardNum.jsp';
			 $("#folio").attr("src",fpath); 
    		
			 
          $('#dashboard').click(function(){
        	  var url=document.URL; 
 			    var reurl=url.split("customerloginnew");   
			       var fpath=reurl[0]+'com/v2/dashBoardNum.jsp';
 			 
 			 $("#folio").attr("src",fpath);  
          });
    		
          
          $('#accounts').click(function(){
      	       var url=document.URL; 
			     var reurl=url.split("customerloginnew");   
				   var fpath=reurl[0]+'com/reports/index.jsp';
			 
			 $("#folio").attr("src",fpath);  
      	  
  			
  		});
    		
   	});
   	function getInitData(){
   			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				$('.admin-cover .panel-body strong').text("Hi "+items.split("::")[0].trim());
	  				$('.user-dropdown .user-dropdown-text').text(items.split("::")[0].trim());
	  				
	  				$('.page-loader').hide();
	  			}
	  		}
	  		x.open("GET", "getClientInitData.jsp", true);
	  		x.send();
		} 
    	
    	 </script>    
    	 
    	 <iframe id="folio" style="overflow:visible; height:80vh;width: 98.9%;" scrolling="yes" >                                                                                       
</iframe>       
</body>     
</html>