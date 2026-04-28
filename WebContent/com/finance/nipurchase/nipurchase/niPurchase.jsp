<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   SCOPED UI: Stable Modern Layout (Client Master Style)
========================================================= */

body, .homeContent {
    background: #ffffff !important; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    color: #222 !important;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e5e7eb; 
}

.erp-form-area {
    background-color: #fff;
    border: 1px solid #e1e4e8;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1100px; 
}

/* Master Input Heights - Stable 24px */
.erp-form-area input[type="text"],
.erp-form-area select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8 !important; 
    border-radius: 3px !important; 
    padding: 2px 6px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    box-sizing: border-box; 
    background-color: #fff !important; 
    color: #333 !important;
    width: 100%;
}

.erp-form-area input[type="text"]:focus,
.erp-form-area select:focus { 
    border-color: #007bff !important; 
    outline: none !important;
    background-color: #FFD6FF !important; /* Client Master Focus */
}

.erp-form-area input[readonly],
.erp-form-area input:disabled,
.erp-form-area select:disabled { 
    background-color: #f8f9fa !important; 
    color: #6b7280 !important;
}

.erp-form-area td {
    padding: 4px 5px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    color: #222 !important;
    vertical-align: middle;
}

.erp-form-area .lbl-right { 
    text-align: right; 
    color: #222 !important;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Data Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

#errormsg {
    color: red;
    font-weight: bold;
    font-size: 12px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
$(document).ready(function () {   
    /* EXACT DATE WIDTHS & HEIGHTS (NO CSS HACKS) */  
    $("#nipurchasedate").jqxDateTimeInput({  width: '100%', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#deliverydate").jqxDateTimeInput({  width: '100%', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});
    $("#invDate").jqxDateTimeInput({  width: '100%', height: '24px', formatString:"dd.MM.yyyy", theme: 'energyblue'});

    /* Force internal jqx styling to align with 24px height */
    setTimeout(function () {
        $("#nipurchasedate, #deliverydate, #invDate").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "padding": "0 6px", "box-sizing":"border-box"
        });
        $("#nipurchasedate, #deliverydate, #invDate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    $('#typesearchwindow').jqxWindow({ width : '25%', height : '58%', maxHeight : '70%', maxWidth : '45%', title : ' Search', position : { x : 700, y : 87 }, theme : 'energyblue', showCloseButton : true, keyboardCloseKey : 27 });
    $('#typesearchwindow').jqxWindow('close');
    
    $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
    $('#accounttypeSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '70%' , title: 'Account Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
    $('#accounttypeSearchwindow').jqxWindow('close');
    $('#costtpesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost Type Search' ,position: { x: 700, y:60 }, keyboardCloseKey: 27});
    $('#costtpesearchwndow').jqxWindow('close');   
    $('#costcodesearchwndow').jqxWindow({ width: '35%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Cost code Search' ,position: { x: 800, y: 60 }, keyboardCloseKey: 27});
    $('#costcodesearchwndow').jqxWindow('close');  
    $('#refnosearchwindow').jqxWindow({ width: '50%', height: '59%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Ref No Search' ,position: { x: 450, y: 40 }, keyboardCloseKey: 27});
    $('#refnosearchwindow').jqxWindow('close');  
    $('#nipurchslnosearch').jqxWindow({ width: '50%', height: '59%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 200, y: 60}, keyboardCloseKey: 27});
    $('#nipurchslnosearch').jqxWindow('close');

    $('#txtproducttype').dblclick(function(){ typeFormSearchContent('typeFormSearchGrid.jsp'); }); 
    
    $('#refno').dblclick(function(){
        if($('#mode').val()!= "view"){
            $('#refnosearchwindow').jqxWindow('open');
            refnoSearchContent('ordermainsearch.jsp?');
        }
    }); 

    $('#nipuraccid').dblclick(function(){
        if($('#mode').val()!= "view"){
            $('#accountSearchwindow').jqxWindow('open');
            accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());
        } 
    });   
});

function typeFormSearchContent(url) {
     document.getElementById("errormsg").innerText="";
    $('#typesearchwindow').jqxWindow('open');
    $.get(url).done(function(data) {
        $('#typesearchwindow').jqxWindow('setContent', data);
        $('#typesearchwindow').jqxWindow('bringToFront');
    });
}

function getProdType(event){
     var x= event.keyCode;
     if(x==114){ typeFormSearchContent('typeFormSearchGrid.jsp');  }
}

function getrefnosearch(event){
    var x= event.keyCode;
    if($('#mode').val()!= "view"){
         if(x==114){
          $('#refnosearchwindow').jqxWindow('open');
          refnoSearchContent('ordermainsearch.jsp?');   }
    }
}  

function refnoSearchContent(url) {
    $.get(url).done(function (data) {
        $('#refnosearchwindow').jqxWindow('open');
        $('#refnosearchwindow').jqxWindow('setContent', data);
    }); 
} 

function costcodeSearchContent(url) {
    $.get(url).done(function (data) {
        $('#costcodesearchwndow').jqxWindow('open');
        $('#costcodesearchwndow').jqxWindow('setContent', data);
    }); 
}  

function costSearchContent(url) {
    $.get(url).done(function (data) {
        $('#costtpesearchwndow').jqxWindow('open');
        $('#costtpesearchwndow').jqxWindow('setContent', data);
    }); 
} 
        
function CashSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accounttypeSearchwindow').jqxWindow('open');
        $('#accounttypeSearchwindow').jqxWindow('setContent', data);
    }); 
} 

function getaccountdetails(event){
    var x= event.keyCode;
    if($('#mode').val()!= "view"){
         if(x==114){
          $('#accountSearchwindow').jqxWindow('open');
          accountSearchContent('accountsDetailsFromGrid.jsp?dtype='+$('#acctype').val());   }
     } 
}  

function accountSearchContent(url) {
    $.get(url).done(function (data) {
        $('#accountSearchwindow').jqxWindow('setContent', data);
    }); 
}

function nipurhsaeslnocontent(url) {
    $.get(url).done(function (data) {
       $('#nipurchslnosearch').jqxWindow('open');
       $('#nipurchslnosearch').jqxWindow('setContent', data);
    }); 
} 
  
function funFocus(){ $('#nipurchasedate').jqxDateTimeInput('focus'); }

function funNotify(){   
    var nipurchasedate = $('#nipurchasedate').jqxDateTimeInput('getDate');
    var validdate=funDateInPeriod(nipurchasedate);
    if(validdate==0){ return 0; }
    
    var txtproducttype= document.getElementById('txtproducttype').value;
    if(txtproducttype==""){
        var selectedrows=$("#nidescdetailsGrid").jqxGrid('getrows');   
        for(var i=0 ; i < selectedrows.length ; i++){
          var tax=$("#nidescdetailsGrid").jqxGrid('getcellvalue',selectedrows[i],'taxper');
          if(parseFloat(tax)>0.0){
              $.messager.alert('Message','Select A Bill Type','warning'); 
              return 0;
          }
        }
    }
    
    if(parseInt(document.getElementById("validates").value)==1){
        var txtproducttype= document.getElementById('txtproducttype').value;
        if(txtproducttype==""){
             document.getElementById("errormsg").innerText=" Bill Type Is Required ";  
             document.getElementById('txtproducttype').focus();
             return 0;
        }
    }
            
    var rows=$('#nidescdetailsGrid').jqxGrid('getrows');
     var aa=0;
     for(var i=0;i<(rows.length);i++){
       var chk=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'headdoc');
       var qty=$('#nidescdetailsGrid').jqxGrid('getcellvalue',i,'qty');
       if(parseFloat(qty)>0){
          if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != "0"){
             aa=1;
          } else {
             aa=0;
          }
       }
     }
       
     if(parseInt(aa)==0) {
         document.getElementById("errormsg").innerText=" Please Select Account";
         return false;
     } 
    
    if( document.getElementById("nireftype").value=="NPO"){
      var refno= document.getElementById('refno').value;
         if(refno==""){
             document.getElementById("errormsg").innerText=" Select Ref NO";   
             document.getElementById('refno').focus();
             return 0;
         } else {
             document.getElementById("errormsg").innerText="";
         }
    }

    var purid= document.getElementById("nipuraccid").value;
    if(purid==""){
         document.getElementById("errormsg").innerText=" Select An Account";
         document.getElementById("nipuraccid").focus();
         return 0;
    } else {
       document.getElementById("errormsg").innerText="";
    } 
                        
   var invno= document.getElementById("invno").value;
    if(invno==""){
         document.getElementById("errormsg").innerText=" Enter Inv NO";
         document.getElementById("invno").focus();
         return 0;
    } else {
       document.getElementById("errormsg").innerText="";
    } 
                        
     var refval= document.getElementById("nettotal").value;
     if(refval==""){
         document.getElementById("errormsg").innerText="Net Total Empty";
         return 0;
    } else {
       document.getElementById("errormsg").innerText="";
    }

     var rows = $("#nidescdetailsGrid").jqxGrid('getrows');
        $('#nidescdetailslenght').val(rows.length);
       for(var i=0 ; i < rows.length ; i++){
       newTextBox = $(document.createElement("input"))
          .attr("type", "dil")
          .attr("id", "desctest"+i)
          .attr("name", "desctest"+i)
          .attr("hidden", "true"); 
       
       newTextBox.val(rows[i].srno+"::"+rows[i].qty+" :: "+rows[i].description+" :: "
              +rows[i].unitprice+" :: "+rows[i].total+" :: "+rows[i].discount+" :: "+rows[i].nettotal+" :: "+rows[i].nuprice+" :: "
              +rows[i].costtype+" :: "+rows[i].costcode+" :: "+rows[i].remarks+" :: "+rows[i].headdoc+" :: "+rows[i].taxper+" :: "+rows[i].taxperamt+" :: "+rows[i].taxamount+" :: "+rows[i].rowno+":: ");
       newTextBox.appendTo('form');
       }   
       
        var x =new XMLHttpRequest();
        x.onreadystatechange=function(){
        if(x.readyState==4 && x.status==200){
            var items=x.responseText;
            var chk=items.trim();
        if(parseInt(chk)==1){
            document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
            document.getElementById("invno").focus();
            return 0;
        } else {
             document.getElementById("errormsg").innerText="";
             document.getElementById("frmNipurchase").submit();
            }
        }
        }
        x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
        x.send();   
} 

