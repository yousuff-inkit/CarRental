<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 

<style>
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
.release-filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.release-filter-table .label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 80px;
}

/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select,
.release-filter-table input[type="text"],
.release-filter-table select {
    width: 100%;
    height: 24px;              
    padding: 2px 8px;          
    border: 1px solid #ccd6e0;
    border-radius: 4px;        
    font-size: 12px;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

/* Readonly / disabled look */
input[readonly],
input:disabled,
.release-filter-table input[readonly],
.release-filter-table input:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    border-color: #e1e8ed;
}

/* jqx date/time containers */
.release-filter-table div[id^="date"] {
    width: 100%;
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
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-submit:disabled {
    background: #9ca3af;
    cursor: not-allowed;
}

/* Action buttons layout */
.release-actions {
    display: flex;
    gap: 8px;
    justify-content: center;
    margin-top: 15px;
}

.release-actions .btn-submit {
    flex: 1;
    min-width: 0;
}

/* ===== RIGHT CONTENT AREA (Dynamically fills screen) ===== */
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
    display: flex;
    flex-direction: column;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}

.grid-wrapper {
    flex: 1; 
    min-height: 250px; 
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
        
         $("#date").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy", enableBrowserBoundsDetection: true});
         /* Searching Window */
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
         
         $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#establishedCodeDetailsWindow').jqxWindow('close');
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         $('#txtbankaccount').dblclick(function(){
             accountSearchContent("bankAccountDetailsSearch.jsp");
         });
         
         $('#txtestablishmentcode').dblclick(function(){
             establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
         });
         
         $("#salaryPaymentDetailsGridID").jqxGrid({ height: 532 });
         $('#salaryPaymentDetailsGridID').jqxGrid({ selectionmode: 'singlerow'});
         $("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
         $('#btnSaveSalaryPayment').attr('disabled', true );
         $('#date').jqxDateTimeInput({disabled: true});
    });
    
    function accountSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function establishedCodeSearchContent(url) {
        $('#establishedCodeDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
        $('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
     function getYear() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var yearItems = items[0].split(",");
                    var yearIdItems = items[1].split(",");
                    $('#excelconfig').val(items[2].split(","));
                    var optionsyear = '<option value="">--Select--</option>';
                    for (var i = 0; i < yearItems.length; i++) {
                        optionsyear += '<option value="' + yearIdItems[i] + '">'
                                + yearItems[i] + '</option>';
                    }
                    $("select#cmbyear").html(optionsyear);
                    if($('#hidcmbyear').val()){
                        document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;
                        funreload(event);
                      }
                } else {
                }
            }
            x.open("GET", "getYear.jsp", true);
            x.send();
        }
    
    function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var payrollcategoryItems = items[0].split(",");
                var payrollcategoryIdItems = items[1].split(",");
                var optionspayrollcategory = '<option value="">--Select--</option>';
                for (var i = 0; i < payrollcategoryItems.length; i++) {
                    optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
                            + payrollcategoryItems[i] + '</option>';
                }
                $("select#cmbempcategory").html(optionspayrollcategory);
                
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
    
    function getSalesAgent() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var salesAgentItems = items[0].split(",");
                var salesAgentIdItems = items[1].split(",");
                var optionssalesagent = '<option value="">--Select--</option>';
                for (var i = 0; i < salesAgentItems.length; i++) {
                     optionssalesagent += '<option value="' + salesAgentIdItems[i] + '">'
                            + salesAgentItems[i] + '</option>';
                }
                $("select#cmbempagentid").html(optionssalesagent);
                
            } else {
            }
        }
        x.open("GET", "getSalesAgent.jsp", true);
        x.send();
    }
    
    function getAccount(event){
        var x= event.keyCode;
        if(x==114){
            accountSearchContent("accountDetailsSearch.jsp");
        }
    }
    
    function getBankAccount(event){
        var x= event.keyCode;
        if(x==114){
            accountSearchContent("bankAccountDetailsSearch.jsp");
        }
    }
    
    function getEstablishmentCode(event){
        var x= event.keyCode;
        if(x==114){
            establishedCodeSearchContent("establishmentCodeDetailsSearch.jsp");
        }
    }

    function  funClearInfo(){
        $('#cmbbranch').val('a');$('#cmbyear').val('');$('#cmbmonth').val('');$('#txtestablishmentcode').val('');
        $('#cmbempcategory').val('');$('#cmbempagentid').val('');$('#date').val(new Date());$('#hiddate').val('');
        $('#txtbankaccount').val('');$('#txtbankaccountname').val('');$('#txtbankaccountdocno').val('');
        $('#txtdrtotal').val('');$('#txtcrtotal').val('');$('#gridlength').val('');
        $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
        $("#postedSalaryGridID").jqxGrid('clear');
        $('#date').jqxDateTimeInput({disabled: true});$('#btnSaveSalaryPayment').attr('disabled', true );
        
        if (document.getElementById("txtbankaccountdocno").value == "") {
            $('#txtbankaccount').attr('placeholder', 'Press F3 to Search'); 
            $('#txtbankaccountname').attr('placeholder', 'Bank Account');
        }
        
        if (document.getElementById("txtestablishmentcode").value == "") {
            $('#txtestablishmentcode').attr('placeholder', 'Press F3 to Search'); 
        }
     }
    
    function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var year = $('#cmbyear').val();
         var month = $('#cmbmonth').val();
         var category = $('#cmbempcategory').val();
         var agent = $('#cmbempagentid').val();
         var establishmentcode = $('#txtestablishmentcode').val();
         var employeebranchchk=window.parent.employeebranchchk.value; 
        
         var bankAccount = $('#txtbankaccountdocno').val();
         var bankName = $('#txtbankaccountname').val();
         if($('#cmbyear').val()==''){
             $.messager.alert('Message','Please Choose a Year.','warning');
             return 0;
         }
        
        if($('#cmbmonth').val()==''){
             $.messager.alert('Message','Please Choose a Month.','warning');
             return 0;
         } 
        
          $("#overlay, #PleaseWait").show();
          $('#date').jqxDateTimeInput({disabled: false});
          $('#date').val(new Date()); 
          var paymentdate=$('#date').val(); 
          $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');
          $("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});$("#salaryPaymentDetailsGridID").jqxGrid({ disabled: true});
          $('#txtselectedemployees').val('');  
          $("#salaryPaymentDetailsDiv").load("salaryPaymentGrid.jsp?branchval="+branchval+'&paymentdate='+paymentdate+'&bankAccount='+bankAccount+'&bankName='+encodeURIComponent(bankName)+'&year='+year+'&month='+month+'&category='+category+'&agent='+agent+'&establishmentCode='+establishmentcode.replace(/ /g, "%20")+'&check=1&employeebranchchk='+employeebranchchk); 
          $('#date').jqxDateTimeInput({disabled: true});
    }
    
    function funExportBtn(){
        var method=document.getElementById("excelconfig").value;
        
        $("#salaryPaymentDetailsDiv").excelexportjs({
            containerid: "salaryPaymentDetailsDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "salaryPaymentDetailsGridID", 
            columns: getColumns("salaryPaymentDetailsGridID") ,   
            worksheetName:"WPS Listing"
            });
    }  
    
    function funWPSFormat(){
        
        if($('#txtestablishmentcode').val()==''){
            $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
             $.messager.alert('Message','Establishment Code is Mandatory.','warning');
             return 0;
         }
        
        if($('#txtbankaccountdocno').val()==''){
            $("#salaryPaymentDetailsGridID").jqxGrid('clearselection');$("#salaryPaymentDetailsGridID").jqxGrid('clear');$("#salaryPaymentDetailsGridID").jqxGrid('addrow', null, {});
             $.messager.alert('Message','Bank Account is Mandatory.','warning');
             return 0;
         }
        
        var rows = $("#salaryPaymentDetailsGridID").jqxGrid('getrows');
        if(rows.length==1 && (rows[0].empdocno=="undefined" || rows[0].empdocno==null || rows[0].empdocno=="")){
            $.messager.alert('Warning','Please Submit & Click again.');
            return false;
        }
        var estcode = $("#txtestablishmentcode").val();
        var currentdate = new Date();   
        var year =new Date(currentdate.getFullYear(), ("0" + (currentdate.getMonth() + 1)).slice(-2), currentdate.getDate()).toLocaleDateString('en', {year: '2-digit'}); 
        var datetime = year+""+("0" + (currentdate.getMonth() + 1)).slice(-2)+""+currentdate.getDate()+""+currentdate.getHours()+""+currentdate.getMinutes()+""+("0"+currentdate.getSeconds()).slice(-2);                  
        console.log(datetime);
              JSONToCSVConNew(dataSIF, estcode+""+datetime, true);  
         
            
    }
    function JSONToCSVConNew(JSONData, ReportTitle, ShowLabel) {
         console.log(JSONData)
        var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
        
       
        var CSV = '';   
        //Set Report title in first row or line
        
        //1st loop is to extract each row
        var strquote = "'";
        
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            
            //2nd loop will extract each column and convert it in string comma-seprated
            for (var index in arrData[i]) {
                console.log(index);
                if(index=="ibanno" ||  index=="ifsccode" || index=="empid" || index=="fromdate" || index=="todate"){   
                    if(isNaN(arrData[i][index])){
                        row += arrData[i][index]+',';   
                    }else{
                        console.log('='+arrData[i][index]);  
                        if((arrData[i][index])!='' && (arrData[i][index])!=null){
                             row += strquote+arrData[i][index]+',';  
                        }else{
                              row += arrData[i][index]+','; 
                        }
                    }
                }else{
                    row += arrData[i][index]+','; 
                }
                
            }

            row.slice(0, row.length - 1);
            
            //add a line break after each row
            CSV += row + '\r\n';
        }

        if (CSV == '') {        
            //alert("Invalid data");
            return;
        }   
        
        //Generate a file name
        var fileName = "";
        //this will remove the blank-spaces from the title and replace it with an underscore
        fileName += ReportTitle.replace(/ /g,"_");   
        
         // newly added 
        var temp = CSV;
        blob = new Blob([temp],{type: 'text/csv'});
        var bigcsv= window.webkitURL.createObjectURL(blob);
       
        //this trick will generate a temp <a /> tag
        var link = document.createElement("a");     
          link.href = bigcsv;
        
        //set the visibility hidden so it will not effect on your web-layout
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        
        //this part will append the anchor tag and remove it after automatic click
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }
</script>
</head>
<body onload="getBranch();getYear();getPayrollCategory();getSalesAgent();">

