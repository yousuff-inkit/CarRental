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
            width: 80px;
        }

        /* ===== UNIFORM 24px INPUTS & SELECTS ===== */
        input[type="text"], select, textarea,
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
        }

        /* Readonly / disabled look */
        input[readonly],
        input:disabled,
        .filter-table input[readonly],
        .filter-table input:disabled {
            background-color: #f3f6f9 !important;
            color: #555;
            border-color: #e1e8ed;
            cursor: pointer;
        }

        /* Placeholder styling */
        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
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
            transition: background 0.2s;
            text-align: center;
        }

        .btn-submit:hover {
            background: #1d4ed8;
        }

        .btn-clear {
            background: #64748b !important;
        }
        
        .btn-clear:hover {
            background: #475569 !important;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 15px;
            justify-content: center;
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
            background: #fff;
        }

        /* Misc */
        #masterDiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>
        
        <script type="text/javascript">
        $(document).ready(function () {
             
             // Uniform 24px date inputs
             $("#fromdate, #todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
             
             $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
             $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
             
             $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
             $('#clientDetailsWindow').jqxWindow('close');
             
             $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#agreementDetailsWindow').jqxWindow('close');
             
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
             $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
             
             $('#todate').on('change', function (event) {
                   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                   var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
                   if(fromdates>todates){
                       $.messager.alert('Message','To Date Less Than From Date ','warning');   
                       return false;
                   }    
             });
             
             $('#txtclientname').dblclick(function(){
                 clientSearchContent('clientDetailsSearchGrid.jsp');
             });
              
             $('#vocnos').dblclick(function(){
                 var branchval = document.getElementById("cmbbranch").value; 
                 agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
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
            var x= event.keyCode;
            if(x==114){
                clientSearchContent('clientDetailsSearchGrid.jsp');
            }
        }

        function getAgreement(event){
            var x= event.keyCode;
            if(x==114){
                var branchval = document.getElementById("cmbbranch").value; 
                agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
            }
        }

        function funClearData(){
             $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#vocnos').val('');$('#todate').val(new Date());$('#clstatuss').val('');
             var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
             $('#fromdate').val(onemounth);
             $('#todate').val(new Date());
             
             if (document.getElementById("txtclientname").value == "") {
                 $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
             }
             if (document.getElementById("vocnos").value == "") {
                 $('#vocnos').attr('placeholder', 'Press F3 to Search'); 
             }
        }

        function funreload(event){
             var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
             var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
             if(fromdates>todates){
                 $.messager.alert('Message','To Date Less Than From Date ','warning');   
                 return false;
             } else {
                 var branchval = document.getElementById("cmbbranch").value;
                 var fromdate = $('#fromdate').val();
                 var todate = $('#todate').val();
                 var cldocno = $('#txtcldocno').val();
                 var agmtno = $('#txtagreementno').val();
                 $("#overlay, #PleaseWait").show();
                 $("#masterDiv").load("detailsGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&agmtno='+agmtno);
             }
        }

        function chktype() { }

        function clearagno()
        {
            $('#txtagreementno').val('');
            $('#vocnos').val('');
        }

        function funExportBtn(){
              $("#detailsgrid").jqxGrid('exportdata', 'xls', 'Drivers Remove');
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
                                    <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">To</td>
                                    <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Client</td>
                                    <td>
                                        <input type="text" id="txtclientname" name="txtclientname" 
                                               readonly="readonly" placeholder="Press F3 to Search"  
                                               onkeydown="getClient(event);" 
                                               value='<s:property value="txtclientname"/>'/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Agreement</td>
                                    <td>
                                        <input type="text" id="vocnos" name="vocnos" 
                                               readonly="readonly" onfocus="chktype()" 
                                               placeholder="Press F3 to Search" 
                                               onkeydown="getAgreement(event);" 
                                               value='<s:property value="vocnos"/>'/>
                                    </td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <button type="button" class="btn-submit btn-clear" name="clear" id="clear" onclick="funClearData();">Clear</button>
                            </div>
                        </div>

                        <!-- HIDDEN FIELDS -->
                        <div style="display:none;">
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                            <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'/>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRID) ================= -->
                <div class="main-content-area">
                    
                    <!-- Top Toolbar appropriately placed above the grid -->
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="masterDiv">
                            <jsp:include page="detailsGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="clientDetailsWindow"><div></div><div></div></div>
            <div id="agreementDetailsWindow"><div></div><div></div></div>
            
        </div>
    </body>
</html>