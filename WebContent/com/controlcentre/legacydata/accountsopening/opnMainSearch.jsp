<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* 🔹 Bigger premium labels */
.search-label {
    font-size: 16px;
    font-weight: 600;
    color: #174A8C;      /* Premium deep blue */
}

/* 🔹 Input style consistent */
.search-input {
    width: 90%;
    padding: 8px 10px;
    border: 1px solid #cfe0ff;
    background: #f9fbff;
    border-radius: 6px;
    font-size: 15px;
}

/* For A/c Name (wider) */
.search-input-wide {
    width: 95%;
}

/* 🔹 Premium Search button */
.search-btn {
    padding: 9px 24px;
    background: linear-gradient(90deg,#1E88E5,#1565C0);
    color: white;
    border: none;
    border-radius: 25px;
    font-weight: 600;
    cursor: pointer;
    box-shadow: 0 3px 8px rgba(21,101,192,0.25);
    transition: 0.3s ease;
}
.search-btn:hover {
    background: linear-gradient(90deg,#42A5F5,#1E88E5);
    transform: translateY(-2px);
}
</style>

<script type="text/javascript">
function loadSearch() {
    var accountNo = document.getElementById("txtaccountno").value;
    var accountName = document.getElementById("txtaccountname").value;
    var total = document.getElementById("txttotal").value;

    getdata(accountNo,accountName,total);
}

function getdata(accountNo,accountName,total){
    $("#refreshdiv").load('opnMainSearchGrid.jsp?accountNo='+accountNo+'&accountName='+accountName.replace(/ /g,"%20")+'&total='+total);
}
</script>

<body>

<div id="search" 
     style="padding:18px; background:#ffffff; border-radius:14px;
     box-shadow:0 3px 10px rgba(0,0,0,0.08); font-family:'Poppins',sans-serif;">

<table width="100%" style="border-collapse:separate; border-spacing:0 12px;">

  <!-- Row 1 -->
  <tr>
   <td align="right" style="font-weight:600; color:#1A3E7A; font-size:16px;">A/c No</td>
   
    <td width="35%">
      <input type="text" id="txtaccountno" name="txtaccountno"
             value='<s:property value="txtaccountno"/>'
             style="width:95%; padding:8px 10px; border:1px solid #cfe0ff;
             background:#f9fbff; border-radius:6px; font-size:15px;">
    </td>

    <td align="right" style="font-weight:600; color:#1A3E7A; font-size:16px;">Balance</td>
    
    <td width="35%">
      <input type="text" id="txttotal" name="txttotal"
             value='<s:property value="txttotal"/>'
             style="width:95%; padding:8px 10px; border:1px solid #cfe0ff;
             background:#f9fbff; border-radius:6px; font-size:15px;">
    </td>
  </tr>

  <!-- Row 2 -->
  <tr>
   <td align="right" style="font-weight:600; color:#1A3E7A; font-size:16px;">A/c Name</td>
   
    <td colspan="2">
      <input type="text" id="txtaccountname" name="txtaccountname"
             value='<s:property value="txtaccountname"/>'
             style="width:97%; padding:8px 10px; border:1px solid #cfe0ff;
             background:#f9fbff; border-radius:6px; font-size:15px;">
    </td>

    <td align="center">
      <button onclick="loadSearch()"
              style="padding:10px 28px; background:linear-gradient(90deg,#1E88E5,#1565C0);
              color:white; border:none; border-radius:25px; font-weight:600;
              cursor:pointer; box-shadow:0 3px 8px rgba(21,101,192,0.25);
              transition:0.3s ease;">
        Search
      </button>
    </td>
  </tr>

  <!-- Grid -->
  <tr>
    <td colspan="4">
      <div id="refreshdiv"
           style="background:white; padding:12px; border-radius:10px;
           box-shadow:0 2px 8px rgba(0,0,0,0.05);">
        <jsp:include page="opnMainSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>
</div>


</body>
</html>
