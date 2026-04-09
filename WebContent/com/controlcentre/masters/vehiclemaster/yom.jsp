<%@page import="com.controlcentre.masters.vehiclemaster.yom.ClsYomAction" %>
<%ClsYomAction coa=new ClsYomAction(); %>

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
.modern-ui .input-full { width: 100% !important; }

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

.modern-ui #jqxYomSearch { 
    border-radius: 4px;
    border: 1px solid #d1d5db;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
    margin-top: 10px;
}
</style>

<script type="text/javascript">
var data= '<%=coa.searchDetails() %>';

$(document).ready(function () {     
    $("#btnSearch").hide(); 
    $("#btnEdit").hide(); 
    $("#btnDelete").hide(); 
    document.getElementById("formdet").innerText="YOM(YOM)";
    document.getElementById("formdetail").value="YOM";
    document.getElementById("formdetailcode").value="YOM";
    window.parent.formCode.value="YOM";
    window.parent.formName.value="YOM";
        
    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'number' },
            {name : 'yom', type: 'String'  }
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            // alert(error);    
        }
    });

    $("#jqxYomSearch").jqxGrid({
        width: '100%',
        height: 315,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        //pagermode: 'default',
        sortable: true,
        //pageable: true,
        altrows:true,
        theme: 'energyblue',
        columns: [
            { text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '40%' },
            { text: 'YOM',columntype: 'textbox', filtertype: 'input', datafield: 'yom', width: '60%' }
        ]
    });

    $('#jqxYomSearch').on('rowdoubleclick', function (event) { 
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxYomSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("yom").value = $("#jqxYomSearch").jqxGrid('getcellvalue', rowindex1, "yom");                
        $('#window').jqxWindow('hide');
    }); 
});

function funReadOnly(){
    $('#frmYom input').attr('readonly', true );
}

function funRemoveReadOnly(){
    $('#frmYom input').attr('readonly', false );
    $('#docno').attr('readonly', true);
}

function setValues(){   
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    document.getElementById("yom").focus();
}
   
$(function(){
    $('#frmYom').validate({
        rules: {
            yom: { 
                required:true,
                maxlength:45
            }
        },
        messages: {
            yom:{ 
                required:" *",
                maxlength:"max 45 chars"
            }
        }
    });
});

function funNotify(){
    return 1;
} 

function funSearchLoad(){
    changeContent('colorSearch.jsp', $('#window')); 
}

function funExcelBtn(){
    $("#jqxYomSearch").jqxGrid('exportdata', 'xls', 'YOM');
}
</script>
</head>
<body onload="setValues();" >
<div class="homeContent" data-type="background">
    <form id="frmYom" action="saveActionYom" autocomplete="off">
        
        <jsp:include page="../../../../header.jsp" />
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Yom Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 50px;">Yom</label>
                        <input type="text" name="yom" id="yom" class="input-md" value='<s:property value="yom"/>'>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" id="docno" class="input-sm" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1">
                        </div>
                    </div>

                </div>
            </div>

            <div id="jqxYomSearch"></div>

            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            
        </div>
    </form>

</div>
</body>
</html>