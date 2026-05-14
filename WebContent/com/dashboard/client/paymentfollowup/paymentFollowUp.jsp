<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit, .myButton {
    flex: 1;
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}
/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.sidebar-filters label.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script> 

<script type="text/javascript">
$(document).ready(function () {
     // Standardized height to 24px and width to 100%
     $("#uptodate, #followupdate, #date").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
     
     $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#accountDetailsWindow').jqxWindow('close');
    
     $('#uptodate').jqxDateTimeInput({disabled: true});
    
     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
     $('#txtclientaccount').dblclick(function(){
         accountsSearchContent('clientAccountDetailsSearch.jsp');
     });
     $('#txtcalculation').val(0);
});
    
function checkMultiCurrency() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var multicurrency = parseInt(items[0]);
            $("#hidmulticurrency").val(multicurrency);
        }
    }   
    x.open("GET", "checkMultiCurrency.jsp", true);
    x.send();
}

function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
        $.messager.alert('Message',' Enter Numbers Only ','warning');   
        return false;
    }
    return true;
}

function getProcess() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var srno  = items[0].split(",");
            var process = items[1].split(",");
            var optionsbranch = '<option value="" selected>-- Select -- </option>';
            for (var i = 0; i < process.length; i++) {
                optionsbranch += '<option value="' + srno[i].trim() + '">' + process[i] + '</option>';
            }
            $("select#cmbprocess").html(optionsbranch);
        }
    }
    x.open("GET","getProcess.jsp", true);
    x.send();
}

function getSalesPerson() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var salesagentItems = items[0].split(",");
            var salesagentIdItems = items[1].split(",");
            var optionssalesagent = '<option value="">--Select--</option>';
            for (var i = 0; i < salesagentItems.length; i++) {
                optionssalesagent += '<option value="' + salesagentIdItems[i] + '">' + salesagentItems[i] + '</option>';
            }
            $("select#cmbsalesperson").html(optionssalesagent);
            if ($('#hidcmbsalesperson').val() != null) {
                $('#cmbsalesperson').val($('#hidcmbsalesperson').val());
            }
        }
    }
    x.open("GET", "getSalesPerson.jsp", true);
    x.send();
}
  
function getCategory() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var categoryItems = items[0].split(",");
            var categoryIdItems = items[1].split(",");
            var optionscategory = '<option value="">--Select--</option>';
            for (var i = 0; i < categoryItems.length; i++) {
                optionscategory += '<option value="' + categoryIdItems[i] + '">' + categoryItems[i] + '</option>';
            }
            $("select#cmbcategory").html(optionscategory);
            if ($('#hidcmbcategory').val() != null) {
                $('#cmbcategory').val($('#hidcmbcategory').val());
            }
        }
    }
    x.open("GET", "getCategory.jsp", true);
    x.send();
}

function getClientAccount(event){
    var x= event.keyCode;
    if(x==114){
        accountsSearchContent('clientAccountDetailsSearch.jsp');
    }
}
   
function disable(){
     $('#date').jqxDateTimeInput({ disabled: true});
     $('#cmbprocess').attr("disabled",true);
     $('#txtremarks').attr("readonly",true);
     $('#btnupdate').attr("disabled",true);
     $("#followUpDetailsGrid").jqxGrid('clear');
     $("#followUpDetailsGrid").jqxGrid("addrow", null, {}); 
     $("#followUpDetailsGrid").jqxGrid({ disabled: true});
}

function followupcheck(){
     if(document.getElementById("chckfollowup").checked){
         document.getElementById("hidchckfollowup").value = 1;
         $('#followupdate').jqxDateTimeInput({ disabled: false});
     }
     else{
         document.getElementById("hidchckfollowup").value = 0;
         $('#followupdate').jqxDateTimeInput({ disabled: true});
     }
 }

function funCalculate(){
    $("#overlay, #PleaseWait").show();
    $('#txtcalculation').val(1);
    $('#paymentFollowUp').jqxGrid('showcolumn', 'current');
    $('#paymentFollowUp').jqxGrid('showcolumn', 'salik');
    $('#paymentFollowUp').jqxGrid('showcolumn', 'traffic');   
    paymentFollowUpGriGridReload();
}

function paymentFollowUpGriGridReload(){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200) {
            var items = x.responseText.trim();
            var arrayitems=items.split(",");
            var rows=$('#paymentFollowUp').jqxGrid('getrows');
            for(var i=0;i<rows.length;i++){
                for(var j=0;j<arrayitems.length;j++){
                    var temp=arrayitems[j].split("###");
                    if(rows[i].cldocno==temp[0]){
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "current",temp[3]);
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "salik",temp[1]);
                        $('#paymentFollowUp').jqxGrid('setcellvalue', i, "traffic",temp[2]);
                    }
                    if(i==rows.length-1){
                        $("#overlay, #PleaseWait").hide();
                    }   
                }
            }
         }
    }
     x.open("GET","paymentGridReload.jsp",true);
     x.send();   
}

