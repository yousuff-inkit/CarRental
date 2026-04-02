<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
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

/* Dynamic Grid Wrappers */
.modern-ui #trafficdiv,
.modern-ui #salikdiv {
    border-radius: 4px;
    border: 1px solid #d1d5db;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05); 
    margin-top: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {     
    /* Upgraded height to 24px for Modern UI */
    $("#tsDate").jqxDateTimeInput({  width: '125px', height: '24px', formatString:"dd.MM.yyyy"}); 
    
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

    $('#tafficfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#tafficfleetsearchwindow').jqxWindow('close');
    $('#salickfleetsearchwindow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#salickfleetsearchwindow').jqxWindow('close');   
});
         
function salickinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#salickfleetsearchwindow').jqxWindow('open');
        $('#salickfleetsearchwindow').jqxWindow('setContent', data);
    }); 
} 

function trafficinfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#tafficfleetsearchwindow').jqxWindow('open');
        $('#tafficfleetsearchwindow').jqxWindow('setContent', data);
    }); 
} 

function funFocus(){
    document.getElementById("tsDate").focus();
}

function funReset() {}

function funReadOnly() {
    $('#frmsalic input').attr('readonly', true);
    $('#frmsalic select').attr('disabled', true);
    $('#tsDate').jqxDateTimeInput({ disabled: true});
    $("#salikgrid").jqxGrid({ disabled: true});
    $("#traficgrid").jqxGrid({ disabled: true});
}

function funRemoveReadOnly() {
    $('#frmsalic input').attr('readonly', false);
    $('#frmsalic select').attr('disabled', false);
    $('#tsDate').jqxDateTimeInput({ disabled: false});
    $("#salikgrid").jqxGrid({ disabled: false});
    $("#traficgrid").jqxGrid({ disabled: false});
    $('#traficdocno').attr('readonly', true);
    
    if ($("#mode").val() == "A") {
        $('#tsDate').val(new Date());
        $("#salikgrid").jqxGrid('clear');
        $("#salikgrid").jqxGrid('addrow', null, {});
        $("#traficgrid").jqxGrid('clear');
        $("#traficgrid").jqxGrid('addrow', null, {});
        $("#trafficdiv").prop("hidden", false);
        $("#salikdiv").prop("hidden",true);
   }
}

function funNotify(){
    if($('#entry').val()=="salik") {
        var rows = $("#salikgrid").jqxGrid('getrows');
        var minaa;
        for(var i=0;i<rows.length;i++){
            if(rows[i].fleetno>0) {
                minaa=1;
                break;
            } else {
                minaa=0;
            }
            if(minaa==0){
                document.getElementById("errormsg").innerText="Enter Salik Details";  
                return 0;
            } 
        }  
       
        for(var i=0 ; i < rows.length ; i++){
            if(rows[i].fleetno>0) {
                if(rows[i].hiddate==""||rows[i].hiddate==null) {
                    document.getElementById("errormsg").innerText="Enter Date";  
                    return 0;
                }
            } 
        }
        var rows = $("#salikgrid").jqxGrid('getrows');
        $('#salickgridlenght').val(rows.length);
        
        for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "salicktest"+i)
            .attr("name", "salicktest"+i)
            .attr("hidden", "true"); 

            newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].tagno+" :: "
                +rows[i].hiddate+" :: "+rows[i].hidtime+" :: "+rows[i].transaction+" :: "+rows[i].direction+" :: "
                +rows[i].source+" :: "+rows[i].amount+" :: "+rows[i].location+" :: ");
            newTextBox.appendTo('form');
        } 
    } else {
        var rows = $("#traficgrid").jqxGrid('getrows');
        var minaa;
        for(var i=0;i<rows.length;i++){
            if(rows[i].fleetno>0) {
                minaa=1;
                break;
            } else {
                minaa=0;
            }
            if(minaa==0){
                document.getElementById("errormsg").innerText="Enter Traffic Details";  
                return 0;
            } 
        }  
        
        var rows = $("#traficgrid").jqxGrid('getrows');
        for(var i=0 ; i < rows.length ; i++){
            if(rows[i].fleetno>0) {
                if(rows[i].hiddate==null) {
                    document.getElementById("errormsg").innerText="Enter Date";  
                    return 0;
                }
            } 
        }
        var rows = $("#traficgrid").jqxGrid('getrows');
        $('#trafficgridlenght').val(rows.length);
        
        for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "traffictest"+i)
            .attr("name", "traffictest"+i)
            .attr("hidden", "true"); 
        
            newTextBox.val(rows[i].fleetno+"::"+rows[i].regno+" :: "+rows[i].source+" :: "
                +rows[i].finesource+" :: "+rows[i].fineno+" :: "+rows[i].hiddate+" :: "+rows[i].hidtime
                +" :: "+rows[i].amount+" :: "+rows[i].description+" :: "+rows[i].location+" :: "+rows[i].pltid+" :: "+rows[i].tcno+" :: ");
            newTextBox.appendTo('form');
        } 
    }
    return 1;
}

