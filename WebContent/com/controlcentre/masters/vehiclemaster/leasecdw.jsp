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
/* =========================================================
SCOPED UI: Compact Input Sizing (Plain Colors)
*Note: All rules strictly scoped to .modern-ui so header.jsp is safe*
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 15px;
    box-sizing: border-box; 
}

/* Master Input Heights - Set to 24px */ 
.modern-ui input[type="text"], 
.modern-ui select, 
.modern-ui textarea {
    height: 24px !important; 
    border: 1px solid #ccc; 
    border-radius: 3px;
    padding: 2px 6px; 
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
}

/* Checkbox Reset (Prevents them from stretching to 24px) */
.modern-ui input[type="checkbox"] {
    height: auto !important;
    width: auto !important;
    margin: 0 4px 0 0;
    cursor: pointer;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 220px !important; }
.modern-ui .input-xl { width: 350px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus, 
.modern-ui textarea:focus { 
    border-color: #007bff;
    outline: none;
}

.modern-ui input[readonly], 
.modern-ui textarea[readonly], 
.modern-ui select:disabled, 
.modern-ui input:disabled { 
    background-color: #f3f4f6;
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right; 
    color: #444; 
    font-size: 12px;
    font-weight: bold; 
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #e1e4e8; 
    padding: 20px 10px 10px 10px; 
    background: #fff;
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -10px;
    left: 10px; 
    background: #fff; 
    padding: 0 5px 0 6px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Validation Error override */
.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    margin-left: 5px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {    
    /* Upgraded height to 24px for Modern UI */
    $("#date").jqxDateTimeInput({ width: '125px', height: '24px' ,formatString : "dd.MM.yyyy" });
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "Arial, sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
    
    document.getElementById("formdet").innerText="Lease CDW(LCDW)";
    document.getElementById("formdetail").value="Lease";
    document.getElementById("formdetailcode").value="LCDW";
    window.parent.formCode.value="LCDW";
    window.parent.formName.value="Lease CDW";
});

function funSearchLoad(){
    changeContent('leaseCDWSearch.jsp', $('#window')); 
}

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
    SetExcseecdwValue();
}

function setValues() {
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    
    if(document.getElementById("hidchkreplace").value=="1"){
        document.getElementById("chkreplace").checked=true;
    } else {
        document.getElementById("chkreplace").checked=false;
    }
    
    if(document.getElementById("hidchkexscdw").value=="1"){
        document.getElementById("chkexscdw").checked=true;
    } else {
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
    });
});

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
    } else {
        document.getElementById("hidchkreplace").value="0";
    }
}

function SetExcseecdwValue(){
    if(document.getElementById("chkexscdw").checked==true){
        document.getElementById("hidchkexscdw").value="1";
    } else {
        document.getElementById("hidchkexscdw").value="0";
    }
}
</script>  
 
</head>
<body onLoad="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />

    <form id="frmLeaseCDW" action="saveLeaseCDW" method="get" autocomplete="off">
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Lease CDW Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Date</label>
                        <div style="width: 125px;">
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                        </div>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" id="docno" class="input-sm" value='<s:property value="docno"/>' readonly tabindex="-1">
                        </div>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Name</label>
                        <input type="text" name="name" id="name" class="input-lg" value='<s:property value="name"/>'>
                        
                        <div style="margin-left: 30px; display: flex; align-items: center; gap: 20px;">
                            <div style="display: flex; align-items: center;">
                                <input type="checkbox" name="chkexscdw" id="chkexscdw" onchange="SetExcseecdwValue();">
                                <label for="chkexscdw" style="font-size: 12px; font-weight: bold; color: #444; cursor: pointer; margin: 0;">Excess CDW</label>
                            </div>
                            
                            <div style="display: flex; align-items: center;">
                                <input type="checkbox" name="chkreplace" id="chkreplace" onchange="SetReplaceValue();">
                                <label for="chkreplace" style="font-size: 12px; font-weight: bold; color: #444; cursor: pointer; margin: 0;">Replacement</label>
                            </div>
                        </div>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Description</label>
                        <input type="text" name="description" id="description" class="input-xl" value='<s:property value="description"/>'>
                        
                        <label class="lbl-right" style="width: 80px; margin-left: 20px;">Remarks</label>
                        <input type="text" name="remarks" id="remarks" class="input-xl" value='<s:property value="remarks"/>'>
                    </div>

                </div>
            </div>

            <div id="leasecdwdiv">
                <jsp:include page="leaseCDWGrid.jsp"></jsp:include>
            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" name="hidchkreplace" id="hidchkreplace" value='<s:property value="hidchkreplace"/>'/>
            <input type="hidden" name="hidchkexscdw" id="hidchkexscdw" value='<s:property value="hidchkexscdw"/>'/>
            
        </div>
    </form>
</div>

</body>
</html>