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
   STRICTLY SCOPED UI: Segoe UI Font & Clean White Search Panel
   Every rule starts with #search to prevent bleeding into the main UI.
========================================================= */

#search {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

/* Master Input Styles - LOCKED TO 24px */
#search input[type="text"],
#search select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

#search input[type="text"]:focus,
#search select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling - Clean White Panel */
#search .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 10px;
}

/* Table Alignment */
#search table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

#search td {
    vertical-align: middle;
}

#search .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - LOCKED TO 24px */
#search .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#search .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
#search .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {
         /* LOCKED TO 24px */
		 $("#msearchdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null, theme: 'energyblue'});
		 getStatus();
	
        /* Force internal alignment AFTER render - LOCKED TO 24px */
        setTimeout(function () {
            $("#msearchdate").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $("#msearchdate").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
	}); 

	function masterloadSearch() {
		var reftype = document.getElementById("cmbsearchrtype").value || "";
		var searchdate = $('#msearchdate').jqxDateTimeInput('val') || "";
		var fleetno = document.getElementById("msearchfleetno").value || "";
		var docno = document.getElementById("msearchdocno").value || "";
		var regno = document.getElementById("msearchregno").value || "";
		var status = document.getElementById("cmbsearchstatus").value || "";
	
		getdata(reftype, searchdate, fleetno, docno, regno, status);
	}
	
    function getStatus() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText;
                items = items.split('***');
                var statusItems = items[0].split(",");
                var statusIdItems = items[1].split(",");
                var optionsstatus = '<option value="">--Select--</option>';
                for (var i = 0; i < statusItems.length; i++) {
                    optionsstatus += '<option value="' + statusIdItems[i] + '">' + statusItems[i] + '</option>';
                }
                $("select#cmbsearchrtype").html(optionsstatus);
            }
        }
        x.open("GET", "getStatus.jsp", true);
        x.send();
    }
    
    function getdata(reftype, searchdate, fleetno, docno, regno, status){
        /* Used encodeURIComponent to safely handle special characters */
        $("#mainrefreshdiv").load('subMainSearch.jsp?reftype=' + encodeURIComponent(reftype) + 
                                  '&msearchdate=' + searchdate + 
                                  '&mfleetno=' + encodeURIComponent(fleetno) + 
                                  '&mdocno=' + encodeURIComponent(docno) + 
                                  '&mregno=' + encodeURIComponent(regno) + 
                                  '&status=' + encodeURIComponent(status));
    }
</script>

</head>
<body>

<div id="search">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="20%">
                    <input type="text" name="msearchdocno" id="msearchdocno" value='<s:property value="msearchdocno"/>'>
                </td>
                
                <td class="lbl-right" width="10%">Ref Type</td>
                <td width="20%">
                    <select name="cmbsearchrtype" id="cmbsearchrtype">
                        <option value="">--Select--</option>
                        <s:property value="refTypeOptions" escape="false"/>
                    </select>
                </td>
                
                <td class="lbl-right" width="8%">Status</td>
                <td width="15%">
                    <select name="cmbsearchstatus" id="cmbsearchstatus">
                        <option value="">--Select--</option>
                        <option value="1">IN</option>
                        <option value="0">OUT</option>
                    </select>
                </td>
                
                <td width="19%" align="center" rowspan="2" style="vertical-align: middle;">
                    <input type="button" name="btnmainSearchExt" id="btnmainSearchExt" class="myButton" value="Search" onclick="masterloadSearch(); return false;">
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right">Date</td>
                <td>
                    <div id="msearchdate" name="msearchdate"></div>
                </td>
                
                <td class="lbl-right">Fleet No</td>
                <td>
                    <input type="text" name="msearchfleetno" id="msearchfleetno" value='<s:property value="msearchfleetno"/>'>
                </td>
                
                <td class="lbl-right">Reg No</td>
                <td>
                    <input type="text" name="msearchregno" id="msearchregno" value='<s:property value="msearchregno"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="mainrefreshdiv">
            <jsp:include page="subMainSearch.jsp" />
        </div>
    </div>

</div>

</body>
</html>