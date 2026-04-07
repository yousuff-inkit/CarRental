<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
SCOPED UI: Strict Layout Matching Client/Vendor Master
* All rules are scoped inside .modern-ui to protect header.jsp *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding-top: 10px;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui textarea { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* * ROW LAYOUT: Matches the exact flow of the Client Master.
 * Elements align left, with consistent spacing, and DO NOT stretch.
 */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    margin-bottom: 12px; 
    flex-wrap: nowrap;
}

/* Grouping Label and Input */
.modern-ui .input-group {
    display: flex;
    align-items: center;
    margin-right: 25px; /* Consistent spacing between groups (e.g., Date and Ref No) */
}

/* Labels */
.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    width: 80px; /* Fixed label width for perfect vertical alignment */
    padding-right: 8px;
    flex-shrink: 0;
}

/* Exact Panel Styling from Screenshot */
.modern-ui .bordered-panel { 
    border: 1px solid #c5d3e0; 
    padding: 15px 15px 15px 10px; 
    background: #f4f7fb; 
    border-radius: 4px; 
    margin-bottom: 10px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
}

/* Validation Error override */
.modern-ui label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
    margin-left: 5px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
$(document).ready(function () { 
    /* FIXED DATE WIDTHS: explicitly set to match text inputs */   
    $("#nipurchaseorderdate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
    $("#deliverydate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
    
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

    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%', maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
         
    $('#typesearchwindow').jqxWindow({
        width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%',
        title : ' Search', position : { x : 700, y : 87 },
        theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27
    });
    $('#typesearchwindow').jqxWindow('close');
        
    $('#txtproducttype').dblclick(function(){
        typeFormSearchContent('typeFormSearchGrid.jsp'); 
    }); 

    $('#puraccid').dblclick(function(){
        if($('#mode').val()!= "view"){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?');
        }
    });   
});

function getaccountdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!="view"){
        if(x==114){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?');    
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

    if(parseInt(document.getElementById("validates").value)==1){
        var txtproducttype= document.getElementById('txtproducttype').value;
        if(txtproducttype==""){
            document.getElementById("errormsg").innerText=" Bill Type Is Required ";  
            document.getElementById('txtproducttype').focus();
            return 0;
        }
    }

    var refval= document.getElementById("nettotal").value;
    if(refval==""){
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

function funChkButton() {}

function funSearchLoad(){
    changeContent('mainsearch.jsp'); 
}

function getCurrencyIds(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
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
    x.open("GET","getRateTo.jsp?curr="+angel,true);
    x.send();
}
   
function combochange(){
    if($('#cmbcurrval').val()!="") {
        $('#cmbcurr').val($('#cmbcurrval').val());
    }
    if($('#acctypeval').val()!="") {
        $('#acctype').val($('#acctypeval').val());
    }
}

function setValues() {
    if($('#hidnipurchaseorderdate').val()){
        $("#nipurchaseorderdate").jqxDateTimeInput('val', $('#hidnipurchaseorderdate').val());
    }
    
    if($('#hiddeliverydate').val()){
        $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
    }
    
    var dis=document.getElementById("masterdoc_no").value;
    if(dis>0) {     
        var indexval1 = document.getElementById("masterdoc_no").value;   
        $("#descdetail").load("descgridDetails.jsp?nipurdoc="+indexval1);
    } 

    if($('#msg').val()!=""){
        $.messager.alert('Message',$('#msg').val());
    } 
        
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

<div class="homeContent hidden-scrollbar" data-type="background">
<form id="frmNipurchaseOrder" action="saveActionNipurOrder" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> 

<div class="modern-ui">
    <div class="bordered-panel">
        
        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right">Date</label>
                <div id="nipurchaseorderdate" name="nipurchaseorderdate" value='<s:property value="nipurchaseorderdate"/>'></div>
                <input type="hidden" name="hidnipurchaseorderdate" id="hidnipurchaseorderdate" value='<s:property value="hidnipurchaseorderdate"/>'>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Ref No</label>
                <input type="text" name="refno" id="refno" style="width: 250px;" value='<s:property value="refno"/>'>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Doc No</label>
                <input type="text" name="docno" id="docno" style="width: 150px;" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
            </div>
        </div>

        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right">Vendor</label>
                <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                <input type="text" name="puraccid" id="puraccid" placeholder="Press F3 To Search" value='<s:property value="puraccid"/>' onKeyDown="getaccountdetails(event);" style="width: 130px;">
                <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' style="width: 330px;">
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 50px;">Curr</label>
                <select name="cmbcurr" id="cmbcurr" value='<s:property value="cmbcurr"/>' onchange="getRatevalue(this.value);" style="width: 100px;">
                    <option value="-1">--Select--</option>
                </select>
                
                <label class="lbl-right" style="width: 40px;">Rate</label>
                <input type="text" name="currate" id="currate" value='<s:property value="currate"/>' style="width: 80px;">
            </div>
        </div>

        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right">Del Date</label>
                <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Del Terms</label>
                <input type="text" name="delterms" id="delterms" style="width: 350px;" value='<s:property value="delterms"/>'>
            </div>

            <div class="input-group">
                <label class="lbl-right" style="width: 60px;">Bill Type</label>
                <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3 for Search" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>' style="width: 250px;"/>
            </div>
        </div>

        <div class="field-row">
            <div class="input-group">
                <label class="lbl-right">Pay Terms</label>
                <input type="text" name="payterms" id="payterms" style="width: 780px;" value='<s:property value="payterms"/>'>
            </div>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <div class="input-group">
                <label class="lbl-right">Description</label>
                <input type="text" name="purdesc" id="purdesc" style="width: 780px;" value='<s:property value="purdesc"/>'>
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="descdetail"><jsp:include page="descgridDetails.jsp"></jsp:include></div>
    </div>

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
            
</div>
</form>

<div id="accountSearchwindow"><div></div></div>
<div id="typesearchwindow"><div></div></div>

</div>
</body>
</html>