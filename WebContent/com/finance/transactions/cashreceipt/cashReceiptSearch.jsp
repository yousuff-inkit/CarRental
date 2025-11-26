<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style>
    /* ===== Search UI Styling (Updated) ===== */

    #search {
        background: #ffffff;
        padding: 20px;
        border-radius: 14px;
        box-shadow: 0 4px 16px rgba(90,120,255,0.15);
        font-size: 1rem; /* Increased font size */
        color: #000000; /* All text black */
    }

    #search input[type="text"] {
        width: 90%;
        padding: 8px 10px;
        border-radius: 6px;
        border: 1px solid #b0c4ff;
        background: #f8fbff;
        font-size: 1rem;  /* Bigger font */
        color: #000000;
    }

    #search td {
        padding: 6px 8px;
        font-size: 1rem;
        color: black;
    }

    .myButton {
        background: linear-gradient(90deg, #3b82f6, #1e3a8a);
        color: #fff;
        border-radius: 8px;
        padding: 10px 24px;
        font-size: 1rem;
        cursor: pointer;
        border: none;
        box-shadow: 0 3px 10px rgba(30, 58, 138, 0.2);
    }

    .myButton:hover {
        background: linear-gradient(90deg, #1d4ed8, #1e3a8a);
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        var atype='<%=request.getParameter("atype")==null?"0":request.getParameter("atype")%>';
        document.getElementById("txttypes").value=atype;
        document.getElementById("txtnewmaindate").value=$('#maindate').val();
    });

    function loadAccountSearchGrid() {

        var accountsno=document.getElementById("txtacctno").value;
        var accountsname=document.getElementById("txtacctname").value;
        var currs=document.getElementById("txtacctcurrency").value;
        var type=document.getElementById("txttypes").value;
        var date=document.getElementById("txtnewmaindate").value;
        var check = 1;

        $("#refreshAccountSearchDetailsDiv")
            .load("cashReceiptSearchGrid.jsp?accountno="+accountsno
                +'&accountname='+accountsname.replace(/ /g,"%20")
                +'&currency='+currs
                +'&atype='+type
                +'&date='+date
                +'&check='+check);
    }
</script>

</head>
<body>

<div id="search">
<table width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="30%">
        <input type="text" name="txtacctno" id="txtacctno" 
               value='<s:property value="txtacctno"/>'>
    </td>

    <td width="10%" align="right">Currency</td>
    <td width="27%">
        <input type="text" name="txtacctcurrency" id="txtacctcurrency" 
               value='<s:property value="txtacctcurrency"/>'>

        <input type="hidden" name="txttypes" id="txttypes"
               value='<s:property value="txttypes"/>'>

        <input type="hidden" name="txtnewmaindate" id="txtnewmaindate"
               value='<s:property value="txtnewmaindate"/>'>
    </td>

    <td width="23%" rowspan="2" align="center">
        <input type="button" name="btnAccountSearch" id="btnAccountSearch"
               class="myButton" value="Search" onclick="loadAccountSearchGrid();">
    </td>
  </tr>

  <tr>
    <td align="right">Account Name</td>
    <td colspan="3">
        <input type="text" name="txtacctname" id="txtacctname"
               value='<s:property value="txtacctname"/>'>
    </td>
  </tr>

  <tr>
    <td colspan="5">
        <div id="refreshAccountSearchDetailsDiv">
            <jsp:include page="cashReceiptSearchGrid.jsp"></jsp:include>
        </div>
    </td>
  </tr>
</table>
</div>

</body>
</html>
