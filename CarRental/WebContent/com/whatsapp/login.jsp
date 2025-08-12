<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="robots" content="noindex, nofollow">

    <title>WhatsApp ChatBox</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css" integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP" crossorigin="anonymous">
    <script type="text/javascript" src="../../js/jquery-1.11.1.min.js"></script>  
    <style type="text/css">   
		body,
		html {
			margin: 0;
			padding: 0;
			height: 100%;
			background-image: url("icons/whatsappbackground.jpg"); 
		}
		.user_card {
			height: 400px;
			width: 350px;
			margin-top: auto;
			margin-bottom: auto;
			background:#4c956c; 
			position: relative;  
			display: flex;
			justify-content: center;
			flex-direction: column;
			padding: 10px;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-webkit-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			-moz-box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			border-radius: 5px;
			
			background: rgba( 255, 255, 255, 0.25 );
			box-shadow: 0 8px 32px 0 rgb(18 61 20 / 37%);
			backdrop-filter: blur( 4px );
			-webkit-backdrop-filter: blur( 6px );
			border-radius: 10px;
			border: 1px solid rgba( 255, 255, 255, 0.18 );  

		}
		.brand_logo_container {
			position: absolute;
			height: 170px;
			width: 170px;
			top: -75px;
			border-radius: 50%;
			background: #00a884;   
			padding: 10px;
			text-align: center;
		}
		.brand_logo {
			height: 150px;
			width: 150px;
			border-radius: 50%;
			border: 2px solid white;
		}
		.form_container {
			margin-top: 50px;
		}  
	 
		.login_btn {
		  appearance: none;
		  background-color: #FFFFFF;
		  border-radius: 0.5em;
		  border-style: none;
		  box-shadow: #ADCFFF 0 -12px 6px inset;
		  box-sizing: border-box;
		  color: #000000;
		  cursor: pointer;
		  display: inline-block;
		  font-family: -apple-system,sans-serif;
		  font-size: 1.2rem;
		  font-weight: 550;
		  letter-spacing: -.24px;
		  margin: 0;
		  outline: none;
		  padding: 1rem 1.3rem;
		  quotes: auto;
		  text-align: center;
		  text-decoration: none;
		  transition: all .15s;
		  user-select: none;
		  -webkit-user-select: none;
		  touch-action: manipulation;
		  width: 250px;    
		}
		
		.login_btn:hover {
		  background-color: #00a884; 
		  box-shadow: #00a884 0 -6px 8px inset;
		  transform: scale(1.125);
		}
		
		.login_btn:active {
		  transform: scale(1.025);
		}
		
		@media (min-width: 768px) {
		  .login_btn {
		    font-size: 1.5rem;
		    padding: .01rem 2rem;
		  }  
		}
		.login_container {
			padding: 0 0.1rem;
		}
		.input-group-text {
			background:#00a884 !important;
			color: white !important;
			border: 0 !important;
			border-radius: 0.25rem 0 0 0.25rem !important;
		}
		.input_user,
		.input_pass:focus {
			box-shadow: none !important;
			outline: 0px !important;
		}
		.custom-checkbox .custom-control-input:checked~.custom-control-label::before {
			background-color: #c0392b !important;
		}   
		.label-style{
		    color: #ff1400;
		    font-weight: 500;
		    font-style: oblique;
		    font-family: sans-serif;
		} 
	</style>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
   
</head>
<body>
	<div class="container h-100">
		<div class="d-flex justify-content-center h-100">
			<div class="user_card">
				<div class="d-flex justify-content-center">  
					<div class="brand_logo_container">
						<img src="icons/whatsapplogo.jpg" class="brand_logo" alt="Logo">  
					</div>
				</div>
				<div class="d-flex justify-content-center form_container">   
					<form>
					    <div class="input-group mb-3">      
					        <label id="warningMessage" class="label-style"></label>
					    </div>
						<div class="input-group mb-3">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-user"></i></span>
							</div>
							<input type="text" name="loginname" id="loginname" class="form-control input_user" value="" placeholder="username">
						</div>
						<div class="input-group mb-2">
							<div class="input-group-append">
								<span class="input-group-text"><i class="fas fa-key"></i></span>
							</div>
							<input type="password" name="loginpass" id="loginpass" class="form-control input_pass" value="" placeholder="password">
						</div>
						<!--<div class="form-group">
							<div class="custom-control custom-checkbox">
								<input type="checkbox" class="custom-control-input" id="customControlInline">
								<label class="custom-control-label" for="customControlInline">Remember me</label>
							</div>
						</div>-->  
					  <div class="d-flex justify-content-center mt-3 login_container">
				 	     <button type="button" name="button" class="btn login_btn" id="loginbtn">Login</button>
				      </div>     
					</form>
				</div>
		
				<!--<div class="mt-4">
					<div class="d-flex justify-content-center links">
						Don't have an account? <a href="#" class="ml-2">Sign Up</a>
					</div>
					<div class="d-flex justify-content-center links">
						<a href="#">Forgot your password?</a>
					</div>
				</div>-->  
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#loginbtn').click(function(){
			login();      
		})
	})   
	
	function login() {   
        var username = document.getElementById("loginname").value;
        var password = document.getElementById("loginpass").value;

        $.ajax({
            type: "POST",
            url: "saveLogin.jsp",  
            data: {
                username: username,
                password: password
            },
            success: function(response) {
            	var items = response.split("####");  
                if(items[0].trim() === "1") {  
                    window.location.href = "whatsappchatbox.jsp?userid="+items[1].trim();
                } else {
                    document.getElementById("warningMessage").innerHTML = "Invalid username or password";
                    $('#warningMessage').fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
                }
            },
            error: function() {
                document.getElementById("warningMessage").innerHTML = "Error in login process";
            }
        });
    }
	</script>
</body>
</html>