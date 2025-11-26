<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../includes.jsp"></jsp:include>        
</head>

<sj:head/>

<!-- ==== PROFESSIONAL BLUE THEME (Matches Vendor Page) ==== -->
<style>

/* Page background */
body {
    background: #f4f7fc;
    margin: 0;
    padding: 20px 0;
    font-family: "Segoe UI", sans-serif;
}

/* Main container */
#mainBG {
    background: #ffffff;
    width: 90%;
    margin: auto;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.08);
}

/* Section */
fieldset {
    border: 2px solid #1f78d1;
    padding: 20px;
    border-radius: 8px;
}

legend {
    font-size: 1.2rem;
    font-weight: 600;
    color: #1f78d1;
    padding: 0 10px;
}

/* Uniform Inputs & Dropdowns */
input[type="text"],
select {
    width: 80%;
    height: 32px;
    padding: 6px 10px;
    font-size: 0.95rem;
    border: 1px solid #c9d3e0;
    border-radius: 6px;
    box-sizing: border-box;
    background: #ffffff;
}

input[type="text"]:focus,
select:focus {
    border-color: #1f78d1;
    box-shadow: 0 0 6px rgba(31,120,209,0.35);
    outline: none;
}

/* Table spacing */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 12px 15px;
}

td {
    vertical-align: middle;
    font-size: 0.95rem;
}

td div {
    font-weight: 500;
    color: #333;
}

/* Datepicker same size */
#costCenterDate {
    width: 80% !important;
}

/* Buttons */
.btn {
    padding: 10px 22px;
    border: none;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    margin: 0 8px;
    color: #fff;
    box-shadow: 0 3px 8px rgba(0,0,0,0.15);
}

.btn-save { background:#1f78d1; }
.btn-save:hover { background:#1661ad; }

.btn-search { background:#27ae60; }
.btn-search:hover { background:#1e8f4d; }

.btn-clear { background:#e74c3c; }
.btn-clear:hover { background:#c0392b; }

</style>

<body>

<div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../header.jsp"></jsp:include><br/>

<!-- ======================= COST CENTRE UI ======================= -->
<div style="width:80%; margin:auto;">
    <fieldset>
    <legend>Cost Centre Master</legend>

<table>
  <!-- Row 1 -->
  <tr>
    <td width="15%"><div align="right">Date</div></td>
    <td colspan="2">
      <sj:datepicker value="today" id="costCenterDate" name="costCenterDate" displayFormat="dd.mm.yy"/>
    </td>

    <td width="15%"><div align="right">Doc No.</div></td>
    <td width="20%">
      <input type="text" name="docno" readonly>
    </td>
  </tr>

  <!-- Row 2 -->
  <tr>
    <td><div align="right">Cost Group</div></td>
    <td width="20%">
      <select name="cost_group">
        <option>--Select--</option>
      </select>
    </td>
    <td colspan="3">
      <input type="text" name="cost_group_name">
    </td>
  </tr>

  <!-- Row 3 -->
  <tr>
    <td><div align="right">Cost Division</div></td>
    <td>
      <select name="cost_division">
        <option>--Select--</option>
      </select>
    </td>
    <td colspan="3">
      <input type="text" name="cost_division_name">
    </td>
  </tr>

  <!-- Row 4 -->
  <tr>
    <td><div align="right">Cost Centre</div></td>
    <td>
      <select name="cost_centre">
        <option>--Select--</option>
      </select>
    </td>
    <td colspan="3">
      <input type="text" name="cost_centre_name">
    </td>
  </tr>

  <!-- Row 5 -->
  <tr>
    <td><div align="right">Type</div></td>
    <td colspan="2">
      <select name="type">
        <option>--Select--</option>
      </select>
    </td>

    <td><div align="right">CE Relation</div></td>
    <td>
      <select name="ce_relation">
        <option>--Select--</option>
      </select>
    </td>
  </tr>

</table>

<!-- ===== BUTTONS ===== -->
<div style="text-align:center; margin-top:25px;">
    <button type="submit" class="btn btn-save">Save</button>

    <button type="button" class="btn btn-search"
            onclick="window.location.href='costCenterSearch.jsp';">
        Search
    </button>

    <button type="reset" class="btn btn-clear">Clear</button>
</div>

</fieldset>
</div>

</div>
</body>
</html>
