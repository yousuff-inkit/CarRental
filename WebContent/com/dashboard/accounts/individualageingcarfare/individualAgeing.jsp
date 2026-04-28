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

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

/* Flex 1 allows this middle section to scroll while keeping top and bottom fixed */
.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
}

/* New fixed bottom panel so buttons are always visible */
.sidebar-fixed-bottom {
    padding: 15px 20px;
    border-top: 1px solid #f0f4f8;
    background: #fff;
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; /* Uniform 12px label */
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"] {
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

/* ===== UNIFORM 24px SELECT DROPDOWNS (FIXED) ===== */
select {
    width: 100%;
    height: 24px !important;
    padding: 2px 24px 2px 8px !important; 
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;
    font-size: 12px !important;
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
    font-family: inherit;
    cursor: pointer;
    
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    
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

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit, .myButton {
    flex: 1;
    width: 100%;
    height: 30px !important;            /* Scaled button height */
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled, .myButton:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

/* =========================================================================
   GLOBAL OVERRIDE: Strips inherited green background from all external css 
========================================================================= */
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

    $(document).ready(function () {
         // UPDATED: Standardized height to 24px and width to 100%
         $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         getConfigs();
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
          $('#txtaccid').dblclick(function(){
              if($('#cmbtype').val()==''){
                 $.messager.alert('Message','Please Choose Account Type.','warning');
                 return 0;
              }
              accountsSearchContent('accountsDetailsSearch.jsp');
          });
          
         document.getElementById("rdall").checked=true;
    });
    
    function accountsSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getSalesPerson() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var salesagentItems = items[0].split(",");
                var salesagentIdItems = items[1].split(",");
                var optionssalesagent = '<option value="">--Select--</option>';
                for (var i = 0; i < salesagentItems.length; i++) {
                    optionssalesagent += '<option value="' + salesagentIdItems[i] + '">'
                            + salesagentItems[i] + '</option>';
                }
                $("select#cmbsalesperson").html(optionssalesagent);
                if ($('#hidcmbsalesperson').val() != null) {
                    $('#cmbsalesperson').val($('#hidcmbsalesperson').val());
                }
            } else {
            }
        }
        x.open("GET", "getSalesPerson.jsp", true);
        x.send();
    }
  
   function getCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var categoryItems = items[0].split(",");
                var categoryIdItems = items[1].split(",");
                var optionscategory = '<option value="">--Select--</option>';
                for (var i = 0; i < categoryItems.length; i++) {
                    optionscategory += '<option value="' + categoryIdItems[i] + '">'
                            + categoryItems[i] + '</option>';
                }
                $("select#cmbcategory").html(optionscategory);
                if ($('#hidcmbcategory').val() != null) {
                    $('#cmbcategory').val($('#hidcmbcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getCategory.jsp?type="+$('#cmbtype').val(), true);
        x.send();
    }
    
    function getAccType(event){
        var x= event.keyCode;
        if(x==114){
          if($('#cmbtype').val()==''){
              $.messager.alert('Message','Please Choose Account Type.','warning');
              return 0;
          }
          accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{
         }
        }
        
    function clearAccountInfo(){
        $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
    } 
    
    function funClearInfo(){

        $('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#cmbtype').val('AR');$('#txtdocno').val('');
        $('#txtaccid').val('');$('#txtaccname').val('');$('#cmbsalesperson').val('');$('#cmbcategory').val('');
        
        $("#individualAgeing").jqxGrid('clear');$("#individualAgeing").jqxGrid('addrow', null, {});
        
         if (document.getElementById("txtaccid").value == "") {
                $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
          }
        
         document.getElementById("rdall").checked=true;
         
        }
    
    function funreload(event){
        
         var branchval = document.getElementById("cmbbranch").value;
         var uptodate = $('#uptodate').val();
         var atype = $('#cmbtype').val();
         var accdocno = $('#txtdocno').val();
         var salesperson = $('#cmbsalesperson').val();
         var category = $('#cmbcategory').val();
         var check=1;
         
         if(atype==''){
             $.messager.alert('Message','Please Choose Account Type.','warning');
             return 0;
         }

         $("#overlay, #PleaseWait").show();
         
         if(document.getElementById("rdall").checked==true){
            $("#individualAgeingSummary").jqxGrid('clear');
            $("#individualAgeingDiv").prop("hidden", false);
            $("#summaryDiv").prop("hidden", true);
            var chkolddate=$('#hidchkolddate').val();
            $("#individualAgeingDiv").load("individualAgeingGrid.jsp?chkolddate="+chkolddate+"&branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
         }else if(document.getElementById("rdsummary").checked==true){
            $("#individualAgeingDiv").jqxGrid('clear');
            $("#individualAgeingDiv").prop("hidden", true);
            $("#summaryDiv").prop("hidden", false);
            
            $("#summaryDiv").load("summaryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&salesperson='+salesperson+'&category='+category+'&check='+check);
         }
         
        }
        
         function funExportBtn(){
        
            $("#individualAgeing").excelexportjs({
                containerid: "individualAgeing",
                datatype: 'json',
                dataset: null,
                gridId: "individualAgeing",
                columns: getColumns("individualAgeing") ,
                worksheetName:"Individual Ageing List"
            });
        } 
        
            
    function funPrint(){
         var branchval = document.getElementById("cmbbranch").value;
         var uptodate = $('#uptodate').val();
         var atype = $('#cmbtype').val();
         var accdocno = $('#txtdocno').val();
         //alert("print");
        
         if(atype==''){
             $.messager.alert('Message','Please Choose Account Type.','warning');
             return 0;
         }
         
        var url=document.URL;

         var reurl=url.split("individualAgeing.jsp");
         var brhid=<%=session.getAttribute("BRANCHID").toString()%>
         var win= window.open(reurl[0]+"individualAgeing?branchval="+branchval+'&uptodate='+uptodate+'&atype='+atype+'&accdocno='+accdocno+'&check=1',"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");  
         win.focus();
        
    }
    
    function getConfigs(){
        
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.split("####");
                
                if(parseInt(items[0]) == 1){ 
                    //alert(items[0]);
                    $('#hidAcurrconfig').val(1);
                } else {
                    //alert("ON ELSE "+items[0]);
                    $('#hidAcurrconfig').val(0);      
                }
                
        }
        }
        x.open("GET", "getConfig.jsp", true);  
        x.send();
     }
    
    
    function funToggleOldDate(){
        if(document.getElementById("chkolddate").checked==true){
            $('#hidchkolddate').val("1");
            $('#individualAgeing').jqxGrid('showcolumn','famount');
            $('#individualAgeing').jqxGrid('showcolumn','fcount');
            $('#individualAgeing').jqxGrid('showcolumn','fdate');
            $('#individualAgeing').jqxGrid('showcolumn','fbalance');
        }
        else{
            $('#hidchkolddate').val("0");
            $('#individualAgeing').jqxGrid('hidecolumn','famount');
            $('#individualAgeing').jqxGrid('hidecolumn','fcount');
            $('#individualAgeing').jqxGrid('hidecolumn','fdate');
            $('#individualAgeing').jqxGrid('hidecolumn','fbalance');
        }
    }
</script>
</head>
<body onload="getBranch();getSalesPerson();getCategory();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <div style="display: flex; align-items: center; gap: 5px; margin-bottom: 12px;">
                    <input type="checkbox" name="chkolddate" id="chkolddate" onchange="funToggleOldDate();">
                    <label for="chkolddate" class="branch" style="margin:0;">Further amount from old date</label>  
                    <input type="hidden" name="hidchkolddate" id="hidchkolddate">
                </div>

                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr> 
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();getCategory();" value='<s:property value="cmbtype"/>'>
                                <option value="" >--Select--</option>
                                <option value="AR" selected>AR</option>
                                <option value="AP">AP</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <span class="branch" style="display:block; margin-bottom:10px; text-align:center; font-size:13px; color:#2563eb;">Report Type</span>
                <table width="100%">
                    <tr>
                        <td width="50%" align="center">
                            <input type="radio" id="rdall" name="rdo" value="rdall">
                            <label for="rdall" class="branch">All</label>
                        </td>
                        <td width="50%" align="center">
                            <input type="radio" id="rdsummary" name="rdo" value="rdsummary">
                            <label for="rdsummary" class="branch">Summary</label>
                        </td>
                    </tr>
                </table>
            </div> 

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccType(event);"/>
                        </td>
                    </tr> 
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                        </td>
                    </tr> 
                    <tr>
                        <td class="label-cell">Sales Person</td>
                        <td>
                            <select id="cmbsalesperson" name="cmbsalesperson" value='<s:property value="cmbsalesperson"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbsalesperson" name="hidcmbsalesperson" value='<s:property value="hidcmbsalesperson"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Category</td>
                        <td>
                            <select id="cmbcategory" name="cmbcategory" value='<s:property value="cmbcategory"/>'>
                                <option value="">--Select--</option>
                            </select>
                            <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <input type="hidden" id="txtacountno" name="txtacountno" value='<s:property value="txtacountno"/>'/>
            <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
            <input type="hidden" id="hidAcurrconfig" name="hidAcurrconfig"  value='<s:property value="hidAcurrconfig"/>'/>
        </div>

        <div class="sidebar-fixed-bottom">
            <div class="button-group" style="margin: 0;">
                <input type="button" 
                       class="myButton" 
                       name="clear" 
                       id="clear" 
                       value="Clear" 
                       onclick="funClearInfo();" 
                       style="margin-top:0;">

                <button class="myButton" 
                        type="button" 
                        id="btnprint" 
                        name="btnprint" 
                        onclick="funPrint();" 
                        style="margin-top:0;">
                    Print
                </button>
            </div>
        </div>

    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
             <div id="individualAgeingDiv"><jsp:include page="individualAgeingGrid.jsp"></jsp:include></div>
             <div id="summaryDiv" hidden="true"><jsp:include page="summaryGrid.jsp"></jsp:include></div>
        </div>
    </div>
</div>
</div>

<div id="accountDetailsWindow">
    <div></div><div></div>
</div>
</body>
</html>