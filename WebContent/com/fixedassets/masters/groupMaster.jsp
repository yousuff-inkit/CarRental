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
/* Premium Blue Theme - Group Master - BIGGER LABELS */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 20px;
    min-height: 100vh;
}

#mainBG {
    background: #ffffff;
    border-radius: 20px;
    box-shadow: 0 12px 40px rgba(0,0,0,0.1);
    padding: 25px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header h3 {
    color: #2c3e50;
    font-size: 28px;
    font-weight: 700;
    margin: 0 0 25px 0;
    text-align: center;
    background: linear-gradient(135deg, #4a90e2, #357abd);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
    margin-bottom: 25px;
}

.cr-table td {
    padding: 14px 12px;
    vertical-align: middle;
    border-bottom: 1px solid #e8ecf4;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* BIGGER LABELS - 18px font-size + bold */
.cr-table td[align="right"],
.cr-table td[align="left"] strong {
    font-size: 18px !important;
    font-weight: 700 !important;
    color: #2c3e50 !important;
    line-height: 1.2 !important;
    letter-spacing: 0.5px !important;
}

/* PREMIUM INPUT STYLING */
#frmgrp input[type="text"] {
    width: 250px !important;
    height: 48px !important;
    border: 2px solid #e1e5e9;
    border-radius: 10px;
    padding: 12px 16px;
    font-size: 16px;
    background: #ffffff;
    transition: all 0.3s ease;
    box-shadow: 0 3px 8px rgba(0,0,0,0.08);
    box-sizing: border-box;
}

#frmgrp input[type="text"]:hover {
    border-color: #4a90e2;
    box-shadow: 0 6px 16px rgba(74,144,226,0.2);
    transform: translateY(-1px);
}

#frmgrp input[type="text"]:focus {
    outline: none;
    border-color: #4a90e2;
    box-shadow: 0 0 0 4px rgba(74,144,226,0.15);
    background: #fafbfc;
}

/* PERFECT DOC NO POSITIONING */
#docno {
    width: 210px !important;
    height: 48px !important;
    padding: 12px 14px !important;
    margin: 0 !important;
    border: 2px solid #e1e5e9 !important;
    border-radius: 10px !important;
    background: #f8f9fa !important;
    font-weight: 600 !important;
    font-size: 16px !important;
    color: #495057 !important;
    box-shadow: 0 2px 8px rgba(0,0,0,0.08) !important;
}

/* Group Name field bigger */
#fgmname {
    width: 400px !important;
    height: 52px !important;
    font-size: 16px;
}

/* jQWidgets DateTimeInput */
#fgmdate {
    margin-right: 8px !important;
}

/* Grid container */
#grpgrid {
    background: white;
    border-radius: 16px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.1);
    padding: 20px;
    margin-top: 20px;
}

@media (max-width: 768px) {
    .cr-table td { padding: 12px 8px; }
    .cr-table td[align="right"],
    .cr-table td[align="left"] strong { font-size: 16px !important; }
    #frmgrp input[type="text"] { width: 100% !important; }
}
</style>

<script type="text/javascript">
$(document).ready(function () {     
    $("#fgmdate").jqxDateTimeInput({width : '130px',height : '20px',formatString : "dd.MM.yyyy"});
    
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
    });
});

function funNotify(){
    if(document.getElementById("fgmname").value==''){
        document.getElementById("errormsg").innerText="Group Name is Mandatory.";
        return false;
    }
    document.getElementById("errormsg").innerText="";
    return 1;
}

function funChkButton() {
}

function funSearchLoad(){
    changeContent('salesmanSearch.jsp'); 
}
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmgrp" action="saveActiongrp" method="post" autocomplete="off" >
    <jsp:include page="../../../header.jsp" />
    <br/>
    <div class="hidden-scrollbar receipt-header">
        <h3>Group Details</h3>
        
        <!-- PERFECT DOC NO TABLE STRUCTURE -->
        <table class="cr-table" width="100%">
          <tr>
            <td width="8%" align="right"><strong>Date</strong></td>
            <td width="14%"><div id="fgmdate" name="fgmdate" value='<s:property value="fgmdate"/>'></div></td>
            <td width="9%" align="left" style="padding-left: 12px !important; padding-right: 6px !important;"><strong>Doc No.</strong></td>
            <td width="22%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
            <td width="45%">&nbsp;</td>
          </tr>
          <tr>
            <td align="right"><strong>Code</strong></td>
            <td><input type="text" name="fgmcode" id="fgmcode" placeholder="Group Code" value='<s:property value="fgmcode"/>'></td>
            <td align="right"><strong>Name</strong></td>
            <td><input type="text" name="fgmname" id="fgmname" style="width:80%;" placeholder="Group Name" value='<s:property value="fgmname"/>'></td>
          </tr>
        </table>

        <div class="cr-table" id="grpgrid"><jsp:include page="groupGrid.jsp"></jsp:include></div>

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
