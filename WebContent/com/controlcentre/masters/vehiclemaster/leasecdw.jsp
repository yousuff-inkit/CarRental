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
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */

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
    font-weight: 700;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

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

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ------------------------------
   FORM ROWS LAYOUT (FIXED)
------------------------------ */

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
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}
.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* Special handling for the "to-account-row" - all items in one line */
.to-account-row {
    display: grid;
    grid-template-columns: 120px 110px 120px 140px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.to-account-row label {
    text-align: right;
    padding-right: 8px;
}

.to-account-row #cmbtotype {
    width: 100%;
}

.to-account-row #txttoaccid {
    width: 100%;
}

.to-account-row #txttoaccname {
    width: 100%;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Hide scrollbars (but allow scrolling) */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
.pdc-cheque-row {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
    flex-wrap: nowrap;
}

/* Checkbox with PDC text - keep them together */
.pdc-cheque-row input[type="checkbox"] {
    width: auto;
    margin: 0 4px 0 0;
    flex-shrink: 0;
}

/* Hidden inputs should not take space */
.pdc-cheque-row input[type="hidden"] {
    display: none;
}

/* Labels styling */
.pdc-cheque-row label {
    text-align: right;
    padding-right: 8px;
    white-space: nowrap;
    margin: 0;
    flex-shrink: 0;
    font-weight: 600;
}

/* Cheque No input */
.pdc-cheque-row #txtchequeno {
    
    max-width: 200px;
    flex-shrink: 0;
}

/* Cheque Date */
.pdc-cheque-row #jqxChequeDate {
    width: 200px;
    flex-shrink: 0;
}
.pdc-cheque-row label:first-child {
    width: 120px;     /* or 100px, match other labels */
    text-align: right; /* move label text to left */
    padding-right: 8px;
    margin-right: -0.5%;
    flex-shrink: 0;
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
	<fieldset><legend>Lease CDW Details</legend>
	<div class="section-block">
		<div class="form-group dual-input">
		<label>Date</label>
			<div id="date" name="date" value='<s:property value="date"/>'></div>
			<label>Doc No</label>
					<input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1">
		</div><!-- pattern=".{1,3}" required="required" -->
		<div class="form-group pdc-cheque-row ">
			<label>Name</label>
			<input type="text" name="name" id="name"  value='<s:property value="name"/>' style="width:30%;">
			<input type="checkbox" name="chkexscdw" id="chkexscdw" class="custom-checkbox" onchange="SetExcseecdwValue();">
            <label for="chkexscdw">Excess CDW</label>
            
            <input type="checkbox" name="chkreplace" id="chkreplace" class="custom-checkbox" onchange="SetReplaceValue();">
            <label for="chkreplace">Replacement</label>
            </div>
			<div class="form-group dual-input">
				<label>Description</label>
                <input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:97%;">
            
		
			  <label>Remarks</label>
			  <input type="text" name="remarks" id="remarks" value='<s:property value="remarks"/>' style="width:97%;">
	  </div>
	</div>
	</fieldset>
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