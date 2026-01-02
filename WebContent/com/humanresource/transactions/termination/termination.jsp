<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		
		 $("#terminationDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#notifyDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#joiningDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value:null});
		 $("#appraisalDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy", value:null});
		
		 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employees Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#employeeDetailsWindow').jqxWindow('close');
 		 
 		 $('#txtemployeeid').dblclick(function(){
 			employeeSearchContent("employeeDetailsSearch.jsp");
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
	
  function getLastTerminalBenefitsDone(date,type){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				 items = items.split('***');
			     $('#txtchkgridload').val(items[0]);
			     $('#txtchkdate').val(items[1]);
			     $('#txtchksalarypaid').val(items[3]);
			   
			     document.getElementById("errormsg").innerText="Terminal Benefits done till "+items[2]+".";
			     
			   if(parseInt($('#txtchkdate').val())==0){
				  if(parseInt($('#txtchkgridload').val())==1){
					if(parseInt($('#txtchksalarypaid').val())==0){  
					    $("#overlay, #PleaseWait").show();
					    $("#terminationDiv").load("terminationGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val()+"&type="+type);
					    $('#txtchkgridload').val('');
					    $('#txtgridload').val(1);
					} else {
						$.messager.alert('Message','Payroll Processing Pending.','warning');
						$("#terminationGridID").jqxGrid('clear'); 
			            $("#terminationGridID").jqxGrid('addrow', null, {});
			            $("#terminationAccountsGridID").jqxGrid('clear');
			            $("#terminationGridID").jqxGrid({ disabled: true});
						$("#terminationAccountsGridID").jqxGrid({ disabled: true});
						return;
					}
				  } else if(parseInt($('#txtchkgridload').val())==0) {
						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
						$("#terminationGridID").jqxGrid('clear'); 
			            $("#terminationGridID").jqxGrid('addrow', null, {});
			            $("#terminationAccountsGridID").jqxGrid('clear');
			            $("#terminationGridID").jqxGrid({ disabled: true});
						$("#terminationAccountsGridID").jqxGrid({ disabled: true});
						return;
				 } else if(parseInt($('#txtchkgridload').val())==2) {
						if(parseInt($('#txtchksalarypaid').val())==0){  
							$('#notifyDate').val(items[4]);
						    $("#overlay, #PleaseWait").show();
						    $("#terminationDiv").load("terminationGrid.jsp?check=1&deprdate="+$('#notifyDate').val()+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val());
						    $('#txtchkgridload').val('');
						    $('#txtgridload').val(1);
						} else {
							$.messager.alert('Message','Payroll Processing Pending.','warning');
							$("#terminationGridID").jqxGrid('clear'); 
				            $("#terminationGridID").jqxGrid('addrow', null, {});
				            $("#terminationAccountsGridID").jqxGrid('clear');
				            $("#terminationGridID").jqxGrid({ disabled: true});
							$("#terminationAccountsGridID").jqxGrid({ disabled: true});
							return;
						}
					}
			  }else {
						$("#terminationGridID").jqxGrid('clear'); 
			            $("#terminationGridID").jqxGrid('addrow', null, {});
			            $("#terminationAccountsGridID").jqxGrid('clear');
						$("#terminationGridID").jqxGrid({ disabled: true});
						$("#terminationAccountsGridID").jqxGrid({ disabled: true});
					}
			}
		}
		x.open("GET", "getLastTerminalBenefitsDone.jsp?date="+date+"&branch="+document.getElementById("brchName").value+"&empid="+$('#txtemployeedocno').val(), true);
		x.send();
	}
  
	  function funProcessBtn(){
		  if($('#txtemployeedocno').val()==''){
			  $.messager.alert('Message','Employee is Mandatory.','warning');
			  return;
		  }
		  
	      var paydate = $('#notifyDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var type=$('#cmbtype').val();
		  var date = $('#notifyDate').val();
		  getLastTerminalBenefitsDone(date,type);
	  }
	  
	  function funCalculateBtn(){

		  if($('#txtemployeedocno').val()==''){
			  $.messager.alert('Message','Employee is Mandatory.','warning');
			  return;
		  }
		  
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var rows = $("#terminationGridID").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
				 $("#overlay, #PleaseWait").show();
			     $("#accountDiv").load("accountsDetailsGrid.jsp?check=2&empid="+$('#txtemployeedocno').val());
			  }
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
	  }

     function funReadOnly(){
			$('#frmTermination input').attr('readonly', true );
			$('#cmbtype').attr('disabled', true );
			$('#terminationDate').jqxDateTimeInput({disabled: true});
			$('#notifyDate').jqxDateTimeInput({disabled: true});
			$('#joiningDate').jqxDateTimeInput({disabled: true});
			$('#appraisalDate').jqxDateTimeInput({disabled: true});
			$("#terminationGridID").jqxGrid({ disabled: true});
			$("#terminationAccountsGridID").jqxGrid({ disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();
	 }
	 
	 function funRemoveReadOnly(){
			$('#frmTermination input').attr('readonly', false );
			$('#cmbtype').attr('disabled', false );
			$('#terminationDate').jqxDateTimeInput({disabled: false});
			$('#notifyDate').jqxDateTimeInput({disabled: false});
			$('#joiningDate').jqxDateTimeInput({disabled: true});
			$('#appraisalDate').jqxDateTimeInput({disabled: true});
			$("#terminationGridID").jqxGrid({ disabled: true});
			$("#terminationAccountsGridID").jqxGrid({ disabled: true});
			$('#btnProcessing').show();$('#btnCalculate').show();
			
			$('#docno').attr('readonly', true);
			$('#txtemployeeid').attr('readonly', true);
			$('#txtemployeename').attr('readonly', true);
			$('#txtemployeedepartment').attr('readonly', true);
			$('#txtemployeedesignation').attr('readonly', true);
			$('#txtemployeecategory').attr('readonly', true);
			$('#txtdrtotal').attr('readonly', true);
			$('#txtcrtotal').attr('readonly', true);
			
			if ($("#mode").val() == "E") {
   			    $("#terminationGridID").jqxGrid('addrow', null, {});
			  }
			
			if ($("#mode").val() == "A") {
				$('#terminationDate').val(new Date());
				$('#notifyDate').val(new Date());
				$('#joiningDate').val(null);
				$('#appraisalDate').val(null);
				$("#terminationGridID").jqxGrid('clear'); 
				$("#terminationGridID").jqxGrid('addrow', null, {});
				$("#terminationAccountsGridID").jqxGrid('clear'); 
			}
			
	 }
	 
	 function funSearchLoad(){
		changeContent('htreMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#terminationDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	    $(function(){
	        $('#frmTermination').validate({
	                rules: {
	                	txtemployeeid:"required"
	                 },
	                 messages: {
	                	 txtemployeeid:" *"
	                 }
	        });}); 
	   
	  function funNotify(){	
		  
		        /* Validation */
	    	      document.getElementById("errormsg").innerText="";
	    		
	    	    /* Validation Ends*/
	    		
	     		/* Termination Grid  Saving*/
				 	var rows = $("#terminationGridID").jqxGrid('getrows');
				 	var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].terminations;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    	newTextBox.val(rows[i].terminations+":: "+rows[i].gratuity+":: "+rows[i].leavesalary+":: "+rows[i].travel);
						newTextBox.appendTo('form');
					 	}
					  }
		 			 $('#gridlength').val(length); 
	 	 		/* Termination Grid  Saving Ends*/	
	 	 
	 			/* Account Details Grid Saving */
		    	 var accountsrows = $("#terminationAccountsGridID").jqxGrid('getrows');
		    	 var journalslength=0;
				 for(var j=0 ; j < accountsrows.length ; j++){
					var chked=accountsrows[j].acno;
					if(typeof(chked) != "undefined" && typeof(chked) != "NaN" && chked != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journals"+journalslength)
					    .attr("name", "journals"+journalslength)
					    .attr("hidden", "true");
						journalslength=journalslength+1;
					
					newTextBox.val(accountsrows[j].acno+":: "+accountsrows[j].debit+":: "+accountsrows[j].credit);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalsgridlength').val(journalslength);
		 		/* Account Details Grid Saving Ends */
			 		
		 		/* Account Details Grid Saving */
		    	 var accountrows = $("#terminationAccountsGridID").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var k=0 ; k < accountrows.length ; k++){
					var chks=accountrows[k].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
						
					var amount=0,id=1;
					if((accountrows[k].credit!=null) && (accountrows[k].credit!='undefined') &&  (accountrows[k].credit!='NaN') && (accountrows[k].credit!="") && (accountrows[k].credit!=0)){
						 amount=accountrows[k].credit*-1;
						 id=-1;
					}
					
					if((accountrows[k].debit!=null) && (accountrows[k].debit!='undefined') && (accountrows[k].debit!='NaN') && (accountrows[k].debit!="") && (accountrows[k].debit!=0)){
						 amount=accountrows[k].debit;
						 id=1;
					}
					
					newTextBox.val(accountrows[k].acno+":: "+amount+":: "+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		
		 		$('#joiningDate').jqxDateTimeInput({disabled: false});
			    $('#appraisalDate').jqxDateTimeInput({disabled: false});
			
	     return 1;
		} 
	  
	  
	  function setValues(){
		  if($('#hidcmbtype').val()!=""){
			  $('#cmbtype').val($('#hidcmbtype').val());
		  }
		  
		  if($('#hidterminationDate').val()){
				 $("#terminationDate").jqxDateTimeInput('val', $('#hidterminationDate').val());
			  }
		  
		  if($('#hidnotifyDate').val()){
				 $("#notifyDate").jqxDateTimeInput('val', $('#hidnotifyDate').val());
			  }
		  
		  if($('#hidjoiningDate').val()){
				 $("#joiningDate").jqxDateTimeInput('val', $('#hidjoiningDate').val());
			  }
		  
		  if($('#hidappraisalDate').val()){
				 $("#appraisalDate").jqxDateTimeInput('val', $('#hidappraisalDate').val());
			  }

		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				$("#terminationDiv").load("terminationGrid.jsp?docno="+indexVal+"&trno="+$('#txttrno').val()+"&empid="+$('#txtemployeedocno').val());
	         	$("#accountDiv").load("accountsDetailsGrid.jsp?docno="+indexVal+"&trno="+$('#txttrno').val()+"&empid="+$('#txtemployeedocno').val());
		  }
	         
		}
	   
	  function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("transactions");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"transactions/termination/printTermination?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"transactions/termination/printTermination?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
</script>

<style>
/* ===============================
   SCROLL AREA
=============================== */
.hidden-scrollbar {
    overflow-y: auto;
    height: 530px;
    padding: 10px;
}

/* ===============================
   PAGE BACKGROUND
=============================== */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
}

/* ===============================
   MAIN CARD
=============================== */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ===============================
   HEADER STRIP
=============================== */
.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;
    padding: 0 24px;
}

