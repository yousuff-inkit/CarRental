<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<%
String mod =request.getParameter("mod")==null?"0":request.getParameter("mod").toString();
String gender=request.getParameter("gender")==null?"0":request.getParameter("gender").toString();
String name=request.getParameter("name")==null?"0":request.getParameter("name").toString();
String dob=request.getParameter("dob")==null?"0":request.getParameter("dob").toString();
String nation=request.getParameter("nation")==null?"0":request.getParameter("nation").toString();
String nationid=request.getParameter("nationid")==null?"0":request.getParameter("nationid").toString();
String brhid=request.getParameter("brhid")==null?"0":request.getParameter("brhid").toString();
String candidateid=request.getParameter("candidateid")==null?"0":request.getParameter("candidateid").toString();
%>

<style>
/* =========================================================
SCOPED UI: Modern Layout (Matches Cash Receipts / Client Master)
========================================================= */
body {
    background-color: #f8fafc; /* Changed to a solid, clean color to match the screenshot perfectly */
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 15px; /* Reduced padding so the top doesn't push down too far */
    box-sizing: border-box;
}

#mainBG {
    background: transparent; /* Removed the forced white box here so it blends naturally */
    max-width: 100%;
    margin: 0 auto;
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 0px;
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

/* Validation Label */
.modern-ui .val-error { color: red; font-size: 11px; font-weight:bold; }
#lblemployeestatus { font-size: 13px; color: #6000FC; font-weight: bold; font-style: italic; }
form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 10px; display: block; padding-left: 15px; }

/* Scrollbar Logic FIX */
.hidden-scrollbar {
    /* REMOVED height: calc(100vh - 150px); and overflow-y: auto; 
       This was forcing the page to chop off the bottom content and create that empty white gap! */
    padding-right: 5px;
}
</style>

