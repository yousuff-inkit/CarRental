<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		
		 $("#leaveRequestDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#fromDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#toDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#halfDayDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close');
		 
		 $('#txtemployeeid').dblclick(function(){
	  		 employeeSearchContent("employeeDetailsSearch.jsp");
		 });
		 
		 getDesignation();getDepartment();getPayrollCategory();getLeaveType();
		 
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getDesignation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var designationItems = items[0].split(",");
				var designationIdItems = items[1].split(",");
				var optionsdesignation = '<option value="">--Select--</option>';
				for (var i = 0; i < designationItems.length; i++) {
					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
							+ designationItems[i] + '</option>';
				}
				$("select#cmbempdesignation").html(optionsdesignation);
				if ($('#hidcmbempdesignation').val() != null) {
					$('#cmbempdesignation').val($('#hidcmbempdesignation').val());
				}
			} else {
			}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
  
  function getDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartment = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbempdepartment").html(optionsdepartment);
				if ($('#hidcmbempdepartment').val() != null) {
					$('#cmbempdepartment').val($('#hidcmbempdepartment').val());
				}
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
  
  function getPayrollCategory() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var payrollcategoryItems = items[0].split(",");
				var payrollcategoryIdItems = items[1].split(",");
				var optionspayrollcategory = '<option value="">--Select--</option>';
				for (var i = 0; i < payrollcategoryItems.length; i++) {
					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
							+ payrollcategoryItems[i] + '</option>';
				}
				$("select#cmbpayrollcategory").html(optionspayrollcategory);
				if ($('#hidcmbpayrollcategory').val() != null) {
					$('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
				}
			} else {
			}
		}
		x.open("GET", "getPayrollCategory.jsp", true);
		x.send();
	}
  
	  function funNoofDaysLeave(){
			 
			 var leavestartday= $('#fromDate').jqxDateTimeInput('getDate');
			 var leaveendday= $('#toDate').jqxDateTimeInput('getDate');
	
			 if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leavestartday>leaveendday){
				 document.getElementById("errormsg").innerText="From Date Should be less than To Date.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
			 
			 var startdate = $('#fromDate').jqxDateTimeInput('getText');
			 var enddate = $('#toDate').jqxDateTimeInput('getText');
			 var halfday = $('#hidchckhalfday').val();
			 getNumberOfDays(startdate,enddate,halfday);
	}
	
	function getNumberOfDays(startdate,enddate,halfday){
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
				    $('#txtnoofdays').val(items.trim());
			}
			}
			x.open("GET", "getNumberOfDays.jsp?startdate="+startdate+'&enddate='+enddate+'&halfday='+halfday, true);
			x.send();
	 }
	
	function halfdaycheck(){
			 if(document.getElementById("chckhalfday").checked){
				 document.getElementById("hidchckhalfday").value = 1;
				 $('#halfDayDate').jqxDateTimeInput({disabled: false});
			 }
			 else{
				 document.getElementById("hidchckhalfday").value = 0;
				 $('#halfDayDate').jqxDateTimeInput({disabled: true});
		 	} 
		}
	
  function getLeaveType() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				console.log("Leave Type Data Received:", items);
				items = items.split('####');
				var leavetypeItems = items[0].split(",");
				var leavetypeIdItems = items[1].split(",");
				var optionsleavetype = '<option value="">--Select--</option>';
				for (var i = 0; i < leavetypeItems.length; i++) {
					optionsleavetype += '<option value="' + leavetypeIdItems[i] + '">'
							+ leavetypeItems[i] + '</option>';
						
				}
				$("select#cmbleavetype").html(optionsleavetype);
				if ($('#hidcmbleavetype').val() != null) {
					$('#cmbleavetype').val($('#hidcmbleavetype').val());
				}
			} else {
			}
		}
		x.open("GET", "getLeaveType.jsp", true);
		x.send();
	}
  
    function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
      	employeeSearchContent("employeeDetailsSearch.jsp");
       } else{}
      }
  
	 function funReadOnly(){
			$('#frmLeaveRequest input').attr('readonly', true );
			$('#frmLeaveRequest select').attr('disabled', true);
			$('#leaveRequestDate').jqxDateTimeInput({disabled: true});
			$('#fromDate').jqxDateTimeInput({disabled: true});
			$('#toDate').jqxDateTimeInput({disabled: true});
			$('#halfDayDate').jqxDateTimeInput({disabled: true});
			$('#chckhalfday').attr('disabled', true);
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmLeaveRequest input').attr('readonly', false );
			$('#frmLeaveRequest select').attr('disabled', false);
			$('#leaveRequestDate').jqxDateTimeInput({disabled: false});
			$('#fromDate').jqxDateTimeInput({disabled: false});
			$('#toDate').jqxDateTimeInput({disabled: false});
			$('#chckhalfday').attr('disabled', false);
			$('#docno').attr('readonly', true);
			$('#txtemployeeid').attr('readonly', true);
			$('#txtemployeename').attr('readonly', true);
			$('#txtnoofdays').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
				$('#leaveRequestDate').val(new Date());
				$('#fromDate').val(new Date());
				$('#toDate').val(new Date());
				$('#halfDayDate').val(new Date());
				document.getElementById("chckhalfday").checked=false;
			    document.getElementById("hidchckhalfday").value = 0; 
			    $('#txtnoofdays').val('1.0');
			}
			
			if ($("#mode").val() == "E") {
				if(document.getElementById("hidchckhalfday").value==1){
					$('#halfDayDate').jqxDateTimeInput({disabled: false});
				}
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('lrqMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#leaveRequestDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	    $(function(){
	        $('#frmLeaveRequest').validate({
	                rules: {
	                cmbleavetype:"required",
	                txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                 cmbleavetype:" *",
	                 txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
		  
		  /* Validation */
		  
		    empid=document.getElementById("txtemployeedocno").value;
		    if(empid==""){
				 document.getElementById("errormsg").innerText="Employee is Mandatory.";
				 return 0;
			}
			 
		    if(document.getElementById("hidchckhalfday").value==1){
		    	
	        	var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
				var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
				var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
				 
				leavestartday = leavestartday.setHours(0,0,0,0);
				leaveendday = leaveendday.setHours(0,0,0,0);
				halfday = halfday.setHours(0,0,0,0);
			       
			   if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
		  	   }
			 
			   if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			   }
			 
			   if(!(halfday==leavestartday || halfday==leaveendday)){
				 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
				 return 0;
			  }
		  }
		    
		  noofdays=document.getElementById("txtnoofdays").value;
	      if(noofdays=="" || noofdays=="0"){
			 document.getElementById("errormsg").innerText="Invalid Request !!!";
			 return 0;
		  }
	    	 
		  document.getElementById("errormsg").innerText="";
	    		
	    /* Validation Ends*/

	      return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidleaveRequestDate').val()){
				 $("#leaveRequestDate").jqxDateTimeInput('val', $('#hidleaveRequestDate').val());
			  }
		  
		  if($('#hidfromDate').val()){
				 $("#fromDate").jqxDateTimeInput('val', $('#hidfromDate').val());
			  }
		  
		  if($('#hidtoDate').val()){
				 $("#toDate").jqxDateTimeInput('val', $('#hidtoDate').val());
			  }
		  
		  if($('#hidhalfDayDate').val()){
				 $("#halfDayDate").jqxDateTimeInput('val', $('#hidhalfDayDate').val());
			  }

		  if(document.getElementById("hidchckhalfday").value==1){
	 			 document.getElementById("chckhalfday").checked = true;
	 		 }
	 		 else if(document.getElementById("hidchckhalfday").value==0){
	 			document.getElementById("chckhalfday").checked = false;
	 		 }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
	         
		}
	   
	  function funPrintBtn() {
				
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 // alert(url);
			    var reurl=url.split("saveLeaveRequests"); 
			     $("#docno").prop("disabled", false);
				 var dtype=$('#formdetailcode').val();
				   //alert(dtype);
				var win= window.open(reurl[0]+"printLeaveRequests?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
				win.focus();
			
			   }
			
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function funHalfDayCheck() {
		  if(document.getElementById("hidchckhalfday").value==1){
		    var leavestartday=  new Date($('#fromDate').jqxDateTimeInput('getDate'));
			var leaveendday=  new Date($('#toDate').jqxDateTimeInput('getDate'));
			var halfday=  new Date($('#halfDayDate').jqxDateTimeInput('getDate'));
			 
			 leavestartday = leavestartday.setHours(0,0,0,0);
			 leaveendday = leaveendday.setHours(0,0,0,0);
			 halfday = halfday.setHours(0,0,0,0);
			 
			 if(leavestartday==null){
				 document.getElementById("errormsg").innerText="From Date is Mandatory.";
				 return 0;
			 }
			 
			 if(leaveendday==null){
				 document.getElementById("errormsg").innerText="To Date is Mandatory.";
				 return 0;
			 }
			 
			 if(!(halfday==leavestartday || halfday==leaveendday)){
				 document.getElementById("errormsg").innerText="Half Day Date Should be From Date or To Date.";
				 return 0;
			 }
			 
			 document.getElementById("errormsg").innerText="";
		  }
	  }
	  
</script>
<style>

* {
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 0;
    /* 2. Critical: Use 100% height and hide horizontal overflow at the source */
    height: 100vh; 
    width: 100%;
    overflow-x: hidden; 
    display: flex;
    flex-direction: column;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    width: 100vw;
    max-width: 100vw;
    margin: 0;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    display: flex;
    flex-direction: column;
    box-sizing: border-box;
    position: relative;
    /* Forces the white background to stretch and cover the bottom of the screen */
    flex: 1; 
}

#formdet {
    text-align: left !important;
    display: block;
    font-size: 22px;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 8px;
    padding-left: 5px;
}
input[type="text"], select, textarea {
    height: 30px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 12px;
    display: block;
    line-height: 30px;
}

.receipt-header {
    display: block;
    margin-bottom: 8px;
    padding: 0 5px;
}

.receipt-header table {
    width: 100%;
    table-layout: fixed;
}

.receipt-header td {
    padding: 2px 4px;
    vertical-align: middle;
}

.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 10px;
    width: 100%;
    box-sizing: border-box;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 700;
    margin: 0 0 15px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
    line-height: 1.2;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: 120px 1fr 120px 1fr 120px 1fr;
    align-items: center;
    gap: 12px 15px;
}

