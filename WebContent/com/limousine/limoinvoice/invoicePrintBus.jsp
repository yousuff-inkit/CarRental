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
</style> 
<script>
$(document).ready(function () {
	
});
function getPrint(){
	//alert("hgchjh");
	 document.getElementById("mode").value="print";
	document.getElementById("frmManualInvoicePrint").submit(); 
}
</script>
</head>
<body onload="" style="font-size:12px">
	<!--<div id="mainBG" class="homeContent" data-type="background">
		<form id="frmLimoInvoicePrint" action="printLimoInvoice" autocomplete="off" target="_blank">
 			<jsp:include page="../../common/printHeader.jsp"></jsp:include> 
			
		</form>
	</div>-->
	<table style="width:100%;">
		<tr>
			<td><jsp:include page="../../common/printHeaderGlobe.jsp"></jsp:include></td>
		</tr>
	</table>
    <fieldset>
		<table width="100%" border="0">
              <tr>
                <td width="11%">Client</td>
                <td colspan="3">:&nbsp;<label name="lblcldocno" id="lblcldocno"><s:property value="lblcldocno"/></label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label name="lblclient" id="lblclient"><s:property value="lblclient"/></label>
                </td>
                <td width="17%">Invoice</td>
                <td width="17%">:&nbsp;<label name="lblvocno" id="lblvocno"><s:property value="lblvocno"/></label></td>
              </tr>
              <tr>
                <td>Details</td>
                <td colspan="3">:&nbsp;<label name="lbldetails" id="lbldetails"><s:property value="lbldetails"/></label></td>
                <td>Date</td>
                <td>:&nbsp;<label name="lbldate" id="lbldate"><s:property value="lbldate"/></label></td>
              </tr>
              <tr>
                <td>From Date</td>
                <td width="21%">:&nbsp;<label name="lblfromdate" id="lblfromdate"><s:property value="lblfromdate"/></label></td>
                <td width="17%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
                <td><!-- Ref No --></td>
                <td><%--:&nbsp; <label name="lblrefno" id="lblrefno"><s:property value="lblrefno"/></label> --%></td>
              </tr>
              <tr>
                <td>To Date</td>
                <td>:&nbsp;<label name="lbltodate" id="lbltodate"><s:property value="lbltodate"/></label></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
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
            <td width="6%"><b>Book No</b></td>
            <td width="10%"><b>Pickup Date</b></td>
            <td width="8%"><b>Time</b></td>
            <!-- <td width="12%"><b>Vehicle</b></td> -->
            <td width="17%"><b>Pickup Loc</b></td>
            <td width="18%"><b>Dropoff Loc</b></td>
            <!-- <td width="9%"><b>Srvc Type</b></td> -->
            <td width="11%" align="right"><b>Total</b></td>
          </tr>
        <s:iterator var="stat1" status="arr" value="%{#request.INVDETAIL}" >
		  	<s:iterator status="arr" value="#stat1" var="stat">    
				<tr>   
					<s:iterator status="arr" value="#stat.split('::')" var="des">
						<s:if test="#arr.index!=4 && #arr.index!=7">
							<s:if test="#arr.index==8">
								<td align="right"><s:property value="#des"/></td>
							</s:if>
							<s:else>
								<td><s:property value="#des"/></td>
							</s:else>
						</s:if>						
					</s:iterator>
				</tr>
			</s:iterator>
		</s:iterator>
       </table>
      </fieldset>
      <hr>
<table width="100%" >
  <tr>
    <td width="197" align="left"><b>Total :</b></td>
    <td width="752">&nbsp;</td>
    <td width="163">&nbsp;</td>
    <td width="146" align="right"><b><label id="lbltotal" name="lbltotal"><s:property value="lbltotal"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>VAT Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblvatamt" name="lblvatamt"><s:property value="lblvatamt"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Net Amount :</b></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td align="right"><b><label id="lblnetamount" name="lblnetamount"><s:property value="lblnetamount"/></label></b></td>
  </tr>
  <tr>
    <td align="left"><b>Amount In Words : </b></td>
    <td colspan="3" align="right"><b><label id="lblamountwords" name="lblamountwords"><s:property value="lblamountwords"/></label></b></td>
    </tr>
</table>
<table width="100%" >
  <tr>
    <td width="197" align="left"><h3><b>Bank Details :</b></h3></td>
   </tr>
  <tr>
    <td width="20%" align="left"><b>Bank Name :</b></td>
    <td width="146" align="left"><label id="lblbankdetails" name="lblbankdetails"><s:property value="lblbankdetails"/></label></td>
  </tr>
  <tr>
    <td width="20%" align="left"><b>Bank Address :</b></td>
    <td width="146" align="left"><label id="lblcompbranchaddress" name="lblcompbranchaddress"><s:property value="lblcompbranchaddress"/></label></td>
  </tr>
  <tr>
    <td width="20%" align="left"><b>Account Name :</b></td>
    <td align="left"><label id="lblbankbeneficiary" name="lblbankbeneficiary"><s:property value="lblbankbeneficiary"/></label></td>
  </tr>
  <tr>
    <td width="20%" align="left"><b>Account Number :</b></td>
    <td align="left"><label id="lblbankaccountno" name="lblbankaccountno"><s:property value="lblbankaccountno"/></label></td>
  </tr>
 <tr>
    <td width="20%" align="left"><b>IBAN :</b></td>
    <td align="left"><label id="lblbankibanno" name="lblbankibanno"><s:property value="lblbankibanno"/></label></td>
  </tr>
  <tr>
    <td width="20%" align="left"><b>Swift Code :</b></td>
    <td align="left"><label id="lblbeneficiarybank" name="lblbeneficiarybank"><s:property value="lblbeneficiarybank"/></label></td>
  </tr>
</table>

<table style="width:100%;">
		<tr>
			<td><jsp:include page="../../common/printFooterGlobal.jsp"></jsp:include></td>
		</tr>
	</table>
	
</body>
</html>
