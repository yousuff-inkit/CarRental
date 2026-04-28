<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">

<style>
/* =========================================================
   SCOPED UI: Cash Receipts Style (Safe Version)
========================================================= */
body {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    margin: 0;
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 12px;
    padding: 10px 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 40px);
}

form label.error {
    color: red;
    font-weight: bold;
}

/* This class protects your header from being affected by the new CSS */
.modern-ui {
    font-size: 12px;
    color: #333;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Fieldset & Legend */
.modern-ui fieldset {
    border-radius: 6px;
    border: 1px solid #c5d3e0;
    padding: 8px 10px;
    margin-bottom: 12px;
    background: #fdfdfd;
}

.modern-ui legend {
    font-size: 13px;
    font-weight: bold;
    padding: 0 8px;
    border-left: 3px solid #0b45a2;
    color: #0b45a2;
}

/* Table Settings (Preserving your original structure) */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 2px 6px;
}

.modern-ui td {
    font-size: 12px;
    vertical-align: middle;
    white-space: nowrap;
}

.modern-ui td[align="right"] {
    font-weight: 600;
    color: #444;
    padding-right: 5px;
}

/* Master Input Heights - Forced to 24px */
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

.modern-ui input[readonly] {
    background: #f8f9fa;
    color: #666;
}

/* Search Icon Wrapper */
.search-wrapper {
    position: relative;
    display: inline-block;
    width: 100%;
}
.search-wrapper input {
    padding-right: 25px !important;
}
.search-wrapper .magnifier-icon {
    position: absolute;
    right: 5px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #2563eb;
    font-weight: bold;
    font-size: 13px;
    z-index: 10;
}
</style>

<script type="text/javascript">
$(document).ready(function() {
    /* JQX Date Pickers - Set to 24px */
    $("#nonpooldate").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });
    $("#regexpiry").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });  
    $("#insurexpiry").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });
    $("#lstsrvcdate").jqxDateTimeInput({ width : '100%', height : '24px', formatString : "dd.MM.yyyy" });
    
    /* Force internal JQX styling */
    setTimeout(function () {
        $(".jqx-datetimeinput").css({"border-color": "#b8c6d8", "border-radius": "3px"});
        $(".jqx-datetimeinput input").css({"line-height": "24px", "font-size": "12px", "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif"});
        $(".jqx-datetimeinput .jqx-action-button").css({"height": "24px"});
    }, 100);
    
    getTestPlateCode();
    getTestModel();
    getTestLocation(); 
});

function getTestPlateCode(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText;
            items = items.split('####');
            var plateItems = items[0].split(",");
            var plateIdItems = items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            for (var i = 0; i < plateItems.length; i++) {
                optionsplate += '<option value="' + plateIdItems[i] + '">' + plateItems[i] + '</option>';
            }
            $("select#cmbplatecode").html(optionsplate);
            if ($('#hidcmbplatecode').val() != null && $('#hidcmbplatecode').val() != "") {
                $('#cmbplatecode').val($('#hidcmbplatecode').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getTestPlateCode.jsp", true);
    x.send();
}

function getTestModel(){
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            var modelItems = items[0].split(",");
            var modelidItems = items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            for (var i = 0; i < modelItems.length; i++) {
                optionsmodel += '<option value="' + modelidItems[i] + '">' + modelItems[i] + '</option>';
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null && $('#hidcmbmodel').val() != "") {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getTestModel.jsp", true);
    x.send();
}

function getTestLocation(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var locationItems=items[0].split(",");
            var locationidItems=items[1].split(",");
            var optionslocation = '<option value="">--Select--</option>';
            for ( var i = 0; i < locationItems.length; i++) {
                optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
            }
            $("select#cmbavailloc").html(optionslocation);
            if ($('#hidcmbavailloc').val() != null && $('#hidcmbavailloc').val() != "") {
                $('#cmbavailloc').val($('#hidcmbavailloc').val()); 
            }
        }
    }
    x.open("GET","../vehiclemaster/getTestLocation.jsp",true);
    x.send();
}

function checkRegNo(){
    var mode=document.getElementById("mode").value;
    var docno=document.getElementById("docno").value;
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();
            if(parseInt(items)>0){
                document.getElementById("errormsg").innerText="";
                document.getElementById("errormsg").innerText="Reg No Already Exists";
                document.getElementById("regno").focus();
                return false;
            }
            document.getElementById("errormsg").innerText="";
        }
    }
    x.open("GET", "../vehicle/checkRegNo.jsp?regno="+document.getElementById("regno").value+"&plate="+document.getElementById("cmbplatecode").value+"&mode="+mode+"&docno="+docno, true);
    x.send();
}