function funreload(event){
     var branchval = document.getElementById("cmbbranch").value;
     var uptodate = $('#uptodate').val();
     var clientaccount = $('#txtclientaccountdocno').val();
     var chkfollowup = $('#hidchckfollowup').val();
     var followupdate = $('#followupdate').val();
     var salesperson = $('#cmbsalesperson').val();
     var category = $('#cmbcategory').val();
     var amtrangefrm = $('#txtamtrangefrom').val();
     var amtrangeto = $('#txtamtrangeto').val();
     var clientstatus = $('#cmbclientstatus').val();
    
     $("#overlay, #PleaseWait").show();
     $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?clientaccount="+clientaccount+'&branchval='+branchval+'&uptodate='+uptodate+'&chkfollowup='+chkfollowup+'&followupdate='+followupdate+'&salesperson='+salesperson+'&category='+category+'&amtrangefrm='+amtrangefrm+'&amtrangeto='+amtrangeto+'&clientstatus='+clientstatus+'&check=1');
}

function funUpdate(event){
    var process = $('#cmbprocess').val();
    var processname = $("#cmbprocess option:selected").text().trim();
    var date =  $('#date').val();
    var branchid = $('#txtbranch').val();
    var remarks = $('#txtremarks').val();
    var docno = $('#txtdocno').val();
    var accountno = $('#txtacountno').val();
    var cldocno = $('#txtcldocno').val();
    
    if(process==''){
         $.messager.alert('Message','Choose a Process.','warning');
         return 0;
     }
     if(remarks==''){
         $.messager.alert('Message','Please Enter Remarks.','warning');   
         return 0;
     }
    
     $.messager.confirm('Message', 'Do you want to save changes?', function(r){
        if(r==false) {
            return false; 
        } else{
            saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno);    
        }
    });
}

