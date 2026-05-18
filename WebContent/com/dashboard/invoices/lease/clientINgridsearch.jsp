 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<style>
.formfont {
	font: 10px Tahoma;
	color: #404040;
	background: #E0ECF8;
	overflow:hidden;
}
</style>
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
 		clname=encodeURIComponent(clname);
		nation=encodeURIComponent(nation);
		getdata(clname,mob,lcno,passno,nation,dob);

	}
	function getdata(clname,mob,lcno,passno,nation,dob){
		
		 $("#refreshdiv").load('clientinfo.jsp?clname='+clname+'&mob='+mob+'&lcno='+lcno+'&passno='+passno+'&nation='+nation+'&dob='+dob+'&mode=1');
	
		}

	</script>
<style type="text/css">

/* ===== MASTER UI STRICT ===== */

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
    color:#333;
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

/* GRID PANEL */
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
    border-spacing:4px 8px;
}

/* LABELS */
.modern-ui .formfont{
    font-size:12px !important;
    font-weight:600;
    color:#000 !important;
    white-space:nowrap;
}

/* LABEL TD */
.modern-ui td.label{
    text-align:right;
    white-space:nowrap;
    vertical-align:middle;
    color:#000 !important;
}

/* LABEL TEXT */
.modern-ui .formfont{
    font-size:12px !important;
    font-weight:600;
    color:#000 !important;
    white-space:nowrap;
}

/* INPUT */
.modern-ui input[type="text"]{
    width:100%;
    height:24px !important;
    padding:2px 6px !important;
    border:1px solid #b8c6d8;
    border-radius:3px;
    background:#fff;
    box-sizing:border-box;
    font-size:12px !important;
}

/* DATE FIELD */
.modern-ui #dr_DOB{
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

/* INLINE DOB + BUTTON */
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

            <colgroup>

                <!-- ROW 1 -->
                <col width="7%">
                <col width="43%">

                <col width="6%">
                <col width="14%">

                <!-- ROW 2 -->
                <col width="7%">
                <col width="13%">

                <col width="7%">
                <col width="13%">

                <col width="7%">
                <col width="13%">

                <col width="5%">
                <col width="18%">

            </colgroup>

            <!-- ROW 1 -->
            <tr>

                <td class="label">
                    <label class="formfont">Name</label>
                </td>

                <td colspan="3">
                    <input type="text"
                           name="Cl_name"
                           id="Cl_name"
                           value='<s:property value="Cl_name"/>'>
                </td>

                <td class="label">
                    <label class="formfont">MOB</label>
                </td>

                <td>
                    <input type="text"
                           name="Cl_mob"
                           id="Cl_mob"
                           value='<s:property value="Cl_mob"/>'>
                </td>

            </tr>

            <!-- ROW 2 -->
            <tr>

                <td class="label">
                    <label class="formfont">Licence#</label>
                </td>

                <td>
                    <input type="text"
                           name="dr_Licence"
                           id="dr_Licence"
                           value='<s:property value="dr_Licence"/>'>
                </td>

                <td class="label">
                    <label class="formfont">Passport#</label>
                </td>

                <td>
                    <input type="text"
                           name="dr_Passport"
                           id="dr_Passport"
                           value='<s:property value="dr_Passport"/>'>
                </td>

                <td class="label">
                    <label class="formfont">Nationality</label>
                </td>

                <td>
                    <input type="text"
                           id="dr_Nation"
                           name="dr_Nation"
                           value='<s:property value="dr_Nation"/>'>
                </td>

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

</body></html>