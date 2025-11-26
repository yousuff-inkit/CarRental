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
	 $("#roledate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var rolename=document.getElementById("txtuserrolename").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("roledate").value;
	
		getdata(rolename,docNo,date);
	}
	function getdata(rolename,docNo,date){
		 $("#refreshdiv").load('ubiMainSearchGrid.jsp?rolename='+encodeURIComponent(rolename)+'&docNo='+docNo+'&date='+date);
		}

	</script>
<body>
<div id="search" 
     style="padding:18px; background:#ffffff; border-radius:14px;
            box-shadow:0 3px 10px rgba(0,0,0,0.08); font-family:'Poppins',sans-serif;">

<table width="100%" style="border-collapse:separate; border-spacing:0 12px;">

  <!-- Row 1 -->
  <tr>
    <td width="12%" align="right" 
        style="font-weight:600; font-size:15px; color:#1A3E7A;">
        Date
    </td>

    <td width="20%">
      <div id="roledate" name="roledate"></div>
      <input type="hidden" id="hidroledate" name="hidroledate"
             value='<s:property value="hidroledate"/>'>
    </td>

    <td width="15%" align="right" 
        style="font-weight:600; font-size:15px; color:#1A3E7A;">
        Doc No
    </td>

    <td width="30%">
      <input type="text" id="txtdocno" name="txtdocno"
             value='<s:property value="txtdocno"/>'
             style="width:85%; padding:8px 10px; border-radius:8px;
                    border:1px solid #cfe0ff; background:#f9fbff; font-size:14px;">
    </td>

    <td width="23%" align="center">
      <button id="btnsearch" onclick="loadSearch()"
              style="padding:8px 22px; background:linear-gradient(90deg,#1E88E5,#1565C0);
              color:white; border:none; border-radius:25px; font-weight:600;
              cursor:pointer; box-shadow:0 3px 8px rgba(21,101,192,0.25);
              transition:0.3s;">
        Search
      </button>
    </td>
  </tr>

  <!-- Row 2 -->
  <tr>
    <td align="right" style="font-weight:600; font-size:15px; color:#1A3E7A;">
        Name
    </td>

    <td colspan="4">
      <input type="text" id="txtuserrolename" name="txtuserrolename"
             value='<s:property value="txtuserrolename"/>'
             style="width:98%; padding:8px 10px; border-radius:8px;
                    border:1px solid #cfe0ff; background:#f9fbff; font-size:14px;">
    </td>
  </tr>

  <!-- Grid -->
  <tr>
    <td colspan="5">
      <div id="refreshdiv"
           style="background:white; padding:12px; border-radius:10px;
           box-shadow:0 2px 8px rgba(0,0,0,0.05);">
        <jsp:include page="ubiMainSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>
</div>
</body>

</html>