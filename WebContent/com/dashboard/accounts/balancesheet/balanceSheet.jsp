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

/* Flex 1 allows this middle section to scroll while keeping bottom fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px; 
}

/* Fixed bottom panel so buttons are always visible */
.sidebar-fixed-bottom {
    padding: 15px 20px;
    border-top: 1px solid #e1e8ed;
    background: #ffffff !important;
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
    cursor: not-allowed;
}

/* Checkbox Alignment */
input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit, .myButton {
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

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled, .myButton:disabled {
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
</style>

<script type="text/javascript">
    
    var selectedBox = null;
    
    $(document).ready(function () {
         // UPDATED: Standardized height to 24px and width to 100%
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
        
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         var year = window.parent.txtaccountperiodfrom.value;
         var newDate = year.split('-');
         year = newDate[1] + "-" + newDate[0] + "-" + newDate[2];
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(year));
            
         $(".chcklevels").click(function() {
            selectedBox = this.id;

            $(".chcklevels").each(function() {
                if ( this.id == selectedBox )
                {
                    this.checked = true;
                   if ( this.id != "chcklevel4" ){  
                     $('#btnprint').attr("disabled",true);
                   }else{
                     $('#btnprint').attr("disabled",false);
                   } 
                }
                else
                {
                    this.checked = false;
                };        
            });
        });    
        
         document.getElementById("hidchcklevel4").value=1;
         document.getElementById("chcklevel4").checked = true;
         $('#btnprint').attr("disabled",true);
         getBalanceSheetPrintConfig();
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
    
    function getBalanceSheetPrintConfig(){
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                
                if(parseInt(items)==1){
                     $("#btnprint").show();
                 } else {
                     $("#btnprint").hide();
                 }
        }
        }
        x.open("GET", "getBalanceSheetPrintConfig.jsp", true);
        x.send();
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
    
    function analysischeck(){
         if(document.getElementById("chckanalysis").checked){
             document.getElementById("hidchckanalysis").value = 1;
             $('#txtnoofdays').val("0");
             $('#txtfrequency').val("0");
         }
         else{
             document.getElementById("hidchckanalysis").value = 0;
         }
         hidedata();
     }
    
    function checklevel1(){
        if(document.getElementById("chcklevel1").checked){
             document.getElementById("hidchcklevel1").value = 1;
             document.getElementById("hidchcklevel2").value = 0;
             document.getElementById("hidchcklevel3").value = 0;
             document.getElementById("hidchcklevel4").value = 0;
         }
         else{
             document.getElementById("hidchcklevel1").value = 0;
         }
     }
    
    function checklevel2(){
         if(document.getElementById("chcklevel2").checked){
             document.getElementById("hidchcklevel2").value = 1;
             document.getElementById("hidchcklevel1").value = 0;
             document.getElementById("hidchcklevel3").value = 0;
             document.getElementById("hidchcklevel4").value = 0;
         }
         else{
             document.getElementById("hidchcklevel2").value = 0;
         }
     }
    
    function checklevel3(){
         if(document.getElementById("chcklevel3").checked){
             document.getElementById("hidchcklevel3").value = 1;
             document.getElementById("hidchcklevel1").value = 0;
             document.getElementById("hidchcklevel2").value = 0;
             document.getElementById("hidchcklevel4").value = 0;
         }
         else{
             document.getElementById("hidchcklevel3").value = 0;
         }
     }
    
    function checklevel4(){
         if(document.getElementById("chcklevel4").checked){
             document.getElementById("hidchcklevel4").value = 1;
             document.getElementById("hidchcklevel1").value = 0;
             document.getElementById("hidchcklevel2").value = 0;
             document.getElementById("hidchcklevel3").value = 0;
         }
         else{
             document.getElementById("hidchcklevel4").value = 0;
         }
     }
    
    function hidedata(){
        var analysis=$('#hidchckanalysis').val();
        
        if(parseInt(analysis)==1){
               $("#analysisDiv").prop("hidden", false);
               $("#viewDiv").attr("hidden", true);
            }
            else{
                $("#analysisDiv").prop("hidden", true);
                $("#viewDiv").attr("hidden", false);
            }
        }
    
     function funreload(event){
         var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var level1 = $('#hidchcklevel1').val();
         var level2 = $('#hidchcklevel2').val();
         var level3 = $('#hidchcklevel3').val();
         var level4 = $('#hidchcklevel4').val();
         var check=1;
        
         $("#overlay, #PleaseWait").show();
         if(document.getElementById("chcklevel4").checked){
           $('#btnprint').attr("disabled",true);
         }
         $("#balanceSheetDiv").load("balanceSheetGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&level1='+level1+'&level2='+level2+'&level3='+level3+'&level4='+level4+'&check='+check);
        }
        
        function funExportBtn(){
          if(parseInt(window.parent.chkexportdata.value)=="1") {
            JSONToCSVCon(dataExcelExport, 'BalanceSheet', true);
          } else {
             $("#balanceSheetGrid").jqxTreeGrid('exportData', 'xls');
          }
        }
        
        function funPrintTForm(){
                var url=document.URL;
                var reurl=url.split("balanceSheet.jsp");

                var fromdate = $('#fromdate').jqxDateTimeInput('val');
                var todate = $('#todate').jqxDateTimeInput('val');
                
                var win= window.open(reurl[0]+"printTForm?branch="+document.getElementById("cmbbranch").value+'&fromdate='+fromdate+'&todate='+todate,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
        }
        
        function funPrint(){
        
          if(document.getElementById("chcklevel4").checked){
            
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
            
             var url=document.URL;
             var reurl=url.split("com/");
             var path= "com/dashboard/accounts/balancesheet/balancesheetlist2.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate;
             var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");      
             win.focus();       
            }
            else {
            
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
            
             var url=document.URL;
             var reurl=url.split("com");
             var path= "com/dashboard/accounts/balancesheet/balancesheetlist.action?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate;
             var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");      
             win.focus();
            
            }
                
        }
       
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

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
                    </table>
                </div>

                <div class="filter-card">
                    <span class="branch" style="display:block; margin-bottom:10px; text-align:center; font-size:13px; color:#2563eb;">Levels</span>
                    
                    <div style="display: flex; flex-direction: column; gap: 8px;">
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <input type="checkbox" id="chcklevel1" name="chcklevel1" class="chcklevels" onchange="checklevel1();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch" style="margin:0;">Level 1</label>
                            <input type="hidden" id="hidchcklevel1" name="hidchcklevel1" value='<s:property value="hidchcklevel1"/>'>
                        </div>
                        
                        <div style="display: flex; align-items: center; gap: 8px;">
                            <input type="checkbox" id="chcklevel2" name="chcklevel2" class="chcklevels" onchange="checklevel2();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch" style="margin:0;">Level 2</label>
                            <input type="hidden" id="hidchcklevel2" name="hidchcklevel2" value='<s:property value="hidchcklevel2"/>'>
                        </div>

                        <div style="display: flex; align-items: center; gap: 8px;">
                            <input type="checkbox" id="chcklevel3" name="chcklevel3" class="chcklevels" onchange="checklevel3();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch" style="margin:0;">Level 3</label>
                            <input type="hidden" id="hidchcklevel3" name="hidchcklevel3" value='<s:property value="hidchcklevel3"/>'>
                        </div>

                        <div style="display: flex; align-items: center; gap: 8px;">
                            <input type="checkbox" id="chcklevel4" name="chcklevel4" class="chcklevels" onchange="checklevel4();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            <label class="branch" style="margin:0;">Level 4</label>
                            <input type="hidden" id="hidchcklevel4" name="hidchcklevel4" value='<s:property value="hidchcklevel4"/>'>
                        </div>
                    </div>
                </div>

            </div>

            <div class="sidebar-fixed-bottom">
                <div class="button-group" style="margin: 0;">
                    <button type="button" class="myButton" id="btnprint" onclick="funPrint();">
                        Print
                    </button>
                </div>
            </div>

        </div>
    </div>
</td>

<td class="right-panel" valign="top" style="padding: 15px; background: #ffffff !important;">

    <div style="width: 100%; margin-bottom: 10px;">
        <jsp:include page="../../heading.jsp"></jsp:include>
    </div>

    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="background: transparent !important;">
        <tr>
             <td valign="top" style="background: transparent !important;">
                 <div id="balanceSheetDiv">
                     <jsp:include page="balanceSheetGrid.jsp"></jsp:include>
                 </div>
             </td>
        </tr>
    </table>

</td>

</tr>
</table>

</div>
</div>

</body>
</html>