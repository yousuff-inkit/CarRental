 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();
 String masterdocno=request.getParameter("docno");
 %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link rel="stylesheet" href="../../../../css/body.css">
<script type="text/javascript">
$(document).ready(function(){

    
});
 
function funprintepic(){
	 var url=document.URL;
	 var reurl=url.split("saveRentalAgreement");
	 var rate=0;
	 if(document.getElementById("rdbhdrshow").checked){
		 rate=1;   
	 }
	 var win = window.open(reurl[0] + "printRA?docno=" + document.getElementById("masterdoc_no").value+ "&rate="+rate + "&formdetailcode=RAG", "_blank", "top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	 win.focus();   
}

</script>

<body>
 
<table>
   <tr>
  
  	<td align="right" width="50%"><input type="radio" id="rdbhdrshow" name="rdo" checked="checked">With rate</td>
    
    <td  align="left" width="50%"><input type="radio" id="rdbhdrhide" name="rdo" >Without rate
    </td> 
    <td width="21%" align="center"><button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funprintepic();">Print</button></td>
  </tr>
  
</table>   
 
</body>
</html>