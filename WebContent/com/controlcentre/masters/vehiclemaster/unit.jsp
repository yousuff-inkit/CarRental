<%@page import="com.controlcentre.masters.vehiclemaster.unit.ClsUnitAction" %>
<% ClsUnitAction cua =new ClsUnitAction();%>

<%@ taglib prefix="s" uri="/struts-tags" %>
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

.modern-ui #jqxUnitSearch1 { 
    border-radius: 4px;
    border: 1px solid #d1d5db;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
    margin-top: 10px;
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
var data= '<%=cua.searchDetails() %>';

$(document).ready(function () {     
    document.getElementById("formdet").innerText="Unit(UOM)";
    document.getElementById("formdetail").value="Unit";
    document.getElementById("formdetailcode").value="UOM";
    window.parent.formCode.value="UOM";
    window.parent.formName.value="Unit";
    
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'number' },
            {name : 'unit', type: 'String'  },
            {name : 'unit_desc', type:  'String'}
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            // alert(error);    
        }
    });
  
    $("#jqxUnitSearch1").jqxGrid({
        width: '100%',
        height: 337,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows:true,
        theme: 'energyblue', /* Applied energyblue theme */
        columns: [
            { text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '30%' },
            { text: 'Unit',columntype: 'textbox', filtertype: 'input', datafield: 'unit', width: '30%' },
            { text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'unit_desc',width: '40%'}
        ]
    });

    $('#jqxUnitSearch1').on('rowdoubleclick', function (event) { 
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxUnitSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("unit").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit");
        document.getElementById("unitdesc").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit_desc");
    });
});

function funSearchLoad(){
    changeContent('unitSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmUnit input').attr('readonly', true);
}

function funRemoveReadOnly() {
    $('#frmUnit input').attr('readonly', false);
    $('#docno').attr('readonly', true);
}

function setValues(){   
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("unit").focus();
}

$(function(){
    $('#frmUnit').validate({
        rules: {
            unit:{
                required:true,
                maxlength:3
            }, 
            unitdesc:{
                maxlength:25
            }
        },
        messages: {
            unit:{
                required:" *",
                maxlength:"max 3 chars"
            },
            unitdesc:{
                maxlength:"max 25 chars"
            }
        }
    });
});

function funNotify(){
    return 1;
} 

function funExcelBtn(){
    $("#jqxUnitSearch1").jqxGrid('exportdata', 'xls', 'Unit');
}
</script>
</head>
<body onload="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    
    <form id="frmUnit" action="saveActionUnit" autocomplete="off">
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Unit Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Unit</label>
                        <input type="text" name="unit" id="unit" class="input-sm" value='<s:property value="unit"/>'>

                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" id="docno" class="input-sm" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
                        </div>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Description</label>
                        <input type="text" name="unitdesc" id="unitdesc" class="input-full" style="max-width: 400px;" value='<s:property value="unitdesc"/>'>
                    </div>

                </div>
            </div>

            <div id="jqxUnitSearch1"></div>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            
        </div>
    </form>
</div>

</body>
</html>