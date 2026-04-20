<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   1. YOUR ORIGINAL PAGE & WRAPPER STYLES (UNTOUCHED)
========================================================= */
form label.error {
    color:red;
    font-weight:bold;
}

.hidden-scrollbar {
    overflow: visible;
    height: auto;
}

html, body {
    background: #ffffff;                
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    font-size: 12px;                     
    color: #333;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

.windowCont,
#mainBG.homeContent {
    background: #ffffff !important;
}

#mainBG {
    background: #ffffff;
    border-radius: 8px;
    padding: 5px 18px 16px 18px; 
    max-width: 1400px;
    margin: 0 auto;
    box-shadow: none;                    
}

/* =========================================================
   2. CASH RECEIPTS UI ELEMENTS (TIGHTENED SPACING)
========================================================= */
.middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 15px 15px 15px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 6px; 
    margin-bottom: 25px;
    margin-top: 15px; 
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

.middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 15px; 
    background: #ffffff; 
    padding: 0 10px; 
    color: #0056b3;
    font-weight: 700; 
    font-size: 15px; 
    border-left: 4px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Flexbox Layout for Rows & Columns */
.field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    width: 100%;
    flex-wrap: wrap;
    gap: 15px;
}

.lbl-right { 
    color: #1e293b;
    font-size: 13px; 
    font-weight: 600; 
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    white-space: nowrap; 
    text-align: right;
    min-width: 100px; 
}

/* Scoped 26px Inputs */
input[type="text"],
input[type="email"],
select { 
    height: 26px !important; 
    border: 1px solid #d1d5db; 
    border-radius: 4px; 
    padding: 4px 8px;
    font-size: 13px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

input[type="text"]:focus,
input[type="email"]:focus,
select:focus { 
    border-color: #3b82f6; 
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

input[readonly],
input:disabled,
select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}
</style>

<script type="text/javascript">
$(document).ready(function () {  
    document.getElementById("formdet").innerText="Location(LOC)";
    document.getElementById("formdetail").value="Location";
    document.getElementById("formdetailcode").value="LOC";
    window.parent.formCode.value="LOC";
    window.parent.formName.value="Location";
});

function funReadOnly(){
    $('#frmLocation input').attr('readonly', true );
    $('#frmLocation select').attr('disabled', true );
}

function funRemoveReadOnly(){
    $('#frmLocation input').attr('readonly', false );
    $('#frmLocation select').attr('disabled', false );
}

function funSearchLoad(){
    changeContent('locationSearch.jsp', $('#window')); 
}

function getBranch() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var branchidItems=items[1].split(",");
            var branchItems=items[0].split(",");
            var optionsbranch = '<option value="">--Select--</option>';
            for ( var i = 0; i < branchItems.length; i++) {
                optionsbranch += '<option value="' + branchidItems[i] + '">' + branchItems[i] + '</option>';
            }
            $("select#cmbbranchname").html(optionsbranch);
            $('#cmbbranchname').val($('#hidcmbbranchname').val()) ;
        }
    }
    x.open("GET","getBranch.jsp",true);
    x.send();   
}

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("cmbbranchname").focus();
}

$(function(){
    $('#frmLocation').validate({
        rules: {
            cmbbranchname: "required",
            txtloccode:"required",
            txtlocname:"required"
        },
        messages: {
            cmbbranchname: " *",
            txtloccode:" *",
            txtlocname:" *"
        }
    });
});

function funNotify(){
    return 1;
}

function checkLocCode(value){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
            if(items.trim()!='undefine'){
                document.getElementById("txtloccode").focus();
                document.getElementById("errormsg").innerText="Location ID Already Exists";
            }
            else{
                document.getElementById("txtlocname").focus();
                document.getElementById("errormsg").innerText="";
            }
        }
    }
    x.open("GET","checkLocCode.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
    x.send();
}
</script>
</head>
<body onload="getBranch();funReadOnly();setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLocation" action="saveActionLocation" autocomplete="off" >

    <jsp:include page="../../../../header.jsp" />
  
    <div class="hidden-scrollbar">

        <div class="middle-panel" style="max-width: 1000px;">
            <span class="middle-panel-title">Location Info</span>
            
            <div class="field-row">
                <label class="lbl-right">Branch</label>
                <select id="cmbbranchname" name="cmbbranchname" value='<s:property value="cmbbranchname"/>' style="flex: 1; max-width: 600px;">
                    <option></option>
                </select>
            </div>

            <div class="field-row">
                <label class="lbl-right">Location</label>
                <div style="display: flex; flex: 1; gap: 10px; max-width: 600px;">
                    <input type="text" id="txtloccode" name="txtloccode" value='<s:property value="txtloccode"/>' onblur="checkLocCode(this.value);" style="width: 100px; flex: none;">
                    <input type="text" id="txtlocname" name="txtlocname" value='<s:property value="txtlocname"/>' style="flex: 1;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Address</label>
                <input type="text" id="txtaddress" name="txtaddress" value='<s:property value="txtaddress"/>' style="flex: 1; max-width: 600px;"/>
            </div>

            <div class="field-row">
                <label class="lbl-right">P.B.No</label>
                <input type="text" id="txtpbno" name="txtpbno" value='<s:property value="txtpbno"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel1" name="txttel1" value='<s:property value="txttel1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Tel</label>
                    <input type="text" id="txttel2" name="txttel2" value='<s:property value="txttel2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax1" name="txtfax1" value='<s:property value="txtfax1"/>' style="flex: 1; margin-left: 15px;">
                </div>
                <div style="display: flex; align-items: center; flex: 1; max-width: 350px;">
                    <label class="lbl-right">Fax</label>
                    <input type="text" id="txtfax2" name="txtfax2" value='<s:property value="txtfax2"/>' style="flex: 1; margin-left: 15px;">
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Email</label>
                <input type="email" id="txtemail1" name="txtemail1" value='<s:property value="txtemail1"/>' style="flex: 1; max-width: 600px;">
            </div>

            <div class="field-row" style="margin-bottom: 0;">
                <label class="lbl-right">Website</label>
                <input type="text" id="txtwebsite" name="txtwebsite" value='<s:property value="txtwebsite"/>' style="flex: 1; max-width: 600px;">
            </div>

        </div>

        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="hidcmbbranchname" name="hidcmbbranchname" value='<s:property value="hidcmbbranchname"/>'>
        <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
        <input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <input type="hidden" id="mode" name="mode"/>

    </div>
</form>
</div>
</body>
</html>