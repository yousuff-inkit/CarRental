 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		getGroup();
		getColor();
	
	}); 
function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#searchgroup").html(optionsgroup);
				
				
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#searchcolor").html(optionscolor);
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
		x.send();
	}
 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		var color=document.getElementById("searchcolor").value;
		var group=document.getElementById("searchgroup").value;
 		var branch=document.getElementById("brchName").value;
		getdata(searchdate,fleetno,docno,regno,color,group,branch);
 

	}

	 function getdata(searchdate,fleetno,docno,regno,color,group,branch){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('fleetSearch.jsp?searchdate='+searchdate+'&fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&color='+color+'&group='+group+'&branch='+branch);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style type="text/css">
/* Strict Scope to protect background page fonts */
#search {
    background-color: #ffffff;
    padding: 2px;
    font-family: Tahoma, Geneva, sans-serif !important;
}

#search table {
    border-collapse: separate;
    border-spacing: 4px 6px; /* Ultra-tight spacing */
    background-color: #ffffff;
}

/* Master UI Labels: Tahoma, Regular, 13px */
#search td {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important; 
    font-size: 13px;
    color: #222;
    white-space: nowrap;
}

/* Master UI Inputs & Selects: White Background, Grey Border */
#search input[type="text"], 
#search select {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 400 !important;
    font-size: 13px;
    padding: 3px 6px;
    width: 100%;                
    box-sizing: border-box;   
    border: 1px solid #bdc3c7;
    border-radius: 3px;
    height: 24px; /* Compact height */
    background-color: #ffffff !important;
    outline: none;
}

/* Ensure dropdown text is properly visible */
#search select {
    appearance: menulist;
    -webkit-appearance: menulist;
}

#search input[type="text"]:focus, 
#search select:focus {
    border-color: #2563eb;
}

/* EXACT Master UI Gradient Button - Fixed 90px Width */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 700 !important;
    font-size: 11px;
    width: 90px !important;
    height: 28px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.2s ease;
    box-shadow: 0 1px 3px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    text-align: center;
}

#search .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    transform: translateY(-1px);
}

#srefreshdiv {
    margin-top: 4px;
    border-top: 1px solid #eee;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
    <table border="0">
        <tr>
            <td align="right">Doc No</td>
            <td width="140">
                <input type="text" name="searchdocno" id="searchdocno" value='<s:property value="searchdocno"/>'>
            </td>
            <td align="right">Date</td>
            <td width="130">
                <div id="searchdate" name="searchdate"></div>
            </td>
            <td align="right">Color</td>
            <td width="140">
                <select name="searchcolor" id="searchcolor">
                    <option value="">--Select--</option>
                    <s:property value="colorOptions" escape="false"/>
                </select>
            </td>
            <td width="10"></td> <td></td> </tr>
        <tr>
            <td align="right">Fleet No</td>
            <td>
                <input type="text" name="searchfleetno" id="searchfleetno" value='<s:property value="searchfleetno"/>'>
            </td>
            <td align="right">Reg No</td>
            <td>
                <input type="text" name="searchregno" id="searchregno" value='<s:property value="searchregno"/>'>
            </td>
            <td align="right">Group</td>
            <td>
                <select name="searchgroup" id="searchgroup">
                    <option value="">--Select--</option>
                    <s:property value="groupOptions" escape="false"/>
                </select>
            </td>
            <td></td>
            <td align="left">
                <input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();">
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <div id="srefreshdiv">
                    <jsp:include page="fleetSearch.jsp" /> 
                </div>
            </td>
        </tr>
    </table>
</div>
</body></html>