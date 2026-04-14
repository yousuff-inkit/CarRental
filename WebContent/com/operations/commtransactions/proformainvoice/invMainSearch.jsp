<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
/* =========================================================
SCOPED UI: Compact Search Modal Layout (Table-Based)
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 10px;
}

/* Restored Table Alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; /* Replaces row/col gap */
    width: 100%;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Modern Search Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Upgraded height to 24px for Modern UI */
    $("#searchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", 
            "line-height": "24px", 
            "font-size": "12px", 
            "font-family": "Arial, sans-serif",
            "padding": "0 6px", 
            "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);
});

function mainloadSearch() {
    if(document.getElementById("searchagmtno").value!=""){
        if(document.getElementById("searchcmbagmttype").value==""){
            if(document.getElementById("errormsg")){
                document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
            }
            return false;
        }
    }
    
    // Safety check in case errormsg doesn't exist on this popup
    if(document.getElementById("errormsg")){
        document.getElementById("errormsg").innerText="";
    }
    
    var client=document.getElementById("searchclient").value || "";
    var cmbagmttype=document.getElementById("searchcmbagmttype").value || "";
    var agmtno=document.getElementById("searchagmtno").value || "";
    var docno=document.getElementById("searchdocno").value || "";
    var searchdate=$('#searchdate').jqxDateTimeInput('val') || "";
    
    $('#brchName').prop('disabled',false);
    var searchbranch=$('#brchName').val() || "";
    $('#brchName').prop('disabled',true);
    
    getdata(client, cmbagmttype, agmtno, docno, searchdate, searchbranch);
}

function getdata(client, cmbagmttype, agmtno, docno, searchdate, searchbranch){
    /* Used encodeURIComponent to safely handle spaces and special characters */
    $("#srefreshdiv").load('subMainSearch.jsp?client=' + encodeURIComponent(client) + 
                           '&cmbagmttype=' + encodeURIComponent(cmbagmttype) + 
                           '&agmtno=' + encodeURIComponent(agmtno) + 
                           '&docno=' + encodeURIComponent(docno) + 
                           '&searchdate=' + searchdate + 
                           '&branch=' + encodeURIComponent(searchbranch) + '&id=1');
}
</script>
</head>
<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Client</td>
                <td width="25%">
                    <input type="text" name="searchclient" id="searchclient" value='<s:property value="searchclient"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Ref Type</td>
                <td width="20%">
                    <select name="searchcmbagmttype" id="searchcmbagmttype">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                </td>
                
                <td class="lbl-right" width="10%">Agmt No</td>
                <td width="27%">
                    <input type="text" name="searchagmtno" id="searchagmtno" value='<s:property value="searchagmtno"/>'>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="searchdate" name="searchdate"></div>
                </td>
                
                <td class="lbl-right">Doc No</td>
                <td>
                    <input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'>
                </td>
                
                <td colspan="2" align="right">
                    <input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search" onClick="mainloadSearch(); return false;">
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>