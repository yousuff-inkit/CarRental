<% String contextPath=request.getContextPath();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>

    <style>
    .container {
    height: 100%;
}

/* ---------- SCROLL ---------- */
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* ---------- BODY ---------- */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
}

/* ---------- MAIN CARD ---------- */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 10px;
    max-width: 100%;
    margin: 0 auto;
}

/* ---------- HEADER ---------- */
.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0 24px;
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

/* ---------- SECTION BLOCKS ---------- */
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
    margin: 0 0 16px;
    color: #253858;
}

/* ---------- TABLE SECTIONS ---------- */
.table-section {
    margin-bottom: 18px;
    padding: 16px;
    border-radius: 8px;
    background: #f6f8fa;
}

/* 🔵 BLUE HEADING LINE */
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
    margin: 0 0 14px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* ---------- TABLE ---------- */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th,
.cr-table td {
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

/* ---------- INPUTS ---------- */
input[type="text"],
select {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

/* ---------- TEXT RULES ---------- */
label,
td,
th {
    font-weight: 700 !important;
    white-space: nowrap !important;
}
    
    </style>
 
<script type="text/javascript">

$(document).ready(function () {     
	 $("#fgmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 //$('#jqxgroupgrid').jqxGrid({ disabled: true}); 
	 
	 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#accountWindow').jqxWindow('close');
		
      		 $('#txtaccno').dblclick(function(){
		  	    $('#accountWindow').jqxWindow('open');
			    var url=document.URL;
			    var reurl=url.split("com/");
				  accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp');
      		 }); 
      		document.getElementById("formdet").innerText="Group Master(FGM)";
    		document.getElementById("formdetail").value="Group Master";
    		document.getElementById("formdetailcode").value="FGM";
    		window.parent.formCode.value="FGM";
    		window.parent.formName.value="Group Master";
    		
  });
	
	function funFocus(){
		document.getElementById("fgmcode").focus();
	}
	
	function funReadOnly() {
		$('#frmgrp input').attr('readonly', true);
		$('#fgmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmgrp input').attr('readonly', false);
		$('#fgmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#hidfgmdate').val()){
			$("#fgmdate").jqxDateTimeInput('val', $('#hidfgmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmgrp').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("fgmname").value==''){
			document.getElementById("errormsg").innerText="Group Name is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
 
</script>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmgrp" action="saveActiongrp" method="post" autocomplete="off">
    <jsp:include page="../../../header.jsp" />
    <br/>

    <div class="hidden-scrollbar receipt-header">

        <div class="table-section">
            <h3>Group Details</h3>

            <table class="cr-table" width="100%">
                <tr>
                    <td width="5%" align="right">Date</td>
                    <td width="16%">
                        <div id="fgmdate" name="fgmdate"
                             value='<s:property value="fgmdate"/>'></div>
                    </td>
                    <td colspan="3" align="right">Doc No.</td>
                    <td width="30%">
                        <input type="text" id="docno" name="docno"
                               value='<s:property value="docno"/>'
                               readonly tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td align="right">Code</td>
                    <td>
                        <input type="text" name="fgmcode" id="fgmcode"
                               placeholder="Group Code"
                               value='<s:property value="fgmcode"/>'>
                    </td>

                    <td width="5%" align="right">Name</td>
                    <td>
                        <input type="text" name="fgmname" id="fgmname"
                               style="width:80%;"
                               placeholder="Group Name"
                               value='<s:property value="fgmname"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="cr-table" id="grpgrid">
            <jsp:include page="groupGrid.jsp"></jsp:include>
        </div>

        <input type="hidden" name="hidfgmdate" id="hidfgmdate"
               value='<s:property value="hidfgmdate"/>'/>
        <input type="hidden" name="mode" id="mode"
               value='<s:property value="mode"/>'/>
        <input type="hidden" name="deleted" id="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>

    </div>
</form>
</div>

<br/>

<div id="jqxSalesmanSearch1"></div>

<div id="accountWindow">
    <div></div>
    <div></div>
</div>

</body>

</html>