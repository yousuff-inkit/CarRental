<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>

/* =================== PREMIUM BLUE UI (UPGRADED) =================== */

:root {
  --pblue: #0a4b9c;               /* Premium Blue */
  --pblue-light: #e8f1ff;
  --pblue-border: #bcd4ff;
  --pblue-focus: #6ea8ff;
  --text-dark: #1b2f4b;
  --card-shadow: rgba(10, 40, 90, 0.08);
}

/* ===== Page ===== */
body {
  background: linear-gradient(180deg, #eaf3ff 0%, #f5f9ff 100%);
  font-family: 'Segoe UI', 'Roboto', Arial, sans-serif;
  margin: 0;
  padding: 22px;
  color: var(--text-dark);
  font-size: 15px;
  overflow-y: scroll !important;
}

/* Wrapper */
#mainBG.homeContent {
  max-width: 1200px;
  margin: auto;
}

/* ===== Premium Card Layout ===== */
.form-card {
  background: #ffffff;
  border-radius: 14px;
  padding: 20px 22px;
  border: 1px solid #dfe9ff;
  box-shadow: 0px 8px 28px var(--card-shadow);
  margin-bottom: 18px;
}

/* Header Bar */
.card-header {
  background: linear-gradient(90deg, #e8f0ff, #ffffff);
  padding: 14px 18px;
  font-size: 18px;
  font-weight: 600;
  color: var(--pblue);
  border-radius: 12px;
  border-left: 4px solid var(--pblue);
  margin-bottom: 18px;
}

/* ===== Responsive 2-column Grid ===== */
.grid-row {
  display: grid;
  grid-template-columns: 170px 1fr 160px 1fr;
  gap: 18px 22px;
  align-items: center;
}

.label-txt {
  font-size: 15px;
  font-weight: 700;
  color: var(--text-dark);
}

/* ===== Premium Input ===== */
.erp-input {
  width: 100%;
  height: 36px;
  padding: 8px 12px;
  border: 1.7px solid var(--pblue-border);
  border-radius: 8px;
  background: white;
  font-size: 14px;
  color: #183a5a;
  transition: 0.20s;
}

.erp-input:hover {
  border-color: var(--pblue);
}

.erp-input:focus {
  border-color: var(--pblue);
  box-shadow: 0 0 0 2px rgba(53, 124, 255, 0.28);
  background: #ffffff;
}

/* Select with same style */
.erp-select {
  width: 100%;
  height: 36px;
  padding: 6px 10px;
  border-radius: 8px;
  border: 1.7px solid var(--pblue-border);
  background: white;
  font-size: 14px;
  color: #183a5a;
  transition: 0.20s;
}

.erp-select:hover,
.erp-select:focus {
  border-color: var(--pblue);
  box-shadow: 0 0 0 2px rgba(53, 124, 255, 0.28);
}

/* Full span inputs */
.span-4 {
  grid-column: 1 / -1;
}

/* ===== Table Styling ===== */
.cr-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 10px;
  overflow: hidden;
  box-shadow: 0 3px 16px rgba(0,0,0,0.04);
}

.cr-table thead th {
  background: var(--pblue-light);
  color: var(--pblue);
  padding: 10px 12px;
  font-weight: 700;
  border-bottom: 1px solid #d7e5ff;
}

.cr-table td {
  padding: 10px 12px;
  border-bottom: 1px solid #eef4ff;
  font-size: 14px;
  color: #284a6a;
}

/* Scroll area for grid */
.hidden-scrollbar {
  overflow-y: auto;
  max-height: 450px;
}

/* Remove Chrome Autofill Pink */
input.erp-input:-webkit-autofill,
input.erp-input:-webkit-autofill:hover,
input.erp-input:-webkit-autofill:focus {
    -webkit-box-shadow: 0 0 0px 1000px #ffffff inset !important;
    border: 1.7px solid var(--pblue-border) !important;
    -webkit-text-fill-color: #183a5a !important;
}

/* ===== Mobile Fix ===== */
@media(max-width: 900px) {
  .grid-row { grid-template-columns: 1fr; }
}

/* FIX: Input & label alignment */
.grid-row {
  display: grid;
  grid-template-columns: 140px 260px 140px 260px;   /* FIXED WIDTHS */
  gap: 14px 22px;
  align-items: center;
}

