<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">
/* =========================================================
SCOPED UI: Modern Layout 
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px;
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }
.modern-ui .myButton:disabled { background: #adb5bd !important; cursor: not-allowed; opacity: 0.7; box-shadow: none; }

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: flex;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Grid Wrappers */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Checkbox alignment */
.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
}
.chk-container input { margin: 0; }

#lblcurrentstatus {
    color: #d32f2f;
    font-weight: bold;
    text-align: center;
    display: block;
    margin-top: 5px;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 120px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Existing user JQX Grid Specific Overrides */
.jqx-grid-header { background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important; border-color: #ced4da !important; color: #212529 !important; font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; }
.jqx-grid-column-header { background: transparent !important; color: #212529 !important; font-weight: 700 !important; font-size: 11px !important; text-align: left !important; border-color: #ced4da !important; }
.jqx-grid-column-header a:link, .jqx-grid-column-header a:visited { color: #212529 !important; text-align: left !important; }
.jqx-grid-column-header > div > div { text-align: left !important; padding-left: 6px !important; }
.jqx-grid-cell { background: #ffffff; border-color: #dee2e6 !important;  border-width: 0px 0px 1px 0px !important; color: #1f2937; font-size: 11px !important; text-align: left !important; }
.jqx-grid-cell-left-align { text-align: left !important; padding-left: 6px !important; margin-left: 0px !important; }
.jqx-grid-cell-middle-align { text-align: left !important; padding-left: 6px !important; }
.jqx-grid-cell-right-align { text-align: right !important; padding-right: 6px !important; }
.jqx-grid-cell-alt { background: #f1f3f5 !important; }
.jqx-grid-cell-hover { background: #dee2e6 !important; border-color: #ced4da !important; color: #000000 !important; }
.jqx-grid-cell-selected { background: #adb5bd !important; color: #ffffff !important; border-color: #868e96 !important; }
.jqx-grid-table .jqx-grid-cell { border-width: 0px 0px 1px 0px !important; border-color: #dee2e6 !important; }
.jqx-grid { border: 1px solid #adb5bd !important; border-radius: 8px !important; overflow: hidden !important; box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important; }
.jqx-grid-cell-sort { background-color: #e9ecef !important; }
.jqx-grid-cell-sort-alt { background-color: #dee2e6 !important; }
.jqx-grid-cell-filter, .jqx-grid-cell-filter-alt { background-color: #f1f3f5 !important; }
.jqx-grid-cell-pinned, .jqx-grid-cell-pinned-alt { background-color: #e9ecef !important; }
.jqx-grid-pager { background: #e9ecef !important; border-top: 1px solid #ced4da !important; padding: 4px !important; }
.jqx-scrollbar-state-normal { background: #f1f3f5 !important; }
.jqx-scrollbar-thumb-state-normal, .jqx-scrollbar-thumb-state-normal-horizontal { background: #868e96 !important; border-color: #868e96 !important; border-radius: 4px !important; }
.jqx-scrollbar-thumb-state-hover, .jqx-scrollbar-thumb-state-hover-horizontal { background: #495057 !important; border-radius: 4px !important; }
</style>

<script type="text/javascript">
      $(document).ready(function () {
          
         // Bulletproof disabling ALL buttons EXCEPT Print
         $('#btnNew, #btnCreate, #btnSave, #btnEdit, #btnDelete, #btnSearch, #btnExcel, #btnClose, #btnAttach, #btnAttachment, #attachBtn, #btnApprove, #btnApproval').prop('disabled', true)
            .css({'pointer-events': 'none', 'opacity': '0.5'})
            .attr('tabindex', '-1');

         // Keep strictly Print alive
         $('#btnPrint').prop('disabled', false)
            .css({'pointer-events': 'auto', 'opacity': '1'})
            .removeAttr('tabindex');
         
         /* Date Formatting */
         $("#payrollDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
         $("#payrollPrintDate").jqxDateTimeInput({ width: '125px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
         
         /* force internal alignment AFTER render */
         setTimeout(function () {
             $("#payrollDate, #payrollPrintDate").find("input").css({
                 "margin-top": "0px",
                 "line-height": "24px",
                 "font-size": "12px", 
                 "font-family": "Arial, sans-serif", 
                 "padding": "0 6px", 
                 "box-sizing":"border-box"
             });
             $("#payrollDate, #payrollPrintDate").find(".jqx-action-button").css({
                 "top": "0px",
                 "height": "24px"
             });
         }, 0);
          
         /* Searching Window */
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
        
         $('#txtemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });
        
         $('#txtprintemployeeid').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });
        
        $('#btnPayrollEmail').attr('disabled', true );
        
        $(".chckpayrollprocessprint").click(function() {
            selectedBox = this.id;

            $(".chckpayrollprocessprint").each(function() {
                if ( this.id == selectedBox )
                {
                    this.checked = true;
                }
                else
                {
                    this.checked = false;
                };        
            }); 
        }); 
        
         if($('#docno').val().trim()==''){
            $('#mode').val('view');$('#docno').val('0');
         } else if(parseInt($('#docno').val().trim())==0){
            $('#mode').val('A'); 
         } else if(parseInt($('#docno').val().trim())>0){
            $('#mode').val('E'); 
         } else {
            $('#mode').val('view');
         }
        
         $('#txtemployeeid').attr('readonly', true);
         $('#txtemployeename').attr('readonly', true);
         $('#txtprintemployeeid').attr('readonly', true);
         $('#txtprintemployeename').attr('readonly', true);
         $('#payrollDate').jqxDateTimeInput('focus'); 
         $("#monthlyPayrollGridID").jqxGrid('clear');
         $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
         /* $("#monthlyPayrollGridID").jqxGrid({ disabled: true}); */
         $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
         document.getElementById("lblcurrentstatus").innerText="";
         $('#hidchckpayrollprocess').val(1);document.getElementById("chckpayrollprocess").checked = true;
         $('#hidchckpayrollprint').val(0);document.getElementById("chckpayrollprint").checked = false;
         $('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;

         $('#payrollPrintDate').jqxDateTimeInput({disabled: true});
         $('#cmbempprintcategory').attr('disabled', true);
         $('#txtprintemployeeid').attr('disabled', true);
         $('#txtprintemployeename').attr('disabled', true);
         $('#chckpayslip').attr('disabled', true);
         $('#btnPayrollPrint').attr('disabled', true );
         $('#btnView').attr('disabled', true );
         $('#clearPrint').attr('disabled', true );
        
         var date = $('#payrollDate').val();
         getPayrollDate(date);getPayrollCategory();getLeaveType();getAllowanceType();
        
         $('#payrollDate').focusout(function(){
             var date = $('#payrollDate').val();
             getPayrollDate(date);getPayrollDocNo(date);
         });
         $('#payrollDate').on('close', function (event) { 
             var date = $('#payrollDate').val();
             getPayrollDate(date);getPayrollDocNo(date);
         }); 
         $('#payrollPrintDate').focusout(function(){
             var date = $('#payrollPrintDate').val();
             getPayrollPrintDate(date);getPayrollPrintDocNo(date);
         });
        
      }); 
      
      function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
     function getPayrollDate(date){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#payrollDate').val(items);
            }
            }
            x.open("GET", "getPayrollDate.jsp?date="+date, true);
            x.send();
     }
     
     function getPayrollPrintDate(date){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    $('#payrollPrintDate').val(items);
            }
            }
            x.open("GET", "getPayrollDate.jsp?date="+date, true);
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
                $("select#cmbempprintcategory").html(optionspayrollcategory);
                if ($('#hidcmbempcategory').val() != null) {
                    $('#cmbempcategory').val($('#hidcmbempcategory').val());
                }
                if ($('#hidcmbempprintcategory').val() != null) {
                    $('#cmbempprintcategory').val($('#hidcmbempprintcategory').val());
                }
            } else {
            }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
    }
    
    function getLeaveType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var leavetypeItems = items[0].split(",");
                var leavetypeIdItems = items[1].split(",");
                var leavetypeCountItems = items[2].split(",");
                
                for (var i = 0; i < leavetypeItems.length; i++) {
                    
                    if(i==0){
                        $('#txtleavetype1').val(leavetypeItems[i]);
                    } else if(i==1){
                        $('#txtleavetype2').val(leavetypeItems[i]);
                    } else if(i==2){
                        $('#txtleavetype3').val(leavetypeItems[i]);
                    } else if(i==3){
                        $('#txtleavetype4').val(leavetypeItems[i]);
                    } else if(i==4){
                        $('#txtleavetype5').val(leavetypeItems[i]);
                    } else if(i==5){
                        $('#txtleavetype6').val(leavetypeItems[i]);
                    } else if(i==6){
                        $('#txtleavetype7').val(leavetypeItems[i]);
                    } else if(i==7){
                        $('#txtleavetype8').val(leavetypeItems[i]);
                    } else if(i==8){
                        $('#txtleavetype9').val(leavetypeItems[i]);
                    } else {
                        $('#txtleavetype10').val(leavetypeItems[i]);
                    }                                   
                    $('#txtleavetypecount').val(leavetypeCountItems[i]);
                }
            } else {
            }
        }
        x.open("GET", "getLeaveType.jsp", true);
        x.send();
    }
    
    function getAllowanceType() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('####');
                var allowancetypeItems = items[0].split(",");
                var allowancetypeIdItems = items[1].split(",");
                var allowancetypeCountItems = items[2].trim();

                for (var i = 0; i < allowancetypeItems.length; i++) {
                    
                    if(i==0){
                        $('#txtallowancetype1').val(allowancetypeItems[i]);
                    } else if(i==1){
                        $('#txtallowancetype2').val(allowancetypeItems[i]);
                    } else if(i==2){
                        $('#txtallowancetype3').val(allowancetypeItems[i]);
                    } else if(i==3){
                        $('#txtallowancetype4').val(allowancetypeItems[i]);
                    } else if(i==4){
                        $('#txtallowancetype5').val(allowancetypeItems[i]);
                    } else if(i==5){
                        $('#txtallowancetype6').val(allowancetypeItems[i]);
                    } else if(i==6){
                        $('#txtallowancetype7').val(allowancetypeItems[i]);
                    } else if(i==7){
                        $('#txtallowancetype8').val(allowancetypeItems[i]);
                    } else if(i==8){
                        $('#txtallowancetype9').val(allowancetypeItems[i]);
                    } else {
                        $('#txtallowancetype10').val(allowancetypeItems[i]);
                    }                                   
                }
                $('#txtallowancetypecount').val(allowancetypeCountItems);
            } else {
            }
        }
        x.open("GET", "getAllowanceType.jsp", true);
        x.send();
    }
    
    function getLastPayrollDate(payrolldate){
        var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
        var branch=document.getElementById("brchName").value; 
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                 items = items.split('***');
                 $('#txtchkgridload').val(items[0]);
                 document.getElementById("errormsg").innerText="Payroll Processed till "+items[1]+".";
                 
                 if(parseInt($('#txtchkgridload').val())==1){
                     $("#overlay, #PleaseWait").show();
                     $('#txtchkgridload').val('');
                     document.getElementById("lblcurrentstatus").innerText="Payroll to be Saved.";
                     funLoadGrid();
                 } else if(parseInt($('#txtchkgridload').val())==0) {
                     $.messager.alert('Message','Payroll Process Pending for Last-Month.','warning');
                     $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="Pending for Last-Month.";
                      $('#mode').val('view');
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==2) {
                     $.messager.alert('Message','Already Payroll Processed.','warning');
                     $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="Already Processed.";
                      $('#mode').val('E');
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==3) {
                     $.messager.alert('Message','Enter Attendance & Process Payroll','warning');
                     $("#monthlyPayrollGridID").jqxGrid('clear'); 
                      $("#monthlyPayrollGridID").jqxGrid('addrow', null, {});
                      $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
                      document.getElementById("lblcurrentstatus").innerText="";
                      $('#mode').val('view');
                      document.getElementById("errormsg").innerText="";
                      return;
                 } else if(parseInt($('#txtchkgridload').val())==4) {
                     document.getElementById("lblcurrentstatus").innerText="Payroll Processed.";
                      $('#mode').val('E');
                      $("#overlay, #PleaseWait").show();
                      funLoadGrid();
                 } else if(parseInt($('#txtchkgridload').val())==5) {
                      $("#overlay, #PleaseWait").show();
                      document.getElementById("lblcurrentstatus").innerText="Payroll Confirmed.";
                      $('#mode').val('view');
                      funLoadGrid();
                 }
                 
               
        }
        }
        x.open("GET", "getLastPayrolledDate.jsp?payrolldate="+payrolldate+"&branch="+branch+"&employeebranchchk="+employeebranchchk, true);
        x.send();
    }
    
    function getPayrollDocNo(payrolldate){
        var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
        var branch=document.getElementById("brchName").value; 
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#docno').val(items);
              
                if(items.trim()==''){
                    $('#mode').val('view');$('#docno').val('0');
                } else if(parseInt(items.trim())==0){
                    $('#mode').val('A'); 
                } else if(parseInt(items.trim())>0){
                    $('#mode').val('E'); 
                } else {
                    $('#mode').val('view');
                }
        }
        }
        x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate+"&branch="+branch+"&employeebranchchk="+employeebranchchk, true);
        x.send();
    }
    
    function getPayrollPrintDocNo(payrolldate){ 
        var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
        var branch=document.getElementById("brchName").value; 
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                $('#docno').val(items);
              
                if(items.trim()==''){
                    $('#docno').val('0');
                }
        }
        }
        x.open("GET", "getPayrollDocNo.jsp?payrolldate="+payrolldate+"&branch="+branch+"&employeebranchchk="+employeebranchchk, true);
        x.send();
    }
    
    function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
            employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
        }

    function funExcelBtn(){
           $("#payrollDiv").excelexportjs({  
            containerid: "payrollDiv", 
            datatype: 'json', 
            dataset: null, 
            gridId: "monthlyPayrollGridID", 
            columns: getColumns("monthlyPayrollGridID") , 
            worksheetName:"MonthlyPayroll"
            }); 
     }
    
     function funLoadGrid() {
        
          var mode = $('#mode').val();
          var docno = $('#docno').val().trim(); 
          var date = $('#payrollDate').jqxDateTimeInput('val');
          var category = $('#cmbempcategory').val();
          var empid = $('#txtemployeedocno').val();
          var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
          var branch=document.getElementById("brchName").value;  
          $("#payrollDiv").load("monthlyPayrollGrid.jsp?mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1"+"&branch="+branch+"&employeebranchchk="+employeebranchchk);
          $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', true );
          
          if(mode=='E'){
             $('#btnConfirmed').attr('disabled', false ); 
          }
          
         if(mode=='view'){
            $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true ); 
          }
    }
    
     function funLoadPrintGrid() {
          var date = $('#payrollPrintDate').val();
          var category = $('#cmbempprintcategory').val();
          var empid = $('#txtprintemployeedocno').val();
          var employeebranchchk=window.parent.employeebranchchk.value.trim(); 
          var branch=document.getElementById("brchName").value;   
          $("#overlay, #PleaseWait").show();
          
          $("#payrollPrintDiv").load("monthlyPayrollPrintGrid.jsp?date="+date+"&category="+category+"&empid="+empid+"&branch="+branch+"&employeebranchchk="+employeebranchchk+"&check=1");
          $('#btnPayrollPrint').attr('disabled', false ); 
     }
    
    function funReadOnly(){} 
    
    function funRemoveReadOnly(){}
    
    function funSearchLoad(){}
    
    function funChkButton(){}
    
     function funNotify(){
            
                /* Monthly Payroll Grid  Saving*/
                var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
                var length=0;
                     for(var i=0 ; i < rows.length ; i++){
                        var chk=rows[i].employeedocno;
                        if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                            newTextBox = $(document.createElement("input"))
                            .attr("type", "dil")
                            .attr("id", "test"+length)
                            .attr("name", "test"+length)
                            .attr("hidden", "true");
                            length=length+1;
                                
                    newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks+":: "+rows[i].earnbasic+":: "+rows[i].earnallowance1+":: "+rows[i].earnallowance2+":: "+rows[i].earnallowance3+":: "+rows[i].earnallowance4+":: "+rows[i].earnallowance5+":: "+rows[i].earnallowance6+":: "+rows[i].earnallowance7+":: "+rows[i].earnallowance8+":: "+rows[i].earnallowance9+":: "+rows[i].earnallowance10+":: "+rows[i].totalearnedsalary+":: "+rows[i].rowno);
                    newTextBox.appendTo('form');
                 }
                }
                $('#gridlength').val(length);
                /* Monthly Payroll Grid  Saving Ends*/  
        
         return 1;
        } 
    
     function funFocus(){
         $('#payrollDate').jqxDateTimeInput('focus'); 
      }
    
     function setValues(){
             checkPaySlip();checkPayrollPrint();checkPayrollProcess();
        
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
            
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 var employeebranchchk=window.parent.employeebranchchk.value.trim();       
                 var branch=document.getElementById("brchName").value; 
                 $("#payrollDiv").load("monthlyPayrollGrid.jsp?docno="+indexVal+"&date="+$('#payrollDate').val()+"&branch="+branch+"&employeebranchchk="+employeebranchchk);
             } 
        }
    
     function  funClearInfo(){
            
            $('#payrollDate').val(new Date());
            document.getElementById("cmbempcategory").value="";
            document.getElementById("txtemployeeid").value="";
            document.getElementById("txtemployeedocno").value="";
            document.getElementById("txtemployeename").value="";
            document.getElementById("txtchkgridload").value="";
            document.getElementById("lblcurrentstatus").innerText="";
            $("#monthlyPayrollGridID").jqxGrid('clear');
            $("#monthlyPayrollGridID").jqxGrid({ disabled: true});
            $('#btnSavePayRoll').prop('disabled', true);$('#btnConfirmed').prop('disabled', true);
            
             if (document.getElementById("txtemployeeid").value == "") {
                    $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
                    $('#txtemployeename').attr('placeholder', 'Employee Name');
                }
            
             $('#payrollDate').jqxDateTimeInput('focus'); 
             document.getElementById("errormsg").innerText="";
    }
    
     function  funClearPrintInfo(){ 
            $('#btnPayrollEmail').prop('disabled', true);  
            $('#payrollPrintDate').val(new Date());
            document.getElementById("cmbempprintcategory").value="";
            document.getElementById("txtprintemployeeid").value="";
            document.getElementById("txtprintemployeedocno").value="";
            document.getElementById("txtprintemployeename").value="";
            document.getElementById("lblcurrentstatus").innerText="";
            $("#monthlyPayrollPrintGridID").jqxGrid('clear');
            $("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
            $('#btnView').prop('disabled', false);$('#clearPrint').prop('disabled', false);$('#btnPayrollPrint').prop('disabled', true);
            $('#hidchckpayslip').val(0);document.getElementById("chckpayslip").checked = false;
            
             if (document.getElementById("txtprintemployeeid").value == "") {
                    $('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); 
                    $('#txtprintemployeename').attr('placeholder', 'Employee Name');
                }
            
             $('#payrollPrintDate').jqxDateTimeInput('focus'); 
             document.getElementById("errormsg").innerText="";
    }
    
     function funProcessGrid(){
         var date = $('#payrollDate').val();
         var paydate = $('#payrollDate').jqxDateTimeInput('getDate');
        var validdate=funDateInPeriod(paydate);
         if(validdate==0){
                return 0;   
         }
         getLastPayrollDate(date);
     }
    
     function funSaveGrid(){
         $('#btnSavePayRoll').attr('disabled', false );$('#btnConfirmed').attr('disabled', false );$('#btnSave').mousedown();
     }
    
     function funConfirm(){
         var alreadyProcessed = $('#txtpayrollalreadyprocessed').val();
         var payrollRows = $("#monthlyPayrollGridID").jqxGrid('getrows');
         if(parseInt(alreadyProcessed)!=parseInt(payrollRows.length)){
             $.messager.alert('Message','Payroll Saving Pending For Some Employee(s).','warning');
             return;
         }
         var paydate = $('#payrollDate').jqxDateTimeInput('getDate');
        var validdate=funDateInPeriod(paydate);
         if(validdate==0){
                return 0;   
         }
         $.messager.confirm('Confirm', 'Do you want to Post?', function(r){
                if (r){
                    
                    /* Monthly Payroll Grid  Saving*/
                    var rows = $("#monthlyPayrollGridID").jqxGrid('getrows');
                    var length=0;
                         for(var i=0 ; i < rows.length ; i++){
                            var chk=rows[i].employeedocno;
                            if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                                newTextBox = $(document.createElement("input"))
                                .attr("type", "dil")
                                .attr("id", "test"+length)
                                .attr("name", "test"+length)
                                .attr("hidden", "true");
                                length=length+1;
                                    
                            newTextBox.val(rows[i].employeedocno+":: "+rows[i].dates+":: "+rows[i].totaldays+":: "+rows[i].leave1+":: "+rows[i].leave2+":: "+rows[i].leave3+":: "+rows[i].leave4+":: "+rows[i].leave5+":: "+rows[i].leave6+":: "+rows[i].leave7+":: "+rows[i].leave8+":: "+rows[i].leave9+":: "+rows[i].leave10+":: "+rows[i].basic+":: "+rows[i].allowance1+":: "+rows[i].allowance2+":: "+rows[i].allowance3+":: "+rows[i].allowance4+":: "+rows[i].allowance5+":: "+rows[i].allowance6+":: "+rows[i].allowance7+":: "+rows[i].allowance8+":: "+rows[i].allowance9+":: "+rows[i].allowance10+":: "+rows[i].totalsalary+":: "+rows[i].ot+":: "+rows[i].hot+":: "+rows[i].overtime+":: "+rows[i].leavedeductions+":: "+rows[i].grosssalary+":: "+rows[i].additions+":: "+rows[i].deductions+":: "+rows[i].loan+":: "+rows[i].netsalary+":: "+rows[i].remarks);
                            newTextBox.appendTo('form');
                     }
                    }
                    $('#gridlength').val(length);
                    /* Monthly Payroll Grid  Saving Ends*/  
                    
                    $('#mode').val('EDIT');
                    $("#overlay, #PleaseWait").show();
                    document.getElementById("frmMonthlyPayroll").submit();
                }
           });
     }
    
     function funCheckPayrollProcess(){
         $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
         document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
         document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
         $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtemployeename').attr('placeholder', 'Employee Name');
         $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
         document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";
         $("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});$('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
                
         if(document.getElementById("chckpayrollprocess").checked == true){
             $('#payrollDate').jqxDateTimeInput('focus'); $('#hidchckpayrollprocess').val(1);$('#hidchckpayrollprint').val(0);$('#payrollDate').jqxDateTimeInput({disabled: false});
             $('#cmbempcategory').attr('disabled', false);$('#txtemployeeid').attr('disabled', false);$('#txtemployeename').attr('disabled', false);$("#payrollDiv").prop("hidden", false);
             $("#payrollPrintDiv").prop("hidden", true);$('#clear').attr('disabled', false);$('#btnProcess').attr('disabled', false );$('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );
                 $('#payrollPrintDate').jqxDateTimeInput({disabled: true});$('#cmbempprintcategory').attr('disabled', true);$('#txtprintemployeeid').attr('disabled', true);$('#txtprintemployeename').attr('disabled', true);
                 $('#chckpayslip').attr('disabled', true);$('#btnPayrollPrint').attr('disabled', true );$('#btnView').attr('disabled', true );$('#clearPrint').attr('disabled', true );
          } 
      }
    
     function funCheckPayrollPrint(){
          $('#payrollDate').val(new Date());document.getElementById("cmbempcategory").value="";document.getElementById("txtemployeeid").value="";
          document.getElementById("txtemployeedocno").value="";document.getElementById("txtemployeename").value="";document.getElementById("txtchkgridload").value="";
          document.getElementById("lblcurrentstatus").innerText="";$("#monthlyPayrollGridID").jqxGrid({ disabled: true});document.getElementById("errormsg").innerText="";
          $('#txtemployeeid').attr('placeholder', 'Press F3 to Search');$('#txtemployeename').attr('placeholder', 'Employee Name');
          $('#payrollPrintDate').val(new Date());document.getElementById("cmbempprintcategory").value="";document.getElementById("txtprintemployeeid").value="";
          document.getElementById("txtprintemployeedocno").value="";document.getElementById("txtprintemployeename").value="";$("#monthlyPayrollPrintGridID").jqxGrid({ disabled: true});
          $('#txtprintemployeeid').attr('placeholder', 'Press F3 to Search'); $('#txtprintemployeename').attr('placeholder', 'Employee Name');
          
          if(document.getElementById("chckpayrollprint").checked == true){
                 $('#payrollPrintDate').jqxDateTimeInput('focus');$('#hidchckpayrollprint').val(1);$('#hidchckpayrollprocess').val(0);$('#payrollPrintDate').jqxDateTimeInput({disabled: false});
                 $('#cmbempprintcategory').attr('disabled', false);$('#txtprintemployeeid').attr('disabled', false);$('#txtprintemployeename').attr('disabled', false);$('#chckpayslip').attr('disabled', false);
                 $('#btnPayrollPrint').attr('disabled', true );$('#payrollDate').jqxDateTimeInput({disabled: true});$('#cmbempcategory').attr('disabled', true);$('#txtemployeeid').attr('disabled', true);
                 $('#txtemployeename').attr('disabled', true);$("#payrollDiv").prop("hidden", true); $("#payrollPrintDiv").prop("hidden", false);$('#clear').attr('disabled', true);$('#btnProcess').attr('disabled', true );
                 $('#btnSavePayRoll').attr('disabled', true );$('#btnConfirmed').attr('disabled', true );$('#btnView').attr('disabled', false );$('#clearPrint').attr('disabled', false );
                
          } 
      }
    
     function checkPayrollProcess(){
         if(document.getElementById("hidchckpayrollprocess").value==1){
             document.getElementById("chckpayrollprocess").checked = true;
         }
         else if(document.getElementById("hidchckpayrollprocess").value==0){
            document.getElementById("chckpayrollprocess").checked = false;
          }
         }
    
     function funCheckPaySlip(){
          if(document.getElementById("chckpayslip").checked == true){
                 $('#hidchckpayslip').val(1);
                 $('#btnPayrollEmail').attr('disabled', false );
          } else{
                 $('#hidchckpayslip').val(0);  
                 $('#btnPayrollEmail').attr('disabled', true );  
          }
      }
    
     function checkPayrollPrint(){
         if(document.getElementById("hidchckpayrollprint").value==1){
             document.getElementById("chckpayrollprint").checked = true;
         }
         else if(document.getElementById("hidchckpayrollprint").value==0){
            document.getElementById("chckpayrollprint").checked = false;
          }
         }
    
    function checkPaySlip(){
         if(document.getElementById("hidchckpayslip").value==1){
             document.getElementById("chckpayslip").checked = true;
         }
         else if(document.getElementById("hidchckpayslip").value==0){
            document.getElementById("chckpayslip").checked = false;
          }
    }
    
    function payrollprintdatechange(){
         var date = $('#payrollPrintDate').val();
         getPayrollPrintDate(date);getPayrollPrintDocNo(date);
    }

     function funPayrollPrint() {
           
        if($("#hidchckpayrollprint").val()=="1") {
            
        var rows=$("#monthlyPayrollPrintGridID").jqxGrid("getrows");
        var selectedrows=$("#monthlyPayrollPrintGridID").jqxGrid('selectedrowindexes');
        selectedrows = selectedrows.sort(function(a,b){return a - b});
        
        var i=0;j=0;k=0;tempemps="";
        for (i = 0; i < rows.length; i++) {
                if(selectedrows[j]==i){
                   if(k==0){
                     tempemps=rows[i].employeedocno;
                     k=1;
                   } else{
                    tempemps=tempemps+","+rows[i].employeedocno;
                 }
               j++; 
            }
         }
        
         $('#txtselectedemployees').val(tempemps);
        
         if($("#hidchckpayslip").val()=="0") {
             var empid = $('#txtprintemployeedocno').val();  
             var url=document.URL;
             var reurl=url.split("monthlypayroll");
            
             $("#docno").prop("disabled", false);
            
                   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){                                        
                    if (r){
                         var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&empid="+empid+"&printcategory="+document.getElementById("cmbempprintcategory").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                         win.focus();
                     }
                    else{
                        var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll?docno="+$("#docno").val()+"&empid="+empid+"&printcategory="+document.getElementById("cmbempprintcategory").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                        win.focus();
                    }
                   });
                   
          } else if($("#hidchckpayslip").val()=="1") {
               if(selectedrows.length==0){
                    $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Warning','Select Employee(s) to be Printed.');
                    return false;
                }
               
                var url=document.URL;
                var reurl=url.split("monthlypayroll");
                
                var win= window.open(reurl[0]+"monthlypayroll/printPaySlipViewer?employeedocno="+$("#txtselectedemployees").val()+"&branch="+document.getElementById("brchName").value+"&date="+document.getElementById("payrollPrintDate").value+"&allowancecount="+document.getElementById("txtallowancetypecount").value+"&docno="+document.getElementById("docno").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                win.focus();
                
          }
         }
        }
     function funPayrollprocessPrint(){
          var mode = $('#mode').val();
          var docno = $('#docno').val().trim(); 
          var date = $('#payrollDate').jqxDateTimeInput('val');
          var category = $('#cmbempcategory').val();
          var empid = $('#txtemployeedocno').val();
                 var url=document.URL;
                 var reurl=url.split("monthlypayroll");
                 $("#docno").prop("disabled", false);
                        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){      
                        if (r){
                            var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll2?branch="+document.getElementById("brchName").value+"&header="+1+"&mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                             win.focus();
                         }                    
                        else{   
                            var win= window.open(reurl[0]+"monthlypayroll/printMonthlyPayroll2?branch="+document.getElementById("brchName").value+"&header="+0+"&mode="+mode+"&docno="+docno+"&date="+date+"&category="+category+"&empid="+empid+"&check=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                            win.focus();
                        }
                       });   
            }
    
       function getEmailConfig() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    if(parseInt(items)==1){     
                        //$("#btnPayrollEmail").val(1); 
                         $("#btnPayrollEmail").show(); 
                    }else{
                        //$("#btnPayrollEmail").val(0);
                        $("#btnPayrollEmail").hide();   
                    }
                } else {
                }
            }
            x.open("GET", 'getEmailConfig.jsp', true);      
            x.send();
        }
 
        function funPayrollEmail() {
            var rows=$("#monthlyPayrollPrintGridID").jqxGrid("getrows");
            var selectedrows=$("#monthlyPayrollPrintGridID").jqxGrid('selectedrowindexes');
            selectedrows = selectedrows.sort(function(a,b){return a - b});
                
            var i=0;j=0;k=0;tempemps="";
            for (i = 0; i < rows.length; i++) {
                        if(selectedrows[j]==i){
                           if(k==0){
                             tempemps=rows[i].employeedocno;
                             k=1;
                           } else{
                            tempemps=tempemps+","+rows[i].employeedocno;
                         }
                       j++; 
                    }
             }
                
             if(selectedrows.length==0){
                $("#overlay, #PleaseWait").hide();
                $.messager.alert('Warning','Select employee(s) to send the payslip(s) by email.');  
                return false;
             }
             $.messager.confirm('Confirm', 'Do you want to send the payslip by email?', function(r){
                if (r){
                    $("#overlay, #PleaseWait").show();
                    $.ajaxFileUpload ({   
                          url: "printPaySlipEmailAction.action?employeedocno="+tempemps+"&branch="+document.getElementById("brchName").value+"&date="+document.getElementById("payrollPrintDate").value+"&allowancecount="+document.getElementById("txtallowancetypecount").value+"&docno="+document.getElementById("docno").value+"&email=1",  
                          type:'POST',      
                          secureuri:false, 
                          fileElementId:'file',   
                          dataType: 'string', 
                          success: function (data, status) {  
                             if(status=='success'){
                                 $("#overlay, #PleaseWait").hide();
                                 $.messager.alert('Message','E-Mail Send Successfully');
                              }
                             
                             if(status=='error'){
                                 $("#overlay, #PleaseWait").hide();
                                 $.messager.alert('Message','E-Mail Sending failed');
                             }
                             
                             if(typeof(data.error) != 'undefined') {  
                                  if(data.error != '')  
                                  {  
                                      alert(data.error);  
                                  }else  
                                  {  
                                      alert(data.message);  
                                  }  
                              }  
                          },  
                           error: function (data, status, e)
                          {  
                              alert(e);  
                          }  
                      }) 
                     return false;
                }   
           });
        }