.jqx-datetimeinput {
    height: 30px !important;
    box-sizing: border-box;
    width: 130px !important;
}

#docno, .header-docno {
    width: 150px !important;
}

input[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
}

.spacer {
    flex-grow: 1;
}
</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background" >
<form id="frmLeaveRequest" action="saveLeaveRequests" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div id="mainBG">
   

    <div class="receipt-header">
        <table width="100%">
            <tr>
                <td width="80px" align="right"><label>Date</label></td>
                <td width="150px">
                    <div id="leaveRequestDate" name="leaveRequestDate" value='<s:property value="leaveRequestDate"/>'></div>
                    <input type="hidden" id="hidleaveRequestDate" name="hidleaveRequestDate" value='<s:property value="hidleaveRequestDate"/>'/>
                </td>
                <td></td>
                <td width="100px" align="right"><label>Doc No.</label></td>
                <td width="150px" align="right">
                    <input type="text" id="docno" name="txtleaverequestdocno" class="header-docno" value='<s:property value="txtleaverequestdocno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Employee Information</h2>
        <div class="agmt-info-grid">
            <label>Designation</label>
            <select id="cmbempdesignation" name="cmbempdesignation" value='<s:property value="cmbempdesignation"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/>

            <label>Department</label>
            <select id="cmbempdepartment" name="cmbempdepartment" value='<s:property value="cmbempdepartment"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>

            <label>Payroll Cat.</label>
            <select id="cmbpayrollcategory" name="cmbpayrollcategory" value='<s:property value="cmbpayrollcategory"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/>

            <label>Employee ID</label>
            <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="F3 to Search" value='<s:property value="txtemployeeid"/>' onkeydown="getEmployee(event);">

            <label>Name</label>
            <div style="grid-column: span 3;">
                <input type="text" id="txtemployeename" name="txtemployeename" readonly tabindex="-1" value='<s:property value="txtemployeename"/>'>
                <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
            </div>
        </div>
    </div>

    <div class="section-block">
        <h2>Leave Details</h2>
        <div class="agmt-info-grid">
            <label>From Date</label>
            <div id="fromDate" name="fromDate" onchange="funNoofDaysLeave();" value='<s:property value="fromDate"/>'></div>
            <input type="hidden" id="hidfromDate" name="hidfromDate" value='<s:property value="hidfromDate"/>'/>

            <label>To Date</label>
            <div id="toDate" name="toDate" onchange="funNoofDaysLeave();" value='<s:property value="toDate"/>'></div>
            <input type="hidden" id="hidtoDate" name="hidtoDate" value='<s:property value="hidtoDate"/>'/>

            <label>No. of Days</label>
            <input type="text" id="txtnoofdays" name="txtnoofdays" readonly tabindex="-1" value='<s:property value="txtnoofdays"/>'>

            <label>Half Day</label>
            <div style="display: flex; align-items: center; gap: 10px;">
                <input type="checkbox" id="chckhalfday" name="chckhalfday" onchange="halfdaycheck();funNoofDaysLeave();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                <div id="halfDayDate" name="halfDayDate" style="width:150px;" value='<s:property value="halfDayDate"/>'></div>
                <input type="hidden" id="hidhalfDayDate" name="hidhalfDayDate" value='<s:property value="hidhalfDayDate"/>'/>
                <input type="hidden" id="hidchckhalfday" name="hidchckhalfday" value='<s:property value="hidchckhalfday"/>'/>
            </div>

            <label>Leave Type</label>
            <select id="cmbleavetype" name="cmbleavetype" value='<s:property value="cmbleavetype"/>'>
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbleavetype" name="hidcmbleavetype" value='<s:property value="hidcmbleavetype"/>'/>

            <label>Description</label>
            <div style="grid-column: span 3;">
                <input type="text" id="txtdescription" name="txtdescription" placeholder="Description" value='<s:property value="txtdescription"/>'>
            </div>
        </div>
    </div>

    <div class="spacer"></div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
</div>
</form>
<div id="employeeDetailsWindow">
   <div></div>
</div>

</div>
</body>
</html>
