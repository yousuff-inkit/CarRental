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

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#dr_DOB").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {
 		
 		var clname=document.getElementById("Cl_name").value;
 		var mob=document.getElementById("Cl_mob").value;
 		var lcno=document.getElementById("dr_Licence").value;
 		var passno=document.getElementById("dr_Passport").value;
 		var nation=document.getElementById("dr_Nation").value;
 		var dob=$('#dr_DOB').jqxDateTimeInput('val');
		var branch=document.getElementById("cmbbranch").value;
		clname=encodeURIComponent(clname);
		nation=encodeURIComponent(nation);
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch+'&mode=1');
	
		}

	</script>
<style type="text/css">
/* ------------------------------
    MASTER UI CSS STANDARDS
------------------------------ */
body {
    background-color: #FFFFFF !important;
    font-family: Tahoma, Geneva, sans-serif;
    margin: 0;
    padding: 0;
}

#search {
    background-color: #FFFFFF !important;
    padding: 15px;
}

/* Table Layout: Standard Master UI Gaps */
table {
    border-collapse: separate;
    border-spacing: 12px 8px;
}

/* Labels: Tahoma 14px, Weight 600 */
.formfont, td[align="right"], td[align="left"] label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;
    color: #222;
    white-space: nowrap;
}

/* Master Inputs: Grey Border #bdc3c7, Weight 600 */
input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 14px;
    padding: 6px 10px;
    border: 1px solid #bdc3c7; 
    border-radius: 4px;
    background-color: #ffffff;
    box-sizing: border-box;
}

input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Date Input Div Standard */
#dr_DOB {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 14px;
}

/* Master Blue Button: #007bff, No Hover Color Change */
.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 14px;
    background-color: #007bff;
    color: white;
    padding: 8px 25px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.myButton:hover {
    background-color: #007bff; /* Stays blue per instructions */
    cursor: pointer;
}
</style>

<body bgcolor="#FFFFFF">
<div id="search">
<table width="100%">
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td align="right"><label class="formfont">Name</label></td>
          <td align="left" width="73.7%">
            <input type="text" name="Cl_name" id="Cl_name" style="width:99%;" value='<s:property value="Cl_name"/>'>
          </td>
          <td align="left"><label class="formfont">MOB</label></td>
          <td align="left">
            <input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  
  <tr>
    <td>
      <table width="100%">
        <tr>
          <td align="right"><label class="formfont">Licence#</label></td>
          <td align="left"><input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'></td>
          <td align="right"><label class="formfont">Passport#</label></td>
          <td align="left"><input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'></td>
          <td align="right"><label class="formfont">Nationality</label></td>
          <td align="left"><input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'></td>
          
          <td align="right"><label class="formfont">DOB</label></td>
          <td align="left">
            <div id="dr_DOB" name="dr_DOB" value='<s:property value="dr_DOB"/>'></div>
            <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
          </td>
          <td colspan="2" align="center">
            <input type="button" name="btnrasearch" id="btnrasearch" class="myButton" value="Search" onclick="loadSearch();">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr>
    <td colspan="8" align="right">
      <div id="refreshdiv">
        <jsp:include page="clientinfo.jsp"></jsp:include> 
      </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>