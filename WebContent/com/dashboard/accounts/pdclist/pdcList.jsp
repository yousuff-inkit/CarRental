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

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 15px; 
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
    margin-top: 8px;
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

/* New fixed bottom panel so buttons are always visible */
.sidebar-fixed-bottom {
    padding: 15px 20px;
    border-top: 1px solid #f0f4f8;
    background: #fff;
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
         $("#fromdate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         $("#todate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
         var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
         var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
         $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
         document.getElementById("rdpayment").checked=true;
         document.getElementById("rdall").checked=true;
         document.getElementById("chckunclrposted").checked = false;
         $('#chckunclrposted').attr('disabled', true);
         $('#hidchckunclrposted').val('0');
         
         $('#txtaccid').dblclick(function(){
             if($('#cmbtype').val()==''){
                 $.messager.alert('Message','Please Choose Account Type.','warning');
                 return 0;
             }
              accountsSearchContent('accountsDetailsSearch.jsp');
            });
         
             document.getElementById('rdall').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', false);
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', true);
             });
             
             document.getElementById('rdpdc').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', false);
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', true);
             });
             
             document.getElementById('rduncleared').addEventListener('change', function (e) {
                 $('#cmbcriteria').attr('disabled', true);
                 $('#cmbcriteria').val('1');
                 document.getElementById("chckunclrposted").checked = false;
                 $('#hidchckunclrposted').val('0');
                 $('#chckunclrposted').attr('disabled', false);
             });

    });
    
    function accountsSearchContent(url) {
        $('#accountDetailsWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#accountDetailsWindow').jqxWindow('setContent', data);
        $('#accountDetailsWindow').jqxWindow('bringToFront');
    }); 
    }
    
    function getAccTypeFrom(event){
        var x= event.keyCode;
        if(x==114){
            if($('#cmbtype').val()==''){
                 $.messager.alert('Message','Please Choose Account Type.','warning');
                 return 0;
             }
            accountsSearchContent('accountsDetailsSearch.jsp');
        }
        else{}
        }
    
     function dateDisable(){
         var posted=$('#cmbcriteria').val();
         if(posted==2){
             $('#jqxFromDate').jqxDateTimeInput({disabled: true}); 
         }else{
             $('#jqxFromDate').jqxDateTimeInput({disabled: false});
         }
      }
    
    function clearAccountInfo(){
        $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
        
        if (document.getElementById("txtaccid").value == "") {
            $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }

    }
    
    function  funClearInfo(){
        
        $('#fromdate').val(new Date());
        var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');;
        var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
        var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
        $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
         
        $('#todate').val(new Date());
        
        document.getElementById("rdpayment").checked=true;
        document.getElementById("rdall").checked=true;
        
        $('#cmbbranch').val('a');$('#cmbcriteria').val('1');$('#cmbcriteria').attr('disabled', false);
        $('#cmbdistribution').val('');$('#cmbgroup').val('');$('#cmbtype').val('0');
        $('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');
        $('#hidchckunclrposted').val('0');$('#chckunclrposted').attr('disabled', false);
        document.getElementById("chckunclrposted").checked = false;
        
        $("#jqxPdcList").jqxGrid('clear');
        $("#jqxPdcList").jqxGrid('addrow', null, {});
        $("#jqxPdcListGroup").jqxGrid('clear');
        $("#jqxDistributionGrid").jqxGrid('clear');
        
        if (document.getElementById("txtaccid").value == "") {
            $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
        }
        
        $("#pdcListDiv").prop("hidden", false);
        $("#pdcListGroupDiv").prop("hidden", true);
        $("#pdcListDistributionDiv").prop("hidden", true);
        
        }

    function funreload(event){
             funGroupDistributionGrid();
             
             var branchval = document.getElementById("cmbbranch").value;
             var fromdate = $('#fromdate').val();
             var todate = $('#todate').val();
             var criteria = $('#cmbcriteria').val();
             var distribution = $('#cmbdistribution').val();
             var group = $('#cmbgroup').val();
             var acctype = $('#cmbtype').val();
             var accno = $('#txtdocno').val();
             var unclrposted = $('#hidchckunclrposted').val();
             var reporttype = "";
             
             if(document.getElementById("rdall").checked==true){
                 reporttype = $('#rdall').val();
             }else if(document.getElementById("rdpdc").checked==true){
                 reporttype = $('#rdpdc').val();
             }else if(document.getElementById("rduncleared").checked==true){
                 reporttype = $('#rduncleared').val();
             }
             
             $("#overlay, #PleaseWait").show();
             
             if(document.getElementById("rdreceipt").checked==true){
                 if(group=='' && distribution==''){
                      $("#pdcListDiv").load("pdcListGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');                               
                 }else if(group!='' && distribution==''){
                     $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
                 }else{
                     $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
                 }
             }else{
                 if(group=='' && distribution==''){
                      $("#pdcListDiv").load("pdcListGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1');                               
                 }else if(group!='' && distribution==''){
                     $("#pdcListGroupDiv").load("pdcListGroupingGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=3');
                 }else{
                     $("#pdcListDistributionDiv").load("pdcListDistributionGrid.jsp?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=2');
                 }
                }
            }
    
    function funGroupDistributionGrid(){
        var group=$('#cmbgroup').val();
        var distribution=$('#cmbdistribution').val();
        if(group=='' && distribution==''){
            $("#pdcListDiv").prop("hidden", false);
            $("#pdcListGroupDiv").prop("hidden", true);
            $("#pdcListDistributionDiv").prop("hidden", true);
        }else if(group!='' && distribution==''){
            $("#pdcListDiv").prop("hidden", true); 
            $("#pdcListGroupDiv").prop("hidden", false);
            $("#pdcListDistributionDiv").prop("hidden", true);
        }else{
            $("#pdcListDiv").prop("hidden", true); 
            $("#pdcListGroupDiv").prop("hidden", true);
            $("#pdcListDistributionDiv").prop("hidden", false);
        }
    }
    
    function checkunclrposted() {
        if(document.getElementById("chckunclrposted").checked) {
             document.getElementById("hidchckunclrposted").value = 1;
         } else {
             document.getElementById("hidchckunclrposted").value = 0;
         }
     }
    
    function funExportBtn(){
         var distribute = $('#cmbdistribution').val();
         var grouping = $('#cmbgroup').val();
         var gridid='';
        if(grouping=='' && distribute==''){
            gridid='jqxPdcList';
        }
        else if(grouping!='' && distribute==''){
            gridid='jqxPdcListGroup';
        }
        else if(!((grouping=='' && distribute=='') && (grouping!='' && distribute==''))){
            gridid='jqxDistributionGrid';
        }
        $("#"+gridid).excelexportjs({
            containerid:gridid,
            datatype: 'json',
            dataset: null,
            gridId: gridid,
            columns: getColumns(gridid) ,
            worksheetName:"PDC List"
        });
    }
    function funprint(){
        var url=document.URL;
        var reurl=url.split("/com");
        var branchval = document.getElementById("cmbbranch").value;
         var fromdate = $('#fromdate').val();
         var todate = $('#todate').val();
         var criteria = $('#cmbcriteria').val();
         var distribution = $('#cmbdistribution').val();
         var group = $('#cmbgroup').val();
         var acctype = $('#cmbtype').val();
         var accno = $('#txtdocno').val();
         var unclrposted = $('#hidchckunclrposted').val();
         var reporttype = "";
         
         if(document.getElementById("rdall").checked==true){
             reporttype = $('#rdall').val();
         }else if(document.getElementById("rdpdc").checked==true){
             reporttype = $('#rdpdc').val();
         }else if(document.getElementById("rduncleared").checked==true){
             reporttype = $('#rduncleared').val();
         }
        //alert(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?branch="+document.getElementById("cmbbranch").value+"&fromdate="+fromdate+"&todate="+todate+"&reporttype="+reporttype+"&criteria="+criteria+"&distribution="+distribution+"&group="+group+"&acctype="+acctype+"&accno="+accno);
         
        //var win=window.open(reurl[0]+"com/dashboard/accounts/pdclist/"+"printpdcjasper?branchval="+branchval+"&fromdate="+fromdate+"&todate="+todate+"&reporttype="+reporttype+"&criteria="+criteria+"&distribution="+distribution+"&group="+group+"&acctype="+acctype+"&accno="+accno,"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
        
        if(document.getElementById("rdreceipt").checked==true){
            var win=window.open(reurl[0]+"/com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FRO&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
         }else{
             var win=window.open(reurl[0]+"/com/dashboard/accounts/pdclist/"+"printpdcjasper?code=FPP&reporttype="+reporttype+'&branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&criteria='+criteria+'&distribution='+distribution+'&group='+group+'&acctype='+acctype+'&accno='+accno+'&unclrposted='+unclrposted+'&check=1',"_blank","top=250,left=310,width=800,height=800,location=no,scrollbars=no,toolbar=yes");
            }
        
    }
    
        
</script>

</head>
<body onload="getBranch();">
    <div id="mainBG" class="homeContent" data-type="background"> 
        <div class='hidden-scrollbar'>
            <div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

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
                </table>
            </div>

            <div class="filter-card">
                <span class="branch" style="display:block; margin-bottom:10px; text-align:center; font-size:13px; color:#2563eb;">Report Type</span>
                <table width="100%">
                    <tr>
                        <td width="50%" align="center">
                            <input type="radio" id="rdpayment" name="rdo" value="FPP">
                            <label for="rdpayment" class="branch">Payment</label>
                        </td>
                        <td width="50%" align="center">
                            <input type="radio" id="rdreceipt" name="rdo" value="FRO">
                            <label for="rdreceipt" class="branch">Receipt</label>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <span class="branch" style="display:block; margin-bottom:10px; text-align:center; font-size:13px; color:#2563eb;">Type</span>
                <table width="100%">
                    <tr>
                        <td width="50%" align="center">
                            <input type="radio" id="rdall" name="rdos" value="rdall">
                            <label for="rdall" class="branch">All</label>
                        </td>
                        <td width="50%" align="center">
                            <input type="radio" id="rdpdc" name="rdos" value="rdpdc">
                            <label for="rdpdc" class="branch">PDC</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="padding-top: 15px; border-top: 1px solid #e1e8ed; margin-top: 10px;">
                            <input type="radio" id="rduncleared" name="rdos" value="rduncleared">
                            <label for="rduncleared" class="branch">Uncleared</label>
                            <div style="margin-top: 8px;">
                                <input type="checkbox" id="chckunclrposted" name="chckunclrposted" value="" onchange="checkunclrposted();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                <label class="branch" for="chckunclrposted">Uncleared Posted</label>
                            </div>
                            <input type="hidden" id="hidchckunclrposted" name="hidchckunclrposted" value='<s:property value="hidchckunclrposted"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Criteria</td>
                        <td>
                            <select id="cmbcriteria" name="cmbcriteria" onchange="dateDisable();" value='<s:property value="cmbcriteria"/>'>
                                <option value="1">All</option>
                                <option value="2">To be Posted</option>
                                <option value="3">Posted PDC</option>
                                <option value="4">Returned PDC</option>
                                <option value="5">Dishonoured PDC</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Distribution</td>
                        <td>
                            <select id="cmbdistribution" name="cmbdistribution" value='<s:property value="cmbdistribution"/>'>
                                <option value="">--Select--</option>
                                <option value="monthwise">Month-Wise</option>
                                <option value="bankwise">Bank-Wise</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Grouping</td>
                        <td>
                            <select id="cmbgroup" name="cmbgroup" value='<s:property value="cmbgroup"/>'>
                                <option value="">--Select--</option>
                                <option value="date">Date</option>
                                <option value="month">Month</option>
                                <option value="bank">Bank</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Acc. Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" onchange="clearAccountInfo();" value='<s:property value="cmbtype"/>'>
                                <option value="0">--Select--</option>
                                <option value="BANK">Bank</option>
                                <option value="AP">AP</option>
                                <option value="AR">AR</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Account</td>
                        <td>
                            <input type="text" id="txtaccid" name="txtaccid" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <input type="text" id="txtaccname" name="txtaccname" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
                            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>
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

                <input type="button"
                       class="myButton"
                       name="Print"
                       id="print"
                       value="Print"
                       onclick="funprint();"
                       style="margin-top:0;">
            </div>
        </div>

    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="pdcListDiv">
                <jsp:include page="pdcListGrid.jsp"></jsp:include>
            </div>
            <div id="pdcListGroupDiv" hidden="true">
                <jsp:include page="pdcListGroupingGrid.jsp"></jsp:include>
            </div>
            <div id="pdcListDistributionDiv" hidden="true">
                <jsp:include page="pdcListDistributionGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="accountDetailsWindow">
    <div></div><div></div>
</div>
</div> 
</body>
</html>