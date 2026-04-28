<%@page import="com.controlcentre.masters.vehiclemaster.brand.ClsBrandAction" %>
<%ClsBrandAction cba=new ClsBrandAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    width: 100%;
    box-sizing: border-box;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.modern-ui input[readonly], .modern-ui input:disabled {
    background: #f8f9fa;
    color: #666;
}

.modern-ui input[type="text"]:focus {
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
    $("#date_brand").jqxDateTimeInput({ width: '100%', height: '24px', formatString : "dd.MM.yyyy" });
    
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);
    
    document.getElementById("formdet").innerText="Brand(BRD)";
    document.getElementById("formdetail").value="Brand";
    document.getElementById("formdetailcode").value="BRD";
    window.parent.formCode.value="BRD";
    window.parent.formName.value="Brand";
    
    var data = '<%=cba.searchDetails() %>';
    var source = {
        datatype: "json",
        datafields: [
            {name : 'DOC_NO' , type: 'number' },
            {name : 'BRAND_NAME', type: 'String'  },
            {name : 'DATE', type: 'date'  }
        ],
        localdata: data
    };
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {}
    });

    $("#jqxBrandSearch1").jqxGrid({
        width: '100%',
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        columns: [
            { text: 'DOC NO', datafield: 'DOC_NO', width: '15%' },
            { text: 'BRAND', columntype: 'textbox', filtertype: 'input', datafield: 'BRAND_NAME', width: '55%' },
            { text: 'DATE', columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '30%', cellsformat:'dd.MM.yyyy' }
        ]
    });

    $('#jqxBrandSearch1').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        document.getElementById("docno").value = $('#jqxBrandSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
        document.getElementById("brand").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "BRAND_NAME");
        $("#date_brand").jqxDateTimeInput('val', $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "DATE"));
    }); 
});

function funSearchLoad(){
    changeContent('brandSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmBrand input').attr('readonly', true);
    $('#date_brand').jqxDateTimeInput({ readonly : true });
}

function funRemoveReadOnly() {
    $('#frmBrand input').attr('readonly', false);
    $('#date_brand').jqxDateTimeInput({ readonly : false });
    $('#docno').attr('readonly', true);
}

function setValues() {
    if($('#datehidden').val()){
        $("#date_brand").jqxDateTimeInput('val', $('#datehidden').val());
    }
    if($('#msg').val() != ""){
        $.messager.alert('Message',$('#msg').val());
    }
}

$(function(){
    $('#frmBrand').validate({
        rules: {
            brand: { required:true, maxlength:40 }
        },
        messages: {
            brand: { required:" *", maxlength:"max 40 only" } 
        }
    });
});

function funNotify(){ return 1; } 
function funFocus(){ document.getElementById("brand").focus(); }
function funExcelBtn(){ $("#jqxBrandSearch1").jqxGrid('exportdata', 'xls', 'Brand'); }
</script>  
</head>

<body onLoad="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
    
    <jsp:include page="../../../../header.jsp" />
    
    <form id="frmBrand" action="saveBrand" method="get" autocomplete="off">
        <div class="modern-ui">
            
            <fieldset>
                <legend>Brand Details</legend>
                <table border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="6%">  <col width="20%"> <col width="54%"> <col width="8%">  <col width="12%"> </colgroup>
                    <tr>
                        <td class="lbl-right">Date</td>
                        <td>
                            <div id="date_brand" name="date_brand"></div>
                        </td>
                        <td></td>
                        <td class="lbl-right">Doc No.</td>
                        <td>
                            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="true" tabindex="-1">
                        </td>
                    </tr>
                    <tr>
                        <td class="lbl-right">Brand</td>
                        <td colspan="4">
                            <input type="text" name="brand" id="brand" value='<s:property value="brand"/>' style="width: 30%;">
                        </td>
                    </tr>
                </table>
            </fieldset>

            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            
        </div>
    </form>

    <div class="modern-ui">
        <table border="0" cellspacing="0" cellpadding="0">
            <colgroup>
                <col width="3%">
                <col width="50%">
                <col width="47%">
            </colgroup>
            <tr>
                <td></td>
                <td><div id="jqxBrandSearch1"></div></td>
                <td></td>
            </tr>
        </table>
    </div>

</div>

</body>
</html>