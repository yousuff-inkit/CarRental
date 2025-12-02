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
<style>
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Outer Search Box */
    #search {
        width: 95%;
        margin: 15px auto;
        padding: 15px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.18);
        border: 1px solid #c6ddf5;
    }

    /* Labels */
    td {
        font-size: 14px;
        color: #000000; /* Black text */
        padding: 4px 8px;
    }

    /* Input Fields */
    input[type="text"], select {
        width: 95%;
        padding: 6px 8px;
        border: 1px solid #b7d1ee;
        border-radius: 6px;
        outline: none;
        font-size: 13px;
        background: #ffffff;
        color: #000000;
        transition: 0.3s;
    }

    input[type="text"]:focus, select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 4px rgba(13, 110, 253, 0.4);
    }

    /* jqxDateTimeInput styling */
    .jqx-widget-content {
        font-size: 13px;
        color: #000000;
        border-radius: 6px;
        border: 1px solid #b7d1ee;
    }

    /* Search Button */
    .myButton {
        background: #0d6efd;
        color: white;
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: 0.3s;
        width: 120px;
    }

    .myButton:hover {
        background: #0b5ed7;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        transform: translateY(-2px);
    }

    /* Grid / Refresh Div Styling */
    #srefreshdiv {
        margin-top: 15px;
        padding: 10px;
        background: #ffffff;
        border: 1px solid #cfdaf0;
        border-radius: 10px;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        color: #000000; /* Black text */
    }

    /* Table styling */
    table {
        border-collapse: collapse;
        width: 100%;
    }

    tr {
        height: 40px;
    }
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
<body bgcolor="#E0ECF8">
<div id=search>
  <table width="100%" >
    <tr>
    <td width="12%" align="right">Doc No</td>
    <td width="14%" align="left"><input type="text" name="searchdocno" id="searchdocno"></td>
    <td width="7%" align="right">Date</td>
    <td width="13%" align="left"><div id="searchdate" name="searchdate"></div></td>
    <td width="13%" align="right">Color</td>
    <td width="15%" align="left"><select name="searchcolor" id="searchcolor" ><option value="">--Select--</option></select></td>
    <td width="12%" align="right">&nbsp;</td>
    <td width="14%" align="left">&nbsp;</td>
    </tr>

  <tr>
    <td align="right">Fleet No</td>
    <td align="left"><input type="text" name="searchfleetno" id="searchfleetno" ></td>
    <td align="right">Reg No</td>
    <td align="left"><input type="text" name="searchregno" id="searchregno"></td>
    <td align="right">Group</td>
    <td align="left"><select name="searchgroup" id="searchgroup" ><option value="">--Select--</option></select></td>
    <td align="right">&nbsp;</td>
    <td align="center"><input type="button" name="btnSearchExt" id="btnSearchExt" class="myButton" value="Search" onClick="mainloadSearch();"></td>
  </tr>
  <tr>
  <td colspan="8">
   <div id="srefreshdiv">
      
   <jsp:include  page="fleetSearch.jsp"></jsp:include> 
   
  </div>
  </td>
  </tr>
 </table>

   
</div>
</body>
</html>