<script type="text/javascript">
var mod1='<%=mod%>';
var gender='<%=gender%>';
var name='<%=name%>';
var dob='<%=dob%>';
var nation='<%=nation%>';
var nationid='<%=nationid%>';
var brhid='<%=brhid%>';
var candidateid='<%=candidateid%>';

      $(document).ready(function () {
          /* Formatted jqxDateTimeInput heights to match modern UI 24px */
          var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
          
          /* Date */
          $("#employeeDate").jqxDateTimeInput(dateWidgetSettings);
          $("#joiningDate").jqxDateTimeInput(dateWidgetSettings);
          $("#empDateOfBirth").jqxDateTimeInput(dateWidgetSettings);
          
          // force internal alignment AFTER render
          setTimeout(function () {
              $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
              $(".jqx-datetimeinput").find("input").css({
                  "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                  "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
              });
              $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
          }, 100);

          /* Searching Window */
         $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#accountDetailsWindow').jqxWindow('close');
        
         $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#costCodeSearchWindow').jqxWindow('close');
        
         $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#nationalityWindow').jqxWindow('close');
        
         $('#printWindow').jqxWindow({width: '100%', height: '25%',  maxHeight: '25%' ,maxWidth: '50%' , title: 'Print',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
          $('#printWindow').jqxWindow('close');
        
          $('#ifsccodeWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'IFSC Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#ifsccodeWindow').jqxWindow('close');
            
            $('#brchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
             $('#brchWindow').jqxWindow('close');
            
              $('#compWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '27%' , title: 'Company Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
                 $('#compWindow').jqxWindow('close');
                
                $('#establishedCodeDetailsWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '30%' , title: 'Establishment Code Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
                 $('#establishedCodeDetailsWindow').jqxWindow('close');
                
                 $('#txtbankbranchname').dblclick(function(){
                brchSearchContent("branchdetailsGrid.jsp");
              });
            
            $('#txtbankifsccode').dblclick(function(){
                ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
             });
           
            $('#txtco_name').dblclick(function(){
                compSearchContent("companydetailsGrid.jsp");
              });
            
            $('#txtest_code').dblclick(function(){
                 establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
             });

         $('#txtempaccount').dblclick(function(){
              accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          });
        
         $('#txtcost').dblclick(function(){
            costCodeSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/employeemaster/costSearchGrid.jsp");
          });
        
        $('#txtempnationality').dblclick(function(){
            nationalitySearchContent("nationSearchGrid.jsp");
          });
        
    getCostAccess();getDesignation();getDepartment();getPayrollCategory();getSalesAgent();
      }); 
      
      function getbrchname(event){
            var x= event.keyCode;
      if(x==114){
        brchSearchContent("branchdetailsGrid.jsp");
      }
      else{}
      }
  
    function brchSearchContent(url) {
        $('#brchWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#brchWindow').jqxWindow('setContent', data);
        $('#brchWindow').jqxWindow('bringToFront');
    }); 
    }

  function getifsccode(event){
        var x= event.keyCode;
        if(x==114){
          ifsccodeSearchContent("ifsccodedetailsGrid.jsp");
        }
        else{}
        }
 
  function ifsccodeSearchContent(url) {
        $('#ifsccodeWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#ifsccodeWindow').jqxWindow('setContent', data);
        $('#ifsccodeWindow').jqxWindow('bringToFront');
    }); 
    }
  function getEstablishmentCode(event){
       var x= event.keyCode;
  if(x==114){
    establishedCodeSearchContent("establishmentCodeDetailsSearchGrid.jsp");
  }
  else{}
  }

function establishedCodeSearchContent(url) {
    $('#establishedCodeDetailsWindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#establishedCodeDetailsWindow').jqxWindow('setContent', data);
    $('#establishedCodeDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getcomp(event){
    var x= event.keyCode;
    if(x==114){
      compSearchContent("companydetailsGrid.jsp");
    }
    else{}
    }

function compSearchContent(url) {
    $('#compWindow').jqxWindow('open');
    $.get(url).done(function (data) {
    $('#compWindow').jqxWindow('setContent', data);
    $('#compWindow').jqxWindow('bringToFront');
}); 
}
     function getCostAccess(){
          var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    var items= x.responseText;
                        if(items.trim()=="0"){
                            $(".costdiv").hide();
                            $(".typediv").hide();
                        }else{
                            $(".costdiv").show();
                            $(".typediv").show();
                        }
                    }
             }
              x.open("GET", "getCostAccess.jsp",true);
             x.send();
            
           }
    
      function accountSearchContent(url) {
          if($("#mode").val() == "view"){
              return false
          }
            $('#accountDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#accountDetailsWindow').jqxWindow('setContent', data);
            $('#accountDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function costCodeSearchContent(url) {
          if($("#mode").val() == "view"){
              return false
          }
        $('#costCodeSearchWindow').jqxWindow('open');
        $.get(url).done(function (data) {
        $('#costCodeSearchWindow').jqxWindow('setContent', data);
        $('#costCodeSearchWindow').jqxWindow('bringToFront');
    }); 
    }
      
      function nationalitySearchContent(url) {
          if($("#mode").val() == "view"){
              return false
          }
            $('#nationalityWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#nationalityWindow').jqxWindow('setContent', data);
            $('#nationalityWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function getDesignation() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var designationItems = items[0].split(",");
                    var designationIdItems = items[1].split(",");
                    var optionsdesignation = '<option value="">--Select--</option>';
                    for (var i = 0; i < designationItems.length; i++) {
                        optionsdesignation += '<option value="' + designationIdItems[i] + '">'
                                + designationItems[i] + '</option>';
                    }
                    $("select#cmbempdesignation").html(optionsdesignation);
                    if ($('#hidcmbempdesignation').val() != null) {
                        $('#cmbempdesignation').val($('#hidcmbempdesignation').val());
                    }
                } else {
                }
            }
            x.open("GET", "getDesignation.jsp", true);
            x.send();
        }
      
      function getDepartment() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText;
                    items = items.split('####');
                    var departmentItems = items[0].split(",");
                    var departmentIdItems = items[1].split(",");
                    var optionsdepartment = '<option value="">--Select--</option>';
                    for (var i = 0; i < departmentItems.length; i++) {
                        optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
                                + departmentItems[i] + '</option>';
                    }
                    $("select#cmbempdepartment").html(optionsdepartment);
                    if ($('#hidcmbempdepartment').val() != null) {
                        $('#cmbempdepartment').val($('#hidcmbempdepartment').val());
                    }
                } else {
                }
            }
            x.open("GET", "getDepartment.jsp", true);
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
                $("select#cmbpayrollcategory").html(optionspayrollcategory);
                if ($('#hidcmbpayrollcategory').val() != null) {
                    $('#cmbpayrollcategory').val($('#hidcmbpayrollcategory').val());
                }
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
                if ($('#hidcmbempagentid').val() != null) {
                    $('#cmbempagentid').val($('#hidcmbempagentid').val());
                }
            } else {
            }
        }
        x.open("GET", "getSalesAgent.jsp", true);
        x.send();
    }
      
      function getCurrencyIds(){
            var x=new XMLHttpRequest();
            x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200)
                {
                    items= x.responseText;
                    items=items.split('####');
                    var curidItems=items[0];
                    var curcodeItems=items[1];
                    var multiItems=items[2];
                    var optionscurr = '';
                    
                 if(curcodeItems.indexOf(",")>=0){
                    var currencyid=curidItems.split(",");
                    var currencycode=curcodeItems.split(",");
                    multiItems.split(",");
               
               for ( var i = 0; i < currencycode.length; i++) {
                   optionscurr += '<option value="' + currencyid[i] + '">' + currencycode[i] + '</option>';
                 }
              
                 $("select#cmbcurrency").html(optionscurr);
                 if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                         $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                 } 
                     
                   }
            
                else{
                   optionscurr += '<option value="' + curidItems + '"selected>' + curcodeItems + '</option>';
                   
                     $("select#cmbcurrency").html(optionscurr);
               
                 if ($('#hidcmbcurrency').val() != null && $('#hidcmbcurrency').val() != "") {
                         $('#cmbcurrency').val($('#hidcmbcurrency').val()) ;
                 }
               }
                }
             }
              x.open("GET", "getCurrencyId.jsp",true);
             x.send();
            
           }
      
      function getEmpAccount(event){
          var x= event.keyCode;
          if(x==114){
              accountSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/accountsDetailsSearch.jsp");
          }
          else{}
          }
      
      function getCost(event){
          var x= event.keyCode;
          if(x==114){
              costCodeSearchContent(<%=contextPath+"/"%>+"com/humanresource/setup/employeemaster/costSearchGrid.jsp");
          }
          else{}
          }
      
      function getNations(event){
          var x= event.keyCode;
          if(x==114){
              nationalitySearchContent("nationSearchGrid.jsp");
          }
          else{}
          }
      
      function getEmployeeCodeAlreadyExists(empcode,docno,mode){
          var retval = 1; 
          var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    
                    if(parseInt(items.trim())==1){
                         retval = 0;
                     } else { 
                        retval = 1; 
                     }
            }
        }
        x.open("GET", "getEmployeeCodeAlreadyExists.jsp?empcode="+empcode+"&docno="+docno+"&mode="+mode, false);
        x.send();
        return retval;   
      }
  
      function getEmployeeAlreadyExists(employeename,docno,mode){
            var retval = 1; 
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();

                    if(parseInt(items)>0){
                         retval = 0;
                     }else{
                        retval = 1; 
                     }
            }
        }
        x.open("GET", "getEmployeeAlreadyExists.jsp?employeename="+employeename+"&docno="+docno+"&mode="+mode, false);
        x.send();
        return retval;   
   }
      
      $(function(){
            $('#frmEmployeeMaster').validate({
                    rules: {
                    txtemployeename:"required",
                    cmbempdesignation:"required",
                    cmbempdepartment:"required",
                    cmbpayrollcategory:"required"
                     },
                     messages: {
                     txtemployeename:" *",
                     cmbempdesignation:" *",
                     cmbempdepartment:" *",
                     cmbpayrollcategory:" *"
                     }
            });});
    
     function funReadOnly(){
            $('#frmEmployeeMaster input').attr('readonly', true );
            $('#frmEmployeeMaster select').attr('disabled', true);
            $('#employeeDate').jqxDateTimeInput({disabled: true});
            $('#joiningDate').jqxDateTimeInput({disabled: true});
            $('#empDateOfBirth').jqxDateTimeInput({disabled: true});
            
            $("#compensationGridID").jqxGrid({ disabled: true});
            $("#documentsGridID").jqxGrid({ disabled: true});
            
             if(mod1=="A") {
                    document.getElementById("formdet").innerText=window.parent.formName.value+" ("+window.parent.formCode.value.trim()+")";
                    document.getElementById("formdetail").value=window.parent.formName.value;
                    document.getElementById("formdetailcode").value=window.parent.formCode.value.trim(); 
                    funCreateBtn();  
                }
     }
    
     function funRemoveReadOnly(){
            $('#frmEmployeeMaster input').attr('readonly', false );
            $('#frmEmployeeMaster select').attr('disabled', false);
            $('#employeeDate').jqxDateTimeInput({disabled: false});
            $('#joiningDate').jqxDateTimeInput({disabled: false});
            $('#empDateOfBirth').jqxDateTimeInput({disabled: false});
            $('#txtempaccount').attr('readonly', true );
            $('#txtcost').attr('readonly', true );
            $('#txtempaccountname').attr('readonly', true );
            $('#txtempnationality').attr('readonly', true );
            $('#docno').attr('readonly', true);
            
            $("#compensationGridID").jqxGrid({ disabled: false});
            $("#documentsGridID").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
                     $('#employeeDate').val(new Date());
                     $('#joiningDate').val(new Date());
                     $('#empDateOfBirth').val(new Date());
                     document.getElementById("lblemployeestatus").innerText="";
                    
                     $("#compensationGridID").jqxGrid('clear'); 
                     $("#compensationGridID").jqxGrid('addrow', null, {});
                     $("#documentsGridID").jqxGrid('clear'); 
                     $("#documentsGridID").jqxGrid('addrow', null, {});
                     
                     $("#compensationDiv").load("compensationGrid.jsp?mode="+$("#mode").val());
                     $("#documentsDiv").load("documentsGrid.jsp?mode="+$("#mode").val());
                     funemployeecodecheck();
            }
            
            if ($("#mode").val() == "E") {
                     $("#compensationGridID").jqxGrid('addrow', null, {});
                     $("#documentsGridID").jqxGrid('addrow', null, {});
                     
                     var indexVal = document.getElementById("docno").value;
                     if(indexVal> 0){
                         $("#compensationDiv").load("compensationGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
                         $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal+"&mode="+$("#mode").val());
                     } 
            }
            
            if (mod1 == "A") {
                 document.getElementById("txtemployeename").value=name;
                 document.getElementById("txtempnationality").value=nation;  
                 document.getElementById("txtempnationalityid").value=nationid;  
                 $("#empDateOfBirth").jqxDateTimeInput('val',dob);
                 $('#hidcmbempsex').val(gender);
                 $("#cmbempsex").val(gender).trigger('change');
                 $('#convertCandidate').val(candidateid);
            }
     }
     function funNotify(){  
         var rows = $("#compensationGridID").jqxGrid('getrows');
         var compensationslength=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].allowanceid;
                if(typeof(chk) != "undefined"){
                    compensationslength=compensationslength+1;
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "txtcompensations"+i)
                    .attr("name", "txtcompensations"+i)
                    .attr("hidden", "true");
            
                    newTextBox.val(rows[i].allowanceid+" :: "+rows[i].refdtype+" :: "+rows[i].addition+":: "+rows[i].deduction+":: "+rows[i].statutorydeduction+":: "+rows[i].remarks+":: "+rows[i].actualsalary);
                    newTextBox.appendTo('form');
             }
            }
         $('#monthlysalarygridlength').val(compensationslength);
        
        var rows = $("#documentsGridID").jqxGrid('getrows');
         var documentslength=0;
             for(var i=0 ; i < rows.length ; i++){
                var chkng=rows[i].documentid;
                if(typeof(chkng) != "undefined"){
                    documentslength=documentslength+1;
                    newTextBox = $(document.createElement("input"))
                    .attr("type", "dil")
                    .attr("id", "txtdocuments"+i)
                    .attr("name", "txtdocuments"+i)
                    .attr("hidden", "true");
            
                    var issueDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'issue_date');
                    var expDate = $('#documentsGridID').jqxGrid('getcelltext', i, 'exp_date');
                                      
            newTextBox.val(rows[i].documentid+" :: "+issueDate+" :: "+expDate+":: "+rows[i].place_of_issue+":: "+rows[i].location+":: "+rows[i].remarks+":: "+rows[i].documentno);
            newTextBox.appendTo('form');
             }
            }
         $('#documentsgridlength').val(documentslength);
         empcode=document.getElementById("txtemployeeid").value;   
         employeename=document.getElementById("txtemployeename").value;
         docno=document.getElementById("docno").value;
         mode=document.getElementById("mode").value;
         var val=0,val1=0,va12=0;
         val= getEmployeeAlreadyExists(employeename,docno,mode);
         if(val==0){
             document.getElementById("errormsg").innerText="Employee Already Exists.";
             return 0;
         }
         val1=getEmployeeCodeAlreadyExists(empcode,docno,mode);
         if(val1==0){
             document.getElementById("errormsg").innerText="Employee ID Already Exists.";   
             return 0;
         }
         if(val==1 && val1==1){   
             va12=1;
         }
        return va12;
        } 
    
     function funSearchLoad(){
            changeContent('empMainSearch.jsp'); 
         }
    
     function funFocus(){
        $('#employeeDate').jqxDateTimeInput('focus');           
    }
    
     function setValues(){
             if($('#hidemployeeDate').val()){
                 $("#employeeDate").jqxDateTimeInput('val', $('#hidemployeeDate').val());
              }
             if($('#hidmaindate').val()){
                 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
              }
             if($('#hidjoiningDate').val()){
                 $("#joiningDate").jqxDateTimeInput('val', $('#hidjoiningDate').val());
              }
             if($('#hidempDateOfBirth').val()){
                 $("#empDateOfBirth").jqxDateTimeInput('val', $('#hidempDateOfBirth').val());
              }
             if($('#hidcmbcurrency').val()!=""){
                 getCurrencyIds();
                 $('#cmbcurrency').val($('#hidcmbcurrency').val());
             }
             if($('#hidtype').val()!=""){
                 $('#cmbtype').val($('#hidtype').val());
             }
             $('#cmbempsex').val($('#hidcmbempsex').val());
             $('#cmbempbloodgroup').val($('#hidcmbempbloodgroup').val());
             $('#cmbempmaritalstatus').val($('#hidcmbempmaritalstatus').val());
              
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
              
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
              
             if(document.getElementById("lblemployeestatus").innerText.trim()=="TERMINATED"){
                    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
              } else {
                    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
              }
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal> 0){
                 $("#compensationDiv").load("compensationGrid.jsp?docno="+indexVal);
                 $("#documentsDiv").load("documentsGrid.jsp?docno="+indexVal);
             } 
        }
    
     function funChkButton() {
            /* funReset(); */
        }
     function getEmpMasterconfig(){
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();
                    document.getElementById("empprint").value=items;
            }
            }
            x.open("GET", "getEmpMasterconfig.jsp", true);
            x.send();
    }
     function funPrintBtn(){
            var empprint=$('#empprint').val();
            if (($("#mode").val() == "view") && $("#docno").val()!="") {
                if(empprint==1) {
                    PrintContent('printVoucherWindow.jsp');
                } else {
             if (($("#mode").val() == "view") && $("#docno").val()!="") {
                   var url=document.URL;
                    var reurl=url.split("saveEmployeeMaster");
                    var brhid=<%=session.getAttribute("BRANCHID").toString()%>
                    var dtype=$('#formdetailcode').val();
                   var win= window.open(reurl[0]+"printEmployeeMasterJrxml?docno="+document.getElementById("docno").value+"&dtype="+dtype+"&brhid="+brhid,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");   
                   win.focus(); 
                   }else {
                       $.messager.alert('Message','Select a Document....!','warning');
                       return false;
                      } 
            }
            } else {
                $.messager.alert('Message','Select a Document....!','warning');
                return false;
            }
        }
     function PrintContent(url) {
            $('#printWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#printWindow').jqxWindow('setContent', data);
            $('#printWindow').jqxWindow('bringToFront');
                }); 
      }
    
     function funemployeecodecheck() {
            var x = new XMLHttpRequest();
            x.onreadystatechange = function() {
                if (x.readyState == 4 && x.status == 200) {
                    var items = x.responseText.trim();  
                    if(parseInt(items)>0 && $("#mode").val()=="A"){
                         $("#txtemployeeid").val(items)
                         $("#txtbankemployeeid").val(items)  
                        }
                } 
            }
            x.open("GET", "linkchk.jsp", true);   
            x.send();   
        }
