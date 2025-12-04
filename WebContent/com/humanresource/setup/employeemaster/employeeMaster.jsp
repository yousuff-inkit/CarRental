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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">
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
    /* --- GLOBAL LAYOUT --- */
    html { overflow-y: scroll; }
    body {
        background-color: #f0f4f8;
        font-family: 'Segoe UI', 'Roboto', Helvetica, Arial, sans-serif;
        margin: 0; padding: 0;
        color: #334155;
    }

    /* --- BACKGROUND WIDTH FIX --- */
    #mainBG, .homeContent {
        width: 100%;
        min-width: 1350px !important; 
        height: auto;
        min-height: 100vh;
        box-sizing: border-box;
        padding-bottom: 80px;
    }

    #frmEmployeeMaster {
        width: 98%;
        margin: 20px auto;
        padding: 0 15px;
        box-sizing: border-box;
    }

    /* --- CARD SECTIONS --- */
    /* This replaces your old colored divs */
    .header-card-section {
        background: linear-gradient(to bottom right, #dbeafe, #eff6ff); 
        border-radius: 16px;
        padding: 20px;
        box-shadow: 0 4px 15px rgba(59, 130, 246, 0.15);
        border: 1px solid #bfdbfe;
        margin-bottom: 20px;
    }

    /* --- GRID CARD SECTION --- */
    .grid-card-section {
        background: #ffffff;
        border-radius: 16px;
        padding: 15px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        border: 1px solid #e2e8f0;
        margin-bottom: 20px;
    }

    /* --- SECTION TITLES --- */
    h3 {
        color: #1e3a8a; 
        font-weight: 700;
        font-size: 1.3rem;
        margin: 0 0 15px 0;
        border-bottom: 2px solid #e2e8f0;
        padding-bottom: 5px;
    }

    /* --- TABLE LAYOUT --- */
    .header-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0 10px; 
        table-layout: auto; 
    }

    /* Labels */
    .header-table td[align="right"] {
        text-align: right;
        color: #1e3a8a;
        font-weight: 700;
        font-size: 15px; 
        white-space: nowrap;
        vertical-align: middle;
        padding-right: 15px; 
    }

    /* Inputs */
    .header-table td {
        vertical-align: middle;
    }

    /* --- PILL INPUT STYLING --- */
    .header-card-section input[type="text"],
    .header-card-section select,
    .header-card-section .jqxDateTimeInput {
        background-color: #ffffff !important;
        border: 1px solid #94a3b8 !important;
        border-radius: 8px !important; 
        height: 38px !important;
        padding: 0 12px !important;
        box-shadow: 0 1px 2px rgba(0,0,0,0.05) !important;
        color: #334155;
        font-size: 14px;
        font-weight: 500;
        width: 100% !important;
        box-sizing: border-box; 
    }

    /* Focus State */
    .header-card-section input[type="text"]:focus, 
    .header-card-section select:focus {
        border-color: #2563eb !important;
        box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2) !important;
        outline: none;
    }

    /* JQX Override */
    .jqx-widget-content {
        border-radius: 8px !important;
        border-color: #94a3b8 !important;
    }
    
    /* Error Msg */
    #errormsg {
        color: #dc2626;
        font-weight: 700;
        text-align: center;
        margin-top: 10px;
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
          /* Date */
          $("#employeeDate").jqxDateTimeInput({ width: '100%', height: '38px', formatString:"dd.MM.yyyy"});
          $("#joiningDate").jqxDateTimeInput({ width: '100%', height: '38px', formatString:"dd.MM.yyyy"});
          $("#empDateOfBirth").jqxDateTimeInput({ width: '100%', height: '38px', formatString:"dd.MM.yyyy"});
          
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
                        //document.getElementById("errormsg").innerText="Employee ID Already Exists.";
                         retval = 0;
                     } else { 
                        //document.getElementById("errormsg").innerText="";
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
                        // document.getElementById("errormsg").innerText="Employee Already Exists.";
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
                 cmbpayrollcategory:"required",
                 //txtmob: {"required":true,digits:true,maxlength:12,minlength:12},
                  
                  },
                  messages: {
                  txtemployeename:" *",
                  cmbempdesignation:" *",
                  cmbempdepartment:" *",
                  cmbpayrollcategory:" *",
                  //txtmob: {required:" *",digits:" Invalid Mobile Number",maxlength:" Maximum 12 Digits",minlength:" Please Enter 12 Digits"},
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
         /* Validation */
        
        
        
        // document.getElementById("errormsg").innerText="";        
         /* Validation Ends*/
        
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
                // alert(rows[i].documentid);
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
                    
            // alert(rows[i].documentid+" :: "+issueDate+" :: "+expDate+":: "+rows[i].place_of_issue+":: "+rows[i].location+":: "+rows[i].remarks+":: "+rows[i].documentno);                 
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
        // alert("val==>"+val);
         if(val==0){
             document.getElementById("errormsg").innerText="Employee Already Exists.";
             return 0;
         }
         val1=getEmployeeCodeAlreadyExists(empcode,docno,mode);
         //alert("val1==>"+val);
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
                if(empprint==1)
                    {
                    PrintContent('printVoucherWindow.jsp');
                    }
                
                else
                    {
             if (($("#mode").val() == "view") && $("#docno").val()!="") {
                        
                   var url=document.URL;
                   //alert(url);
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
                
            }   
                
            
            else {
                
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
                    //alert(items);
                    if(parseInt(items)>0 && $("#mode").val()=="A"){
                         $("#txtemployeeid").val(items)
                         $("#txtbankemployeeid").val(items)  
                        }
                    else{
                        
                        }  
                } else {
                }   
            }
            x.open("GET", "linkchk.jsp", true);     
            x.send();    
        }
    
