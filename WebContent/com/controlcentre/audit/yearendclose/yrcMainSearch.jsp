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
	 $("#yrcdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#yrcAccFrmDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	 $("#yrcAccToDate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("yrcdate").value;
 		var yrcAccFrmDate=document.getElementById("yrcAccFrmDate").value;
 		var yrcAccToDate=document.getElementById("yrcAccToDate").value;
	
		getdata(docNo,date,yrcAccFrmDate,yrcAccToDate);
	}
	function getdata(docNo,date,yrcAccFrmDate,yrcAccToDate){
		 $("#refreshdiv").load('yrcMainSearchGrid.jsp?docNo='+docNo+'&date='+date+'&yrcAccFrmDate='+yrcAccFrmDate+'&yrcAccToDate='+yrcAccToDate);
		}

	</script>
<body>
<div id="search"
     style="padding:20px; background:#ffffff; border-radius:14px;
     box-shadow:0 4px 12px rgba(0,0,0,0.08); 
     font-family:'Poppins',sans-serif;">

<table width="100%" 
       style="border-collapse:separate; border-spacing:0 14px;">

  <!-- Row 1 -->
  <tr>
    <td width="15%" align="right"
        style="font-size:15px; font-weight:600; color:#1A3E7A;">
      Date
    </td>

    <td width="22%">
      <div id="yrcdate"
           style="padding:6px; border-radius:6px; background:#f9fbff; 
                  border:1px solid #cfe0ff;">
      </div>
      <input type="hidden" id="hidyrcdate" name="hidyrcdate">
    </td>

    <td width="16%" align="right"
        style="font-size:15px; font-weight:600; color:#1A3E7A;">
      Doc No
    </td>

    <td width="28%">
      <input type="text" id="txtdocno" name="txtdocno"
             value='<s:property value="txtdocno"/>'
             style="width:88%; padding:8px 12px; border:1px solid #cfe0ff;
             background:#f9fbff; border-radius:6px; font-size:14px;">
    </td>

    <td width="19%" rowspan="2" align="center">
      <button id="btnsearch" onclick="loadSearch()"
              style="padding:10px 26px; background:linear-gradient(90deg,#1E88E5,#1565C0);
              color:white; border:none; border-radius:28px; font-size:15px;
              font-weight:600; cursor:pointer; 
              box-shadow:0 3px 8px rgba(21,101,192,0.28); 
              transition:0.25s ease;">
        Search
      </button>
    </td>
  </tr>

  <!-- Row 2 -->
  <tr>
    <td align="right"
        style="font-size:15px; font-weight:600; color:#1A3E7A;">
      Accounting Year From
    </td>

    <td>
      <div id="yrcAccFrmDate"
           style="padding:6px; border-radius:6px; background:#f9fbff;
                  border:1px solid #cfe0ff;">
      </div>
      <input type="hidden" id="hidyrcAccFrmDate" name="hidyrcAccFrmDate">
    </td>

    <td align="right"
        style="font-size:15px; font-weight:600; color:#1A3E7A;">
      Accounting Year To
    </td>

    <td>
      <div id="yrcAccToDate"
           style="padding:6px; border-radius:6px; background:#f9fbff;
                  border:1px solid #cfe0ff;">
      </div>
      <input type="hidden" id="hidyrcAccToDate" name="hidyrcAccToDate">
    </td>
  </tr>

  <!-- Grid Section -->
  <tr>
    <td colspan="5">
      <div id="refreshdiv"
           style="background:white; padding:14px; border-radius:10px;
           box-shadow:0 2px 8px rgba(0,0,0,0.05);">
        <jsp:include page="yrcMainSearchGrid.jsp"></jsp:include>
      </div>
    </td>
  </tr>

</table>
</div>

</body>
</html>