function funReset(){}

function funReadOnly(){
    $('#frmNonpoolvehicle input').attr('readonly', true);
    $('#frmNonpoolvehicle select').attr('disabled', true );
    $('#frmNonpoolvehicle textarea').attr('disabled', true );
    $('#nonpooldate').jqxDateTimeInput({ disabled: true});
    $('#regexpiry').jqxDateTimeInput({ disabled: true});
    $('#insurexpiry').jqxDateTimeInput({ disabled: true});
    $('#lstsrvcdate').jqxDateTimeInput({ disabled: true}); 
}

function funRemoveReadOnly(){
    $('#frmNonpoolvehicle input').attr('readonly', false);
    $('#frmNonpoolvehicle select').attr('disabled', false );
    $('#frmNonpoolvehicle textarea').attr('disabled', false );
    $('#nonpooldate').jqxDateTimeInput({ disabled: false});
    $('#regexpiry').jqxDateTimeInput({ disabled: false});
    $('#insurexpiry').jqxDateTimeInput({ disabled: false});
    $('#lstsrvcdate').jqxDateTimeInput({ disabled: false}); 
    $('#docno').attr('readonly', true);
}

function getAuthority() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('####');
            var authItems=items[0].split(",");
            var authidItems=items[1].split(",");
            var optionsauth = '<option value="">--Select--</option>';
            for ( var i = 0; i < authItems.length; i++) {
                optionsauth += '<option value="' + authidItems[i] + '">' + authItems[i] + '</option>';
            }
            $("select#cmbauthority").html(optionsauth);
            if ($('#hidcmbauthority').val() != null && $('#hidcmbauthority').val() != "") {
                $('#cmbauthority').val($('#hidcmbauthority').val());
            }
        }
    }
    x.open("GET","../vehiclemaster/getAuthority.jsp",true);
    x.send();
}

function getPlatecode(value) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var plateItems=items[0].split(",");
            var plateidItems=items[1].split(",");
            var optionsplate = '<option value="">--Select--</option>';
            for ( var i = 0; i < plateItems.length; i++) {
                optionsplate += '<option value="' + plateidItems[i] + '">' + plateItems[i] + '</option>';
            }
            $("select#cmbplatecode").html(optionsplate);
            if ($('#hidcmbplatecode').val() != null && $('#hidcmbplatecode').val() != "") {
                $('#cmbplatecode').val($('#hidcmbplatecode').val());
            }
        }
    }
    x.open("GET","getPlatecode.jsp?id="+value,true);
    x.send();
}

function getBrand() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var brandItems=items[0].split(",");
            var brandidItems=items[1].split(",");
            var optionsbrand = '<option value="">--Select--</option>';
            for ( var i = 0; i < brandItems.length; i++) {
                optionsbrand += '<option value="' + brandidItems[i] + '">' + brandItems[i] + '</option>';
            }
            $("select#cmbbrand").html(optionsbrand);
            if ($('#hidcmbbrand').val() != null && $('#hidcmbbrand').val() != "") {
                $('#cmbbrand').val($('#hidcmbbrand').val());
            }
        }
    }
    x.open("GET","../vehiclemaster/getBrand.jsp",true);
    x.send();
}

function getGroup() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var groupItems=items[0].split(",");
            var groupidItems=items[1].split(",");
            var optionsgroup = '<option value="">--Select--</option>';
            for ( var i = 0; i < groupItems.length; i++) {
                optionsgroup += '<option value="' + groupidItems[i] + '">' + groupItems[i] + '</option>';
            }
            $("select#cmbgroup").html(optionsgroup);
            if ($('#hidcmbgroup').val() != null && $('#hidcmbgroup').val() != "") {
                $('#cmbgroup').val($('#hidcmbgroup').val());
            }
        }
    }
    x.open("GET","getGroup.jsp",true);
    x.send();
}

function getModel(value) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var modelItems=items[0].split(",");
            var modelidItems=items[1].split(",");
            var optionsmodel = '<option value="">--Select--</option>';
            for ( var i = 0; i < modelItems.length; i++) {
                optionsmodel += '<option value="' + modelidItems[i] + '">' + modelItems[i] + '</option>';
            }
            $("select#cmbmodel").html(optionsmodel);
            if ($('#hidcmbmodel').val() != null && $('#hidcmbmodel').val() != "") {
                $('#cmbmodel').val($('#hidcmbmodel').val());
            }
        }
    }
    x.open("GET","getModel.jsp?id="+value,true);
    x.send();
}

