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
    document.getElementById("formdet").innerText="Currency(CUR)";
    document.getElementById("formdetail").value="Currency";
    document.getElementById("formdetailcode").value="CUR";
    window.parent.formCode.value="CUR";
    window.parent.formName.value="Currency";
});

function funSearchLoad(){
    changeContent('currencySearch.jsp', $('#window')); 
}

function funReset(){
    $('#frmCurrency')[0].reset(); 
}

function funReadOnly(){
    $('#frmCurrency input').attr('readonly', true );
}

function funRemoveReadOnly(){
    $('#frmCurrency input').attr('readonly', false );
    $('#docno').attr('readonly', true);
}

function funFocus(){
    document.getElementById("txtcode").focus();
}

$(function(){
    $('#frmCurrency').validate({
        rules: {
            txtcode: { required:true, maxlength:3 },
            txtcodename:{ required:true, maxlength:15 },
            txtcountry:"required",
            txtfraction:"required",
            txtdecimal:{ required:true, number:true }
        },
        messages: {
            txtcode:{ required:" *", maxlength:"Max 3 chars" },
            txtcodename:{ required:" *", maxlength:"Max 15 chars" },
            txtcountry:" *",
            txtfraction:" *",
            txtdecimal:{ required:" *", number:"Invalid Decimal" }
        }
    });
});

function funNotify(){
    return 1;
}

function setValues(){   
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function checkCurrency(value){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items=x.responseText;
            if(items.trim()!='undefine'){
                document.getElementById("txtcode").focus();
                document.getElementById("errormsg").innerText="Currency Code Already Exists";
            }
            else{
                document.getElementById("errormsg").innerText="";
            }
        }
    }
    x.open("GET","checkCurrency.jsp?code="+value+"&doc="+document.getElementById("docno").value,true);
    x.send();
}
</script>
</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCurrency" action="saveActionCurrency" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />
  
    <div class="hidden-scrollbar">

        <div class="middle-panel" style="max-width: 800px;">
            <span class="middle-panel-title">Currency Details</span>
            
            <div class="field-row">
                <label class="lbl-right">Doc No</label>
                <input type="text" id="docno" name="docno" style="width:120px; flex: none;" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1"/>
            </div>

            <div class="field-row">
                <label class="lbl-right">Code</label>
                <div style="display: flex; flex: 1; gap: 10px; max-width: 400px;">
                    <input type="text" id="txtcode" name="txtcode" value='<s:property value="txtcode"/>' onblur="checkCurrency(this.value);" style="width: 80px; flex: none;"/>
                    <input type="text" id="txtcodename" name="txtcodename" value='<s:property value="txtcodename"/>' style="flex: 1;" />
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right">Country</label>
                <input type="text" id="txtcountry" name="txtcountry" value='<s:property value="txtcountry"/>' style="max-width: 250px;"/>
            </div>

            <div class="field-row">
                <label class="lbl-right">Fraction</label>
                <input type="text" id="txtfraction" name="txtfraction" value='<s:property value="txtfraction"/>' style="max-width: 250px;"/>
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right">Price Decimals</label>
                <input type="text" id="txtdecimal" name="txtdecimal" value='<s:property value="txtdecimal"/>' style="max-width: 150px;"/>
            </div>

        </div>

        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode"/>

    </div>
</form>
</div>
</body>
</html>