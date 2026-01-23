 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>


<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 
	 
	 $( "#btnok_client" ).click(function() {
  	   
        	var rows = $("#jqxclientsearch").jqxGrid('selectedrowindexes');
        if(rows!=""){
     	 	if(document.getElementById("searchdetails").value==""){
	           		document.getElementById("searchdetails").value="Client";	
	           		document.getElementById("client").value="Client";
	           	}
	           	else{
	           		document.getElementById("searchdetails").value+="\n\nClient";
	           		document.getElementById("client").value+="\nClient";
	           	}
        }
       
        	
        	document.getElementById("hidclient").value="";
        	
        	for(var i=0;i<rows.length;i++){
        		var dummy=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'refname');
        		var docno=$('#jqxclientsearch').jqxGrid('getcellvalue',rows[i],'cldocno');
        		document.getElementById("searchdetails").value+="\n"+dummy;
        		document.getElementById("client").value+="\n"+dummy;
        		if(i==0){
        			document.getElementById("hidclient").value=docno;
        		}
        		else{
        			document.getElementById("hidclient").value+=","+docno;
        		}
        	}
        	$('#clientSearchWindow').jqxWindow('close');
	});


$( "#btncancel_client" ).click(function() {
		$('#clientSearchWindow').jqxWindow('close');
	});
	
	
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=document.getElementById("dr_DOB").value;
		var branch=document.getElementById("cmbbranch").value;
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientSearchGrid.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch);
	
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
.formfont, td[align="right"] {
  font-family: Tahoma, Geneva, sans-serif;
  font-size: 14px;
  font-weight: 600; /* Font weight 600 as requested */
  color: #333;
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

/* Specifically adjust jqxDateTimeInput styling for DOB div */
#dr_DOB {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 600;
  font-size: 14px;
}

/* Master Button Appearance */
.myButton {
  font-family: Tahoma, Geneva, sans-serif;
  font-weight: 700;
  font-size: 14px;
  background-color: #007bff; /* Standard Blue */
  color: white;
  padding: 8px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  transition: none; /* No hover transition */
  min-width: 85px;
}

/* No color change on hover as per instructions */
.myButton:hover {
  background-color: #007bff; 
  cursor: pointer;
}

/* Row spacing */
tr {
  line-height: 1.6;
}

/* Override container backgrounds */
#search {
    background-color: #FFFFFF;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right"><label class="formfont">Name</label></td>
    <td colspan="5" align="left">
        <input type="text" name="Cl_name" id="Cl_name" style="width:100%;" value='<s:property value="Cl_name"/>'>
    </td>
    <td width="6%" align="center">&nbsp;</td>
    <td width="14%" align="center">
        <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onClick="loadSearch();">
    </td>
  </tr>
  <tr>
    <td align="right"><label class="formfont">License#</label></td>
    <td width="12%" align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'></td>
    <td width="8%" align="right"><label class="formfont">Passport#</label></td>
    <td width="17%" align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'></td>
    <td width="8%" align="right"><label class="formfont">Nationality</label></td>
    <td width="14%" align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'></td>
    <td align="center">&nbsp;</td>
    <td align="center">
        <button type="button" id="btnok_client" name="btnok" class="myButton">OK</button>
    </td>
  </tr>
  <tr>
    <td align="right"><span class="formfont">Mobile</span></td>
    <td align="left"><input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'></td>
    <td align="right"><span class="formfont">DOB</span></td>
    <td align="left">
        <div id="dr_DOB" name="dr_DOB" value='<s:property value="dr_DOB"/>'></div>
        <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
    </td>
    <td align="right">&nbsp;</td>
    <td align="left">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">
        <button type="button" id="btncancel_client" name="btncancel" class="myButton">Cancel</button>
    </td>
  </tr>
  <tr>
    <td colspan="8">
        <div id="refreshdiv">
            <jsp:include page="clientSearchGrid.jsp"></jsp:include> 
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>