function funOutStandingStatement(){
     var accno = $('#txtacountno').val();
    if(accno==''){
         $.messager.alert('Message','Please Choose a Client.','warning');
         return 0;
     }
    if ($("#txtacountno").val()!="") {
        var url=document.URL;
        var reurl=url.split("paymentFollowUp.jsp");
        $("#txtacountno").prop("disabled", false);
        var win= window.open(reurl[0]+"printOutstandingsStatement?atype=AR&acno="+document.getElementById("txtacountno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
     } else {
        $.messager.alert('Message','Account is Mandatory.','warning');
        return;
    }
}

function funRAWiseBalance(){
     var accno = $('#txtacountno').val();
    if(accno==''){
         $.messager.alert('Message','Please Choose a Client.','warning');
         return 0;
     }
    if ($("#txtacountno").val()!="") {
        var url=document.URL;
        var reurl=url.split("paymentFollowUp.jsp");
        $("#txtacountno").prop("disabled", false);
        var win= window.open(reurl[0]+"printRAWiseBalance?atype=AR&acno="+document.getElementById("txtacountno").value+'&branch='+document.getElementById("cmbbranch").value+'&uptoDate='+$("#uptodate").val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
     } else {
        $.messager.alert('Message','Account is Mandatory.','warning');
        return;
    }
}

function funSendingEmail() {  
    var email = document.getElementById("txtclientaccountemail").value;
    var res;var part1;var part2;var dotsplt;
    if(email.indexOf("@")>=0) {
        res = email.split('@');
        part1=res[0];
        part2=res[1];
        dotsplt=part2.split('.');
    }
    
   if ($("#txtacountno").val().trim()=="" || typeof($("#txtacountno").val().trim())=="undefined" || typeof($("#txtacountno").val().trim())=="NaN") {
         $('#txtacountno').val('');
         $.messager.alert('Message','Please Choose a Client/Supplier.','warning');
        return;
  } else  if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(email.indexOf("@")<0) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(email.split('@').length!=2) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(part1.length==0) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(part1.split(" ").length>2) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(part2.split(".").length<2) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(dotsplt[0].length==0 ) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
         $.messager.alert('Message','Email is not Configured Properly.','warning');
        return;
  } else {
        $("#overlay, #PleaseWait").show();
        $.ajaxFileUpload ({         
              url: 'printOutstandingsStatement.action?acno='+document.getElementById("txtacountno").value+'&atype=AR&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("txtbranch").value+'&uptoDate='+$("#uptodate").val()+'&email='+$('#txtclientaccountemail').val()+'&print=0',  
              secureuri:false,
              fileElementId:'file',
              dataType: 'string',
              success: function (data, status) {  
                   if(status=='success'){
                        $("#overlay, #PleaseWait").hide();
                        $.messager.alert('Message','E-Mail Send Successfully');
                   }
                   if(status=='error'){
                     $("#overlay, #PleaseWait").hide();
                     $.messager.alert('Message','E-Mail Sending failed');
                   }
                   $("#testImg").attr("src",data.message);
                   if(typeof(data.error) != 'undefined') {  
                       if(data.error != '') {  
                           alert(data.error);  
                       }else {  
                           alert(data.message);  
                       }  
                   }  
              },  
               error: function (data, status, e) {  
                  alert(e);  
              }  
          }) 
         return false;
  } 
}
    
function saveGridData(process,processname,date,branchid,docno,accountno,remarks,cldocno){
    var x=new XMLHttpRequest();
    x.onreadystatechange=function(){
        if (x.readyState==4 && x.status==200){
            var items=x.responseText;
            $('#cmbprocess').val('');
            $('#date').val(new Date());
            $('#txtbranch').val('');
            $('#txtremarks').val('');
            $('#txtdocno').val('');
            $('#txtacountno').val('');
            $('#txtcldocno').val('');
            $('#cmbclientstatus').val('');
            $('#txtclientaccount').val('');
            $('#txtclientname').val('');
            $('#txtclientaccountdocno').val('');
            
            if (document.getElementById("txtclientaccount").value == "") {
                $('#txtclientaccount').attr('placeholder', 'Press F3 to Search'); 
            }
            $.messager.alert('Message', ' Record Successfully Updated ', function(r){ });
            disable();
        }
    }
    x.open("GET","saveData.jsp?process="+process+"&processname="+processname+"&date="+date+"&branchid="+branchid+"&docno="+docno+"&accountno="+accountno+"&remarks="+remarks+"&cldocno="+cldocno,true);
    x.send();
}

function funExportBtn(){
     if(parseInt(window.parent.chkexportdata.value)=="1") {
        JSONToCSVCon(dataExcelExport, 'PaymentFollowUp', true);
     } else {
         $("#paymentFollowUp").jqxGrid('exportdata', 'xls', 'PaymentFollowUp');
     }
}

function getRawiseConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var method = x.responseText;
            if(method==0){
                document.getElementById("rawisebtndiv").style.display="none";
            }
        }
    }
    x.open("GET", "getRawiseConfig.jsp", true);
    x.send();
}

function getSmsConfig() {
    var x = new XMLHttpRequest();
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            var method = x.responseText.trim();
            $("#hidconfig").val(method);     
            if(parseInt(method)==0){
                document.getElementById("smsdiv").style.display="none";
                document.getElementById("paysmsdiv").style.display="none";
            }else if(parseInt(method)==1){  
                document.getElementById("paysmsdiv").style.display="none";   
            }
        }
    }
    x.open("GET", "getPfsmsConfig.jsp", true);
    x.send();
}

function funSendSms(id) {   
    var brhid=document.getElementById("txtbranch").value;
    var dtype="";
    var pdocno=document.getElementById("txtcldocno").value;   
    var mobno=document.getElementById("txtmobno").value;
    if($('#txtdocno').val()=="" || $('#txtdocno').val()==null){
        $.messager.alert("warning","Please select a Document");
        return false;
    }  
    if(parseInt(id)==1){
        dtype="BCPF";  
    }else if(parseInt(id)==2){
        dtype="BCPFR";     
    }
    var config = $("#hidconfig").val();
    var val=0;
    if(config.trim() == "2"){
       var rows = $('#followUpDetailsGrid').jqxGrid('getrows');
       for(var i=0;i<rows.length;i++){
            var chk = $('#followUpDetailsGrid').jqxGrid('getcellvalue',i,'fdate');
            console.log(chk)
            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != "" && chk != null){
                val = 1;  
                break;  
            }
       }
    }  
    if(config.trim() == "2" && val == 0){   
        $.messager.alert("warning","Followup is not done!!!");
        return false;
    }
     $("#overlay, #PleaseWait").show();
     $.ajaxFileUpload ({         
          url:"sendPaymentSms?brhid="+brhid+"&docno="+pdocno+"&dtype="+dtype+"&mobno="+mobno,  
          secureuri:false,
          fileElementId:'file',
          dataType: 'string',
          success: function (data, status) {  
               if(status=='success'){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','SMS Send Successfully');
               }
               if(status=='error'){
                 $("#overlay, #PleaseWait").hide();
                 $.messager.alert('Message','SMS Sending failed');
               }
          },  
           error: function (data, status, e) {  
              alert(e);  
          }  
      }) 
      return false;
  }
