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
            var branchval = document.getElementById("cmbbranch").value;
            if(branchval.trim() == 'a'){
                $.messager.alert('Warning','Branch is Mandatory');
                document.getElementById("cmbbranch").focus();
                return false;
            }
            if($('#periodupto').jqxDateTimeInput('getDate') == null){
                $.messager.alert('Warning','Upto Date is Mandatory');
                $('#periodupto').jqxDateTimeInput('focus');
                return false;
            }
            var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
            if(docdateval == 0){
                $('#periodupto').jqxDateTimeInput('focus');
                return false;
            }
            
            $("#overlay, #PleaseWait").show();
            $('#extraserviceinvdiv').load('extraServiceInvGrid.jsp?branch='+branchval+'&uptodate='+$('#periodupto').jqxDateTimeInput('val')+'&temp=1');    
        }

        function funNotify(){
            var docdateval = funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
            if(docdateval == 0){
                $('#periodupto').jqxDateTimeInput('focus');
                return false;
            }
                
            var z = 0;
            var rows = $("#extraServiceInvGrid").jqxGrid('getrows');                    
        
            if(rows.length > 0 && (rows[0].doc_no == "undefined" || rows[0].doc_no == null || rows[0].doc_no == "")){
                return 0;
            }
            var selectedrows = $("#extraServiceInvGrid").jqxGrid('selectedrowindexes');
            if(selectedrows.length == 0){
                $.messager.alert('Warning','Select an Invoice');
                return 0;
            }
            
            $('#invgridlength').val(selectedrows.length);
            for (var i = 0; i < rows.length; i++) {
                for(var j = 0; j < selectedrows.length; j++){
                    if(selectedrows[j] == i){
                        newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "testinvoice"+z)
                            .attr("name", "testinvoice"+z)
                            .attr("hidden","true");
                            
                        newTextBox.val(rows[i].doc_no+"::"+rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].cldocno+"::"+rows[i].acno+"::"+rows[i].date);
                        newTextBox.appendTo('form');
                        z++;
                    }
                }
            }
            
            $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
                if (r){
                    document.getElementById("mode").value = 'A';
                    $("#overlay, #PleaseWait").show();
                    document.getElementById("frmExtraServiceInvoice").submit();
                }
            });
        }

        function setValues(){
            if($('#msg').val() != ""){
                $.messager.alert('Message',$('#msg').val());
            }
        }

        function funExportBtn(){
            if(parseInt(window.parent.chkexportdata.value) == "1") {
                JSONToCSVCon(exservicedata, 'Extra Services', true);
            } else {
                $("#extraServiceInvGrid").jqxGrid('exportdata', 'xls', 'Extra Services');
            }
        }
        </script>
    </head>

    <body onload="getBranch();setValues();">
        <form id="frmExtraServiceInvoice" action="saveExtraServiceInvoice">
            <div id="mainBG" class="homeContent"> 
                <div class="master-container">

                    <!-- ================= LEFT SIDEBAR ================= -->
                    <div class="sidebar-filters">
                        <div class="sidebar-scroll-content">
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">Period Upto</td>
                                        <td><div id="periodupto"></div></td>
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
                            <div id="extraserviceinvdiv">
                                <jsp:include page="extraServiceInvGrid.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- HIDDEN FIELDS -->
                <div style="display:none;">
                    <input type="hidden" name="invgridlength" id="invgridlength" value='<s:property value="invgridlength"/>'>
                    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                </div>

            </div>
        </form>
    </body>
</html>