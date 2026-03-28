<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

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
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
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
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
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


fieldset {
    background: #ffffff;
}

.status {
    padding: 3px 8px;
    border-radius: 3px;
    font-weight: bold;
    font-size: 11px;
    display: inline-block;
}

/* Active (Green) */
.status.active {
    background-color: #e6f4ea;
    color: #2e7d32;
    border: 1px solid #2e7d32;
}

/* Inactive (Red) */
.status.inactive {
    background-color: #fdecea;
    color: #c62828;
    border: 1px solid #c62828;
}

/* Warning (Orange) */
.status.warning {
    background-color: #fff4e5;
    color: #ef6c00;
    border: 1px solid #ef6c00;
}


.status {
    font-weight: bold;
    font-size: 14px;
    color: #f4a261;
    text-shadow: 0 0 1px rgba(0,0,0,0.1);
}

.status {
    font-weight: bold;
    font-size: 14px;
    color: #f4a261;
    animation: blink 2s infinite;
}

/* Blinking animation */
@keyframes blink {
    0%   { opacity: 1; }
    50%  { opacity: 0; }
    100% { opacity: 1; }
}

 .myButton {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important;
    font-size: 9px;
    width: 90px !important;
    height: 26px;
    padding: 0;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

 .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

.myButton:active {
    transform: scale(0.97);
}
</style>

<script type="text/javascript">

	$(document).ready(function () { 
		 $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		 $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );$('#btnPrint').attr('disabled', true );
		 
		 $("#jqxNonFinancialDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#jqxClientReviewDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		$('#clientWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Clients Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
		$('#clientWindow').jqxWindow('close');
		
		$('#nonFinancialWindow').jqxWindow({width: '51%', height: '28%',  maxHeight: '30%' ,maxWidth: '51%' , title: 'Non-Financial Comments',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true });
		$('#nonFinancialWindow').jqxWindow('close');
		
		document.getElementById("hidchckdetailed").value = 0;
		getIDPDetails();
		
		$('#txtclientname').dblclick(function(){
			clientSearchContent('clientDetailsSearch.jsp');
		});
	});
	
	function clientSearchContent(url) {
	    $('#clientWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientWindow').jqxWindow('setContent', data);
		$('#clientWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function nonFinancialCommentsContent(url) {
	    $('#nonFinancialWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#nonFinancialWindow').jqxWindow('setContent', data);
		$('#nonFinancialWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getIDPDetails(){
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			    $('#idpdetailsallowed').val(items);
		}
		}
		x.open("GET", "getIDPDetailsAllowed.jsp", true);
		x.send();
    }
	
	function getAccountBalance(a,b){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  			    $('#txtbalance').val(items[0]);
  			    $('#lblclientstatus').html(items[1]);
  		}
  		}
  		x.open("GET", "getAccountBalance.jsp?accountno="+a+'&cldocno='+b, true);
  		x.send();
 	}
	
	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearch.jsp');
	    }
	    else{}
	    }
	
	function funDetailed(){
		 if(document.getElementById("chckdetailed").checked){
			 $.messager.confirm('Confirm', 'Do you want to have detailed informations?', function(r){
					if (r){
						document.getElementById("hidchckdetailed").value = 1;
						var detailed=$('#hidchckdetailed').val();
						var cldocno=$('#txtcldocno').val();
						var accno=$('#txtaccno').val();
						if(cldocno != ""){
				    	    $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
				    	    $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
			          	    $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
			          	    $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
			          	}
			        	if(accno != ""){
				    	    $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
			        	}
					 }
					else{
						document.getElementById("chckdetailed").checked = false;
						document.getElementById("hidchckdetailed").value = 0;
					}
				   });
		 } else{
			 document.getElementById("chckdetailed").checked = false;
			 document.getElementById("hidchckdetailed").value = 0;
			 var detailed=$('#hidchckdetailed').val();
			 var cldocno=$('#txtcldocno').val();
			 var accno=$('#txtaccno').val();
			 if(cldocno != ""){
	    	    $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
	    	    $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
          	    $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
          	    $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
          	 }
        	 if(accno != ""){
	    	    $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+cldocno+'&detailed='+detailed);
        	 }
		 }
	 }
	
	function funOutStandingStatement(){
		var accno = $('#txtaccno').val();
		 
		if(accno==''){
			 $.messager.alert('Message','Please Choose a Client.','warning');
			 return 0;
		 }
		
	    if ($("#txtaccno").val()!="") {
	        var url=document.URL;
	        var reurl=url.split("clientReview.jsp");
	        
	        $("#txtaccno").prop("disabled", false);
	        var win= window.open(reurl[0]+"clientReviewOutstandingsStatement?atype=AR&acno="+document.getElementById("txtaccno").value+'&level1from=0&level1to=30&level2from=31&level2to=60&level3from=61&level3to=90&level4from=91&level4to=120&level5from=121&branch='+document.getElementById("brchName").value+'&uptoDate='+$("#jqxClientReviewDate").val()+'&email=Nil&print=1',"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        win.focus();
	     }
	    else {
			$.messager.alert('Message','Account is Mandatory.','warning');
			return;
		}
	   }
  
    function funSaveDetails(event){
		var mode = $("#mode").val("A");
		var cldocno = $('#txtcldocno').val();
		var description = $('#txtdescription').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		 saveGridData(description,cldocno,mode);	
		     	}
		 });
	}
    
    function funDeleteDocu(event){
		var mode = $("#mode").val("D");
		var cldocno = $('#txtcldocno').val();
		
		if(cldocno==''){
			 $.messager.alert('Message','Choose a Client.','warning');
			 return 0;
		 }
			
		    $.messager.confirm('Message', 'Do you want to delete?', function(r){
			        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		$('#txtdescription').val('');
		    		$('#txtdescriptions').val('');
		    		var description = 0;
		     		 saveGridData(description,cldocno,mode);	
		     	}
		 });
	}
	
	function saveGridData(description,cldocno,mode){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				$.messager.alert('Message', 'Successfully Completed. ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?description="+description+"&cldocno="+cldocno+"&mode="+mode,true);
	x.send();
	}
	
	function funAttachButton(){
		if (($("#mode").val() == "view") && $("#txtcldocno").val()!="") {
			$("#windowattach").jqxWindow('setTitle',"CRM - "+document.getElementById("txtcldocno").value);
		
			changeAttachContent("<%=contextPath%>/com/common/attachGrid.jsp?formCode=CRM&docno="+document.getElementById("txtcldocno").value);		
		} else {
			$.messager.alert('Message','Select a Document....!','warning');
			return;
		}
	}
	
	function funReadOnly(){
		$('#frmClientReview input').attr('readonly', true );
		$("#financialCommentsGridID").jqxGrid({ disabled: true});
		//$("#nonFinancialCommentsGridID").jqxGrid({ disabled: true});
		$("#operationGridID").jqxGrid({ disabled: true});
		$("#quotationGridID").jqxGrid({ disabled: true});
		$("#accidentDamageGridID").jqxGrid({ disabled: true});
		$("#driverGridID").jqxGrid({ disabled: true});
		$("#btnbalance").hide();
    }
	
 	function funRemoveReadOnly(){}
 
 	function funSearchLoad(){
	/* changeContent('cpvMainSearch.jsp'); */ 
 	}
	
	 function funChkButton() {
		/* funReset(); */
	}
 
 	function funFocus(){
    	document.getElementById("txtclientname").focus();	    		
    }
   
  function funNotify(){	
    		return 1;
	} 
  
  
  function setValues(){
	  $("#btnbalance").show();
	  
	  if(document.getElementById("hidchckdetailed").value==1){
		  document.getElementById("chckdetailed").checked = true;
	  } else if(document.getElementById("hidchckdetailed").value==0){
		  document.getElementById("chckdetailed").checked = false;
	  }
	  
	  if($('#msg').val()!=""){
		  $.messager.alert('Message',$('#msg').val());
	  }
	  
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel();
	  
	  var detailed=$('#hidchckdetailed').val();
	  var accno=$('#txtaccno').val();
  	  if(accno != ""){
      	   var indexVal = document.getElementById("txtcldocno").value;
  	       $("#paymentFollowUpDiv").load("paymentFollowUpGrid.jsp?accountno="+accno+'&cldocno='+indexVal+'&detailed='+detailed);
  	  }
  	
  	  var cldocno=$('#txtcldocno').val();
  	  if(cldocno != ""){
  	      $("#operationDiv").load("operationGrid.jsp?cldocno="+cldocno+'&detailed='+detailed);
  	      $("#driverDiv").load("driverDetailsGrid.jsp?cldocno="+cldocno);
  	      $("#accidentDamageDiv").load("accidentDamageHistoryGrid.jsp?cldocno="+cldocno);
  	      $("#quotationDiv").load("quotationGrid.jsp?cldocno="+cldocno);
  	  }
  	
  	  /* var cldocno=$('#txtcldocno').val();
  	  if(cldocno != ""){
    	  $("#nonFinancialCommentsDiv").load("nonFinancialCommentsGrid.jsp?cldocno="+cldocno);
	  } */
  	
  	  $('#txtdescription').attr('readonly', false);
	 
	}
	
</script>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientReview" action="saveClientReview" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>

<table width="100%">
  <tr>
    <td width="4%" align="right">Client</td>

    <td width="22%">
      <input type="text" id="txtclientname" name="txtclientname"
             placeholder="Press F3 to Search"
             onkeydown="getAcc(event);"
             value='<s:property value="txtclientname"/>'/>

      <input type="hidden" id="txtcldocno" name="txtcldocno"
             value='<s:property value="txtcldocno"/>'/>

      <input type="hidden" id="txtaccno" name="txtaccno"
             value='<s:property value="txtaccno"/>'/>
    </td>

    <td width="12%" align="right" class="lbl-right">
      Account Balance :
    </td>

    <td width="18%">
      <input type="text" id="txtbalance" name="txtbalance"
             style="width:40%; text-align:right;"
             value='<s:property value="txtbalance"/>'/>
    </td>

    <td width="10%">
      <label class="status" id="lblclientstatus">
        <s:property value="lblclientstatus"/>
      </label>
    </td>

    <td width="11%">
      <label class="chk-container">
        <input type="checkbox" id="chckdetailed"
               onchange="funDetailed();"
               onclick="$(this).attr('value', this.checked ? 1 : 0)">
        Detailed
      </label>

      <input type="hidden" id="hidchckdetailed"
             value='<s:property value="hidchckdetailed"/>'/>
    </td>

    <td width="13%">
      <button class="myButton" type="button"
              onclick="funOutStandingStatement();">
        Outstanding Statement
      </button>
    </td>

    <td width="9%" align="center">
      <button class="myButton" type="button"
              onclick="funAttachButton();">
        Attach
      </button>
    </td>
  </tr>
</table>


<table width="100%">

<tr>
<td>
  <fieldset>
    <legend>Operations</legend>
    <div id="operationDiv">
      <jsp:include page="operationGrid.jsp"></jsp:include>
    </div>
  </fieldset>
</td>
</tr>

<tr>
<td>
  <table width="100%">
    <tr>

      <td width="70%">
        <fieldset>
          <legend>Payment Follow-Up</legend>
          <div id="paymentFollowUpDiv">
            <jsp:include page="paymentFollowUpGrid.jsp"></jsp:include>
          </div>
        </fieldset>
      </td>

      <td width="30%">
        <fieldset>
          <jsp:include page="description.jsp"></jsp:include>
        </fieldset>
      </td>

    </tr>
  </table>
</td>
</tr>

<tr>
<td>
  <fieldset>
    <legend>Driver Details</legend>
    <div id="driverDiv">
      <jsp:include page="driverDetailsGrid.jsp"></jsp:include>
    </div>
  </fieldset>
</td>
</tr>

<tr>
<td>
  <fieldset>
    <legend>Accident/Damage History</legend>
    <div id="accidentDamageDiv">
      <jsp:include page="accidentDamageHistoryGrid.jsp"></jsp:include>
    </div>
  </fieldset>
</td>
</tr>

<tr>
<td>
  <fieldset>
    <legend>Quotation Details</legend>
    <div id="quotationDiv">
      <jsp:include page="quotationGrid.jsp"></jsp:include>
    </div>
  </fieldset>
</td>
</tr>

</table>



<div hidden="true" id="jqxClientReviewDate" name="jqxClientReviewDate" value='<s:property value="jqxClientReviewDate"/>'></div>
<div hidden="true" id="jqxNonFinancialDate" name="jqxNonFinancialDate" value='<s:property value="jqxNonFinancialDate"/>'></div>
<input type="hidden" id="hidjqxNonFinancialDate" name="hidjqxNonFinancialDate" value='<s:property value="hidjqxNonFinancialDate"/>'/>
<input type="hidden" id="txtnonfinancialcomment" name="txtnonfinancialcomment" style="width:80%;" value='<s:property value="txtnonfinancialcomment"/>'/>
<input type="hidden" id="docno" name="txtnonfinancialdocno" value='<s:property value="txtnonfinancialdocno"/>'/>
<input type="hidden" id="idpdetailsallowed" name="idpdetailsallowed"  value='<s:property value="idpdetailsallowed"/>'/>

<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
<div id="clientWindow">
	<div></div><div></div>
</div>
<div id="nonFinancialWindow">
	<div></div><div></div>
</div>  
</div>
</body>
</html>