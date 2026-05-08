<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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
    width: 80px;
}

/* ===== UNIFORM 24px TEXT INPUTS & SELECTS ===== */
input[type="text"], select, textarea {
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
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
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
    cursor: pointer;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 8px;
    margin-top: 5px;
}

.btn-submit {
    flex: 1;
    height: 30px !important;            
    padding: 0 5px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    text-align: center;
    transition: all 0.2s ease;
    width: 100%;
}

.btn-submit:hover { background: #1d4ed8 !important; }

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
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:600px;'><img src='../../../../icons/31load.gif'/></div>"); 

    // Standardize jqxDateTimeInputs
    $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
    $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

    $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
    $('#clientDetailsWindow').jqxWindow('close');
    
    $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
    $('#agreementDetailsWindow').jqxWindow('close');
    
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
    
    $('#todate').on('change', function (event) {
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
        
        if(fromdates > todates){
            $.messager.alert('Message','To Date Less Than From Date  ','warning');   
            return false;
        }   
    });
    
    $('#txtclientname').dblclick(function(){
        clientSearchContent('clientDetailsSearchGrid.jsp');
    });
      
    $('#agmtvocno').dblclick(function(){
         if(document.getElementById("rentaltype").value == ""){
             $.messager.alert('Warning','Please Select Agreement Type');
             return false;
         }
         agreementSearchContent('agreementDetailsSearch.jsp'); 
    });
});

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#clientDetailsWindow').jqxWindow('setContent', data);
        $('#clientDetailsWindow').jqxWindow('bringToFront');
    }); 
}
    
function agreementSearchContent(url) {
    $('#agreementDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
        $('#agreementDetailsWindow').jqxWindow('setContent', data);
        $('#agreementDetailsWindow').jqxWindow('bringToFront');
    }); 
}
    
function getClient(event){
    var x = event.keyCode;
    if(x == 114){
        clientSearchContent('clientDetailsSearchGrid.jsp');
    }
}
    
function getAgreement(event){
    if(document.getElementById("rentaltype").value == ""){
        $.messager.alert('Warning','Please Select Agreement Type');
        return false;
    }
    var x = event.keyCode;
    if(x == 114){
        agreementSearchContent('agreementDetailsSearch.jsp');
    }
}

function funExportBtn(){
    $("#rentalInvoiceGrid").excelexportjs({
        containerid: "rentalInvoiceGrid",
        datatype: 'json',
        dataset: null,
        gridId: "rentalInvoiceGrid",
        columns: getColumns("rentalInvoiceGrid") ,
        worksheetName:"Grouped Invoice"
    }); 
}

function funClearData(){
    $('#txtclientname').val(''); $('#agmtvocno').val(''); $('#txtcldocno').val(''); $('#rentaltype').val(''); $('#txtagreementno').val(''); $('#todate').val(new Date()); $('#clstatuss').val('');
    
    var onemounth = new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
    $('#fromdate').jqxDateTimeInput('setDate', onemounth);
    $('#todate').jqxDateTimeInput('setDate', new Date());
     
    if (document.getElementById("txtclientname").value == "") {
        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
    }
    if (document.getElementById("txtagreementno").value == "") {
        $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
        $('#agmtvocno').attr('placeholder', 'Press F3 to Search');
    }
}
    
function funreload(event){
    var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
    var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
    
    if(fromdates > todates){
        $.messager.alert('Message','To Date Less Than From Date  ','warning');   
        return false;
    } else {
        var branchval = document.getElementById("cmbbranch").value;
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        var cldocno = $('#txtcldocno').val();
        var rentaltype = $('#rentaltype').val();
        var agmtno = $('#txtagreementno').val();
        var clstatuss = $('#clstatuss').val();
        
        $("#overlay, #PleaseWait").show();
        $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&cldocno=' + cldocno + '&rentaltype=' + rentaltype + '&agmtno=' + agmtno + '&clstatuss=' + clstatuss);
    }
}

function chktype() {
    if($('#rentaltype').val() == "") {
        $.messager.alert('Message','Select Type  ','warning');   
        document.getElementById("rentaltype").focus(); 
        return false;
    }
}
    
function clearagno() {
    $('#txtagreementno').val('');
    $('#agmtvocno').val('');
}

