<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title>Customer Login</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/bootstrap-v3/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../js/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../vendors/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="../vendors/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="../vendors/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->

<script type="text/javascript">
	
</script>
</head>
<body>
		<div class="limiter">
			<div class="container-login100" style="background-image: url('images/bg-01.jpg');">
				<div class="wrap-login100 p-l-110 p-r-110 p-t-30 p-b-33">
					<form class="login100-form validate-form flex-sb flex-w" id="frmCustomerLogin" action="saveCustomerLogin" method="post">
						<span class="login100-form-title p-b-20">
							Customer Login
						</span>
	<!-- 
						<a href="#" class="btn-face m-b-20">
							<i class="fa fa-facebook-official"></i>
							Facebook
						</a>
	
						<a href="#" class="btn-google m-b-20">
							<img src="images/icons/icon-google.png" alt="GOOGLE">
							Google
						</a>
						 -->
						<div class="p-t-20 p-b-9">
							<span class="txt1">
								Username
							</span>
						</div>
						<div class="wrap-input100 validate-input" data-validate = "Username is required">
							<input class="input100" type="text" name="clientusername" id="clientusername">
							<span class="focus-input100"></span>
						</div>
						
						<div class="p-t-13 p-b-9">
							<span class="txt1">
								Password
							</span>
	<!-- 
							<a href="#" class="txt2 bo1 m-l-5">
								Forgot?
							</a> -->
						</div>
						<div class="wrap-input100 validate-input" data-validate = "Password is required">
							<input class="input100" type="password" name="clientpassword" id="clientpassword">
							<span class="focus-input100"></span>
						</div>
	
						<div class="container-login100-form-btn m-t-17">
							<button class="login100-form-btn btn-client-login" type="button">
								Sign In
							</button>
						</div>
	<!-- 
						<div class="w-full text-center p-t-55">
							<span class="txt2">
								Not a member?
							</span>
	
							<a href="#" class="txt2 bo1">
								Sign up now
							</a>
						</div> -->
						<input type="hidden" name="docno" id="docno">
						<input type="hidden" name="mode" id="mode">
						<input type="hidden" name="msg" id="msg">
					</form>
				</div>
			</div>
		</div>
   
	<div id="dropDownSelect1"></div>
	
<!--===============================================================================================-->
	<script src="../js/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/bootstrap-v3/js/popper.js"></script>
	<script src="../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/daterangepicker/moment.min.js"></script>
	<script src="../vendors/daterangepicker/daterangepicker.min.js"></script>
<!--===============================================================================================-->
	<script src="../vendors/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>