 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 getStatus();
	
	}); 

 	function masterloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#msearchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("msearchfleetno").value;
 		var docno=document.getElementById("msearchdocno").value;
 		var regno=document.getElementById("msearchregno").value;
 		var status=document.getElementById("cmbsearchstatus").value;
	
 		
		getdata(reftype,reftype,searchdate,fleetno,docno,regno,status);
 

	}
	 function getStatus() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					items = items.split('***');
					var statusItems = items[0].split(",");
					var statusIdItems = items[1].split(",");
					var optionsstatus = '<option value="">--Select--</option>';
					for (var i = 0; i < statusItems.length; i++) {
						optionsstatus += '<option value="' + statusIdItems[i] + '">'
								+ statusItems[i] + '</option>';
					}
					$("select#cmbsearchrtype").html(optionsstatus);
					
					
				} else {
				}
			}
			x.open("GET", "getStatus.jsp", true);
			x.send();
		}
	 function getdata(reftype,reftype,searchdate,fleetno,docno,regno,status){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#mainrefreshdiv").load('subMainSearch.jsp?reftype='+reftype+'&msearchdate='+searchdate+'&mfleetno='+fleetno+'&mdocno='+docno+'&mregno='+regno+'&status='+status+'');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style type="text/css">
/* Master UI Styles */
/* Table spacing and layout */
table {
  border-collapse: separate;
  border-spacing: 15px 12px; /* Standardized master gap */
}

/* Bold labels - Standardized to Master UI 14px Tahoma */
td {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs and selects with Grey Borders */
input[type="text"], select {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Font weight 600 as requested */
  font-size: 14px;
  padding: 8px 10px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus, select:focus {
  border-color: #007bff;
  outline: none;
}

/* Specifically adjust jqxDateTimeInput styling if used */
#msearchdate {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 10px 25px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
}

/* No color change on hover */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
 <table width="100%">
  <tr>
    <td width="9%">Doc No</td>
    <td width="24%"><input type="text" name="msearchdocno" id="msearchdocno" style="width:95%;"></td>
    <td width="10%">Ref Type</td>
    <td width="24%"><select name="cmbsearchrtype" id="cmbsearchrtype" style="width:84%;"><option value="">--Select--</option></select></td>
    <td width="8%">Status</td>
    <td width="14%"><select name="cmbsearchstatus" id="cmbsearchstatus" style="width:99%;"><option value="">--Select--</option>
    <option value=1>IN</option><option value=0>OUT</option></select></td>
    <td width="11%" rowspan="2" align="center">
        <input type="button" name="btnmainSearchExt" id="btnmainSearchExt" class="myButton" value="Search" onclick="masterloadSearch();">
    </td>
  </tr>
  <tr>
    <td>Date</td>
    <td><div id="msearchdate" name="msearchdate"></div></td>
    <td>Fleet No</td>
    <td><input type="text" name="msearchfleetno" id="msearchfleetno" style="width:84%;"></td>
    <td>Reg No</td>
    <td><input type="text" name="msearchregno" id="msearchregno" style="width:99%;"></td>
  </tr>
  <tr>
  <td colspan="7">
    <div id="mainrefreshdiv">
      <jsp:include page="subMainSearch.jsp" />
    </div>
  </td>
  </tr>
 </table>
</div>
</body>
</html>