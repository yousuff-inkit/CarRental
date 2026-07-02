<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 60px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.filter-table input[type="text"],
.filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
}

textarea#applyinfo {
    width: 100%;
    height: 90px !important;
    padding: 8px !important;
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #f3f6f9 !important;
    color: #333;
    font-family: inherit;
    resize: none;
    box-sizing: border-box;
    outline: none;
    margin-top: 5px;
}

select {
    padding-right: 24px; 
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

/* Readonly / disabled look */
input[readonly], input:disabled, select:disabled, textarea[readonly],
.filter-table input[readonly], .filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
    cursor: not-allowed;
}

/* jqx date/time containers */
div[id^="fromdate"], div[id^="todate"] {
    width: 100%;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover:not(:disabled) { background: #1d4ed8; }
.btn-submit:disabled {
    background: #cbd5e1 !important;
    cursor: not-allowed;
    color: #64748b !important;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
         // Standardized height to 24px and width to 100%
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
        
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         $('#txtaccid').dblclick(function(){
              accountsSearchContent('accountsDetailsSearch.jsp');
         });
         
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
    });
    
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
    
    function funreload(event){
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var branchval = document.getElementById("cmbbranch").value;
         var atype = $('#cmbtype').val();
         var accountno = $('#txtdocno').val();
        
         $('#txtreason').val('');$('#txttrno').val();
         $('#txtoutamount').val('');$('#txtdtype').val('');$('#txtbranchid').val('');$('#applyinfo').val(' ');
        
         if(accountno == ''){
             $.messager.alert('Message','Account is Mandatory.','warning');
             return 0;
         }
       
         $("#overlay, #PleaseWait").show();
        
         $("#appliedDiv").load("appliedGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&branchval="+branchval+'&atype='+atype+'&accountno='+accountno+'&check=1');
    }
    
    function clearAccountInfo(){
        $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
        $('#txttrno').val(' ');$('#txtoutamount').val(' ');$('#txtdtype').val(' ');
        $('#txtbranchid').val(' ');
        $('#txtreason').val(' ');
        $('#applyinfo').val(' ');
        $("#appliedDetailsGrid").jqxGrid({ disabled: true});$("#appliedDetailsGrid").jqxGrid('clear'); 
        $("#appliedDelete").jqxGrid('clear');
      
        if (document.getElementById("txtaccid").value == "") {
            $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }
    }
    
    function getAccTypeFrom(event){
        var x = event.keyCode;
        if(x == 114){
            accountsSearchContent('accountsDetailsSearch.jsp');
        }
    }
    
    function funExportBtn(){
        JSONToCSVCon(data, 'Applied Details', true); 
    } 
    
    function funPrint(){
        if ($("#txtaccid").val() != "") {
            var url = document.URL;
            var atype = $('#cmbtype').val();
            var branch = document.getElementById("cmbbranch").value;
            var reurl = url.split("appliedDetails.jsp");   
            var win = window.open(reurl[0]+"../../../../com/dashboard/audit/applieddetails/printAppliedDetail?acno="+document.getElementById("txtaccid").value+'&accname='+$('#txtaccname').val()+'&atype='+atype+'&branch='+branch+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$('#todate').val(),"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
         }
        else {
            $.messager.alert('Message','Account is Mandatory.','warning');
            return;
        }
    }
    
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAppliedDetails" action="saveAppliedDetails" method="post" autocomplete="off">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();">
                                    <option value="AR">AR</option>
                                    <option value="AP">AP</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text" id="txtaccid" name="txtaccid"
                                       placeholder="Press F3 to Search" readonly
                                       onkeydown="getAccTypeFrom(event);"
                                       value='<s:property value="txtaccid"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <input type="text" id="txtaccname" name="txtaccname"
                                       readonly tabindex="-1"
                                       value='<s:property value="txtaccname"/>'>

                                <input type="hidden" id="txtdocno" name="txtdocno"
                                       value='<s:property value="txtdocno"/>'>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card" style="text-align:center;">
                    <textarea id="applyinfo" name="applyinfo" readonly><s:property value="applyinfo"/></textarea>
                </div>

                <div style="display:none;">
                    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'>
                    <input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'>
                    <input type="hidden" id="txtdtype" name="txtdtype" value='<s:property value="txtdtype"/>'>
                    <input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'>
                    <input type="hidden" id="txtbranchid" name="txtbranchid" value='<s:property value="txtbranchid"/>'>
                </div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="appliedDiv">
                    <jsp:include page="appliedGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>
</form>

<div id="accountDetailsWindow">
    <div></div><div></div>
</div>

</div>
</body>
</html>