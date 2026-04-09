<%@page import="com.controlcentre.masters.vehiclemaster.securitypass.ClsSecurityPassDAO" %>
<%ClsSecurityPassDAO DAO1=new ClsSecurityPassDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
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

.modern-ui #jqxSecpassSearch1 { 
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
    $("#date").jqxDateTimeInput({ width: '125px', height: '24px' ,formatString : "dd.MM.yyyy" });
    $("#startdate").jqxDateTimeInput({ width: '125px', height: '24px' ,formatString : "dd.MM.yyyy" });
    $("#enddate").jqxDateTimeInput({ width: '125px', height: '24px' ,formatString : "dd.MM.yyyy" });
    
    /* Force internal alignment AFTER render for all jqxDateTimeInputs */
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

    document.getElementById("formdet").innerText="Security Pass(SPA)";
    document.getElementById("formdetail").value="Security Pass";
    document.getElementById("formdetailcode").value="SPA";
    window.parent.formCode.value="SPA";
    window.parent.formName.value="Security Pass";
        
    /* Grid starts */
    var spdata='<%=DAO1.searchDetails()%>'; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'doc_no' , type: 'number' },
            {name : 'name', type: 'String'  },
            {name : 'date', type: 'date'  },
            {name : 'startdate', type: 'date'  },
            {name : 'enddate', type: 'date'  },
            {name : 'description',type:'string'},
            {name : 'qty',type:'string'},
        ],
        localdata: spdata,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            // alert(error);    
        }
    });
    
    $("#jqxSecpassSearch1").jqxGrid({
        width: '100%',
        height:350,
        source: dataAdapter,
        showfilterrow: true,
        filterable: true,
        selectionmode: 'singlerow',
        theme: 'energyblue', /* Applied Theme */
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
            { text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
            { text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
            { text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
            { text: 'StartDate',columntype: 'textbox', filtertype: 'input', datafield: 'startdate', width: '10%',cellsformat:'dd.MM.yyyy' },
            { text: 'EndDate',columntype: 'textbox', filtertype: 'input', datafield: 'enddate', width: '10%',cellsformat:'dd.MM.yyyy' },
            { text: 'Qty',columntype: 'textbox', filtertype: 'input', datafield: 'qty', width: '10%' }
        ]
    });
    
    $('#jqxSecpassSearch1').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
        document.getElementById("name").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "name");
        document.getElementById("description").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "description");
        $("#date").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
        var sdate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate");
        var edate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate");
        
        if(sdate==null ||sdate==""){
            $("#startdate").val(new Date());
        }else{
            $("#startdate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate"));
        }
        
        if(edate==null ||edate==""){
            $("#enddate").val(new Date());
        }else{
            $("#enddate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate"));
        }
         
        document.getElementById("qty").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "qty");
        $('#window').jqxWindow('close');
    });  
    /* Grid Ends */
});
    
function funSearchLoad(){
    changeContent('securityPassSearch.jsp', $('#window')); 
}

function funReadOnly() {
    $('#frmSecpass input').attr('readonly', true);
    $('#date').jqxDateTimeInput({readonly : true});
    $('#startdate').jqxDateTimeInput({readonly : true});
    $('#enddate').jqxDateTimeInput({readonly : true});
}

function funRemoveReadOnly() {
    $('#frmSecpass input').attr('readonly', false);
    $('#date').jqxDateTimeInput({readonly : false});
    $('#startdate').jqxDateTimeInput({readonly : false});
    $('#enddate').jqxDateTimeInput({readonly : false});
    $('#docno').attr('readonly', true);
    
    if(document.getElementById("mode").value=='A'){
        $("#startdate").jqxDateTimeInput('setDate', new Date());
        $("#enddate").jqxDateTimeInput('setDate', new Date());
        $("#date").jqxDateTimeInput('setDate', new Date());
    }
}

function setValues() {
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
    
$(function(){
    $('#frmSecpass').validate({
        rules: {
            name: {
                required:true,
                maxlength:40
            }
        },
        messages: {
            name: {
                required:" *",
                maxlength:"max 40 only"
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
    $("#jqxSecpassSearch1").jqxGrid('exportdata', 'xls', 'Brand');
}
</script>  
</head>
<body onLoad="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />

    <form id="frmSecpass" action="saveSecurityPass" method="get" autocomplete="off">
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Security Pass Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Date</label>
                        <div style="width: 125px;">
                            <div id="date" name="date" value='<s:property value="date"/>'></div>
                        </div>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No.</label>
                            <input type="text" name="docno" id="docno" class="input-sm" value='<s:property value="docno"/>' readonly tabindex="-1">
                        </div>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Start Date</label>
                        <div style="width: 125px;">
                            <div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div>
                        </div>
                        
                        <label class="lbl-right" style="width: 60px; margin-left: 45px;">End Date</label>
                        <div style="width: 125px;">
                            <div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div>
                        </div>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Name</label>
                        <input type="text" name="name" id="name" class="input-xl" value='<s:property value="name"/>'>
                        
                        <label class="lbl-right" style="width: 60px; margin-left: 20px;">Qty</label>
                        <input type="text" name="qty" id="qty" class="input-sm" value='<s:property value="qty"/>'>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 80px;">Description</label>
                        <input type="text" name="description" id="description" class="input-full" style="max-width: 450px;" value='<s:property value="description"/>'>
                    </div>

                </div>
            </div>

            <div id="jqxSecpassSearch1"></div>

            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>

        </div>      
    </form>
</div>

</body>
</html>