/* FIX: labels spacing */
.label-txt {
  padding-top: 4px;         /* pushes label down a bit */
  font-size: 15px;
}

/* FIX: inputs height + alignment */
.erp-input, .erp-select {
  height: 32px;
  padding: 6px 10px;
}

/* FIX: Description width smaller */
.desc-small {
  width: 260px !important;
}

/* FIX: Vendor fields alignment */
.vendor-box {
  display: flex;
  gap: 8px;
  align-items: center;
}

/* FIX: Description stays next to Pay Terms (same row) */
.desc-row {
  display: flex;
  align-items: center;
  gap: 20px;
}



/* Reduce all input width globally */
.erp-input {
  width: 180px !important;   /* small & clean */
}

/* For long fields if needed */
.erp-input.long {
  width: 300px !important;
}

/* Description smaller */
#purdesc {
  width: 250px !important;
}


</style>


<!-- keep your JS intact -->
<script type="text/javascript">
// (original scripts kept as-is)
$(document).ready(function () {
    /* Date */
    $("#nipurchaseorderdate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({  width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');

    $('#typesearchwindow').jqxWindow({
        width : '25%',
        height : '58%',
        maxHeight : '70%',
        maxWidth : '45%',
        title : ' Search',
        position : {
            x : 700,
            y : 87
        },
        theme : 'energyblue',
        showCloseButton : true,
        keyboardCloseKey : 27
    });
    $('#typesearchwindow').jqxWindow('close');

    $('#txtproducttype').dblclick(function(){
        typeFormSearchContent('typeFormSearchGrid.jsp');
    });

    $('#puraccid').dblclick(function(){
        if($('#mode').val()!= "view") {
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?');
        }
    });
});

function getaccountdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!="view") {
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?');
        } else {
            // nothing
        }
    }
}
function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    });
}
function typeFormSearchContent(url) {
    $('#typesearchwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#typesearchwindow').jqxWindow('setContent', data);
        $('#typesearchwindow').jqxWindow('bringToFront');
    });
}
function getProdType(event){
    var x= event.keyCode;
    if(x==114){
        typeFormSearchContent('typeFormSearchGrid.jsp');
    }
}
function funReset(){ }
function funReadOnly(){
    $('#frmNipurchaseOrder input').attr('readonly', true );
    $('#frmNipurchaseOrder select').attr('disabled', true );
    $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: true});
    $('#deliverydate').jqxDateTimeInput({ disabled: true});
    $("#descdetailsGrid").jqxGrid({ disabled: true});
    $('#cmbcurr').attr('disabled', true);
    $('#acctype').attr('disabled', true);
    $('#txtproducttype').attr('disabled', true);
}
function funRemoveReadOnly(){
    funinterstate();
    $('#frmNipurchaseOrder input').attr('readonly', false );
    $('#txtproducttype').attr('readonly', true);
    $('#frmNipurchaseOrder select').attr('disabled', false );
    $('#currate').attr('readonly', true);
    $('#puraccid').attr('readonly', true);
    $('#puraccname').attr('readonly', true);
    $('#nipurchaseorderdate').jqxDateTimeInput({ disabled: false});
    $('#deliverydate').jqxDateTimeInput({ disabled: false});
    $('#cmbcurr').attr('disabled', false);
    $('#acctype').attr('disabled', false);
    $('#docno').attr('readonly', true);
    $("#descdetailsGrid").jqxGrid({ disabled: false});
    if ($("#mode").val() == "A") {
        $('#nipurchaseorderdate').val(new Date());
        $('#deliverydate').val(new Date());
        $("#descdetailsGrid").jqxGrid('clear');
        $("#descdetailsGrid").jqxGrid('addrow', null, {});
        $('#txtproducttype').attr('disabled', true);
        document.getElementById("validates").value=0;
    }
    if($('#mode').val()=='E') {
        $("#descdetailsGrid").jqxGrid('addrow', null, {});
    }
    getCurrencyIds();
}
function funFocus(){
    $('#nipurchaseorderdate').jqxDateTimeInput('focus');
}
function funNotify(){
    var purid= document.getElementById("puraccid").value;
    if(purid==""){
        document.getElementById("errormsg").innerText=" Select An Account";
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    if(parseInt(document.getElementById("validates").value)==1) {
        var txtproducttype= document.getElementById('txtproducttype').value;
        if(txtproducttype=="") {
            document.getElementById("errormsg").innerText=" Bill Type Is Required ";
            document.getElementById('txtproducttype').focus();
            return 0;
        }
    }
    var refval= document.getElementById("nettotal").value;
    if(refval=="") {
        document.getElementById("errormsg").innerText="Net Amount Empty";
        return 0;
    } else {
        document.getElementById("errormsg").innerText="";
    }
    var rows = $("#descdetailsGrid").jqxGrid('getrows');
    $('#descgridlenght').val(rows.length);
    for(var i=0 ; i < rows.length ; i++){
        newTextBox = $(document.createElement("input"))
           .attr("type", "dil")
           .attr("id", "desctest"+i)
           .attr("name", "desctest"+i)
           .attr("hidden", "true");
        newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
               +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "+rows[i].taxper+"::"+rows[i].taxperamt+"::"+rows[i].taxamount+"::");
        newTextBox.appendTo('form');
    }
    return 1;
}
function funChkButton() { }
function funSearchLoad(){ changeContent('mainsearch.jsp'); }
function getCurrencyIds(){
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
     if (x.readyState==4 && x.status==200){
       items= x.responseText;
       items=items.trim().split('####');
       var curidItems=items[0];
       var curcodeItems=items[1];
       var currateItems=items[2];
       var multiItems=items[3];
       var optionscurr = '';
       if(curcodeItems.indexOf(",")>=0){
         curidItems=curidItems.split(",");
         curcodeItems=curcodeItems.split(",");
         currateItems=currateItems.split(",");
         for ( var i = 0; i < curcodeItems.length; i++) {
           optionscurr += '<option value="' + curidItems[i] + '">' + curcodeItems[i] + '</option>';
         }
         $("select#cmbcurr").html(optionscurr);
         funRoundRate(currateItems,"currate");
       } else {
         optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
         $("select#cmbcurr").html(optionscurr);
         funRoundRate(currateItems,"currate");
         $('#currate').attr('readonly', true);
       }
     }
   }
   x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchaseorderdate").value ,true);
   x.send();
}
function getRatevalue(angel){
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
     if (x.readyState==4 && x.status==200){
       var items= x.responseText;
       funRoundRate(items,"currate");
     }
   }
   x.open("GET","getRateTo.jsp?curr="+a,true);
   x.send();
}
function combochange(){
   if($('#cmbcurrval').val()!=""){ $('#cmbcurr').val($('#cmbcurrval').val()); }
   if($('#acctypeval').val()!=""){ $('#acctype').val($('#acctypeval').val()); }
}
function setValues() {
    if($('#hidnipurchaseorderdate').val()){
        $("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
    }
    if($('#hiddeliverydate').val()){
        $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
    }
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0){
        var indexval1 = document.getElementById("masterdoc_no").value;
        $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
    }
    if($('#msg').val()!=""){ $.messager.alert('Message',$('#msg').val()); }
    combochange();
    document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    funSetlabel();
}
function funPrintBtn(){
    if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
        var url=document.URL;
        var reurl=url.split("saveActionNipurOrder");
        $("#docno").prop("disabled", false);
        var brhid=<%= session.getAttribute("BRANCHID").toString()%>
        var dtype=$('#formdetailcode').val();
        var win= window.open(reurl[0]+"printniphOrder?docno="+document.getElementById("masterdoc_no").value+"&brhid="+brhid+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
    } else {
        $.messager.alert('Message','Select a Document....!','warning');
        return false;
    }
}
$(function(){
    $('#frmNipurchaseOrder').validate({
        rules: {
            delterms:{maxlength:200},
            purdesc:{maxlength:200},
            payterms:{maxlength:200},
            puraccid:{required:true}
        },
        messages: {
            delterms: {maxlength:"  Max 200 chars"},
            purdesc: {maxlength:"  Max 200 chars"},
            payterms: {maxlength:"  Max 200 chars"},
            puraccid: {required:" *"}
        }
    });
});
</script>
</head>

