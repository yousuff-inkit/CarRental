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
        
        <script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

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
            $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            $("#todate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy"});
            
            $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%', maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
            $('#clientDetailsWindow').jqxWindow('close');
            
            $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%', maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
            $('#agreementDetailsWindow').jqxWindow('close');
            
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
            $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
            
            $('#todate').on('change', function (event) {
                var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
                var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
                
                if(fromdates > todates){
                    $.messager.alert('Message','To Date Less Than From Date','warning');   
                    return false;
                }   
            });
            
            $('#txtclientname').dblclick(function(){
                clientSearchContent('clientDetailsSearchGrid.jsp');
            });
              
            $('#agmtvocno').dblclick(function(){
                 if(document.getElementById("rentaltype").value == ""){
                     $.messager.alert('Warning','Please Select Agreement Type');
                     return false;
                 }
                 agreementSearchContent('agreementDetailsSearch.jsp'); 
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
                clientSearchContent('clientDetailsSearchGrid.jsp');
            }
        }
            
        function getAgreement(event){
            if(document.getElementById("rentaltype").value == ""){
                $.messager.alert('Warning','Please Select Agreement Type');
                return false;
            }
            var x = event.keyCode;
            if(x == 114){
                agreementSearchContent('agreementDetailsSearch.jsp');
            }
        }

        function funExportBtn(){
            $("#rentalInvoiceGrid").excelexportjs({
                containerid: "rentalInvoiceGrid",
                datatype: 'json',
                dataset: null,
                gridId: "rentalInvoiceGrid",
                columns: getColumns("rentalInvoiceGrid") ,
                worksheetName:"Grouped Invoice"
            }); 
        }

        function funClearData(){
            $('#txtclientname').val(''); $('#agmtvocno').val(''); $('#txtcldocno').val(''); $('#rentaltype').val(''); $('#txtagreementno').val(''); $('#todate').val(new Date()); $('#clstatuss').val('');
            
            var onemounth = new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
            $('#fromdate').jqxDateTimeInput('setDate', onemounth);
            $('#todate').jqxDateTimeInput('setDate', new Date());
             
            if (document.getElementById("txtclientname").value == "") {
                $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
            }
            if (document.getElementById("txtagreementno").value == "") {
                $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
                $('#agmtvocno').attr('placeholder', 'Press F3 to Search');
            }
        }
            
        function funreload(event){
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates = new Date($('#todate').jqxDateTimeInput('getDate')); 
            
            if(fromdates > todates){
                $.messager.alert('Message','To Date Less Than From Date','warning');   
                return false;
            } else {
                var branchval = document.getElementById("cmbbranch").value;
                var fromdate = $('#fromdate').val();
                var todate = $('#todate').val();
                var cldocno = $('#txtcldocno').val();
                var rentaltype = $('#rentaltype').val();
                var agmtno = $('#txtagreementno').val();
                var clstatuss = $('#clstatuss').val();
                
                $("#overlay, #PleaseWait").show();
                $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?branchval=" + branchval + '&fromdate=' + fromdate + '&todate=' + todate + '&cldocno=' + cldocno + '&rentaltype=' + rentaltype + '&agmtno=' + agmtno + '&clstatuss=' + clstatuss);
            }
        }

        function chktype() {
            if($('#rentaltype').val() == "") {
                $.messager.alert('Message','Select Type','warning');   
                document.getElementById("rentaltype").focus(); 
                return false;
            }
        }
            
        function clearagno() {
            $('#txtagreementno').val('');
            $('#agmtvocno').val('');
        }

        function funGroupPrint(){
            if(document.getElementById("txtcldocno").value == ""){
                $.messager.alert('Message','Client is Mandatory','warning');
                document.getElementById("txtcldocno").focus();
                return false;
            } else {
                var z = 0;
                var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
                if(rows.length > 0 && (rows[0].rano == "undefined" || rows[0].rano == null || rows[0].rano == "")){
                    return false;
                }
                
                var selectedRecords = new Array();
                var selectedrows = $("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select an Invoice');
                    return false;
                }
                document.getElementById("invgridlength").value = "";
                
                $.messager.confirm('Confirm', 'Do you want to Print Invoice?', function(r){
                    if (r){
                        var i = 0;
                        for (i = 0; i < rows.length; i++) {
                            for(var j = 0; j < selectedrows.length; j++){
                                if(selectedrows[j] == i){
                                    if(document.getElementById("invgridlength").value == ""){
                                        document.getElementById("invgridlength").value = rows[i].doc_no;  
                                    } else {
                                        document.getElementById("invgridlength").value = document.getElementById("invgridlength").value + "," + rows[i].doc_no;
                                    }
                                    z++;
                                }
                            }
                            if(i == rows.length - 1){
                                var url = document.URL;
                                var reurl = url.split("groupedinvoice.jsp");
                                var win = window.open(reurl[0]+"printGroupedInvoice?cldocno="+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val(),"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes"); 
                                win.focus(); 
                            }
                        }
                    }
                });
            }
        }

        function funSendmail() {
            if(document.getElementById("txtcldocno").value == ""){
                $.messager.alert('Message','Client is Mandatory','warning');
                document.getElementById("txtcldocno").focus();
                return false;
            } else {
                var selectedRecords = new Array();
                var selectedrows = $("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');

                if(selectedrows.length == 0){
                    $.messager.alert('Warning','Select an Invoice');
                    return false;
                }
                
                var z = 0;
                var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
                if(rows.length > 0 && (rows[0].rano == "undefined" || rows[0].rano == null || rows[0].rano == "")){
                    return false;
                }

                if(document.getElementById("email").value == "") {
                    document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
                    return 0;
                }
                
                $("#overlay, #PleaseWait").show();
                document.getElementById("invgridlength").value = "";
                
                $.messager.confirm('Confirm', 'Do you want to Send this Invoice?', function(r){
                    if (r){
                        var i = 0;
                        for (i = 0; i < rows.length; i++) {
                            for(var j = 0; j < selectedrows.length; j++){
                                if(selectedrows[j] == i){
                                    if(document.getElementById("invgridlength").value == ""){
                                        document.getElementById("invgridlength").value = rows[i].doc_no;  
                                    } else {
                                        document.getElementById("invgridlength").value = document.getElementById("invgridlength").value + "," + rows[i].doc_no;
                                    }
                                    z++;
                                }
                            }
                            if(i == rows.length - 1){
                                sample();   
                            }
                        }
                    } else {
                        $("#overlay, #PleaseWait").hide();
                    }
                });
            }
        }
         
        function sample() {  
            var frdate = document.getElementById("fromdate").value.trim();
            var todate = document.getElementById("todate").value.trim();
            var cldocno = document.getElementById("txtcldocno").value.trim();
            var clstatus = document.getElementById("clstatuss").value.trim();
            var retype = document.getElementById("rentaltype").value.trim();
            var agmtvocno = document.getElementById("agmtvocno").value.trim();
            var txtagmtno = document.getElementById("txtagreementno").value.trim();
            var recep = document.getElementById("email").value.trim();
            var formcode = document.getElementById("lbldetailname").innerText.trim();
            var branch = <%=session.getAttribute("BRANCHID").toString()%>;
            
            $.ajaxFileUpload({  
                url: 'grpdinvjspToPdf.action?cldocno='+document.getElementById("txtcldocno").value+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&rentaltype="+$('#rentaltype').val()+"&agmtno="+$('#txtagreementno').val()+"&clstatus="+$('#clstatuss').val()+"&griddocno="+$('#invgridlength').val()+"&recep="+recep+"&formcode="+formcode,  
                secureuri: false,
                fileElementId: 'file', 
                dataType: 'string',
                success: function (data, status) {  
                    if(status == 'success'){
                        $("#overlay, #PleaseWait").hide();
                        $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show', style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
                    }
                    if(status == 'error'){
                        $("#overlay, #PleaseWait").hide();
                        $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show', style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}});
                    }
                    
                    $("#testImg").attr("src",data.message);
                    if(typeof(data.error) != 'undefined') {  
                        if(data.error != '') {  
                            alert(data.error);  
                        } else {  
                            alert(data.message);  
                        }  
                    }  
                },  
                error: function (data, status, e) {  
                    alert(e);  
                    $("#overlay, #PleaseWait").hide();
                }  
            }); 
            return false;
        }
        </script>
    </head>

    <body onload="getBranch();">
        <form id="frmGroupedInvoice" action="saveGroupedInvoice">
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
                                        <td class="label-cell">E-Mail</td>
                                        <td>
                                            <input type="text" id="email" name="email" readonly value='<s:property value="email"/>'>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Status</td>
                                        <td>
                                            <select id="clstatuss" name="clstatuss">
                                                <option value="">--Select--</option>
                                                <option value="0">Open</option>
                                                <option value="1">Close</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Type</td>
                                        <td>
                                            <select id="rentaltype" name="rentaltype" onchange="clearagno();">
                                                <option value="">--Select--</option>
                                                <option value="RAG">Rental</option>
                                                <option value="LAG">Lease</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">Agreement</td>
                                        <td>
                                            <input type="text" id="agmtvocno" name="agmtvocno" readonly placeholder="Press F3 to Search" onfocus="chktype()" ondblclick="funSearchdblclick();" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'>
                                            <input type="hidden" id="txtagreementno" name="txtagreementno" value='<s:property value="txtagreementno"/>'>
                                        </td>
                                    </tr>
                                </table>

                                <div class="action-buttons">
                                    <button type="button" class="btn-submit" onclick="funClearData();" style="background:#64748b !important;">
                                        Clear
                                    </button>
                                    <button type="button" class="btn-submit" onclick="funGroupPrint();" style="background:#10b981 !important;">
                                        Print
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Hidden Fields -->
                            <div style="display:none;">
                                <input type="hidden" id="invgridlength" name="invgridlength" value='<s:property value="invgridlength"/>'>
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
                                <jsp:include page="rentalInvoiceGrid.jsp"></jsp:include>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </form>

        <!-- POPUPS -->
        <div id="clientDetailsWindow"><div></div><div></div></div>
        <div id="agreementDetailsWindow"><div></div><div></div></div>

    </body>
</html>