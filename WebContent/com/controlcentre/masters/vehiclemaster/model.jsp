<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath(); %>
<link href="<%=contextPath%>/css/body.css" rel="stylesheet" type="text/css">

<style>
/* =========================================================
   SCOPED UI: Cash Receipts Style (Bulletproofed with Grid)
========================================================= */
body {
    margin: 0;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#mainBG {
    background: #fff;
    border-radius: 12px;
    padding: 10px 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.modern-ui {
    font-size: 12px;
    color: #333;
    width: 100%;
}

.modern-ui fieldset {
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 15px;
    margin-bottom: 12px;
    background: #fdfdfd;
}

.modern-ui legend {
    font-size: 13px;
    font-weight: bold;
    color: #0b45a2;
    padding: 0 8px;
    border-left: 3px solid #0b45a2;
}

/* Master Grid Table Alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px;
    width: 100%;
    table-layout: fixed;
}

.modern-ui td {
    font-size: 12px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    font-weight: 600;
    color: #444;
    padding-right: 5px;
    white-space: nowrap;
}

/* Inputs - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    font-size: 12px;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    width: 100%;
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui input[readonly], .modern-ui input:disabled, .modern-ui select:disabled {
    background: #f8f9fa;
    color: #666;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* JQX Grid Styling overrides to match UI */
.jqx-grid {
    border-color: #c5d3e0 !important;
    border-radius: 4px;
}
.jqx-widget-header {
    background: #f1f5f9 !important;
    color: #333 !important;
    font-weight: bold;
    font-size: 12px;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 40px);
}
</style>

<script type="text/javascript">
$(document).ready(function () {          
    /* Apply exact Cash Receipts Date size */
    $("#modeldate").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });  
    
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);

    document.getElementById("formdet").innerText="Model(MOD)";
    document.getElementById("formdetail").value="Model";
    document.getElementById("formdetailcode").value="MOD";
    window.parent.formCode.value="MOD";
    window.parent.formName.value="Model";
    
    var data = '<%=cma.searchDetails() %>';
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'int' },
            {name : 'vtype', type: 'String'  },
            {name : 'date', type: 'date'  },
            {name : 'brand_name',type:'String'},
            {name : 'brandid',type:'String'}
        ],
        localdata: data
    };
              
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) { alert(error); }
    });

    $("#jqxModelSearch1").jqxGrid({
        width: '100%',
        height: 350,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        sortable: true,
        altrows: true,
        columns: [
            { text: 'Doc No', filtertype: 'number', datafield: 'DOC_NO', width: '20%' },
            { text: 'Brand ID', columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' },
            { text: 'Model', columntype: 'textbox', filtertype: 'input', datafield: 'vtype', width: '30%' },
            { text: 'Date', columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%', cellsformat:'dd.MM.yyyy' },
            { text: 'Brand', columntype: 'textbox', filtertype: 'input', datafield: 'brand_name', width: '30%' }
        ]
    });

    $('#jqxModelSearch1').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        document.getElementById("docno").value = $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vtype");
        $('#frmModel select').attr('disabled', false);
        $('#modeldate').jqxDateTimeInput({disabled: false});
        $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
        $('#frmModel select').attr('disabled', true);
        $('#modeldate').jqxDateTimeInput({disabled: true});
    }); 
    $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
});
    
function funSearchLoad(){
    changeContent('modelSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmModel input').attr('readonly', true);
    $('#frmModel select').attr('disabled', true);
    $('#modeldate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly() {
    $('#frmModel input').attr('readonly', false);
    $('#frmModel select').attr('disabled', false);
    $('#modeldate').jqxDateTimeInput({disabled: false});
    $('#docno').attr('readonly', true);
}

function getBrand() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('***');
            var brandItems = items[0].split(",");
            var brandidItems = items[1].split(",");
            var optionsbrand = '<option value="">--Select--</option>';
            for (var i = 0; i < brandItems.length; i++) {
                optionsbrand += '<option value="' + brandidItems[i] + '">' + brandItems[i] + '</option>';
            }
            $("select#brand").html(optionsbrand);
            $('#brand').val($('#brandid').val());
        }
    }
    x.open("GET", "getBrand.jsp", true);
    x.send();
}

function funFocus(){
    document.getElementById("brand").focus();
}

$(function(){
    $('#frmModel').validate({
        rules: {
            brand: { required: true },
            model: { required: true, maxlength: 20 }
        },
        messages: {
            brand: { required: " *" },
            model: { required: " *", maxlength: "max 20 chars" }
        }
    });
});

function funNotify(){ return 1; } 

function setValues() {
    if ($('#brandid').val() != null) {
        $('#brand').val($('#brandid').val());
    }
    if($('#msg').val() != ""){
       $.messager.alert('Message',$('#msg').val());
    }
}

function funExcelBtn(){
    $("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
}
</script>
</head>

<body onLoad="getBrand();setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
    <jsp:include page="../../../../header.jsp" />
    
    <form id="frmModel" action="saveActionModel" autocomplete="off">
        <div class="modern-ui">
            
            <fieldset>
                <legend>Model Details</legend>
                <input type="text" id="brandid" name="brandid" value='<s:property value="brandid"/>' hidden="true">
                
                <table border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="10%"> <col width="20%"> <col width="10%"> <col width="20%"> <col width="40%"> </colgroup>
                    <tr>
                        <td class="lbl-right">Date</td>
                        <td>
                            <div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div>
                        </td>
                        <td class="lbl-right">Doc No</td>
                        <td>
                            <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly" tabindex="-1">
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Brand</td>
                        <td> 
                            <select name="brand" id="brand"></select>
                        </td>
                        <td class="lbl-right">Model</td>
                        <td>
                            <input type="text" name="model" id="model" value='<s:property value="model"/>'>
                        </td>
                        <td></td>
                    </tr>
                </table> 
            </fieldset>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>    
        </div>
    </form>

    <div class="modern-ui">
        <table border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="2%">
                <col width="60%">
                <col width="38%">
            </colgroup>
            <tr>
                <td></td>
                <td><div id="jqxModelSearch1"></div></td>
                <td></td>
            </tr>
        </table>
    </div>

</div>

</body>
</html>