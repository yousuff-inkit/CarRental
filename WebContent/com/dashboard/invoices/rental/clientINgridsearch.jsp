<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
/* =========================================================
   SCOPED UI: Modern Search Popup Style
========================================================= */
body {
    margin: 0;
    background-color: #f5f7fa; 
}

#search.modern-ui {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-size: 12px !important;
    color: #333;
    padding: 10px;
    background-color: #f5f7fa;
}

.modern-ui .search-panel {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 12px 10px;
    margin-bottom: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    min-height: 50px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.04);
}

/* Table layout */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 4px 8px; 
    width: 100%;
}

.modern-ui td {
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    vertical-align: middle;
}

.modern-ui td[align="right"] {
    color: #444 !important;
    font-weight: 600 !important;
    padding-right: 8px;
    white-space: nowrap;
}

.modern-ui .formfont {
    font-size: 12px;
    font-weight: 600;
    cursor: default;
    color: #444;
}

/* Master Input Heights */
.modern-ui input[type="text"] {
    height: 24px !important;
    font-size: 12px !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: normal !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    box-sizing: border-box;
    width: 100%;
    transition: border-color 0.2s;
    background-color: #ffffff;
}

.modern-ui input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

/* Buttons */
.modern-ui .myButton {
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif !important;
    font-weight: 700 !important;
    font-size: 12px !important;
    height: 24px !important; 
    line-height: 22px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: 1px solid #083a8a; 
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    text-align: center;
    width: 100%;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#dr_DOB").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value: null});
}); 

function loadSearch() {
    var clname = document.getElementById("Cl_name").value;
    var mob = document.getElementById("Cl_mob").value;
    var lcno = document.getElementById("dr_Licence").value;
    var passno = document.getElementById("dr_Passport").value;
    var nation = document.getElementById("dr_Nation").value;
    var dob = $('#dr_DOB').jqxDateTimeInput('val');
    
    // Safely check for the cmbbranch element (handles if it's placed in a parent DOM window)
    var branchEle = document.getElementById("cmbbranch");
    var branch = branchEle ? branchEle.value : "";
    
    getdata(clname, mob, lcno, passno, nation, dob, branch);
}   

function getdata(clname, mob, lcno, passno, nation, dob, branch){
    $("#refreshdiv").load('clientinfo.jsp?clname=' + encodeURIComponent(clname) + 
        '&mob=' + encodeURIComponent(mob) + 
        '&lcno=' + encodeURIComponent(lcno) + 
        '&passno=' + encodeURIComponent(passno) + 
        '&nation=' + encodeURIComponent(nation) + 
        '&dob=' + encodeURIComponent(dob) + 
        '&branch=' + encodeURIComponent(branch) + 
        '&mode=1');
}
</script>
</head>

<body bgcolor="#f5f7fa">
<div id="search" class="modern-ui">

    <!-- SEARCH FORM -->
    <div class="search-panel">
        <table width="100%" cellpadding="0" cellspacing="0">
            <colgroup>
                <col width="10%"> <col width="23%">
                <col width="10%"> <col width="23%">
                <col width="10%"> <col width="24%">
            </colgroup>

            <!-- Row 1 -->
            <tr>
                <td align="right"><label class="formfont">Name</label></td>
                <td align="left" colspan="3">
                    <input type="text" name="Cl_name" id="Cl_name" value='<s:property value="Cl_name"/>'>
                </td>

                <td align="right"><label class="formfont">Mob</label></td>
                <td align="left">
                    <input type="text" name="Cl_mob" id="Cl_mob" value='<s:property value="Cl_mob"/>'>
                </td>
            </tr>

            <!-- Row 2 -->
            <tr>
                <td align="right"><label class="formfont">Licence#</label></td>
                <td align="left">
                    <input type="text" name="dr_Licence" id="dr_Licence" value='<s:property value="dr_Licence"/>'>
                </td>

                <td align="right"><label class="formfont">Passport#</label></td>
                <td align="left">
                    <input type="text" name="dr_Passport" id="dr_Passport" value='<s:property value="dr_Passport"/>'>
                </td>

                <td align="right"><label class="formfont">Nationality</label></td>
                <td align="left">
                    <input type="text" id="dr_Nation" name="dr_Nation" value='<s:property value="dr_Nation"/>'>
                </td>
            </tr>

            <!-- Row 3 -->
            <tr>
                <td align="right"><label class="formfont">DOB</label></td>
                <td align="left">
                    <div id="dr_DOB" name="dr_DOB" value='<s:property value="dr_DOB"/>'></div>
                    <input type="hidden" name="hiddr_DOB" id="hiddr_DOB" value='<s:property value="hiddr_DOB"/>'>
                </td>

                <td colspan="3"></td>

                <td align="center">
                    <button type="button" name="btnrasearch" id="btnrasearch" class="myButton" onclick="loadSearch();">
                        Search
                    </button>
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