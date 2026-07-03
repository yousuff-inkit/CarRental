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
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
}

/* Force layout tables to white */
.master-layout-table, 
.master-layout-table > tbody > tr, 
.master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}

/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, 
table td:hover, 
table th:hover, 
tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #ffffff !important; 
    margin: 0 !important;
    padding: 0 !important;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #ffffff !important;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}

/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}

.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}

.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
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
    background-color: #ffffff !important;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

/* Utility for dual inputs (ranges) */
.input-range-row {
    display: flex;
    align-items: center;
    gap: 6px;
}
.input-range-row input {
    flex: 1;
    min-width: 0;
}
.input-range-row span {
    font-size: 12px;
    color: #4e5e71;
    font-weight: bold;
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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
    margin-top: 15px; 
}

.btn-submit, .myButton, .myButtons {
    flex: 1;
    height: 30px !important;            
    padding: 0 12px !important;         
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;      
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;       
    text-align: center;
    transition: background 0.2s;
    width: 100%;
    margin-top: 0;
}

.btn-submit:hover, .myButton:hover, .myButtons:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled, .myButton:disabled, .myButtons:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Global Overrides for Labels */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    padding-left: 4px;
    background: transparent !important;
    background-color: transparent !important;
}

.grid-heading-lbl {
    font-size: 14px;
    font-weight: bold;
    color: #2563eb;
    margin-bottom: 15px;
    display: inline-block;
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
         // UPDATED: Standardized height to 24px and width to 100%
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
        
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
        
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
         $('#txtaccid').dblclick(function(){
             if($('#cmbtype').val()==''){
                 $.messager.alert('Message','Account Type is Mandatory.','warning');
                 return 0;
             }
             
             if($('#cmbtype').val()==null){
                 $.messager.alert('Message','Account Search Not Available.','warning');
                 return 0;
             }
             accountsSearchContent('accountsDetailsSearch.jsp');
         });
    });

    // Targeted function to populate the native dropdown inside heading.jsp
    function getBranch() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim().split('####');
                if (items.length > 1) {
                    var brchIdItems = items[0].split(",");
                    var brchItems = items[1].split(",");
                    var optionsbrch = '<option value="">--Select--</option>';
                    for (var i = 0; i < brchItems.length; i++) {
                        optionsbrch += '<option value="' + brchIdItems[i] + '">' + brchItems[i] + '</option>';
                    }
                    $("select#cmbbranch").html(optionsbrch);
                }
            }
        }
        x.open("GET", "getBranch.jsp", true);
        x.send();
    }
    
    function accountsSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getDocumentType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var dtypeItems = items[0].split(",");
                var menuItems = items[1].split(",");
                var optionssalutn = '<option value="">--Select--</option>';
                for (var i = 0; i < menuItems.length; i++) {
                    optionssalutn += '<option value="' + dtypeItems[i] + '">'
                            + menuItems[i] + '</option>';
                }
                $("select#cmbdoctype").html(optionssalutn);
                if ($('#hidcmbdoctype').val() != null) {
                    $('#cmbdoctype').val($('#hidcmbdoctype').val());
                }
            } else {
            }
        }
        x.open("GET", "getDocumentType.jsp", true);
        x.send();
    } 
    
    function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
          if($('#cmbtype').val()==''){
             $.messager.alert('Message','Account Type is Mandatory.','warning');
             return 0;
          }
          if($('#cmbtype').val()==null){
             $.messager.alert('Message','Account Search Not Available.','warning');
             return 0;
          }
          accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
        
    function funExportBtn(){
         var dtype=$('#cmbdoctype').val();
         if(dtype=='BPV'){
            
             $("#bankDiv").excelexportjs({
                    containerid: "bankDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxBankVoucher",
                    columns: getColumns("jqxBankVoucher"),
                    worksheetName: "BankPaymentVoucher"
                });
         }
       if(dtype=='BRV'){
            
             $("#bankDiv").excelexportjs({
                    containerid: "bankDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxBankVoucher",
                    columns: getColumns("jqxBankVoucher"),
                    worksheetName: "BankReceiptVoucher"
                });
         }
       if(dtype=='IBP'){
            
             $("#bankDiv").excelexportjs({
                    containerid: "bankDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxBankVoucher",
                    columns: getColumns("jqxBankVoucher"),
                    worksheetName: "IBBankPaymentVoucher"
                });
         }
       if(dtype=='IBR'){
            
             $("#bankDiv").excelexportjs({
                    containerid: "bankDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxBankVoucher",
                    columns: getColumns("jqxBankVoucher"),
                    worksheetName: "IBBankReceiptVoucher"
                });
         }
       if(dtype=='CPV'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "CashPaymentVoucher"
                });
         }
       if(dtype=='CRV'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "CashReceiptVoucher"
                });
         }
       if(dtype=='ICPV'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "IBCashPaymentVoucher"
                });
         }
       if(dtype=='ICRV'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "IBCashReceiptVoucher"
                });
         }
       if(dtype=='PC'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "PettyCashVoucher"
                });
         }
       if(dtype=='FCR'){
            
             $("#cashDiv").excelexportjs({
                    containerid: "cashDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCashVoucher",
                    columns: getColumns("jqxCashVoucher"),
                    worksheetName: "FuelCardReimbursement"
                });
         }
       if(dtype=='COT'){
            
             $("#contraDiv").excelexportjs({
                    containerid: "contraDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxContraTransVoucher",
                    columns: getColumns("jqxContraTransVoucher"),
                    worksheetName: "ContraTransVoucher"
                });
         }
       if(dtype=='CNO'){
            
             $("#creditDiv").excelexportjs({
                    containerid: "creditDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCreditDebitVoucher",
                    columns: getColumns("jqxCreditDebitVoucher"),
                    worksheetName: "CreditVoucher"
                });
         }
       if(dtype=='DNO'){
            
             $("#creditDiv").excelexportjs({
                    containerid: "creditDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCreditDebitVoucher",
                    columns: getColumns("jqxCreditDebitVoucher"),
                    worksheetName: "DebitVoucher"
                });
         }
       if(dtype=='TCN'){  
            
             $("#creditDiv").excelexportjs({
                    containerid: "creditDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCreditDebitVoucher",
                    columns: getColumns("jqxCreditDebitVoucher"),
                    worksheetName: "Tax Credit Note"
                });
         }
       if(dtype=='TDN'){
            
             $("#creditDiv").excelexportjs({
                    containerid: "creditDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxCreditDebitVoucher",
                    columns: getColumns("jqxCreditDebitVoucher"),
                    worksheetName: "Tax Debit Note"
                });
         }
       if(dtype=='JVT'){
            
             $("#journalDiv").excelexportjs({
                    containerid: "journalDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxJournalVoucher",
                    columns: getColumns("jqxJournalVoucher"),
                    worksheetName: "JournalVoucher"
                });
         }
       if(dtype=='IJV'){
            
             $("#journalDiv").excelexportjs({
                    containerid: "journalDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxJournalVoucher",
                    columns: getColumns("jqxJournalVoucher"),
                    worksheetName: "IBJournalVoucher"
                });
         }
       if(dtype=='PRIV'){
            
             $("#propertyDiv").excelexportjs({
                    containerid: "propertyDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxPropertyInvoice",
                    columns: getColumns("jqxPropertyInvoice"),
                    worksheetName: "PropertyInvoice"
                });
         }
       if(dtype=='SEC'){
            
             $("#securityChqDiv").excelexportjs({
                    containerid: "securityChqDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "securityChequeList",
                    columns: getColumns("securityChequeList"),
                    worksheetName: "SecurityCheque"
                });
         }
       if(dtype=='UCP'){
            
             $("#unclearedChqDiv").excelexportjs({
                    containerid: "unclearedChqDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxUnclearedChequeVoucher",
                    columns: getColumns("jqxUnclearedChequeVoucher"),
                    worksheetName: "UnclearedChequePaymentVoucher"
                });
         }
       if(dtype=='UCR'){
            
             $("#unclearedChqDiv").excelexportjs({
                    containerid: "unclearedChqDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxUnclearedChequeVoucher",
                    columns: getColumns("jqxUnclearedChequeVoucher"),
                    worksheetName: "UnclearedChequeReceiptVoucher"
                });
         }
       if(dtype=='MCP'){
             $("#mcpDiv").excelexportjs({
                    containerid: "mcpDiv",
                    datatype: 'json',
                    dataset: null,
                    gridId: "jqxMCP",
                    columns: getColumns("jqxMCP"),
                    worksheetName: "MultipleCashPurchase"   
                });
         }
    } 
    
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
         {
          $.messager.alert('Message',' Enter Numbers Only ','warning');   
            return false;
         }
        return true;
    }

    function  funClearInfo(){
        $('#cmbbranch').val('a');
        $('#fromdate').val(new Date());
        var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
        var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
        $('#todate').val(new Date());
        
        document.getElementById("lbldoctype").innerHTML="";
        document.getElementById("cmbdoctype").value="";
        document.getElementById("txtdocrangefrom").value="";
        document.getElementById("txtdocrangeto").value="";
        document.getElementById("txtamtrangefrom").value="";
        document.getElementById("txtamtrangeto").value="";
        document.getElementById("cmbtype").value="";
        document.getElementById("txtaccid").value="";
        document.getElementById("txtaccname").value="";
        document.getElementById("txtdocno").value="";
        
        $("#jqxMCP").jqxGrid('clear');$("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
        $("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');$("#jqxPropertyInvoice").jqxGrid('clear');
        
        $("#jqxMCP").jqxGrid('addrow', null, {});$("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
        $("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
        $("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});$("#jqxPropertyInvoice").jqxGrid('addrow', null, {});
        
        $("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
        $("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true); $("#mcpDiv").prop("hidden", true);
        
        if (document.getElementById("txtaccid").value == "") {
                $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }
            
        }

    function docTypeInfo(){
            document.getElementById("lbldoctype").innerHTML="";
            document.getElementById("txtdocrangefrom").value="";
            document.getElementById("txtdocrangeto").value="";
            document.getElementById("txtamtrangefrom").value="";
            document.getElementById("txtamtrangeto").value="";
            document.getElementById("cmbtype").value="";
            document.getElementById("txtaccid").value="";
            document.getElementById("txtaccname").value="";
            document.getElementById("txtdocno").value="";
            
            $("#jqxMCP").jqxGrid('clear');$("#jqxCashVoucher").jqxGrid('clear');$("#jqxBankVoucher").jqxGrid('clear');$("#jqxCreditDebitVoucher").jqxGrid('clear');$("#jqxJournalVoucher").jqxGrid('clear');
            $("#jqxContraTransVoucher").jqxGrid('clear');$("#securityChequeList").jqxGrid('clear');$("#jqxUnclearedChequeVoucher").jqxGrid('clear');$("#jqxPropertyInvoice").jqxGrid('clear');
            
            $("#jqxMCP").jqxGrid('addrow', null, {});$("#jqxCashVoucher").jqxGrid('addrow', null, {});$("#jqxBankVoucher").jqxGrid('addrow', null, {});$("#jqxCreditDebitVoucher").jqxGrid('addrow', null, {});
            $("#jqxJournalVoucher").jqxGrid('addrow', null, {});$("#jqxContraTransVoucher").jqxGrid('addrow', null, {});$("#securityChequeList").jqxGrid('addrow', null, {});
            $("#jqxUnclearedChequeVoucher").jqxGrid('addrow', null, {});$("#jqxPropertyInvoice").jqxGrid('addrow', null, {});
            
            $("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);
            $("#securityChqDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true); $("#mcpDiv").prop("hidden", true);
            
            if($('#cmbdoctype').val()=='FCR'){
                $('#cmbtype').attr('disabled', true);
            }else{
                $('#cmbtype').attr('disabled', false);
            }
            
            if (document.getElementById("txtaccid").value == "") {
                $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
            }
    }
    
    function clearAccountInfo(){
        $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
        if (document.getElementById("txtaccid").value == "") {
            $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }
    } 
    
    function funreload(event){
        
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var acctype = $('#cmbtype').val();
         var accdocno = $('#txtdocno').val();
         var dtype=$('#cmbdoctype').val();
         var docrangefrom=$('#txtdocrangefrom').val();
         var docrangeto=$('#txtdocrangeto').val();
         var amtrangefrom=$('#txtamtrangefrom').val();
         var amtrangeto=$('#txtamtrangeto').val();
         var chk=1;
        
        if(dtype==''){
             $.messager.alert('Message','Please Choose Document Type.','warning');
             return 0;
         }
        
         var documenttype='';
         if(dtype=='CRV'){documenttype='Listing of Cash Receipt Voucher (CRV)';}if(dtype=='CPV'){documenttype='Listing of Cash Payment Voucher (CPV)';}
         if(dtype=='BRV'){documenttype='Listing of Bank Receipt Voucher (BRV)';}if(dtype=='BPV'){documenttype='Listing of Bank Payment Voucher (BPV)';}
         if(dtype=='CNO'){documenttype='Listing of Credit Note (CNO)';}if(dtype=='DNO'){documenttype='Listing of Debit Note (DNO)';}
         if(dtype=='TCN'){documenttype='Listing of Tax Credit Note (TCN)';} if(dtype=='TDN'){documenttype='Listing of Tax Debit Note (TDN)';}   
         if(dtype=='JVT'){documenttype='Listing of Journal Voucher (JVT)';}if(dtype=='IJV'){documenttype='Listing of IB-Journal Voucher (IJV)';}
         if(dtype=='PC'){documenttype='Listing of Petty Cash (PC)';}if(dtype=='COT'){documenttype='Listing of Contra Trans (COT)';}
         if(dtype=='SEC'){documenttype='Listing of Security Cheque (SEC)';}if(dtype=='UCP'){documenttype='Listing of Uncleared Cheque Payment (UCP)';}
         if(dtype=='UCR'){documenttype='Listing of Uncleared Cheque Receipt (UCR)';}if(dtype=='FCR'){documenttype='Listing of Fuel Card Reimbursement (FCR)';}
         if(dtype=='ICRV'){documenttype='Listing of IB-Cash Receipt Voucher (ICRV)';}if(dtype=='ICPV'){documenttype='Listing of IB-Cash Payment Voucher (ICPV)';}
         if(dtype=='IBR'){documenttype='Listing of IB-Bank Receipt Voucher (IBR)';}if(dtype=='IBP'){documenttype='Listing of IB-Bank Payment Voucher (IBP)';}
         if(dtype=='PRIV'){documenttype='Listing of Property Invoice (PRIV)';}if(dtype=='PRIV'){documenttype='Listing of Property Invoice (PRIV)';}
         if(dtype=='MCP'){documenttype='Listing of Multiple Cash Purchase (MCP)';}  
        
         $("#overlay, #PleaseWait").show();  
        
         document.getElementById("lbldoctype").innerText=documenttype; 
         if(dtype=='CRV' || dtype=='CPV' || dtype=='ICRV' || dtype=='ICPV' || dtype=='PC' || dtype=='FCR'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#cashDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
                 $("#cashDiv").load("cashVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                         +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         } else if(dtype=='BRV' || dtype=='BPV' || dtype=='IBR' || dtype=='IBP'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", false);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#bankDiv").load("bankVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&acctype='+acctype+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         } else if(dtype=='CNO' || dtype=='DNO' || dtype=='TCN' || dtype=='TDN'){   
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", false);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#creditDiv").load("creditVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         } else if(dtype=='COT'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", false);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#contraDiv").load("contraTransVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         } else if(dtype=='SEC'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#securityChqDiv").load("securityCheque.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         } else if(dtype=='UCP' || dtype=='UCR'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", false);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#unclearedChqDiv").load("unclearedVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         }else if(dtype=='JVT' || dtype=='IJV'){
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#journalDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);
             $("#journalDiv").load("journalVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         }else if(dtype=='MCP'){   
             $("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", true);$("#mcpDiv").prop("hidden", false);
             $("#mcpDiv").load("multipleCashPurchaseGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                                 +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         }else {
             $("#mcpDiv").prop("hidden", true);$("#unclearedChqDiv").prop("hidden", true);$("#securityChqDiv").prop("hidden", true);$("#propertyDiv").prop("hidden", false);$("#contraDiv").prop("hidden", true);$("#creditDiv").prop("hidden", true);$("#bankDiv").prop("hidden", true);$("#cashDiv").prop("hidden", true);$("#journalDiv").prop("hidden", true);
             $("#propertyDiv").load("propertyVoucher.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&accdocno='+accdocno+'&dtype='+dtype
                     +'&docrangefrom='+docrangefrom+'&docrangeto='+docrangeto+'&amtrangefrom='+amtrangefrom+'&amtrangeto='+amtrangeto+'&chk='+chk);
         }
        
        }
    
</script>
</head>
<body onload="getBranch();getDocumentType();">
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>

<table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background-color: #ffffff !important;">
<tr>

<td width="330px" valign="top" style="vertical-align: top; padding: 0 !important; margin: 0 !important; background: #ffffff !important; border-right: 1px solid #e1e8ed;">
    <div class="master-container">
        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">Period</td>
                            <td>
                                <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td>
                                <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Dtype</td>
                            <td>
                                <select id="cmbdoctype"
                                        name="cmbdoctype"
                                        onchange="docTypeInfo();"
                                        value='<s:property value="cmbdoctype"/>'>
                                    <option value="">--Select--</option>
                                </select>
                                <input type="hidden"
                                       id="hidcmbdoctype"
                                       name="hidcmbdoctype"
                                       value='<s:property value="hidcmbdoctype"/>'>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Doc. Range</td>
                            <td>
                                <div class="input-range-row">
                                    <input type="text"
                                           id="txtdocrangefrom"
                                           name="txtdocrangefrom"
                                           onkeypress="javascript:return isNumber(event)"
                                           value='<s:property value="txtdocrangefrom"/>'>
                                    <span>-</span>
                                    <input type="text"
                                           id="txtdocrangeto"
                                           name="txtdocrangeto"
                                           onkeypress="javascript:return isNumber(event)"
                                           value='<s:property value="txtdocrangeto"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Amount Range</td>
                            <td>
                                <div class="input-range-row">
                                    <input type="text"
                                           id="txtamtrangefrom"
                                           name="txtamtrangefrom"
                                           style="text-align:right;"
                                           onkeypress="javascript:return isNumber(event)"
                                           onblur="funRoundAmt(this.value,this.id);"
                                           value='<s:property value="txtamtrangefrom"/>'>
                                    <span>-</span>
                                    <input type="text"
                                           id="txtamtrangeto"
                                           name="txtamtrangeto"
                                           style="text-align:right;"
                                           onkeypress="javascript:return isNumber(event)"
                                           onblur="funRoundAmt(this.value,this.id);"
                                           value='<s:property value="txtamtrangeto"/>'>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Type</td>
                            <td>
                                <select id="cmbtype"
                                        name="cmbtype"
                                        onchange="clearAccountInfo();"
                                        value='<s:property value="cmbtype"/>'>
                                    <option value="">--Select--</option>
                                    <option value="AP">AP</option>
                                    <option value="AR">AR</option>
                                    <option value="GL">GL</option>
                                    <option value="HR">HR</option>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="label-cell">Account</td>
                            <td>
                                <input type="text"
                                       id="txtaccid"
                                       name="txtaccid"
                                       readonly
                                       placeholder="Press F3 to Search"
                                       value='<s:property value="txtaccid"/>' 
                                       onkeydown="getAccTypeFrom(event);">
                            </td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>
                                <input type="text"
                                       id="txtaccname"
                                       name="txtaccname"
                                       readonly
                                       value='<s:property value="txtaccname"/>'
                                       tabindex="-1">
                                <input type="hidden"
                                       id="txtdocno"
                                       name="txtdocno"
                                       value='<s:property value="txtdocno"/>'>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="button-group">
                        <input type="button"
                               class="myButtons"
                               id="clear"
                               value="Clear"
                               onclick="funClearInfo();">
                    </div>
                </div>

            </div>
        </div>
    </div>
</td>

<td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important;">

    <div style="width: 100%; margin-bottom: 10px;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <label class="grid-heading-lbl" id="lbldoctype" name="lbldoctype"></label>

    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
        <tr>
             <td valign="top" style="background: transparent !important;">

                 <div id="cashDiv">
                     <jsp:include page="cashVoucher.jsp"></jsp:include>
                 </div>

                 <div id="bankDiv" hidden="true">
                     <jsp:include page="bankVoucher.jsp"></jsp:include>
                 </div>

                 <div id="creditDiv" hidden="true">
                     <jsp:include page="creditVoucher.jsp"></jsp:include>
                 </div>

                 <div id="journalDiv" hidden="true">
                     <jsp:include page="journalVoucher.jsp"></jsp:include>
                 </div>

                 <div id="contraDiv" hidden="true">
                     <jsp:include page="contraTransVoucher.jsp"></jsp:include>
                 </div>

                 <div id="securityChqDiv" hidden="true">
                     <jsp:include page="securityCheque.jsp"></jsp:include>
                 </div>

                 <div id="propertyDiv" hidden="true">
                     <jsp:include page="propertyVoucher.jsp"></jsp:include>
                 </div>

                 <div id="unclearedChqDiv" hidden="true">
                     <jsp:include page="unclearedVoucher.jsp"></jsp:include>
                 </div>

                 <div id="mcpDiv" hidden="true">
                     <jsp:include page="multipleCashPurchaseGrid.jsp"></jsp:include>
                 </div>

             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

<div id="accountDetailsWindow">
    <div></div><div></div>
</div>

</body>
</html>