<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
.tablereceipt {
    border: 1px solid rgb(139,136,120);
    border-collapse: collapse;
}
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 legend{
        border-style:none;
        background-color:#FFF;
        padding-left:1px;
    }
 hr { 
   border-top: 1px solid #e1e2df  ;
    } 

</style>

<script type="text/javascript">

	function hidedata(){
		
		var header=document.getElementById("txtheader").value;
		var first=document.getElementById("firstarray").value;
		var second=document.getElementById("secondarray").value;
		var third=document.getElementById("thirdarray").value;
		
		if(parseInt(header)==1){
		   $("#headerdiv").prop("hidden", false);
		   $("#withoutHeaderDiv").attr("hidden", true);
		}
		else{
			$("#headerdiv").prop("hidden", true);
			$("#withoutHeaderDiv").attr("hidden", false);
		}
		
		if(parseInt(first)==1){
			   $("#firstdiv").prop("hidden", true);
			}
		else{
			$("#firstdiv").prop("hidden", false);
			}
		
		if(parseInt(second)=="1"){
			   $("#vehiclediv").prop("hidden", false);
			}
		else{
			$("#vehiclediv").prop("hidden", true);
			}
		
		if(parseInt(third)=="1"){
			   $("#detaildiv").prop("hidden", false);
			}
		else{
			$("#detaildiv").prop("hidden", true);
			}
		
		}

</script>
</head>
<body bgcolor="white" style="font-size:10px;" onload="hidedata();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmContraTransVoucherPrint" action="contraTransVoucherPrint" method="post" autocomplete="off" target="_blank">

<div style="background-color:white;">
<div id="headerdiv" hidden="true" >
<jsp:include page="../../../common/printHeader.jsp"></jsp:include>
</div>
<div id="withoutHeaderDiv" hidden="true" style="height: 100px;" >
<br/><br/>
<center><b><font size="5"><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></font></b></center>
</div>

<fieldset>
<table width="100%">
  <tr>
    <td width="12%" align="left">Voucher Date </td>
    <td>: <label id="lbldate" name="lbldate" ><s:property value="lbldate"/></label></td>
    <td width="12%" align="left">Voucher No. </td>
    <td width="20%">: <label name="lblvoucherno" id="lblvoucherno" ><s:property value="lblvoucherno"/></label></td>
  </tr>
  <tr>
   <td align="left">Amount in words </td>
   <td>: <label id="lblnetamountwords" name="lblnetamountwords"><s:property value="lblnetamountwords"/></label></td>
   <td align="left">Amount </td>
   <td>: <label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></td>
  </tr>
</table>
</fieldset><br/>

<table width="100%">
<tr>
 <td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="22%">Paid To</td>
    <td width="78%">: <label id="lblpaidtoname" name="lblpaidtoname"><s:property value="lblpaidtoname"/></label></td>
  </tr>
  <tr>
    <td>Cheque No</td>
    <td>: <label id="lblchqno" name="lblchqno"><s:property value="lblchqno"/></label></td>
  </tr>
  <tr>
    <td>Cheque Date</td>
    <td>: <label id="lblchqdate" name="lblchqdate"><s:property value="lblchqdate"/></label></td>
  </tr>
</table>
<div id="firstdiv" hidden="true" >
<table width="100%">
  <tr>
    <td width="22%">Branch</td>
    <td width="78%">: <label id="lblinterbranch" name="lblinterbranch"><s:property value="lblinterbranch"/></label></td>
  </tr>
</table>
</div>
</fieldset>
</td>
 <td width="50%">
<fieldset>
<table width="100%">
  <tr>
    <td width="22%">Received From</td>
    <td width="78%">: <label id="lblreceivedname" name="lblreceivedname"><s:property value="lblreceivedname"/></label></td>
  </tr>
  <tr>
    <td>Description</td>
    <td>: <label id="lbldescription" name="lbldescription" ><s:property value="lbldescription"/></label></td>
  </tr>
</table><br/><br/>
</fieldset>
</td></tr></table><br/>

<div id="vehiclediv">
<table width="100%">
<tr>
 <td width="100%">
