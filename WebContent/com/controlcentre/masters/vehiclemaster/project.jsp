<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<%ClsProjectDAO cpd=new ClsProjectDAO(); %>
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

.modern-ui #jqxProjectSearch1 { 
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
$(document).ready(function () {
    /* Upgraded height to 24px for Modern UI */
    $("#projectDate").jqxDateTimeInput({ width: '125px', height: '24px' ,formatString : "dd.MM.yyyy" });
    
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
    
    $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#clientDetailsWindow').jqxWindow('close');
    
    $("#btnExcel").click(function() {
        $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
    });
    
    document.getElementById("formdet").innerText="Project(PRJ)";
    document.getElementById("formdetail").value="Project";
    document.getElementById("formdetailcode").value="PRJ";
    window.parent.formCode.value="PRJ";
    window.parent.formName.value="Project";
    
    var data= '<%=cpd.projectDetailsLoading() %>';
    
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'date', type: 'date'  },
            {name : 'refname', type: 'String'  },
            {name : 'project_name', type: 'String'  }
        ],
        localdata: data,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {}
    });
    
    $("#jqxProjectSearch1").jqxGrid({
        width: '100%',
        height: 315,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'multiplecellsextended',
        theme: 'energyblue',
        columns: [
            { text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
            { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
            { text: 'Client Name',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
            { text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '40%' }
        ]
    });
    
    $('#jqxProjectSearch1').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxProjectSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("txtprojectname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "project_name");
        $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        document.getElementById("txtclientname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
    }); 
    
    $('#txtclientname').dblclick(function(){
        clientSearchContent('clientDetailsGrid.jsp');
    });
});

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function funReadOnly(){
    $('#frmProject input').attr('readonly', true );
    $('#projectDate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly(){
    $('#frmProject input').attr('readonly', false );
    $('#projectDate').jqxDateTimeInput({disabled: false});
    $('#txtclientname').prop('readonly', true);
    $('#docno').prop('readonly', true);
}

function setValues(){   
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus(){
    $('#projectDate').jqxDateTimeInput('focus'); 
}
   
/* Validations */
$(function(){
    $('#frmProject').validate({
        rules: {
            txtclientname:"required",
            txtprojectname:"required"
        },
        messages: {
            txtclientname:" *",
            txtprojectname:" *"
        }
    });
});
     
function funNotify(){
   return 1;
} 

function funSearchLoad(){
    changeContent('projectSearch.jsp');
}
     
function getClient(event){
    var x= event.keyCode;
    if(x==114){
        clientSearchContent('clientDetailsGrid.jsp');
    }
}

function funExcelBtn(){
    $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
}
</script>
</head>
<body onload="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <form id="frmProject" action="saveActionProject" autocomplete="off" method="post">
        
        <div class="modern-ui">
            
            <div class="middle-panel">
                <span class="middle-panel-title">Project Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Date</label>
                        <div style="width: 125px;">
                            <div id="projectDate" name="projectDate" value='<s:property value="projectDate"/>'></div>
                        </div>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" id="docno" name="txtprojectdocno" class="input-sm" value='<s:property value="txtprojectdocno"/>' tabindex="-1" readonly/>
                        </div>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Client</label>
                        <input type="text" name="txtclientname" id="txtclientname" class="input-xl" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);">
                        
                        <label class="lbl-right" style="width: 80px; margin-left: 20px;">Project Name</label>
                        <input type="text" name="txtprojectname" id="txtprojectname" class="input-xl" value='<s:property value="txtprojectname"/>'>
                    </div>

                </div>
            </div>

            <div id="jqxProjectSearch1"></div> 

            <input type="hidden" id="hidprojectDate" name="hidprojectDate" value='<s:property value="hidprojectDate"/>'/>
            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            
        </div>
    </form>

    <div id="clientDetailsWindow">
        <div></div><div></div>
    </div>
</div>

</body>
</html>