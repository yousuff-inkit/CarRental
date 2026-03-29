<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
/* =========================================================
SCOPED UI: Compact Input Sizing (Plain Colors)
* All rules are scoped inside .modern-ui to protect header.jsp *
========================================================= */

body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
    overflow-x: hidden;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 15px;
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

/* Middle Section Panels matching the screenshot */
.modern-ui .modern-panel { 
    border: 1px solid #e1e4e8; 
    padding: 20px 10px 10px 10px; 
    background: #fff;
    position: relative;
    border-radius: 4px; 
    margin-bottom: 15px;
}

.modern-ui .modern-panel-title { 
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

.hidden-scrollbar { 
    overflow: auto; 
    height: 530px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }

</style>

<script type="text/javascript">
$(document).ready(function () {

    /* Master 24px heights for JQX Dates */
    $("#date").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy"});
    $("#startdate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    $("#enddate").jqxDateTimeInput({ width: '120px', height: '24px',formatString:"dd.MM.yyyy",value:null});

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

    $('#clientinfowindow').jqxWindow({ width: '62%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' ,title: ' Client Search' , position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    $('#clientinfowindow').jqxWindow('close');
    
    $('#searchwindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#searchwindow').jqxWindow('close');

    $('#cldocno').dblclick(function(){
        $('#clientinfowindow').jqxWindow('open');
        $('#clientinfowindow').jqxWindow('focus'); 
        clieninfoSearchContent('clientINgridsearch.jsp', $('#clientinfowindow'));
    });

    $('#date, #startdate, #enddate').on('change', function (event) { 
        var maindate = $(this).jqxDateTimeInput('getDate'); 
        if ($("#mode").val() == "A") { 
            funDateInPeriod(maindate);
        }
    });
});

function dataSearchContent(url) {
    $.get(url).done(function (data) {
        $('#searchwindow').jqxWindow('setContent', data);
    });
}

function funReadOnly(){
    $('#docno').attr('disabled', true);
    $('#date,#startdate,#enddate').jqxDateTimeInput({ disabled: true});
    $('#frmMasterLeaseAgmt input').attr('disabled', true );
    $('#frmMasterLeaseAgmt select').attr('disabled', true);
}

function getclientinfo(event){ 
    var x= event.keyCode; 
    if(x==114){
        $('#clientinfowindow').jqxWindow('open'); 
        clieninfoSearchContent('clientINgridsearch.jsp');    
    }
}

function clieninfoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#clientinfowindow').jqxWindow('setContent', data);
    });
}

function funRemoveReadOnly(){
    $('#frmMasterLeaseAgmt input').attr('disabled', false );
    $('#frmMasterLeaseAgmt select').attr('disabled', false);
    $('#date,#startdate,#enddate').jqxDateTimeInput({ disabled: false}); 
    
    if($('#mode').val()=='A'){
        $('#masterLeaseGrid').jqxGrid('clear');
        $('#masterLeaseGrid').jqxGrid('addrow', 0, {});
    }
    else if($('#mode').val()=='E'){
        var rows=$('#masterLeaseGrid').jqxGrid('getrows');
        $('#masterLeaseGrid').jqxGrid('addrow', rows.length+1, {});
    }
}

function funFocus(){ 
    document.getElementById("cldocno").focus();
}

function funNotify(){
    var maindate = $('#date').jqxDateTimeInput('getDate'); 
    var validdate=funDateInPeriod(maindate); 
    if(validdate==0){
        return 0;
    }

    if(document.getElementById("cldocno").value=="") {
        document.getElementById("errormsg").innerText=" Select Client"; 
        document.getElementById("cldocno").focus();
        return 0;
    }
    
    var startdate=$('#startdate').jqxDateTimeInput('getDate'); 
    if(startdate==null || startdate==""){
        document.getElementById("errormsg").innerText="Start Date is Mandatory"; 
        return 0;
    }
    
    var enddate=$('#enddate').jqxDateTimeInput('getDate'); 
    if(enddate==null || enddate==""){
        document.getElementById("errormsg").innerText="End Date is Mandatory"; 
        return 0;
    }
    
    startdate=new Date($('#startdate').jqxDateTimeInput('getDate')); 
    startdate.setHours(0,0,0,0);
    
    enddate=new Date($('#enddate').jqxDateTimeInput('getDate')); 
    enddate.setHours(0,0,0,0);
    
    if(enddate<startdate){ 
        document.getElementById("errormsg").innerText="End Date cannot be less than Start Date";
        return 0;
    }
    
    var validdesc=document.getElementById("description").value; 
    if(validdesc!="") {
        var nmaxs = validdesc.length; 
        if(nmaxs>99) {
            document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters";
            document.getElementById("description").focus(); 
            return 0;
        } else{
            document.getElementById("errormsg").innerText="";
        }
    }
    
    var rows=$('#masterLeaseGrid').jqxGrid('getrows'); 
    var z=0;
    for(var i=0;i< rows.length; i++) {
        if(rows[i].brand!="" && rows[i].brand!="undefined" && rows[i].brand!=null && typeof(rows[i].brand)!="undefined"){
            newTextBox = $(document.createElement("input"))
            .attr("type", "dil")
            .attr("id", "gridarray"+z)
            .attr("name", "gridarray"+z)
            .attr("hidden","true");

            newTextBox.val(rows[i].brandid+"::"+rows[i].modelid+"::"+rows[i].specid+"::"+rows[i].leaseduration+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].gps+"::"+rows[i].childseat+"::"+rows[i].kmrestrict+"::"+rows[i].excesskmrate);
            newTextBox.appendTo('form'); 
            z++;
        }
    }
    
    if(z==0){ 
        document.getElementById("errormsg").innerText="please type in valid vehicle details"; 
        return 0;
    }

    $('#gridlength').val(z); 
    return 1;
}