function funchkinv() {
    var x =new XMLHttpRequest();
    x.onreadystatechange=function() {
        if(x.readyState==4 && x.status==200) {
            var items=x.responseText;
            var chk=items.trim();
        if(parseInt(chk)==1) {
            document.getElementById("errormsg").innerText="Inv No "+document.getElementById("invno").value+" Already Exists ";  
            document.getElementById("invno").focus();
            return 0;
        } else {
             document.getElementById("errormsg").innerText="";
             return 1;
        }
        }
    }
    x.open("GET","checkinvno.jsp?invno="+document.getElementById("invno").value+'&masterdocno='+document.getElementById("masterdoc_no").value+'&accdocno='+document.getElementById("accdocno").value);
    x.send();
}
        
function funchkforedit() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.trim();  
            if(parseInt(items)>0) {
                 $("#btnEdit").attr('disabled', true );
                 $("#btnDelete").attr('disabled', true ); 
            }
        }
    }
    x.open("GET", "linkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
    x.send();   
}

function funChkButton() {}
function funSearchLoad(){ changeContent('nipurchaseMastersearch.jsp'); }
function funReset(){}

function funReadOnly(){
    $('#frmNipurchase input').attr('readonly', true );
    $('#frmNipurchase select').attr('disabled', true );
     $('#nipurchasedate').jqxDateTimeInput({ disabled: true});
     $('#deliverydate').jqxDateTimeInput({ disabled: true});
     $('#invDate').jqxDateTimeInput({ disabled: true});
     $('#nireftype').attr('disabled', true);
      $('#cmbcurr').attr('disabled', true);
     $('#acctype').attr('disabled', true);
     $('#refno').attr('disabled', true);
       $('#refslno').attr('disabled', true);
       $('#interstate').attr('disabled', true);
        $("#nidescdetailsGrid").jqxGrid({ disabled: true});
         $('#txtproducttype').attr('disabled', true);
       combochange();
         getCurrencyIds();
}

