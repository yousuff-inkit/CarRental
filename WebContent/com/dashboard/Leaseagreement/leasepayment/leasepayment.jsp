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
        #detlist, #rtariff {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>
        
        <script type="text/javascript">
            $(document).ready(function () {
                $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#clientwindow').jqxWindow('close');
                $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#fleetwindow').jqxWindow('close');
                $('#groupwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#groupwindow').jqxWindow('close');
                $('#brandwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#brandwindow').jqxWindow('close');
                $('#modelwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#modelwindow').jqxWindow('close');
                
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

                $('#clientname').dblclick(function(){
                    $('#clientwindow').jqxWindow('open');
                    clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
                });
                
                $('#fleet').dblclick(function(){
                    $('#fleetwindow').jqxWindow('open');
                    fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
                });
                
                $('#group').dblclick(function(){
                    $('#groupwindow').jqxWindow('open');
                    groupSearchContent('groupsearch.jsp?', $('#groupwindow')); 
                });
                
                $('#brand').dblclick(function(){
                    $('#brandwindow').jqxWindow('open');
                    brandSearchContent('brandsearch.jsp?', $('#brandwindow')); 
                });
                
                $('#model').dblclick(function(){
                    $('#modelwindow').jqxWindow('open');
                    modelSearchContent('modelsearch.jsp?', $('#modelwindow')); 
                }); 
            });

            function getmodel(event){
                var x= event.keyCode;
                if(x==114){
                    $('#modelwindow').jqxWindow('open');
                    modelSearchContent('modelsearch.jsp?', $('#modelwindow'));    
                }
            } 
            function modelSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#modelwindow').jqxWindow('open');
                    $('#modelwindow').jqxWindow('setContent', data);
                }); 
            } 

            function getbrand(event){
                var x= event.keyCode;
                if(x==114){
                    $('#brandwindow').jqxWindow('open');
                    brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    
                }
            } 
            function brandSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#brandwindow').jqxWindow('open');
                    $('#brandwindow').jqxWindow('setContent', data);
                }); 
            } 

            function getgroup(event){
                var x= event.keyCode;
                if(x==114){
                    $('#groupwindow').jqxWindow('open');
                    groupSearchContent('groupsearch.jsp?', $('#groupwindow'));    
                }
            } 
            function groupSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#groupwindow').jqxWindow('open');
                    $('#groupwindow').jqxWindow('setContent', data);
                }); 
            } 

            function getfleet(event){
                var x= event.keyCode;
                if(x==114){
                    $('#fleetwindow').jqxWindow('open');
                    fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    
                }
            } 
            function fleetSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#fleetwindow').jqxWindow('open');
                    $('#fleetwindow').jqxWindow('setContent', data);
                }); 
            } 

            function getclinfo(event){
                var x= event.keyCode;
                if(x==114){
                    $('#clientwindow').jqxWindow('open');
                    clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    
                }
            } 
            function clientSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#clientwindow').jqxWindow('open');
                    $('#clientwindow').jqxWindow('setContent', data);
                }); 
            } 

            function funreload(event) {
                var barchval = document.getElementById("cmbbranch").value;
                $("#overlay, #PleaseWait").show();
                $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val());
                disiem(); 
            }

            function funcleardata() {
                document.getElementById("cldocno").value="";
                document.getElementById("groupdoc").value="";
                document.getElementById("groupdoc").value="";
                document.getElementById("brandid").value="";
                document.getElementById("modelid").value="";
                document.getElementById("model").value="";
                document.getElementById("brand").value="";
                document.getElementById("group").value="";
                document.getElementById("fleet").value="";
                document.getElementById("clientname").value="";
                document.getElementById("status").value="0";
                document.getElementById("docnos").value="";
                document.getElementById("branchid").value="";
                
                if (document.getElementById("clientname").value == "") {
                    $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("model").value == "") {
                    $('#model').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("brand").value == "") {
                    $('#brand').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("group").value == "") {
                    $('#group').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("fleet").value == "") {
                    $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
                }
            }
                
            function funExportBtn(){
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(shotterm, 'LAG-Payment', true);
                } else {
                    $("#detailsgrid").jqxGrid('exportdata', 'xls', 'LAG-Payment');
                }
            }
                
            function disiem() {
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "mode","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "amount","");
                $('#jqxgridpayment').jqxGrid('setcellvalue', 0, "acode","");
                $('#jqxgridpayment').jqxGrid('setcellvalue', 0, "cardno","");
                $('#jqxgridpayment').jqxGrid('setcellvalue', 0, "expdate","");
                $('#jqxgridpayment').jqxGrid('setcellvalue', 0, "hidexpdate","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "card","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "cardtype","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "paytype","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "rano","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "odate","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "brhid","");
                $('#jqxgridpayment').jqxGrid('setcellvalue',0, "vocno","");
            }
        </script>
    </head>
    
    <body onload="getBranch();disiem()">
        <div id="mainBG" class="homeContent"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        <div class="filter-card">
                            <table class="filter-table">
                                <tr>
                                    <td class="label-cell">Status</td>
                                    <td>
                                        <select id="status" name="status">
                                            <option value="0">Open</option>
                                            <option value="1">Close</option>
                                            <option value="">All</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Client</td>
                                    <td>
                                        <input type="text" name="clientname" id="clientname"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getclinfo(event);" onclick="this.placeholder=''"
                                               value='<s:property value="clientname"/>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Fleet</td>
                                    <td>
                                        <input type="text" name="fleet" id="fleet"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getfleet(event)" onclick="this.placeholder=''"
                                               value='<s:property value="fleet"/>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Group</td>
                                    <td>
                                        <input type="text" name="group" id="group"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getgroup(event)" onclick="this.placeholder=''"
                                               value='<s:property value="group"/>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Brand</td>
                                    <td>
                                        <input type="text" name="brand" id="brand"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getbrand(event)" onclick="this.placeholder=''"
                                               value='<s:property value="brand"/>'>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="label-cell">Model</td>
                                    <td>
                                        <input type="text" name="model" id="model"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getmodel(event)" onclick="this.placeholder=''"
                                               value='<s:property value="model"/>'>
                                    </td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <input type="button" class="btn-submit btn-clear" name="clear" id="clear" value="Clear" onclick="funcleardata()">
                            </div>
                        </div>

                        <!-- HIDDEN FIELDS -->
                        <div style="display:none;">
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value=""></option>
                                <option value=""></option>
                            </select> 
                            <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                            <input type="hidden" name="groupdoc" id="groupdoc" value='<s:property value="groupdoc"/>'>
                            <input type="hidden" name="brandid" id="brandid" value='<s:property value="brandid"/>'>
                            <input type="hidden" name="modelid" id="modelid" value='<s:property value="modelid"/>'> 
                            <input type="hidden" name="docnos" id="docnos" value='<s:property value="docnos"/>'>
                            <input type="hidden" id="excessinsur" name="excessinsur" value='<s:property value="excessinsur"/>'>
                            <input type="hidden" name="normalinsu" id="normalinsu" value='<s:property value="normalinsu"/>'>
                            <input type="hidden" name="cdwinsu" id="cdwinsu" value='<s:property value="cdwinsu"/>'> 
                            <input type="hidden" name="supercdwinsu" id="supercdwinsu" value='<s:property value="supercdwinsu"/>'>
                            <input type="hidden" id="gridlength" name="gridlength">
                            <input type="hidden" id="branchid" name="branchid" value='<s:property value="branchid"/>'>
                            <div id='paychaaaaa' style="width: 100%; height: 80px;"></div>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRID) ================= -->
                <div class="main-content-area">
                    
                    <!-- Top Toolbar matching the To Be Released design -->
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <!-- Primary Grid -->
                        <div id="detlist">
                            <jsp:include page="detailsGrid.jsp"></jsp:include>
                        </div>
                        
                        <!-- Secondary Payment Grid -->
                        <div id="rtariff" style="margin-top: 15px;">
                            <jsp:include page="paymentgrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="clientwindow"><div></div></div>
            <div id="fleetwindow"><div></div></div>
            <div id="groupwindow"><div></div></div>
            <div id="brandwindow"><div></div></div>
            <div id="modelwindow"><div></div></div>
            <div id="usersearchwindow"><div></div></div>
            
        </div>
    </body>
</html>