<%@page import="com.controlcentre.masters.vehiclemaster.leasecdw.*" %>
<%ClsLeaseCDWDAO cdwdao=new ClsLeaseCDWDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%String contextPath=request.getContextPath();%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size: 1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 30px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
}

.pdc-cheque-row {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
    flex-wrap: nowrap;
}

.pdc-cheque-row input[type="checkbox"] {
    width: auto;
    margin: 0 4px 0 0;
}

.pdc-cheque-row label {
    text-align: right;
    padding-right: 8px;
    white-space: nowrap;
    margin: 0;
    font-weight: 600;
}

.myButton {
    background-color: #007BFF;
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
    transition: background-color 0.3s ease, transform 0.1s ease, box-shadow 0.3s ease;
}

input:-webkit-autofill {
    -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
    -webkit-text-fill-color: #253858 !important;
}

.jqx-datetimeinput {
    height: 34px !important;
    box-sizing: border-box;
}
</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    document.getElementById("formdet").innerText="Lease CDW(LCDW)";
		document.getElementById("formdetail").value="Lease";
		document.getElementById("formdetailcode").value="LCDW";
		window.parent.formCode.value="LCDW";
		window.parent.formName.value="Lease CDW";
		
        });
	function funSearchLoad(){
		changeContent('leaseCDWSearch.jsp', $('#window')); 
	 }
	/* function funReset() {
		$(this).closest('form').find("input[type=text]").val("");
		//$('#frmBrand').trigger("reset");
		//document.getElementById("frmBrand").reset();
		//document.getElementById("docno").value="";
		//document.getElementById("brand").value="";
	} */
	
	
	function funReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', true);
		$('#chkreplace').attr('disabled', true);
		$('#chkexscdw').attr('disabled', true);
		$('#date').jqxDateTimeInput({ disabled: true});
	}
	
	
	function funRemoveReadOnly() {
		$('#frmLeaseCDW input').attr('readonly', false);
		$('#date').jqxDateTimeInput({ disabled: false});
		$('#chkreplace').attr('disabled', false);
		$('#chkexscdw').attr('disabled', false);
		$('#docno').attr('readonly', true);
		SetReplaceValue();
		 SetExcseecdwValue()
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
		  }
		 if(document.getElementById("hidchkreplace").value=="1"){
			 document.getElementById("chkreplace").checked=true;
		 }
		 else{
			 document.getElementById("chkreplace").checked=false;
		 }
		 
		 
		  if(document.getElementById("hidchkexscdw").value=="1"){
			 document.getElementById("chkexscdw").checked=true;
		 }
		 else{
			 document.getElementById("chkexscdw").checked=false;
		 } 

		$('#leasecdwdiv').load('leaseCDWGrid.jsp');
	}
	
	 $(function(){
	        $('#frmLeaseCDW').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:100
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 100 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		 
	  }
	  function SetReplaceValue(){
		  if(document.getElementById("chkreplace").checked==true){
			  document.getElementById("hidchkreplace").value="1";
			 
		  }
		  else{
			  document.getElementById("hidchkreplace").value="0";
		  }
		  
		 
		
	  }
	  function SetExcseecdwValue(){
		
		  if(document.getElementById("chkexscdw").checked==true){
			  document.getElementById("hidchkexscdw").value="1";
			   
		  }
		  else{
			  document.getElementById("hidchkexscdw").value="0";
		  }
		  }
</script>  
 
</head>
<body onLoad="setValues();"  class="hidden-scrollbar">
<form id="frmLeaseCDW" action="saveLeaseCDW" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<div id="mainBG">
    <div class='receipt-header'>
        <table width="100%">
            <tr>
                <td width="5%" align="right"><label>Date</label></td>
                <td width="15%">
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </td>
                <td width="40%"></td>
                <td width="10%" align="right"><label>Doc No</label></td>
                <td width="30%">
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Lease CDW Details</h2>
        
        <div class="form-group pdc-cheque-row">
            <label style="width:120px; text-align:right;">Name</label>
            <input type="text" name="name" id="name" value='<s:property value="name"/>' style="width:30%;">
            
            <input type="checkbox" name="chkexscdw" id="chkexscdw" class="custom-checkbox" onchange="SetExcseecdwValue();">
            <label for="chkexscdw">Excess CDW</label>
            
            <input type="checkbox" name="chkreplace" id="chkreplace" class="custom-checkbox" onchange="SetReplaceValue();">
            <label for="chkreplace">Replacement</label>
        </div>

        <div class="form-group dual-input">
            <label>Description</label>
            <input type="text" name="description" id="description" value='<s:property value="description"/>'>
            
            <label>Remarks</label>
            <input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>'>
        </div>
    </div>
</div>
    <br>
    <table width="100%">
  <tr>
    <td><div id="leasecdwdiv"><jsp:include page="leaseCDWGrid.jsp"></jsp:include></div></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
<input type="hidden" name="hidchkreplace" id="hidchkreplace" value='<s:property value="hidchkreplace"/>'/>
<input type="hidden" name="hidchkexscdw" id="hidchkexscdw" value='<s:property value="hidchkexscdw"/>'/>

	</form>
</body>
</html>