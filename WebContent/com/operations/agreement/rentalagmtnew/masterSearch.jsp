 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%--   <jsp:include page="../../../../includes.jsp"></jsp:include>   --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclnames=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var smra=document.getElementById("smra").value;
	
 		var sclname = sclnames.replace(/ /g, "%20");
 		
 		var branch_chk=document.getElementById("branch_chk").value;
 		
		getdata(sclname,smob,rno,flno,sregno,smra,branch_chk);
		
		

	}
	 function getdata(sclname,smob,rno,flno,sregno,smra,branch_chk){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('submainSearch.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&smra='+smra+'&branch_chk='+branch_chk);
		 

		  
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
td[align="right"], td {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 700;
  color: #222;
  white-space: nowrap;
}

/* Bold text inside inputs with Grey Borders */
input[type="text"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600; /* Font weight 600 as requested */
  font-size: 14px;
  padding: 8px 12px;
  max-width: 100%;
  box-sizing: border-box;
  /* Grey border */
  border: 1px solid #bdc3c7; 
  border-radius: 4px;
  background-color: #ffffff;
}

/* Focus state for inputs */
input[type="text"]:focus {
  border-color: #007bff;
  outline: none;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Blue Button Color */
  color: white;
  padding: 8px 20px;
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

/* Checkbox alignment */
input[type="checkbox"] {
  vertical-align: middle;
  margin-right: 5px;
}

/* Row spacing */
tr {
  line-height: 1.6;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%" >
  <tr>
   <td>
     <table width="100%">
       <tr>
        <td align="right" width="55">Name</td>
        <td align="left" colspan="3">
          <input type="text" name="SCl_name" id="SCl_name" style="width:99%;" value='<s:property value="SCl_name"/>'>
        </td>
        <td align="right">MOB</td>
        <td align="left">
          <input type="text" name="Sl_mob" id="Sl_mob" value='<s:property value="Sl_mob"/>'>
        </td>
        <td width="35" align="right">MRA</td>
        <td width="144" align="left">
          <input type="text" id="smra" name="smra" value='<s:property value="smra"/>'>
        </td>
       </tr>
       
       <tr>
        <td align="right" width="55">Doc NO</td>
        <td align="left" width="120">
          <input type="text" name="rno" id="rno" value='<s:property value="rno"/>'>
        </td>
        <td align="right" width="68">Fleet NO</td>
        <td align="left" width="298">
          <input type="text" name="flno" id="flno" style="width:96.5%;" value='<s:property value="flno"/>'>
        </td>
        <td align="right" width="59">Reg NO</td>
        <td align="left" width="146">
          <input type="text" id="sregno" name="sregno" value='<s:property value="sregno"/>'>
        </td>
        <td align="left" width="55" colspan="2">
          <input type="checkbox" id="branch_chk" name="branch_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
          &nbsp;All Branch &nbsp;&nbsp; 
          <input type="button" name="mbtnrasearch" id="mbtnrasearch" class="myButton" value="Search" onclick="mainloadSearch();">
        </td>
       </tr>
     </table>
   </td>
  </tr>

  <tr>
    <td colspan="8">
      <div id="srefreshdiv">
        <jsp:include page="submainSearch.jsp"></jsp:include>
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>