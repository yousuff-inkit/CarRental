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

        input::placeholder {
            color: #9aa4b2;
            opacity: 1;
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

        input[type="radio"], input[type="checkbox"] {
            margin: 0;
            cursor: pointer;
            width: 14px;
            height: 14px;
            vertical-align: middle;
        }

        .branch {
            font-size: 12px;
            font-weight: 600;
            color: #4e5e71;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 5px;
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

        .btn-submit:disabled {
            background: #9ca3af !important;
            cursor: not-allowed;
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
        #Readygrid {
            border: 1px solid #e3e8ee;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 10px;
        }
        </style>
        
        <script type="text/javascript">
        $(document).ready(function () {
            document.getElementById("btninvoicesave").style.display="none";
            
            $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:200px;right:600px;'><img src='../../../../icons/31load.gif'/></div>");
            
            // Uniform inputs
            $("#periodupto").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            $('#clientwindow').jqxWindow({ width: '62%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#clientwindow').jqxWindow('close');
            
            $('#agmtwindow').jqxWindow({ width: '62%', height: '65%', maxHeight: '85%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
            $('#agmtwindow').jqxWindow('close');  
            
            $('#client').dblclick(function(){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
            });
            
            $('#agmtno').dblclick(function(){
                $('#agmtwindow').jqxWindow('open');
                $('#agmtwindow').jqxWindow('focus');
                agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
            });
            
            document.getElementById("imgloading").style.display="none";
            document.getElementById("chkall").checked=true;
            setAll();
            setSalik();
            setTraffic();
            
            $('#periodupto').on('change', function (event) {  
                var docdateval=1;
                if(docdateval==0){
                    $('#periodupto').jqxDateTimeInput('focus');
                    return false;
                }
            }); 
        });

        function getClient(event){
            var x= event.keyCode;
            if(x==114){
                $('#clientwindow').jqxWindow('open');
                $('#clientwindow').jqxWindow('focus');
                clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
            }
        }

        function getAgmt(event){
            var x= event.keyCode;
            if(x==114){
                $('#agmtwindow').jqxWindow('open');
                $('#agmtwindow').jqxWindow('focus');
                agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
            }
        }

        function clientSearchContent(url) {
            $.get(url).done(function (data) {
                $('#clientwindow').jqxWindow('setContent', data);
            }); 
        }

        function agmtSearchContent(url) {
            $.get(url).done(function (data) {
                $('#agmtwindow').jqxWindow('setContent', data);
            }); 
        }

        function funreload(event) {
            var dateval=1;
            if(dateval==1){
                var barchval = document.getElementById("cmbbranch").value;
                var date1= $('#periodupto').jqxDateTimeInput('getText');
                var client=document.getElementById("hidclient").value;
                var agmtno=document.getElementById("hidagmtno").value;
                $('#leaseInvoiceGrid').jqxGrid('clear');
                $("#leaseInvoiceGrid").jqxGrid("addrow", null, {}); 
                document.getElementById("btninvoicesave").style.display="none";
                $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1&agmtno="+agmtno);
            }
        }

        function funCalculate(){
            $("#overlay, #PleaseWait").show(); 
            var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');
            if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
                return false;
            }
            var date1= $('#periodupto').jqxDateTimeInput('getText');
            var client=document.getElementById("hidclient").value;
            var agmtno=document.getElementById("hidagmtno").value;
            var branchvalue =document.getElementById("cmbbranch").value;
            $('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1&agmtno='+agmtno);
        }
            
        function funNotify(){
            var z=0;
            var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');                  
            if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
                return false;
            }
            
            var selectedRecords = new Array();
            var selectedrows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
            
            if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
                $.messager.alert('Warning','Please Calculate the Amount');
                return false;
            }
            if(selectedrows.length==0){
                $.messager.alert('Warning','Select an Invoice');
                return false;
            }
            
            var dataarray=new Array();
            $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
                if (r){
                    var i=0;
                    $('#invgridlength').val(selectedrows.length);
                    for (i = 0; i < rows.length; i++) {
                        for(var j=0;j<selectedrows.length;j++){
                            if(selectedrows[j]==i){
                                if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){       
                                    dataarray.push(rows[i].rano+" :: "+rows[i].ratype+" :: "+rows[i].fromdate+" :: "+rows[i].todate+" :: "+rows[i].acno+" :: "+rows[i].acname+" :: "+rows[i].amount+" :: "+rows[i].cldocno+" :: "+rows[i].rentalsum+" :: "+rows[i].accsum+" :: "+rows[i].salikamt+" :: "+rows[i].trafficamt+" :: "+rows[i].saliksrvc+" :: "+rows[i].trafficsrvc+" :: "+rows[i].datediff+" :: "+rows[i].brhid+" :: "+rows[i].curid+" :: "+rows[i].insurchg+" :: "+rows[i].salikcount+" :: "+rows[i].trafficcount+" :: "+rows[i].salamount+" :: "+rows[i].salrate);
                                }
                                z++;
                            }
                        }
                    }
                    $('#reqhidden').val(dataarray);
                    document.getElementById("mode").value='A';
                    $("#overlay, #PleaseWait").show();
                }
            });
        }

        function setValues(){
            if($('#msg').val()!=""){
               $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
            }
        }

        function funExportBtn(){
            if(parseInt(window.parent.chkexportdata.value)=="1") {
                JSONToCSVCon(invoicedata, 'Lease Invoice', true);
            }
            else {
                $("#leaseInvoiceGrid").jqxGrid('exportdata', 'xls', 'Lease Invoice');
            }
        }

        function setSalik(){
            if(document.getElementById("chksalik").checked==true){
                document.getElementById("hidchksalik").value="1";
                document.getElementById("hidchkexsalik").value="0";
                document.getElementById("chkall").checked=false;
            }
            if(document.getElementById("chkexsalik").checked==true){
                document.getElementById("hidchkexsalik").value="1";
                document.getElementById("hidchksalik").value="0";
                document.getElementById("chkall").checked=false;
            } 
        }
                
        function setTraffic(){
            if(document.getElementById("chktraffic").checked==true){
                document.getElementById("hidchktraffic").value="1";
                document.getElementById("hidchkextraffic").value="0";
                document.getElementById("chkall").checked=false;
            }
            if(document.getElementById("chkextraffic").checked==true){
                document.getElementById("hidchkextraffic").value="1";
                document.getElementById("hidchktraffic").value="0";
                document.getElementById("chkall").checked=false;
            }
        }
                
        function setAll(){
            if(document.getElementById("chkall").checked==true){
                document.getElementById("hidchkall").value="1";
                $('#chksalik').removeAttr('checked');
                $('#chkexsalik').removeAttr('checked');
                $('#chktraffic').removeAttr('checked');
                $('#chkextraffic').removeAttr('checked');
                document.getElementById("hidchksalik").value="0";
                document.getElementById("hidchkexsalik").value="0";
                document.getElementById("hidchktraffic").value="0";
                document.getElementById("hidchkextraffic").value="0";
            }
            else{
                document.getElementById("hidchkall").value="0";
            }
        }
        </script>
    </head>
    
    <body onload="getBranch();setValues();">
        <form id="frmDashboardLeaseInvoice" method="post" style="height: 100%;">
            <input type="hidden" id="reqhidden" name="reqhidden">
            
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
                                    <tr>
                                        <td class="label-cell">Client</td>
                                        <td>
                                            <input type="text" name="client" id="client" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="client"/>' style="background:#ffffff !important; color:#333;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agmt No</td>
                                        <td>
                                            <input type="text" name="agmtno" id="agmtno" readonly="readonly" placeholder="Press F3 to Search" onkeydown="getAgmt(event);" value='<s:property value="agmtno"/>' style="background:#ffffff !important; color:#333;">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="right">
                                            <label class="branch" for="chkall" style="margin-top: 5px;">
                                                <input type="checkbox" name="chkall" id="chkall" onchange="setAll();"> All
                                            </label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            <div class="filter-card">
                                <fieldset>
                                    <legend>Separate Invoice</legend>
                                    <div style="display: flex; justify-content: space-around; gap: 10px;">
                                        <label class="branch"><input type="radio" name="chksalik" id="chksalik" onChange="setSalik();"> Salik</label>
                                        <label class="branch"><input type="radio" name="chktraffic" id="chktraffic" onchange="setTraffic();"> Traffic</label>
                                    </div>
                                </fieldset>

                                <fieldset style="margin-bottom: 0;">
                                    <legend>Not To Be Invoiced</legend>
                                    <div style="display: flex; justify-content: space-around; gap: 10px;">
                                        <label class="branch"><input type="radio" name="chksalik" id="chkexsalik" onChange="setSalik();"> Salik</label>
                                        <label class="branch"><input type="radio" name="chktraffic" id="chkextraffic" onchange="setTraffic();"> Traffic</label>
                                    </div>
                                </fieldset>
                            </div>

                            <div id="Readygrid">
                                <jsp:include page="invnoGrid.jsp"></jsp:include>
                            </div>

                            <div class="action-buttons">
                                <button type="button" name="btninvoicesave" id="btninvoicesave" class="btn-submit" disabled style="opacity: 0;">Generate</button>
                            </div>

                            <!-- HIDDEN FIELDS -->
                            <div style="display:none;">
                                <input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>
                                <input type="hidden" name="hidchksalik" id="hidchksalik" value='<s:property value="hidchksalik"/>'>
                                <input type="hidden" name="hidchktraffic" id="hidchktraffic" value='<s:property value="hidchktraffic"/>'>
                                <input type="hidden" name="hidchkexsalik" id="hidchkexsalik" value='<s:property value="hidchkexsalik"/>'>
                                <input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'>
                                <input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>
                                <input type="hidden" name="hidclient" id="hidclient" >
                                <input type="hidden" name="gridlength" id="gridlength" >
                                <input type="hidden" name="invgridlength" id="invgridlength" >
                                <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
                                <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
                            </div>

                        </div>
                    </div>

                    <!-- ================= RIGHT SIDE (GRID) ================= -->
                    <div class="main-content-area">
                        
                        <!-- Header matching target layout design -->
                        <div class="top-toolbar-container">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div class="grid-content-container">
                            <div id="imgdiv" style="text-align: center; margin-bottom: 10px;">
                                <img id="imgloading" alt="Loading..." src="../../../../icons/31load.gif"/>
                            </div>
                            
                            <div id="leaseinvoicediv">
                                <jsp:include page="leaseInvoiceGrid.jsp"></jsp:include>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            
            <!-- POPUPS -->
            <div id="clientwindow"><div></div></div>
            <div id="agmtwindow"><div></div></div>
            
        </form>
    </body>
</html>