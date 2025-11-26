<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
#search {
    background: #ffffff;
    border-radius: 14px;
    border: 1px solid #dce6ff;
    box-shadow: 0px 10px 30px rgba(93,125,255,0.14);
    padding: 14px 18px;
    box-sizing: border-box;
}

#search table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 12px 8px;
    background: transparent;
}

#search td {
    font-family: "Poppins", Arial, sans-serif;
    font-size: 0.92rem;
    color: #263b75;
    vertical-align: middle;
    padding: 6px;
}

#search input[type="text"] {
    width: 95%;
    height: 34px;
    padding: 6px 10px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    background: #ffffff;
    box-shadow: 0 2px 6px rgba(150,175,255,0.20);
    font-size: 0.92rem;
    box-sizing: border-box;
    transition: border-color 0.15s ease, box-shadow 0.15s ease, transform 0.12s ease;
}

#search input[type="text"]:focus,
#search input[type="text"].-webkit-autofill {
    outline: none;
    border-color: #6a96ff;
    -webkit-box-shadow: 0 0 0 1000px white inset;
    box-shadow: 0 0 0 1000px white inset;
}

#refunddate {
    width: 110px;
    height: 34px;
    padding: 6px 10px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    background: #ffffff;
    box-shadow: 0 2px 6px rgba(150,175,255,0.12);
    box-sizing: border-box;
    display: inline-block;
}

#hidrefunddate {
    display: none;
}

.myButton {
    display: inline-block;
    background: linear-gradient(90deg,#6fb1fc,#1a73e8);
    color: #ffffff;
    height: 34px;
    line-height: 34px;
    padding: 0 18px;
    font-size: 0.92rem;
    font-weight: 600;
    border: none;
    border-radius: 10px;
    cursor: pointer;
    box-shadow: 0 4px 12px rgba(26,115,232,0.30);
    transition: transform 0.14s ease, box-shadow 0.14s ease;
}

.myButton:hover {
    transform: translateY(-2px);
}

#refreshdiv {
    margin-top: 10px;
    padding-top: 12px;
    background: #f4f7ff;
    border-top: 1px solid #e3eaff;
    border-radius: 8px;
}

@media(max-width:720px) {
    #search table, #search td, #search input[type="text"] {
        width: 100% !important;
        display: block;
    }
    #search td[align="right"] {
        text-align: left !important;
    }
    #search td[colspan] input[type="text"] {
        width: 100% !important;
    }
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#refunddate").jqxDateTimeInput({ width: '110px', height: '34px', formatString:"dd.MM.yyyy", value:null});
});

function loadSearch() {
    var accountName = document.getElementById("txtaccountname").value;
    var srNo = document.getElementById("txtdocumentsrno").value;
    var date = document.getElementById("refunddate").value;
    var total = document.getElementById("txtamounttotal").value;
    var refNo = document.getElementById("txtreferenceno").value;
    getdata(accountName, srNo, date, total, refNo);
}

function getdata(accountName, srNo, date, total, refNo){
    $("#refreshdiv").load('rrpMainSearchGrid.jsp?accountName=' + accountName.replace(/ /g, "%20") + '&srNo=' + srNo + '&date=' + date + '&total=' + total + '&refNo=' + refNo);
}
</script>
</head>

<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="7%" align="right">RR No</td>
    <td width="19%"><input type="text" name="txtdocumentsrno" id="txtdocumentsrno" autocomplete="off" value='<s:property value="txtdocumentsrno"/>'></td>
    <td width="10%" align="right">A/C Name</td>
    <td colspan="3"><input type="text" name="txtaccountname" id="txtaccountname" autocomplete="off" style="width:80%" value='<s:property value="txtaccountname"/>'></td>
    <td width="13%" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search"  onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Date</td>
    <td>
        <div id="refunddate" name="refunddate" value='<s:property value="refunddate"/>'></div>
        <input type="hidden" name="hidrefunddate" id="hidrefunddate" value='<s:property value="hidrefunddate"/>'>
    </td>
    <td align="right">Total</td>
    <td width="23%"><input type="text" name="txtamounttotal" id="txtamounttotal" autocomplete="off" value='<s:property value="txtamounttotal"/>'></td>
    <td width="6%" align="right">Ref. No</td>
    <td colspan="2"><input type="text" id="txtreferenceno" name="txtreferenceno" autocomplete="off" value='<s:property value="txtreferenceno"/>'></td>
  </tr>
  <tr>
    <td colspan="7">
        <div id="refreshdiv">
            <jsp:include page="rrpMainSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>
</body>
</html>
