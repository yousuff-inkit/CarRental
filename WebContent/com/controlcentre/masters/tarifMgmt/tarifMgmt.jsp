<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.controlcentre.masters.tarifmgmt.ClsTarifAction"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>

<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Tariff Management</title>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
html, body { height: 100%; overflow-y: auto; }
body::-webkit-scrollbar { width: 10px; }
body::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 8px; }
body::-webkit-scrollbar-thumb { background: #4da3ff; border-radius: 8px; border: 2px solid #eaf3ff; }
body::-webkit-scrollbar-thumb:hover { background: #1a73e8; }
.hidden-scrollbar { max-height: 80vh; overflow-y: auto; padding-right: 10px; scrollbar-width: thin; scrollbar-color: #4da3ff #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar { width: 8px; }
.hidden-scrollbar::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 4px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background-color: #4da3ff; border-radius: 4px; border: 2px solid #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar-thumb:hover { background-color: #1a73e8; }
body { background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%); font-family: "Poppins", "Segoe UI", sans-serif; color: #1f2f46; margin: 0; padding: 40px 0; min-height: 100vh; animation: fadeIn 0.5s ease-in-out; box-sizing: border-box; }
#mainBG { background: #f4f8ff; border-radius: 16px; box-shadow: 0 4px 25px rgba(50, 110, 255, 0.12); padding: 22px 26px; max-width: 1250px; margin: 0 auto; transition: 0.3s ease; }
.receipt-header { background: #edf4ff; border: 1px solid #c9dafc; border-radius: 14px; padding: 18px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(132, 168, 255, 0.12); }
.clean-grid-form { display: grid; grid-template-columns: repeat(6, 1fr); gap: 14px 18px; width: 100%; box-sizing: border-box; align-items: center; }
.clean-grid-item { display: flex; flex-direction: column; }
.clean-grid-item.full { grid-column: span 6; }
.clean-input, .clean-grid-item input[type="text"], .clean-grid-item select, .receipt-header input[type="text"], .receipt-header select, .receipt-header textarea { width: 100%; height: 42px; padding: 8px 12px; border: 1px solid #b9ccf2; border-radius: 8px; background: #ffffff; font-size: 0.95rem; color:#1f2f46; box-sizing: border-box; transition: 0.14s ease; }
.clean-input:focus, .receipt-header input[type="text"]:focus, .receipt-header select:focus, .receipt-header textarea:focus { border-color: #4da3ff; box-shadow: 0 0 6px rgba(77,163,255,0.20); outline: none; }
#jqxTariffDate, #jqxTariffFromDate, #jqxTariffToDate { width: 100% !important; height: 42px !important; }
#jqxTariffDate input, #jqxTariffFromDate input, #jqxTariffToDate input { height: 40px !important; padding-left: 10px !important; border-radius: 8px !important; background-color: #ffffff !important; box-shadow: none !important; }
.cr-table input[type="text"], .cr-table select { width: 100%; height: 40px; padding: 6px 10px; box-sizing: border-box; border-radius: 8px; border: 1px solid #d6e1ff; background: #fff; }
label { font-weight: 600; font-size: 13px; color: #1b3f73; margin-bottom: 6px; display:block; }
.cr-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(100, 140, 255, 0.06); }
.cr-table th, .cr-table td { padding: 10px 12px; border-bottom: 1px solid #e6eefc; text-align: left; font-size: 0.95rem; color: #1f2f46; vertical-align: middle; }
.cr-table th { background-color: #dcebff; color: #1b3f73; font-weight: 600; }
button, .myButton { background: linear-gradient(90deg, #3b82f6, #1a73e8); color: #fff; border: none; border-radius: 8px; padding: 8px 18px; font-weight: 600; cursor: pointer; transition: 0.18s ease; box-shadow: 0 3px 10px rgba(30, 100, 255, 0.12); }
@keyframes fadeIn { from { opacity: 0; transform: translateY(-6px); } to { opacity: 1; transform: translateY(0); } }
@media (max-width: 1000px) { .clean-grid-form { grid-template-columns: repeat(2, 1fr); } .clean-grid-item.full { grid-column: span 2; } .receipt-header { padding: 14px; } }
</style>

<script type="text/javascript">
$(document).ready(function () {
  getTariftype();
  getcheckbox();
  setCheck();
  document.getElementById("grouplabel").style.display="none";
  document.getElementById("txtclient").disabled=true;
  $("#jqxTariffDate").jqxDateTimeInput({ width: '100%', height: 42, formatString:"dd.MM.yyyy"});
  $("#jqxTariffFromDate").jqxDateTimeInput({ width: '100%', height: 42, formatString:"dd.MM.yyyy"});
  $("#jqxTariffToDate").jqxDateTimeInput({ width: '100%', height: 42, formatString:"dd.MM.yyyy"});
  document.getElementById("btnTarifEdit").style.display="none";
  $('#clienttarifwindow').jqxWindow({autoOpen:false, width: '50%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
  $('#clienttarifwindow').jqxWindow('close');
  selectTarif();
  $('#txtclient').dblclick(function(){
    $('#clienttarifwindow').jqxWindow('open');
    $('#clienttarifwindow').jqxWindow('focus');
    clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
  });
});

function clientSearchContent(url) {
  $.get(url).done(function (data) {
    $('#clienttarifwindow').jqxWindow('setContent', data);
  });
}
function getClient(event){
  var x= event.keyCode;
  if(x==114){
    $('#clienttarifwindow').jqxWindow('open');
    $('#clienttarifwindow').jqxWindow('focus');
    clientSearchContent('clientSearch.jsp?tariftype='+document.getElementById("cmbtariftype").value, $('#clienttarifwindow'));
  }
}
function selectTarif(){
  $('#frmTariffManagement select').attr('disabled',false );
  var temp=document.getElementById("cmbtariftype").value;
  if(document.getElementById("mode").value=='A'){}
  if(temp=="Client"){
    $('#txtclient').attr('disabled', false );
    $("#jqxgridtarif").jqxGrid({ disabled: false});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    $("#jqxgridtariffuel").jqxGrid({ disabled: false});
    if(document.getElementById("mode").value=='A'){
      $("#jqxgridtarif").jqxGrid({ disabled: true});
    }
  } else if(temp=="Corporate"){
    $('#txtclient').attr('disabled', false );
    $("#jqxgridtarif").jqxGrid({ disabled: false});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    $("#jqxgridtariffuel").jqxGrid({ disabled: false});
    if(document.getElementById("mode").value=='A'){
      $("#jqxgridtarif").jqxGrid({ disabled: true});
    }
  } else if(temp=="Weekend"){
    document.getElementById("fieldweekday").style.display="block";
    document.getElementById("fieldfoc").style.display="none";
    $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    $("#jqxgridtarif").jqxGrid({ disabled: true});
    if(document.getElementById("mode").value=='A'){
      $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
      $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    }
  } else if(temp=="FOC"){
    document.getElementById("fieldweekday").style.display="none";
    document.getElementById("fieldfoc").style.display="block";
    $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    $("#jqxgridtarif").jqxGrid({ disabled: true});
    if(document.getElementById("mode").value=='A'){
      $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
      $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    }
  } else {
    $('#txtclient').attr('disabled', true );
    $("#jqxgridtarif").jqxGrid({ disabled: false});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    $("#jqxgridtariffuel").jqxGrid({ disabled: false});
    if(document.getElementById("mode").value=='A'){
      $("#jqxgridtarif").jqxGrid({ disabled: true});
    }
  }
}
function funReadOnly(){
  $('#frmTariffManagement input').attr('readonly', true );
  $('#frmTariffManagement select').attr('disabled', true );
  $('#frmTariffManagement textarea').attr('readonly', true );
  $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: true});
  $('#jqxTariffToDate').jqxDateTimeInput({ disabled: true});
  $('#jqxTariffDate').jqxDateTimeInput({ disabled: true});
  $("#jqxgridtarif").jqxGrid({ disabled: true});
  $("#jqxgridtariffuel").jqxGrid({ disabled: true});
  $("#jqxgridtariffoc").jqxGrid({ disabled: true});
  $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
  $("#jqxgridtarifgrpfinish").jqxGrid({ disabled: true});
}
function funRemoveReadOnly(){
  $('#frmTariffManagement input').attr('readonly', false );
  $('#frmTariffManagement select').attr('disabled', false );
  $('#frmTariffManagement textarea').attr('readonly', false );
  $('#jqxTariffFromDate').jqxDateTimeInput({ disabled: false});
  $('#jqxTariffToDate').jqxDateTimeInput({ disabled: false});
  $('#jqxTariffDate').jqxDateTimeInput({ disabled: false});
  $("#jqxgridtarif").jqxGrid({ disabled: false});
  $("#jqxgridtariffuel").jqxGrid({ disabled: false});
  $("#jqxgridtariffoc").jqxGrid({ disabled: false});
  $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
  $("#jqxgridtarifgrpfinish").jqxGrid({ disabled: false});
  if(document.getElementById("mode").value=='A'){
    $("#divRegularTarif").load("gridRegularTarif.jsp");
    $("#divfoc").load("gridFoc.jsp");
    $("#divweekday").load("gridWeekday.jsp");
    $("#divgroup1").load("gridgroup1.jsp");
    $("#divgroup2").load("gridgroup2.jsp");
    document.getElementById("grouplabel").style.display="none";
    document.getElementById("btnTarifEdit").style.display="none";
    document.getElementById("btnTarifSave").style.display="none";
    $("#jqxTariffFromDate").jqxDateTimeInput('setDate', new Date());
    $("#jqxTariffToDate").jqxDateTimeInput('setDate', new Date());
    $("#jqxTariffDate").jqxDateTimeInput('setDate', new Date());
  }
}
function funNotify(){
  if(document.getElementById("docno").value!=''){
    var rows = $("#jqxgridtarif").jqxGrid('getrows');
    $('#gridlength').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
      newTextBox = $(document.createElement("input")).attr("type", "dil").attr("id", "test"+i).attr("name", "test"+i);
      newTextBox.val(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+rows[i].disclevel1+"::"+rows[i].disclevel2+"::"+rows[i].disclevel3+"::"+rows[i].kmrest+"::"+rows[i].exkmrte+"::"+rows[i].oinschg);
      newTextBox.appendTo('form');
    }
    if(document.getElementById("cmbtariftype").value=='Weekend'){
      var rowsweekday=$("#jqxgridtarifweekday").jqxGrid('getrows');
      var j=0;
      for(var i=0 ; i < rowsweekday.length ; i++){
        newTextBoxweekday = $(document.createElement("input")).attr("type", "dil").attr("id", "txtweekday"+i).attr("name", "txtweekday"+i);
        var d=new Date(rowsweekday[i].cstime);
        var tempstarttime=d.getHours()+":"+(d.getMinutes()<10?'0':'') + d.getMinutes();
        var d1=new Date(rowsweekday[i].cetime);
        var tempendtime=d1.getHours()+":"+(d1.getMinutes()<10?'0':'') + d1.getMinutes();
        if(typeof(rowsweekday[i].cswkday)!="undefined" && rowsweekday[i].cswkday!="" && typeof(rowsweekday[i].cstime)!="undefined" && typeof(rowsweekday[i].cstime)!="" && typeof(rowsweekday[i].cewkday)!="undefined" && rowsweekday[i].cewkday!="" && typeof(rowsweekday[i].cetime)!="undefined" && rowsweekday[i].cetime!="" ){
          newTextBoxweekday.val(rowsweekday[i].cswkday+"::"+tempstarttime+"::"+rowsweekday[i].cewkday+"::"+tempendtime+"::"+rowsweekday[i].rate+"::"+rowsweekday[i].cdw+"::"+rowsweekday[i].gps+"::"+rowsweekday[i].babyseater+"::"+rowsweekday[i].cooler+"::"+rowsweekday[i].kmrest+"::"+rowsweekday[i].exkmrte+"::"+rowsweekday[i].oinschg+"::"+rowsweekday[i].ulevel1+"::"+rowsweekday[i].ulevel2+"::"+rowsweekday[i].ulevel3+"::"+rowsweekday[i].exdaychg);
          j++;
          newTextBoxweekday.appendTo('form');
        }
      }
      $('#weekdaylength').val(j);
    }
    if(document.getElementById("cmbtariftype").value=='FOC'){
      var rowsfoc=$("#jqxgridtariffoc").jqxGrid('getrows');
      $('#foclength').val(rowsfoc.length);
      for(var i=0 ; i < rowsfoc.length ; i++){
        newTextBoxfoc = $(document.createElement("input")).attr("type", "dil").attr("id", "txtfoc"+i).attr("name", "txtfoc"+i);
        newTextBoxfoc.val(rowsfoc[i].minday+"::"+rowsfoc[i].foc+"::"+rowsfoc[i].rate+"::"+rowsfoc[i].cdw+"::"+rowsfoc[i].gps+"::"+rowsfoc[i].babyseater+"::"+rowsfoc[i].cooler+"::"+rowsfoc[i].kmrest+"::"+rowsfoc[i].exkmrte+"::"+rowsfoc[i].oinschg);
        newTextBoxfoc.appendTo('form');
      }
    }
    var a=document.getElementById("gridlength").value;
    var b=document.getElementById("weekdaylength").value;
    var c=document.getElementById("foclength").value;
    var d=document.getElementById("fuellength").value;
  }
  $('#frmTariffManagement select').attr('disabled',false);
  $('#txtclient').attr('disabled',false);
  return 1;
}
function setCheck(){
  if(document.getElementById("chckdeliverychg").checked==true){
    document.getElementById("hidcheck").value=1;
  } else {
    document.getElementById("hidcheck").value=0;
  }
}
function getcheckbox(){
  if(document.getElementById("hidcheck").value==1){
    document.getElementById("chckdeliverychg").checked=true;
  } else {
    document.getElementById("chckdeliverychg").unchecked=true;
  }
}
function setValues(){
  document.getElementById("cmbtariftype").disabled=false;
  if(document.getElementById("cmbtariftype").value=="Weekend"){
    document.getElementById("fieldweekday").style.display="block";
    document.getElementById("fieldfoc").style.display="none";
  }
  if(document.getElementById("cmbtariftype").value=="FOC"){
    document.getElementById("fieldweekday").style.display="none";
    document.getElementById("fieldfoc").style.display="block";
  }
  if(document.getElementById("docno")!=''){
    var temp=document.getElementById("docno").value;
    $("#divgroup2").load("gridgroup2.jsp?id="+temp);
    $("#divgroup1").load("gridgroup1.jsp?id="+temp);
  }
  if ($('#hidcmbtariftype').val() != null) {
    $('#cmbtariftype').val($('#hidcmbtariftype').val());
  }
  if ($('#hidcmbtariffor').val() != null) {
    $('#cmbtariffor').val($('#hidcmbtariffor').val());
  }
  if($('#hidjqxTariffDate').val()){
    $("#jqxTariffDate").jqxDateTimeInput('val', $('#hidjqxTariffDate').val());
  }
  if($('#hidjqxTariffFromDate').val()){
    $("#jqxTariffFromDate").jqxDateTimeInput('val', $('#hidjqxTariffFromDate').val());
  }
  if($('#hidjqxTariffToDate').val()){
    $("#jqxTariffToDate").jqxDateTimeInput('val', $('#hidjqxTariffToDate').val());
  }
  if($('#msg').val()!=""){
    $.messager.alert('Message',$('#msg').val());
  }
  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
  if(document.getElementById("docno").value==''){
    document.getElementById("btnTarifEdit").style.display="none";
  }
  document.getElementById("cmbtariftype").disabled=true;
}
function funTarifEdit(){
  document.getElementById("cmbtariftype").disabled=false;
  $("#jqxgridtarifgrp").jqxGrid({ disabled:false});
  document.getElementById("insurexcess").readOnly=false;
  document.getElementById("cdwexcess").readOnly=false;
  document.getElementById("scdwexcess").readOnly=false;
  document.getElementById("securityamt").readOnly=false;
  if(document.getElementById("cmbtariftype").value=="Weekend"){
    $("#jqxgridtarifweekday").jqxGrid({ disabled: false});
    $("#jqxgridtariffoc").jqxGrid({ disabled:true});
    $("#jqxgridtarif").jqxGrid({ disabled: true});
    document.getElementById("btnTarifEdit").style.display="none";
    document.getElementById("btnTarifSave").style.display="block";
  } else if(document.getElementById("cmbtariftype").value=="FOC"){
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtariffoc").jqxGrid({ disabled:false});
    $("#jqxgridtarif").jqxGrid({ disabled: true});
    document.getElementById("btnTarifEdit").style.display="none";
    document.getElementById("btnTarifSave").style.display="block";
  } else {
    $("#jqxgridtariffoc").jqxGrid({ disabled: true});
    $("#jqxgridtarifweekday").jqxGrid({ disabled: true});
    $("#jqxgridtariffuel").jqxGrid({ disabled: false});
    document.getElementById("btnTarifEdit").style.display="none";
    document.getElementById("btnTarifSave").style.display="block";
    $("#jqxgridtarif").jqxGrid({ disabled: false});
  }
  document.getElementById("cmbtariftype").disabled=true;
}
function funTarifSave(){
  document.getElementById("cmbtariftype").disabled=false;
  if(document.getElementById("cmbtariftype").value=="Weekend"){
    var rowsweekday=$('#jqxgridtarifweekday').jqxGrid('getrows');
    if(typeof(rowsweekday[0].cswkday)=="undefined" || rowsweekday[0].cswkday==""){
      document.getElementById("errormsg").innerText="Start day is Mandatory";
      return false;
    }
    if(typeof(rowsweekday[0].cstime)=="undefined" || rowsweekday[0].cstime==""){
      document.getElementById("errormsg").innerText="Start time is Mandatory";
      return false;
    }
    if(typeof(rowsweekday[0].cewkday)=="undefined" || rowsweekday[0].cewkday==""){
      document.getElementById("errormsg").innerText="End day is Mandatory";
      return false;
    }
    if(typeof(rowsweekday[0].cetime)=="undefined" || rowsweekday[0].cetime==""){
      document.getElementById("errormsg").innerText="End time is Mandatory";
      return false;
    }
    if(typeof(rowsweekday[0].rate)=="undefined" || rowsweekday[0].rate==""){
      document.getElementById("errormsg").innerText="Tariff is Mandatory";
      return false;
    }
  }
  if(document.getElementById("docno").value!=""){
    document.getElementById("mode").value="A";
    $('#btnSave').mousedown();
  } else {
    $.messager.alert('Warning','Please Select a Valid Document');
    return false;
  }
  document.getElementById("cmbtariftype").disabled=true;
}
function isNumber(evt,id) {
  var iKeyCode = (evt.which) ? evt.which : evt.keyCode
  if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
    $.messager.alert('Warning','Enter Numbers Only');
    $("#"+id+"").focus();
    return false;
  }
  return true;
}
function funPrintBtn() {
  if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
    $.messager.alert('Warning','Select a Document');
    return false;
  }
  var url=document.URL;
  var reurl=url.split("com/");
  var win= window.open(reurl[0]+"com/controlcentre/masters/tarifmgmt/tarifPrint.action?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
  win.focus();
}
function getTariftype(){
  var x = new XMLHttpRequest();
  x.onreadystatechange = function() {
    if (x.readyState == 4 && x.status == 200) {
      var items = x.responseText;
      items=items.split("***");
      var tarifitems = items[0].split(",");
      var optionstarif = '<option value="">--Select--</option>';
      for (var i = 0; i < tarifitems.length; i++) {
        optionstarif += '<option value="' + tarifitems[i] + '">' + tarifitems[i] + '</option>';
      }
      $("select#cmbtariftype").html(optionstarif);
      if ($('#hidcmbtariftype').val() != null) {
        $('#cmbtariftype').val($('#hidcmbtariftype').val());
      }
      document.getElementById("fieldfoc").style.display="none";
      document.getElementById("fieldweekday").style.display="none";
    }
  }
  x.open("GET", "getTariftype.jsp", true);
  x.send();
}
</script>

</head>

<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmTariffManagement" action="saveTariffManagement" autocomplete="off">
<script>
  window.parent.formName.value="Tariff Management";
  window.parent.formCode.value="TFM";
</script>
<jsp:include page="../../../../header.jsp" />
<br/>

<div class="hidden-scrollbar">
  <div class="receipt-header">
    <div class="clean-grid-form">

```
  <div class="clean-grid-item">
    <label>Date</label>
    <div id="jqxTariffDate"></div>
    <input type="hidden" id="hidjqxTariffDate" name="hidjqxTariffDate" value='<s:property value="hidjqxTariffDate"/>'/>
  </div>

  <div class="clean-grid-item">
    <label>Tariff Type</label>
    <select id="cmbtariftype" name="cmbtariftype" class="clean-input" onchange="selectTarif();">
      <option value="">--Select--</option>
    </select>
    <input type="hidden" id="hidcmbtariftype" name="hidcmbtariftype" value='<s:property value="hidcmbtariftype"/>'/>
  </div>

  <div class="clean-grid-item">
    <label>Tariff / Client</label>
    <input type="text" id="txtclient" name="txtclient" class="clean-input" placeholder="Press F3 to Search" value='<s:property value="txtclient"/>' onkeydown="getClient(event);" />
    <input type="hidden" name="hidtxtclient" id="hidtxtclient" value='<s:property value="hidtxtclient"/>'/>
  </div>

  <div class="clean-grid-item">
    <label>Tariff For</label>
    <select id="cmbtariffor" name="cmbtariffor" class="clean-input">
      <option value="">--Select--</option>
      <option value="Vehicle">Vehicle</option>
    </select>
    <input type="hidden" id="hidcmbtariffor" name="hidcmbtariffor" value='<s:property value="hidcmbtariffor"/>'/>
  </div>

  <div class="clean-grid-item">
    <label>Validity From</label>
    <div id="jqxTariffFromDate"></div>
    <input type="hidden" id="hidjqxTariffFromDate" name="hidjqxTariffFromDate" value='<s:property value="hidjqxTariffFromDate"/>'/>
  </div>

  <div class="clean-grid-item">
    <label>Validity To</label>
    <div id="jqxTariffToDate"></div>
    <input type="hidden" id="hidjqxTariffToDate" name="hidjqxTariffToDate" value='<s:property value="hidjqxTariffToDate"/>'/>
  </div>

  <div class="clean-grid-item" style="display:flex; align-items:center; gap:10px;">
    <label style="margin:0;">Delivery Charge</label>
    <input type="checkbox" id="chckdeliverychg" name="chckdeliverychg" onchange="setCheck();">
    <input type="hidden" name="hidcheck" id="hidcheck" value='<s:property value="hidcheck"/>'>
  </div>

  <div class="clean-grid-item full">
    <label>Notes</label>
    <textarea id="notes" name="notes" class="clean-input" style="height:44px; resize:none;"><s:property value="notes"/></textarea>
  </div>

</div>
```

  </div>
</div>

<table width="100%" style="margin-top:12px;">
  <tr>
    <td width="6%" rowspan="11" valign="top"><div id="divgroup1"><jsp:include page="gridgroup1.jsp"></jsp:include></div></td>
    <td colspan="2" align="center"><fieldset style="border-radius:10px;padding:14px;"><div id="divRegularTarif"><jsp:include page="gridRegularTarif.jsp"></jsp:include></div></fieldset></td>
    <td width="6%" rowspan="11" valign="top"><div id="divgroup2"><jsp:include page="gridgroup2.jsp"></jsp:include></div></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><fieldset id="fieldextrainsur" style="padding:12px;">
      <table width="100%">
        <tr>
          <td align="right" style="width:16%;">Security Amount</td><td align="left" style="width:18%;"><input type="text" name="securityamt" id="securityamt" value='<s:property value="securityamt"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right" style="width:16%;">Insurance Excess</td><td align="left" style="width:18%;"><input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td align="right" style="width:16%;">CDW Excess</td><td align="left" style="width:18%;"><input type="text" name="cdwexcess" id="cdwexcess" value='<s:property value="cdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
        </tr>
        <tr>
          <td align="right">Super CDW Excess</td><td align="left"><input type="text" name="scdwexcess" id="scdwexcess" value='<s:property value="scdwexcess"/>' onkeypress="javascript:return isNumber (event,id)"></td>
          <td colspan="4"></td>
        </tr>
      </table>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><fieldset id="fieldfoc" style="padding:12px; display:none;">
      <legend>FOC Tariff</legend>
      <div id="divfoc"><jsp:include page="gridFoc.jsp"></jsp:include></div>
    </fieldset></td>
  </tr>
  <tr>
    <td colspan="2" align="center"><fieldset id="fieldweekday" style="padding:12px; display:none;">
      <legend>Week Day Tariff</legend>
      <div id="divweekday"><jsp:include page="gridWeekday.jsp"></jsp:include></div>
    </fieldset></td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <input type="hidden" name="conditionstatus" id="conditionstatus" value='<s:property value="conditionstatus"/>'>
  <input type="hidden" name="hidgroupdoc" id="hidgroupdoc" value='<s:property value="hidgroupdoc"/>'>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="text" name="delete" id="delete" value='<s:property value="delete"/>' hidden="true"/>
<input type="hidden" name="tempgroup" id="tempgroup" value='<s:property value="tempgroup"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="weekdaylength" id="weekdaylength" value='<s:property value="weekdaylength"/>'>
<input type="hidden" name="foclength" id="foclength" value='<s:property value="foclength"/>'>
<input type="hidden" name="fuellength" id="fuellength" value='<s:property value="fuellength"/>'>
<input type="hidden" name="tarifmode" id="tarifmode" value='<s:property value="tarifmode"/>'>
<input type="hidden" name="temprowindex" id="temprowindex" value='<s:property value="temprowindex"/>'>
<input type="hidden" name="deliverylength" id="deliverylength" value='<s:property value="deliverylength"/>'>
<input type="hidden" name="tempdocno" id="tempdocno" value='<s:property value="tempdocno"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="tempstatus" id="tempstatus" value='<s:property value="tempstatus"/>'>

</form>

<div id="clienttarifwindow"><div></div></div>

<div hidden="true">
<fieldset>
  <legend>Fuel Info</legend>
  <table width="100%">
    <tr>
      <td><div id="divfuel"><jsp:include page="gridfuel.jsp"></jsp:include></div></td>
    </tr>
  </table>
</fieldset>
</div>

<p>&nbsp;</p>
</div>
</body>
</html>
