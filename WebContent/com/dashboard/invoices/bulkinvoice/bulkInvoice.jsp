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

        /* Tables inside Cards */
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
            width: 80px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select,
        .filter-table input[type="text"],
        .filter-table select {
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

        /* Readonly / disabled look */
        input[readonly], input:disabled, 
        .filter-table input[readonly], 
        .filter-table input:disabled {
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed !important;
            cursor: default;
        }

        /* Checkbox & Radio styling */
        input[type="radio"], input[type="checkbox"] {
            margin: 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

        .checkbox-wrap {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 12px;
            font-weight: 600;
            color: #4e5e71;
            cursor: pointer;
        }

        .radio-group {
            display: flex;
            justify-content: flex-start;
            gap: 15px;
            font-size: 12px;
            font-weight: 600;
            color: #4e5e71;
        }

        .radio-group label {
            display: flex;
            align-items: center;
            gap: 4px;
            cursor: pointer;
        }

        /* jqx date/time containers */
        #periodupto {
            width: 100%;
        }

        /* ===== BUTTONS ===== */
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
            transition: background 0.2s;
            text-align: center;
            width: 100%;
        }

        .btn-submit:hover {
            background: #1d4ed8 !important;
        }

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            justify-content: center;
            margin-top: 15px;
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

        .grid-content-container {
            flex: 1;
            padding: 15px;
            overflow: auto;
            box-sizing: border-box;
            position: relative;
        }

        /* Loader Positioning */
        #PleaseWait, #imgdiv {
            position: absolute !important;
            z-index: 1002;
            top: 50% !important;
            left: 50% !important;
            transform: translate(-50%, -50%);
        }
        </style>

        <script type="text/javascript">
        $(document).ready(function () {
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../../../icons/31load.gif'/></div>");
            $("#overlay, #PleaseWait").hide();
            
            // Standardize jqxDateTimeInputs
            $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            $('#clientwindow').jqxWindow({ width: '62%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#clientwindow').jqxWindow('close');
            
            $('#projectwindow').jqxWindow({ width: '50%', height: '65%', maxHeight: '65%' ,maxWidth: '65%' , title: 'Project Search' , theme: 'energyblue', position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#projectwindow').jqxWindow('close');
            
            $('#client').dblclick(function(){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
            });
            
            $('#project').dblclick(function(){
                $('#projectwindow').jqxWindow('open');
                $('#projectwindow').jqxWindow('focus');
                projectSearchContent('projectSearchGrid.jsp?id=1');
            });
            
            document.getElementById("imgloading").style.display="none";
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    $('#periodupto').jqxDateTimeInput('val',items);
                }
            }
            x.open("GET","getLastDay.jsp?date="+$('#periodupto').jqxDateTimeInput('val'), true);
            x.send();
            
            $.get("../getInitData.jsp", function(data, status){
                data = JSON.parse(data);
                if(data.invfuturedate == "1"){
                    $('.tr-futuredate').show();
                } else {
                    $('.tr-futuredate').hide();
                }
            });
            
            $('#periodupto').on('change', function (event) {  
                if($('#chkfuturedate').is(':checked') == true){
                    var curdate = new Date();
                    var formdate = new Date($('#periodupto').jqxDateTimeInput('getDate'));
                    if(curdate.getMonth() != formdate.getMonth()){
                        $.messager.alert('Warning','Please choose a valid month');
                        return false;
                    }
                } else {
                    var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
                    if(docdateval == 0){
                        $('#periodupto').jqxDateTimeInput('focus');
                        return false;
                    }
                }
                
                var date = $('#periodupto').jqxDateTimeInput('val');
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if(items == "0"){
                            $.messager.alert('Warning','Date should be month end');
                            return false;
                        } else {
                            return true;
                        }
                    }
                }
                x.open("GET","checkMonthEnd.jsp?date="+date, true);
                x.send();
            });
            
            setAgmtType("RAG");
        });

        function getClient(event){
            var x = event.keyCode;
            if(x == 114){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
            }
        }

        function clientSearchContent(url) {
            $.get(url).done(function (data) {
                $('#clientwindow').jqxWindow('setContent', data);
            }); 
        }

        function projectSearchContent(url) {
            $.get(url).done(function (data) {
                $('#projectwindow').jqxWindow('setContent', data);
            }); 
        }

        function funreload(event) {
            if(document.getElementById("cmbbranch").value == "" || document.getElementById("cmbbranch").value == 'a'){
                $.messager.alert('Warning','Please Select Branch');
                return false;
            }
            
            if($('#cmbtype').val() == ''){
                $.messager.alert('Warning','Please Select Type');
                return false;
            }
            
            if($('#chkfuturedate').is(':checked') == true){
                var curdate = new Date();
                var formdate = new Date($('#periodupto').jqxDateTimeInput('getDate'));
                if(curdate.getMonth() != formdate.getMonth()){
                    $.messager.alert('Warning','Please choose a valid month');
                    return false;
                }
                var date = $('#periodupto').jqxDateTimeInput('val');
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if(items == "0"){
                            $.messager.alert('Warning','Date should be month end');
                            return false;
                        } else {
                            loadGridData();
                        }
                    }
                }
                x.open("GET","checkMonthEnd.jsp?date="+date, true);
                x.send();
            } else {
                var dateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
                if(dateval == 1){
                    var date = $('#periodupto').jqxDateTimeInput('val');
                    var x = new XMLHttpRequest();
                    x.onreadystatechange = function() {
                        if (x.readyState == 4 && x.status == 200) {
                            var items = x.responseText.trim();
                            if(items == "0"){
                                $.messager.alert('Warning','Date should be month end');
                                return false;
                            } else {
                                loadGridData();
                            }
                        }
                    }
                    x.open("GET","checkMonthEnd.jsp?date="+date, true);
                    x.send();
                }   
            }
        }

        function loadGridData() {
            $("#overlay, #PleaseWait").show(); 
            var branchvalue = document.getElementById("cmbbranch").value;
            var date1 = $('#periodupto').jqxDateTimeInput('getText');
            var client = document.getElementById("hidclient").value;
            var agmttype = '';
            var rpttype = '';
            
            if(document.getElementById("chkclient").checked == true){ rpttype = "CRM"; }
            else if(document.getElementById("chkproject").checked == true){ rpttype = "PRJ"; }
            
            if(document.getElementById("chkrental").checked == true){ agmttype = "RAG"; }
            else if(document.getElementById("chklease").checked == true){ agmttype = "LAG"; }
            
            var projectdocno = "";
            if($('#hidproject').val() != ''){ projectdocno = $('#hidproject').val(); }
            
            $('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?date1='+date1+'&branch='+branchvalue+'&client='+client+'&id=1&type='+agmttype+'&rpttype='+rpttype+'&projectdocno='+projectdocno);
        }

        function funCalculate(){
            // Retained as placeholder from original functionality
        }
            
        function funNotify(){
            var selectedrows = $('#agmtDetailGrid').jqxGrid('selectedrowindexes');
            if(selectedrows.length == 0){
                $.messager.alert('Warning','Please select valid documents');
                return false;
            }
            $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
                if (r){
                    var agmtarray = new Array();
                    for(var i=0; i<selectedrows.length; i++){
                        var rano = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rano');
                        var ratype = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'ratype');
                        var fromdate = $('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'fromdate');
                        var todate = $('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'todate');
                        var acno = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
                        var amount = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
                        var cldocno = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
                        var rentalsum = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rentalsum');
                        var accsum = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'accsum');
                        var datediff = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'datediff');
                        var brhid = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
                        var curid = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'curid');
                        var insurchg = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'insurchg');
                        var acname = $('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acname');
                        agmtarray.push(rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+acname);
                    }
                    document.getElementById("selectedagmt").value = agmtarray;
                    $('#mode').val('A');
                    $("#overlay, #PleaseWait").show();
                    document.getElementById("frmDashboardBulkInvoice").submit();
                }
            });
        }

        function setValues(){
            if($('#msg').val() != ""){
                $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
            }
        }

        function funExportBtn(){
            if(parseInt(window.parent.chkexportdata.value) == "1") {
                JSONToCSVCon(invoicedata, 'Lease Invoice', true);
            } else {
                $("#leaseInvoiceGrid").jqxGrid('exportdata', 'xls', 'Lease Invoice');
            }
        }

        function setAgmtType(value){
            if(document.getElementById("chkrental").checked == true){
                document.getElementById("hidchkagmttype").value = "RAG";
            } else if(document.getElementById("chklease").checked == true){
                document.getElementById("hidchkagmttype").value = "LAG";
            }
        }

        function getProject(){
            var x = event.keyCode;
            if(x == 114){
                $('#projectwindow').jqxWindow('open');
                $('#projectwindow').jqxWindow('focus');
                projectSearchContent('projectSearchGrid.jsp?id=1');
            }
        }

        function setReportType(value){
            // Placeholder maintained
        }

        function funClearData(){
            $('#leaseInvoiceGrid,#agmtDetailGrid').jqxGrid('clear');
            $('#project,#hidproject,#client,#hidclient').val('');
        }
        </script>
    </head>

    <body onload="getBranch();setValues();">
        <form id="frmDashboardBulkInvoice" action="saveDashboardBulkInvoice" method="post">
            <input type="hidden" id="selectedagmt" name="selectedagmt">
            
            <div id="mainBG" class="homeContent"> 
                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr class="tr-futuredate" hidden="true">
                                        <td colspan="2" align="right">
                                            <label class="checkbox-wrap" style="justify-content: flex-end;">
                                                <input type="checkbox" id="chkfuturedate" name="chkfuturedate">
                                                Future Date Invoicing
                                            </label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label-cell">Period Upto</td>
                                        <td>
                                            <div id="periodupto" name="periodupto"></div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <div class="radio-group" style="justify-content: center; padding: 5px 0;">
                                                <label>
                                                    <input type="radio" name="chkagmttype" id="chkrental" value="RAG" checked onchange="setAgmtType(value);">
                                                    Rental
                                                </label>
                                                <label>
                                                    <input type="radio" name="chkagmttype" id="chklease" value="LAG" onchange="setAgmtType(value);">
                                                    Lease
                                                </label>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2">
                                            <div class="radio-group" style="justify-content: center; padding: 5px 0;">
                                                <label>
                                                    <input type="radio" name="chkrpttype" id="chkclient" value="CRM" checked onchange="setReportType(value);">
                                                    Client
                                                </label>
                                                <label>
                                                    <input type="radio" name="chkrpttype" id="chkproject" value="PRJ" onchange="setReportType(value);">
                                                    Project
                                                </label>
                                            </div>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label-cell">Project</td>
                                        <td>
                                            <input type="text" name="project" id="project" readonly placeholder="Press F3 to Search" onkeydown="getProject(event);">
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="client"/>'>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select name="cmbtype" id="cmbtype">
                                                <option value="1">Month End</option>
                                                <option value="2">Period</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>

                                <div class="action-buttons">
                                    <button type="button" id="btncleardata" name="btncleardata" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                                        Clear
                                    </button>
                                    <button type="button" id="btninvoicesave" name="btninvoicesave" class="btn-submit" onclick="funNotify();">
                                        Generate
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (MAIN CONTENT) ================= -->
                    <div class="main-content-area">
                        <!-- Toolbar/Heading (Moved from Sidebar) -->
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>
                        
                        <div class="grid-content-container">
                            
                            <!-- Loader -->
                            <div id="imgdiv" style="display:none;">
                                <img id="imgloading" alt="" src="../../../../icons/31load.gif"/>
                            </div>

                            <!-- LEASE INVOICE GRID -->
                            <div id="leaseinvoicediv" style="margin-bottom:15px;">
                                <jsp:include page="leaseInvoiceGrid.jsp"></jsp:include>
                            </div>

                            <!-- AGREEMENT GRID -->
                            <div id="leaseagmtdiv">
                                <jsp:include page="agmtDetailGrid.jsp"></jsp:include>
                            </div>

                        </div>
                    </div>

                </div>

                <!-- HIDDEN FIELDS -->
                <div style="display:none;">
                    <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
                    <input type="hidden" name="hidproject" id="hidproject" value='<s:property value="hidproject"/>'>
                    <input type="hidden" name="hidchkagmttype" id="hidchkagmttype" value='<s:property value="hidchkagmttype"/>'>
                    <input type="hidden" name="hidclient" id="hidclient">
                    <input type="hidden" name="gridlength" id="gridlength">
                    <input type="hidden" name="invgridlength" id="invgridlength">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                </div>

                <!-- POPUPS -->
                <div id="clientwindow"><div></div></div>
                <div id="agmtwindow"><div></div></div>
                <div id="projectwindow"><div></div></div>

            </div>
        </form>
    </body>
</html>