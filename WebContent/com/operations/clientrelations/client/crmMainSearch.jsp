<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
#txtdob {
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
 $("#txtdob").jqxDateTimeInput({ width: '110px', height: '34px', formatString:"dd.MM.yyyy", value:null});
}); 

function loadSearch() {
    var clientid=document.getElementById("txtclientid").value;
    var clname=document.getElementById("txtclientname").value;
    var clientaccount=document.getElementById("txtclientsaccount").value;
    var mob=document.getElementById("txtmobile").value;
    var lcno=document.getElementById("txtlicence").value;
    var driverid=document.getElementById("txtdriveridsearch").value;
    var nation=document.getElementById("txtnation").value;
    var dob=document.getElementById("txtdob").value;
    var check = 1;
    getdata(clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check);
}

function getdata(clname,mob,lcno,clientid,driverid,nation,dob,clientaccount,check){    
    $("#refreshdiv").load('crmMainSearchGrid.jsp?clname='+clname.replace(/ /g, "%20")+'&mob='+mob+'&lcno='+lcno+'&clientid='+clientid+'&driverid='+driverid.replace(/ /g, "%20")+'&nation='+nation.replace(/ /g, "%20")+'&dob='+dob+'&clientaccount='+clientaccount+'&check='+check);
}
</script>
</head>
<body>
<div id="search">
<table width="100%">
  <tr>
    <td width="6%" align="right">Client#</td>
    <td><input type="text" name="txtclientid" id="txtclientid" value='<s:property value="txtclientid"/>'></td>
    <td width="4%" align="right">Name</td>
    <td colspan="3"><input type="text" name="txtclientname" id="txtclientname" value='<s:property value="txtclientname"/>'></td>
    <td align="right">Account</td>
    <td><input type="text" name="txtclientsaccount" id="txtclientsaccount" value='<s:property value="txtclientsaccount"/>'></td>
    <td colspan="2" align="center"><input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();"></td>
  </tr>
  <tr>
    <td align="right">Licence#</td>
    <td width="15%"><input type="text" name="txtlicence" id="txtlicence" value='<s:property value="txtlicence"/>'></td>
    <td width="4%" align="right">Mob</td>
    <td width="17%"><input type="text" name="txtmobile" id="txtmobile" value='<s:property value="txtmobile"/>'></td>
    <td width="5%" align="right">ID#</td>
    <td width="14%"><input type="text" name="txtdriveridsearch" id="txtdriveridsearch" value='<s:property value="txtdriveridsearch"/>'></td>
    <td width="8%" align="right">Nationality</td>
    <td width="14%"><input type="text" id="txtnation" name="txtnation" value='<s:property value="txtnation"/>'></td>
    <td width="6%" align="right">DOB</td>
    <td width="11%"><div id="txtdob" name="txtdob" value='<s:property value="txtdob"/>'></div>
        <input type="hidden" name="hidtxtdob" id="hidtxtdob" value='<s:property value="hidtxtdob"/>'></td>
  </tr>
  <tr>
    <td colspan="10"><div id="refreshdiv"><jsp:include page="crmMainSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</body>
</html>
