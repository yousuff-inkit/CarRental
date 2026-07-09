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
        #uptodate {
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
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../../../icons/31load.gif'/></div>");
            
            // Standardize jqxDateTimeInputs
            $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
        });
        
        function inspectionSearchContent(url) {
            $('#inspectionWindow').jqxWindow('focus'); 
            $.get(url).done(function (data) {
                $('#inspectionWindow').jqxWindow('setContent', data);
            }); 
        }
        
        function funreload(event){
            var branchval = document.getElementById("cmbbranch").value;
            var avgkm = document.getElementById("avgkm").value;
            var uptodate = $('#uptodate').val();
             
            if(avgkm == ""){
                $.messager.alert('Message','Please Enter Avg KM/Month','warning');
                return 0;
            }

            $("#overlay, #PleaseWait").show();
            $("#servicedueDiv").load("servicedueGrid.jsp?branchval="+branchval+'&avgkm='+avgkm+'&uptodate='+uptodate);
        }
        
        function funExportBtn(){
            $("#servicedueDiv").excelexportjs({
                containerid: "servicedueDiv", 
                datatype: 'json', 
                dataset: null, 
                gridId: "servicedueGrid", 
                columns: getColumns("servicedueGrid") ,   
                worksheetName:"Service Due List"
            });
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
                                    <td class="label-cell">Up To</td>
                                    <td>
                                        <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Avg KM/Month</td>
                                    <td>
                                        <input type="text" name="avgkm" id="avgkm" value='<s:property value="avgkm"/>'>
                                    </td>
                                </tr>
                            </table>
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
                        <div id="servicedueDiv">
                            <jsp:include page="servicedueGrid.jsp"></jsp:include>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </body>
</html>