</script>
</head>
<body onload="setValues();getEmpMasterconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmEmployeeMaster" action="saveEmployeeMaster" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar receipt-header'>
    
    <div class="header-card-section">
        <table class="header-table">
            <colgroup>
                <col style="width: 10%;">  <col style="width: 15%;">  
                <col style="width: 10%;">  <col style="width: 15%;">  
                <col style="width: 10%;">  <col style="width: 15%;">  
                <col style="width: auto;">
            </colgroup>
            <tr>
                <td align="right">Date</td>
                <td>
                    <div id="employeeDate" name="employeeDate" value='<s:property value="employeeDate"/>'></div>
                    <input type="hidden" id="hidemployeeDate" name="hidemployeeDate" value='<s:property value="hidemployeeDate"/>'/>
                </td>
                <td align="right">Employee ID</td>
                <td>
                    <input type="text" id="txtemployeeid" name="txtemployeeid" placeholder="Employee ID" onblur="getEmployeeCodeAlreadyExists(this.value,$('#docno').val(),$('#mode').val());" value='<s:property value="txtemployeeid"/>'/>
                </td>
                <td align="right">Doc No</td>
                <td>
                    <input type="text" id="docno" name="txtempmasterdocno" tabindex="-1" value='<s:property value="txtempmasterdocno"/>'/>
                </td>
                <td align="center" style="padding-left: 10px;">
                    <i><b><label id="lblemployeestatus" name="lblemployeestatus" style="font-size: 13px;font-family: Tahoma; color:#6000FC;"><s:property value="lblemployeestatus"/></label></b></i>
                </td>
            </tr>
            
            <tr>
                <td align="right">Name</td>
                <td><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" value='<s:property value="txtemployeename"/>'/></td>
                <td align="right">Account</td>
                <td><input type="text" id="txtempaccount" name="txtempaccount" placeholder="Press F3" value='<s:property value="txtempaccount"/>' onfocus="getCurrencyIds();" onkeydown="getEmpAccount(event);"/></td>
                <td align="right">Acc. Name</td>
                <td colspan="2">
                    <input type="text" id="txtempaccountname" name="txtempaccountname" placeholder="Account Name" value='<s:property value="txtempaccountname"/>' tabindex="-1"/>
                    <input type="hidden" id="txtempaccdocno" name="txtempaccdocno" value='<s:property value="txtempaccdocno"/>'/>
                </td>
            </tr>
            
            <tr>
                <td align="right">Currency</td>
                <td>
                    <select id="cmbcurrency" name="cmbcurrency" value='<s:property value="cmbcurrency"/>'><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbcurrency" name="hidcmbcurrency" value='<s:property value="hidcmbcurrency"/>'/>
                </td>
                <td align="right">Date of Joining</td>
                <td>
                    <div id="joiningDate" name="joiningDate" value='<s:property value="joiningDate"/>'></div>
                    <input type="hidden" id="hidjoiningDate" name="hidjoiningDate" value='<s:property value="hidjoiningDate"/>'/>
                </td>
                <td align="right">Designation</td>
                <td>
                    <select id="cmbempdesignation" name="cmbempdesignation" value='<s:property value="cmbempdesignation"/>'><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbempdesignation" name="hidcmbempdesignation" value='<s:property value="hidcmbempdesignation"/>'/>
                </td>
            </tr>

            <tr>
                <td align="right">Department</td>
                <td>
                    <select id="cmbempdepartment" name="cmbempdepartment" value='<s:property value="cmbempdepartment"/>'><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbempdepartment" name="hidcmbempdepartment" value='<s:property value="hidcmbempdepartment"/>'/>
                </td>
                <td align="right">Payroll Cat</td>
                <td>
                    <select id="cmbpayrollcategory" name="cmbpayrollcategory" value='<s:property value="cmbpayrollcategory"/>'><option value="">--Select--</option></select>
                    <input type="hidden" id="hidcmbpayrollcategory" name="hidcmbpayrollcategory" value='<s:property value="hidcmbpayrollcategory"/>'/>
                </td>
                <td align="right">Cost/Hour</td>
                <td>
                    <input type="text" id="txtempcostperhour" name="txtempcostperhour" style="text-align: right;" placeholder="Cost" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtempcostperhour"/>'/>
                </td>
            </tr>

            <tr>
                <td align="right">Travels</td>
                <td>
                    <input type="text" id="txtemptravels" name="txtemptravels" style="text-align: right;" placeholder="Travels" onblur="funRoundAmt(this.value,this.id);" value='<s:property value="txtemptravels"/>'/>
                </td>
                <td align="right">Est. Code</td>
                <td>
                    <input type="text" id="txtest_code" name="txtest_code" placeholder="Press F3" value='<s:property value="txtest_code"/>'/>
                </td>
                <td align="right">Company</td>
                <td>
                    <input type="text" id="txtco_name" name="txtco_name" placeholder="Press F3" value='<s:property value="txtco_name"/>'/>
                </td>
            </tr>

            <tr>
                <td align="right">Qualification</td>
                <td>
                    <input type="text" id="txtqualification" name="txtqualification" placeholder="Qualification" value='<s:property value="txtqualification"/>'/>
                </td>
                <td align="right" class="costdiv" hidden>Cost</td>
                <td class="costdiv" hidden>
                    <input type="text" id="txtcost" name="txtcost" placeholder="Press F3" value='<s:property value="txtcost"/>' onkeydown="getCost(event);"/>
                    <input type="hidden" id="hidcostid" name="hidcostid" value='<s:property value="hidcostid"/>'/>
                </td>
                <td align="right" class="typediv" hidden>Type</td>
                <td class="typediv" hidden>
                    <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                        <option value="0">--Select--</option><option value="1">Full Time</option><option value="2">Fixed Term contractors</option><option value="3">Freelancers</option>
                    </select>
                    <input type="hidden" id="hidtype" name="hidtype" value='<s:property value="hidtype"/>'/>
                </td>
            </tr>
        </table>
    </div>

    <div class="header-card-section">
        <h3>Personal Details</h3>
        <table class="header-table">
             <colgroup>
                <col style="width: 10%;"> <col style="width: 22%;"> 
                <col style="width: 10%;"> <col style="width: 22%;"> 
                <col style="width: 10%;"> <col style="width: 22%;"> 
                <col style="width: auto;">
            </colgroup>
            
            <tr>
                <td align="right">Address (Perm)</td>
                <td colspan="3">
                    <input type="text" id="txtpermanentaddress" name="txtpermanentaddress" placeholder="Permanent Address" value='<s:property value="txtpermanentaddress"/>'/>
                </td>
                <td align="right">Address (Pres)</td>
                <td colspan="2">
                    <input type="text" id="txtpresentaddress" name="txtpresentaddress" placeholder="Present Address" value='<s:property value="txtpresentaddress"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">Mobile (Perm)</td>
                <td><input type="text" id="txtpermanentmobile" name="txtpermanentmobile" value='<s:property value="txtpermanentmobile"/>'/></td>
                <td align="right">Email (Perm)</td>
                <td><input type="text" id="txtpermanentemail" name="txtpermanentemail" value='<s:property value="txtpermanentemail"/>'/></td>
                <td align="right">Mobile (Pres)</td>
                <td><input type="text" id="txtpresentmobile" name="txtpresentmobile" value='<s:property value="txtpresentmobile"/>'/></td>
            </tr>
            <tr>
                <td align="right">Email (Pres)</td>
                <td><input type="text" id="txtpresentemail" name="txtpresentemail" value='<s:property value="txtpresentemail"/>'/></td>
                <td align="right">City</td>
                <td><input type="text" id="txtempcity" name="txtempcity" value='<s:property value="txtempcity"/>'/></td>
                <td align="right">State</td>
                <td><input type="text" id="txtempstate" name="txtempstate" value='<s:property value="txtempstate"/>'/></td>
            </tr>
            <tr>
                <td align="right">Pincode</td>
                <td><input type="text" id="txtemppincode" name="txtemppincode" value='<s:property value="txtemppincode"/>'/></td>
                <td align="right">Nationality</td>
                <td>
                    <input type="text" id="txtempnationality" name="txtempnationality" placeholder="Press F3" value='<s:property value="txtempnationality"/>'  onkeydown="getNations(event);"/>
                    <input type="hidden" id="txtempnationalityid" name="txtempnationalityid" value='<s:property value="txtempnationalityid"/>'/>
                </td>
                <td align="right">Religion</td>
                <td><input type="text" id="txtempreligion" name="txtempreligion" value='<s:property value="txtempreligion"/>'/></td>
            </tr>
            <tr>
                <td align="right">Nearest Airport</td>
                <td><input type="text" id="txtempnearestairport" name="txtempnearestairport" value='<s:property value="txtempnearestairport"/>'/></td>
                <td align="right">Place of Birth</td>
                <td><input type="text" id="txtempplaceofbirth" name="txtempplaceofbirth" value='<s:property value="txtempplaceofbirth"/>'/></td>
                <td align="right">Date of Birth</td>
                <td>
                    <div id="empDateOfBirth" name="empDateOfBirth" value='<s:property value="empDateOfBirth"/>'></div>
                    <input type="hidden" id="hidempDateOfBirth" name="hidempDateOfBirth" value='<s:property value="hidempDateOfBirth"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">Sex</td>
                <td>
                    <select id="cmbempsex" name="cmbempsex" value='<s:property value="cmbempsex"/>'>
                      <option value="">--Select--</option><option value="M">Male</option><option value="F">Female</option>
                    </select>
                    <input type="hidden" id="hidcmbempsex" name="hidcmbempsex" value='<s:property value="hidcmbempsex"/>'/>
                </td>
                <td align="right">Blood Group</td>
                <td>
                    <select id="cmbempbloodgroup" name="cmbempbloodgroup" value='<s:property value="cmbempbloodgroup"/>'>
                      <option value="">--Select--</option><option value="O +ve">O Positive</option><option value="O -ve">O Negative</option><option value="A +ve">A Positive</option>
                      <option value="A -ve">A Negative</option><option value="B +ve">B Positive</option><option value="B -ve">B Negative</option><option value="AB +ve">AB Positive</option>
                      <option value="AB -ve">AB Negative</option>
                    </select>
                    <input type="hidden" id="hidcmbempbloodgroup" name="hidcmbempbloodgroup" value='<s:property value="hidcmbempbloodgroup"/>'/>
                </td>
                <td align="right">Marital Status</td>
                <td>
                    <select id="cmbempmaritalstatus" name="cmbempmaritalstatus" value='<s:property value="cmbempmaritalstatus"/>'>
                      <option value="">--Select--</option><option value="SINGLE">Single</option><option value="MARRIED">Married</option>
                    </select>
                    <input type="hidden" id="hidcmbempmaritalstatus" name="hidcmbempmaritalstatus" value='<s:property value="hidcmbempmaritalstatus"/>'/>
                </td>
            </tr>
            <tr>
                <td align="right">Father's Name</td>
                <td><input type="text" id="txtempfathername" name="txtempfathername" value='<s:property value="txtempfathername"/>'/></td>
                <td align="right">Mother's Name</td>
                <td><input type="text" id="txtempmothername" name="txtempmothername" value='<s:property value="txtempmothername"/>'/></td>
                <td align="right">Spouse's Name</td>
                <td><input type="text" id="txtempspousename" name="txtempspousename" value='<s:property value="txtempspousename"/>'/></td>
            </tr>
             <tr>
                <td align="right">Other Details</td>
                <td colspan="5">
                    <input type="text" id="txtempotherdetails" name="txtempotherdetails" value='<s:property value="txtempotherdetails"/>'/>
                </td>
            </tr>
        </table>
    </div>

    <div class="header-card-section">
        <h3>Bank Details</h3>
        <table class="header-table">
            <colgroup>
                <col style="width: 10%;"> <col style="width: 15%;"> 
                <col style="width: 10%;"> <col style="width: 15%;"> 
                <col style="width: 10%;"> <col style="width: 15%;"> 
                <col style="width: auto;">
            </colgroup>
            <tr>
                <td align="right">Agent ID</td>
                <td>
                    <select id="cmbempagentid" name="cmbempagentid" value='<s:property value="cmbempagentid"/>'>
                      <option value="">--Select--</option>
                    </select>
                    <input type="hidden" id="hidcmbempagentid" name="hidcmbempagentid" value='<s:property value="hidcmbempagentid"/>'/>
                </td>
                <td align="right">Employee ID</td>
                <td><input type="text" id="txtbankemployeeid" name="txtbankemployeeid" value='<s:property value="txtbankemployeeid"/>'/></td>
                <td align="right">Account No.</td>
                <td><input type="text" id="txtbankaccountno" name="txtbankaccountno" value='<s:property value="txtbankaccountno"/>'/></td>
            </tr>
            <tr>
                <td align="right">Branch Name</td>
                <td><input type="text" id="txtbankbranchname" name="txtbankbranchname" placeholder="Press F3" value='<s:property value="txtbankbranchname"/>'/></td>
                <td align="right">IFSC Code</td>
                <td><input type="text" id="txtbankifsccode" name="txtbankifsccode" placeholder="Press F3" value='<s:property value="txtbankifsccode"/>'/></td>
            </tr>
        </table>
    </div>

    <div class="grid-card-section">
        <h3>Monthly Salary</h3>
        <div class="cr-table" id="compensationDiv"><jsp:include page="compensationGrid.jsp"></jsp:include></div>
    </div>

    <div class="grid-card-section">
        <h3>Documents</h3>
        <div class="cr-table" id="documentsDiv"><jsp:include page="documentsGrid.jsp"></jsp:include></div>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    <input type="hidden" id="monthlysalarygridlength" name="monthlysalarygridlength"/>
    <input type="hidden" id="documentsgridlength" name="documentsgridlength"/>
    <input type="hidden" id="empprint" name="empprint"/>
    <input type="hidden" id="convertCandidate" name="convertCandidate" value='<s:property value="convertCandidate"/>'/>

</div>
</form>

<div id="accountDetailsWindow"><div></div></div>
<div id="costCodeSearchWindow"><div></div></div> 
<div id="nationalityWindow"><div></div></div>
<div id="printWindow"><div></div></div>
<div id="brchWindow"><div></div></div>  
<div id="ifsccodeWindow"><div></div></div>
<div id="establishedCodeDetailsWindow"><div></div></div>    
<div id="compWindow"><div></div></div>

</div>
</body>
</html>