function funRemoveReadOnly(){
    funinterstate();
    $('#frmNipurchase input').attr('readonly', false );
    $('#frmNipurchase select').attr('disabled', false );
     $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
     $('#deliverydate').jqxDateTimeInput({ disabled: false});
     $('#invDate').jqxDateTimeInput({ disabled: false});
     $('#interstate').attr('disabled', false);
     $('#txtproducttype').attr('readonly', true);
     $('#nireftype').attr('disabled', false);
      $('#cmbcurr').attr('disabled', false);
     $('#acctype').attr('disabled', false);
    $('#docno').attr('readonly', true);
      $('#nipuraccid').attr('readonly', true);
      $('#puraccname').attr('readonly', true);
      $('#refno').attr('disabled', true);
       $('#refslno').attr('disabled', true);
          $('#refno').attr('readonly', true);
          $('#refslno').attr('readonly', true);

        $("#nidescdetailsGrid").jqxGrid({ disabled: false});
        if ($("#mode").val() == "A") {
            $('#nipurchasedate').val(new Date());
            $('#deliverydate').val(new Date());
             $("#nidescdetailsGrid").jqxGrid('clear');
                $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
                $('#txtproducttype').attr('disabled', true);
                document.getElementById("validates").value=0;
                getCurrencyIds();
           }
        if ($("#mode").val() == "E") {
            getCurrencyIds();
          if($('#reftypeval').val()=="NPO") {
          $('#refno').attr('disabled', false);
           $('#refslno').attr('disabled', false);
          $('#refno').attr('readonly', true);
           $('#refslno').attr('readonly', true);
          }
           }
        if($('#mode').val()=='A'){
            $('#cmbbilltype').val('1');
        }
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
                  if($("#mode").val()=="A"){
                      funRoundRate(currateItems,"currate");
                  }
                  
                  if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
                         $('#cmbcurr').val($('#cmbcurrval').val()) ;
                        getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
                     } 
            } else {
                   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                   $("select#cmbcurr").html(optionscurr);
               if($("#mode").val()=="A"){
                  funRoundRate(currateItems,"currate");
               }
              
                  if ($('#cmbcurrval').val() != null && $('#cmbcurrval').val() != "") {
                         $('#cmbcurr').val($('#cmbcurrval').val()) ;
                        getRatevalue1($('#cmbcurrval').val(),$('#nipurchasedate').val());
                     } 
              }
        }
       }
       x.open("GET","getCurrencyId.jsp?date="+document.getElementById("nipurchasedate").value ,true);
        x.send();
}

