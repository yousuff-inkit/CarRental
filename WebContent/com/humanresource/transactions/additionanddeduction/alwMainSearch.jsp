 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<style type="text/css">
/* ================================
   SEARCH POPUP – COMMON MASTER CSS
   ================================ */

#search {
    background-color: #ffffff;
    padding: 8px;
}

/* Table layout */
#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 15px 12px;
}

/* Labels */
#search td[align="right"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
}

/* Text inputs */
#search input[type="text"] {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 600;

    padding: 6px 10px;
    height: 34px;
    width: 100%;

    box-sizing: border-box;
    border: 1px solid #bdc3c7;
    border-radius: 4px;
    background-color: #ffffff;
}

/* Input focus */
#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}

/* Button */
#search .myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;

    background-color: #007bff;
    color: #ffffff;

    padding: 8px 20px;
    border: none;
    border-radius: 4px;

    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

#search .myButton:hover {
    background-color: #007bff;
}

/* Result grid spacing */
#refreshdiv {
    margin-top: 10px;
}
/* ================================
   SEARCH POPUP – REFINED LAYOUT
   ================================ */

.search-popup {
    padding: 14px;
}

/* Search form table */
.search-form {
    width: 100%;
    border-spacing: 18px 12px;
}

/* Labels */
.search-form .label {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    color: #222;
    white-space: nowrap;
    text-align: right;
}

/* Input cells */
.search-form .field {
    width: 28%;
}

/* Action cell */
.search-form .action {
    text-align: center;
    width: 12%;
}

/* Grid wrapper */
.search-grid {
    margin-top: 14px;
    border: 1px solid #dcdcdc;
    border-radius: 4px;
    background: #ffffff;
    padding: 6px;
}
.myButtons {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 14px;
    font-weight: 700;
    background-color: #007bff;   /* BLUE */
    color: #ffffff;
    padding: 8px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    box-shadow: 0 2px 4px rgba(0,0,0,0.15);
}

/* Keep same blue on hover */
.myButtons:hover {
    background-color: #007bff;
}
</style>
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
<body>
<div id="search">
<table width="100%">

  <!-- ROW 1 -->
  <tr>
    <td class="label">Date</td>
    <td class="field">
        <div id="alwdate"
             name="alwdate"
             value='<s:property value="alwdate"/>'></div>

        <input type="hidden"
               name="hidalwdate"
               id="hidalwdate"
               value='<s:property value="hidalwdate"/>'>
    </td>

    <td class="label">Doc No</td>
    <td class="field">
        <input type="text"
               name="txtdocno"
               id="txtdocno"
               value='<s:property value="txtdocno"/>'>
    </td>

    <td class="label">Year</td>
    <td class="field">
        <select name="cmbalwyear" id="cmbalwyear"
                value='<s:property value="cmbalwyear"/>'>
            <option value="">--Select--</option>
        </select>
    </td>

    <td class="action" rowspan="2">
        <input type="button"
               name="btnsearch"
               id="btnsearch"
               class="myButton"
               value="Search"
               onclick="loadSearch();">
    </td>
  </tr>

  <!-- ROW 2 -->
  <tr>
    <td class="label">Month</td>
    <td class="field">
        <select name="cmbalwmonth" id="cmbalwmonth"
                value='<s:property value="cmbalwmonth"/>'>
            <option value="">--Select--</option>
        </select>
    </td>

    <td class="label">Description</td>
    <td class="field" colspan="3">
        <input type="text"
               name="txtalwdescription"
               id="txtalwdescription"
               value='<s:property value="txtalwdescription"/>'>
    </td>
  </tr>

  <!-- GRID -->
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