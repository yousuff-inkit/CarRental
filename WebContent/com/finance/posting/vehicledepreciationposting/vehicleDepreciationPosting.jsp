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
		 
		 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
	     var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		 var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	     var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	     $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	    
	});
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     
	  			     document.getElementById("errormsg").innerText="Depreciation done till "+items[2]+".";
	  			     
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					  $("#overlay, #PleaseWait").show();
	  					  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value);
	  					  $('#txtchkgridload').val('');
	  					  $('#txtgridload').val(1);
	  					  $('#btnExcelExporter').show();
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Depreciation Pending for Last-Month.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Depreciation Already Done.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Depreciation date should be Month-End.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
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
			$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: true});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: true});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmVehicleDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: false});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: false});
			$('#jqxVehDepreciationPostingDate').jqxDateTimeInput({disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#jqxVehDepreciationPostingDate').val(new Date());
				var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
				var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
			    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
				
				$("#jqxvehicleDetails").jqxGrid('clear'); 
				$("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				$("#jqxVehicleAccounts").jqxGrid('clear');
				$("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('vdpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxVehDepreciationPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
				var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		        var validdate=funDateInPeriod(paydate);
		         if(validdate==0){
			        return 0;	
		         }
		         
		        var txtdrtotal=parseFloat($('#txtdrtotal').val()==''?0.0:$('#txtdrtotal').val());
		        var txtcrtotal=parseFloat($('#txtcrtotal').val()==''?0.0:$('#txtcrtotal').val());
		        if(txtdrtotal==0.0 || txtcrtotal==0.0){
		        	document.getElementById("errormsg").innerText="";
		        	document.getElementById("errormsg").innerText="Dedit/Credit Total cannot be zero";
		        	return 0;
		        }
	    	    /* Validation Ends*/
	        	
	        	/* Vehicle Details Grid  Saving*/
				 var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
				 var length=0;
				 var veharray=new Array();
				 var accarray=new Array();
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].fleet_no;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							/* newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    newTextBox.val(rows[i].fleet_no+"::"+rows[i].depr_amt+"::"+rows[i].frmdate+"::"+rows[i].depr+"::"+rows[i].bookvalue);
					newTextBox.appendTo('form'); */
					length=length+1;
							veharray.push(rows[i].fleet_no+"::"+rows[i].depr_amt+"::"+rows[i].frmdate+"::"+rows[i].depr+"::"+rows[i].bookvalue+"::");
							
						}
					}
		 		 $('#gridlength').val(length);
		 		//veharray.appendTo('form');
		 		//veharray.
		 		document.getElementById("vehdetarray").value=veharray;
	 		   /* Vehicle Details Grid  Saving Ends*/	
	 		   
		 		/* Account Details Grid Saving */
		    	 var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
		    	 var journallength=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chks=rows[i].acno;
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						journallength=journallength+1;
						
					var amount,id;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 id=-1;
					}
					
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 id=1;
					}
					
					newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
					newTextBox.appendTo('form');
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidjqxVehDepreciationPostingDate').val()){
				 $("#jqxVehDepreciationPostingDate").jqxDateTimeInput('val', $('#hidjqxVehDepreciationPostingDate').val());
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
	         $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
	         } 
		}	
	  
	  function funProcessBtn(){
	      var paydate = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(paydate);
		  if(validdate==0){
			return 0;	
		  }
		  var date = $('#jqxVehDepreciationPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#jqxVehDepreciationPostingDate').val();
			  var curfromdate= $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  
			  $("#vehiclesDetailsDiv").load("vehiclesDetailsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  
			  var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
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
			  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
			 } else {
				 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
			 }
		 }
	  
	  function funExcelBtn() {
		  if ($("#mode").val() == "view") {
		  	 if(parseInt(window.parent.chkexportdata.value)=="1") {
			  	JSONToCSVCon(data, 'VehicleDepreciationPosting', true);
			 } else {
				 $("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'VehicleDepreciationPosting');
			 }
		  }
	  }
		
		function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("posting");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"posting/vehicledepreciationposting/printVehicleDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"posting/vehicledepreciationposting/printVehicleDepreciationPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
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
		    var date = $('#jqxVehDepreciationPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#jqxVehDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	  }
	  
</script>
<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
      width: 100%;
    max-width: 100%;
    margin: 0;              /* REMOVE auto */
    padding: 15px;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
     flex: 1;
    overflow: visible;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 6px;
    padding: 8px 8px 6px;
    border-radius: 4px;
}


legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;

    border-left: 3px solid #0056b3;
      margin-bottom: 2px;   /* reduce gap below title */
    padding: 0 4px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }

