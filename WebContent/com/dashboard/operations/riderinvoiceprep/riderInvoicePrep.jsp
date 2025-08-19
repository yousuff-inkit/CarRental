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
    <div class="row hidden" style="margin-top:8px;">
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsegip">
					<svg  id="svg1" version="1.1" fill="none" height="24" stroke="#fff" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" class="icon-bg">
						<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"></path>
						<g>
						<polyline points="10 17 15 12 10 7"></polyline>
						<line x1="15" x2="3" y1="12" y2="12"></line>
						</g>
					</svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Gate In Pass</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseest">
					<svg class="icon-bg" id="Layer_1" style="enable-background:new 0 0 30 30;" version="1.1" viewBox="0 0 30 30" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><path d="M7,22  V4h18v18c0,2.209-1.791,4-4,4" style="fill:none;stroke:#fff;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;"/><path d="M17,22  L17,22H4l0,0c0,2.209,1.791,4,4,4h13C18.791,26,17,24.209,17,22z" style="fill:none;stroke:#fff;stroke-width:2;stroke-linecap:round;stroke-linejoin:round;stroke-miterlimit:10;"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="13" y2="13"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="13" y2="13"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="17" y2="17"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="17" y2="17"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="15" x2="21" y1="9" y2="9"/><line style="fill:none;stroke:#fff;stroke-width:2;stroke-linejoin:round;stroke-miterlimit:10;" x1="11" x2="13" y1="9" y2="9"/><path style="fill:none;" d="M17,22L17,22H4l0,0c0,2.209,1.791,4,4,4h13C18.791,26,17,24.209,17,22z"/></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Estimation</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item"  data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejob">
					<svg class="icon-bg" height="8.4666mm" style="shape-rendering:geometricPrecision; text-rendering:geometricPrecision; image-rendering:optimizeQuality; fill-rule:evenodd; clip-rule:evenodd" version="1.1" viewBox="0 0 846.66 846.66" width="8.4666mm" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><defs><style type="text/css">
   <![CDATA[
    .fil0 {fill:#fff;fill-rule:nonzero}
   ]]>
  </style></defs><g id="Layer_x0020_1"><path class="fil0" d="M57.69 10.3l586.02 0c11.4,0 20.65,9.24 20.65,20.64l0 86.43 124.61 0c11.4,0 20.64,9.24 20.64,20.64l0 677.71c0,11.4 -9.24,20.64 -20.64,20.64l-586.02 0c-11.4,0 -20.65,-9.24 -20.65,-20.64l0 -86.43 -124.61 0c-11.4,0 -20.64,-9.24 -20.64,-20.64l0 -677.71c0,-11.4 9.24,-20.64 20.64,-20.64zm606.67 148.36l0 549.99c0,11.4 -9.25,20.64 -20.65,20.64l-420.11 0 0 65.78 544.72 0 0 -636.41 -103.96 0zm-375.67 176.69c-5.31,26.52 -45.63,18.46 -40.33,-8.06 5.33,-26.52 20.73,-49.83 42.89,-65.22 -1.02,-1.32 -2,-2.68 -2.93,-4.07 -8.05,-12.01 -12.75,-26.38 -12.75,-41.76 0,-41.49 33.64,-75.13 75.13,-75.13 41.49,0 75.13,33.64 75.13,75.13 0,16.64 -5.53,32.68 -15.68,45.83 22.17,15.38 37.57,38.7 42.89,65.22 5.3,26.52 -35.02,34.58 -40.32,8.06 -4.36,-21.68 -20.08,-39.68 -40.91,-47.03 -6.82,2.03 -13.99,3.06 -21.11,3.06 -7.1,0 -14.29,-1.03 -21.11,-3.06 -20.83,7.35 -36.55,25.34 -40.9,47.03zm62.01 -85.26c18.93,0 33.84,-15.08 33.84,-33.85 0,-18.69 -15.15,-33.84 -33.84,-33.84 -18.69,0 -33.84,15.15 -33.84,33.84 0,18.93 15.09,33.85 33.84,33.85zm-151.48 198.89c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 149.5c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm0 -74.75c-27.16,0 -27.16,-41.29 0,-41.29l302.97 0c27.16,0 27.16,41.29 0,41.29l-302.97 0zm423.84 -472.14l-544.72 0 0 636.41 544.72 0 0 -636.41z"/></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Job Card</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapsejcc">
					<svg class="icon-bg" style="enable-background:new 0 0 50 50;" version="1.1" viewBox="0 0 50 50" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"><style type="text/css">
	.st0{display:none;}
	.st1{display:inline;}
	.st2{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-miterlimit:10;}
	.st3{display:inline;fill:none;stroke:#fff;stroke-width:5;stroke-linecap:round;stroke-miterlimit:10;}
	.st4{display:inline;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st5{fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st6{display:inline;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
	.st7{display:none;fill:none;stroke:#fff;stroke-width:3;stroke-linecap:round;stroke-miterlimit:10;}
</style><g class="st0" ><g class="st1"><g><path d="M19.5,8.2c6.2,0,11.3,5.1,11.3,11.3s-5.1,11.3-11.3,11.3S8.2,25.8,8.2,19.5S13.2,8.2,19.5,8.2 M19.5,5.2     c-7.9,0-14.3,6.4-14.3,14.3s6.4,14.3,14.3,14.3s14.3-6.4,14.3-14.3S27.3,5.2,19.5,5.2L19.5,5.2z"/></g></g><line class="st2" x1="28.8" x2="32.1" y1="28.7" y2="32"/><line class="st3" x1="44.8" x2="33" y1="44.8" y2="33"/></g><g class="st0" ><path class="st4" d="M46.3,13.9H3.7c-0.3,0-0.5-0.2-0.5-0.5V6.6c0-0.6,0.4-1,1-1h41.7c0.6,0,1,0.4,1,1v6.8   C46.8,13.7,46.6,13.9,46.3,13.9z"/><path class="st4" d="M42.5,44.4H7.5c-0.6,0-1-0.4-1-1V13.9h37.1v29.5C43.5,43.9,43.1,44.4,42.5,44.4z"/><path class="st4" d="M32.3,26.5H18.2c-1.6,0-2.9-1.3-2.9-2.9v0c0-1.6,1.3-2.9,2.9-2.9h14.1c1.6,0,2.9,1.3,2.9,2.9v0   C35.2,25.1,33.9,26.5,32.3,26.5z"/></g><g class="st0" ><path class="st4" d="M11.6,41.3h-3c-0.6,0-1-0.4-1-1v-32c0-0.6,0.4-1,1-1h3V41.3z"/><path class="st4" d="M32.2,6.1H12.6c-0.6,0-1,0.4-1,1v35.8c0,0.6,0.4,1,1,1h28.9c0.6,0,1-0.4,1-1V15c0-0.3-0.1-0.6-0.4-0.8   l-9.2-7.8C32.7,6.2,32.4,6.1,32.2,6.1z"/><line class="st4" x1="32.2" x2="32.2" y1="6.1" y2="14.9"/><line class="st4" x1="42.4" x2="32.2" y1="15" y2="15"/><g class="st1"><line class="st5" x1="19" x2="36" y1="20.9" y2="20.9"/><line class="st5" x1="19" x2="33.3" y1="26" y2="26"/><line class="st5" x1="19" x2="36" y1="30.9" y2="30.9"/><line class="st5" x1="19" x2="33.3" y1="35.6" y2="35.6"/></g></g><g class="st0" ><path class="st4" d="M38.5,32.6v10.7c0,0.6-0.4,1-0.9,1H9.3c-0.5,0-0.9-0.4-0.9-1V6.6c0-0.6,0.4-1,0.9-1h28.3c0.5,0,0.9,0.4,0.9,1   v10.5"/><path class="st6" d="M28.5,30V20c0-0.2-0.3-0.4-0.5-0.2l-6.6,5c-0.2,0.1-0.2,0.4,0,0.5l6.6,5C28.3,30.4,28.5,30.2,28.5,30z"/><line class="st4" x1="28.5" x2="45.6" y1="25" y2="25"/></g><g class="st0" ><path class="st4" d="M9.9,16.1h31.3v-4.6c0-0.6-0.4-1-1-1H4.4c-0.6,0-1,0.4-1,1v23.2c0,0.6,0.4,1,1,1h4.6V17.1   C8.9,16.5,9.4,16.1,9.9,16.1z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1H46c0.6,0,1,0.4,1,1v24.7C47,42.4,46.6,42.8,46,42.8z"/><path class="st4" d="M46,42.8H9.9c-0.6,0-1-0.4-1-1V17.1c0-0.6,0.4-1,1-1l15.3,14.6c1.5,1.5,4,1.5,5.5,0L46,16.1c0.6,0,1,0.4,1,1   v24.7C47,42.4,46.6,42.8,46,42.8z"/><line class="st4" x1="22.3" x2="8.9" y1="27.9" y2="38.6"/><line class="st4" x1="33.6" x2="47" y1="28.1" y2="38.9"/></g><g class="st0" ><path class="st6" d="M30.8,36.6l5.8,8.1c0.1,0.2,0.5,0.2,0.5-0.1l2.5-7.9c0.1-0.2-0.1-0.4-0.3-0.4L31,36.1   C30.8,36.1,30.7,36.4,30.8,36.6z"/><path class="st6" d="M18.7,12.6l-5.8-8.1c-0.1-0.2-0.5-0.2-0.5,0.1l-2.5,7.9c-0.1,0.2,0.1,0.4,0.3,0.4l8.3,0.2   C18.7,13.1,18.9,12.8,18.7,12.6z"/><path class="st4" d="M39.4,36.5c-3.5,4.3-8.7,7-14.6,7c-10.4,0-18.8-8.4-18.8-18.8c0-1.5,0.2-2.9,0.5-4.3"/><path class="st4" d="M10.1,12.6c3.5-4.3,8.7-7,14.6-7c10.4,0,18.8,8.4,18.8,18.8c0,1.5-0.2,2.9-0.5,4.3"/></g><path class="st7" d="M25.1,5.3c-11.5,0-20.9,8.1-20.9,18.2c0,5.8,3.1,11,8,14.3L7.5,45  c-0.2,0.2,0.1,0.5,0.3,0.4c4.7-0.6,8.9-2,12.5-4.3c1.5,0.3,3.1,0.5,4.8,0.5c11.5,0,20.9-8.1,20.9-18.2S36.7,5.3,25.1,5.3z" /><g id="SLA"><path class="st5" d="M43.4,44.4H6.6c-0.6,0-1-0.4-1-1V6.6c0-0.6,0.4-1,1-1h36.8c0.6,0,1,0.4,1,1v36.8   C44.4,43.9,43.9,44.4,43.4,44.4z"/><g><g><line class="st5" x1="11.9" x2="24.4" y1="36.2" y2="36.2"/><line class="st7" x1="30.7" x2="33.2" y1="34.8" y2="37.5"/><line class="st7" x1="38.1" x2="33.2" y1="32.5" y2="37.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="26.2" y2="26.2"/><line class="st5" x1="30.7" x2="33.2" y1="24.8" y2="27.5"/><line class="st5" x1="38.1" x2="33.2" y1="22.5" y2="27.5"/></g><g><line class="st5" x1="11.9" x2="24.4" y1="16.2" y2="16.2"/><line class="st5" x1="30.7" x2="33.2" y1="14.8" y2="17.5"/><line class="st5" x1="38.1" x2="33.2" y1="12.5" y2="17.5"/></g></g></g><g class="st0" ><path class="st4" d="M44.2,9.3H5.7c-0.6,0-1-0.4-1-1V4.9c0-0.6,0.4-1,1-1h38.5c0.6,0,1,0.4,1,1v3.4C45.2,8.9,44.7,9.3,44.2,9.3z"/><path class="st4" d="M42.2,38.4H7.7c-0.6,0-1-0.4-1-1V9.3h36.5v28.1C43.2,38,42.7,38.4,42.2,38.4z"/><line class="st4" x1="25" x2="25" y1="42.8" y2="38.4"/><circle class="st4" cx="25" cy="45.6" r="2.2"/><g class="st1"><line class="st5" x1="28" x2="38.7" y1="18.8" y2="18.8"/><line class="st5" x1="28" x2="38.7" y1="23.9" y2="23.9"/><line class="st5" x1="28" x2="38.7" y1="29" y2="29"/><path class="st5" d="M17.8,23.4l-0.6-5.2c0-0.2-0.1-0.3-0.3-0.3c-3.5,0.2-6.2,3.5-5.4,7.1c0.5,2.2,2.3,4,4.5,4.5    c3.7,0.8,6.9-1.9,7.1-5.3c0-0.2-0.1-0.3-0.3-0.3L17.8,23.4z"/></g></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Job Card Complete</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapseinv">
					<svg class="icon-bg" style="fill: #fff;stroke: none;" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><defs><style>.cls-1{fill:none;}</style></defs><title/><g data-name="Layer 2" id="Layer_2"><path d="M26,26H6a3,3,0,0,1-3-3V9A3,3,0,0,1,6,6H26a3,3,0,0,1,3,3V23A3,3,0,0,1,26,26ZM6,8A1,1,0,0,0,5,9V23a1,1,0,0,0,1,1H26a1,1,0,0,0,1-1V9a1,1,0,0,0-1-1Z"/><path d="M14,22H8a1,1,0,0,1,0-2h6a1,1,0,0,1,0,2Z"/><path d="M28,13H4a1,1,0,0,1,0-2H28a1,1,0,0,1,0,2Z"/></g><g id="frame"><rect class="cls-1" height="32" width="32"/></g></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Invoiced</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
			<div class="col-xs-12 col-sm-4 col-md-2 col-lg-2">
				<div class="card-item" data-parent="#floorcard" data-toggle="collapse" data-target="#collapserls">
					<svg class="icon-bg" fill="none" height="24" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" x2="9" y1="12" y2="12"/></svg>
					<h2><span class="value">102</span></h2>
					<h6><strong>Released</strong></h6>
					<small><span class="value">102</span> out of <span class="totalcount"></span></small>
					<div class="progress">
						<div class="progress-bar" role="progress-bar" style="width:0%;"></div>
					</div>
				</div>
			</div>
		</div>
    	<div class="row rowgap">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		<div class=" primarypanel custompanel">
        		<div class="form-group"  style="display:flex; align-items:center; margin: 0px 0px;">
        			<div style="display:flex; align-items:center;">
 		       			<label for="formonth" >Month : &nbsp; </label>
        				<div id="formonth"></div>
        			</div>
        			<div style="margin-left:4px;">
	        			<select name="cmbbranch" id="cmbbranch" class="form-control" style="width:200px;"><option value="">--Select--</option></select>
        			</div>
        			<div style="margin-left:4px;">
  						<button type="button" class="btn btn-default" id="btnsubmit" data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>
  						<button type="button" class="btn btn-default" id="btnremove" data-toggle="tooltip" title="Remove" data-placement="bottom"><i class="fa fa-trash-o" aria-hidden="true"></i></button>
          				<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        			</div>
        		</div>
        		</div>
        		<div class="primarypanel custompanel" style="display: flex;">
    <div class="border1">
        <input type="file" id="fileexcelimport" name="file" style="display: none;">
        <span id="file-name" class="file-name">No file chosen</span>
        <label for="fileexcelimport" class="custom-file-upload btn btn-default" style="font-weight: normal;">Choose File</label>
       <button type="button" class="btn btn-default" id="btnuploaddata" ><i class="fa fa-upload" aria-hidden="true" data-toggle="tooltip" title="Upload" data-placement="bottom"></i></button>
    </div>
</div>
        		
        		<!-- <div class="actionpanel custompanel">
          			<button type="button" class="btn btn-default" id="btnvehmovupdate" data-target="#modalvehmovupdate" ><i class="fa fa-car " aria-hidden="true" data-toggle="tooltip" title="Vehicle Movement Update" data-placement="bottom"></i></button>
        		</div> -->
        		<!-- <div class="warningpanel custompanel">
          			<div class="btn-group" role="group">
          				<button type="button" class="btn btn-default" id="btnpartsdelay" data-toggle="tooltip" title="Parts Delay" data-placement="bottom" data-filtervalue="Delayed" data-datafield="partsstatus" data-filtertype="stringfilter" data-filtercondition="contains"><i class="fa fa-cogs " aria-hidden="true"></i></button>
          				<span class="badge badge-notify badge-partsdelay">3</span>
          			</div>	        	
        		</div> -->
        		<div class="detailpanel custompanel">
          			<button type="button" class="btn btn-default" id="btnsummary" ><i class="fa fa-file-text-o" aria-hidden="true" data-toggle="tooltip" title="Summary" data-placement="bottom"></i></button>
          			<!-- <button type="button" class="btn btn-default" id="btncreatemovement" ><i class="fa fa-exchange" aria-hidden="true" data-toggle="tooltip" title="Create Movement" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnassignclient"><i class="fa fa-user-plus" aria-hidden="true" data-toggle="tooltip" title="Assign Client" data-placement="bottom"></i></button>
          			<button type="button" class="btn btn-default" id="btnupdatestatus" ><i class="fa fa-flag" aria-hidden="true" data-toggle="tooltip" title="Update Status" data-placement="bottom"></i></button> -->
          			
        		</div>
        		 <!-- <div class="otherpanel custompanel">
        			 <button type="button" class="btn btn-default" id="btnattach"><i class="fa fa-paperclip" aria-hidden="true" data-toggle="tooltip" title="Attachments" data-placement="bottom"></i></button>
	        		<button type="button" class="btn btn-default" id="btncomment"  data-target="#modalcomments" ><i class="fa fa-comments " aria-hidden="true" data-toggle="tooltip" title="Comments" data-placement="bottom"></i></button>
        	</div> -->
        		<div class="textpanel custompanel" style="max-width:300px;height:55px;">
					<p style="word-wrap: break-word;font-size:1.1rem;">&nbsp;</p>
        		</div>
      		</div>
    	</div>
    	<div class="row">
      		<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        		 <div id="maingriddiv"><jsp:include page="riderInvoiceGrid.jsp"></jsp:include></div>
      		</div>
    	</div>
    	
    		<!-- Summary Modal-->
    	<div id="modalsummary" class="modal fade" role="dialog">
      		<div class="modal-dialog modal-xl" style="width:1250px;">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Summary</h4>
          			</div>
          			<div class="modal-body">
            			<div class="comments-outer-container container-fluid">
              				<div class="comments-container">
            					<div id="summarygriddiv"><jsp:include page="ripsummarygrid.jsp"></jsp:include></div>
              				</div>
              				<div class="create-msg-container">
                				<!-- <div class="container-fluid"> -->
                  				<div class="row">
                    				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      					<div class="input-group">
                      					</div>
                    				</div>
                  				</div>
                			<!-- </div> -->
              				</div>
            			</div>
          			</div>
          			 <div class="modal-footer">
            			<button type="button" class="btn btn-default" id="btngenerate">Generate</button>
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div> 
        		</div>
      		</div>
    	</div>
	
    	<!-- Comments Modal-->
    	<div id="modalcomments" class="modal fade" role="dialog">
      		<div class="modal-dialog">
        		<div class="modal-content">
          			<div class="modal-header">
            			<button type="button" class="close" data-dismiss="modal">&times;</button>
            			<h4 class="modal-title">Comments</h4>
          			</div>
          			<div class="modal-body">
            			<div class="comments-outer-container container-fluid">
              				<div class="comments-container">
              				</div>
              				<div class="create-msg-container">
                				<!-- <div class="container-fluid"> -->
                  				<div class="row">
                    				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      					<div class="input-group">
                        					<input type="text" class="form-control" placeholder="Please Type In" id="txtcomment">
                        					<div class="input-group-btn">
                          						<button type="button" id="btncommentsend" class="btn btn-default">
                            						<i class="fa fa-paper-plane"></i>
                          						</button>
                        					</div>
                      					</div>
                    				</div>
                  				</div>
                			<!-- </div> -->
              				</div>
            			</div>
          			</div>
          			<!-- <div class="modal-footer">
            			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          			</div> -->
        		</div>
      		</div>
    	</div>
  </div>
  <input type="hidden" name="empdocno" id="empdocno">
  <input type="hidden" name="rowindex" id="rowindex">
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<!--  -->
<script src="../../../../js/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>

<script type="text/javascript">
	var rawfilterdata=[];

    $(document).ready(function(){
    	
    	
    	 $("#formonth").jqxDateTimeInput({
             width: '110px',
             height: '30px',
             formatString: 'MMMM yyyy', // Display format: Full month and year
             dropDownHorizontalAlignment: 'left', // Align dropdown
         });

    	
        $('[data-toggle="tooltip"]').tooltip();
        
        getInitData();
        funGetCountData();
        funGetFilterData();
        $('.load-wrapp').hide();
      //Custom file upload button  
        document.getElementById("fileexcelimport").addEventListener("change", function() {
            var fileName = this.files[0] ? this.files[0].name : "No file chosen";
            var maxLength = 15; // Set the maximum number of characters for the name

            // Separate the name and extension
            var dotIndex = fileName.lastIndexOf(".");
            var name = fileName.substring(0, dotIndex);
            var extension = fileName.substring(dotIndex);

            // Truncate the name if it exceeds maxLength
            var displayName = name.length > maxLength 
                              ? name.substring(0, maxLength) + "..." + extension 
                              : fileName;

            document.getElementById("file-name").textContent = displayName;
            
        });
        $('#btnuploaddata').click(function(){
        	upload();
        });
        
        $('#btngenerate').click(function(){
        	//alert("Entered")
        	funCheckIsGenerated();
        });
        
       
        $('#btnattach').click(function(){
        	var targetid=$(this).attr('id');
        	var rowindex=$('#rowindex').val();
        	var docno=$('#riderGrid').jqxGrid('getcellvalue',rowindex,'empdocno');
        	//var vocno=$('#riderGrid').jqxGrid('getcellvalue',rowindex,'vocno');
			var brhid=$('#riderGrid').jqxGrid('getcellvalue',rowindex,'brhid');
        	//var processstatus=$('#riderGrid').jqxGrid('getcellvalue',rowindex,'processstatus');
        	if(docno=='' || docno==null || docno=="undefined" || typeof(docno)=="undefined"){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
				return false;
        	}
        	var formname="Rider Management";
        	var  myWindow= window.open("../../../../com/common/Attachmaster.jsp?formCode=RDM&docno="+docno+"&brchid="+brhid+"&frmname="+formname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
        });
        
        $('.card-item').click(function(){
        	var textstatus='All';
			$('.card-item').not(this).each(function(){
				if($(this).hasClass('active')){
					$(this).removeClass('active');		
				}
			});
			
			$(this).toggleClass('active');
			if($(this).hasClass('active')){
				textstatus=$(this).find('h6 strong').text();
				var filtergroup = new $.jqx.filter();
		    	var filter_or_operator = 1;
		    	var filtervalue=$(this).find('h6').text(); 
		    	var filtercondition = 'EQUAL';
		    	var filter1 = filtergroup.createfilter("stringfilter", filtervalue, filtercondition);
		
		    	filtergroup.addfilter(filter_or_operator, filter1);
		    	if(textstatus=='Estimation'){
		    		filter2 = filtergroup.createfilter("stringfilter", "Quotation Approval", filtercondition);
		    		filtergroup.addfilter(filter_or_operator, filter2);
		    	}
		    	//filtergroup.addfilter(filter_or_operator, filter2);
		    	// add the filters.
		    	$("#riderGrid").jqxGrid('addfilter', 'gipprocess', filtergroup);
		    	// apply the filters.
		    	$("#riderGrid").jqxGrid('applyfilters');
		    	
			}
			else{
				$('#riderGrid').jqxGrid('removefilter','gipprocess', true);
			}

        });
        $('#btnsubmit').click(function(){
        	//$('.page-loader').show();
        	loadGrid();
        	var brhid=$('#cmbbranch').val();
        	//$('#maingriddiv').load('riderGrid.jsp?id=1&brhid='+brhid);
        });
        
        $('#btnremove').click(function(){
        	//$('.page-loader').show();
        	var date = $('#formonth').val();
        	var rows = $('#jqxtinting').jqxGrid('getrows');
    		var rowCount = rows.length;
    		
    		if(rowCount<=0){
    			$.messager.show({
                    title: 'Message',
                    msg: 'No data to be removed!',
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
    		let isGenerated = false;
    		let isPayroll = false;
    		
    		for(let i=0;i<rowCount;i++){
    			if(!($('#jqxtinting').jqxGrid('getcellvalue',i, 'issrs')<=0)){
    				isGenerated = true;
    			}
    			
    			if(!($('#jqxtinting').jqxGrid('getcellvalue',i, 'ispayroll')<=0)){
    				isPayroll = true;
    			}
    		}
    		
    		if(isGenerated){
    			$.messager.show({
                    title: 'Message',
                    msg: 'SRS has been generated, cannot delete',
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
        	
    		if(isPayroll){
    			$.messager.show({
                    title: 'Message',
                    msg: 'Payroll has been generated, cannot delete',
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
    		
        	Swal.fire({
        		title: 'Are you sure?',
        		text: "Do you want to remove the uploaded data of period - "+date,
        		icon: 'warning',
        		showCancelButton: true,
        		confirmButtonColor: '#3085d6',
        		cancelButtonColor: '#d33',
        		confirmButtonText: 'Yes'
        	}).then((result) => {
        		if (result.isConfirmed) {
        			removeUploadedData();
        		}
        	});
        	        	//$('#maingriddiv').load('riderGrid.jsp?id=1&brhid='+brhid);
        });
        
        $('#btnexcel').click(function(){
        	$("#jqxtinting").excelexportjs({
				containerid: "jqxtinting",
				datatype: 'json',
				dataset: null,
				gridId: "jqxtinting",
				columns: getColumns("jqxtinting"),
				worksheetName: "Rider Invoice Prep Data"
			});
        });
        
        $('#btnsaveassignclient').click(function(){
        	var empdocno=$('#empdocno').val();
        	if(empdocno==""){
        		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Please select an employee'
				});
        		return false;
        	}
        	
        	var clientacno=$('#cmbclient').val();
        	if(clientacno==""){
        		$('#cmbclient').closest('.form-group').addClass('has-error');
        		$('#cmbclient').closest('.form-group').find('.control-container').append('<span class="help-block">Client is mandatory</span>')
        		return false;
        	}
        	else{
        		$('#cmbclient').closest('.form-group').removeClass('has-error');
        		$('#cmbclient').closest('.form-group').find('.control-container .help-block').remove();
        	}
        	
        	var clientuid=$('#clientuid').val();
        	if(clientuid==""){
        		$('#clientuid').closest('.form-group').addClass('has-error');
        		$('#clientuid').closest('.form-group').find('.control-container').append('<span class="help-block">Client Unique Number is mandatory</span>')
        		return false;
        	}
        	else{
        		$('#clientuid').closest('.form-group').removeClass('has-error');
        		$('#clientuid').closest('.form-group').find('.control-container .help-block').remove();
        	}
        	
        	Swal.fire({
        		title: 'Are you sure?',
        		text: "Do you want to assign client for Emp#"+$('.empid').text(),
        		icon: 'warning',
        		showCancelButton: true,
        		confirmButtonColor: '#3085d6',
        		cancelButtonColor: '#d33',
        		confirmButtonText: 'Yes'
        	}).then((result) => {
        		if (result.isConfirmed) {
        			var saldocno=$('#riderGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'saldocno');
        			var riderdocno=$('#riderGrid').jqxGrid('getcellvalue',$('#rowindex').val(),'riderdocno');
        			$.post('assignClient.jsp',{'saldocno':saldocno,'clientacno':clientacno,'clientuid':clientuid,'riderdocno':riderdocno},function(data,status){
        				data=JSON.parse(data);
        				if(data.errorstatus=="0"){
        					Swal.fire({
        						icon:'success',
        						title: 'Success',
        						text: 'Client Assigned Successfully'
        					});
        					$('#modalAssignClient').modal('hide');
        					$('#clientuid,#empdocno,#rowindex').val('');
        					$('#cmbclient').val('').trigger('change');
        					$('.empid').text('');
        					$('#btnsubmit').trigger('click');
        				}
        				else{
        					Swal.fire({
        						icon:'warning',
        						title: 'Warning',
        						text: 'Not Updated'
        					});
        				}
        			});
        		}
        	});
        });
        
        $('#btnsummary').click(function(){
        	var date = $('#formonth').jqxDateTimeInput('getDate');
    	    let month = date.getMonth() + 1;
    	    let year = date.getFullYear();
    		var brchid=$('#cmbbranch').val();
    		if(date==null || typeof(date)=='undefined'){
    			 $.messager.show({
                     title: 'Message',
                     msg: 'Select valid date',
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
    		$('#modalsummary').modal('show');
    		$("#summarygriddiv").load("ripsummarygrid.jsp?docNo="+docNo+"&brchid=" +brchid+"&month="+month+"&year="+year+"&chk=1");
    		

        });

        $('#btncommentsend').click(function(){
        	var txtcomment=$('#txtcomment').val();
        	var empdocno=$('#empdocno').val();
        	if(txtcomment==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please type in comment'
				});
        		return false;
        	}
        	if(empdocno==""){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please select a document'
				});
        		return false;
        	}
        	
        	saveComment();
        });
        
        
        $('.warningpanel div button').click(function(){
        	var gridrows=$('#riderGrid').jqxGrid('getrows');
        	if(gridrows.length==0){
        		Swal.fire({
					icon:'warning',
					type: 'error',
					title: 'Warning',
					text: 'Please submit'
				});
				return false;
        	}
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('id'),$(this).attr('data-filtervalue'),$(this).attr('data-datafield'),$(this).attr('data-filtertype'),$(this).attr('data-filtercondition'));
        	}
        	else{
        		$('#riderGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });
        
        
    }); 
    
    function upload(){     
  	  var type=$('#type').val();
  	  var brch=$('#cmbbranch').val();
  	  
  	  if(brch==0 || brch=="" || brch=="a"){
  		  $.messager.alert('Message', 'Select Branch.');
            return false;
  		  
  	  }
  	  if(type==0){
  		  $.messager.alert('Message', 'Select Type.');
            return false;
  		  
  	  }
  			 $.messager.confirm('Confirm', 'Do you want to Import Excel?', function(r){
  				   if (r==false){
  					
  						return 0;
  					}
  					else
  						{
  						$("#overlay, #PleaseWait").show();
  						$("#cmbbranch").val(1);
  	  					$('#txtexcelvalidation').val(1);
  	  					getAttachDocumentNo();
  						}
  			 });
  		
  	 
    }
    
    function getAttachDocumentNo() {
	    var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.trim();

	            if (items > 0) {

	                var path = document.getElementById("fileexcelimport").value;
	                var fsize = $('#fileexcelimport')[0].files[0].size;
	                var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
	                ajaxFileUpload(items);

	               /*  if ((extn == 'xls') || (extn == 'csv')) {
	                    ajaxFileUpload(items);
	                } else {
	                    $.messager.show({
	                        title: 'Message',
	                        msg: 'File of xlsx Format is not Supported.',
	                        showType: 'show',
	                        style: {
	                            left: '',
	                            right: 27,
	                            top: document.body.scrollTop + document.documentElement.scrollTop,
	                            bottom: ''
	                        }
	                    });
	                    return;
	                } */
	            }
	        }
	    }

	    x.open("GET", "getAttachDocumentNo.jsp", true);
	    x.send();
	}
    
	function ajaxFileUpload(docNo) {
		//alert("test")
	    if (window.File && window.FileReader && window.FileList && window.Blob) {
	        var fsize = $('#fileexcelimport')[0].files[0].size;

	        if (fsize > 1048576) {
	            $.messager.show({
	                title: 'Message',
	                msg: fsize + ' bytes too big ! Maximum Size 1 MB.',
	                showType: 'show',
	                style: {
	                    left: '',
	                    right: 27,
	                    top: document.body.scrollTop + document.documentElement.scrollTop,
	                    bottom: ''
	                }
	            });
	            return;
	        }
	    } else {
	        $.messager.show({
	            title: 'Message',
	            msg: 'Please upgrade your browser, because your current browser lacks some new features we need!',
	            showType: 'show',
	            style: {
	                left: '',
	                right: 27,
	                top: document.body.scrollTop + document.documentElement.scrollTop,
	                bottom: ''
	            }
	        });
	        return;
	    }

	    $.ajaxFileUpload({
	    	
	    	 url:'fileAttachAction.action?formCode=RIIP&doc_no='+docNo+'&descpt=Excel Import' ,   
	    	secureuri: false,
	        fileElementId: 'fileexcelimport',
	        dataType: 'json',
	        success: function(data, status) {
	        	//alert("status--"+status)
	            if (status == 'success') {
	            	//alert("test"+docNo)
	                saveExcelDataData(docNo);
	                $.messager.show({
	                    title: 'Message',
	                    msg: 'Successfully Uploaded',
	                    showType: 'show',
	                    style: {
	                        left: '',
	                        right: 27,
	                        top: document.body.scrollTop + document.documentElement.scrollTop,
	                        bottom: ''
	                    }
	                });
	            }

	            if (typeof(data.error) != 'undefined') {
	                if (data.error != '') {
	                    $.messager.show({
	                        title: 'Message',
	                        msg: data.error,
	                        showType: 'show',
	                        style: {
	                            left: '',
	                            right: 27,
	                            top: document.body.scrollTop + document.documentElement.scrollTop,
	                            bottom: ''
	                        }
	                    });
	                } else {
	                    $.messager.show({
	                        title: 'Message',
	                        msg: data.message,
	                        showType: 'show',
	                        style: {
	                            left: '',
	                            right: 27,
	                            top: document.body.scrollTop + document.documentElement.scrollTop,
	                            bottom: ''
	                        }
	                    });
	                }
	            }
	        },
	        error: function(data, status, e) {
	            $.messager.alert('Message', e);
	        }
	    });
	    return false;
	}
    
	var excelDocNo=0;
	
		function saveExcelDataData(docNo) {
			var date = $('#formonth').jqxDateTimeInput('getDate');
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
		  var x = new XMLHttpRequest();
	    x.onreadystatechange = function() {
	        if (x.readyState == 4 && x.status == 200) {
	            var items = x.responseText.trim();

	            if (parseInt(items)> 0) {
	            	 $.messager.alert('Message', ' Successfully Imported.');
	                $("#btnupdate").attr("disabled",false);
	                $("#fileexcelimport").val('');
	                excelDocNo = docNo;
	               // alert('excelDocNo' +excelDocNo)
	               // var type=$('#type').val();
		            $("#maingriddiv").load("riderInvoiceGrid.jsp?docNo="+docNo+"&brchid=" +brchid+"&month="+month+"&year="+year+"&chk=1");
		               
	            }

	        }
	    }

	    x.open("GET", "saveData.jsp?docNo=" + docNo+"&brchid="+brchid+"&month="+month+"&year="+year, true);
	    x.send();
	} 
		
	function loadGrid(){
		var date = $('#formonth').jqxDateTimeInput('getDate');
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
		$("#maingriddiv").load("riderInvoiceGrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
	}
	
	function removeUploadedData(){
		var date = $('#formonth').jqxDateTimeInput('getDate');
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
		  var x = new XMLHttpRequest();
		  x.onreadystatechange = function() {
		  if (x.readyState == 4 && x.status == 200) {
		  	var items = x.responseText.trim();
		    if (parseInt(items)> 0) {
		      $.messager.alert('Message', ' Successfully Removed.');
			            $("#maingriddiv").load("riderInvoiceGrid.jsp?brchid="+brchid+"&month="+month+"&year="+year+"&chk=1");
			               
		            }
		        }
		    }
		    x.open("GET", "removedata.jsp?brchid="+brchid+"&month="+month+"&year="+year, true);
		    x.send();
	}
		
		
    function addGridFilters(id,filtervalue,datafield,filtertype,filtercondition){
    	var filtergroup = new $.jqx.filter();
    	var filter_or_operator = 1;
    	if(id=="btnoverdue"){
    		filtervalue=new Date();
    	} 
    	//var filtercondition = 'contains';
    	var filter1 = filtergroup.createfilter(filtertype, filtervalue, filtercondition);
    	/*filtervalue = 'Andrew';
    	filtercondition = 'starts_with';
    	var filter2 = filtergroup.createfilter('stringfilter', filtervalue, filtercondition);*/

    	filtergroup.addfilter(filter_or_operator, filter1);
    	//filtergroup.addfilter(filter_or_operator, filter2);
    	// add the filters.
    	$("#riderGrid").jqxGrid('addfilter', datafield, filtergroup);
    	// apply the filters.
    	$("#riderGrid").jqxGrid('applyfilters');
 	}
    function saveComment(){
    	var comment=$('#txtcomment').val();
    	var docno=$('#empdocno').val();
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				getComments();	
				$('#txtcomment').val('');
			}
			else
			{
			}
		}
		x.open("GET","saveComment.jsp?comment="+comment.replace(/ /g, "%20")+"&docno="+docno+"&dtype=RDM",true);
		x.send();
    }
    function getComments(){
    	var docno=$('#empdocno').val();
    	$('.comments-container').html('');
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				if(x.responseText.trim()!=""){
					var items=x.responseText.trim().split(",");
					var str='';
					for(var k=0;k<items.length;k++){
						str+='<div class="comment"><div class="msg"><p>'+items[k].split("::")[0]+'</p></div><div class="msg-details"><p>'+items[k].split("::")[1]+' - '+items[k].split("::")[2]+'</p></div></div>';
					}
					$('.comments-container').html($.parseHTML(str));		
				}
			
			}
			else
			{
			}
		}
		x.open("GET","getComments.jsp?docno="+docno+"&dtype=RDM",true);
		x.send();
    }
    
    function funGetCountData(){
    	var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				var htmldata='';
				$.each(items.branchdata,function(index,value){
	  				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
	  			});
	  			$('#cmbbranch').html($.parseHTML(htmldata));
	  			htmldata='<option value="">--Select--</option>';
				$.each(items.clientdata,function(index,value){
	  				htmldata+='<option value="'+value.cldocno+'">'+value.refname+'</option>';
	  			});
				$('.page-loader').show();
				funGetFilterData();
				$('#maingriddiv').load('riderGrid.jsp?id=1&brhid='+$("#cmbbranch").val());
	  			
			}
			else
			{
			}
		}
		x.open("GET","getCountData.jsp",true);
		x.send();
    }

	function funGetFilterData(){
		$.get('getFilterData.jsp', { brhid:$('#cmbbranch').val() }, function(data) {
   			data=JSON.parse(data);
   			var htmldata='<option value="">Choose Client</option>';
   			$.each(data.clientdata,function(index,value){
   				htmldata+='<option value="'+value.acno+'">'+value.refname+'</option>';
   			});
   			
   			$('#cmbclient').html($.parseHTML(htmldata));
   			$('#cmbclient').select2({
   				placeholder:"Choose Client",
   				allowClear:true
   			});
   			
   			/* 
   			var gippercent=((parseFloat(data.gipcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var estpercent=((parseFloat(data.estcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var jobpercent=((parseFloat(data.jobcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var jccpercent=((parseFloat(data.jcccount)/parseFloat(data.totalcount))*100).toFixed(0);
			var invpercent=((parseFloat(data.invcount)/parseFloat(data.totalcount))*100).toFixed(0);
			var rlspercent=((parseFloat(data.relcount)/parseFloat(data.totalcount))*100).toFixed(0);
			if (isNaN(gippercent)) gippercent = 0;
			if (isNaN(estpercent)) estpercent = 0;
			if (isNaN(jobpercent)) jobpercent = 0;
			if (isNaN(jccpercent)) jccpercent = 0;
			if (isNaN(invpercent)) invpercent = 0;
			if (isNaN(rlspercent)) rlspercent = 0;
			$('.card-item').eq(0).find('.value').text(data.gipcount).closest('.card-item').find('.progress-bar').css('width',gippercent+'%');
			$('.card-item').find('.totalcount').text(data.totalcount);
			$('.card-item').eq(1).find('.value').text(data.estcount).closest('.card-item').find('.progress-bar').css('width',estpercent+'%');
			$('.card-item').eq(2).find('.value').text(data.jobcount).closest('.card-item').find('.progress-bar').css('width',jobpercent+'%');
			$('.card-item').eq(3).find('.value').text(data.jcccount).closest('.card-item').find('.progress-bar').css('width',jccpercent+'%');
			$('.card-item').eq(4).find('.value').text(data.invcount).closest('.card-item').find('.progress-bar').css('width',invpercent+'%');
			$('.card-item').eq(5).find('.value').text(data.relcount).closest('.card-item').find('.progress-bar').css('width',rlspercent+'%'); */
		});
	}

	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data);
			var htmldata="";
			$.each(data.branchdata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#cmbbranch').html($.parseHTML(htmldata));
			
		});
	}
	
	function funCheckIsGenerated(){
		var date = $('#formonth').jqxDateTimeInput('getDate');
	    let month = date.getMonth() + 1;
	    let year = date.getFullYear();
	    let brchid = $("#cmbbranch").val();
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				items=JSON.parse(items);
				if(items>0){
					$.messager.show({
		                   title: 'Message',
		                   msg: 'SRS has already been generated for the selected month.',
		                   showType: 'show',
		                   style: {
		                       left: '',
		                       right: 27,
		                       top: document.body.scrollTop + document.documentElement.scrollTop,
		                       bottom: ''
		                   }
		               });
					   return false;
				} else {
					funSRSOpen();
				}
	  			
			}
			else
			{
			}
		}
		x.open("GET","chkIsGenerated.jsp?year="+year+"&month="+month+"&brchid="+brchid,true);
		x.send();
	}
	
	
	function funSRSOpen(){      
		
		var date = $('#formonth').jqxDateTimeInput('getDate');
	    let month = date.getMonth() + 1;
	    let year = date.getFullYear();
		
		  var gridrows=$('#jqxripsummary').jqxGrid('getrows');
		  
    	  var path1="com/project/execution/ServiceSale/serviceSale.jsp";  
    	  var name="Service Sale";
    	  var url=document.URL;
    	  var reurl=url.split("com/");    
    	  var brhid = $("#cmbbranch").val();
    	  
    	  window.parent.formName.value = "Service Sale"; 
    	  window.parent.formCode.value = "SRS";
    	  window.parent.branchid.value = brhid;  
    	  var detName = "Service Sale";  
    	  var mode = "A";
    	  var path= path1+"?month="+month+"&year="+year+"&mod="+mode+"&data="+encodeURIComponent(JSON.stringify(gridrows));          
    	  //console.log("path==="+path)
    	  top.addTab( detName,reurl[0]+""+path);  
        }
 
</script>
</body>
</html>