function funChkButton() {}
  
function funSearchLoad(){
    changeContent('saltrafficMastersearch.jsp'); 
}
 
function gridchange() {
    if($('#entry').val()=="salik") {
        $("#trafficdiv").prop("hidden", true);
        $("#salikdiv").prop("hidden",false);
    } else {
        $("#trafficdiv").prop("hidden", false);
        $("#salikdiv").prop("hidden",true);
    }
}

function chkChange() {
    if($('#entryval').val()!="") {
        $('#entry').val($('#entryval').val());
    }

    var indexVal2 = document.getElementById("traficdocno").value;
    
    if(indexVal2>0) {
        if($('#entryval').val()=="traffic") {
            $("#trafficdiv").prop("hidden", false);
            $("#salikdiv").prop("hidden",true);
            $("#trafficdiv").load("traficGrid.jsp?trafficdocno="+indexVal2);
        } else {
            $("#trafficdiv").prop("hidden", true);
            $("#salikdiv").prop("hidden",false);
            $("#salikdiv").load("salikmainGrid.jsp?salickdocno="+indexVal2);   
        }
    }
    
    var indexVal3 = document.getElementById("traficdocno").value;
    
    if(indexVal3==0) {
        if($('#entryval').val()=="traffic") {
            $("#trafficdiv").prop("hidden", false);
            $("#salikdiv").prop("hidden",true);
        } else {
            $("#trafficdiv").prop("hidden", true);
            $("#salikdiv").prop("hidden",false);
        }
    }
}
 
function setValues() {
    if($('#hidtsDate').val()){
        $("#tsDate").jqxDateTimeInput('val', $('#hidtsDate').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";      
    chkChange();
}
</script>
</head>

<body onload="setValues();">

<div class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp" />
    
    <form id="frmsalic" action="saveSalik" method="post" autocomplete="off">
        
        <div class="modern-ui">

            <div class="middle-panel">
                <span class="middle-panel-title">Salik & Traffic Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row" style="margin-bottom: 0;">
                        <label class="lbl-right" style="width: 60px;">Entry</label>
                        <select name="entry" id="entry" class="input-md" value='<s:property value="entry"/>' onchange="gridchange()">
                            <option value="traffic">Traffic</option>
                            <option value="salik">Salik</option>
                        </select>
                        
                        <label class="lbl-right" style="width: 60px; margin-left: 20px;">Date</label>
                        <div style="width: 125px;">
                            <div id="tsDate" name="tsDate" value='<s:property value="tsDate"/>'></div>
                            <input type="hidden" name="hidtsDate" id="hidtsDate" value='<s:property value="hidtsDate"/>'>
                        </div>
                        
                        <div style="margin-left: 50px; display: flex; align-items: center; gap: 8px;">
                            <label class="lbl-right" style="width: 60px;">Doc No</label>
                            <input type="text" name="traficdocno" id="traficdocno" class="input-sm" tabindex="-1" value='<s:property value="traficdocno"/>'>
                        </div>
                    </div>

                </div>
            </div>

            <div id="trafficdiv"><jsp:include page="traficGrid.jsp"></jsp:include></div> 
            <div id="salikdiv" hidden="true"><jsp:include page="salikmainGrid.jsp"></jsp:include></div> 

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" id="entryval" name="entryval" value='<s:property value="entryval"/>'>
            <input type="hidden" id="salickgridlenght" name="salickgridlenght" value='<s:property value="salickgridlenght"/>'>
            <input type="hidden" id="trafficgridlenght" name="trafficgridlenght" value='<s:property value="trafficgridlenght"/>'>

        </div>
    </form>

    <div id="salickfleetsearchwindow"><div></div></div>
    <div id="tafficfleetsearchwindow"><div></div></div>

</div>
</body>
</html>