function setValues() { 
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    if($('#docno').val()!=''){
        $('#masterleasegriddiv').load('masterLeaseGrid.jsp?id=1&docno='+$('#docno').val());
    }
}

function fundescvalidate() {
    var validdesc=document.getElementById("description").value; 
    if(validdesc!="") {
        var nmaxs = validdesc.length; 
        if(nmaxs>99) {
            document.getElementById("errormsg").innerText="Description Cannot Contain More Than 100 Characters"; 
            document.getElementById("description").focus();
            return 0;
        } else {
            document.getElementById("errormsg").innerText="";
        }
    }
}

function funSearchLoad(){ 
    changeContent('mainSearch.jsp', $('#window'));
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        document.getElementById("errormsg").innerText="Enter Numbers Only"; 
        return false;
    }
    document.getElementById("errormsg").innerText=""; 
    return true;
}

function funPrintBtn(){
    if (($("#mode").val() != "A") && $("#docno").val()!="") { 
        var url=document.URL;
        var reurl=url.split("saveLeaseAgreement");
        $("#docno").prop("disabled", false); 
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document !','warning');
        return false;
    }
}
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <form id="frmMasterLeaseAgmt" action="saveMasterLeaseAgmt" method="post" autocomplete="off">
    
        <jsp:include page="../../../../header.jsp" />

        <div class="modern-ui hidden-scrollbar">

            <div style="border: 1px solid transparent; padding: 5px 0; margin-bottom: 10px;">
                <div class="field-row">
                    <label class="lbl-right" style="width: 80px;">Date</label>
                    <div style="width: 120px;">
                        <div id="date" name="date" value='<s:property value="date"/>'></div>
                    </div>

                    <label class="lbl-right" style="width: 60px;">PO</label>
                    <input type="text" name="po" id="po" class="input-md" value='<s:property value="po"/>'>

                    <label class="lbl-right" style="width: 70px;">Ref No</label>
                    <input type="text" name="refno" id="refno" class="input-md" value='<s:property value="refno"/>'>

                    <div style="margin-left: auto; display: flex; align-items: center; gap: 8px; padding-right: 10px;">
                        <label class="lbl-right">Doc No</label>
                        <input type="text" name="vocno" id="vocno" class="input-md" value='<s:property value="vocno"/>' readonly tabindex="-1">
                        <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
                    </div>
                </div>
            </div>

            <div class="modern-panel">
                <span class="modern-panel-title">Document Details</span>
                <div style="padding-top: 5px;">

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Client</label>
                        <input type="text" name="cldocno" id="cldocno" class="input-md" value='<s:property value="cldocno"/>' readonly placeholder="Press F3 to Search">
                        <input type="text" name="clientdetails" id="clientdetails" class="input-full" value='<s:property value="clientdetails"/>' readonly>
                    </div>

                    <div class="field-row">
                        <label class="lbl-right" style="width: 80px;">Description</label>
                        <input type="text" name="description" id="description" class="input-full" value='<s:property value="description"/>'>

                        <label class="lbl-right" style="width: 80px;">Start Date</label>
                        <div style="width: 120px;">
                            <div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div>
                        </div>

                        <label class="lbl-right" style="width: 80px;">End Date</label>
                        <div style="width: 120px;">
                            <div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="modern-panel">
                <span class="modern-panel-title">Master Lease Details</span>
                <div style="padding-top: 5px; min-height: 100px;">
                    <div id="masterleasegriddiv"><jsp:include page="masterLeaseGrid.jsp" /></div>
                </div>
            </div>

            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
            
        </div>
    </form>

    <div id="clientinfowindow"><div></div></div>
    <div id="searchwindow"><div></div></div>

</div>
</body>
</html>