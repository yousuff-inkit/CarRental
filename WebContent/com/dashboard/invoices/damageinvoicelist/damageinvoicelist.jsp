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
            width: 100%;
        }

        .btn-submit:hover {
            background: #1d4ed8 !important;
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
            $("#btnExcel").click(function() {
                if(parseInt(window.parent.chkexportdata.value) == "1") {
                    JSONToCSVCon(invoicedata, 'Damage Invoice List', true);
                } else {
                    $("#DamageInvoiceGrid").jqxGrid('exportdata', 'xls', 'Damage Invoice List');
                }
            }); 

            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../../../icons/31load.gif'/></div>"); 
            $("#overlay, #PleaseWait").hide();
            
            // Standardize jqxDateTimeInputs
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});

            $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
            $('#clientDetailsWindow').jqxWindow('close');
            
            $('#fleetwindow').jqxWindow({ width: '30%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27, theme: 'energyblue'});
            $('#fleetwindow').jqxWindow('close');  
            
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
                
            $('#fleetno').dblclick(function(){
                $('#fleetwindow').jqxWindow('open');
                fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
            });
            
            $('#txtclientname').dblclick(function(){
                clientSearchContent('clientDetailsSearchGrid.jsp');
            });
        });

        function clientSearchContent(url) {
            $('#clientDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
                $('#clientDetailsWindow').jqxWindow('setContent', data);
                $('#clientDetailsWindow').jqxWindow('bringToFront');
            }); 
        }

        function getClient(event){
            var x = event.keyCode;
            if(x == 114){
                clientSearchContent('clientDetailsSearchGrid.jsp');
            }
        }
            
        function fleetSearchContent(url) {
            $.get(url).done(function (data) {
                $('#fleetwindow').jqxWindow('open');
                $('#fleetwindow').jqxWindow('setContent', data);
            }); 
        } 

        function getfleetdata(event){
            var x = event.keyCode;
            if(x == 114){
                $('#fleetwindow').jqxWindow('open');
                fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));     
            }
        }

        function funExportBtn(){
            JSONToCSVConvertor(damageinvoiceexceldata, 'Damage Invoices List', true);
        }
              
        function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
            var CSV = '';    
            CSV += ReportTitle + '\r\n\n';

            if (ShowLabel) {
                var row = "";
                for (var index in arrData[0]) {
                    row += index + ',';
                }
                row = row.slice(0, -1);
                CSV += row + '\r\n';
            }
              
            for (var i = 0; i < arrData.length; i++) {
                var row = "";
                for (var index in arrData[i]) {
                    row += '"' + arrData[i][index] + '",';
                }
                row.slice(0, row.length - 1);
                CSV += row + '\r\n';
            }

            if (CSV == '') {        
                alert("Invalid data");
                return;
            }   
              
            var fileName = "";
            fileName += ReportTitle.replace(/ /g,"_");    
              
            var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
            var link = document.createElement("a");    
            link.href = uri;
            link.style = "visibility:hidden";
            link.download = fileName + ".csv";
              
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }

        function funClearData(){
            $('#txtclientname').val(''); $('#fleetno').val(''); $('#todate').val(new Date()); $('#txtcldocno').val('');
            
            var onemounth = new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
            $('#fromdate').jqxDateTimeInput('setDate', onemounth);
            $('#todate').jqxDateTimeInput('setDate', new Date());
             
            if (document.getElementById("txtclientname").value == "") {
                $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
            }
            if (document.getElementById("fleetno").value == "") {
                $('#fleetno').attr('placeholder', 'Press F3 to Search'); 
            }
        }
            
        function funreload(event){
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
            
            if(fromdates > todates){
                $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                return false;
            } else {
                var docdateval = funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
                if(docdateval == 0){
                    $('#todate').jqxDateTimeInput('focus');
                    return false;
                }
            
                var branchval = document.getElementById("cmbbranch").value;
                var fromdate = $('#fromdate').val();
                var todate = $('#todate').val();
                var cldocno = $('#txtcldocno').val();
                var fleetno = document.getElementById("fleetno").value;
                $("#overlay, #PleaseWait").show();
                $("#damageInvoicedDiv").load("damageinvoicelistGrid.jsp?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&cldocno=' + cldocno + '&fleetno=' + fleetno);
            }
        }
        </script>
    </head>

    <body onload="getBranch();">
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
                                    <td class="label-cell">Fleet</td>
                                    <td>
                                        <input type="text" id="fleetno" name="fleetno" readonly placeholder="Press F3 To Search" onkeydown="getfleetdata(event);" value='<s:property value="fleetno"/>'>
                                    </td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <button type="button" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                                    Clear
                                </button>
                            </div>
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
                        <div id="damageInvoicedDiv">
                            <jsp:include page="damageinvoicelistGrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>

            </div>

            <!-- POPUPS -->
            <div id="clientDetailsWindow"><div></div><div></div></div>
            <div id="fleetwindow"><div></div><div></div></div>

        </div>
    </body>
</html>