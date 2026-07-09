<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
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
        #periodupto {
            width: 100%;
        }

        /* ===== BUTTONS ===== */
        .btn-submit {
            flex: 1;
            height: 30px !important;            
            padding: 0 12px !important;          
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
            
            // Standardize jqxDateTimeInputs
            $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            $('#periodupto').on('change', function (event) {  
                var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
                if(docdateval == 0){
                    $('#periodupto').jqxDateTimeInput('focus');
                    return false;
                }
            });
        });

        function funreload(event) {
            if(document.getElementById("cmbbranch").value == "" || document.getElementById("cmbbranch").value == 'a'){
                $.messager.alert('Warning','Please Select Branch');
                return false;
            }
            var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
            if(docdateval == 0){
                $('#periodupto').jqxDateTimeInput('focus');
                return false;
            }
            $("#overlay, #PleaseWait").show(); 
            var branch = $('#cmbbranch').val();
            var uptodate = $('#periodupto').jqxDateTimeInput('val');
            $('#invoicediv').load('invoiceGrid.jsp?branch='+branch+'&uptodate='+uptodate+'&mode=1');
        }

        function funCalculate(){
            var selectedrows = $('#invoiceGrid').jqxGrid('selectedrowindexes');
            if(selectedrows.length == 0){
                $.messager.alert('Warning','Please select agreements');
                return false;
            }
            var agmtarray = new Array();
            for(var i = 0; i < selectedrows.length; i++){
                agmtarray.push($('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno'));
            }
            var branch = $('#cmbbranch').val();
            var uptodate = $('#periodupto').jqxDateTimeInput('val');
            
            $('#overlay,#PleaseWait').show();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = JSON.parse(items);
                    $.each(items.calcdata, function( index, value ) {
                        for(var i = 0; i < selectedrows.length; i++){
                            if(value.agmtno == $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno')){
                                var totalamt = parseFloat(value.rent)+parseFloat(value.insurchg)+parseFloat(value.accchg)+parseFloat(value.salikamt)+parseFloat(value.saliksrvc)+parseFloat(value.trafficamt)+parseFloat(value.trafficsrvc);
                                totalamt = totalamt.toFixed(2);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'totalamt',totalamt);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'rentalamt',value.rent);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'accamt',value.accchg);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'insuramt',value.insurchg);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'salikamt',value.salikamt);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficamt',value.trafficamt);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'saliksrvc',value.saliksrvc);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficsrvc',value.trafficsrvc);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'salikcount',value.salikcount);
                                $('#invoiceGrid').jqxGrid('setcellvalue',selectedrows[i],'trafficcount',value.trafficcount);
                            }
                        }
                    });
                    $('#overlay,#PleaseWait').hide();
                }
            }
            x.open("GET","calculateAmount.jsp?agmtarray="+agmtarray+"&branch="+branch+"&uptodate="+uptodate, true);
            x.send();
        }

        function funNotify(){
            var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
            if(docdateval == 0){
                $('#periodupto').jqxDateTimeInput('focus');
                return false;
            }
            var selectedrows = $('#invoiceGrid').jqxGrid('selectedrowindexes');
            if(selectedrows.length == 0){
                $.messager.alert('Warning','Please select agreements');
                return false;
            }
            var testamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[0],'rentalamt');
            if(testamt == "" || testamt == "undefined" || testamt == null || typeof(testamt) == "undefined"){
                $.messager.alert('Warning','Please Calculate');
                return false;
            }
            
            var agmtarray = new Array();
            for(var i = 0; i < selectedrows.length; i++){
                var agmtno = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'agmtno');
                var totalamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'totalamt');
                var rentalamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'rentalamt');
                var accamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'accamt');
                var insuramt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'insuramt');
                var salikamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'salikamt');
                var saliksrvc = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'saliksrvc');
                var salikcount = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'salikcount');
                var trafficamt = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficamt');
                var trafficsrvc = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficsrvc');
                var trafficcount = $('#invoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'trafficcount');
                var fromdate = $('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'fromdate');
                var todate = $('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'todate');
                var agmtvocno = $('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'agmtvocno');
                var datediff = $('#invoiceGrid').jqxGrid('getcelltext',selectedrows[i],'datediff');
                
                agmtarray.push(agmtno+"::"+totalamt+"::"+rentalamt+"::"+accamt+"::"+insuramt+"::"+salikamt+"::"+saliksrvc+"::"+salikcount+"::"+trafficamt+"::"+trafficsrvc+"::"+trafficcount+"::"+datediff);
            }
            
            var branch = $('#cmbbranch').val();
            var uptodate = $('#periodupto').jqxDateTimeInput('val');
            
            $('#overlay,#PleaseWait').show();
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    items = JSON.parse(items);
                    if(items.errorstatus == "1"){
                        $.messager.alert('Message',items.errormsg);
                        $('#invoiceGrid').jqxGrid('clear');
                    } else {
                        $.messager.alert('Warning',items.errormsg);
                    }
                    $('#overlay,#PleaseWait').hide();
                }
            }
            x.open("GET","createProforma.jsp?agmtarray="+agmtarray+"&branch="+branch+"&uptodate="+uptodate, true);
            x.send();
        }

        function setValues(){
            if($('#msg').val() != ""){
                $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
            }
        }

        function funExportBtn(){
            // Excelexportjs implementation placeholder if needed
        }
        </script>
    </head>

    <body onload="getBranch();setValues();">
        <form id="frmProforma" action="saveProforma" method="post">
            <div id="mainBG" class="homeContent"> 
                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Period Upto</td>
                                        <td>
                                            <div id="periodupto" name="periodupto"></div>
                                        </td>
                                    </tr>
                                </table>

                                <div class="action-buttons">
                                    <input type="button" name="btninvoicesave" id="btninvoicesave" class="btn-submit" value="Generate" onclick="funNotify();">
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
                            <div id="invoicediv">
                                <jsp:include page="invoiceGrid.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>

                </div>
                
                <!-- HIDDEN FIELDS -->
                <div style="display:none;">
                    <input type="hidden" name="invgridlength" id="invgridlength">
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                </div>

            </div>
        </form>
    </body>
</html>