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
		/*  $('#btnPrint').attr('disabled', true ); */$('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#terminationBenefitsPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	     var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	    
	});
	
	function getLeaveDaysConfig(){
		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText.trim();
  				document.getElementById("chkleavedayconfig").value=items;
  			} else {
  				}
  			}
  		x.open("GET", "leavedaysconfig.jsp", true);
  		x.send();
	}
	
	function getLastMonthDepreciation(date){
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
	  					    var employeebranchchk=window.parent.employeebranchchk.value;   
	  					    $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value+'&employeebranchchk='+employeebranchchk);
	  					    $('#txtchkgridload').val('');
	  					    $('#txtgridload').val(1);
	  					    $('#btnExcelExporter').show();
	  					} else {
	  						$.messager.alert('Message','Payroll Processing Pending.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Terminal Benefits Pending for Last-Month.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Terminal Benefits Already Done.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Terminal Benefits date should be Month-End.','warning');
							$("#terminationBenefitsDetails").jqxGrid('clear'); 
				            $("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				            $("#terminationBenefitsAccounts").jqxGrid('clear');
				            $("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
							$('#txtterminalbenefitstotal').val('');
							$('#txtleavesalarytotal').val('');
							$('#txttravelstotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  		}
  		}
  		x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("brchName").value, true);
  		x.send();
    }
	
	 function funReadOnly(){
			$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: true});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: true});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmTerminalBenefitsPosting input').attr('readonly', true );
			$("#terminationBenefitsDetails").jqxGrid({ disabled: false});
			$("#terminationBenefitsAccounts").jqxGrid({ disabled: false});
			$('#terminationBenefitsPostingDate').jqxDateTimeInput({disabled: false});
			getLeaveDaysConfig();
			
			if ($("#mode").val() == "A") {
				$('#terminationBenefitsPostingDate').val(new Date());
				var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				
				$("#terminationBenefitsDetails").jqxGrid('clear'); 
				$("#terminationBenefitsDetails").jqxGrid('addrow', null, {});
				$("#terminationBenefitsAccounts").jqxGrid('clear');
				$("#terminationBenefitsAccounts").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		 changeContent('tebMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#terminationBenefitsPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	var rows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
				var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         }
	    	    /* Validation Ends*/
	        	
	        	/* Terminal Benefits Details Grid  Saving*/
				 var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
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
							
				    newTextBox.val(rows[i].employeedocno+"::"+rows[i].salary+"::"+rows[i].terminalbenefitsyears+"::"+rows[i].terminalbenefitsdaystobeposted+"::"+rows[i].terminalbenefitscurrentprovision+"::"+rows[i].terminalbenefitsalreadyposted+"::"+rows[i].terminalbenefitstobeposted+"::"+rows[i].leavesalary+"::"+rows[i].leavesalarydaystobeposted+"::"+rows[i].leavesalarytotaldaysposted+"::"+rows[i].leavesalarycurrentprovision+"::"+rows[i].leavesalaryalreadyposted+"::"+rows[i].leavesalarytobeposted+"::"+rows[i].travelstotalperyear+"::"+rows[i].travelsdaystobeposted+"::"+rows[i].travelstotaldaysposted+"::"+rows[i].travelstotal+"::"+rows[i].travelsalreadyposted+"::"+rows[i].travelstobeposted);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Terminal Benefits Details Grid  Saving Ends*/	
	 		   
		 		/* Account Details Grid Saving */
		    	 var accountrows = $("#terminationBenefitsAccounts").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var j=0 ; j < accountrows.length ; j++){
					var chks=accountrows[j].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
						
					var amount=0,id=1;
					if((accountrows[j].credit!=null) && (accountrows[j].credit!='undefined') &&  (accountrows[j].credit!='NaN') && (accountrows[j].credit!="") && (accountrows[j].credit!=0)){
						 amount=accountrows[j].credit*-1;
						 id=-1;
					}
					
					if((accountrows[j].debit!=null) && (accountrows[j].debit!='undefined') && (accountrows[j].debit!='NaN') && (accountrows[j].debit!="") && (accountrows[j].debit!=0)){
						 amount=accountrows[j].debit;
						 id=1;
					}
					
					newTextBox.val(accountrows[j].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidterminationBenefitsPostingDate').val()){
				 $("#terminationBenefitsPostingDate").jqxDateTimeInput('val', $('#hidterminationBenefitsPostingDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		     var indexVal = document.getElementById("txttrno").value;
			 if(indexVal>0){
	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
			 }
	         
			 var indexVal1 = document.getElementById("docno").value;
	         var indexVal2 = document.getElementById("txttrno").value;
	         if(indexVal1>0){
	        	 var employeebranchchk=window.parent.employeebranchchk.value; 
	      		 var branch=document.getElementById("brchName").value;  
	         	$("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
	         } 
		}	
	  
	  function funProcessBtn(){
	      var paydate = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#terminationBenefitsPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#terminationBenefitsPostingDate').val();
			  var curfromdate= $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  var employeebranchchk=window.parent.employeebranchchk.value; 
			  $("#terminationBenefitsDetailsDiv").load("terminationBenefitsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value+'&employeebranchchk='+employeebranchchk);
			  
			  var rows = $("#terminationBenefitsDetails").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
			     $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?check=2");
			  }
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
	  }
	  
	  function funExcelExporter(){
			 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'TerminalBenefits', true);
			 } else {
				 $("#terminationBenefitsDetails").jqxGrid('exportdata', 'xls', 'TerminalBenefits');
			 }
		 }
	  
	  function funExcelBtn() {
		  JSONToCSVCon(dataExcelExport, 'TerminalBenefits', true);
	  }
		
		function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("transactions");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"transactions/terminationbenefits/printTerminalBenefitsPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
		
	  function datechange(){
		    var date = $('#terminationBenefitsPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#terminationBenefitsPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	  }
	  
</script>

<style>
/* ===============================
   ICONS
=============================== */
.icon {
    width: 2.5em;
    height: 2em;
    border: none;
    background-color: #E0ECF8;
}

/* ===============================
   SCROLL AREA
=============================== */
.hidden-scrollbar {
    overflow-y: auto;
    height: 530px;
    padding: 10px;
}

/* ===============================
   PAGE BASE
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
    border-radius: 12px;
    padding: 0 24px;
}

.receipt-header label {
    font-weight: 600;
    color: #333;
}

/* ===============================
   GLOBAL INPUT / SELECT SIZE FIX
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
   SECTION LAYOUT
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

/* ===============================
   🔵 BLUE HEADING ACCENT (ADDED)
=============================== */
.table-section h3,
.section-block h2,
.section-block h3 {
    margin: 0 0 16px;
    padding-left: 8px;
    border-left: 4px solid #007bff;
    font-size: 15px;
    font-weight: 700;
    color: #253858;
}

/* ===============================
   FORM GROUPS
=============================== */
.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 600;
    color: #253858;
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
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 700;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ===============================
   BOLD + NO WRAP (YOUR REQUIREMENT)
=============================== */
label,
.cr-table td label,
.cr-table th,
.cr-table td,
td,
th {
    font-weight: 700 !important;
    white-space: nowrap !important;
}

/* ===============================
   DATE PICKER HEIGHT FIX
=============================== */
.jqx-datetimeinput,
.jqx-input,
.jqx-datetimeinput input,
#masterdate,
#startDate,
#terminationDate,
#payrollDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    height: 32px !important;
    min-height: 32px !important;
    font-size: 14px !important;
}

/* ===============================
   DROPDOWN OPTIONS
=============================== */
select option {
    padding: 8px 12px;
    font-size: 14px;
    line-height: 1.6;
}

</style>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmTerminalBenefitsPosting"
      action="terminalbenefitsposting"
      method="post"
      autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="hidden-scrollbar">

        <!-- ===============================
             HEADER DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Terminal Benefits Posting</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Date</td>
                    <td>
                        <div id="terminationBenefitsPostingDate"
                             name="terminationBenefitsPostingDate"
                             onchange="datechange();"
                             value='<s:property value="terminationBenefitsPostingDate"/>'></div>
                        <input type="hidden"
                               id="hidterminationBenefitsPostingDate"
                               name="hidterminationBenefitsPostingDate"
                               value='<s:property value="hidterminationBenefitsPostingDate"/>' />
                    </td>

                    <td align="center">
                        <button type="button"
                                class="icon"
                                id="btnExcelExporter"
                                title="Export to Excel"
                                onclick="funExcelExporter();">
                            <img src="<%=contextPath%>/icons/excel_new.png"
                                 alt="Excel">
                        </button>
                    </td>

                    <td align="center">
                        <button type="button"
                                class="icon"
                                id="btnProcessing"
                                title="Process"
                                onclick="funProcessBtn();">
                            <img src="<%=contextPath%>/icons/process2.png"
                                 alt="Process"
                                 width="16" height="16">
                        </button>
                    </td>

                    <td align="center">
                        <button type="button"
                                class="icon"
                                id="btnCalculate"
                                title="Calculate"
                                onclick="funCalculateBtn();">
                            <img src="<%=contextPath%>/icons/calculate_new.png"
                                 alt="Calculate">
                        </button>
                    </td>

                    <td align="right">Doc No.</td>
                    <td>
                        <input type="text"
                               id="docno"
                               name="txtjvno"
                               tabindex="-1"
                               value='<s:property value="txtjvno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             DETAILS GRID
        ================================ -->
        <div class="table-section">
            <h3>Details</h3>
            <div class="cr-table" id="terminationBenefitsDetailsDiv">
                <jsp:include page="terminationBenefitsGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             TOTALS
        ================================ -->
        <div class="table-section">
            <h3>Summary</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Terminal Benefits</td>
                    <td>
                        <input type="text"
                               id="txtterminalbenefitstotal"
                               name="txtterminalbenefitstotal"
                               tabindex="-1"
                               style="text-align:right"
                               value='<s:property value="txtterminalbenefitstotal"/>' />
                    </td>

                    <td align="right">Leave Salary</td>
                    <td>
                        <input type="text"
                               id="txtleavesalarytotal"
                               name="txtleavesalarytotal"
                               tabindex="-1"
                               style="text-align:right"
                               value='<s:property value="txtleavesalarytotal"/>' />
                    </td>

                    <td align="right">Travels</td>
                    <td>
                        <input type="text"
                               id="txttravelstotal"
                               name="txttravelstotal"
                               tabindex="-1"
                               style="text-align:right"
                               value='<s:property value="txttravelstotal"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             ACCOUNTS
        ================================ -->
        <div class="table-section">
            <h3>Accounts</h3>
            <div class="cr-table" id="accountsDetailsDiv">
                <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
            </div>
        </div>

        <!-- ===============================
             DR / CR TOTALS
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
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <input type="hidden" id="journalgridlength" name="journalgridlength"/>
        <input type="hidden" id="txttrno" name="txttrno"
               value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtgridload" name="txtgridload"
               value='<s:property value="txtgridload"/>'/>
        <input type="hidden" id="txtchkgridload" name="txtchkgridload"
               value='<s:property value="txtchkgridload"/>'/>
        <input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid"
               value='<s:property value="txtchksalarypaid"/>'/>
        <input type="hidden" id="txtchkdate" name="txtchkdate"
               value='<s:property value="txtchkdate"/>'/>
        <input type="hidden" id="chkleavedayconfig"
               name="chkleavedayconfig"/>

    </div><!-- /.hidden-scrollbar -->

</form>

</div><!-- /#mainBG -->

</body>

</html>