<form id="frmDashboardSalaryPayment" action="saveDashboardSalaryPayment" method="post">
<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Year</td>
                            <td>
                                <select id="cmbyear" name="cmbyear">
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Month</td>
                            <td>
                                <select id="cmbmonth" name="cmbmonth">
                                    <option value="">--Select--</option>
                                    <option value="01">January</option>
                                    <option value="02">February</option>
                                    <option value="03">March</option>
                                    <option value="04">April</option>
                                    <option value="05">May</option>
                                    <option value="06">June</option>
                                    <option value="07">July</option>
                                    <option value="08">August</option>
                                    <option value="09">September</option>
                                    <option value="10">October</option>
                                    <option value="11">November</option>
                                    <option value="12">December</option>
                                </select>
                                <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Agent Id</td>
                            <td>
                                <select id="cmbempagentid" name="cmbempagentid">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Category</td>
                            <td>
                                <select id="cmbempcategory" name="cmbempcategory">
                                    <option value="">--Select--</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Est. Code</td>
                            <td>
                                <input type="text"
                                       id="txtestablishmentcode"
                                       name="txtestablishmentcode"
                                       readonly
                                       placeholder="Press F3 to Search"
                                       value='<s:property value="txtestablishmentcode"/>'
                                       onkeydown="getEstablishmentCode(event);">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Payment</td>
                            <td>
                                <div id="date"></div>
                                <input type="hidden" id="hiddate" name="hiddate" value='<s:property value="hiddate"/>'>
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Bank</td>
                            <td>
                                <input type="text"
                                       id="txtbankaccount"
                                       name="txtbankaccount"
                                       readonly
                                       placeholder="Press F3 to Search"
                                       value='<s:property value="txtbankaccount"/>'
                                       onkeydown="getBankAccount(event);">
                                <input type="hidden"
                                       id="txtbankaccountdocno"
                                       name="txtbankaccountdocno"
                                       value='<s:property value="txtbankaccountdocno"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="text"
                                       id="txtbankaccountname"
                                       name="txtbankaccountname"
                                       readonly
                                       placeholder="Bank Account"
                                       value='<s:property value="txtbankaccountname"/>'
                                       tabindex="-1">
                            </td>
                        </tr>
                    </table>

                    <div class="release-actions">
                        <button type="button" class="btn-submit" onclick="funClearInfo();">Clear</button>
                        <button type="button" class="btn-submit" onclick="funWPSFormat();">WPS Format</button>
                    </div>
                </div>

                <input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'>
                <input type="hidden" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>'>
                <input type="hidden" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>'>
                <input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'>
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
                <input type="hidden" id="excelconfig" name="excelconfig" value='<s:property value="excelconfig"/>'>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div class="grid-wrapper" id="salaryPaymentDetailsDiv">
                    <jsp:include page="salaryPaymentGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="accountDetailsWindow"><div></div></div>
    <div id="establishedCodeDetailsWindow"><div></div></div>

</div>
</form>

</body>
</html>