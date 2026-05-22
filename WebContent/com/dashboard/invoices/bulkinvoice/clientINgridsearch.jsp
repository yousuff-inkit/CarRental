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

		getdata(clname,mob,lcno,passno,nation,dob);

	}
	function getdata(clname,mob,lcno,passno,nation,dob){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&mode=1');
	
		}

	</script>
<style type="text/css">

/* ===== MASTER UI ===== */

body{
    margin:0;
    background:#f5f7fa;
}

/* MAIN */
#search.modern-ui{
    width:96%;
    margin:8px auto;
    font-family:'Segoe UI','Roboto','Arial',sans-serif !important;
    font-size:12px !important;
}

/* SEARCH PANEL */
.modern-ui .search-panel{
    background:#ffffff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:10px;
    margin-bottom:10px;
    box-shadow:0 2px 6px rgba(0,0,0,0.04);
}

/* GRID */
.modern-ui .grid-container{
    background:#ffffff;
    border:1px solid #c5d3e0;
    border-radius:8px;
    padding:5px;
}

/* TABLE */
.modern-ui table{
    width:100%;
    border-collapse:separate;
    border-spacing:6px 8px;
}

/* LABELS */
.modern-ui td.label{
    text-align:right;
    white-space:nowrap;
    vertical-align:middle;
}

.modern-ui .formfont{
    font-size:12px !important;
    font-weight:600;
    color:#000 !important;
}

/* INPUTS */
.modern-ui input[type="text"]{
    height:24px !important;
    padding:2px 6px !important;
    border:1px solid #b8c6d8;
    border-radius:3px;
    background:#fff;
    box-sizing:border-box;
    font-size:12px !important;
}

/* FIELD WIDTHS */
.modern-ui .name-field{
    width:100%;
}

.modern-ui .mob-field{
    width:140px;
}

.modern-ui .licence-field{
    width:150px;
}

.modern-ui .passport-field{
    width:150px;
}

.modern-ui .nation-field{
    width:140px;
}

/* DOB */
.modern-ui #dr_DOB{
    min-width:110px;
    height:24px;
    display:flex;
    align-items:center;
}

/* BUTTON */
.modern-ui .myButton{
    height:24px !important;
    line-height:22px !important;
    padding:0 14px;
    font-size:12px !important;
    font-weight:700;
    background:linear-gradient(135deg,#0b45a2 0%,#2563eb 100%);
    color:#fff;
    border:1px solid #083a8a;
    border-radius:3px;
    cursor:pointer;
    white-space:nowrap;
}

/* INLINE DOB */
.modern-ui .dob-wrapper{
    display:flex;
    align-items:center;
    gap:6px;
}

</style>

<body>

<div id="search" class="modern-ui">

    <!-- SEARCH PANEL -->
    <div class="search-panel">

        <table>

            <!-- ROW 1 -->
            <tr>

                <!-- NAME -->
                <td class="label">
                    <label class="formfont">Name</label>
                </td>

                <td width="48%">
                    <input type="text"
                           class="name-field"
                           name="Cl_name"
                           id="Cl_name"
                           value='<s:property value="Cl_name"/>'>
                </td>

                <!-- MOBILE -->
                <td class="label">
                    <label class="formfont">MOB</label>
                </td>

                <td width="18%">
                    <input type="text"
                           class="mob-field"
                           name="Cl_mob"
                           id="Cl_mob"
                           value='<s:property value="Cl_mob"/>'>
                </td>

            </tr>

            <!-- ROW 2 -->
            <tr>

                <!-- LICENCE -->
                <td class="label">
                    <label class="formfont">Licence#</label>
                </td>

                <td>
                    <input type="text"
                           class="licence-field"
                           name="dr_Licence"
                           id="dr_Licence"
                           value='<s:property value="dr_Licence"/>'>
                </td>

                <!-- PASSPORT -->
                <td class="label">
                    <label class="formfont">Passport#</label>
                </td>

                <td>
                    <input type="text"
                           class="passport-field"
                           name="dr_Passport"
                           id="dr_Passport"
                           value='<s:property value="dr_Passport"/>'>
                </td>

                <!-- NATIONALITY -->
                <td class="label">
                    <label class="formfont">Nationality</label>
                </td>

                <td>
                    <input type="text"
                           class="nation-field"
                           id="dr_Nation"
                           name="dr_Nation"
                           value='<s:property value="dr_Nation"/>'>
                </td>

                <!-- DOB -->
                <td class="label">
                    <label class="formfont">DOB</label>
                </td>

                <td>

                    <div class="dob-wrapper">

                        <div id="dr_DOB"
                             name="dr_DOB"
                             value='<s:property value="dr_DOB"/>'>
                        </div>

                        <input type="hidden"
                               name="hiddr_DOB"
                               id="hiddr_DOB"
                               value='<s:property value="hiddr_DOB"/>'>

                        <input type="button"
                               name="btnrasearch"
                               id="btnrasearch"
                               class="myButton"
                               value="Search"
                               onclick="loadSearch();">

                    </div>

                </td>

            </tr>

        </table>

    </div>

    <!-- GRID -->
    <div class="grid-container">

        <div id="refreshdiv">

            <jsp:include page="clientinfo.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>