function getRatevalue1(angel,date) {
   var x=new XMLHttpRequest();
   x.onreadystatechange=function(){
   if (x.readyState==4 && x.status==200) {
      var items= x.responseText;
   if($("#mode").val()=="A"){
         funRoundRate(items,"currate");  
   }
        } 
       }
   x.open("GET","getRateFrom.jsp?curr="+angel+"&date="+date,true);
    x.send();
}

function funrefdisslno() {
         $("#nidescdetailsGrid").jqxGrid('clear');
            $("#nidescdetailsGrid").jqxGrid('addrow', null, {});
        
       if($('#nireftype').val()=="NPO") {
        $('#refno').attr('disabled', false);
        $('#refslno').attr('disabled', false);
       } else {
       $('#refno').val(" ");
       $('#refslno').val(" ");
       $('#refno').attr('disabled', true);
       $('#refslno').attr('disabled', true);
       }
}

function combochange() {
       if($('#cmbcurrval').val()!="") {
       $('#cmbcurr').val($('#cmbcurrval').val());
       }
       if($('#acctypeval').val()!="") {
       $('#acctype').val($('#acctypeval').val());
       }
       if($('#reftypeval').val()!="") {
       $('#nireftype').val($('#reftypeval').val());
       
       if($('#reftypeval').val()=="NPO") {
       $('#refno').attr('disabled', false);
        $('#refslno').attr('disabled', false);
       $('#refno').attr('readonly', true);
        $('#refslno').attr('readonly', true);
       }
       }
}