function getYom() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var yomItems=items[0].split(",");
            var yomidItems=items[1].split(",");
            var optionsyom = '<option value="">--Select--</option>';
            for ( var i = 0; i < yomItems.length; i++) {
                optionsyom += '<option value="' + yomidItems[i] + '">' + yomItems[i] + '</option>';
            }
            $("select#cmbyom").html(optionsyom);
            if ($('#hidcmbyom').val() != null && $('#hidcmbyom').val() != "") {
                $('#cmbyom').val($('#hidcmbyom').val());
            }
        }
    }
    x.open("GET","getYom.jsp",true);
    x.send();
}

function getBranch() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            brchIdItems = items[0].split(",");
            brchItems = items[1].split(",");
            var optionsbrch = '<option value="">--Select--</option>';
            for (var i = 0; i < brchItems.length; i++) {
                optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
            }
            $("select#cmbavailbranch").html(optionsbrch);
            if ($('#hidcmbavailbranch').val() != null && $('#hidcmbavailbranch').val() != "") {
                $('#cmbavailbranch').val($('#hidcmbavailbranch').val());
            }
        }
    }
    x.open("GET", "../vehiclemaster/getBranch.jsp", true);
    x.send();
}

function getLocation(value) {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var locationItems=items[0].split(",");
            var locationidItems=items[1].split(",");
            var optionslocation = '<option value="">--Select--</option>';
            for ( var i = 0; i < locationItems.length; i++) {
                optionslocation += '<option value="' + locationidItems[i] + '">' + locationItems[i] + '</option>';
            }
            $("select#cmbavailloc").html(optionslocation);
            if ($('#hidcmbavailloc').val() != null && $('#hidcmbavailloc').val() != "") {
                $('#cmbavailloc').val($('#hidcmbavailloc').val());
            }
        }
    }
    x.open("GET","getLocation.jsp?id="+value,true);
    x.send();
}

function getColor() {
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            items= x.responseText;
            items=items.split('***');
            var colorItems=items[0].split(",");
            var coloridItems=items[1].split(",");
            var optionscolor = '<option value="">--Select--</option>';
            for ( var i = 0; i < colorItems.length; i++) {
                optionscolor += '<option value="' + coloridItems[i] + '">' + colorItems[i] + '</option>';
            }
            $("select#cmbcolor").html(optionscolor);
            if ($('#hidcmbcolor').val() != null && $('#hidcmbcolor').val() != "") {
                $('#cmbcolor').val($('#hidcmbcolor').val());
            }
        }
    }
    x.open("GET","getColor.jsp",true);
    x.send();
}

function getFleetname() {
    document.getElementById("fleetname").value="";
    var r=$("#cmbbrand option:selected").text();
    var r1=$("#cmbmodel option:selected").text();
    document.getElementById("fleetname").value = r+" "+r1;
}

function funNotify(){
    return 1;
}

function setValues() {
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
    getAuthority();
    getBrand();
    getGroup();
    getYom();
    getBranch();
    getColor();

    if ($('#hidcmbfuel').val() != null && $('#hidcmbfuel').val() != "") {
        $('#cmbfuel').val($('#hidcmbfuel').val());
    }
    if ($('#hidcmbfueltype').val() != null && $('#hidcmbfueltype').val() != "") {
        $('#cmbfueltype').val($('#hidcmbfueltype').val());
    }
    if ($('#hidcmbavailbranch').val() != null && $('#hidcmbavailbranch').val() != "") {
        $('#cmbavailbranch').val($('#hidcmbavailbranch').val());
    }
    if ($('#hidcmbavailloc').val() != null && $('#hidcmbavailloc').val() != "") {
        $('#cmbavailloc').val($('#hidcmbavailloc').val());
    }
    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    }
}

function funFocus() {
    document.getElementById("cmbauthority").focus();
}

$(function(){
    $('#frmNonpoolvehicle').validate({
        rules: {
            cmbauthority:"required",
            cmbplatecode:"required",
            cmbgroup:"required",
            regno:"required",
            cmbbrand:"required",
            cmbmodel:"required",
            cmbyom:"required",
            saliktag:"required",
            cmbfuel:"required",
            cmbcolor:"required",
            cmbavailbranch:"required",
            cmbavailloc:"required",
            fuelcapacity:"required",
            cmbfueltype:"required",
        }, 
        messages:{
            cmbauthority:" *", 
            cmbplatecode:" *",
            cmbgroup:" *",
            regno:" *",
            cmbbrand:" *",
            cmbmodel:" *",
            cmbyom:" *",
            saliktag:" *",
            cmbfuel:" *",
            cmbcolor:" *",
            cmbavailbranch:" *",
            cmbavailloc:" *",
            cmbfueltype:" *",
            fuelcapacity:" *",
        }
    });
});  

