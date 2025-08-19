<%@page import="javax.servlet.http.HttpSession.*"%>
<%@page import="javax.servlet.http.HttpServletRequest.*"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
<!-- <link href="https://fonts.googleapis.com/css?family=Mada:700" rel="stylesheet"> -->
<!-- media="print" -->
<style>
body{
	background-color:#fff !important;
}
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);
}
.saliktable{
 border:1px solid;
 border-collapse:collapse;
 }
table:last-of-type {
    page-break-after: auto
}
#pageFooter {
    display: table-footer-group;
}
#pageFooter:after {
      counter-increment: page;
      counter-reset: pages 1;
      content: "Page " counter(page) " / " counter(pages);
}
/* h1{
font-family: 'Mada', sans-serif;
} */
</style> 
<script>
$(document).ready(function () {
	
});
function getPrint(){
	/* //alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit();  */
	
	
}
</script>
</head>
<body onload="" style="font-size:12px">
	<!--<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmLimoInvoicePrint" action="printLimoInvoice" autocomplete="off" target="_blank">
 			<jsp:include page="../../common/printHeader.jsp"></jsp:include> 
			
		</form>
	</div>-->
	<%-- <table style="width:100%;">
		<tr>
			<td><jsp:include page="../../common/printHeader.jsp"></jsp:include></td>
		</tr>
	</table> --%>
	<form id="frmLimoInvoicePrint" action="printLimoInvoice" autocomplete="off" target="_blank">
	<input type="hidden" name="lblhidheader" id="lblhidheader" value="1">
	<!-- <div style="margin-top:150px;"></div> -->
	<%-- <table style="width:100%;">
		<tr>
			<td><jsp:include page="../../common/printHeader.jsp"></jsp:include></td>
		</tr>
	</table> --%>
	<div class="commonheader">
		<jsp:include page="../../common/printCAMHeader.jsp"></jsp:include> <br/> 
	</div>
 <div style="background-color:white;">
<%--  <jsp:include page="../../../common/printDrivenHeader.jsp"></jsp:include> --%>
<div class="invheader" style="display:none;">
<table width="100%" class="normaltable">
  <tr>
  <td align="center" colspan="2" class="complogo"><%-- <img src="<%=contextPath%>/icons/epic.jpg" width="100%" height="91"  alt=""/> --%></td>
  </tr>
  <tr>
  <td align="center" colspan="4"><font size="6"><b><label id="lblprintname" name="lblprintname"><s:property value="lblprintname"/></label></b></font></td>
  </tr>
  
  <tr>
  	<td width="7%" align="left">Location </td>
  	<td width="59%" align="left"><label id="lbllocation" name="lbllocation" >: <s:property value="lbllocation"/></label></td>
 	<td width="7%" align="left"> <b>TRN</b></td>
  	<td width="27%" align="left"><b>: <label id="lblcomptrn" name="lblcomptrn" >
  	<s:property value="lblcomptrn"/> 
  	</label></b></td>
  </tr>
  
  <tr>
  	<td align="left">Branch </td>
  	<td colspan="3" align="left"><label id="lblbranch" name="lblbranch" >: <s:property value="lblbranch"/></label></td>
  </tr>
  </table>
  </div>
	<%-- <h1 style="text-align:center;"><s:property value="lblprintname"/></h1> --%>
    <fieldset>
		<table width="100%" border="0">
              <tr>
                <td width="11%">Client</td>
                <td colspan="3">:&nbsp;<label name="lblclient" id="lblclient"><s:property value="lblclient"/></label>
                </td>
                <td width="17%">Invoice</td>
                <td width="17%">:&nbsp;<label name="lblvocno" id="lblvocno"><s:property value="lblvocno"/></label></td>
              </tr>
              <tr>
                <td width="11%">Code</td>
                <td colspan="3">:&nbsp;<label name="lblcode" id="lblcode"><s:property value="lblcldocno"/></label></td>
				<td>Date</td>
                <td>:&nbsp;<label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></td>
				
              </tr>
              <tr>
                <td width="11%">Address</td>
                <td colspan="3">:&nbsp;<label name="lbladdress" id="lbladdress"><s:property value="lbladdress"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">&nbsp;</td>
                <td colspan="3">:&nbsp;<label name="lbladdressother" id="lbladdressother"><s:property value="lbladdressother"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">Mobile No</td>
                <td colspan="3">:&nbsp;<label name="lblmobileno" id="lblmobileno"><s:property value="lblmobileno"/></label>
                </td>
              </tr>
              <tr>
                <td width="11%">Mail</td>
                <td colspan="3">:&nbsp;<label name="lblmail" id="lblmail"><s:property value="lblmail"/></label>
                <td>Event</td>
                <td>:&nbsp;<label name="lblevent" id="lblevent"><s:property value="lblevent"/></label></td>
                </td>
              </tr>
              <%-- <tr>
                <td>Details</td>
                <td colspan="3">:&nbsp;<label name="lbldetails" id="lbldetails"><s:property value="lbldetails"/></label></td>
              </tr> --%>
              <tr>
                <td>From Date</td>
                <td width="21%">:&nbsp;<label name="lblfromdate" id="lblfromdate"><s:property value="lblfromdate"/></label></td>
                <td width="17%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
                <td>LPO No</td>
                <td>:&nbsp;<label name="lbllpo" id="lbllpo"><s:property value="lbllpo"/></label></td>
              </tr>
              <tr>
                <td>To Date</td>
                <td>:&nbsp;<label name="lbltodate" id="lbltodate"><s:property value="lbltodate"/></label></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>Currency</td>
                <td>:&nbsp;<label name="lblcurrencycode" id="lblcurrencycode"><s:property value="lblcurrencycode"/></label></td>
              </tr>
              <!--<tr>
                <td>Details</td>
                <td colspan="3">:</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
				<label name="lblguest" id="lblguest"><s:property value="lblguest"/></label>
              <tr>
                <td>Booked By</td>
                <td colspan="2">:&nbsp;<label name="lblbookedby" id="lblbookedby"><s:property value="lblbookedby"/></label></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>-->
        </table>
      </fieldset>
      <br>
      <fieldset>
      	<table width="100%" border="0">
          <tr>
            <td width="5%"><b>SL No</b></td>
            <td width="5%"><b>Conf #</b></td>
            <td width="8%"><b>Ref. No.</b></td>
            <td width="8%"><b>Date &amp; Time</b></td>
            <td width="10%"><b>Passenger</b></td>
            <td width="20%"><b>Routing Info</b></td>
            <td width="6%" align="right" ><b>Trip Amount</b></td>
            <td width="6%" align="right"><b>VAT</b></td>
            <td width="6%" align="right"><b>Total</b></td>
          </tr>
        <s:iterator var="stat1" status="arr" value="%{#request.INVDETAIL}" >
		  	<s:iterator status="arr" value="#stat1" var="stat">    
				<tr>   
					<s:iterator status="arr" value="#stat.split('::')" var="des">
						<s:if test="#arr.index>5">
							<td align="right"><s:property value="#des"/></td>
						</s:if>
						<s:else>
							<td><s:property value="#des"/></td>
						</s:else>
					</s:iterator>
				</tr>
			</s:iterator>
		</s:iterator>
       </table>
      </fieldset>
      <hr>
	<table width="100%" >
	  <tr>
	    <td width="197" align="left"><b>Sub Total :</b></td>
	    <td width="752">&nbsp;</td>
	    <td width="163">&nbsp;</td>
	    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
	  </tr>
	  <tr>
	    <td width="197" align="left"><b>VAT :</b></td>
	    <td width="752">&nbsp;</td>
	    <td width="163">&nbsp;</td>
	    <td width="146" align="right"><b><label id="lblvatamt" name="lblvatamt"><s:property value="lblvatamt"/></label></b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>Grand Total :</b></td>
	    <td>&nbsp;</td>
	    <td>&nbsp;</td>
	    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label><b></td>
	  </tr>
	  <tr>
	    <td align="left"><b>Amount In Words : </b></td>
	    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
	    </tr>
	</table>
	<hr>