function setValues() {
       combochange();
       getCurrencyIds();
      
       if($('#hidnipurchasedate').val()){
            $("#nipurchasedate").jqxDateTimeInput('val', $('#hidnipurchasedate').val());
        }
        
        if($('#hiddeliverydate').val()){
            $("#deliverydate").jqxDateTimeInput('val', $('#hiddeliverydate').val());
        }

        if($('#hidinvDate').val()){
            $("#invDate").jqxDateTimeInput('val', $('#hidinvDate').val());
        }

        var interstate=document.getElementById("hidinterstate").value;
        if(interstate>0){
            document.getElementById("interstate").checked=true;
        } else{
            document.getElementById("interstate").checked=false;
        }

        if($('#hidcmbbilltype').val!=""){
            $("#cmbbilltype").val($('#hidcmbbilltype').val());
        }
        
        var dis=document.getElementById("masterdoc_no").value;
        if(dis>0) {     
            funchkforedit();
         var indexval1 = document.getElementById("masterdoc_no").value;   
                 $("#nipurdetails").load("descgridDetails.jsp?nipurdoc="+indexval1);
             } 

         if($('#msg').val()!=""){
               $.messager.alert('Message',$('#msg').val());
              } 
         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }

   $(function(){
        $('#frmNipurchase').validate({
                rules: { 
                delterms:{maxlength:200},
                purdesc:{maxlength:200},
                payterms:{maxlength:200}
                 },
                 messages: {
                     delterms: {maxlength:"  Max 200 chars"},
                     purdesc: {maxlength:"  Max 200 chars"},
                     payterms: {maxlength:"  Max 200 chars"}
                 }
        });});

   function funPrintBtn(){
        if ($("#mode").val() !== "view" || $("#masterdoc_no").val() === "") {
            $.messager.alert('Message','Select a Document....!','warning');
            return false;
        }

        var baseUrl = document.URL.split("saveActionNipurchase")[0];
        var dtype   = $('#formdetailcode').val();
        var brhid   = <%= session.getAttribute("BRANCHID").toString() %>;

        var printUrl = baseUrl + "printniphs" + "?docno=" + $("#masterdoc_no").val() + "&dtype=" + dtype + "&brhid=" + brhid;
        openAndPrint(printUrl);
    }

   function openAndPrint(url) {
        var win = window.open(url, "_blank", "top=250,left=310,width=900,height=800,scrollbars=yes");

        if (win) {
            setTimeout(function () {
                win.focus();
                win.print();
                win.onafterprint = function () {
                    win.close();
                };
            }, 700);
        } else {
            $.messager.alert('Message','Popup blocked by browser','warning');
        }
    }