function funGroupPrint(){
    if(document.getElementById("txtcldocno").value == ""){
        $.messager.alert('Message','Client is Mandatory','warning');
        document.getElementById("txtcldocno").focus();
        return false;
    } else {
        var z = 0;
        var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
        if(rows.length > 0 && (rows[0].rano == "undefined" || rows[0].rano == null || rows[0].rano == "")){
            return false;
        }
        
        var selectedRecords = new Array();
        var selectedrows = $("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

        if(selectedrows.length == 0){
            $.messager.alert('Warning','Select an Invoice');
            return false;
        }
        document.getElementById("invgridlength").value = "";
        
        $.messager.confirm('Confirm', 'Do you want to Print Invoice?', function(r){
            if (r){
                var i = 0;
                for (i = 0; i < rows.length; i++) {
                    for(var j = 0; j < selectedrows.length; j++){
                        if(selectedrows[j] == i){
                            if(document.getElementById("invgridlength").value == ""){
                                document.getElementById("invgridlength").value = rows[i].doc_no;  
                            } else {
                                document.getElementById("invgridlength").value = document.getElementById("invgridlength").value + "," + rows[i].doc_no;
                            }
                            z++;
                        }
                    }
                    if(i == rows.length - 1){
                        var url = document.URL;
                        var reurl = url.split("groupedinvoice.jsp");
                        var win = window.open(reurl[0]+"printGroupedInvoice?cldocno="+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val(),"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes"); 
                        win.focus(); 
                    }
                }
            }
        });
    }
}

function funSendmail() {
    if(document.getElementById("txtcldocno").value == ""){
        $.messager.alert('Message','Client is Mandatory','warning');
        document.getElementById("txtcldocno").focus();
        return false;
    } else {
        var selectedRecords = new Array();
        var selectedrows = $("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

        if(selectedrows.length == 0){
            $.messager.alert('Warning','Select an Invoice');
            return false;
        }
        
        var z = 0;
        var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
        if(rows.length > 0 && (rows[0].rano == "undefined" || rows[0].rano == null || rows[0].rano == "")){
            return false;
        }

        if(document.getElementById("email").value == "") {
            document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
            return 0;
        }
        
        $("#overlay, #PleaseWait").show();
        document.getElementById("invgridlength").value = "";
        
        $.messager.confirm('Confirm', 'Do you want to Send this Invoice?', function(r){
            if (r){
                var i = 0;
                for (i = 0; i < rows.length; i++) {
                    for(var j = 0; j < selectedrows.length; j++){
                        if(selectedrows[j] == i){
                            if(document.getElementById("invgridlength").value == ""){
                                document.getElementById("invgridlength").value = rows[i].doc_no;  
                            } else {
                                document.getElementById("invgridlength").value = document.getElementById("invgridlength").value + "," + rows[i].doc_no;
                            }
                            z++;
                        }
                    }
                    if(i == rows.length - 1){
                        sample();   
                    }
                }
            }
        });
    }
}
 
function sample() {  
    var frdate = document.getElementById("fromdate").value.trim();
    var todate = document.getElementById("todate").value.trim();
    var cldocno = document.getElementById("txtcldocno").value.trim();
    var clstatus = document.getElementById("clstatuss").value.trim();
    var retype = document.getElementById("rentaltype").value.trim();
    var agmtvocno = document.getElementById("agmtvocno").value.trim();
    var txtagmtno = document.getElementById("txtagreementno").value.trim();
    var recep = document.getElementById("email").value.trim();
    var formcode = document.getElementById("lbldetailname").innerText.trim();
    var branch = <%=session.getAttribute("BRANCHID").toString()%>;
    
    $.ajaxFileUpload({  
        url: 'grpdinvjspToPdf.action?cldocno='+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val()+"&recep="+recep+"&formcode="+formcode,  
        secureuri: false,
        fileElementId: 'file', 
        dataType: 'string',
        success: function (data, status) {  
            if(status == 'success'){
                $("#overlay, #PleaseWait").hide();
                $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show', style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
            }
            if(status == 'error'){
                $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show', style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
            }
            
            $("#testImg").attr("src",data.message);
            if(typeof(data.error) != 'undefined') {  
                if(data.error != '') {  
                    alert(data.error);  
                } else {  
                    alert(data.message);  
                }  
            }  
        },  
        error: function (data, status, e) {  
            alert(e);  
        }  
    }); 
    return false;
}
</script>
</head>

<body onload="getBranch();">
<form id="frmGroupedInvoice" action="saveGroupedInvoice">

<div id="mainBG" class="homeContent">
<div class='hidden-scrollbar'>
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="330px" valign="top">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">E-Mail</td>
                        <td>
                            <input type="text" id="email" name="email" readonly value='<s:property value="email"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="clstatuss" name="clstatuss">
                                <option value="">--Select--</option>
                                <option value="0">Open</option>
                                <option value="1">Close</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" onchange="clearagno();">
                                <option value="">--Select--</option>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agreement</td>
                        <td>
                            <input type="text" id="agmtvocno" name="agmtvocno" readonly placeholder="Press F3 to Search" onfocus="chktype()" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'>
                            <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'>
                        </td>
                    </tr>
                </table>

                <div class="button-group" style="margin-top: 15px;">
                    <button type="button" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                        Clear
                    </button>
                    <button type="button" class="btn-submit" onclick="funGroupPrint();" style="background:#10b981 !important;">
                        Print
                    </button>
                </div>
            </div>
            
            <!-- Hidden Fields -->
            <div style="display:none;">
                <input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'>
            </div>
            
        </div>
    </div>
</td>

<!-- ================= RIGHT SIDE (GRID) ================= -->
<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="notInvoicedDiv">
                <jsp:include page="rentalInvoiceGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</td>

</tr>
</table>

</div>
</div>
</div>
</form>

<!-- POPUPS -->
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="agreementDetailsWindow"><div></div><div></div></div>

</body>
</html>