</script>
</head>
<body onload="setValues();getEmailConfig();">   
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmMonthlyPayroll" action="saveMonthlyPayroll" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    
    <div class="modern-ui hidden-scrollbar">
        <div style="display: flex; gap: 15px; margin-bottom: 15px;">
            
            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">
                    <div class="chk-container">
                        <input type="checkbox" id="chckpayrollprocess" name="chckpayrollprocess" class="chckpayrollprocessprint" onclick="funCheckPayrollProcess();">
                        <label for="chckpayrollprocess">Process Payroll</label>
                        <input type="hidden" id="hidchckpayrollprocess" name="hidchckpayrollprocess" value='<s:property value="hidchckpayrollprocess"/>'/>
                    </div>
                </span>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div id="payrollDate"></div>
                    
                    <label class="lbl-right" style="width:80px;">Category</label>
                    <select id="cmbempcategory" name="cmbempcategory" style="width:130px;">
                        <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempcategory" name="hidcmbempcategory" value='<s:property value="hidcmbempcategory"/>'/>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Employee</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Press F3" onkeydown="getEmployeeId(event);"/>
                        <svg class="magnifier-icon" onclick="employeeSearchContent('employeeDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/>
                    </div>
                    
                    <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" tabindex="-1" readonly style="flex:1; max-width:180px; margin-left:8px;"/>
                </div>

                <div class="field-row" style="justify-content: center; margin-top: 20px;">
                    <button type="button" class="myButton" id="clear" onclick="funClearInfo();">Clear</button>
                    <button type="button" class="myButton" id="btnProcess" onclick="funProcessGrid();">Process & Calc</button>
                    <button type="button" class="myButton" id="btnSavePayRoll" onclick="funSaveGrid();">Save</button>
                    <button type="button" class="myButton" id="btnConfirmed" onclick="funConfirm();">Confirm</button>
                    <button type="button" class="myButton" id="btnPayrollprocessPrint" onclick="funPayrollprocessPrint();">Print</button>
                </div>
                
                <label id="lblcurrentstatus" name="lblcurrentstatus">
                    <s:property value="lblcurrentstatus"/>
                </label>
            </div>

            <div class="middle-panel" style="flex: 1; margin-bottom: 0;">
                <span class="middle-panel-title">
                    <div class="chk-container">
                        <input type="checkbox" id="chckpayrollprint" name="chckpayrollprint" class="chckpayrollprocessprint" onclick="funCheckPayrollPrint();">
                        <label for="chckpayrollprint">Print Payroll</label>
                        <input type="hidden" id="hidchckpayrollprint" name="hidchckpayrollprint" value='<s:property value="hidchckpayrollprint"/>'/>
                    </div>
                </span>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Date</label>
                    <div id="payrollPrintDate" onchange="payrollprintdatechange();"></div>
                    
                    <label class="lbl-right" style="width:80px;">Category</label>
                    <select id="cmbempprintcategory" name="cmbempprintcategory" style="width:130px;">
                        <option value="">--Select--</option>
                    </select>
                </div>

                <div class="field-row">
                    <label class="lbl-right" style="width:80px;">Employee</label>
                    <div class="input-search-container" style="width: 125px;">
                        <input type="text" id="txtprintemployeeid" name="txtprintemployeeid" placeholder="Press F3" onkeydown="getEmployeeId(event);"/>
                        <svg class="magnifier-icon" onclick="employeeSearchContent('employeeDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        <input type="hidden" id="txtprintemployeedocno" name="txtprintemployeedocno"/>
                    </div>
                    
                    <input type="text" id="txtprintemployeename" name="txtprintemployeename" placeholder="Employee Name" tabindex="-1" readonly style="flex:1; max-width:180px; margin-left:8px;"/>
                </div>

                <div class="field-row" style="justify-content: center; margin-top: 20px;">
                    <div class="chk-container" style="margin-right:10px;">
                        <input type="checkbox" id="chckpayslip" name="chckpayslip" onclick="funCheckPaySlip();">
                        <label for="chckpayslip" style="font-weight:bold; font-size:12px; color:#444;">Pay Slip</label>
                        <input type="hidden" id="hidchckpayslip" name="hidchckpayslip" value='<s:property value="hidchckpayslip"/>'/>
                    </div>
                    <button type="button" class="myButton" id="clearPrint" onclick="funClearPrintInfo();">Clear</button>
                    <button type="button" class="myButton" id="btnView" onclick="funLoadPrintGrid();payrollprintdatechange();">View</button>
                    <button type="button" class="myButton" id="btnPayrollPrint" onclick="funPayrollPrint();">Print</button>
                    <button type="button" class="myButton" id="btnPayrollEmail" onclick="funPayrollEmail();">Email</button>
                </div>
            </div>

        </div>

        <div class="middle-panel" style="padding: 10px;">
            <div id="payrollDiv">
                <jsp:include page="monthlyPayrollGrid.jsp"></jsp:include>
            </div>
            <div id="payrollPrintDiv" hidden="true">
                <jsp:include page="monthlyPayrollPrintGrid.jsp"></jsp:include>
            </div>
        </div>

    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="docno" name="txtmonthlypayrolldocno" value='<s:property value="txtmonthlypayrolldocno"/>'/>
        <input type="hidden" id="txtselectedemployees" name="txtselectedemployees" value='<s:property value="txtselectedemployees"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="txtleavetype1" name="txtleavetype1"  value='<s:property value="txtleavetype1"/>'/>
        <input type="hidden" id="txtleavetype2" name="txtleavetype2"  value='<s:property value="txtleavetype2"/>'/>
        <input type="hidden" id="txtleavetype3" name="txtleavetype3"  value='<s:property value="txtleavetype3"/>'/>
        <input type="hidden" id="txtleavetype4" name="txtleavetype4"  value='<s:property value="txtleavetype4"/>'/>
        <input type="hidden" id="txtleavetype5" name="txtleavetype5"  value='<s:property value="txtleavetype5"/>'/>
        <input type="hidden" id="txtleavetype6" name="txtleavetype6"  value='<s:property value="txtleavetype6"/>'/>
        <input type="hidden" id="txtleavetype7" name="txtleavetype7"  value='<s:property value="txtleavetype7"/>'/>
        <input type="hidden" id="txtleavetype8" name="txtleavetype8"  value='<s:property value="txtleavetype8"/>'/>
        <input type="hidden" id="txtleavetype9" name="txtleavetype9"  value='<s:property value="txtleavetype9"/>'/>
        <input type="hidden" id="txtleavetype10" name="txtleavetype10"  value='<s:property value="txtleavetype10"/>'/>
        <input type="hidden" id="txtleavetypecount" name="txtleavetypecount"  value='<s:property value="txtleavetypecount"/>'/>
        <input type="hidden" id="txtallowancetype1" name="txtallowancetype1"  value='<s:property value="txtallowancetype1"/>'/>
        <input type="hidden" id="txtallowancetype2" name="txtallowancetype2"  value='<s:property value="txtallowancetype2"/>'/>
        <input type="hidden" id="txtallowancetype3" name="txtallowancetype3"  value='<s:property value="txtallowancetype3"/>'/>
        <input type="hidden" id="txtallowancetype4" name="txtallowancetype4"  value='<s:property value="txtallowancetype4"/>'/>
        <input type="hidden" id="txtallowancetype5" name="txtallowancetype5"  value='<s:property value="txtallowancetype5"/>'/>
        <input type="hidden" id="txtallowancetype6" name="txtallowancetype6"  value='<s:property value="txtallowancetype6"/>'/>
        <input type="hidden" id="txtallowancetype7" name="txtallowancetype7"  value='<s:property value="txtallowancetype7"/>'/>
        <input type="hidden" id="txtallowancetype8" name="txtallowancetype8"  value='<s:property value="txtallowancetype8"/>'/>
        <input type="hidden" id="txtallowancetype9" name="txtallowancetype9"  value='<s:property value="txtallowancetype9"/>'/>
        <input type="hidden" id="txtallowancetype10" name="txtallowancetype10"  value='<s:property value="txtallowancetype10"/>'/>
        <input type="hidden" id="txtallowancetypecount" name="txtallowancetypecount"  value='<s:property value="txtallowancetypecount"/>'/>
        <input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
        <input type="hidden" id="txtpayrollalreadyprocessed" name="txtpayrollalreadyprocessed"  value='<s:property value="txtpayrollalreadyprocessed"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
    </div>
</form>

<div id="employeeDetailsWindow"><div></div></div>
</div>
</body>
</html>