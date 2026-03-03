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
/* ================================
   SEARCH POPUP – COMMON MASTER CSS
   ================================ */

#search {
    background-color: #ffffff;
    padding: 8px;
}

/* Table layout */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px;
}

/* Labels */
#search td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
}

/* Text inputs */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;

    padding: 6px 10px;
    height: 34px;
    width: 100%;

    box-sizing: border-box;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    background-color: #ffffff;
}

/* Input focus */
#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;

    background-color: #007bff;
    color: #ffffff;

    padding: 8px 20px;
    border: none;
    border-radius: 4px;

    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

#search .myButton:hover {
    background-color: #007bff;
}

/* Result grid spacing */
#refreshdiv {
    margin-top: 10px;
}
/* ================================
   SEARCH POPUP – REFINED LAYOUT
   ================================ */

.search-popup {
    padding: 14px;
}

/* Search form table */
.search-form {
    width: 100%;
    border-spacing: 18px 12px;
}

/* Labels */
.search-form .label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
    text-align: right;
}

/* Input cells */
.search-form .field {
    width: 28%;
}

/* Action cell */
.search-form .action {
    text-align: center;
    width: 12%;
}

/* Grid wrapper */
.search-grid {
    margin-top: 14px;
    border: 1px solid #dcdcdc;
    border-radius: 4px;
    background: #ffffff;
    padding: 6px;
}


</style>

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
		getdata(clname,mob,lcno,passno,nation,dob,branch);

	}	
	function getdata(clname,mob,lcno,passno,nation,dob,branch){
		
		 $("#refreshdiv").load('clientSearchGrid.jsp?clname='+clname.replace(/ /g,"%20")+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&branch='+branch+'&mode=1');
	
		}

	</script>
<body bgcolor="#E0ECF8">
<div id="search">

<table width="100%">

    <!-- ================= ROW 1 ================= -->
    <tr>
        <td align="right" width="10%">
            <label class="formfont">Name</label>
        </td>

        <td align="left" width="35%">
            <input type="text" name="Cl_name" id="Cl_name"
                  
                   value='<s:property value="Cl_name"/>'>
        </td>

        <td align="right" width="10%">
            <label class="formfont">MOB</label>
        </td>

        <td align="left" width="20%">
            <input type="text" name="Cl_mob" id="Cl_mob"
                   value='<s:property value="Cl_mob"/>'>
        </td>
    </tr>

    <!-- ================= ROW 2 ================= -->
    <tr>
        <td align="right">
            <label class="formfont">Licence#</label>
        </td>

        <td align="left">
            <input type="text" name="dr_Licence" id="dr_Licence"
                   value='<s:property value="dr_Licence"/>'>
        </td>

        <td align="right">
            <label class="formfont">Passport#</label>
        </td>

        <td align="left">
            <input type="text" name="dr_Passport" id="dr_Passport"
                   value='<s:property value="dr_Passport"/>'>
        </td>
    </tr>

    <!-- ================= ROW 3 ================= -->
    <tr>
        <td align="right">
            <label class="formfont">Nationality</label>
        </td>

        <td align="left">
            <input type="text" id="dr_Nation" name="dr_Nation"
                   value='<s:property value="dr_Nation"/>'>
        </td>

        <td align="right">
            <label class="formfont">DOB</label>
        </td>

        <td align="left">
            <div id="dr_DOB"
                 name="dr_DOB"
                 value='<s:property value="dr_DOB"/>'></div>
            <input type="hidden" name="hiddr_DOB" id="hiddr_DOB"
                   value='<s:property value="hiddr_DOB"/>'>
        </td>
    </tr>

    <!-- ================= SEARCH BUTTON ================= -->
    <tr>
        <td colspan="4" align="center" style="padding-top:10px;">
            <input type="button"
                   name="btnrasearch"
                   id="btnrasearch"
                   class="myButton"
                   value="Search"
                   onclick="loadSearch();">
        </td>
    </tr>

    <!-- ================= GRID ================= -->
    <tr>
        <td colspan="4">
            <div id="refreshdiv" style="margin-top:15px;">
                <jsp:include page="clientSearchGrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>

</table>

</div>
</body>
</html>