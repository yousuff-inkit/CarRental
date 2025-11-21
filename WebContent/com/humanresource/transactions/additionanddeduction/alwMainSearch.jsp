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

<!-- Minimal visual improvements only — DO NOT change IDs/names/JS logic -->
<style>
/* === keep behavior, improve look === */

/* container look */
#search{
  background: #ffffff;
  border: 1px solid #d7e3ff;
  border-radius: 12px;
  padding: 12px 14px;
  box-shadow: 0 6px 18px rgba(80,120,255,0.12);
  font-family: "Segoe UI", Tahoma, Arial, sans-serif;
}

/* table labels */
#search table td {
  font-size: 13px;
  color: #2f3f86;
  vertical-align: middle;
  font-weight: 600;
}

/* inputs and selects — keep 95% width as original but nicer */
#search input[type="text"],
#search select,
#search input[type="hidden"] {
  width: 95% !important;
  height: 36px !important;
  padding: 6px 10px !important;
  font-size: 13px !important;
  border: 1px solid #c4d3ff !important;
  border-radius: 8px !important;
  background: #fff !important;
  color: #001a4d !important;
  box-shadow: 0 2px 6px rgba(130,150,240,0.08) !important;
  box-sizing: border-box;
}

/* date jqx container (if jqx wraps an input) */
#alwdate {
  width: 110px;
  height: 36px;
}

/* focus styling */
#search input:focus,
#search select:focus {
  outline: none !important;
  border-color: #5a8aff !important;
  box-shadow: 0 0 6px rgba(90,140,255,0.22) !important;
  background: #fff !important;
}

/* search button */
.myButton {
  background: linear-gradient(90deg,#6fb1fc,#1a73e8);
  border: none;
  color: white;
  padding: 8px 20px;
  font-size: 14px;
  font-weight: 600;
  border-radius: 8px;
  cursor: pointer;
  box-shadow: 0 4px 12px rgba(26,115,232,0.25);
}
.myButton:hover { transform: translateY(-2px); }

/* small responsive tweak for small containers */
@media (max-width: 900px) {
  #search table td { font-size: 12px; }
  #search input[type="text"], #search select { height: 34px !important; }
}

/* =========================================================
   CRITICAL: prevent jqx modal from clipping dropdown lists
   (only visual/css changes — does not touch JS/data)
   ========================================================= */

/* allow dropdowns to overflow the window container */
.jqx-window, .jqx-window-content, .jqx-window .jqx-window-content {
  overflow: visible !important;
}

/* ensure jqx dropdown and listbox float above modal */
.jqx-drop-down-list,
.jqx-listbox,
.jqx-listitem-element,
.jqx-item,
.jqx-dropdownlist-content,
.jqx-listbox-outer {
  z-index: 999999 !important;
  background: #fff !important;
  color: #000 !important;
  box-shadow: 0 6px 20px rgba(0,0,0,0.12) !important;
}

/* normalize dropdown input appearance inside jqx */
.jqx-dropdownlist-input,
.jqx-dropdownlist-state-normal,
.jqx-dropdownlist-container,
select.jqx-input {
  height: 36px !important;
  padding: 6px 10px !important;
  border-radius: 8px !important;
  border: 1px solid #c4d3ff !important;
  background: #fff !important;
  color: #001a4d !important;
}

/* list hover/selected */
.jqx-listitem-state-hover { background: #e8f0ff !important; color: #002060 !important; }
.jqx-listitem-state-selected { background: #6a96ff !important; color: #fff !important; }

/* reset any aggressive global rules that might hide selects inside popup */
.jqx-window select,
.jqx-window option {
  display: block !important;
  visibility: visible !important;
}

/* end css */
</style>

<script type="text/javascript">
$(document).ready(function () {
    // keep the original widths and behavior
    $("#alwdate").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy", value:null});
    getAlwYear();
    getAlwMonth();
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
                optionsyear += '<option value="' + yearIdItems[i] + '">' + yearItems[i] + '</option>';
            }
            $("select#cmbalwyear").html(optionsyear);
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
                optionsmonth += '<option value="' + monthIdItems[i] + '">' + monthItems[i] + '</option>';
            }
            $("select#cmbalwmonth").html(optionsmonth);
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
    var branch=document.getElementById("brchName") ? document.getElementById("brchName").value : "";
    getdata(date,docNo,year,month,description, employeebranchchk, branch);
}

function getdata(date,docNo,year,month,description, employeebranchchk, branch){
    $("#refreshdiv").load('alwMainSearchGrid.jsp?date='+date+'&docNo='+docNo+'&year='+year+'&month='+month+'&description='+description.replace(/ /g, "%20")+'&branch='+branch+'&employeebranchchk='+employeebranchchk);
}
</script>
</head>

<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="15%"><div id="alwdate" name="alwdate"  value='<s:property value="alwdate"/>'></div>
        <input type="hidden" name="hidalwdate" id="hidalwdate" value='<s:property value="hidalwdate"/>'></td>
    <td width="9%" align="right">Doc No</td>
    <td width="12%"><input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'></td>
    <td width="10%" align="right">Year</td>
    <td width="29%"><select id="cmbalwyear" name="cmbalwyear" style="width:50%;" value='<s:property value="cmbalwyear"/>'>
    <option value="">--Select--</option></select></td>
    <td width="20%" rowspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Month</td>
    <td><select id="cmbalwmonth" name="cmbalwmonth" style="width:98%;"  value='<s:property value="cmbalwmonth"/>'>
      <option value="">--Select--</option></select></td>
    <td align="right">Description</td>
    <td colspan="3"><input type="text" name="txtalwdescription" id="txtalwdescription" style="width:80%;" value='<s:property value="txtalwdescription"/>'></td>
  </tr>
  <tr>
    <td colspan="7"><div id="refreshdiv"><jsp:include page="alwMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>