<fieldset>
<table width="100%">
  <tr>
   	<td width="8%">Vehicle Make</td>
    <td width="17%">: <label id="lblbrandname" name="lblbrandname"><s:property value="lblbrandname"/></label></td>
    <td width="8%">Model/year</td>
    <td width="17%">: <label id="lblmodelyear" name="lblmodelyear"><s:property value="lblmodelyear"/></label></td>
    <td width="8%">Chassis No</td>
    <td width="17%">: <label id="lblchasisno" name="lblchasisno"><s:property value="lblchasisno"/></label></td>
    <td width="8%">Color</td>
    <td width="17%">: <label id="lblcolor" name="lblcolor"><s:property value="lblcolor"/></label></td>
  </tr>
</table>
</fieldset>
</td>
</tr>
</table>
<br/>
</div>

<div id="detaildiv">
 <fieldset> 
<table style="border-collapse: collapse;" width="100%"  >
<tr height="25" style="background-color: #D8D8D8;border-collapse: collapse;">
	<td align="left" style="border-collapse: collapse;" width="5%"><b>Sl No</b></td>
	<td align="left" style="border-collapse: collapse;"><b>Description</b></td>
	<td align="left" style="border-collapse: collapse;" width="5%"><b>Qty</b></td>
	<td align="right" style="border-collapse: collapse;" width="7%"><b>Amount</b></td>
</tr>

<s:iterator var="stat" value='#request.details'>
<tr>   
<%int i=0; %>
  <s:iterator status="arr" value="#stat.split('::')" var="des">   
  <%if(i==3){%>
  <td  align="right" >
  <s:property value="#des"/>
  </td>
   <%} else{ %>
  <td  align="left" >
  <s:property value="#des"/>
  </td>
  <% } i++;  %>
 </s:iterator>
</tr>
</s:iterator>
</table>
</fieldset>
<br/>
</div>

<table width="100%" class="tablereceipt">
<tr>
<td width="60%">
<table width="100%">
  <tr>
    <td width="39%" align="left" height="25"><b>Prepared</b></td>
    <td width="35%" align="center"><b>Verified</b></td>
    <td width="26%" align="center"><b>Approved</b></td>
  </tr>
  <tr>
    <td><b>by</b>&nbsp;<label name="lblpreparedby" id="lblpreparedby" ><s:property value="lblpreparedby"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>on</b>&nbsp;<label name="lblpreparedon" id="lblpreparedon" ><s:property value="lblpreparedon"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><b>at</b>&nbsp;<label name="lblpreparedat" id="lblpreparedat" ><s:property value="lblpreparedat"/></label></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</td>

<td width="40%" class="tablereceipt">
<table width="100%">
  <tr>
    <td height="25" colspan="4"><b>Received By</b></td>
  </tr>
  <tr>
    <td width="5%"><b>Name</b></td>
    <td colspan="3">:<hr style="border:0;border-bottom: 1px dashed #ccc;" size=1 width="100%"></td>
  </tr>
  <tr>
    <td><b>Date</b></td>
    <td width="48%">:&nbsp;</td>
    <td width="5%"><b>Time</b></td>
    <td width="42%">:&nbsp;</td>
  </tr>
</table>
</td></tr>
</table><br/>

<table width="100%">
 <tr>
     <td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  </tr>
  <tr>
  <td width="47%" style="color: #D8D8D8;" align="left"><i>Printed by <%=session.getAttribute("USERNAME")%> 
  <label id="lblfooter"></label></i></td>
  
  <td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
  
 <td width="10%" style="color: #D8D8D8;">
    <div id="content"> 
  <div id="pageFooter"></div>
   </div>  
  </td>
  </tr>
</table>

<input type="hidden" id="firstarray" name="firstarray" value='<s:property value="firstarray"/>'>  
<input type="hidden" name="secondarray" id="secondarray"  value='<s:property value="secondarray"/>'>
<input type="hidden" name="thirdarray" id="thirdarray"  value='<s:property value="thirdarray"/>'>
<input type="hidden" id="txtheader" name="txtheader" value='<s:property value="txtheader"/>'>
<br/><br/><br/><br/>
</div>

</form>
</div>
</body>
</html>
