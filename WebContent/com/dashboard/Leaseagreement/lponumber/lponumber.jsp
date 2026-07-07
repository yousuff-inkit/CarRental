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

        /* Fieldsets & Radios */
        fieldset {
            border: 1px solid #ccd6e0;
            border-radius: 6px;
            padding: 10px;
            margin-bottom: 12px;
            background: #fff;
        }

        legend {
            font-size: 11px;
            font-weight: bold;
            color: #4e5e71;
            padding: 0 5px;
            text-transform: uppercase;
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
        
        #detlist {
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
                $('#salesmanwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Salesman Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#salesmanwindow').jqxWindow('close');
                $('#lpowindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'MRA NO Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#lpowindow').jqxWindow('close');
                $('#catwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: ' Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
                $('#catwindow').jqxWindow('close');
                
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
                
                $('#clientname').dblclick(function(){
                    $('#clientwindow').jqxWindow('open');
                    clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
                });
                
                $('#catname').dblclick(function(){
                    $('#catwindow').jqxWindow('open');
                    catnameSearchContent('categorysearch.jsp?', $('#catwindow'));  
                });
                
                $('#fleet').dblclick(function(){
                    $('#fleetwindow').jqxWindow('open');
                    fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
                });

                $('#salesman').dblclick(function(){
                    $('#salesmanwindow').jqxWindow('open');
                    salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow')); 
                });
                
                $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
                $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
                
                var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
                $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
                
                $('#todate').on('change', function (event) {
                    var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                    var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
                    if(fromdates>todates){
                        $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                        return false;
                    }   
                });
            });

            function funExportBtn(){
                JSONToCSVCon(dataildata, 'Lease PO Number', true);
            }
             
            function getclcat(event){
                var x= event.keyCode;
                if(x==114){
                    $('#catwindow').jqxWindow('open');
                    catnameSearchContent('categorysearch.jsp?', $('#catwindow'));    
                }
            } 
             
            function catnameSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#catwindow').jqxWindow('open');
                    $('#catwindow').jqxWindow('setContent', data);
                }); 
            }  

            function getsalesman(event){
                var x= event.keyCode;
                if(x==114){
                    $('#salesmanwindow').jqxWindow('open');
                    salesmanSearchContent('salesmansearch.jsp?', $('#salesmanwindow'));    
                }
            } 

            function salesmanSearchContent(url) {
                $.get(url).done(function (data) {
                    $('#salesmanwindow').jqxWindow('open');
                    $('#salesmanwindow').jqxWindow('setContent', data);
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
                var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
                
                if(fromdates>todates){
                    $.messager.alert('Message','To Date Less Than From Date  ','warning');   
                    return false;
                } else {
                    var barchval = document.getElementById("cmbbranch").value;
                    var fromdate= $("#fromdate").val();
                    var todate= $("#todate").val(); 
                    $("#overlay, #PleaseWait").show();
                    $("#detlist").load("detailedGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&salesmandoc="+document.getElementById("salesmandoc").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val()+'&outchk='+$("#outchks").val()+'&inchk='+$("#inchks").val()+'&catid='+$("#catid").val());
                }
            }

            function getrentaltype() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function() {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        var rentaltype  = items.split(",");
                        var optionsrental = '<option value="" selected>-- Select -- </option>';
                        for (var i = 0; i < rentaltype.length; i++) {
                            optionsrental += '<option value="' + rentaltype[i].trim() + '">'
                                    + rentaltype[i] + '</option>';
                        }
                        $("select#rentaltype").html(optionsrental);
                        
                    }
                }
                x.open("GET","getrentaltypes.jsp", true);
                x.send();
            }

            function funcleardata() {
                document.getElementById("catid").value="";
                document.getElementById("cldocno").value="";
                document.getElementById("salesmandoc").value="";
                document.getElementById("salesman").value="";
                document.getElementById("salesmandoc").value="";
                document.getElementById("fleet").value="";
                document.getElementById("clientname").value="";
                document.getElementById("rentaltype").value="";
                document.getElementById("status").value="";
                document.getElementById("catname").value="";
                document.getElementById("ra_no").value="";
                
                if (document.getElementById("clientname").value == "") {
                    $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("ra_no").value == "") {
                    $('#ra_no').attr('placeholder', ''); 
                }
                if (document.getElementById("salesman").value == "") {
                    $('#salesman').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("fleet").value == "") {
                    $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
                }
                if (document.getElementById("catname").value == "") {
                    $('#catname').attr('placeholder', 'Press F3 TO Search'); 
                }
                $("#detailedGrid").jqxGrid('clear');
            }

            function funupdate() {
                if(document.getElementById("ra_no").value=="") {
                    $.messager.alert('Message',' select salesman ra_no ','warning');   
                    return 0;
                }
                if(document.getElementById("lpo").value=="") {
                    $.messager.alert('Message','select LPO NO ','warning');   
                    return 0;
                }
                
                var ra_no = document.getElementById("ra_no").value;
                var lpo = document.getElementById("lpo").value;
                var oldlpo = document.getElementById("oldlpo").value;

                $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                    if(r==false) {
                        return false; 
                    } else {
                        savegriddata(ra_no,lpo,oldlpo);	
                    }
                });
            }

            function savegriddata(ra_no,lpo,oldlpo) {
                var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                    if (x.readyState==4 && x.status==200) {
                        var items=x.responseText;
                        document.getElementById("ra_no").value="";
                        document.getElementById("lpo").value="";
                        document.getElementById("oldlpo").value="";
                          
                        $.messager.alert('Message', '  Record Successfully Updated ', function(r){});
                        funreload(event); 
                        $("#detailedGrid").jqxGrid('clear');
                        disitems();
                    }
                }
                x.open("GET","lposavedata.jsp?ra_no="+ra_no+"&lpo="+encodeURIComponent(lpo)+"&oldlpo="+encodeURIComponent(oldlpo), true);       
                x.send();
                document.getElementById("lpo").value="";
                if (document.getElementById("lpo").value == "") {
                    $('#lpo').attr('placeholder', 'Enter LPO No'); 
                }
                document.getElementById("ra_no").value="";
            }
        </script>
    </head>
    
    <body onload="getBranch();getrentaltype();">
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
                                    <td class="label-cell">Status</td>
                                    <td>
                                        <select id="status" name="status">
                                            <option value="">All</option>  
                                            <option value="0">Open</option>
                                            <option value="1">Close</option>  
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
                                    <td class="label-cell">Category</td>
                                    <td>
                                        <input type="text" name="catname" id="catname"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getclcat(event);" onclick="this.placeholder=''"
                                               value='<s:property value="catname"/>'>
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
                                    <td class="label-cell">Salesman</td>
                                    <td>
                                        <input type="text" name="salesman" id="salesman"
                                               placeholder="Press F3 TO Search" readonly
                                               onkeydown="getsalesman(event)" onclick="this.placeholder=''"
                                               value='<s:property value="salesman"/>'>
                                    </td>
                                </tr>
                            </table>

                            <div class="action-buttons">
                                <input type="button" class="btn-submit btn-clear" name="clear" id="clear" value="Clear" onclick="funcleardata()">
                            </div>
                        </div>
                        
                        <div class="filter-card">
                            <fieldset>
                                <legend>LPO NO change</legend>
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">LPO NO</td>
                                        <td>
                                            <input type="text" name="lpo" id="lpo" placeholder="Enter LPO No" value='<s:property value="lpo"/>'>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <input type="button" class="btn-submit" name="update" id="update" value="Update" onclick="funupdate()">
                                </div>
                            </fieldset>
                        </div>

                        <!-- HIDDEN FIELDS -->
                        <div style="display:none;">
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'></select>
                            <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                            <input type="hidden" name="salesmandoc" id="salesmandoc" value='<s:property value="salesmandoc"/>'>
                            <input type="hidden" name="catid" id="catid" value='<s:property value="catid"/>'>
                            <input type="hidden" name="ra_no" id="ra_no" value='<s:property value="ra_no"/>'>
                            <input type="hidden" name="oldlpo" id="oldlpo" value='<s:property value="oldlpo"/>'>
                        </div>

                    </div>
                </div>

                <!-- ================= RIGHT SIDE (GRID) ================= -->
                <div class="main-content-area">
                    
                    <!-- Top Toolbar placed properly above the grid -->
                    <div class="top-toolbar-container">
                        <jsp:include page="../../heading.jsp"></jsp:include>
                    </div>

                    <div class="grid-content-container">
                        <div id="detlist">
                            <jsp:include page="detailedGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="catwindow"><div></div></div>
            <div id="clientwindow"><div></div></div>
            <div id="fleetwindow"><div></div></div>
            <div id="salesmanwindow"><div></div></div>
            <div id="lpowindow"><div></div></div>
            
        </div>
    </body>
</html>