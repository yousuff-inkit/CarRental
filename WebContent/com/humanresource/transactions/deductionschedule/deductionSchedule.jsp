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
<script type="text/javascript" src="../../../../js/ajaxfileupload.js"></script> 

<style>
/* =========================================================
   SCOPED UI: Modern Layout (Matches Cash Receipts)
   STRICT 24PX INPUTS / FLEXBOX SIDE-BY-SIDE
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

/* Layout Utilities (Side-by-side flex rows) */
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

/* Checkbox specific fix */
.modern-ui input[type="checkbox"] {
    margin: 0;
    cursor: pointer;
}
</style>

<script type="text/javascript">
      $(document).ready(function () {
          /* EXACT Cash Receipts JQX Widget Sizing (24px) */
          var dateWidgetSettings = { width: '100%', height: 24, formatString:"dd.MM.yyyy"};
          
          /* Date */
          $("#deductionScheduleDate").jqxDateTimeInput(dateWidgetSettings);
          $("#startDate").jqxDateTimeInput(dateWidgetSettings);
          
          // Force internal inline style adjustments for JQX to fit the 24px height perfectly
          setTimeout(function () {
              $(".jqx-datetimeinput").css({"margin": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
              $(".jqx-datetimeinput").find("input").css({
                  "margin-top": "0px", "line-height": "24px", "font-size": "12px", "font-weight": "normal",
                  "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
              });
              $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
          }, 100);

          /* Searching Window */
         $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
         $('#employeeDetailsWindow').jqxWindow('close');
        
         $('#txtemployeedetails').dblclick(function(){
            employeeSearchContent("employeeDetailsSearch.jsp");
          });
        
         $('#allowinstamt').change(function() {
             if (!$(this).prop('checked')) {
                 $('#txtinstcustomamt').val(''); // Clear the text field
             }
         });
        
      }); 
      
      function employeeSearchContent(url) {
            $('#employeeDetailsWindow').jqxWindow('open');
            $.get(url).done(function (data) {
            $('#employeeDetailsWindow').jqxWindow('setContent', data);
            $('#employeeDetailsWindow').jqxWindow('bringToFront');
        }); 
        }
      
      function getEmployeeDetails(event){
          var x= event.keyCode;
          if(x==114){
              employeeSearchContent("employeeDetailsSearch.jsp");
          }
          else{}
          }
      
      function funInstAmount(){
          
          var amount=$('#txtamount').val();
         var instantcustomamount=$('#txtinstcustomamt').val();
         var instno=$('#txtinstnos').val();
        if(amount==""){ 
            document.getElementById("errormsg").innerText="Amount is Mandatory.";
             return 0;  
        }
        
        if(instno=="0"){ 
            document.getElementById("errormsg").innerText="Installment number is Invalid.";
             return 0;  
        }
        document.getElementById("errormsg").innerText="";
        
        if($('#allowinstamt').is(":checked")){
            if(instantcustomamount==""){ 
                document.getElementById("errormsg").innerText="Installment Amount is Mandatory.";
                 return 0;  
            }
            if(!isNaN(amount)){
                var result = Math.ceil(amount / instantcustomamount);
                 $('#txtinstnos').val(result);
                 }
            else if(isNaN(amount)){
                $('#txtinstnos').val(0.0);
            }
        } else {
            if(instno==""){ 
                document.getElementById("errormsg").innerText="Installment number is Mandatory.";
                 return 0;  
         }
            
             if(!isNaN(amount)){
                 var result = amount / instno;
                 $('#txtinstamt').val(result);
                 }
                 else if(isNaN(amount)){
                     $('#txtinstamt').val(0.0);
                 }
        }
     }
      
      function deductionGridLoading(){
          var startdate = $('#startDate').jqxDateTimeInput('getText');
          var chngdate=startdate;
          var saldate = document.getElementById("hidsaldate").value;
          var amount = document.getElementById("txtamount").value;
          var instno = document.getElementById("txtinstnos").value;
          var instamt = $('#allowinstamt').is(":checked")?$('#txtinstcustomamt').val():document.getElementById("txtinstamt").value;
           var fromdate = chngdate.split('.');
        chngdate = new Date();
       // chngdate.setFullYear(fromdate[2],fromdate[1]-1,fromdate[0]);
        var caldateyear=fromdate[2];
        var caldatemonth=fromdate[1];
        var caldateday=fromdate[0];
        var todate = saldate.split('.');
        saldate = new Date();
        //saldate.setFullYear(todate[2],todate[1]-1,todate[0]);
        var caltodateyear=todate[2];
        var caltodatemonth=todate[1];
        var caltodateday=todate[0];
        
        if(caldateyear==caltodateyear && caldatemonth==caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear<caltodateyear && caldatemonth==caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear==caltodateyear && caldatemonth<caltodatemonth && caldateday==caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
        else if(caldateyear==caltodateyear && caldatemonth==caltodatemonth && caldateday<caltodateday){
            $.messager.alert('Warning','Salary Processed,Please Choose Another Date ');
             return false;
        }
          $("#deductionScheduleDiv").load('deductionScheduleGrid.jsp?startdate='+startdate+'&amount='+amount+'&instno='+instno+'&instamt='+instamt);
      }
      
      $(function(){
            $('#frmDeductionSchedule').validate({
                    rules: {
                        txtemployeedetails:"required",
                     },
                     messages: {
                         txtemployeedetails:" *",
                     }
            });});
    
     function funReadOnly(){
            $('#txtinstcustomamt').attr('disabled',true);
            $('#frmDeductionSchedule input').attr('readonly', true );
            $('#frmDeductionSchedule select').attr('disabled', true);
            $('#deductionScheduleDate').jqxDateTimeInput({disabled: true});
            $('#startDate').jqxDateTimeInput({disabled: true});
            $('#btnDistributionSubmit').attr('disabled', true);
            
            $("#deductionScheduleGridID").jqxGrid({ disabled: true});
     }
    
     function funRemoveReadOnly(){
            $('#frmDeductionSchedule input').attr('readonly', false );
            $('#frmDeductionSchedule select').attr('disabled', false);
            $('#deductionScheduleDate').jqxDateTimeInput({disabled: false});
            $('#startDate').jqxDateTimeInput({disabled: false});
            $('#txtemployeedetails').attr('readonly', true );
            $('#docno').attr('readonly', true);
            $('#btnDistributionSubmit').attr('disabled', false);
            
            $("#deductionScheduleGridID").jqxGrid({ disabled: false});
            
            if ($("#mode").val() == "A") {
                     $('#deductionScheduleDate').val(new Date());
                    
                     $("#deductionScheduleGridID").jqxGrid('clear'); 
                     $("#deductionScheduleGridID").jqxGrid('addrow', null, {});
            }
            disableEdit();
     }
    
     function disableEdit(){
            var rows = $("#deductionScheduleGridID").jqxGrid('getrows');
            var isDisable=false;  
                for (var i = 0; i < rows.length; i++) {
                    if (rows[i].posted == 1) {
                        isDisable=true;
                    }
                }
                if(isDisable){
                    $('#txtinstcustomamt').attr('disabled',true);
                    $('#frmDeductionSchedule input').attr('readonly', true );
                    $('#frmDeductionSchedule select').attr('disabled', true);
                    $('#deductionScheduleDate').jqxDateTimeInput({disabled: true});
                    $('#startDate').jqxDateTimeInput({disabled: true});
                    $('#btnDistributionSubmit').attr('disabled', true);
                    $("#allowinstamt").attr("disabled", true);
                }
    }
    
     function funNotify(){  
         /* Validation */
        if($('#txtvalidation').val()==1) return;
                
         /* Validation Ends*/
        
         $('#startDate').jqxDateTimeInput({disabled: false});  
         $('#deductionScheduleDate').jqxDateTimeInput({disabled: false});  
        
         /* Deduction Schedule Grid  Saving*/
          var rows = $("#deductionScheduleGridID").jqxGrid('getrows');
          var length=0;
             for(var i=0 ; i < rows.length ; i++){
                var chk=rows[i].amount;
                if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
                    length=length+1;
                        newTextBox = $(document.createElement("input"))
                        .attr("type", "dil")
                        .attr("id", "test"+i)
                        .attr("name", "test"+i)
                        .attr("hidden", "true");
                    
                    newTextBox.val(rows[i].sr_no+"::"+rows[i].date+"::"+rows[i].amount+"::"+rows[i].posted+"::"+rows[i].rowno+"::"+rows[i].postedtrno);
                    newTextBox.appendTo('form');
                    }
                }
                 $('#gridlength').val(length);
                /*Deduction Schedule Grid  Saving Ends*/  
        
            return 1;       
        } 
    
     function funSearchLoad(){
             changeContent('dscMainSearch.jsp'); 
         }
    
     function funFocus(){
        $('#deductionScheduleDate').jqxDateTimeInput('focus');          
    }
    
     function setValues(){
             if($('#hiddeductionScheduleDate').val()){
                 $("#deductionScheduleDate").jqxDateTimeInput('val', $('#hiddeductionScheduleDate').val());
              }
              
             if($('#hidstartDate').val()){
                 $("#startDate").jqxDateTimeInput('val', $('#hidstartDate').val());
              }
              
             if($('#msg').val()!=""){
                   $.messager.alert('Message',$('#msg').val());
                  }
              
             document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
             funSetlabel();
            
             var indexVal = document.getElementById("docno").value;
             if(indexVal>0){
                 $("#deductionScheduleDiv").load("deductionScheduleGrid.jsp?docno="+indexVal);
             }
        }
    
     function funChkButton() {
            /* funReset(); */
        }
        
    function funPrintBtn() {
            if (($("#mode").val() == "view") && $("#docno").val()!="") {
                 var url=document.URL;
                 reurl=url.split("transactions");
                 $("#docno").prop("disabled", false);   
                 var win= window.open(reurl[0]+"transactions/deductionschedule/printDeduction?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
                 win.focus();   
             }
            else {
                $.messager.alert('Message','Select a Document....!','warning');
                return;
            }
    }
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmDeductionSchedule" action="saveDeductionSchedule" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="modern-ui hidden-scrollbar">
        
        <span id="errormsg"></span>

        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 120px;">
                    <div id="deductionScheduleDate" name="deductionScheduleDate" value='<s:property value="deductionScheduleDate"/>'></div>
                    <input type="hidden" id="hiddeductionScheduleDate" name="hiddeductionScheduleDate" value='<s:property value="hiddeductionScheduleDate"/>' />
                </div>
                
                <label class="lbl-right" style="width:80px;">Ref. No.</label>
                <input type="text" id="txtemployeerefno" name="txtemployeerefno" placeholder="Ref. No." value='<s:property value="txtemployeerefno"/>' style="width:120px;" />
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No</label>
                <input type="text" id="docno" name="txtdeductionscheduledocno" tabindex="-1" value='<s:property value="txtdeductionscheduledocno"/>' style="width:120px;" readonly />
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Employee</span>
            
            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Employee</label>
                <div class="input-search-container" style="width:250px;">
                    <input type="text" id="txtemployeedetails" name="txtemployeedetails" placeholder="Press F3 to Search" onkeydown="getEmployeeDetails(event);" value='<s:property value="txtemployeedetails"/>' />
                    <svg class="magnifier-icon" onclick="employeeSearchContent('employeeDetailsSearch.jsp');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>' />
                </div>
            </div>
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Deduction Details</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Amount</label>
                <input type="text" id="txtamount" name="txtamount" placeholder="Amount" style="width:120px; text-align:right;" onblur="funRoundAmt(this.value,this.id);funInstAmount();" value='<s:property value="txtamount"/>' />
                
                <label class="lbl-right" style="width:80px;">Inst. Nos</label>
                <input type="text" id="txtinstnos" name="txtinstnos" placeholder="Inst. Nos" style="width:120px; text-align:right;" onblur="funInstAmount();" value='<s:property value="txtinstnos"/>' />
                
                <div style="display:flex; align-items:center; margin-left:20px; gap:6px;">
                    <input type="checkbox" id="allowinstamt" name="allowinstamt" onchange="this.checked ? $('#txtinstcustomamt').prop('disabled',false) : $('#txtinstcustomamt').prop('disabled',true);" />
                    <label class="lbl-right" style="padding-right:0;">Inst. Amount</label>
                </div>
                
                <input type="text" id="txtinstcustomamt" name="txtinstcustomamt" placeholder="Inst. Amount" style="width:120px; text-align:right;" disabled onblur="funRoundAmt(this.value,this.id);funInstAmount();" value='<s:property value="txtinstcustomamt"/>' />
                <input type="hidden" id="txtinstamt" name="txtinstamt" value='<s:property value="txtinstamt"/>' />
                <input type="hidden" id="txtinstamttotal" name="txtinstamttotal" value='<s:property value="txtinstamttotal"/>' />
            </div>

            <div class="field-row" style="margin-bottom:0;">
                <label class="lbl-right" style="width:80px;">Start Date</label>
                <div style="width: 120px;">
                    <div id="startDate" name="startDate" value='<s:property value="startDate"/>'></div>
                    <input type="hidden" id="hidstartDate" name="hidstartDate" value='<s:property value="hidstartDate"/>' />
                </div>

                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" placeholder="Description" value='<s:property value="txtdescription"/>' style="flex:1;" />
                
                <button type="button" class="myButton" id="btnDistributionSubmit" onclick="deductionGridLoading();" style="margin-left: 15px;">Submit</button>
            </div>
        </div>

        <div class="middle-panel" style="padding-top:25px;">
            <span class="middle-panel-title">Schedule</span>
            <div id="deductionScheduleDiv" class="grid-container">
                <jsp:include page="deductionScheduleGrid.jsp"></jsp:include>
            </div>
        </div>

        <input type="hidden" id="mode" name="mode" />
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>' />
        <input type="hidden" id="gridlength" name="gridlength" />
        <input type="hidden" id="hidsaldate" name="hidsaldate" />

    </div></form>

<div id="employeeDetailsWindow"><div></div></div>

</div></body>
</html>