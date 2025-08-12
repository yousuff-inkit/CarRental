<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html P0UBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Payroll Analysis</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://daneden.github.io/animate.css/animate.min.css">
<jsp:include page="../../../../travelIncludes.jsp"></jsp:include>            
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />
<style type="text/css">
.padrow{
padding:5px;
}
    .custompanel{
      float: left;
      display: inline-block;
      margin-top: 0px; 
      padding-top: 10px;
      padding-bottom: 0px;
      border-radius: 8px;
      padding-right: 5px;
    }
</style>
<script type="text/javascript">

	$(document).ready(function () {
		getYear();
		getEmployee();
		
		   $('#btnsubmit').click(function(){    
	            funreload(); 
	            
	        });
		   $('#btnexcel').click(function(){  
			   $("#pasdiv").excelexportjs({ 
	        		containerid: "pasdiv",       
	        		datatype: 'json', 
	        		dataset: null, 
	        		gridId: "jqxpasGrid",     
	        		columns: getColumns("jqxpasGrid") ,   
	        		worksheetName:"Payrollanalysis"     
	         	});  
	            
	        });
	});
	function funreload(){
		 $("#overlay, #PleaseWait").show();     
		  var year = $("#cmbyear").val(); 
		   var month = $("#cmbmonth").val(); 
		   var employee = $("#cmbemployee").val(); 
 	       $('#pasdiv').load('payrollanalysisgrid.jsp?id='+1+'&year='+year+'&month='+month+'&employee='+employee);  

	}
	  function getYear() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var yearItems = items[0].split(",");
					var yearIdItems = items[1].split(",");
					var optionsyear = '<option value="">--Select--</option>';
					for (var i = 0; i < yearItems.length; i++) {
						optionsyear += '<option value="' + yearIdItems[i] + '">'
								+ yearItems[i] + '</option>';
					}
				 $("select#cmbyear").html(optionsyear);  
				} else {
				}
			}
			x.open("GET", "getYear.jsp", true);
			x.send();
		}
	  
	  function getEmployee()  {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('####');
					var employeeItems = items[0].split(",");
					var employeeIdItems = items[1].split(",");
					var optionsemployee = '<option value="">--Select--</option>';
					for (var i = 0; i < employeeItems.length; i++) {
						optionsemployee += '<option value="' + employeeIdItems[i] + '">'
								+ employeeItems[i] + '</option>';
					}
				 	$("select#cmbemployee").html(optionsemployee);
				} else {
				}
			}
			x.open("GET", "getEmployee.jsp", true);
			x.send();
		}
		</script>
</head>
<body> 
<div class="hidden-scrollbar">                               
  <div class="container-fluid" >
    <div class="row" >
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> 
          <div class="primarypanel custompanel" style="margin-left:5px;">
      <label class="branch">Year</label>
         <select name="cmbyear" id="cmbyear">
		 <option value="">--Select--</option></select>
  
    <label class="branch">Month</label>
    	<select id="cmbmonth" name="cmbmonth">
     		<option value="">--Select--</option><option value="01">January</option><option value="02">February</option><option value="03">March</option>
      		<option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
     		<option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      		<option value="12">December</option></select>  
 
    	<label class="branch">Employee</label>
    	<select id="cmbemployee" name="cmbemployee" style="width:329px">
     		<option value="">--Select--</option></select>
 </div>
     	<div class="primarypanel custompanel">
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>        
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
        </div> 
     </div>
 </div>
   
    <div class="row padrow"> 
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">             
        <div id="pasdiv"><jsp:include page="payrollanalysisgrid.jsp"></jsp:include></div>          
      </div>
    </div>
    
    </div>
</div>	
</div>	
</body>
</html>	
   
      
    
    	

