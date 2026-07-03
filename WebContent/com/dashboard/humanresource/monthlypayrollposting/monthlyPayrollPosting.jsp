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
.release-filter-table div[id^="uptodate"],
.release-filter-table div[id^="postingDate"] {
    width: 100%;
}

.lbl-last-posted {
    font-size: 13px;
    color: #2563eb;
    font-weight: bold;
    text-align: center;
    margin: 8px 0;
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
    gap: 15px;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
}

.grid-wrapper {
    flex: 1; /* Allow grids to share vertical space evenly */
    min-height: 250px; /* Prevent grids from collapsing too much */
}

</style>

<script type="text/javascript">
    $(document).ready(function () {
        
         $("#uptodate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"MM.yyyy"});
         $("#postingDate").jqxDateTimeInput({ width: '100%', height: '24px',formatString:"dd.MM.yyyy"});
         
         $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
         $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
         
         $('#uptodate').focusout(function(){
             getLastPayrollPostedDate();
         });
         
         getLastPayrollPostedDate();
    });
    
    function getLastPayrollPostedDate(){
        var employeebranchchk=window.parent.employeebranchchk.value; 
        var branch=document.getElementById("cmbbranch").value;  
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                 var items = x.responseText;
                 items = items.split('***');
                 
                 $('#uptodate').val(items[0]);
                 document.getElementById("lbllastposted").innerText=items[1].trim();
            }
        }
        x.open("GET", 'getLastPayrollPostedDate.jsp?branch='+branch+'&employeebranchchk='+employeebranchchk, true); 
        x.send();
    }
    
    function  funClearData(){
        $('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');
        $('#txtselectedemployees').val('');disable();$('#txtdrtotal').val('');$('#txtcrtotal').val('');
        $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollTotalGridID").jqxGrid('clear');
        $("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
        $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});getLastPayrollPostedDate();
        document.getElementById("gridlength").value="";document.getElementById("mode").value="";document.getElementById("msg").value="";
     }
    
    function funreload(event){
        
         var branchval = document.getElementById("cmbbranch").value;
         var uptodate = $('#uptodate').val();
         
         if(uptodate==''){
             $.messager.alert('Message','Save Payroll and Post.','warning');
             return;
         }
         
         var check = 1;
         $("#monthlyPayrollPostingGridID").jqxGrid('clearselection');$("#monthlyPayrollPostingGridID").jqxGrid('clear');$("#monthlyPayrollPostingGridID").jqxGrid('addrow', null, {});$("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
         $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: true});$('#txtdrtotal').val('');$('#txtcrtotal').val('');
         $('#postingDate').val(new Date());$('#txtremarks').val('');$('#txtremarks').attr('placeholder', 'Remarks');document.getElementById("gridlength").value="";
         document.getElementById("mode").value="";document.getElementById("msg").value="";$('#txtselectedemployees').val('');$('#btnpost').attr("disabled",true);$('#postingDate').jqxDateTimeInput({ disabled: true});
         
         $("#overlay, #PleaseWait").show();
         
         $("#monthlypayrollTotalDiv").load("monthlyPayrollTotalGrid.jsp?branchval="+branchval+'&uptodate=01.'+uptodate+'&check='+check);
         
    }

    function disable(){
         $('#postingDate').jqxDateTimeInput({ disabled: true});
         $('#txtremarks').attr("readonly",true);
         $('#btnpost').attr("disabled",true);
         $("#monthlyPayrollPostingGridID").jqxGrid({ disabled: true});
         $("#payrollPostingJVGridID").jqxGrid({ disabled: true});
    }
    
    function funCalculate(){
        
        var rows = $('#monthlyPayrollPostingGridID').jqxGrid('getrows');
        if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
            $.messager.alert('Message','Select Payroll to be Posted & Calculate.','warning');
            return 0;
        } 
         var paymentPostingdate =$('#postingDate').jqxDateTimeInput('getDate');
          var validdate=funDateInPeriod(paymentPostingdate);
          if(parseInt(validdate)==0){
                return 0;   
             }
        var rows = $('#payrollPostingJVGridID').jqxGrid('getrows');
        var rowlength= rows.length;
        if(rowlength!=0){
            $.messager.alert('Message','Already calculated.Submit Again. ','warning');
            return 0;
        } else{
            $("#payrollPostingJVGridID").jqxGrid('clear');
            $('#txtselectedemployees').val('');
        } 
        
        $("#overlay, #PleaseWait").show();
        
        var rows = $("#monthlyPayrollPostingGridID").jqxGrid('getrows');
        
        if(rows.length==1 && (rows[0].netsalary=="undefined" || rows[0].netsalary==null || rows[0].netsalary=="")){
            return false;
        }
        
        var selectedrows=$("#monthlyPayrollPostingGridID").jqxGrid('selectedrowindexes');
        selectedrows = selectedrows.sort(function(a,b){return a - b});
        
        if(selectedrows.length==0){
            $("#overlay, #PleaseWait").hide();
            $.messager.alert('Warning','Select Items to be Calculated.');
            return false;
        }
        
        var i=0;var tempempdocnos="",tempempcatids="";
        $('#gridlength').val(selectedrows.length);
        var j=0; var k=0;
        for (i = 0; i < rows.length; i++) {
                if(selectedrows[j]==i){
                    
                    if(k==1){
                        tempempdocnos=tempempdocnos+","+rows[i].employeedocno;
                        tempempcatids=tempempcatids+","+rows[i].empcatid;
                    } else {
                        tempempdocnos=rows[i].employeedocno;
                        tempempcatids=rows[i].empcatid;
                        k=1;
                    }
                j++; 
              }
            }
        
        $('#txtselectedemployees').val(tempempdocnos);
        $('#txtcategoryids').val(tempempcatids);
        var checked = 1;
        
        $("#payrollPostingJVGridID").jqxGrid('clear');$("#payrollPostingJVGridID").jqxGrid({ disabled: false});
        $('#postingDate').jqxDateTimeInput({ disabled: false});$('#txtremarks').attr("readonly",false);$('#btnpost').attr("disabled",false);
        $("#JVTDiv").load("monthlyJVGrid.jsp?branchval="+$('#cmbbranch').val()+'&uptodate=01.'+$('#uptodate').val()+'&category='+$('#txtcategoryids').val()+'&employees='+$('#txtselectedemployees').val()+'&postdate='+$('#postingDate').val()+'&checked='+checked);
        
    }
    
    function funPost(event){
        funNotify();
    }
    
    function funNotify() {  
        
           $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
            if (r){
                    
            /* Journal Voucher Grid Saving */
             var rows = $("#payrollPostingJVGridID").jqxGrid('getrows');
             var length=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].docno;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "test"+length)
                    .attr("name", "test"+length)
                    .attr("hidden", "true");
                    length=length+1;
                    
                var amount,baseamount,id;
                if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
                     amount=rows[i].credit*-1;
                     baseamount=rows[i].baseamount*-1;
                     id=-1;
                }
                
                if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
                     amount=rows[i].debit;
                     baseamount=rows[i].baseamount;
                     id=1;
                }
                
                newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+baseamount+"::"+amount+":: 0::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
                
                newTextBox.appendTo('form');
                }
             }
             $('#gridlength').val(length);
            /* Journal Voucher Grid Saving Ends */
            
             document.getElementById("mode").value='A';
             $("#overlay, #PleaseWait").show();
             document.getElementById("frmDashboardMonthlyPayrollPosting").submit();
            
             }
            });
        
        return 1;
    } 
    
    function setValues(){
        
          if($('#hiduptodate').val()){
             $("#uptodate").jqxDateTimeInput('val', $('#hiduptodate').val());
          }

          if($('#hidpostingDate').val()){
             $("#postingDate").jqxDateTimeInput('val', $('#hidpostingDate').val());
          }
  
          if($('#msg').val()!=""){
             $.messager.alert('Message',$('#msg').val());
             getLastPayrollPostedDate();funreload(event);disable(); 
         }
    }
