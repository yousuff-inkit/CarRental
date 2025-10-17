<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#employeeDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
    	  /* Searching Window */
    	 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#accountDetailsWindow').jqxWindow('close');
 		 
 		 $('#txtempaccount').dblclick(function(){
			  accountSearchContent("accountsDetailsSearch.jsp");
		  });
 		
      }); 
      
      function accountSearchContent(url) {
		 	$('#accountDetailsWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#accountDetailsWindow').jqxWindow('setContent', data);
			$('#accountDetailsWindow').jqxWindow('bringToFront');
		}); 
		}
      
      function getEmpAccount(event){
          var x= event.keyCode;
          if(x==114){
        	  accountSearchContent("accountsDetailsSearch.jsp");
          }
          else{}
          }
      
	  function getEmployeeCodeAlreadyExists(empcode,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				
	  				if(parseInt(items.trim())==1){
	  					document.getElementById("errormsg").innerText="Employee ID Already Exists.";
	  					 return 0;
	  				 } else { 
	  					document.getElementById("errormsg").innerText="";
	  				 }
	  		}
		}
		x.open("GET", "getEmployeeCodeAlreadyExists.jsp?empcode="+empcode+"&docno="+docno+"&mode="+mode, true);
		x.send();
     }
  
      function getEmployeeAlreadyExists(employeename,docno,mode){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();

					if(parseInt(items)==1){
	  					 document.getElementById("errormsg").innerText="Employee Already Exists.";
	  					 return 0;
	  				 }else{
	  					$("#frmEmpMaster").submit();
	  				 }
	  			   
	  		}
		}
		x.open("GET", "getEmployeeAlreadyExists.jsp?employeename="+employeename+"&docno="+docno+"&mode="+mode, true);
		x.send();
   }
      
      $(function(){
	        $('#frmEmpMaster').validate({
	                rules: {
	                txtemployeename:"required"
	                 
	                 },
	                 messages: {
	                 txtemployeename:" *"
	                 }
	        });});
 	 
	 function funReadOnly(){
			$('#frmEmpMaster input').attr('readonly', true );
			$('#frmEmpMaster select').attr('disabled', true);
			$('#employeeDate').jqxDateTimeInput({disabled: true});
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmEmpMaster input').attr('readonly', false );
			$('#frmEmpMaster select').attr('disabled', false);
			$('#employeeDate').jqxDateTimeInput({disabled: false});
			$('#txtempaccount').attr('readonly', true );
			$('#docno').attr('readonly', true);
			
			if ($("#mode").val() == "A") {
					 $('#employeeDate').val(new Date());
					 document.getElementById("lblemployeestatus").innerText="";
			}
			
	 }
	 function funNotify(){	
		 /* Validation */
		 
		 
		 
		// document.getElementById("errormsg").innerText="";		 
		 /* Validation Ends*/
		
		 employeename=document.getElementById("txtemployeename").value;
		 docno=document.getElementById("docno").value;
		 mode=document.getElementById("mode").value;
		 getEmployeeAlreadyExists(employeename,docno,mode);
	    	
		} 
	 
	 function funSearchLoad(){
			changeContent('empMainSearch.jsp'); 
		 }
	 
	 function funFocus(){
	    	$('#employeeDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 function setValues(){
		 
			 if($('#hidemployeeDate').val()){
				 $("#employeeDate").jqxDateTimeInput('val', $('#hidemployeeDate').val());
			  }
			 
			 if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
			 funSetlabel();
			 
			 if(document.getElementById("lblemployeestatus").innerText.trim()=="TERMINATED"){
				    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
			  } else {
				    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
			  }
             
		}
	 
	 function funChkButton() {
			/* funReset(); */
		}
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}
#mainBG {
    background: #fff;
    border-radius: 16px;
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
    padding-inline: 1.04em;
    padding-block: 1.04em;
    border-radius: 8px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEmpMaster" action="saveEmpMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="background: #E8DEF7; width: 100%;">
<table class="cr-table" width="99%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="20%"><div id="employeeDate" name="employeeDate" value='<s:property value="employeeDate"/>'></div>
    <input type="hidden" id="hidemployeeDate" name="hidemployeeDate" value='<s:property value="hidemployeeDate"/>'/></td>
    <td width="19%" align="right">Employee ID</td>
    <td width="17%"><input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Employee ID" style="width:70%;" onblur="getEmployeeCodeAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtemployeeid"/>'/></td>
    <td width="13%" align="center"><i><b><label id="lblemployeestatus"  name="lblemployeestatus"   style="font-size: 13px;font-family: Tahoma; color:#6000FC;text-align: right;"><s:property value="lblemployeestatus"/></label></b></i></td>
    <td width="7%" align="right">Doc No </td>
    <td width="19%"><input type="text" id="docno" name="txtempmasterdocno" style="width:70%;" tabindex="-1" value='<s:property value="txtempmasterdocno"/>'/></td>
  </tr>
</table>
<table class="cr-table" width="99%">
  <tr>
    <td width="5%" align="right">Account </td>
    <td width="15%"><input type="text" id="txtempaccount" name="txtempaccount" style="width:78%;" placeholder="Press F3 to Search" value='<s:property value="txtempaccount"/>' onkeydown="getEmpAccount(event);"/>
    <input type="hidden" id="txtempaccdocno" name="txtempaccdocno" value='<s:property value="txtempaccdocno"/>'/>
    <td width="6%" align="right">Name</td>
    <td width="74%"><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:40%;" value='<s:property value="txtemployeename"/>'/></td>
  </tr>
</table>
</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
</div>
</form>
<div id="accountDetailsWindow">
   <div></div>
</div>

</div>
</body>
</html>