</script>
</head>
<body onload="getBranch();getProcess();disable();getSalesPerson();getCategory();followupcheck();getRawiseConfig();getSmsConfig();checkMultiCurrency();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width="330px" valign="top">
    <div class="master-container">
        <div class="sidebar-filters">

            <div class="sidebar-fixed-top">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="sidebar-scroll-content">
                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client</td>
                            <td>
                                <input type="text" id="txtclientaccount" name="txtclientaccount" readonly placeholder="Press F3 to Search" value='<s:property value="txtclientaccount"/>' onkeydown="getClientAccount(event);"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="text" id="txtclientname" name="txtclientname" readonly value='<s:property value="txtclientname"/>' style="margin-bottom:8px;"/>
                                <div style="display:flex; align-items:center; gap:8px;">
                                    <input type="checkbox" id="chckfollowup" name="chckfollowup" onchange="followupcheck();" onclick="$(this).attr('value', this.checked ? 1 : 0)" />
                                    <label class="branch">FollowUp</label>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="followupdate" name="followupdate" value='<s:property value="followupdate"/>'></div></td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Sales Person</td>
                            <td><select id="cmbsalesperson" name="cmbsalesperson"></select></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td><select id="cmbcategory" name="cmbcategory"></select></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Amt Range</td>
                            <td>
                                <div style="display:flex; align-items:center; gap:5px;">
                                    <input type="text" id="txtamtrangefrom" style="text-align: right;" onkeypress="return isNumber(event)" value='<s:property value="txtamtrangefrom"/>'/>
                                    <span>-</span>
                                    <input type="text" id="txtamtrangeto" style="text-align: right;" onkeypress="return isNumber(event)" value='<s:property value="txtamtrangeto"/>'/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Status</td>
                            <td>
                                <select id="cmbclientstatus" name="cmbclientstatus">
                                    <option value="">--Select--</option>
                                    <option value="1">On Hire</option>
                                    <option value="2">Off Hire</option>
                                    <option value="7">Over Due</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Process</td>
                            <td><select name="cmbprocess" id="cmbprocess"></select></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Date</td>
                            <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td><input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/></td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <button class="myButton" type="button" id="btnupdate" onclick="funUpdate(event);">
                        Update
                    </button>

                    <button class="myButton" type="button" id="btnIndividual" onclick="funOutStandingStatement();">
                        Outstanding Statement
                    </button>

                    <div id="rawisebtndiv">
                        <button class="myButton" type="button" id="btnRAWiseBalance" onclick="funRAWiseBalance();">
                            RA Wise Balance
                        </button>
                    </div>

                    <div id="smsdiv">
                        <button class="myButton" type="button" id="btnsms" onclick="funSendSms(1);">
                            Send SMS
                        </button>
                    </div>

                    <div id="paysmsdiv">
                        <button class="myButton" type="button" id="btnpaysms" onclick="funSendSms(2);">
                            Payment Reminder SMS
                        </button>
                    </div>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="txtclientaccountdocno" value='<s:property value="txtclientaccountdocno"/>'/>
                    <input type="hidden" id="txtclientaccountemail" value='<s:property value="txtclientaccountemail"/>'/>
                    <input type="hidden" id="hidchckfollowup" value='<s:property value="hidchckfollowup"/>'/>
                    <input type="hidden" id="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/>
                    <input type="hidden" id="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                    <input type="hidden" id="txtacountno" value='<s:property value="txtacountno"/>'/>      
                    <input type="hidden" id="txtdocno" value='<s:property value="txtdocno"/>'/>
                    <input type="hidden" id="txtbranch" value='<s:property value="txtbranch"/>'/>
                    <input type="hidden" id="txtmobno" value='<s:property value="txtmobno"/>'/>
                    <input type="hidden" id="txtcldocno" value='<s:property value="txtcldocno"/>'/> 
                    <input type="hidden" id="txtcalculation" value='<s:property value="txtcalculation"/>'/>
                    <input type="hidden" id="hidmulticurrency" value='0'/>
                    <input type="hidden" id="hidconfig" />
                </div>

            </div>
        </div>
    </div>
</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="paymentFollowUpDiv">
                <jsp:include page="paymentFollowUpGrid.jsp"></jsp:include>
            </div>
            
            <div style="height:15px;"></div>
            
            <div id="detailDiv">
                <jsp:include page="detailGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>

<div id="accountDetailsWindow"><div></div></div>

</body>
</html>