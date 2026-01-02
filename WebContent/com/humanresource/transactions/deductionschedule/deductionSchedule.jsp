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

<script type="text/javascript">
      $(document).ready(function () {
    	  /* Date */
    	  $("#deductionScheduleDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  $("#startDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  //$("#empDateOfBirth").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
    	  
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
        //alert(caldate+"===="+caltodate);
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
		 
		 $('#startDate').jqxDateTimeInput({disabled: false});  // while saving the date goes as null for disabled jqxdateandtime
		 $('#deductionScheduleDate').jqxDateTimeInput({disabled: false});  // while saving the date goes as null for disabled jqxdateandtime
		 
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

<style>
/* ==============================
   MASTER SCROLL AREA
============================== */
.hidden-scrollbar {
    max-height: calc(100vh - 140px); /* header + padding safe */
    overflow-y: auto;
    overflow-x: hidden;
    padding: 10px;
}

/* ==============================
   BACKGROUND
============================== */
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

/* ==============================
   MAIN CARD
============================== */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ==============================
   RECEIPT HEADER
============================== */
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

.receipt-header input[type="text"] {
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    width: 120px;
    background: #fff;
}

.receipt-header input:focus {
    border-color: #007bff;
    outline: none;
}

.receipt-header button {
    height: 32px;
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 0 16px;
    font-weight: 500;
    cursor: pointer;
}

.receipt-header button:hover {
    background: #0056b3;
}

/* ==============================
   SECTION BLOCKS
============================== */
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

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input,
.section-block select {
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
}

/* ==============================
   TABLE SECTION
============================== */
.table-section {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 12px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.table-section h3 {
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 15px;
    font-weight: 600;
}

/* ==============================
   TABLE GRID
============================== */
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

/* ==============================
   INPUTS IN TABLE
============================== */
.cr-table input,
.cr-table select {
    height: 32px;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
}
/* ==============================
   MASTER INPUT SIZE FIX
============================== */
input[type="text"],
input[type="number"],
input[type="file"],
select {
    height: 32px !important;        /* 🔑 lock height */
    padding: 4px 10px !important;  /* reduce bulk */
    font-size: 14px !important;
    line-height: 1.2;
    border-radius: 6px;
    box-sizing: border-box;
}


</style>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmDeductionSchedule"
      action="saveDeductionSchedule"
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
            <h3>Deduction Schedule</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Date</td>
                    <td>
                        <div id="deductionScheduleDate"
                             name="deductionScheduleDate"
                             value='<s:property value="deductionScheduleDate"/>'></div>
                        <input type="hidden"
                               id="hiddeductionScheduleDate"
                               name="hiddeductionScheduleDate"
                               value='<s:property value="hiddeductionScheduleDate"/>' />
                    </td>

                    <td align="right">Ref. No.</td>
                    <td>
                        <input type="text"
                               id="txtemployeerefno"
                               name="txtemployeerefno"
                               placeholder="Ref. No."
                               value='<s:property value="txtemployeerefno"/>' />
                    </td>

                    <td align="right">Doc No</td>
                    <td>
                        <input type="text"
                               id="docno"
                               name="txtdeductionscheduledocno"
                               tabindex="-1"
                               value='<s:property value="txtdeductionscheduledocno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             EMPLOYEE DETAILS
        ================================ -->
        <div class="table-section">
            <h3>Employee</h3>

            <table class="cr-table">
                <tr>
                    <td align="right">Employee</td>
                    <td>
                        <input type="text"
                               id="txtemployeedetails"
                               name="txtemployeedetails"
                               placeholder="Press F3 to Search"
                               onkeydown="getEmployeeDetails(event);"
                               value='<s:property value="txtemployeedetails"/>' />
                        <input type="hidden"
                               id="txtemployeedocno"
                               name="txtemployeedocno"
                               value='<s:property value="txtemployeedocno"/>' />
                    </td>
                </tr>
            </table>
        </div>

        <!-- ===============================
             DEDUCTION DETAILS + GRID
        ================================ -->
        <div class="table-section">

            <div class="section-row">

                <!-- LEFT : FORM -->
                <div class="section-block">

                    <h3>Deduction Details</h3>

                    <div class="form-group">
                        <label>Amount</label>
                        <input type="text"
                               id="txtamount"
                               name="txtamount"
                               placeholder="Amount"
                               style="text-align:right"
                               onblur="funRoundAmt(this.value,this.id);funInstAmount();"
                               value='<s:property value="txtamount"/>' />
                    </div>

                    <div class="form-group">
                        <label>Inst. Nos</label>
                        <input type="text"
                               id="txtinstnos"
                               name="txtinstnos"
                               placeholder="Inst. Nos"
                               onblur="funInstAmount();"
                               value='<s:property value="txtinstnos"/>' />
                    </div>

                    <div class="form-group">
                        <label></label>
                        <input type="checkbox"
                               id="allowinstamt"
                               name="allowinstamt"
                               onchange="this.checked ?
                                   $('#txtinstcustomamt').prop('disabled',false) :
                                   $('#txtinstcustomamt').prop('disabled',true);" />
                        <span>Inst. Amount</span>
                    </div>

                    <div class="form-group">
                        <label></label>
                        <input type="text"
                               id="txtinstcustomamt"
                               name="txtinstcustomamt"
                               placeholder="Inst. Amount"
                               style="text-align:right"
                               disabled
                               onblur="funRoundAmt(this.value,this.id);funInstAmount();"
                               value='<s:property value="txtinstcustomamt"/>' />
                        <input type="hidden"
                               id="txtinstamt"
                               name="txtinstamt"
                               value='<s:property value="txtinstamt"/>' />
                        <input type="hidden"
                               id="txtinstamttotal"
                               name="txtinstamttotal"
                               value='<s:property value="txtinstamttotal"/>' />
                    </div>

                    <div class="form-group">
                        <label>Start Date</label>
                        <div id="startDate"
                             name="startDate"
                             value='<s:property value="startDate"/>'></div>
                        <input type="hidden"
                               id="hidstartDate"
                               name="hidstartDate"
                               value='<s:property value="hidstartDate"/>' />
                    </div>

                    <div class="form-group">
                        <label>Description</label>
                        <input type="text"
                               id="txtdescription"
                               name="txtdescription"
                               placeholder="Description"
                               value='<s:property value="txtdescription"/>' />
                    </div>

                    <div style="text-align:center; margin-top:16px;">
                        <button type="button"
                                class="myButton"
                                id="btnDistributionSubmit"
                                onclick="deductionGridLoading();">
                            Submit
                        </button>
                    </div>

                </div>

                <!-- RIGHT : GRID -->
                <div class="section-block">
                    <h3>Schedule</h3>
                    <div class="cr-table" id="deductionScheduleDiv">
                        <jsp:include page="deductionScheduleGrid.jsp"></jsp:include>
                    </div>
                </div>

            </div>
        </div>

        <!-- ===============================
             HIDDEN FIELDS
        ================================ -->
        <input type="hidden" id="mode" name="mode" />
        <input type="hidden" id="deleted" name="deleted"
               value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>' />
        <input type="hidden" id="txtvalidation" name="txtvalidation"
               value='<s:property value="txtvalidation"/>' />
        <input type="hidden" id="gridlength" name="gridlength" />
        <input type="hidden" id="hidsaldate" name="hidsaldate" />

    </div><!-- /.hidden-scrollbar -->

</form>

<div id="employeeDetailsWindow"><div></div></div>

</div><!-- /#mainBG -->

</body>

</html>
