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

        /* Checkbox styling */
        input[type="checkbox"] {
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

        /* jqx date/time containers */
        #fromdate, #todate {
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
        #PleaseWait {
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
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: new Date()});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: new Date()});
            
            $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
            $('#clientDetailsWindow').jqxWindow('close');
            
            $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
            $('#agreementDetailsWindow').jqxWindow('close');
            
            $('#fromdate').on('change', function (event) {  
                var docdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
                if(docdateval==0){
                    $('#fromdate').jqxDateTimeInput('focus');
                    return false;
                }
            });
            
            $('#todate').on('change', function (event) {  
                var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
                if(docdateval==0){
                    $('#todate').jqxDateTimeInput('focus');
                    return false;
                }
            });
            
            $("#btnExcel").click(function() {
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(data1, 'To Be Invoiced Salik', true);
                } else {
                    $("#jqxNotInvoiced").jqxGrid('exportdata', 'xls', 'To Be Invoiced Salik');
                }
            }); 
             
            if(document.getElementById("mode").value==""){
                var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
                var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
                $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
            } 
             
            $('#agmtvocno').dblclick(function(){
                if($('#rentaltype').val()==""){
                    $.messager.alert('Message','Choose a Type.','warning');   
                    return false;
                }
                var branchval = document.getElementById("cmbbranch").value; 
                agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
            });
             
            $('#txtclientname').dblclick(function(){
                clientSearchContent('clientDetailsSearchGrid.jsp?id=1');
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
                clientSearchContent('clientDetailsSearchGrid.jsp?id=1');
            }
        }
            
        function getAgreement(event){
            var x = event.keyCode;
            if(x == 114){
                if($('#rentaltype').val()==""){
                    $.messager.alert('Message','Choose a Type.','warning');   
                    return false;
                }
                var branchval = document.getElementById("cmbbranch").value; 
                agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
            }
        }

        function funClearData(){
            $('#txtclientname').val(''); $('#agmtvocno').val(''); $('#txtcldocno').val(''); $('#rentaltype').val(''); $('#txtagreementno').val(''); $('#fromdate').val(new Date()); $('#todate').val(new Date());
            $('#cmbtype').val('');
            
            var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
            var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
            $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
                 
            if (document.getElementById("txtclientname").value == "") {
                $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
            }
            if (document.getElementById("txtagreementno").value == "") {
                $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
            }
        }
            
        function funreload(event){
            if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
                $.messager.alert('Warning','Please Select a Single Branch');
                return false;
            }
            var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
            if(docdateval1==0){
                $('#fromdate').jqxDateTimeInput('focus');
                return false;
            }
            var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
            if(docdateval==0){
                $('#todate').jqxDateTimeInput('focus');
                return false;
            }
            
            var branchval = document.getElementById("cmbbranch").value.trim();
            var fromdate = $('#fromdate').val();
            var todate = $('#todate').val();
            var cldocno = $('#txtcldocno').val();
            var rentaltype = $('#rentaltype').val();
            var agmtno = $('#txtagreementno').val();
            var type=$('#cmbtype').val();
            var agmtstatus=$('#cmbagmtstatus').val();
            
            $("#overlay, #PleaseWait").show();
            $("#notInvoicedDiv").load('notInvoicedGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&type='+type+'&agmtstatus='+agmtstatus);
        }
            
        function funSalikInvoicePrint(){
            var url=document.URL;
            var reurl=url.split("notInvoiced.jsp");
            var cldocno = $('#txtcldocno').val();
            var rentaltype = $('#rentaltype').val();
            var agmtno = $('#txtagreementno').val();
            var win= window.open(reurl[0]+"printSalikToBeInvoiced?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val()+'&agmtno='+agmtno+'&rentaltype='+rentaltype+'&cldocno='+cldocno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
            win.focus();
        }
            
        function setValues(){
            if($('#msg').val()!=""){
                $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
            }
        }
            
        function funGenerate(){
            var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
            if(docdateval1==0){
                $('#fromdate').jqxDateTimeInput('focus');
                return false;
            }
            var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
            if(docdateval==0){
                $('#todate').jqxDateTimeInput('focus');
                return false;
            }
            var rows=$('#jqxNotInvoiced').jqxGrid('getrows');
            if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
                $.messager.alert('Warning','Please Select a Single Branch');
                return false;
            }
            
            if(rows.length==0){
                $.messager.alert('Message','Not Valid Data','warning');
                return false;
            } else {
                $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
                    if (r){
                        document.getElementById("mode").value="A";
                        $("#overlay, #PleaseWait").show();
                        document.getElementById("frmNotInvoicedSalikClosedAgmt").submit();
                        funClearData();
                    }
                });
            }
        }
        </script>
    </head>

    <body onload="getBranch();setValues();">

        <form id="frmNotInvoicedSalikClosedAgmt" action="saveNotInvoicedSalikClosedAgmt" method="post">
            <div id="mainBG" class="homeContent">
                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
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
                                        <td class="label-cell">Agmt Status</td>
                                        <td>
                                            <select id="cmbagmtstatus" name="cmbagmtstatus">
                                                <option value="1">Closed</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt Type</td>
                                        <td>
                                            <select id="rentaltype" name="rentaltype">
                                                <option value="">--Select--</option>
                                                <option value="RAG">Rental</option>
                                                <option value="LAG">Lease</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agreement</td>
                                        <td>
                                            <input type="text" id="agmtvocno" name="agmtvocno" readonly placeholder="Press F3 to Search" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Tariff Type</td>
                                        <td>
                                            <select id="cmbtype" name="cmbtype">
                                                <option value="">--Select--</option>
                                                <option value="Daily">Daily</option>
                                                <option value="Weekly">Weekly</option>
                                                <option value="Monthly">Monthly</option>
                                                <option value="Lease">Lease</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>

                                <div class="action-buttons">
                                    <button type="button" id="clear" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                                        Clear
                                    </button>
                                    <button type="button" id="btngenerate" class="btn-submit" onclick="funGenerate();">
                                        Generate
                                    </button>
                                    <button type="button" id="btnSalikInvoicePrint" class="btn-submit" onclick="funSalikInvoicePrint();" style="background:#10b981 !important;">
                                        Print
                                    </button>
                                </div>
                            </div>

                            <!-- Hidden Fields -->
                            <div style="display:none;">
                                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
                                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRID) ================= -->
                    <div class="main-content-area">
                        <!-- Toolbar/Heading (Moved from Sidebar) -->
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>
                        
                        <div class="grid-content-container">
                            <div id="notInvoicedDiv">
                                <jsp:include page="notInvoicedGrid.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- POPUPS -->
                <div id="clientDetailsWindow"><div></div><div></div></div>
                <div id="agreementDetailsWindow"><div></div><div></div></div>

            </div>
        </form>

    </body>
</html>