<body onLoad="getCurrencyIds();setValues();funinterstate();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />
    <br/>

    <!-- Top card -->
    <div class="form-card">
      <div class="card-header">Purchase Order</div>

      <div class="grid-row">

        <!-- DATE -->
        <div class="label-txt">Date</div>
        <div>
          <div id="nipurchaseorderdate" class="erp-input"></div>
          <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate"
                 value='<s:property value="hidnipurchaseorderdate"/>'>
        </div>

        <!-- DOC NO -->
        <div class="label-txt">Doc No</div>
        <div>
          <input type="text" name="docno" id="docno"
                 value='<s:property value="docno"/>'
                 readonly class="erp-input">
        </div>

        <!-- REF NO -->
        <div class="label-txt">Ref No</div>
        <div>
          <input type="text" name="refno" id="refno"
                 value='<s:property value="refno"/>'
                 class="erp-input">
        </div>

        <!-- VENDOR -->
        <div class="label-txt">Vendor</div>
        <div style="display:flex;gap:8px;">
            <input type="hidden" name="acctype" id="acctype" 
                   value='<s:property value="acctype"/>'>

            <input type="text" name="puraccid" id="puraccid"
                   placeholder="Press F3 To Search"
                   value='<s:property value="puraccid"/>'
                   class="erp-input"
                   onKeyDown="getaccountdetails(event);">

            <input type="text" id="puraccname" name="puraccname"
                   value='<s:property value="puraccname"/>'
                   class="erp-input">
        </div>

        <!-- CURRENCY -->
        <div class="label-txt">Currency</div>
        <div>
          <select name="cmbcurr" id="cmbcurr" class="erp-select">
            <option value="-1">--Select--</option>
          </select>
        </div>

        <!-- RATE -->
        <div class="label-txt">Rate</div>
        <div>
          <input type="text" name="currate" id="currate"
                 value='<s:property value="currate"/>'
                 class="erp-input">
        </div>

        <!-- DELIVERY DATE -->
        <div class="label-txt">Del Date</div>
        <div>
          <div id="deliverydate" class="erp-input"></div>
          <input type="hidden" name="hiddeliverydate" id="hiddeliverydate"
                 value='<s:property value="hiddeliverydate"/>'>
        </div>

        <!-- DELIVERY TERMS -->
        <div class="label-txt">Del Terms</div>
        <div style="display:flex;gap:10px;align-items:center;">
          <input type="text" name="delterms" id="delterms"
                 value='<s:property value="delterms"/>'
                 class="erp-input" style="width:60%;">

          <label style="font-weight:600;color:#1a3c6b;">Bill Type</label>
          <input type="text" id="txtproducttype" name="txtproducttype"
                 placeholder="Press F3 for Search"
                 value='<s:property value="txtproducttype"/>'
                 class="erp-input" onKeyDown="getProdType(event);"
                 style="width:160px;">
        </div>

        <!-- PAY TERMS -->
        <div class="label-txt">Pay Terms</div>
        <div>
          <input type="text" name="payterms" id="payterms"
                 value='<s:property value="payterms"/>'
                 class="erp-input">
        </div>

<div class="label-txt">Description</div>
<div class="desc-row">
  <input type="text" name="purdesc" id="purdesc"
         class="erp-input desc-small"
         value='<s:property value="purdesc"/>'>
</div>

      </div><!-- grid-row -->

    </div><!-- form-card -->

    <!-- ITEM DETAILS -->
    <div class="form-card">
      <div class="card-header">Item Details</div>
      <div id="descdetail" class="hidden-scrollbar cr-table">
        <jsp:include page="descgridDetails.jsp"></jsp:include>
      </div>
    </div>

    <!-- Hidden fields -->
    <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
    <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
    <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>
    <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>
    <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>
    <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>
    <input type="hidden" id="validates" name="validates" value='<s:property value="validates"/>'/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="taxpers" name="taxpers" value='<s:property value="taxpers"/>'/>
    <input type="hidden" id="taxaccount" name="taxaccount" value='<s:property value="taxaccount"/>'/>
    <input type="hidden" id="hideproducttype" name="hideproducttype" value='<s:property value="hideproducttype"/>'/>

</form>

<!-- Popups -->
<div id="accountSearchwindow"><div></div></div>
<div id="typesearchwindow"><div></div></div>

</div><!-- mainBG -->

</body>

</html>
