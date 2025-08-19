<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>HR Dashboard</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
		<link rel="stylesheet" href="../vendors/animate/animate.css">
		<%-- <jsp:include page="floorMgmtIncludes.jsp"></jsp:include> --%>
		<link href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
		<link href="../vendors/select2/css/select2.min.css" rel="stylesheet" />
		<link href="../css/loginutil.css" rel="stylesheet" />
		<style>
			
			@font-face {
				font-family: Poppins-Regular;
			  	src: url('../vendors/fonts/Poppins/Poppins-Regular.ttf'); 
			}
			
			@font-face {
			  	font-family: Poppins-Medium;
			  	src: url('../vendors/fonts/Poppins/Poppins-Medium.ttf'); 
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
			.page-loader{
				position:fixed;
				top:50%;
				left:50%;
				transform:translate(-50%,-50%);
				z-index:9999999;
				width:100vw;
				height:100vh;
				background-color:rgba(255,255,255,0.9);
			}
			.page-loader button,.page-loader button:hover,.page-loader button:active,.page-loader button:focus{
				background-color: #5867dd;
		    	border-color: #5867dd;
				color:#fff;
				margin:0 auto;
				position:absolute;
				top:50%;
				left:50%;
				transform:translate(-50%,-50%);
			}
			.border{
				border:1px solid red;
			}
			.present{
				color: #10C90D;
			}
			.absent,.late{
				color:#ff8a5c 
			}
			.leave{
				color: #cf455c;
			}
			.font-bold{
				font-weight: 700;
			}
			#chartContainer {
  				width: 100%;
  				height: 500px;
			}
			.canvasjs-chart-credit{
				display:none;
			}
		</style>
		<!-- Resources -->
	</head>
	<body>
		<div class="page-loader">
			<button type="button" class="btn btn-brand"><i class="fa fa-circle-o-notch fa-spin fa-fw"></i> Loading</button>
		</div>
		<nav class="navbar navbar-default navbar-fixed-top">
  			<div class="container-fluid">
    			<div class="navbar-header">
      				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span>
        				<span class="icon-bar"></span> 
      				</button>
      				<a class="navbar-brand" href="#">HR Dashboard</a>
    			</div>
    			<div class="collapse navbar-collapse" id="myNavbar">
      				<!-- <ul class="nav navbar-nav">
        				<li class="active"><a href="#">Home</a></li>
        				<li><a href="#">Page 1</a></li>
        				<li><a href="#">Page 2</a></li> 
        				<li><a href="#">Page 3</a></li> 
      				</ul> -->
      				<ul class="nav navbar-nav navbar-right">
        				<%-- <li><a href="#"><span class="fa fa-bell-o"></span></a></li>
        				<li class="dropdown">
        					<a class="dropdown-toggle" data-toggle="dropdown" href="#"><span class="fa fa-user"></span> John Doe
        					<span class="caret"></span>
        					</a>
        					<ul class="dropdown-menu">
          						<li><a href="#">Sign Out</a></li>
          						<li><a href="#">Change Password</a></li>
        					</ul>
      					</li> --%>
      				</ul>
    			</div>
  			</div>
		</nav>
	
		<div class="container-fluid m-t-60 ">
			<div class="row">
				<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
					<div class="panel panel-default">
				  		<div class="panel-body">
				  			<div class="row">
				    			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				    				<p class="m-b-0"><strong>Welcome Back</strong></p>
				    			</div>
				    			<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6">
				    				<p class="m-b-0 pull-right last-updated">Last Updated On </p>
				    			</div>
				    		</div>
				  		</div>
					</div>
					<ul class="nav nav-pills nav-justified">
		    			<!-- <li><a data-toggle="pill" href="#menuoverview">Overview</a></li> -->
		    			<li class="active"><a data-toggle="pill" href="#menudept">Department Wise</a></li>
		    			<li><a data-toggle="pill" href="#menudesig">Designation Wise</a></li>
		    			<!-- <li><a data-toggle="pill" href="#menuholidays">Holidays</a></li> -->
		  			</ul>
		  			<div class="tab-content p-t-10">
		    			<!-- <div id="menuoverview" class="tab-pane fade in active">
		      				
		    			</div> -->
		    			<div id="menudept" class="tab-pane fade in active">
		    				<div class="row">
		    					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
		    						<div class="panel panel-default">
				  						<div class="panel-body">
				  							<div class="row">
				    								<div class="col-xs-4 col-sm-4 col-md-4 col-lg-3">
				    									<p class="m-b-0">Departments</p>
				    								</div>
				    								<div class="col-xs-2 col-sm-2 col-md-2 col-lg-3">
				    									<p class="text-center m-b-0">Total Emp.</p>
				    								</div>
				    								<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    									<p class="text-center m-b-0">Today</p>
				    								</div>
				    								<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    									<p class="text-center m-b-0">This Month</p>
				    								</div>
				    								<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    									<p class="text-center m-b-0">This Year</p>
				    								</div>
				    							</div>
				  						</div>
									</div>
				      				<div class="panel-group" id="deptaccordion" role="tablist" aria-multiselectable="true">
				  						
									</div>
		    					</div>
		    					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		    						<div class="panel panel-default">
		  								<div class="panel-body">
		  									<div class="row">
		    									<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		    										<p class="m-b-0">Attendance <span class="hryear">2019</span></p>
		    									</div>
		    								</div>
		  								</div>
									</div>
									<canvas id="myChart"></canvas>
		    					</div>
		    				</div>
		    				
		    			</div>
		    			<div id="menudesig" class="tab-pane fade">
		      				<div class="row">
		    					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8">
		    						<div class="panel panel-default">
				  						<div class="panel-body">
				  							<div class="row">
				    							<div class="col-xs-4 col-sm-4 col-md-4 col-lg-3">
				    								<p class="m-b-0">Designations</p>
				    							</div>
				    							<div class="col-xs-2 col-sm-2 col-md-2 col-lg-3">
				    								<p class="text-center m-b-0">Total Emp.</p>
				    							</div>
				    							<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    								<p class="text-center m-b-0">Today</p>
				    							</div>
				    							<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    								<p class="text-center m-b-0">This Month</p>
				    							</div>
				    							<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
				    								<p class="text-center m-b-0">This Year</p>
				    							</div>
				    						</div>
				  						</div>
									</div>
				      				<div class="panel-group" id="desigaccordion" role="tablist" aria-multiselectable="true">
				  						
									</div>
		    					</div>
		    					<div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">
		    						<div class="panel panel-default">
		  								<div class="panel-body">
		  									<div class="row">
		    									<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		    										<p class="m-b-0">Attendance <span class="hryear">2019</span></p>
		    									</div>
		    								</div>
		  								</div>
									</div>
									<canvas id="myChart2"></canvas>
		    					</div>
		    				</div>
		    				
		    			</div>
		    			<!-- <div id="menuholidays" class="tab-pane fade">
		      
		    			</div> -->
		  			</div>
				</div>
			</div>
			
		</div>	
		<script src="../vendors/jquery/jquery-3.2.1.min.js"></script>
		<script src="../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
		<script src="../vendors/chartjs/chart.js"></script>
		<script type="text/javascript">
			var dt = new Date();

			// ensure date comes as 01, 09 etc
			var DD = ("0" + dt.getDate()).slice(-2);
			
			// getMonth returns month from 0
			var MM = ("0" + (dt.getMonth() + 1)).slice(-2);
			
			var YYYY = dt.getFullYear();
			
			var hh = ("0" + dt.getHours()).slice(-2);
			
			var mm = ("0" + dt.getMinutes()).slice(-2);
			
			var ss = ("0" + dt.getSeconds()).slice(-2);
			
			var date_string = DD + "-" + MM + "-" + YYYY + " " + hh + ":" + mm;
			$('.last-updated').text('Last Updated On '+date_string);
			var ctx = document.getElementById('myChart').getContext('2d');
			var ctx2 = document.getElementById('myChart2').getContext('2d');
			var chart;
			var chart2;
			var options = {
				responsive:true,
    			tooltips: {
      				callbacks: {
        				label: function(tooltipItem, data) {
        					//var tooltiplabel = data.datasets[tooltipItem.datasetIndex].data[currentIndex] || '';
        					var dataset = data.datasets[tooltipItem.datasetIndex];
          					var total = dataset.data.reduce(function(previousValue, currentValue, currentIndex, array) {
            					return previousValue + currentValue;
          					});
          					var currentValue = dataset.data[tooltipItem.index];
          					var percentage = Math.floor(((currentValue/total) * 100)+0.5);         
          					return percentage + "%";
        				}
      				}
      			}
    			/*plugins: {
        			datalabels: {
            			formatter: (value, ctx) => {
                			let sum = 0;
                			let dataArr = ctx.chart.data.datasets[0].data;
                			dataArr.map(data => {
                    			sum += data;
                			});
                			let percentage = (value*100 / sum).toFixed(2)+"%";
                			return percentage;
            			},
            			color: '#fff',
        			}
    			}*/
			};
			
			
			chart = new Chart(ctx, {
    			// The type of chart we want to create
    			type: 'pie',

    			// The data for our dataset
    			data: {
        			labels: ['Present', 'Absent', 'Leave'],
        			datasets: [{
            			label: 'My First dataset',
            			backgroundColor: ['#67b7dc','#6794dc','#a367dc'],
            			borderColor: ['#67b7dc','#6794dc','#a367dc'],
            			data: [42, 8, 10]
        			}]
    			},

    			// Configuration options go here
    			options: options
			});
			
			chart2 = new Chart(ctx2, {
    			// The type of chart we want to create
    			type: 'pie',

    			// The data for our dataset
    			data: {
        			labels: ['Present', 'Absent', 'Leave'],
        			datasets: [{
            			label: 'My First dataset',
            			backgroundColor: ['#67b7dc','#6794dc','#a367dc'],
            			borderColor: ['#67b7dc','#6794dc','#a367dc'],
            			data: [42, 8, 10]
        			}]
    			},

    			// Configuration options go here
    			options: options
			});
			$(window).ready(function(){
				
				getInitData();
			});
			
			function getInitData(){
				var x=new XMLHttpRequest();
				x.onreadystatechange=function(){
					if (x.readyState==4 && x.status==200){
		 				var deptdata=x.responseText.trim().split("::")[0];
		 				deptdata=JSON.parse(deptdata);
		 				var desigdata=x.responseText.trim().split("::")[1];
		 				desigdata=JSON.parse(desigdata);
		 				var panelhtml='';
		 				var chartleaveyear=0,chartabsentyear=0,chartpresentyear=0;
		 				$.each( deptdata, function( key, value ) {
		 					panelhtml+='<div class="panel panel-default">';
							panelhtml+='<div class="panel-heading border" role="tab" id="deptheading1">';
							panelhtml+='<div class="row">';
							panelhtml+='<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">';
							panelhtml+='<h4 class="panel-title">';
							panelhtml+='<a role="button" data-toggle="collapse" data-parent="#accordion" href="#dept'+deptdata[key].deptdocno+'" aria-expanded="true" aria-controls="dept'+deptdata[key].deptdocno+'">';
							panelhtml+=deptdata[key].deptname;
							panelhtml+='</a>';
							panelhtml+='</h4>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center">';
							panelhtml+='<span class="emp-total text-bold">'+deptdata[key].totalempcount+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center today">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+deptdata[key].presenttoday+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+deptdata[key].absenttoday+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+deptdata[key].leavetoday+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center this-month">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+deptdata[key].presentmonth+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+deptdata[key].absentmonth+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+deptdata[key].leavemonth+'</span>';

							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center this-year">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+deptdata[key].presentyear+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+deptdata[key].absentyear+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+deptdata[key].leaveyear+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							
							panelhtml+='<div id="dept'+deptdata[key].deptdocno+'" class="panel-collapse collapse " role="tabpanel" aria-labelledby="deptheading'+deptdata[key].deptdocno+'">';
							panelhtml+='<div class="panel-body table-responsive">';
							panelhtml+='<table class="table">';
							panelhtml+='<thead>';
							panelhtml+='<tr>';
							panelhtml+='<th>Sr.No</th>';
							panelhtml+='<th>Employee ID</th>';
							panelhtml+='<th>Employee Name</th>';
							panelhtml+='<th class="text-center">In Time</th>';
							panelhtml+='<th class="text-center">Status</th>';
							panelhtml+='<th class="text-center">This Month</th>';
							panelhtml+='<th class="text-center">This Year</th>';
							panelhtml+='</tr>';
							panelhtml+='</thead>';
							panelhtml+='<tbody>';
							
							$.each( deptdata[key].deptemp, function( empkey, value ) {
								panelhtml+='<tr>';
								panelhtml+='<td>'+deptdata[key].deptemp[empkey].srno+'</td>';
								panelhtml+='<td>'+deptdata[key].deptemp[empkey].codeno+'</td>';
								panelhtml+='<td>'+deptdata[key].deptemp[empkey].empname+'</td>';
								panelhtml+='<td class="text-center">'+deptdata[key].deptemp[empkey].intime+'</td>';
								panelhtml+='<td class="text-center">'+deptdata[key].deptemp[empkey].status+'</td>';
								panelhtml+='<td class="text-center">';
								panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+deptdata[key].deptemp[empkey].presentmonth+'</span>';
								panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+deptdata[key].deptemp[empkey].absentmonth+'</span>';
								panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+deptdata[key].deptemp[empkey].leavemonth+'</span>';
								panelhtml+='</td>';
								panelhtml+='<td class="text-center">';
								panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+deptdata[key].deptemp[empkey].presentyear+'</span>';
								panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+deptdata[key].deptemp[empkey].absentyear+'</span>';
								panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+deptdata[key].deptemp[empkey].leaveyear+'</span>';
								panelhtml+='</td>';
								chartleaveyear+=deptdata[key].deptemp[empkey].leaveyear;
								chartpresentyear+=deptdata[key].deptemp[empkey].presentyear;
								chartabsentyear+=deptdata[key].deptemp[empkey].absentyear;
								panelhtml+='</tr>';	
							});
							
							panelhtml+='</tbody>';
							panelhtml+='</table>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
		 				});
		 				
		 				$('#deptaccordion').html($.parseHTML(panelhtml));
		 				panelhtml='';
		 				$.each( desigdata, function( key, value ) {
		 					panelhtml+='<div class="panel panel-default">';
							panelhtml+='<div class="panel-heading border" role="tab" id="desigheading1">';
							panelhtml+='<div class="row">';
							panelhtml+='<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">';
							panelhtml+='<h4 class="panel-title">';
							panelhtml+='<a role="button" data-toggle="collapse" data-parent="#accordion" href="#desig'+desigdata[key].desigdocno+'" aria-expanded="true" aria-controls="desig'+desigdata[key].desigdocno+'">';
							panelhtml+=desigdata[key].designame;
							panelhtml+='</a>';
							panelhtml+='</h4>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center">';
							panelhtml+='<span class="emp-total text-bold">'+desigdata[key].totalempcount+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center today">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+desigdata[key].presenttoday+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+desigdata[key].absenttoday+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+desigdata[key].leavetoday+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center this-month">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+desigdata[key].presentmonth+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+desigdata[key].absentmonth+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+desigdata[key].leavemonth+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">';
							panelhtml+='<div class="text-center this-year">';
							panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+desigdata[key].presentyear+'</span>';
							panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+desigdata[key].absentyear+'</span>';
							panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+desigdata[key].leaveyear+'</span>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							
							panelhtml+='<div id="desig'+desigdata[key].desigdocno+'" class="panel-collapse collapse " role="tabpanel" aria-labelledby="desigheading'+desigdata[key].desigdocno+'">';
							panelhtml+='<div class="panel-body table-responsive">';
							panelhtml+='<table class="table">';
							panelhtml+='<thead>';
							panelhtml+='<tr>';
							panelhtml+='<th>Sr.No</th>';
							panelhtml+='<th>Employee ID</th>';
							panelhtml+='<th>Employee Name</th>';
							panelhtml+='<th class="text-center">In Time</th>';
							panelhtml+='<th class="text-center">Status</th>';
							panelhtml+='<th class="text-center">This Month</th>';
							panelhtml+='<th class="text-center">This Year</th>';
							panelhtml+='</tr>';
							panelhtml+='</thead>';
							panelhtml+='<tbody>';
							
							$.each( desigdata[key].deptemp, function( empkey, value ) {
								panelhtml+='<tr>';
								panelhtml+='<td>'+desigdata[key].deptemp[empkey].srno+'</td>';
								panelhtml+='<td>'+desigdata[key].deptemp[empkey].codeno+'</td>';
								panelhtml+='<td>'+desigdata[key].deptemp[empkey].empname+'</td>';
								panelhtml+='<td class="text-center">'+desigdata[key].deptemp[empkey].intime+'</td>';
								panelhtml+='<td class="text-center">'+desigdata[key].deptemp[empkey].status+'</td>';
								panelhtml+='<td class="text-center">';
								panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+desigdata[key].deptemp[empkey].presentmonth+'</span>';
								panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+desigdata[key].deptemp[empkey].absentmonth+'</span>';
								panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+desigdata[key].deptemp[empkey].leavemonth+'</span>';
								panelhtml+='</td>';
								panelhtml+='<td class="text-center">';
								panelhtml+='<span class="emp-present m-r-10 present font-bold" data-toggle="tooltip" data-placement="bottom" title="Present">'+desigdata[key].deptemp[empkey].presentyear+'</span>';
								panelhtml+='<span class="emp-absent m-r-10 absent font-bold" data-toggle="tooltip" data-placement="bottom" title="Absent">'+desigdata[key].deptemp[empkey].absentyear+'</span>';
								panelhtml+='<span class="emp-leave leave font-bold" data-toggle="tooltip" data-placement="bottom" title="Leave">'+desigdata[key].deptemp[empkey].leaveyear+'</span>';
								panelhtml+='</td>';
								chartleaveyear+=desigdata[key].deptemp[empkey].leaveyear;
								chartpresentyear+=desigdata[key].deptemp[empkey].presentyear;
								chartabsentyear+=desigdata[key].deptemp[empkey].absentyear;
								panelhtml+='</tr>';	
							});
							
							panelhtml+='</tbody>';
							panelhtml+='</table>';
							panelhtml+='</div>';
							panelhtml+='</div>';
							panelhtml+='</div>';
		 				});
		 				chart.data.datasets[0].data[2] = chartleaveyear;
		 				chart.data.datasets[0].data[1] = chartabsentyear;
		 				chart.data.datasets[0].data[0] = chartpresentyear;
		 				chart2.data.datasets[0].data[2] = chartleaveyear;
		 				chart2.data.datasets[0].data[1] = chartabsentyear;
		 				chart2.data.datasets[0].data[0] = chartpresentyear;
						// Would update the first dataset's value of 'March' to be 50
						chart.update();
						chart2.update();
						// Calling update now animates the position of March from 90 to 50.
		 				$('#desigaccordion').html($.parseHTML(panelhtml));
		 				$(function () {
  							$('[data-toggle="tooltip"]').tooltip()
						});
		 				var basedate=new Date();
		 				$('.hryear').text(basedate.getFullYear());
		 				$('.page-loader').hide();
		 				
					}
					else
					{
					}
				}
				x.open("GET","getHRInitData.jsp",true);
				x.send();
			}
			
		</script>
	</body>
</html>