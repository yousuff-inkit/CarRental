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
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 10px 0;
    box-sizing: border-box;
    overflow-x: hidden;
    min-height: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    /* Fixed to full screen width as per image_22a61c.png */
    width: 100vw;
    max-width: 100vw;
    margin: 0;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    display: block;
    box-sizing: border-box;
    position: relative;
}

#formdet {
    text-align: left !important;
    display: block;
    font-size: 22px;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 8px; /* Reduced space between title and header */
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

input[type="text"]:focus, select:focus, textarea:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 8px;
}

.receipt-header {
    display: block;
    margin-bottom: 8px; /* Tight spacing between sections */
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
    padding: 15px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 8px; /* Reduced space between cards */
    width: 100%;
    box-sizing: border-box;
}

.section-block h2 {
    font-size: 1rem;
    font-weight: 600;
    margin: 0 0 12px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: 100px 1fr 100px 1fr 100px 1fr;
    align-items: center;
    gap: 8px 12px;
}

/* Force specific widths for header inputs as per request */
.jqx-datetimeinput {
    height: 30px !important;
    box-sizing: border-box;
    width: 150px !important; 
}

#docno, .header-docno {
    width: 150px !important;
}

.grid-container {
    margin-top: 10px;
    background: #fff;
    border-radius: 8px;
    border: 1px solid #e4e7ec;
    overflow: hidden;
}

input[readonly], textarea[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
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

    <div id="mainBG">
    <div id="formdet">Group Master</div>

    <div class="receipt-header">
        <table width="100%">
            <tr>
                <td width="60px" align="right"><label>Date</label></td>
                <td width="150px">
                    <div id="fgmdate" name="fgmdate" value='<s:property value="fgmdate"/>'></div>
                </td>
                <td></td>
                <td width="80px" align="right"><label>Doc No.</label></td>
                <td width="150px" align="right">
                    <input type="text" id="docno" name="docno" class="header-docno" value='<s:property value="docno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Group Details</h2>
        <div class="agmt-info-grid">
            <label>Code</label>
            <input type="text" name="fgmcode" id="fgmcode" placeholder="Group Code" value='<s:property value="fgmcode"/>'>
            
            <label>Name</label>
            <div style="grid-column: span 3;">
                <input type="text" name="fgmname" id="fgmname" placeholder="Group Name" value='<s:property value="fgmname"/>'>
            </div>
        </div>
    </div>

    <div class="section-block">
        <h2>Group Grid Information</h2>
        <div class="grid-container">
            <div id="grpgrid">
                <jsp:include page="groupGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>

    <input type="hidden" name="hidfgmdate" id="hidfgmdate" value='<s:property value="hidfgmdate"/>'/>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
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