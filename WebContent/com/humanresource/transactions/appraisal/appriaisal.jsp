<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<jsp:include page="../../../../includes.jsp"></jsp:include> 

<style>
/* =========================================================
   SCOPED UI: Modern Layout (Strict 24px Height)
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

form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 10px; display: block; padding-left: 15px; }

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* Checkbox Header Alignment */
.modern-ui .chk-title {
    display: flex;
    align-items: center;
    gap: 5px;
    margin: 0;
    padding: 0;
    cursor: pointer;
}
.modern-ui .chk-title input {
    margin: 0;
    cursor: pointer;
}
</style>

<script type="text/javascript">
 $(document).ready(function () {
     
     /* Formatted jqxDateTimeInput heights to match modern UI 24px */
     var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
     
     $("#masterdate").jqxDateTimeInput(dateWidgetSettings);     
     $("#leastpaydate").jqxDateTimeInput(dateWidgetSettings);     
     $("#joindate").jqxDateTimeInput(dateWidgetSettings);     
     $("#prevappdate").jqxDateTimeInput(dateWidgetSettings);     
      
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
     $('#empsearchwndow').jqxWindow({ width: '60%', height: '59%',  maxHeight: '80%' ,maxWidth: '80%' , title: 'Employee Search' ,position: { x: 300, y: 80 }, theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
     $('#empsearchwndow').jqxWindow('close'); 
 
     $('#empid').dblclick(function(){
         $('#empsearchwndow').jqxWindow('open');
         empSearchContent('employeeDetailsSearch.jsp'); 
     }); 
      
     $('#leastpaydate').on('change', function (event) {
         if ($("#mode").val() == "A" || $("#mode").val() == "E") {  
             if(document.getElementById("cmbyear").value==""|| document.getElementById("cmbmonth").value=="") {
                 return 0;
              }
              
              var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
              payrolldate.setHours(0,0,0,0);
              var year1=payrolldate.getFullYear();  
              var cmbyear=document.getElementById("cmbyear").value;
          
              if(year1>cmbyear) {
                 document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On";
                 return false; 
              }
 
              if(year1<cmbyear) {
                 var mounth1=payrolldate.getMonth()+1;
                 var cmbmonth=document.getElementById("cmbmonth").value;  
                 if(mounth1>=cmbmonth) {
                   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On";
                   return false; 
                 } else {   
                   document.getElementById("errormsg").innerText="";  
                 } 
              } else {
                 document.getElementById("errormsg").innerText="";  
              } 
         }
   });
        
    getYear();
 });
        
   function empSearchContent(url) {
         $.get(url).done(function (data) {
         $('#empsearchwndow').jqxWindow('open');
         $('#empsearchwndow').jqxWindow('setContent', data);
    }); 
    } 
       
    function getEmployee(event){
       var x= event.keyCode;
       if(x==114){
           empSearchContent('employeeDetailsSearch.jsp');
       }
       else{}
       }
       
    function funReset(){}
    
    function funReadOnly(){
          $('#frmappraisal input').prop('readonly', true );
          $('#change').attr('disabled', true);
          $('#masterdate').jqxDateTimeInput({ disabled: true});
          $('#leastpaydate').jqxDateTimeInput({ disabled: true});
          $('#joindate').jqxDateTimeInput({ disabled: true});
          $('#prevappdate').jqxDateTimeInput({ disabled: true});
          $("#compensationGridID").jqxGrid({ disabled: true});
         
          $('#cmbdept').attr("disabled", true);
          $('#cmbdesignation').attr("disabled", true);
          $('#cmbcategory').attr("disabled", true);
          $('#cmbyear').attr("disabled", true);
          $('#cmbmonth').attr("disabled", true);
    }

    function funRemoveReadOnly(){
          $('#frmappraisal input').prop('readonly', false );
          $('#masterdate').jqxDateTimeInput({ disabled: false});
          $('#leastpaydate').jqxDateTimeInput({ disabled: false});
          $('#joindate').jqxDateTimeInput({ disabled: true});
          $('#prevappdate').jqxDateTimeInput({ disabled: false});
          $('#desc').attr("readonly", false);
          $('#change').attr('disabled', false);
          $('#cmbdept').attr("disabled", true);
          $('#cmbdesignation').attr("disabled", true);
          $('#cmbcategory').attr("disabled", true);
          $('#cmbyear').attr("disabled", false);
          $('#cmbmonth').attr("disabled", false);
       
         if($("#mode").val() == "A") {
              $("#compensationGridID").jqxGrid('clear');
              $("#compensationGridID").jqxGrid('addrow', null, {});
              $("#compensationGridID").jqxGrid('disabled', false);
              $('#masterdate').val(new Date());
              $('#leastpaydate').val(new Date());
              $('#joindate').val(new Date());
              $('#prevappdate').val(new Date());
          }
         
         if($("#mode").val() == "E") {
              var docVal1=document.getElementById("docno").value; 
              $("#comdiv").load("compensationGrid.jsp?docno="+docVal1+"&mode="+$("#mode").val()+"&check="+1); 
             
              if(document.getElementById("change").checked==true) {
                     $('#cmbdept').attr("disabled", false);
                     $('#cmbdesignation').attr("disabled", false);
                     $('#cmbcategory').attr("disabled", false);
              }
         }
    } 
    
    
    function checkchange() {
        if(document.getElementById("change").checked==true) {
            $('#cmbdept').attr("disabled", false);
            $('#cmbdesignation').attr("disabled", false);
            $('#cmbcategory').attr("disabled", false);
        } else {
            $('#cmbdept').attr("disabled", true);
            $('#cmbdesignation').attr("disabled", true);
            $('#cmbcategory').attr("disabled", true);
        }
    }
           
    function getDesignation() {
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var designationItems = items[0].split(",");
            var designationIdItems = items[1].split(",");
            var optionsdesignation = '<option value="">--Select--</option>';
            for (var i = 0; i < designationItems.length; i++) {
             optionsdesignation += '<option value="' + designationIdItems[i] + '">'
               + designationItems[i] + '</option>';
            }
            $("select#cmbdesignation").html(optionsdesignation);
            if ($('#hidcmbdesignation').val() != null) {
             $('#cmbdesignation').val($('#hidcmbdesignation').val());
            }
           }
          }
          x.open("GET", "getDesignation.jsp", true);
          x.send();
         }
     
    function getDepartment() {  
          var x = new XMLHttpRequest();
          x.onreadystatechange = function() {
           if (x.readyState == 4 && x.status == 200) {
            var items = x.responseText.split('####');
            var departmentItems = items[0].split(",");
            var departmentIdItems = items[1].split(",");
            var optionsdepartment = '<option value="">--Select--</option>';
            for (var i = 0; i < departmentItems.length; i++) {
             optionsdepartment += '<option value="' + departmentIdItems[i] + '">'
               + departmentItems[i] + '</option>';
            }
            $("select#cmbdept").html(optionsdepartment);
            if ($('#hidcmbdept').val() != null) {
             $('#cmbdept').val($('#hidcmbdept').val());
            }
           }
          }
          x.open("GET", "getDepartment.jsp", true);
          x.send();
         }
         
    function getPayrollCategory() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
         if (x.readyState == 4 && x.status == 200) {
          var items = x.responseText.split('####');
          var payrollcategoryItems = items[0].split(",");
          var payrollcategoryIdItems = items[1].split(",");
          var optionspayrollcategory = '<option value="">--Select--</option>';
          for (var i = 0; i < payrollcategoryItems.length; i++) {
           optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
             + payrollcategoryItems[i] + '</option>';
          }
          $("select#cmbcategory").html(optionspayrollcategory);
          if ($('#hidcmbcategory').val() != null) {
           $('#cmbcategory').val($('#hidcmbcategory').val());
          }
         }
        }
        x.open("GET", "getPayrollCategory.jsp", true);
        x.send();
       }     
        
    function funPrintBtn() {
        if (($("#mode").val() == "view") && $("#docno").val()!="") {
             var url=document.URL;
             var reurl=url.split("saveAppraisal");
             $("#docno").prop("disabled", false);
                   
             var win= window.open(reurl[0]+"printAppraisal?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
             win.focus();
         }
        else {
            $.messager.alert('Message','Select a Document....!','warning');
            return;
        }
    }
    
    function funNotify() { 
          var payrolldate=new Date($('#leastpaydate').jqxDateTimeInput('getDate'));     
          payrolldate.setHours(0,0,0,0);
          var year1=payrolldate.getFullYear();  
          var cmbyear=document.getElementById("cmbyear").value;
          
           if(year1>cmbyear) {
                document.getElementById("errormsg").innerText="Year Cannot be Less than Last Payroll Created On Date";
                return false; 
           }
           
           if(year1<cmbyear) {
                var mounth1=payrolldate.getMonth()+1;
                var cmbmonth=document.getElementById("cmbmonth").value;  
               
                if(mounth1>=cmbmonth) {
                   document.getElementById("errormsg").innerText="Month Cannot be Less than Last Payroll Created On Date";
                   return false; 
                } else {   
                   document.getElementById("errormsg").innerText="";  
                } 
            } else {
                    document.getElementById("errormsg").innerText="";  
            } 
        
           var rows = $("#compensationGridID").jqxGrid('getrows');
           $('#compensationGridlength').val(rows.length);
           for(var i=0 ; i < rows.length ; i++){
            newTextBox = $(document.createElement("input"))
               .attr("type", "dil")
               .attr("id", "test"+i)
               .attr("name", "test"+i)
               .attr("hidden", "true");   
           
               newTextBox.val(rows[i].allowanceid+"::"+((rows[i].addition==" "||rows[i].addition=="")&&(rows[i].deduction!=" "||rows[i].deduction!=""||rows[i].statutorydeduction!=" "||rows[i].statutorydeduction!=""||rows[i].revadd!=" "||rows[i].revadd!=""||rows[i].revded!=" "||rows[i].revded!=""||rows[i].revstatded!=" "||rows[i].revstatded!="")?0:rows[i].addition)+" :: "+rows[i].deduction+" :: "+rows[i].statutorydeduction+" :: "+rows[i].remarks+" :: "+rows[i].refdtype+" :: "+rows[i].revadd+" :: "+rows[i].revded+" :: "+rows[i].revstatded+" :: ");
               newTextBox.appendTo('form');
           }   
           $('#joindate').jqxDateTimeInput({ disabled: false});
           return 1;
      } 

    function funChkButton() {}

    function funSearchLoad(){
         changeContent('masterSearch.jsp'); 
    }
        
    function funFocus(){
        $('#masterdate').jqxDateTimeInput('focus');     
    }
     
    function getYear() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function () {
            if (x.readyState === 4 && x.status === 200) {
                var items = x.responseText.trim().split('####');
                if (items.length < 2) return;

                var yearItems = items[0].split(",");
                var yearIdItems = items[1].split(",");

                var optionsyear = '<option value="">--Select--</option>';
                for (var i = 0; i < yearItems.length; i++) {
                    optionsyear += '<option value="' + yearIdItems[i] + '">' +
                                    yearItems[i] + '</option>';
                }

                $('#cmbyear').html(optionsyear);

                var hidVal = $('#hidcmbyear').val();
                if (hidVal) {
                    $('#cmbyear').val(hidVal);
                }
            }
        };
        x.open("GET", "getYear.jsp", true);
        x.send();
    }

    function setValues() {
          if(document.getElementById("hidchange").value==1) {
              document.getElementById("change").checked = true;
              document.getElementById("change").value = 1;
              editstatus();        
              if($('#hidcmbdept').val()=="1") {
                 $('#cmbdept').val($('#hidcmbdept').val());
              } else if($('#hidcmbdept').val()=="0") {
                   $('#hidcmbdept').val('');
              }
               
              if($('#hidcmbdesignation').val()=="1") {
                 $('#cmbdesignation').val($('#hidcmbdesignation').val());
              } else if($('#hidcmbdesignation').val()=="0") {
                   $('#hidcmbdesignation').val(''); 
              }
               
              if($('#hidcmbcategory').val()=="1") {
                 $('#cmbcategory').val($('#hidcmbcategory').val());
              } else if($('#hidcmbcategory').val()=="0") {
                   $('#hidcmbcategory').val("");
              }
         } else {
               $('#hidcmbcategory').val("");
               $('#hidcmbdesignation').val(''); 
               $('#hidcmbdept').val('');
         }
          
         if($('#hidcmbyear').val()!="") {
               $('#cmbyear').val($('#hidcmbyear').val());
         } else {
               $('#cmbyear').val('');
         }
          
         if($('#hidcmbmonth').val()!="") {
                $('#cmbmonth').val($('#hidcmbmonth').val());
         } else {
                $('#cmbmonth').val('');
         }
        
         var docVal1 = document.getElementById("docno").value;
        if(docVal1>0) {
             $("#comdiv").load("compensationGrid.jsp?docno="+docVal1+"&check="+1);
        }
           
       if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
       }
       
       if($('#hidmasterdate').val()!="") {
          $('#masterdate').val($('#hidmasterdate').val());
       }
      
       if($('#hidleastpaydate').val()!="") {
          $('#leastpaydate').val($('#hidleastpaydate').val());
       }
      
       if($('#hidjoindate').val()!="") {
          $('#joindate').val($('#hidjoindate').val());
       }
      
       if($('#hidprevappdate').val()!="") {
          $('#prevappdate').val($('#hidprevappdate').val());
       }
 
       document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
    }

    function clearmsg() {  
        document.getElementById("errormsg").innerText="";
    }

    function editstatus(){                 
        var date=$('#masterdate').jqxDateTimeInput('val');
        var empdocno=$('#empdocno').val();
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.trim();  
                
                if(parseInt(items)>0) {
                     $("#btnEdit").attr('disabled', false );
                }
                else {   
                    $("#btnEdit").attr('disabled', true );   
                }
            }
        }
        x.open("GET", "getEditStat.jsp?masterdoc="+empdocno+"&date="+date, true);      
        x.send();
    }
