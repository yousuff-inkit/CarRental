<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>

<!DOCTYPE html>
<html>
<head>
<%@ taglib prefix="s" uri="/struts-tags" %>
 <s:head/>
 <% String contextPath=request.getContextPath();%>
 
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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

.modern-ui #maintearch1 { 
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
$(document).ready(function() {
    /* Upgraded height to 24px for Modern UI */
    $("#miandate").jqxDateTimeInput({
        width : '125px',
        height : '24px',
        formatString : "dd.MM.yyyy"
    });
    
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
    
    document.getElementById("formdet").innerText="Maintenance(MAT)";
    document.getElementById("formdetail").value="Maintenance";
    document.getElementById("formdetailcode").value="MAT";
    window.parent.formCode.value="MAT";
    window.parent.formName.value="Maintenance";
        
    var datas= '<%=cmd.mainserch() %>';
    var num = 0; 
    var source = {                           
        datatype: "json",
        datafields: [  
            {name : 'docno' , type: 'number' },
            {name : 'mtype', type: 'String'  },
            {name : 'name', type: 'String'  },
            {name : 'date',type:'date'}
        ],
        localdata: datas,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            // alert(error);    
        }
    }); 
            
    $("#maintearch1").jqxGrid({
        width: '100%',
        height: 325,
        source: dataAdapter,
        sortable: true,    
        selectionmode: 'singlerow',
        theme: 'energyblue',
        columns: [
            { text: 'Doc No', datafield: 'docno', width: '15%' },
            { text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
            { text: 'Description',datafield:'name',width:'50%' },
            { text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true }
        ]
    });
      
    $('#maintearch1').on('rowselect', function (event) {
        var rowindex1=event.args.rowindex;
        document.getElementById("docno").value= $('#maintearch1').jqxGrid('getcellvalue', rowindex1, "docno");
        document.getElementById("maintenancetype").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "mtype");
        document.getElementById("desc").value=$('#maintearch1').jqxGrid('getcellvalue', rowindex1, "name");
        $("#miandate").jqxDateTimeInput('val',$("#maintearch1").jqxGrid('getcellvalue', rowindex1, "date"));
    }); 
});
</script>

<script type="text/javascript">
function funReadOnly(){
    $('#frmmaint input').attr('readonly', true );
    $('#miandate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
    $('#frmmaint input').attr('readonly', false );
    $('#miandate').jqxDateTimeInput({ disabled: false});
    $('#docno').attr('readonly', true);
}

function funFocus(){
    document.getElementById("maintenancetype").focus();
}

function funSearchLoad(){
    changeContent('mainmasterSearch.jsp'); 
}

function funNotify(){
    $('#miandate').jqxDateTimeInput({ disabled: false});
    return 1;
} 

$(function(){
    $('#frmmaint').validate({
        rules: {
            maintenancetype: {
                required:true,
                maxlength:20
            },
            desc:{
                required:true,
                maxlength:45
            }
        },
        messages: {
            maintenancetype:{
                required:" * required",
                maxlength:"  Max 20 chars"
            },
            desc:{
                required:" * required",
                maxlength:"  Max 45 chars"
            }
        }
    });
});

function setValues(){
    if($('#miandatehidden').val()){
        $("#miandate").jqxDateTimeInput('val', $('#miandatehidden').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}
</script>

</head>
<body onload="setValues();">
<div class="homeContent" data-type="background">
    <form id="frmmaint" action="saveMain" autocomplete="off" method="post">
        
        <jsp:include page="../../../../header.jsp" />

        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Maintenance Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 120px;">Date</label>
                        <div style="width: 125px;">
                            <div id="miandate" name="miandate" value='<s:property value="miandate"/>'></div>
                        </div>
                        <input type="hidden" name="miandatehidden" id="miandatehidden" value='<s:property value="miandatehidden"/>'>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="docno" readonly="readonly" id="docno" class="input-sm" value='<s:property value="docno"/>' tabindex="-1">
                        </div>
                    </div>

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 120px;">Maintenance Type</label>
                        <input type="text" name="maintenancetype" id="maintenancetype" class="input-lg" value='<s:property value="maintenancetype"/>'>

                        <label class="lbl-right" style="width: 80px; margin-left: 20px;">Description</label>
                        <input type="text" name="desc" id="desc" class="input-xl" value='<s:property value="desc"/>'>
                    </div>

                </div>
            </div>

            <div id="maintearch1"></div>

            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
                  
        </div>
    </form>
</div>
</body>
</html>