.receipt-header label {
    font-weight: 500;
    color: #333;
}

/* ===============================
   INPUTS (GLOBAL FIX)
=============================== */
input[type="text"],
input[type="number"],
input[type="file"],
select {
    height: 32px !important;
    padding: 4px 10px !important;
    font-size: 14px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    background: #fff;
    box-sizing: border-box;
}

input:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

/* ===============================
   BUTTONS
=============================== */
button,
.myButton {
    height: 32px;
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 0 16px;
    font-weight: 500;
    cursor: pointer;
}

button:hover,
.myButton:hover {
    background: #0056b3;
}

/* ===============================
   SECTION BLOCKS
=============================== */
.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}

.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2,
.section-block h3 {
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 15px;
    font-weight: 600;
}

/* ===============================
   FORM ROWS
=============================== */
.form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

label {
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
}

/* ===============================
   TABLE SECTION
=============================== */
.table-section {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 12px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

/* ===============================
   TABLE GRID
=============================== */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th,
.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 13px;
    vertical-align: middle;
    white-space: nowrap;
    font-weight: 500;
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ===============================
   DATE PICKER HEIGHT FIX
=============================== */
#deductionScheduleDate,
#masterdate,
#startDate,
.jqx-datetimeinput,
.jqx-input,
.jqx-datetimeinput input {
    height: 32px !important;
    min-height: 32px !important;
    font-size: 14px !important;
}
.table-section h3 {
    margin: 0 0 16px;
    padding-left: 8px;
    border-left: 3px solid #007bff;
    font-size: 15px;
    font-weight: 600;
    color: #253858;
}

</style>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmTermination"
      action="saveTermination"
      method="post"
      autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <!-- ===============================
         SCROLLABLE CONTENT
    ================================ -->
    <div class="hidden-scrollbar">

        <!-- ===============================
             HEADER DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Termination</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Date</td>
                    <td>
                        <div id="terminationDate"
                             name="terminationDate"
                             value='<s:property value="terminationDate"/>'></div>
                        <input type="hidden"
                               id="hidterminationDate"
                               name="hidterminationDate"
                               value='<s:property value="hidterminationDate"/>' />
                    </td>

                    <td align="right">Doc No.</td>
                    <td>
                        <input type="text"
                               id="docno"
                               name="txtterminationdocno"
                               tabindex="-1"
                               value='<s:property value="txtterminationdocno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             EMPLOYEE DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Employee Details</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Employee ID</td>
                    <td>
                        <input type="text"
                               id="txtemployeeid"
                               name="txtemployeeid"
                               placeholder="Press F3 to Search"
                               onkeydown="getEmployeeDetails(event);"
                               value='<s:property value="txtemployeeid"/>' />
                        <input type="hidden"
                               id="txtemployeedocno"
                               name="txtemployeedocno"
                               value='<s:property value="txtemployeedocno"/>' />
                    </td>

                    <td align="right">Name</td>
                    <td>
                        <input type="text"
                               id="txtemployeename"
                               name="txtemployeename"
                               tabindex="-1"
                               value='<s:property value="txtemployeename"/>' />
                    </td>

                    <td align="right">Designation</td>
                    <td>
                        <input type="text"
                               id="txtemployeedesignation"
                               name="txtemployeedesignation"
                               tabindex="-1"
                               value='<s:property value="txtemployeedesignation"/>' />
                    </td>

                    <td align="right">Department</td>
                    <td>
                        <input type="text"
                               id="txtemployeedepartment"
                               name="txtemployeedepartment"
                               tabindex="-1"
                               value='<s:property value="txtemployeedepartment"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Category</td>
                    <td>
                        <input type="text"
                               id="txtemployeecategory"
                               name="txtemployeecategory"
                               tabindex="-1"
                               value='<s:property value="txtemployeecategory"/>' />
                    </td>

                    <td align="right">Notify Date</td>
                    <td>
                        <div id="notifyDate"
                             name="notifyDate"
                             value='<s:property value="notifyDate"/>'></div>
                        <input type="hidden"
                               id="hidnotifyDate"
                               name="hidnotifyDate"
                               value='<s:property value="hidnotifyDate"/>' />
                    </td>

                    <td align="center">
                        <button type="button"
                                id="btnProcessing"
                                title="Process"
                                onclick="funProcessBtn();"
                                style="background:none;border:none;">
                            <img src="<%=contextPath%>/icons/process2.png"
                                 alt="Process"
                                 width="16" height="16">
                        </button>
                    </td>

                    <td align="center">
                        <button type="button"
                                id="btnCalculate"
                                title="Calculate"
                                onclick="funCalculateBtn();"
                                style="background:none;border:none;">
                            <img src="<%=contextPath%>/icons/calculate_new.png"
                                 alt="Calculate">
                        </button>
                    </td>

                    <td align="right">Type</td>
                    <td>
                        <select id="cmbtype" name="cmbtype">
                            <option value="TER">Termination</option>
                            <option value="RES">Resignation</option>
                        </select>
                        <input type="hidden"
                               id="hidcmbtype"
                               name="hidcmbtype"
                               value='<s:property value="hidcmbtype"/>' />
                    </td>
                </tr>

                <tr>
                    <td align="right">Date of Join</td>
                    <td>
                        <div id="joiningDate"
                             name="joiningDate"
                             value='<s:property value="joiningDate"/>'></div>
                        <input type="hidden"
                               id="hidjoiningDate"
                               name="hidjoiningDate"
                               value='<s:property value="hidjoiningDate"/>' />
                    </td>

                    <td align="right">Appraisal Date</td>
                    <td>
                        <div id="appraisalDate"
                             name="appraisalDate"
                             value='<s:property value="appraisalDate"/>'></div>
                        <input type="hidden"
                               id="hidappraisalDate"
                               name="hidappraisalDate"
                               value='<s:property value="hidappraisalDate"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             TERMINATION GRID
        ================================ -->
        <div class="table-section">
            <h3>Termination Details</h3>
            <div class="cr-table" id="terminationDiv">
                <jsp:include page="terminationGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             ACCOUNT DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Account Details</h3>
            <div class="cr-table" id="accountDiv">
                <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             TOTALS
        ================================ -->
        <div class="table-section">
            <table class="cr-table">
                <tr>
                    <td align="right">Dr. Total</td>
                    <td>
                        <input type="text"
                               id="txtdrtotal"
                               name="txtdrtotal"
                               tabindex="-1"
                               style="text-align:right"
                               value='<s:property value="txtdrtotal"/>' />
                    </td>

                    <td align="right">Cr. Total</td>
                    <td>
                        <input type="text"
                               id="txtcrtotal"
                               name="txtcrtotal"
                               tabindex="-1"
                               style="text-align:right"
                               value='<s:property value="txtcrtotal"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             HIDDEN FIELDS
        ================================ -->
        <input type="hidden" id="mode" name="mode" />
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>' />
        <input type="hidden" id="gridlength" name="gridlength" />
        <input type="hidden" id="journalgridlength" name="journalgridlength" />
        <input type="hidden" id="journalsgridlength" name="journalsgridlength" />
        <input type="hidden" id="txttrno" name="txttrno"
               value='<s:property value="txttrno"/>' />
        <input type="hidden" id="txtgridload" name="txtgridload"
               value='<s:property value="txtgridload"/>' />
        <input type="hidden" id="txtchkgridload" name="txtchkgridload"
               value='<s:property value="txtchkgridload"/>' />
        <input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid"
               value='<s:property value="txtchksalarypaid"/>' />
        <input type="hidden" id="txtchkdate" name="txtchkdate"
               value='<s:property value="txtchkdate"/>' />

    </div><!-- /.hidden-scrollbar -->

</form>

<div id="employeeDetailsWindow"><div></div></div>

</div><!-- /#mainBG -->

</body>

</html>