</script>

</head>
<body onload="setValues();getDepartment();getDesignation();getPayrollCategory();" onmouseover="editstatus();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmappraisal" action="saveAppraisal" autocomplete="OFF">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="modern-ui hidden-scrollbar">
        <span id="errormsg"></span>

        <div class="middle-panel">
            <span class="middle-panel-title">Appraisal Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Date</label>
                <div style="width: 120px;">
                    <div id="masterdate" name="masterdate" value='<s:property value="masterdate"/>'></div>
                    <input type="hidden" id="hidmasterdate" name="hidmasterdate" value='<s:property value="hidmasterdate"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px;">Year</label>
                <select id="cmbyear" name="cmbyear" value='<s:property value="cmbyear"/>' onchange="clearmsg();" style="width:120px;">
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>' />

                <label class="lbl-right" style="width:80px;">Month</label>
                <select id="cmbmonth" name="cmbmonth" value='<s:property value="cmbmonth"/>' onchange="clearmsg();" style="width:120px;">
                    <option value="">--Select--</option>
                    <option value="1">January</option>
                    <option value="2">February</option>
                    <option value="3">March</option>
                    <option value="4">April</option>
                    <option value="5">May</option>
                    <option value="6">June</option>
                    <option value="7">July</option>
                    <option value="8">August</option>
                    <option value="9">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>
                <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>' />
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Last Payroll</label>
                <div style="width: 120px;">
                    <div id="leastpaydate" name="leastpaydate" value='<s:property value="leastpaydate"/>'></div>
                    <input type="hidden" id="hidleastpaydate" name="hidleastpaydate" value='<s:property value="hidleastpaydate"/>' />
                </div>

                <label class="lbl-right" style="width:80px;">Doc No</label>
                <input type="text" id="docno" name="docno" tabindex="-1" value='<s:property value="docno"/>' style="width:120px;" readonly />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Employee Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Employee ID</label>
                <div class="input-search-container" style="width:120px;">
                    <input type="text" id="empid" name="empid" placeholder="Press F3" onkeydown="getEmployee(event);" value='<s:property value="empid"/>' />
                    <svg class="magnifier-icon" onclick="empSearchContent('employeeDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="hidden" id="empdocno" name="empdocno" value='<s:property value="empdocno"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px;">Name</label>
                <input type="text" id="empname" name="empname" value='<s:property value="empname"/>' style="flex:1;" />
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Date of Join</label>
                <div style="width: 120px;">
                    <div id="joindate" name="joindate" value='<s:property value="joindate"/>'></div>
                    <input type="hidden" id="hidjoindate" name="hidjoindate" value='<s:property value="hidjoindate"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px;">Prev. Appraisal</label>
                <div style="width: 120px;">
                    <div id="prevappdate" name="prevappdate" value='<s:property value="prevappdate"/>'></div>
                    <input type="hidden" id="hidprevappdate" name="hidprevappdate" value='<s:property value="hidprevappdate"/>' />
                </div>
            </div>

            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Department</label>
                <input type="text" id="deprtment" name="deprtment" value='<s:property value="deprtment"/>' style="width:120px;" readonly />
                <input type="hidden" id="hiddeprtment" name="hiddeprtment" value='<s:property value="hiddeprtment"/>' />
                
                <label class="lbl-right" style="width:80px;">Designation</label>
                <input type="text" id="designation" name="designation" value='<s:property value="designation"/>' style="width:120px;" readonly />
                <input type="hidden" id="hiddesignation" name="hiddesignation" value='<s:property value="hiddesignation"/>' />
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Payroll Category</label>
                <input type="text" id="category" name="category" value='<s:property value="category"/>' style="width:120px;" readonly />
                <input type="hidden" id="hidcategory" name="hidcategory" value='<s:property value="hidcategory"/>' />
            </div>
        </div>

        <div class="middle-panel">
            <label class="middle-panel-title chk-title">
                <input type="checkbox" id="change" name="change" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" onchange="checkchange();" />
                Changes in Employee Details
            </label>
            
            <div class="field-row">
                <label class="lbl-right" style="width:100px;">Department</label>
                <select id="cmbdept" name="cmbdept" style="width:120px;" disabled>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbdept" name="hidcmbdept" value='<s:property value="hidcmbdept"/>' />
                
                <label class="lbl-right" style="width:80px;">Designation</label>
                <select id="cmbdesignation" name="cmbdesignation" style="width:120px;" disabled>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbdesignation" name="hidcmbdesignation" value='<s:property value="hidcmbdesignation"/>' />
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:100px;">Payroll Category</label>
                <select id="cmbcategory" name="cmbcategory" style="width:120px;" disabled>
                    <option value="">--Select--</option>
                </select>
                <input type="hidden" id="hidcmbcategory" name="hidcmbcategory" value='<s:property value="hidcmbcategory"/>' />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Description</span>
            <div class="field-row" style="margin-bottom:0;">
                <input type="text" id="desc" name="desc" value='<s:property value="desc"/>' style="flex:1;" />
            </div>
        </div>

        <div class="middle-panel" style="padding-top:25px;">
            <span class="middle-panel-title">Monthly Salary</span>
            <div id="comdiv" class="grid-container">
                <jsp:include page="compensationGrid.jsp"></jsp:include>
            </div>
        </div>

        <input type="hidden" id="compensationGridlength" name="compensationGridlength" value='<s:property value="compensationGridlength"/>' />
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>' />
        <input type="hidden" id="hidchange" name="hidchange" value='<s:property value="change"/>' />

    </div></form>

<div id="empsearchwndow"><div></div></div>

</div></body>
</html>