</script>
</head>
<body onLoad="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmNipurchase" action="saveActionNipurchase" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp" /> 

    <div class="erp-form-area">
        
        <span id="errormsg"></span>

        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="4%">Date</td>
                <td width="10%">
                    <div id="nipurchasedate" name="nipurchasedate" value='<s:property value="nipurchasedate"/>'></div>
                    <input type="hidden" name="hidnipurchasedate" id="hidnipurchasedate" value='<s:property value="hidnipurchasedate"/>'>
                </td>
                <td class="lbl-right" width="6%">Ref Type</td>
                <td width="8%">
                    <select name="nireftype" id="nireftype" value='<s:property value="nireftype"/>' onchange="funrefdisslno()">
                        <option value="DIR">DIR</option>
                        <option value="NPO">NPO</option>
                    </select>
                </td>
                <td class="lbl-right" width="5%">Ref No</td>
                <td width="12%">
                    <input type="text" name="refno" id="refno" placeholder="Press F3 To Search" value='<s:property value="refno"/>' onKeyDown="getrefnosearch(event);">
                </td>
                <td class="lbl-right" width="5%">Inv NO</td>
                <td width="10%">
                    <input type="text" id="invno" name="invno" onblur="funchkinv();" value='<s:property value="invno"/>'>
                </td>
                <td class="lbl-right" width="4%">Type</td>
                <td width="8%">
                    <select name="cmbbilltype" id="cmbbilltype" value='<s:property value="cmbbilltype"/>'>
                        <option value="1">VAT</option>
                        <option value="2">RCM</option>
                    </select>
                    <input type="hidden" id="hidcmbbilltype" name="hidcmbbilltype" value='<s:property value="hidcmbbilltype"/>'/>
                </td>
                <td class="lbl-right" width="6%">Inv Date</td>
                <td width="10%">
                    <div id="invDate" name="invDate" value='<s:property value="invDate"/>'></div>
                    <input type="hidden" id="hidinvDate" name="hidinvDate" value='<s:property value="hidinvDate"/>'>
                </td>
                <td class="lbl-right" width="5%">Doc No</td>
                <td width="7%">
                    <input type="text" name="docno" id="docno" tabindex="-1" value='<s:property value="docno"/>' readonly="readonly">
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="4%">Vendor</td>
                <td width="41%">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="30%">
                                <input type="hidden" name="acctype" id="acctype" value='<s:property value="acctype"/>'>
                                <input type="text" name="nipuraccid" id="nipuraccid" placeholder="Press F3 To Search" value='<s:property value="nipuraccid"/>' onKeyDown="getaccountdetails(event);">
                            </td>
                            <td width="2%"></td>
                            <td width="68%">
                                <input type="text" id="puraccname" name="puraccname" value='<s:property value="puraccname"/>' tabindex="-1" readonly>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="lbl-right" width="4%">Curr</td>
                <td width="8%">
                    <select name="cmbcurr" id="cmbcurr" style="pointer-events:none;" tabindex="-1" value='<s:property value="cmbcurr"/>' onchange="getRatevalue1(this.value,$('#nipurchasedate').val());">
                        <option value="-1">--Select--</option>
                    </select>
                </td>
                <td class="lbl-right" width="5%">Rate</td>
                <td width="8%">
                    <input type="text" name="currate" id="currate" value='<s:property value="currate"/>' style="text-align: right;" readonly tabindex="-1">
                </td>
                <td class="lbl-right" width="6%">Bill Type</td>
                <td width="24%">
                    <input type="text" id="txtproducttype" name="txtproducttype" placeholder="Press F3 for Search" onKeyDown="getProdType(event);" value='<s:property value="txtproducttype"/>'>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="4%">Del Date</td>
                <td width="10%">
                    <div id="deliverydate" name="deliverydate" value='<s:property value="deliverydate"/>'></div>
                    <input type="hidden" name="hiddeliverydate" id="hiddeliverydate" value='<s:property value="hiddeliverydate"/>'>
                </td>
                <td width="9%">
                    <div id="interdiv" style="display:flex; align-items:center;">
                        <input type="checkbox" name="interstate" id="interstate" value="interstate" value='<s:property value="interstate"/>' onclick="$(this).attr('value', this.checked ? 1 : 0);" style="width:auto; height:auto!important; margin-right:5px; margin-left: 5px;">
                        <label style="margin:0;">Interstate</label>
                    </div>
                </td>
                <td class="lbl-right" width="6%">Del Terms</td>
                <td width="71%">
                    <input type="text" name="delterms" id="delterms" value='<s:property value="delterms"/>'>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="4%">Pay Terms</td>
                <td width="96%">
                    <input type="text" name="payterms" id="payterms" value='<s:property value="payterms"/>'>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="4%">Description</td>
                <td width="96%">
                    <input type="text" name="purdesc" id="purdesc" value='<s:property value="purdesc"/>'>
                </td>
            </tr>
        </table>

    </div>

    <div class="grid-container">
        <div id="nipurdetails"><jsp:include page="descgridDetails.jsp"></jsp:include></div>
    </div>

    <div style="display:none;">
        <input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
        <input type="hidden" id="ordermasterdoc_no" name="ordermasterdoc_no" value='<s:property value="ordermasterdoc_no"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>   
        <input type="hidden" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>'/>
        <input type="hidden" id="rowval" name="rowval" value='<s:property value="rowval"/>'/>
        <input type="hidden" id="accdocno" name="accdocno" value='<s:property value="accdocno"/>'/>  
        <input type="hidden" id="descgridlenght" name="descgridlenght" value='<s:property value="descgridlenght"/>'/>   
        <input type="hidden" id="cmbcurrval" name="cmbcurrval" value='<s:property value="cmbcurrval"/>'/>   
        <input type="hidden" id="acctypeval" name="acctypeval" value='<s:property value="acctypeval"/>'/>  
        <input type="hidden" id="reftypeval" name="reftypeval" value='<s:property value="reftypeval"/>'/>  
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="taxpers" name="taxpers" value='<s:property value="taxpers"/>'/>
        <input type="hidden" id="taxaccount" name="taxaccount" value='<s:property value="taxaccount"/>'/>
        <input type="hidden" id="refslno" name="refslno" value='<s:property value="refslno"/>' >
        <input type="hidden" id="hidinterstate" name="hidinterstate" value='<s:property value="hidinterstate"/>'/>
        <input type="hidden" id="tarannumber" name="tarannumber" value='<s:property value="tarannumber"/>'/>
        <input type="hidden" id="costgropename" name="costgropename" value='<s:property value="costgropename"/>'/>
        <input type="hidden" id="nidescdetailslenght" name="nidescdetailslenght" value='<s:property value="nidescdetailslenght"/>'/>
        <input type="hidden" id="acctypegrid" name="acctypegrid" value='<s:property value="acctypegrid"/>'/>
        <input type="hidden" id="validates" name="validates" value='<s:property value="validates"/>'/>
        <span id="formdet"></span>
    </div>
            
</form>

<div id="accountSearchwindow"><div></div></div>
<div id="accounttypeSearchwindow"><div></div></div>
<div id="costtpesearchwndow"><div></div></div>
<div id="costcodesearchwndow"><div></div></div> 
<div id="refnosearchwindow"><div></div></div> 
<div id="nipurchslnosearch"><div></div></div> 
<div id="typesearchwindow"><div></div></div>

</div>
</body>
</html>