<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
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

.modern-ui .grid-container-table {
    width: 100%;
    margin-top: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    document.getElementById("formdet").innerText="Specification(SPC)";
    document.getElementById("formdetail").value="Specification";
    document.getElementById("formdetailcode").value="SPC";
    window.parent.formCode.value="SPC";
    window.parent.formName.value="Specification";
});

function funNotify(){
    return 1;
}

function funReadOnly(){
    $('#frmSpecification input').attr('readonly', true );
}

function funRemoveReadOnly(){
    $('#frmSpecification input').attr('readonly', false );
    $('#docno').attr('readonly', true);
}

function funSearchLoad(){
    changeContent('specificationSearch.jsp', $('#window')); 
}

function chkButton(){
}

function funFocus(){
    document.getElementById("specname").focus();
}

function setValues(){
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funExcelBtn(){
    $("#specGrid").jqxGrid('exportdata', 'xls', 'Specifications');
}
</script>
</head>
<body onload="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <form id="frmSpecification" action="saveSpecification" method="post" autocomplete="off">
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Specification Info</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Name</label>
                        <input type="text" name="specname" id="specname" class="input-lg" value='<s:property value="specname"/>' placeholder="Spec Name" />

                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" tabindex="-1" readonly id="docno" class="input-sm" value='<s:property value="docno"/>'/>
                        </div>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Details</label>
                        <input type="text" name="specdetails" id="specdetails" class="input-full" style="max-width: 400px;" value='<s:property value="specdetails"/>' placeholder="Spec Details"/>
                    </div>

                </div>
            </div>

            <div class="grid-container-table">
                <table width="100%">
                    <tr>
                        <td><jsp:include page="specGrid.jsp"></jsp:include></td>
                    </tr>
                </table>
            </div>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            
        </div>
    </form>
</div>

</body>
</html>