</script>
</head>

<body onload="setValues();getEmpMasterconfig();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmEmployeeMaster" action="saveEmployeeMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <span id="errormsg"></span>

    <div class="middle-panel">
        <span class="middle-panel-title">General Info</span>
        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Date</label>
            <div style="width: 120px;">
                <div id="employeeDate" name="employeeDate" value='<s:property value="employeeDate"/>'></div>
                <input type="hidden" id="hidemployeeDate" name="hidemployeeDate" value='<s:property value="hidemployeeDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:100px;">Employee ID</label>
            <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Employee ID" onblur="getEmployeeCodeAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtemployeeid"/>' style="width:120px;" />
            
            <label id="lblemployeestatus" name="lblemployeestatus" style="flex:1; text-align:center;"><s:property value="lblemployeestatus"/></label>
            
            <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
            <input type="text" id="docno" name="txtempmasterdocno" tabindex="-1" value='<s:property value="txtempmasterdocno"/>' style="width:120px;" readonly />
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Employment Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Name</label>
            <input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" value='<s:property value="txtemployeename"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:80px;">Account</label>
            <div class="input-search-container" style="width:120px;">
                <input type="text" id="txtempaccount" name="txtempaccount" placeholder="Press F3" value='<s:property value="txtempaccount"/>' onfocus="getCurrencyIds();" onkeydown="getEmpAccount(event);"/>
                <svg class="magnifier-icon" onclick="accountSearchContent('<%=contextPath%>/com/humanresource/setup/accountsDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:90px;">Account Name</label>
            <input type="text" id="txtempaccountname" name="txtempaccountname" placeholder="Employee Account Name" value='<s:property value="txtempaccountname"/>' style="width:150px;" tabindex="-1" readonly />
            <input type="hidden" id="txtempaccdocno" name="txtempaccdocno" value='<s:property value="txtempaccdocno"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Currency</label>
            <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>' style="width:120px;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
            
            <label class="lbl-right" style="width:80px;">Date of Joining</label>
            <div style="width: 120px;">
                <div id="joiningDate" name="joiningDate" value='<s:property value="joiningDate"/>'></div>
                <input type="hidden" id="hidjoiningDate" name="hidjoiningDate" value='<s:property value="hidjoiningDate"/>'/>
            </div>
            
            <label class="lbl-right" style="width:90px;">Designation</label>
            <select id="cmbempdesignation" name="cmbempdesignation" value='<s:property value="cmbempdesignation"/>' style="flex:1;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Department</label>
            <select id="cmbempdepartment" name="cmbempdepartment" value='<s:property value="cmbempdepartment"/>' style="width:120px;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>
            
            <label class="lbl-right" style="width:80px;">Payroll Cat.</label>
            <select id="cmbpayrollcategory" name="cmbpayrollcategory" value='<s:property value="cmbpayrollcategory"/>' style="width:120px;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/>
            
            <label class="lbl-right" style="width:90px;">Cost/Hour</label>
            <input type="text" id="txtempcostperhour" name="txtempcostperhour" style="flex:1; text-align:right;" placeholder="Cost Per Hour" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtempcostperhour"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Travels</label>
            <input type="text" id="txtemptravels" name="txtemptravels" style="width:120px; text-align:right;" placeholder="Travels" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtemptravels"/>'/>
            
            <label class="lbl-right" style="width:80px;">Est. Code</label>
            <div class="input-search-container" style="width:120px;">
                <input type="text" id="txtest_code" name="txtest_code" placeholder="Press F3" value='<s:property value="txtest_code"/>' />
                <svg class="magnifier-icon" onclick="establishedCodeSearchContent('establishmentCodeDetailsSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:90px;">Company Name</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtco_name" name="txtco_name" placeholder="Press F3" value='<s:property value="txtco_name"/>' />
                <svg class="magnifier-icon" onclick="compSearchContent('companydetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Qualification</label>
            <input type="text" id="txtqualification" name="txtqualification" placeholder="Qualification" value='<s:property value="txtqualification"/>' style="width:120px;"/>
            
            <label class="lbl-right costdiv" style="width:80px;" hidden>Cost</label>
            <div class="input-search-container costdiv" style="width:120px;" hidden>
                <input type="text" id="txtcost" name="txtcost" placeholder="Press F3" value='<s:property value="txtcost"/>' onkeydown="getCost(event);" />
                <svg class="magnifier-icon" onclick="costCodeSearchContent('<%=contextPath%>/com/humanresource/setup/employeemaster/costSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="hidden" id="hidcostid" name="hidcostid" value='<s:property value="hidcostid"/>'/>
            </div>
            
            <label class="lbl-right typediv" style="width:90px;" hidden>Type</label>
            <select id="cmbtype" name="cmbtype" class="typediv" value='<s:property value="cmbtype"/>' style="flex:1;" hidden>
                <option value="0">--Select--</option>
                <option value="1">Full Time</option>
                <option value="2">Fixed Term contractors</option>
                <option value="3">Freelancers</option>
            </select>
            <input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>'/>
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Personal Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Permanent Addr</label>
            <input type="text" id="txtpermanentaddress" name="txtpermanentaddress" placeholder="Permanent Address" value='<s:property value="txtpermanentaddress"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:90px;">Present Addr</label>
            <input type="text" id="txtpresentaddress" name="txtpresentaddress" placeholder="Present Address" value='<s:property value="txtpresentaddress"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Mobile (Perm)</label>
            <input type="text" id="txtpermanentmobile" name="txtpermanentmobile" placeholder="Permanent Mobile" value='<s:property value="txtpermanentmobile"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:90px;">Email (Perm)</label>
            <input type="text" id="txtpermanentemail" name="txtpermanentemail" placeholder="Permanent Email ID" value='<s:property value="txtpermanentemail"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Mobile (Pres)</label>
            <input type="text" id="txtpresentmobile" name="txtpresentmobile" placeholder="Present Mobile" value='<s:property value="txtpresentmobile"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:90px;">Email (Pres)</label>
            <input type="text" id="txtpresentemail" name="txtpresentemail" placeholder="Present Email ID" value='<s:property value="txtpresentemail"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">City</label>
            <input type="text" id="txtempcity" name="txtempcity" placeholder="City" value='<s:property value="txtempcity"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:50px;">State</label>
            <input type="text" id="txtempstate" name="txtempstate" placeholder="State" value='<s:property value="txtempstate"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:50px;">Pincode</label>
            <input type="text" id="txtemppincode" name="txtemppincode" placeholder="Pincode" value='<s:property value="txtemppincode"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Nationality</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtempnationality" name="txtempnationality" placeholder="Press F3" value='<s:property value="txtempnationality"/>' onkeydown="getNations(event);" />
                <svg class="magnifier-icon" onclick="nationalitySearchContent('nationSearchGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                <input type="hidden" id="txtempnationalityid" name="txtempnationalityid" value='<s:property value="txtempnationalityid"/>'/>
            </div>
            
            <label class="lbl-right" style="width:90px;">Religion</label>
            <input type="text" id="txtempreligion" name="txtempreligion" placeholder="Religion" value='<s:property value="txtempreligion"/>' style="flex:1;" />
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Place of Birth</label>
            <input type="text" id="txtempplaceofbirth" name="txtempplaceofbirth" placeholder="Place of Birth" value='<s:property value="txtempplaceofbirth"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:90px;">Date of Birth</label>
            <div style="flex:1;">
                <div id="empDateOfBirth" name="empDateOfBirth" value='<s:property value="empDateOfBirth"/>'></div>
                <input type="hidden" id="hidempDateOfBirth" name="hidempDateOfBirth" value='<s:property value="hidempDateOfBirth"/>'/>
            </div>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Sex</label>
            <select id="cmbempsex" name="cmbempsex" value='<s:property value="cmbempsex"/>' style="flex:1;">
                <option value="">--Select--</option>
                <option value="M">Male</option>
                <option value="F">Female</option>
            </select>
            <input type="hidden" id="hidcmbempsex" name="hidcmbempsex" value='<s:property value="hidcmbempsex"/>'/>
            
            <label class="lbl-right" style="width:50px;">Blood</label>
            <select id="cmbempbloodgroup" name="cmbempbloodgroup" value='<s:property value="cmbempbloodgroup"/>' style="flex:1;">
                <option value="">--Select--</option>
                <option value="O +ve">O Positive</option>
                <option value="O -ve">O Negative</option>
                <option value="A +ve">A Positive</option>
                <option value="A -ve">A Negative</option>
                <option value="B +ve">B Positive</option>
                <option value="B -ve">B Negative</option>
                <option value="AB +ve">AB Positive</option>
                <option value="AB -ve">AB Negative</option>
            </select>
            <input type="hidden" id="hidcmbempbloodgroup" name="hidcmbempbloodgroup" value='<s:property value="hidcmbempbloodgroup"/>'/>
            
            <label class="lbl-right" style="width:80px;">Marital Status</label>
            <select id="cmbempmaritalstatus" name="cmbempmaritalstatus" value='<s:property value="cmbempmaritalstatus"/>' style="flex:1;">
                <option value="">--Select--</option>
                <option value="SINGLE">Single</option>
                <option value="MARRIED">Married</option>
            </select>
            <input type="hidden" id="hidcmbempmaritalstatus" name="hidcmbempmaritalstatus" value='<s:property value="hidcmbempmaritalstatus"/>'/>
        </div>

        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Father's Name</label>
            <input type="text" id="txtempfathername" name="txtempfathername" placeholder="Father's Name" value='<s:property value="txtempfathername"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:90px;">Mother's Name</label>
            <input type="text" id="txtempmothername" name="txtempmothername" placeholder="Mother's Name" value='<s:property value="txtempmothername"/>' style="flex:1;" />
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Spouse's Name</label>
            <input type="text" id="txtempspousename" name="txtempspousename" placeholder="Spouse's Name" value='<s:property value="txtempspousename"/>' style="width:150px;" />
            
            <label class="lbl-right" style="width:60px;">Other Details</label>
            <input type="text" id="txtempotherdetails" name="txtempotherdetails" placeholder="Other Details" value='<s:property value="txtempotherdetails"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:80px;">Nearest Airport</label>
            <input type="text" id="txtempnearestairport" name="txtempnearestairport" placeholder="Nearest Airport" value='<s:property value="txtempnearestairport"/>' style="width:120px;" />
        </div>
    </div>

    <div class="middle-panel">
        <span class="middle-panel-title">Bank Details</span>
        
        <div class="field-row">
            <label class="lbl-right" style="width:100px;">Agent ID</label>
            <select id="cmbempagentid" name="cmbempagentid" value='<s:property value="cmbempagentid"/>' style="flex:1;">
                <option value="">--Select--</option>
            </select>
            <input type="hidden" id="hidcmbempagentid" name="hidcmbempagentid" value='<s:property value="hidcmbempagentid"/>'/>
            
            <label class="lbl-right" style="width:100px;">Emp ID (Bank)</label>
            <input type="text" id="txtbankemployeeid" name="txtbankemployeeid" placeholder="Employee ID" value='<s:property value="txtbankemployeeid"/>' style="flex:1;" />
            
            <label class="lbl-right" style="width:100px;">Bank Acc No.</label>
            <input type="text" id="txtbankaccountno" name="txtbankaccountno" placeholder="Bank Account No." value='<s:property value="txtbankaccountno"/>' style="flex:1;" />
        </div>

        <div class="field-row" style="margin-bottom:0;">
            <label class="lbl-right" style="width:100px;">Branch Name</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtbankbranchname" name="txtbankbranchname" placeholder="Press F3" value='<s:property value="txtbankbranchname"/>' />
                <svg class="magnifier-icon" onclick="brchSearchContent('branchdetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <label class="lbl-right" style="width:100px;">IFSC Code</label>
            <div class="input-search-container" style="flex:1;">
                <input type="text" id="txtbankifsccode" name="txtbankifsccode" placeholder="Press F3" value='<s:property value="txtbankifsccode"/>' />
                <svg class="magnifier-icon" onclick="ifsccodeSearchContent('ifsccodedetailsGrid.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
            </div>
            
            <div style="flex:1;"></div> </div>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Monthly Salary</span>
        <div id="compensationDiv" class="grid-container"><jsp:include page="compensationGrid.jsp"></jsp:include></div>
    </div>

    <div class="middle-panel" style="padding-top:25px;">
        <span class="middle-panel-title">Documents</span>
        <div id="documentsDiv" class="grid-container"><jsp:include page="documentsGrid.jsp"></jsp:include></div>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    <input type="hidden" id="monthlysalarygridlength" name="monthlysalarygridlength"/>
    <input type="hidden" id="documentsgridlength" name="documentsgridlength"/>
    <input type="hidden" id="empprint" name="empprint"/>
    <input type="hidden" id="convertCandidate" name="convertCandidate" value='<s:property value="convertCandidate"/>'/>

</div>
</form>

<div id="cashReceiptGridWindow"><div></div><div></div></div>  
<div id="accountDetailsFromWindow"><div></div><div></div></div>  
<div id="accountDetailsToWindow"><div></div><div></div></div> 
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 
<div id="accountDetailsWindow"><div></div></div>
<div id="nationalityWindow"><div></div></div>
<div id="printWindow"><div></div></div>
<div id="brchWindow"><div></div></div>   
<div id="ifsccodeWindow"><div></div></div>
<div id="establishedCodeDetailsWindow"><div></div></div>   
<div id="compWindow"><div></div></div>

</div>
</body>
</html>