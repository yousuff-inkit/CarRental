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

        /* Ranges Table specific to this page */
        .range-table {
            width: 100%;
            border-spacing: 0 8px;
        }

        .range-table td {
            vertical-align: middle;
        }

        .range-table .range-input {
            width: 45px !important;
            text-align: center;
        }
        
        .range-table .amt-input {
            width: 100px !important;
            text-align: right;
        }

        .range-table .range-sep {
            font-size: 11px;
            color: #4e5e71;
            margin: 0 4px;
        }
        
        #listdiv {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
        }
        </style>
        
        <script type="text/javascript">
            $(document).ready(function () {
                $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

                $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
                $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
                
                var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
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
                if(parseInt(window.parent.chkexportdata.value)=="1") {
                    JSONToCSVCon(dat1, 'Termination Clauses', true);
                } else {
                    $("#leasetermination").jqxGrid('exportdata', 'xls', 'Termination Clauses');
                }
            }  

            function change1() { 
                if(document.getElementById("m2").value!="") {
                    document.getElementById("m3").value=parseInt(document.getElementById("m2").value)+1;
                } else {
                    document.getElementById("m3").value="";
                }
            }

            function change2() {
                if(document.getElementById("m4").value!="") {
                    document.getElementById("m5").value=parseInt(document.getElementById("m4").value)+1;
                } else {
                    document.getElementById("m5").value="";
                }
            }

            function change3() {
                if(document.getElementById("m6").value!="") {
                    document.getElementById("m7").value=parseInt(document.getElementById("m6").value)+1;
                } else {
                    document.getElementById("m7").value="";
                }
            }

            function change4() {
                if(document.getElementById("m8").value!="") {
                    document.getElementById("m9").value=parseInt(document.getElementById("m8").value)+1;
                } else {
                    document.getElementById("m9").value="";
                }
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
                    $("#listdiv").load("terminationlistGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);
                }
            }

            function isNumber(evt) {
                var iKeyCode = (evt.which) ? evt.which : evt.keyCode;
                if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
                    $.messager.alert('Message','Enter Numbers Only ','warning');     	
                    return false;
                }
                return true;
            }
             
            function funupdate() {
                if(document.getElementById("amt1").value=="") {
                    $.messager.alert('Message','Minimum Data Requirement','warning');     	
                    return false;
                }
        
                var m1=document.getElementById("m1").value;	
                var m2=document.getElementById("m2").value;
                var amt1=document.getElementById("amt1").value;
                
                var m3=document.getElementById("m3").value;	
                var m4=document.getElementById("m4").value;
                var amt2=document.getElementById("amt2").value;
                
                var m5=document.getElementById("m5").value;	
                var m6=document.getElementById("m6").value;
                var amt3=document.getElementById("amt3").value;
                
                var m7=document.getElementById("m7").value;	
                var m8=document.getElementById("m8").value;
                var amt4=document.getElementById("amt4").value;
                
                var m9=document.getElementById("m9").value;	
                var m10=document.getElementById("m10").value;
                var amt5=document.getElementById("amt5").value;
                
                $.messager.confirm('Message', 'Do you want to save changes?', function(r){
                    if(r==false) {
                        return false; 
                    } else {
                        delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5);
                    }
                });
            }

            function delsave(m1,m2,amt1,m3,m4,amt2,m5,m6,amt3,m7,m8,amt4,m9,m10,amt5) {
                var x=new XMLHttpRequest();
                x.onreadystatechange=function(){
                    if (x.readyState==4 && x.status==200) {
                        var items= x.responseText;
                        
                        document.getElementById("m1").value="";	
                        document.getElementById("m2").value="";
                        document.getElementById("amt1").value="";
                        
                        document.getElementById("m3").value="";	
                        document.getElementById("m4").value="";
                        document.getElementById("amt2").value="";
                        
                        document.getElementById("m5").value="";	
                        document.getElementById("m6").value="";
                        document.getElementById("amt3").value="";
                        
                        document.getElementById("m7").value="";	
                        document.getElementById("m8").value="";
                        document.getElementById("amt4").value="";
                        
                        document.getElementById("m9").value="";	
                        document.getElementById("m10").value="";
                        document.getElementById("amt5").value="";
                        
                        document.getElementById("ladocno").value="";
                        document.getElementById("lano").value="";
                        
                        disitems();
                        funreload(event);
                        $.messager.alert('Message', '  Record Successfully Updated ', function(r){});
                    }
                }
                x.open("GET","saveterminationdate.jsp?m1="+m1+"&m2="+m2+"&amt1="+amt1+"&m3="+m3+"&m4="+m4+"&amt2="+amt2+"&m5="+m5+"&m6="+m6+
                     "&amt3="+amt3+"&m7="+m7+"&m8="+m8+"&amt4="+amt4+"&m9="+m9+"&m10="+m10+"&amt5="+amt5+"&doc="+document.getElementById("ladocno").value,true);
                x.send();
            }
             
            function disitems() {
                $('#lano').attr("readonly",true);
                $('#m1').attr("readonly",true);
                $('#m2').attr("readonly",true);
                $('#amt1').attr("readonly",true);	
                
                $('#m3').attr("readonly",true);
                $('#m4').attr("readonly",true);
                $('#amt2').attr("readonly",true);	
                 
                $('#m5').attr("readonly",true);
                $('#m6').attr("readonly",true);
                $('#amt3').attr("readonly",true);	
                 
                $('#m7').attr("readonly",true);
                $('#m8').attr("readonly",true);
                $('#amt4').attr("readonly",true);	
                 
                $('#m9').attr("readonly",true);
                $('#m10').attr("readonly",true);
                $('#amt5').attr("readonly",true);	
                 
                $('#terUpdate').attr("disabled",true);	
            }
        </script>
    </head>
    
    <body onload="getBranch();disitems()">
        <div id="mainBG" class="homeContent" data-type="background"> 

            <div class="master-container">

                <!-- ================= LEFT SIDEBAR ================= -->
                <div class="sidebar-filters">
                    
                    <div class="sidebar-scroll-content">
                        <!-- Date Filter Card -->
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
                            </table>
                        </div>
                        
                        <!-- Termination Update Card -->
                        <div class="filter-card">
                            <fieldset>
                                <legend>Termination Clauses</legend>
                                <table class="filter-table" style="margin-bottom: 12px;">
                                    <tr>
                                        <td class="label-cell">LA NO</td>
                                        <td>
                                            <input type="text" id="lano" name="lano" value='<s:property value="lano"/>'>
                                        </td>
                                    </tr>
                                </table>
                                
                                <table class="range-table">
                                    <!-- ROW 1 -->
                                    <tr>
                                        <td style="white-space: nowrap;">
                                            <input type="text" name="m1" id="m1" class="range-input" value='<s:property value="m1"/>' onkeypress="return isNumber(event)">
                                            <span class="range-sep">to</span>
                                            <input type="text" name="m2" id="m2" class="range-input" value='<s:property value="m2"/>' onkeypress="return isNumber(event)" onblur="change1();">
                                        </td>
                                        <td>
                                            <input type="text" id="amt1" name="amt1" class="amt-input" value='<s:property value="amt1"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="return isNumber(event)">
                                        </td>
                                    </tr>

                                    <!-- ROW 2 -->
                                    <tr>
                                        <td style="white-space: nowrap;">
                                            <input type="text" name="m3" id="m3" class="range-input" value='<s:property value="m3"/>' readonly>
                                            <span class="range-sep">to</span>
                                            <input type="text" name="m4" id="m4" class="range-input" value='<s:property value="m4"/>' onblur="change2();">
                                        </td>
                                        <td>
                                            <input type="text" id="amt2" name="amt2" class="amt-input" value='<s:property value="amt2"/>'>
                                        </td>
                                    </tr>

                                    <!-- ROW 3 -->
                                    <tr>
                                        <td style="white-space: nowrap;">
                                            <input type="text" name="m5" id="m5" class="range-input" value='<s:property value="m5"/>' readonly>
                                            <span class="range-sep">to</span>
                                            <input type="text" name="m6" id="m6" class="range-input" value='<s:property value="m6"/>' onblur="change3();">
                                        </td>
                                        <td>
                                            <input type="text" id="amt3" name="amt3" class="amt-input" value='<s:property value="amt3"/>'>
                                        </td>
                                    </tr>

                                    <!-- ROW 4 -->
                                    <tr>
                                        <td style="white-space: nowrap;">
                                            <input type="text" name="m7" id="m7" class="range-input" value='<s:property value="m7"/>' readonly>
                                            <span class="range-sep">to</span>
                                            <input type="text" name="m8" id="m8" class="range-input" value='<s:property value="m8"/>' onblur="change4();">
                                        </td>
                                        <td>
                                            <input type="text" id="amt4" name="amt4" class="amt-input" value='<s:property value="amt4"/>'>
                                        </td>
                                    </tr>

                                    <!-- ROW 5 -->
                                    <tr>
                                        <td style="white-space: nowrap;">
                                            <input type="text" name="m9" id="m9" class="range-input" value='<s:property value="m9"/>' readonly>
                                            <span class="range-sep">to</span>
                                            <input type="text" name="m10" id="m10" class="range-input" value='<s:property value="m10"/>'>
                                        </td>
                                        <td>
                                            <input type="text" id="amt5" name="amt5" class="amt-input" value='<s:property value="amt5"/>'>
                                        </td>
                                    </tr>
                                </table>
                                
                                <div class="action-buttons">
                                    <input type="button" id="terUpdate" class="btn-submit" value="Update" onclick="funupdate()">
                                </div>
                            </fieldset>
                        </div>

                        <!-- HIDDEN FIELDS -->
                        <div style="display:none;">
                            <input type="hidden" id="ladocno" name="ladocno">
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
                        <div id="listdiv">
                            <jsp:include page="terminationlistGrid.jsp"></jsp:include>
                        </div>
                    </div>

                </div>

            </div>
            
            <!-- POPUPS -->
            <div id="clinfowindow"><div></div></div> 
            
        </div>
    </body>
</html>