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
/* =========================================================
SCOPED UI: Clean UI Panel Design for Search Modal
* All rules are prefixed with .modern-ui to prevent bleeding! *
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    padding: 10px;
    background-color: #f4f6f9;
    height: 100%;
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */
.modern-ui input[type="text"], 
.modern-ui select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
}

/* Compact Width Classes */
.modern-ui .input-xs { width: 60px !important; }
.modern-ui .input-sm { width: 100px !important; }
.modern-ui .input-md { width: 140px !important; }
.modern-ui .input-lg { width: 200px !important; }
.modern-ui .input-full { width: 100% !important; flex: 1; }

.modern-ui input[type="text"]:focus, 
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Layout Utilities */
.modern-ui .field-row {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 12px;
    flex-wrap: wrap;
}

.modern-ui .lbl-right {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
    padding-right: 5px;
}

/* Panel Styling */
.modern-ui .modern-panel {
    border: 1px solid #e1e4e8;
    padding: 15px;
    background: #fff;
    border-radius: 4px;
    margin-bottom: 15px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.05);
}

/* Search Button */
.modern-ui .myButton {
    font-weight: bold;
    font-size: 12px;
    height: 24px !important;
    padding: 0px 16px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s ease;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Grid Container */
.modern-ui .grid-container {
    background: #fff;
    border: 1px solid #e1e4e8;
    padding: 2px;
    min-height: 200px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    /* Upgraded height to 24px for Modern UI */
    $("#searchdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy",value:null});
    
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
            document.getElementById("errormsg").innerText="";
            document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
            return false;
        }
    }
    
    // Safety check in case errormsg doesn't exist on this popup
    if(document.getElementById("errormsg")){
        document.getElementById("errormsg").innerText="";
    }
    
    var client=document.getElementById("searchclient").value;
    var cmbagmttype=document.getElementById("searchcmbagmttype").value;
    var agmtno=document.getElementById("searchagmtno").value;
    var docno=document.getElementById("searchdocno").value;
    var searchdate=$('#searchdate').jqxDateTimeInput('val');
    
    $('#brchName').prop('disabled',false);
    var searchbranch=$('#brchName').val();
    $('#brchName').prop('disabled',true);
    
    getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch);
}

function getdata(client,cmbagmttype,agmtno,docno,searchdate,searchbranch){
    $("#srefreshdiv").load('subMainSearch.jsp?client='+client+'&cmbagmttype='+cmbagmttype+'&agmtno='+agmtno+'&docno='+docno+'&searchdate='+searchdate+'&branch='+searchbranch+'&id=1');
}
</script>
</head>
<body>

<div id="search" class="modern-ui">

    <div class="modern-panel">
        
        <div class="field-row">
            <label class="lbl-right" style="width: 50px;">Client</label>
            <input type="text" name="searchclient" id="searchclient" class="input-lg" value='<s:property value="searchclient"/>'>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">Ref Type</label>
            <select name="searchcmbagmttype" id="searchcmbagmttype" class="input-md">
                <option value="">--Select--</option>
                <option value="RAG">Rental</option>
                <option value="LAG">Lease</option>
            </select>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">Agmt No</label>
            <input type="text" name="searchagmtno" id="searchagmtno" class="input-md" value='<s:property value="searchagmtno"/>'>
        </div>

        <div class="field-row" style="margin-bottom: 0;">
            <label class="lbl-right" style="width: 50px;">Date</label>
            <div style="width: 125px;">
                <div id="searchdate" name="searchdate"></div>
            </div>

            <label class="lbl-right" style="width: 60px; margin-left: 10px;">Doc No</label>
            <input type="text" name="searchdocno" id="searchdocno" class="input-md" value='<s:property value="searchdocno"/>'>

            <div style="margin-left: auto;">
                <input type="button" name="btninvsearch" id="btninvsearch" class="myButton" value="Search" onClick="mainloadSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="subMainSearch.jsp"></jsp:include> 
        </div>
    </div>

</div>

</body>
</html>