function funSearchLoad(){
    changeContent('masterSearch.jsp', $('#window')); 
}
</script>

</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    
    <form id="frmNonpoolvehicle" action="saveActionNonpoolvehicle" autocomplete="off" method="post">
        
        <div class="modern-ui">
        
            <fieldset>
                <legend>Vehicle Info</legend>
                <table width="100%">
                    <tr>
                        <td align="right">Date</td>
                        <td colspan="3" align="left">
                            <div id="nonpooldate" name="nonpooldate"></div>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                        <td align="right">Doc No</td>
                        <td align="left"><input name="docno" type="text" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly></td>
                    </tr>
                    <tr>
                        <td align="right">Fleet No</td>
                        <td colspan="3" align="left">
                            <div style="display: flex; gap: 5px; align-items: center;">
                                <div class="search-wrapper" style="width:30%;">
                                    <input type="text" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' tabindex="-1" readonly>
                                    <span class="magnifier-icon" onclick="funSearchLoad();">&#128269;</span>
                                </div>
                                <input type="text" name="fleetname" id="fleetname" value='<s:property value="fleetname"/>' style="width:70%;" readonly tabindex="-1">
                            </div>
                        </td>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td> 
                        <td align="right"><span style="text-align: right">Ast Status</span></td>
                        <td width="16%" align="left"><input type="text" name="aststatus" id="aststatus" value='<s:property value="aststatus"/>' readonly tabindex="-1"></td>
                        <td width="6%" align="right">CostTran No</td>
                        <td align="left"><input type="text" name="costtranno" id="costtranno" value='<s:property value="costtranno"/>' readonly tabindex="-1"></td>
                    </tr>
                    <tr>
                        <td width="6%" align="right">Authority</td>
                        <td width="11%" align="left">
                            <select name="cmbauthority" style="width:100%;" id="cmbauthority" onchange="getPlatecode(this.value);" >
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td width="5%" align="right">Plate Code</td>
                        <td width="8%" align="left">
                            <select name="cmbplatecode" id="cmbplatecode" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td align="right">Reg No</td>
                        <td align="left"><input type="text" name="regno" id="regno" value='<s:property value="regno"/>' onblur="checkRegNo();"></td>
                        <td width="6%" align="right">Group</td>
                        <td align="left">
                            <select name="cmbgroup" id="cmbgroup" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td align="right">Op Status</td>
                        <td align="left"><input type="text" name="opstatus" id="opstatus" value='<s:property value="opstatus"/>' readonly tabindex="-1"></td>
                    </tr>
                    <tr>
                        <td align="right">Brand</td>
                        <td align="left">
                            <select name="cmbbrand" id="cmbbrand" style="width:100%;" onchange="getModel(this.value);">
                                <option value="" >--Select--</option>
                            </select>
                        </td>
                        <td align="right">Model</td>
                        <td align="left">
                            <select name="cmbmodel" id="cmbmodel" style="width:100%;" onchange="getFleetname();">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td width="6%" align="right">YoM</td>
                        <td width="12%" align="left">
                            <select name="cmbyom" id="cmbyom" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td align="right">Salik Tag</td>
                        <td align="left"><input type="text" name="saliktag" id="saliktag" value='<s:property value="saliktag"/>'></td>
                        <td align="right">Veh Color</td>
                        <td width="24%" align="left">
                            <select name="cmbcolor" id="cmbcolor" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">Reg Expiry</td>
                        <td align="left"><div id="regexpiry"></div></td>
                        <td align="right">&nbsp;</td>
                        <td align="left">&nbsp;</td>
                        <td align="right">Ins Expiry</td>
                        <td align="left"><div id="insurexpiry"></div></td>
                        <td align="right">Avail Branch </td>
                        <td align="left">
                            <select name="cmbavailbranch" id="cmbavailbranch" style="width:100%;" onchange="getLocation(this.value);">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                        <td align="right">Location</td>
                        <td align="left">
                            <select name="cmbavailloc" id="cmbavailloc" style="width:100%;">
                                <option value="">--Select--</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </fieldset>

            <fieldset>
                <legend>Other Info</legend>
                <table width="100%">
                    <tr>
                        <td width="6%" align="right">Engine No</td>
                        <td colspan="3" align="left"><input type="text" name="engineno" id="engineno" value='<s:property value="engineno"/>' style="text-transform:uppercase;"></td>
                        <td width="7%" align="right">Chassis No</td>
                        <td width="8%" align="left"><input type="text" name="chasisno" id="chasisno" value='<s:property value="chasisno"/>' style="text-transform:uppercase;"></td>
                        <td width="6%" align="right">VIN</td>
                        <td width="12%" align="left"><input type="text" name="vin" id="vin" value='<s:property value="vin"/>' ></td>
                        <td width="6%" align="right">Fuel Type</td>
                        <td width="14%" align="left">
                            <select id="cmbfueltype" name="cmbfueltype">
                                <option value="">--Select--</option>
                                <option value="P">Petrol</option>
                                <option value="D">Diesel</option>
                            </select>
                        </td>
                        <td width="8%" align="right">Fuel Tank Cap.</td>
                        <td width="11%" align="left"><input type="text" name="fuelcapacity" id="fuelcapacity" value='<s:property value="fuelcapacity"/>' /></td>
                        <td width="4%" align="right">Fuel</td>
                        <td width="9%" align="left">
                            <select name="cmbfuel" id="cmbfuel" style="width:100%;">
                                <option value="">--Select--</option>
                                <option value="0.000">Level 0/8</option>
                                <option value="0.125">Level 1/8</option>
                                <option value="0.250">Level 2/8</option>
                                <option value="0.375">Level 3/8</option>
                                <option value="0.500">Level 4/8</option>
                                <option value="0.625">Level 5/8</option>
                                <option value="0.750">Level 6/8</option>
                                <option value="0.875">Level 7/8</option>
                                <option value="1.000">Level 8/8</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </fieldset>

            <fieldset>
                <legend>Service Info</legend>
                <table width="100%">
                    <tr>
                        <td width="6%" align="right">Service KM</td>
                        <td colspan="3" align="left"><input type="text" name="servicekm" id="servicekm" value='<s:property value="servicekm"/>' ></td>
                        <td width="7%" align="right">Last Service KM</td>
                        <td width="8%" align="left"><input type="text" name="lastservicekm" id="lastservicekm" value='<s:property value="lastservicekm"/>'></td>
                        <td width="6%" align="right">Last srvc.Date</td>
                        <td width="12%" align="left"><div id="lstsrvcdate"></div></td>
                        <td width="6%" align="right">Current KM</td>
                        <td width="46%" align="left"><input type="text" name="currentkm" id="currentkm" value='<s:property value="currentkm"/>' ></td>
                    </tr>
                </table>
            </fieldset>
            
            <label id="errormsg" style="color:red; font-weight:bold;"></label>

            <input type="hidden" name="hidnonpooldate" id="hidnonpooldate" value='<s:property value="hidnonpooldate"/>'>
            <input type="hidden" name="hidcmbauthority" id="hidcmbauthority" value='<s:property value="hidcmbauthority"/>'>
            <input type="hidden" name="hidcmbplatecode" id="hidcmbplatecode" value='<s:property value="hidcmbplatecode"/>'>
            <input type="hidden" id="hidcmbgroup" name="hidcmbgroup" value='<s:property value="hidcmbgroup"/>'>
            <input type="hidden" name="hidcmbbrand" id="hidcmbbrand" value='<s:property value="hidcmbbrand"/>'>
            <input type="hidden" name="hidcmbmodel" id="hidcmbmodel" value='<s:property value="hidcmbmodel"/>'>
            <input type="hidden" name="hidcmbyom" id="hidcmbyom" value='<s:property value="hidcmbyom"/>'>
            <input type="hidden" name="hidcmbcolor" id="hidcmbcolor" value='<s:property value="hidcmbcolor"/>'>
            <input type="hidden" name="hidinsurexpiry" id="hidinsurexpiry" value='<s:property value="hidinsurexpiry"/>'>
            <input type="hidden" name="hidregexpiry" id="hidregexpiry" value='<s:property value="hidregexpiry"/>'>
            <input type="hidden" name="hidcmbavailbranch" id="hidcmbavailbranch"  value='<s:property value="hidcmbavailbranch"/>'>
            <input type="hidden" name="hidcmbavailloc" id="hidcmbavailloc" value='<s:property value="hidcmbavailloc"/>'>
            <input type="hidden" name="hidcmbfueltype" id="hidcmbfueltype" value='<s:property value="hidcmbfueltype"/>' />
            <input type="hidden" id="hidcmbfuel" name="hidcmbfuel" value='<s:property value="hidcmbfuel"/>'>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
            <input type="hidden" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>'>
            <input type="hidden" name="vehdocno" id="vehdocno" value='<s:property value="vehdocno"/>'>
            
        </div>
    </form>
</div>

</body>
</html>