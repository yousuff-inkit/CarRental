<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
<!DOCTYPE html>
<html lang="en">
<head>
	<title>GW Query Builder</title>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="../../includes.jsp"></jsp:include>
	<script src="../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="../../vendors/bootstrap-v3/css/bootstrap.min.css">
	
	<link href="../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
	<link href="../../vendors/select2/css/select2.min.css" rel="stylesheet" />
	<style type="text/css">
	  	:root {
		    --theme-deafult: #7366ff;
		    --theme-secondary: #f73164;
		}
		@font-face {
	  		font-family: Poppins;
	  		src: url('../../vendors/fonts/Poppins/Poppins-Regular.ttf')  format('truetype');
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
	.ml-1{
		margin-left:1rem;
	}
	.mr-1{
		margin-right:1rem;
	}
	
	.sidepanel {
  		height: 100%; /* Specify a height */
  		width: 0px; /* 0 width - change this with JavaScript */
  		position: fixed; /* Stay in place */
  		z-index: 1; /* Stay on top */
  		top: 60px;
  		right: 0;
  		overflow-x: hidden; /* Disable horizontal scroll */
  		
  		transition: all 0.5s ease-in; /* 0.5 second transition effect to slide in the sidepanel */
	}
	.select2-container{
		margin-top:0.8rem;
	}
	.data-section div{
		overflow:auto;
		height:80vh;
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
    <nav class="navbar navbar-default">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="#">GW Query Builder</a>
    		</div>
    		<ul class="nav navbar-nav">
    			<li>
    				<button class="btn btn-default" style="margin-top:0.8rem;" onclick="onExecQuery();">Execute Query</button>
    			</li>
    			<li>
    				<select name="cmbdatabase" id="cmbdatabase" class="form-control" style="margin-top:0.8rem;margin-left:0.5rem;">
    					<option value="">--Select--</option>
    				</select>
    			</li>
    		</ul>
    		
    		<ul class="nav navbar-nav navbar-right">
    			<li><a href="#!" onclick="onToggleSidebar();"><i class="fa fa-bars"></i></a></li>
    		</ul>
  		</div>
	</nav>
	<div class="container-fluid">
		<div class="row">
			<div class="col-xs-12">
				<section class="query-section">
					<div class="form-group">
						<textarea rows="" cols="" class="form-control" id="query-text"></textarea>
					</div>
					
				</section>
			</div>
		</div>
		<div class="row">
			<div class="col-xs-12">
				<section class="data-section">
					
				</section>
			</div>
		</div>
	</div>
	<div id="mySidepanel" class="sidepanel" style="background-color:#fff;">
		<div class="container-fluid">
			<p><strong>DATABASES</strong></p>
			<ul class="list-group db-list">
	  			
	  		</ul>
		</div>
	</div>
	
	<div id="loginmodal" class="modal fade" role="dialog">
  		<div class="modal-dialog">
			<div class="modal-content">
      			<div class="modal-header">
        			<h4 class="modal-title">Login</h4>
      			</div>
      			<div class="modal-body">
      				<div class="form-group">
        				<label for="mysqlusername">Username:</label>
    					<input type="text" class="form-control" id="mysqlusername">
    					<span class="help-block"></span>
        			</div>
        			<div class="form-group">
        				<label for="mysqlpassword">Password:</label>
    					<input type="password" class="form-control" id="mysqlpassword">
    					<span class="help-block"></span>
        			</div>
      			</div>
      			<div class="modal-footer">
        			<button type="button" class="btn btn-primary btn-signin" >Sign In</button>
      			</div>
    		</div>
  		</div>
	</div>
<script src="../../js/sweetalert2.all.min.js"></script>
<script src="../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('.page-loader').hide();
		$('input').attr('autocomplete','off');
		getInitData();
		$("#loginmodal").modal({backdrop: "static",keyboard:false});
		
		$('.btn-signin').click(function(){
			var mysqlpassword=$('#mysqlpassword').val();
			var mysqlusername=$('#mysqlusername').val();
			$('.page-loader').show();
			$.post('checkLogin.jsp',{'mysqlpassword':mysqlpassword,'mysqlusername':mysqlusername},function(data,status){
				$('.page-loader').hide();
				data=JSON.parse(data);
				if(data.errorstatus=="0"){
					$('#mysqlpassword').closest('.form-group').addClass('has-success');
					$('#mysqlpassword').closest('.form-group').find('span.help-block').text('Sign in Successfull');
					$("#loginmodal").modal('hide');
				}
				else{
					$('#mysqlpassword').closest('.form-group').addClass('has-error');
					$('#mysqlpassword').closest('.form-group').find('span.help-block').text('Incorrect Password');
				}
			});
		});
	});
	
	function getInitData(){
		$.post('getInitData.jsp',function(data,status){
			data=JSON.parse(data);
			var htmldata='',dblist='';
			$.each(data.dblist,function(index,value){
				htmldata+='<li class="list-group-item"><a href="#!"><i class="fa fa-database mr-1"></i>'+value.dbname+'</a></li>';
				dblist+='<option value="'+value.dbname+'">'+value.dbname+'</option>';
			});
			
			$('#cmbdatabase').html($.parseHTML(dblist));
			$('#cmbdatabase').select2({
				placeholder:'Choose Database',
				allowClear:true
			});
			$('.db-list').html($.parseHTML(htmldata));
		});
	}
	function onToggleSidebar(){
		var sidepanelwidth=$('#mySidepanel').css('width');
		if(sidepanelwidth=='0px'){
			$('#mySidepanel').css('width','250px');
		}
		else{
			$('#mySidepanel').css('width','0px');
		}
	}
	
	function onExecQuery(){
		var querytext=$('#query-text').val();
		var dbname=$('#cmbdatabase').val();
		if(querytext==''){
			$('#query-text').closest('.form-group').addClass('has-error');
		}
		else{
			$('#query-text').closest('.form-group').removeClass('has-error');		
		}
		$('.page-loader').show();
		$.post('getQueryData.jsp',{'query':querytext,'dbname':dbname},function(data){
			data=JSON.parse(data);
			$('.data-section').html('');
			if(data.sqltype=='rs'){
				var sqlmessage=data.sqlmessage;
				var htmldata='';
				if(sqlmessage!=null && sqlmessage!="" && sqlmessage!="undefined" && typeof(sqlmessage)!="undefined"){
					htmldata='<div class="alert alert-danger"><a href="#" class="alert-link">'+sqlmessage+'</a></div>';
				}
				else{
					htmldata='<div class="table-responsive container-fluid">';
					htmldata+='<table class="table table-hover"><thead>';
					htmldata+='<tr>';
					$.each(data.columnnames,function(index,value){
						htmldata+='<th>'+value+'</th>';
					});
					htmldata+='</tr>';
					htmldata+='</thead>';
					htmldata+='<tbody>';
					$.each(data.columnvalues,function(index,value){
						htmldata+='<tr>';
						$.each(value,function(subindex,subvalue){
							htmldata+='<td>'+subvalue+'</td>';
						});
						htmldata+='<tr>';
					});
					htmldata+='</tbody>';
					htmldata+='</table>';
					htmldata+='</div>';
				}
				
				$('.data-section').html($.parseHTML(htmldata));
				$('.page-loader').hide();
			}
			else if(data.sqltype=='stmt'){
				var sqlmessage=data.sqlmessage;
				var htmldata='';
				if(sqlmessage!=null && sqlmessage!="" && sqlmessage!="undefined" && typeof(sqlmessage)!="undefined"){
					htmldata='<div class="alert alert-danger"><a href="#" class="alert-link">'+sqlmessage+'</a></div>';
				}
				else{
					htmldata='<div class="alert alert-success"><a href="#" class="alert-link">'+data.rowsaffected+' Rows Affected</a></div>';
				}
				$('.data-section').html($.parseHTML(htmldata));
				$('.page-loader').hide();
			}
		});
	}
</script>
</body>
</html>