html, body {
    height: 100%;
}

body {
    display: flex;
    flex-direction: column;
    margin: 0;
}



html, body {
    height: 100%;
    overflow-y: auto;   /* enable main scroll */
}

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmVehicleDepreciationPosting" action="vehicledepreciationposting" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<div id="mainBG">

<fieldset>

<div class="top-grid">

    <!-- Date -->
    <label>Date</label>
    <div id="jqxVehDepreciationPostingDate"
         onchange="datechange();"
         value='<s:property value="jqxVehDepreciationPostingDate"/>'></div>

    <input type="hidden" id="hidjqxVehDepreciationPostingDate"
           name="hidjqxVehDepreciationPostingDate"
           value='<s:property value="hidjqxVehDepreciationPostingDate"/>'/>

    <!-- Excel -->
    <label></label>
    <button type="button" class="icon" id="btnExcelExporter"
            title="Export current Document to Excel"
            onclick="funExcelExporter();">
        <img src="<%=contextPath%>/icons/excel_new.png">
    </button>

    <!-- Process -->
    <label></label>
    <button type="button" id="btnProcessing"
            title="Process"
            style="border:none;background:none;"
            onclick="funProcessBtn();">
        <img src="<%=contextPath%>/icons/process2.png" width="16">
    </button>

    <!-- Calculate -->
    <label></label>
    <button type="button" id="btnCalculate"
            title="Calculate"
            onclick="funCalculateBtn();">
        <img src="<%=contextPath%>/icons/calculate_new.png">
    </button>

    <!-- Doc No -->
    <label>Doc No.</label>
    <input type="text" id="docno" name="txtjvno"
           value='<s:property value="txtjvno"/>' tabindex="-1"/>

</div>

</fieldset>

<fieldset>
<legend>Details</legend>
<div id="vehiclesDetailsDiv">
    <jsp:include page="vehiclesDetailsGrid.jsp"></jsp:include>
</div>
</fieldset>

<!-- Depreciation Total -->
<div class="top-grid" style="grid-template-columns: 1fr 200px;">
    <label class="lbl-right">Depr. Total</label>
    <input type="text" id="txtdeprtotal"
           name="txtdeprtotal"
           value='<s:property value="txtdeprtotal"/>'
           style="text-align:right;" tabindex="-1"/>
</div>

<fieldset>
<legend>Accounts</legend>
<div id="accountsDetailsDiv">
    <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
</div>
</fieldset>

<!-- DR / CR Totals -->
<div class="top-grid"
     style="grid-template-columns: 100px 150px 100px 150px; max-width: 500px; margin-left:auto;">

    <label class="lbl-right">Dr. Total</label>
    <input type="text" id="txtdrtotal"
           name="txtdrtotal"
           value='<s:property value="txtdrtotal"/>'
           style="text-align:right;" tabindex="-1"/>

    <label class="lbl-right">Cr. Total</label>
    <input type="text" id="txtcrtotal"
           name="txtcrtotal"
           value='<s:property value="txtcrtotal"/>'
           style="text-align:right;" tabindex="-1"/>

</div>

</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="journalgridlength" name="journalgridlength"/>
<input type="hidden" id="txttrno" name="txttrno"  value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtgridload" name="txtgridload"  value='<s:property value="txtgridload"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload"  value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtchkdate" name="txtchkdate"  value='<s:property value="txtchkdate"/>'/>
<input type="hidden" id="vehdetarray" name="vehdetarray"  value='<s:property value="vehdetarray"/>'/>
</div>
</form>
	
</div>
</body>
</html>