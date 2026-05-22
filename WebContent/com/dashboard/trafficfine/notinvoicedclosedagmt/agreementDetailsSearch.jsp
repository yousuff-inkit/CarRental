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
<style>
.textdetail {
	color: black;
	background-color: #E0ECF8;
	width: 100%;
	font-family: Tahoma;
	font-size: 10px;
}
</style>

	<script type="text/javascript">
	$(document).ready(function () {
	
	}); 

 	function mainloadSearch() {
 		
 		var sclname=document.getElementById("SCl_name").value;
 		var smob=document.getElementById("Sl_mob").value;
 		var rno=document.getElementById("rno").value;
 		var flno=document.getElementById("flno").value;
 		var sregno=document.getElementById("sregno").value;
 		var branch=document.getElementById("cmbbranch").value;
 		var rentaltype=document.getElementById("rentaltype").value;
 		

	
		getdata(sclname,smob,rno,flno,sregno,rentaltype,branch);

	}
	 function getdata(sclname,smob,rno,flno,sregno,rentaltype,branch){
		 $("#srefreshdiv").load('agreementDetailsSearchGrid.jsp?sclname='+sclname+'&smob='+smob+'&rno='+rno+'&flno='+flno+'&sregno='+sregno+'&rentaltype='+rentaltype+'&branch='+branch);
		}
 
	</script>
<style type="text/css">

/* ===== CLEAN MASTER UI ===== */

body{
    margin:0;
    background:#f5f7fa;
}

/* MAIN */
#search{
    width:96%;
    margin:8px auto;
    font-family:Segoe UI, Arial, sans-serif;
    font-size:12px;
}

/* TOP PANEL */
.search-panel{
    background:#ffffff;
    border:1px solid #cfd9e2;
    border-radius:6px;
    padding:8px 10px;
    margin-bottom:8px;
}

/* GRID PANEL */
.grid-panel{
    background:#ffffff;
    border:1px solid #cfd9e2;
    border-radius:6px;
    padding:4px;
}

/* TABLE */
#search table{
    width:100%;
    border-collapse:separate;
    border-spacing:6px 6px;
}

/* LABELS */
.label{
    font-size:12px;
    font-weight:600;
    color:#000;
    white-space:nowrap;
    text-align:right;
}

/* INPUTS */
#search input[type="text"]{
    height:24px;
    border:1px solid #bcc8d6;
    border-radius:3px;
    padding:2px 6px;
    font-size:12px;
    box-sizing:border-box;
    background:#fff;
}

/* BUTTON */
.myButton{
    height:24px;
    padding:0 16px;
    font-size:12px;
    font-weight:600;
    color:#fff;
    border:1px solid #0a3d91;
    border-radius:3px;
    background:#1f5fd1;
    cursor:pointer;
}

/* WIDTHS */
.name-box{
    width:100%;
}

.mob-box{
    width:130px;
}

.reg-box{
    width:130px;
}

.doc-box{
    width:120px;
}

.fleet-box{
    width:150px;
}

/* INLINE */
.inline-row{
    display:flex;
    align-items:center;
    gap:8px;
}

</style>

<body>

<div id="search">

    <!-- SEARCH AREA -->
    <div class="search-panel">

        <table>

            <!-- ROW 1 -->
            <tr>

                <td class="label" width="6%">Name</td>

                <td width="44%">
                    <input type="text"
                           class="name-box"
                           name="SCl_name"
                           id="SCl_name"
                           value='<s:property value="SCl_name"/>'>
                </td>

                <td class="label" width="5%">Mob</td>

                <td width="14%">
                    <input type="text"
                           class="mob-box"
                           name="Sl_mob"
                           id="Sl_mob"
                           value='<s:property value="Sl_mob"/>'>
                </td>

                <td class="label" width="7%">Reg No</td>

                <td width="14%">
                    <input type="text"
                           class="reg-box"
                           id="sregno"
                           name="sregno"
                           value='<s:property value="sregno"/>'>
                </td>

            </tr>

            <!-- ROW 2 -->
            <tr>

                <td class="label">Doc No</td>

                <td colspan="3">

                    <div class="inline-row">

                        <input type="text"
                               class="doc-box"
                               name="rno"
                               id="rno"
                               value='<s:property value="rno"/>'>

                        <label class="label">Fleet No</label>

                        <input type="text"
                               class="fleet-box"
                               name="flno"
                               id="flno"
                               value='<s:property value="flno"/>'>

                    </div>

                </td>

                <td colspan="2" align="left">

                    <input type="button"
                           name="mbtnrasearch"
                           id="mbtnrasearch"
                           class="myButton"
                           value="Search"
                           onclick="mainloadSearch();">

                </td>

            </tr>

        </table>

    </div>

    <!-- GRID -->
    <div class="grid-panel">

        <div id="srefreshdiv">

            <jsp:include page="agreementDetailsSearchGrid.jsp"></jsp:include>

        </div>

    </div>

</div>

</body>
</html>