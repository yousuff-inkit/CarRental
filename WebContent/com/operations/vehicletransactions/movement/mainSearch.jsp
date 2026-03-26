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
		 $("#msearchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		 getStatus();
	
	}); 

 	function masterloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 		var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#msearchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("msearchfleetno").value;
 		var docno=document.getElementById("msearchdocno").value;
 		var regno=document.getElementById("msearchregno").value;
 		var status=document.getElementById("cmbsearchstatus").value;
	
 		
		getdata(reftype,reftype,searchdate,fleetno,docno,regno,status);
 

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
						optionsstatus += '<option value="' + statusIdItems[i] + '">'
								+ statusItems[i] + '</option>';
					}
					$("select#cmbsearchrtype").html(optionsstatus);
					
					
				} else {
				}
			}
			x.open("GET", "getStatus.jsp", true);
			x.send();
		}
	 function getdata(reftype,reftype,searchdate,fleetno,docno,regno,status){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#mainrefreshdiv").load('subMainSearch.jsp?reftype='+reftype+'&msearchdate='+searchdate+'&mfleetno='+fleetno+'&mdocno='+docno+'&mregno='+regno+'&status='+status+'');
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style type="text/css">
/* Scope all styles strictly to #search to protect background page fonts */
#search {
    background-color: #ffffff;
    padding: 5px;
    font-family: Tahoma, Geneva, sans-serif !important;
}

#search table {
    border-collapse: separate;
    border-spacing: 12px 10px;
    background-color: #ffffff;
}

/* Master UI Labels: Tahoma, Regular (Non-Bold), 13px */
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
    padding: 5px 8px;
    width: 100%;                
    box-sizing: border-box;   
    border: 1px solid #bdc3c7;
    border-radius: 3px;
    height: 28px;
    background-color: #ffffff !important;
    outline: none;
    display: inline-block;
}

/* Ensure dropdowns are visible and don't crash */
#search select {
    appearance: menulist;
    -webkit-appearance: menulist;
}

#search input[type="text"]:focus, 
#search select:focus {
    border-color: #2563eb;
}

/* EXACT Master UI Gradient Button */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif !important;
    font-weight: 700 !important;
    font-size: 13px;
    width: 90px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

#search .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
    box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}

#search tr {
    line-height: 1.2;
}

#mainrefreshdiv {
    margin-top: 10px;
    border-top: 1px solid #eee;
}
</style>

<body bgcolor="#ffffff">
<div id="search">
    <table width="100%" border="0">
        <tr>
            <td width="8%" align="right">Doc No</td>
            <td width="22%">
                <input type="text" name="msearchdocno" id="msearchdocno" value='<s:property value="msearchdocno"/>'>
            </td>
            <td width="10%" align="right">Ref Type</td>
            <td width="22%">
                <select name="cmbsearchrtype" id="cmbsearchrtype">
                    <option value="">--Select--</option>
                    <s:property value="refTypeOptions" escape="false"/>
                </select>
            </td>
            <td width="8%" align="right">Status</td>
            <td width="15%">
                <select name="cmbsearchstatus" id="cmbsearchstatus">
                    <option value="">--Select--</option>
                    <option value="1">IN</option>
                    <option value="0">OUT</option>
                </select>
            </td>
            <td width="15%" rowspan="2" align="center">
                <input type="button" name="btnmainSearchExt" id="btnmainSearchExt" class="myButton" value="Search" onclick="masterloadSearch();">
            </td>
        </tr>
        <tr>
            <td align="right">Date</td>
            <td>
                <div id="msearchdate" name="msearchdate"></div>
            </td>
            <td align="right">Fleet No</td>
            <td>
                <input type="text" name="msearchfleetno" id="msearchfleetno" value='<s:property value="msearchfleetno"/>'>
            </td>
            <td align="right">Reg No</td>
            <td>
                <input type="text" name="msearchregno" id="msearchregno" value='<s:property value="msearchregno"/>'>
            </td>
        </tr>
        <tr>
            <td colspan="7">
                <div id="mainrefreshdiv">
                    <jsp:include page="subMainSearch.jsp" />
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>