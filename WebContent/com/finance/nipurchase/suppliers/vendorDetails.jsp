<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>

body {
    background: #f2f6ff;
    font-family: 'Segoe UI', Arial, sans-serif;
    padding: 30px 0;
}

#mainBG {
    width: 95%;
    background: #ffffff;
    margin: auto;
    padding: 25px;
    border-radius: 14px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
}

.page-heading {
    text-align: center;
    font-size: 22px;
    font-weight: bold;
    color: #1d3f80;
    margin-bottom: 20px;
}

.section-title {
    font-size: 16px;
    font-weight: 600;
    color: #1d3f80;
    margin-top: 20px;
    margin-bottom: 6px;
}

.section-line {
    width: 100%;
    height: 2px;
    background: #1d84e9;
    margin-bottom: 15px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
}

.cr-table td {
    padding: 8px 10px;
}

input[type="text"],
input[type="email"],
input[type="date"],
select {
    width: 85%;
    padding: 6px 10px;
    border: 1px solid #c5d7f2;
    border-radius: 6px;
    background: #fff;
    font-size: 14px;
    height: 32px;
}

.action-btn,
.myButton,
button[type="button"] {
    background: #e6e9f2;
    border: none;
    padding: 6px 18px;
    border-radius: 15px;
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    color: #2a2a2a;
}

.action-btn:hover {
    background: #d7d9e0;
}

.btn-small {
    background: #1e6ed8;
    color: #fff;
    border: none;
    padding: 6px 20px;
    border-radius: 6px;
    font-size: 14px;
    cursor: pointer;
}

.btn-small:hover {
    background: #155db5;
}

</style>

</head>

<body onload="setValues();">

<h1 class="page-heading">Vendor Details</h1>

<div id="mainBG">

<form id="frmVendorDetails" method="post" action="saveVendorDetails">

<jsp:include page="../../../../header.jsp"></jsp:include>

<h3 class="section-title">Account Details</h3>
<div class="section-line"></div>

<table class="cr-table">
<tr>
    <td align="right">Date</td>
    <td><input type="date" id="txtVendorDate" name="txtVendorDate"></td>

    <td align="right">Code</td>
    <td><input type="text" id="txtcode" name="txtcode"
        value='<s:property value="txtcode"/>'></td>

    <td align="right">Name</td>
    <td><input type="text" id="txtvendorname" name="txtvendorname"
        value='<s:property value="txtvendorname"/>'></td>
</tr>

<tr>
    <td align="right">Currency</td>
    <td><select id="cmbcurrency" name="cmbcurrency"></select></td>

    <td align="right">Category</td>
    <td><select id="cmbcategory" name="cmbcategory"
    onchange="getCategoryAccountGroup(this.value);"></select></td>

    <td align="right">Type</td>
    <td><select id="cmbtype" name="cmbtype"></select></td>
</tr>
</table>

<h3 class="section-title">Contact Details</h3>
<div class="section-line"></div>

<table class="cr-table">
<tr>
    <td align="right">Address</td>
    <td><input type="text" id="txtaddress" name="txtaddress"
        value='<s:property value="txtaddress"/>'></td>

    <td align="right">Email</td>
    <td><input type="email" id="txtemail" name="txtemail"
        value='<s:property value="txtemail"/>'></td>
</tr>

<tr>
    <td align="right">Mobile</td>
    <td><input type="text" id="txtmob" name="txtmob"
        value='<s:property value="txtmob"/>' 
        onblur="getMobileNoAlreadyExists(this.value,$('#docno').val(),$('#mode').val());"></td>

    <td align="right">Contact Person</td>
    <td><input type="text" id="txtcontact" name="txtcontact"
        value='<s:property value="txtcontact"/>'></td>
</tr>
</table>

<div style="text-align:center; margin-top:20px;">
    <button class="btn-small" type="submit">Save</button>
    <button class="btn-small" type="button" onclick="funSearchLoad()">Search</button>
    <button class="btn-small" type="reset">Clear</button>
</div>

</form>

</div>
</body>
</html>