</script>
</head>
<body onload="getBranch();disable();setValues();">

<form id="frmDashboardMonthlyPayrollPosting" action="saveDashboardMonthlyPayrollPosting" method="post">
<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">
                
                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Up To</td>
                            <td>
                                <div id="uptodate"></div>
                                <input type="hidden"
                                       id="hiduptodate"
                                       name="hiduptodate"
                                       value='<s:property value="hiduptodate"/>'>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="lbl-last-posted">
                        <label id="lbllastposted" name="lbllastposted">
                            <s:property value="lbllastposted"/>
                        </label>
                    </div>
                </div>

                <div class="filter-card">
                    <div id="monthlypayrollTotalDiv">
                        <jsp:include page="monthlyPayrollTotalGrid.jsp"></jsp:include>
                    </div>
                </div>

                <div class="filter-card">
                    <table class="release-filter-table">
                        <tr>
                            <td class="label-cell">Posting</td>
                            <td>
                                <div id="postingDate"></div>
                                <input type="hidden"
                                       id="hidpostingDate"
                                       name="hidpostingDate"
                                       value='<s:property value="hidpostingDate"/>'>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Remarks</td>
                            <td>
                                <input type="text"
                                       id="txtremarks"
                                       name="txtremarks"
                                       placeholder="Remarks"
                                       value='<s:property value="txtremarks"/>'>
                            </td>
                        </tr>
                    </table>
                    
                    <div class="release-actions">
                        <button type="button" class="btn-submit" onclick="funClearData();">Clear</button>
                        <button type="button" id="btnpost" class="btn-submit" onclick="funPost(event);">Post</button>
                    </div>
                </div>

                <input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'>
                <input type="hidden" id="txtcategoryids" name="txtcategoryids" value='<s:property value="txtcategoryids"/>'>
                <input type="hidden" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>'>
                <input type="hidden" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>'>
                <input type="hidden" id="gridlength" name="gridlength">
                <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
                <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div class="grid-wrapper" id="monthlyPayrollPostingDiv">
                    <jsp:include page="monthlyPayrollPostingGrid.jsp"></jsp:include>
                </div>
                
                <div class="grid-wrapper" id="JVTDiv">
                    <jsp:include page="monthlyJVGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

</div>
</form>

</body>
</html>