<h4 style="text-align:center;text-transform:uppercase"><b>bank details</b></h4>
<h4>Please Transfer to our Bank Account Below</h4>
<table width="100%" border="0">
	<tr>
    	<td colspan="2">Al Sayara Limousine Passengers Transport Per Person Company</td>
    </tr>
  	<tr>
    	<td>BANK</td>
    	<td>:&nbsp;ADCB</td>
  	</tr>
  	<tr>
    	<td>A/C NO</td>
    	<td>:&nbsp;10482006220001</td>
  	</tr>
  	<tr>
    	<td>A/C NAME</td>
    	<td>:&nbsp;AL SAYARA LIMOUSN PASSGR TRANS LLC</td>
  	</tr>
  	<tr>
    	<td>IBAN No</td>
    	<td>:&nbsp;AE590030010482006220001</td>
  	</tr>
  	<tr>
    	<td>SWIFT CODE</td>
    	<td>:&nbsp;ADCBAEAA</td>
  	</tr>
</table>
	
<%-- <div id="bottompage" style="margin-top:60px;">
	<hr>
	<table width="100%" >
  		<tr>
   			<td width="13%">Processed By</td>
    		<td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    		<td width="13%">Checked By</td>
    		<td width="22%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    		<td width="12%">Recieved By</td>
    		<td width="21%">&nbsp;</td>
   		</tr>
  		<tr>
    		<td colspan="4" height="85px">&nbsp;</td>
    		<td width="6%">Date</td>
    		<td width="21%"><!-- <label id="lblfinaldate" name="lblfinaldate" style="padding-top:30px;"><s:property value="lblfinaldate"/></label> --></td>
    	</tr>
	</table>
</div> --%>
<div id="bottompage" style="margin-top:60px;">
<table width="100%" >
  <tr>
    <td width="13%">Checked By</td>
    <td width="20%"><label id="lblcheckedby" name="lblcheckedby"><s:property value="lblcheckedby"/></label></td>
    <td width="13%">Received By</td>
    <td width="29%"><label id="lblrecievedby" name="lblrecievedby"><s:property value="lblrecievedby"/></label></td>
    <td width="4%">Date</td>
    <td width="21%"><label id="lblfinaldate" name="lblfinaldate"><s:property value="lblfinaldate"/></label></td>
    </tr>
  <tr>
    <td colspan="6">&nbsp;</td>
    </tr>
</table>
</div>
<div class="divFooter">
	<table width="100%">
 		<tr>
     		<td colspan="3" align="center"><fieldset><font style="color: #D8D8D8;font-size: 11px;">System Generated Document Signature & Stamp Not Required.</font></fieldset></td>
  		</tr>
  		<tr>
  			<td width="47%" style="color: #D8D8D8;" align="left">
  				<i>Printed by <%=session.getAttribute("USERNAME")%> 
  				<label id="lblfooter"></label></i>
  			</td>
  			<td width="43%" style="color: #FAFAFA;" align="left">Powered by GATEWAY ERP</td>
 			<td width="10%" style="color: #D8D8D8;">
    			<div id="content"> 
  					<div id="pageFooter"></div>
   				</div>  
  			</td>
  		</tr>
	</table>
</div>

</form>
</body>
</html>
