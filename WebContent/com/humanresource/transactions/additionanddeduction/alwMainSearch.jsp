 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<title>GatewayERP(i)</title>

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#alwdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 getAlwYear();getAlwMonth();
	}); 
	
	function getAlwYear() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbalwyear").html(optionsyear);
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
	
	function getAlwMonth() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var monthItems = items[0].split(",");
				var monthIdItems = items[1].split(",");
				var optionsmonth = '<option value="">--Select--</option>';
				for (var i = 0; i < monthItems.length; i++) {
					optionsmonth += '<option value="' + monthIdItems[i] + '">'
							+ monthItems[i] + '</option>';
				}
				$("select#cmbalwmonth").html(optionsmonth);
			} else {
			}
		}
		x.open("GET", "getMonth.jsp", true);
		x.send();
	}

 	function loadSearch() {

 		var date=document.getElementById("alwdate").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var year=document.getElementById("cmbalwyear").value;
 		var month=document.getElementById("cmbalwmonth").value;
 		var description=document.getElementById("txtalwdescription").value;
 		var employeebranchchk=window.parent.employeebranchchk.value; 
 		var branch=document.getElementById("brchName").value;
		getdata(date,docNo,year,month,description, employeebranchchk, branch);
	}
 	
	function getdata(date,docNo,year,month,description, employeebranchchk, branch){
		 $("#refreshdiv").load('alwMainSearchGrid.jsp?date='+date+'&docNo='+docNo+'&year='+year+'&month='+month+'&description='+description.replace(/ /g, "%20")+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
	}

	</script>
<style type="text/css">
#search {
    width: 900px;
    margin: 0 auto;
    background: #ffffff;
    border: 1px solid #ccc;
    font-family: Tahoma, Geneva, sans-serif;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 12px 10px; 
}

td[align="right"], td.label {
    font-size: 13px;
    font-weight: 700;
    color: #333;
    white-space: nowrap;
    text-align: right;
}

input[type="text"], select {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 600;
    font-size: 12px;
    padding: 4px 8px;
    width: 100%;
    box-sizing: border-box;
    border: 1px solid #d1d5db;
    border-radius: 4px;
    height: 28px;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
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

.myButton:hover {
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}

#refreshdiv {
    margin-top: 10px;
    border-top: 1px solid #e0e4ee;
}
</style>

<body bgcolor="#E0ECF8">
<div id="search">
    <table border="0">
        <tr>
            <td width="10%" class="label">Date</td>
            <td width="15%">
                <div id="alwdate" name="alwdate" value='<s:property value="alwdate"/>'></div>
                <input type="hidden" name="hidalwdate" id="hidalwdate" value='<s:property value="hidalwdate"/>'>
            </td>

            <td width="10%" class="label">Doc No</td>
            <td width="15%">
                <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'>
            </td>

            <td width="10%" class="label">Year</td>
            <td width="15%">
                <select name="cmbalwyear" id="cmbalwyear">
                    <option value="">--Select--</option>
                </select>
            </td>

            <td width="25%" rowspan="2" align="center" valign="middle">
                <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
            </td>
        </tr>

        <tr>
            <td class="label">Month</td>
            <td>
                <select name="cmbalwmonth" id="cmbalwmonth">
                    <option value="">--Select--</option>
                </select>
            </td>

            <td class="label">Description</td>
            <td colspan="3">
                <input type="text" name="txtalwdescription" id="txtalwdescription" value='<s:property value="txtalwdescription"/>'>
            </td>
        </tr>

        <tr>
            <td colspan="7">
                <div id="refreshdiv">
                    <jsp:include page="alwMainSearchGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>