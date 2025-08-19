<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<title>GatewayERP(i)</title>
<!-- <link rel="stylesheet" type="text/css" href="../../../../css/body.css">  -->
  <jsp:include page="../../../../includes.jsp"></jsp:include>  
<style>
 .hidden-scrollbar {
  overflow: auto;
/*  height: 900px;  */
} 

label {
    font: normal 10px ;
}


 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid #30B700;
  padding-left:2px;
  
  
 }
 
    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:10px;
        color:#30B700;
      

    }
    
p{
	
	font-size:0.0001px;
	line-height: 9.5px;
	font-family: Times New Roman; 	
	text-align: justify;
	padding-left:3px;
	padding-right:3px;
	
	
}
.tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}

#para1{
	font-size: 8.5px;
	font-family: Times New Roman;
	align: justify;
}
table{
font-size:0.001vh;

}
table tr td{
	cell-padding:0;
}
</style> 
<script>
 
 
function gridload(){
	   var indexvals = document.getElementById("docnoval").value;
  
       $("#calcdiv").load("calculationGrid.jsp?rentaldoc="+indexvals);
       
     }  


</script>
</head>
<body onload="gridload();" bgcolor="white" style="font: 10px Tahoma " >
	<div id="mainBG" class="homeContent" data-type="background">
		<div class='hidden-scrollbar'>
			<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 				<div style="background-color:white;">
    				<table width="100%"  >
  						<tr>
    						<td colspan="1"><img src="<%=contextPath%>/icons/worldheader.jpg" width="100%"/></td>
  						</tr>
  						<tr> 
    						<td align="center"><b><font size="5"><label style="font-family: Times new roman;">RENTAL AGREEMENT</label></font></b></td>
    						<td align="left">&nbsp;</td>
  						</tr>
						<!-- <tr>
    						<td align="left">&nbsp;</td>
  						</tr> -->  
  <table width="100%">
  <tr>
    <td rowspan="2" ><b><label style="font-family: Times new roman;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>RANO : </b></label><b><label id="rentaldoc" name="rentaldoc"  style="font-family: Times new roman;"><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b><label style="font-family: Times new roman;">MRA NO : </label><label id="mrano" name="mrano"  style="font-family: Times new roman;"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b><label style="font-family: Times new roman;">RA STATUS : </label></b><b><label  id="rastatus" name="rastatus" style="font-family: Times new roman;"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left" width="23%"><b><label style="font-family: Times new roman;">Branch : </label></b><label id="barnchval" name="barnchval" style="font-family: Times new roman;"><s:property value="barnchval"/></label></td>
  </tr>
  </table>
  <table width="100%">
  <tr>
   <td align="left" width="77%"> </td><td align="left" width="23%"><b><label style="font-family: Times new roman;">Location : </label></b><label id="location" name="location" style="font-family: Times new roman;"><s:property value="location"/></label></td>
  </tr>
  </table>
  <!-- <tr hidden="true">
    <td colspan="3"><hr noshade size=1 color="#30B700" width="100%"></td>
  </tr> -->
</table>
<table width="100%">
 <tr>
  <td width="50%">
  <fieldset><legend><b><p align="justify">Details</p></b></legend> 
  <table width="100%" style="line-height:0.1px;""> 
  <tr>
      <td width="15%" align="left" ><p align="justify">Name : </td>
    <td width="100%" ><label id="clname" name="clname" style="font-family: Times new roman;"><s:property value="clname"/></label></td>
   
    </tr>
      <tr>
    <td  width="19%" align="left"><p align="justify">Address : </td>
    <td  width="100%"><label id="claddress" name="claddress" style="font-family: Times new roman;"><s:property value="claddress"/></label></td>
    </tr>
   
   </table>
  <table width="100%" style="line-height:0.1px;">
      <tr>
    <td width="15%" align="left"><p align="justify">MOB : </td>
    <td width="30%"><label id="clmobno" name="clmobno" style="font-family: Times new roman;"><s:property value="clmobno"/></label></td> 
</tr>
<tr>
    <td  width="15%" align="left"><p align="justify">Email : </td>
    <td ><label id="clemail" name="clemail" style="font-family: Times new roman;"><s:property value="clemail"/></label></td>
    </tr>
   <tr>
   <td  width="15%" align="left"><p align="justify">D\L# : </td>
    <td><label id="radlno" name="radlno" style="font-family: Times new roman;"><s:property value="radlno"/></label></td>
   
   <td width="20%" align="right"><p align="justify">Exp Date : </td>
    <td width="60%"  ><label id="lblaccount" name="licexpdate" style="font-family: Times new roman;" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td width="19%" align="left"><p align="justify">Passport : </td>
    <td > <label name="passno" id="passno" style="font-family: Times new roman;"><s:property value="passno"/></label></td>
    <td width="20%" align="right"><p align="justify">Exp Date : </td>
    <td width="20%"><label name="passexpdate" id="passexpdate" style="font-family: Times new roman;"><s:property value="passexpdate"/></label></td>
    </tr>
   <tr>
     <td width="15%" align="left"><p align="justify">DOB : </td>
    <td width="30%"><label name="dobdate" id="dobdate" style="font-family: Times new roman;"><s:property value="dobdate"/></label></td>
  
      <td width="22%" align="right"><p align="justify">Nationality :</td>
    <td width="20%"><label name="lblnation" id="lblnation" style="font-family: Times new roman;"><s:property value="lblnation"/></label></td>
    </tr>
    </table>
</fieldset>

 
  <fieldset><legend ><b><p align="justify">Additional Drivers</p></b></legend>
   <p align="justify">
    <table  width="100%">
 
    <tr> <td width="30%" align="left" ><label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">Additional Driver One : </label></td></tr>
  </table>
    <table width="100%" style="line-height:0.1px;">
  
   <tr> 
     <td width="15%" align="left"><p align="justify">Name : </td>  
        <td  width="100%" ><label id="adddrname1" name="adddrname1"style="font-family: Times new roman;"><s:property value="adddrname1"/></label></td>
    </tr></table>
  <table  width="100%" style="line-height:0.1px;">
  <tr>
      <td  width="15%" align="left"><p align="justify">D\L#: </td>
        <td width="34%"><label id="addlicno1" name="addlicno1"style="font-family: Times new roman;"><s:property value="addlicno1"/></label></td>
       <td width="22%" align="right"><p align="justify">Exp Date : </td>
        <td><label id="expdate1" name="expdate1" style="font-family: Times new roman;"><s:property value="expdate1"/></label></td>
    
    </tr>
   <tr>
      <td width="15%" align="left"><p align="justify">DOB : </td>
        <td width="34%"><label id="adddob1" name="adddob1" style="font-family: Times new roman;"><s:property value="adddob1"/></label></td>
 
  <td width="22%" align="right"><p align="justify">Nationality : </td>
  <td><label  id=lblindigoaddnationality name=lblindigoaddnationality  style="font-family: Times new roman;" ><s:property value="lblindigoaddnationality"/></label></td>
     </tr>
</table>

 <table  width="100%" >
 <tr> <td width="30%" align="left"><label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">Additional Driver Two: </label></td></tr>
  </table>
    <table width="100%" style="line-height:0.1px;" >
  <tr> 
      <td width="15%"align="left"><p align="justify">Name : </td>  
      <td  width="100%"><label id="adddrname2" name="adddrname2" style="font-family: Times new roman;"><s:property value="adddrname2"/></label></td>
    </tr>
    </table>
  <table  width="100%" style="line-height:0.1px;" >
      <tr>
      <td width="15%" align="left"><p align="justify">D\L#: </td>
      <td width="34%" ><label id="addlicno2" name="addlicno2" style="font-family: Times new roman;"><s:property value="addlicno2"/></label></td>
   <td width="22%" align="right"><p align="justify">Exp Date : </td>
      <td><label id="expdate2" name="expdate2" style="font-family: Times new roman;"><s:property value="expdate2"/></label></td>
    </tr>
     <tr>
      <td width="15%" align="left"><p align="justify">DOB : </td>
      <td width="34%"><label id="adddob2" name="adddob2" style="font-family: Times new roman;"><s:property value="adddob2"/></label></td>
   <td width="22%" align="right"><p align="justify">Nationality : </td>
   <td width="60%"  ><label id=nation2 name=nation2  style="font-family: Times new roman;" ><s:property value="nation2"/></label></td>
    </tr>
     </table>
     <table  width="100%"  style="line-height:0.1px;">
 <tr><td align="left"> <p style="font-size: 0.0001px; font-family: Times new roman;"> If driver is not mentioned the primary driver will be penalized.</p></td></tr>
</table>
</fieldset>
<table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>


<legend><b><p align="justify">Traffic/Parking Fines/Salik (Tolls)</p></b></legend>
<p style="line-height:10.5px;">
By initialing, I agree to pay all traffic/parking/other fines plus AED 20 Knowledge & Innovation fee (as 
per RTA) and a ___ surcharge on all fines above 500 or AED 50 minimum on all fines below 500. I 
agree to pay Salik and plus AED 1 per crossing. Fines will be paid as per the next billing date. Late fines 
are subject to an additional AED 10 per day.

<br></p>

<table width="100%">
<tr><td width="40%" style="padding-top:20px;"></td><td width="60%" height="10px"><fieldset style="height:100%;"><label style=" color:#30B700"><p align="justify">Customer Signature: </p></label></fieldset>
</td>
<%-- <label style="text-align: right;display: block;" id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
</tr>
</table>
</fieldset>

 </td>
 </tr>
 
 </table>
 
  <table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b><p align="justify">Fuel</p></b></legend> 
 <p style="line-height:10px;">
 The user must return the car with the same level of fuel as when it was given. There will be charges for the 
difference if returned at a lower level or empty. Fuel will be charged as per actual rate plus AED 50 service 
fee.
       </p>
       </fieldset>
</td>
</tr>
 
</table>

<table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b><p align="justify">Maintenance</p></b></legend> 
 <p style="line-height:10px;">
 All costs related to the regular maintenance and service will be borne by SEL CAR RENTAL LLC. We will 
provide a replacement vehicle whenever the vehicle is in our workshop for repair and maintenance. 
In case the same range of vehicle is unavailable, a smaller car will be provided as a temporary 
replacement.  </p>
<p >
The scheduling of maintenance is the responsibility of customers. To ensure the best quality of the 
car, timely maintenance is required. Late maintenance will result in a penalty of AED 200 for every 
1000 KMs. Damaging or removal of a service sticker costs a penalty of AED 1000.
All our vehicles are NON-SMOKING; a fee of AED 500 will be charged for cleaning and 
removing cigarette odor. The penalty for damaging or removing a non-smoking sticker is AED 
1000. Excessive discoloration, pet hair, filth, or soilage will result in an AED 300 charge for interior 
cleaning and seat detailing.  </p>
       </fieldset>
</td>
</tr>
 
</table>
 
 
 
 <table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b><p align="justify">Terms & Conditions</p></b></legend> 
 <p style="line-height:10px;">
I have reviewed and agreed to all the terms and conditions of this agreement and confirm that if 
a payment is to be made via my credit card, my signature below shall constitute authority to debit 
my nominated credit/debit card or I will pay the total amount due in cash or bank transfer. The 
payment terms constitute monthly in advance & AED 1,000 to 1,500 security deposit (refundable 
30 days from date of off hire). 5% VAT shall be applicable to all invoices. Failure to pay will 
result in immobilization of the car within 48 hours. I agree to pay auto liability charges as 
mentioned above. I further agree with all traffic and parking fines and any other violations 
(charged during the rental period). I undertake not to drive the vehicle outside UAE without prior 
written approval from the company. Minimum rental period is 24hours. If the vehicle is returned 
earlier than 30 days, during the first month of the rental, daily or weekly rates will apply. Desert 
driving is NOT permitted. Customers will be charged in full for any damage caused by off-road 
driving. All our vehicles are NON-SMOKING; a penalty of AED 500 will be charged for 
cleaning and removing cigarette odor. Vehicle upgrade as replacement is for temporary use only. 
SEL  will contact you for an exchange. Three (3) attempts will be made and if all three attempts 
were unsuccessful, you will be charged for the upgraded vehicle rate from the date the vehicle in 
your charge group was available. Driving under the influence of alcohol is NOT permitted. Any 
unsettled dues such as traffic fines, tolls, rental, damages and other charges may result in legal 
action.
       </p>
       </fieldset>
</td>
</tr>
</table>

  </td>
  
  
  <td width="50%">
  <fieldset>
  <legend><b><p align="justify"> Vehicle</p></b></legend>
     <table width="100%"  style="line-height:0.1px;">  
  <tr>
    
    <td width="52%" ><p align="justify"><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="18%" ><p align="justify">YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    <td width="30%"><p align="justify">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td align="left"><p align="justify">Reg No&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
 
     <td align="left" colspan="2"><p align="justify">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b><p align="justify">Vehicle Out</p></b></legend>  
       <table width="100%" >
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="20%" align="left"  style="font-family: Times new roman;">Date</th>
       <th width="11%" align="left"  style="font-family: Times new roman;">Time</th>
          <th width="14%" align="left"  style="font-family: Times new roman;">Km</th>
             <th width="21%" align="left"  style="font-family: Times new roman;">Fuel</th>
             
  </tr>
  <tr>
  <td width="35%"><b><p align="justify" ><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td><label id="radateout" name="radateout" style="font-family: Times new roman;"><s:property value="radateout"/></label></td>
<td><label id="ratimeout" name="ratimeout" style="font-family: Times new roman;"><s:property value="ratimeout"/></label></td>
<td><label id="raklmout" name="raklmout" style="font-family: Times new roman;"><s:property value="raklmout"/></label></td>
<td><label id="rafuelout" name="rafuelout" style="font-family: Times new roman;"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td width="35%"><b><p align="justify">Delivery : </p></b></td>
<td><label id="deldates" name="deldates" style="font-family: Times new roman;"><s:property value="deldates"/></label></td>
<td><label id="deltimes" name="deltimes" style="font-family: Times new roman;"><s:property value="deltimes"/></label></td>
<td><label id="delkmins" name="delkmins" style="font-family: Times new roman;"><s:property value="delkmins"/></label></td>
<td><label id="delfuels" name="delfuels" style="font-family: Times new roman;"><s:property value="delfuels"/></label></td>
  </tr>
  
 <td width="35%"><b><p align="justify">Due Date : </b> </td> <td> <label id="duedate" name="duedate" style="font-family: Times new roman;"><s:property value="duedate"/></label></td>
  
 <td> <label id="duetime" name="duetime" style="font-family: Times new roman;"><s:property value="duetime"/></label></td>
  </tr>
 <tr> <td width="39%"><b><p align="justify">Next Service KM due : </b> </td><td> <td> </td><td><label id="srvckm" name="srvckm" style="font-family: Times new roman;"><s:property value="srvckm"/></label></td>
  </td></tr>

 </table>
   
  <table width="100%">
<tr></tr>
<tr><td width="40%" style="padding-top:20px;">
    <hr noshade size=1 color="#30B700"></td>
 <td width="60%"  height="10px"><fieldset style="height:100%;"><label style=" color:#30B700"><p align="justify">Customer Signature: </label></fieldset>
</td>
</tr>
</table>
  </fieldset>     
        
  <%--   <fieldset>
    <legend><b>Out Details</b></legend>
    <table width="100%" >
    <tr>
    <td width="10%" align="left">Date</td>
    <td width="18%"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
    <td width="12%" align="right">Time&nbsp;&nbsp;</td>
     <td width="15%"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
    </tr>
    <tr>
   
    <td width="10%" align="left">KM</td><td width="25%">
      <label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
      
        <td width="10%" align="right">Fuel&nbsp;&nbsp;</td><td width="30%">
      <label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
    </tr>
    </table>
    </fieldset> --%>
<%--      <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%" >
      <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
  </table>
    </fieldset> --%>
    
    
        <fieldset><legend><b><p align="justify">Rental Rate</p></b></legend>  
     
    <table  width="100%">
    <tr>  <td width="56%"><label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">Fixed </label></td> 
      <td width="44%"><label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">Add Ons </label></td> 
 </tr></table>      
  
      <table  width="100%" style="line-height:0.1px;">
     <tr> <td width="31%"><b><p align="justify">Rent Type : </p></b></td><td  width=19% align="right"><label id="rarenttypes" name="rarenttypes" style="font-family: Times new roman;"><s:property value="rarenttypes"/></label></td><td  width="5%" >&nbsp; </td>
    <%--  <tr> <td width="40%">SUPER CDW</td><td  width="20%" align="right"><label id="selcarcdw1" name="selcarcdw1"><s:property value="selcarcdw1"/></label></td><td  width="30%" >&nbsp; </td></tr>
     --%>
      <td width="26%"><b><p align="justify">CDC/SCDW : </p></b></td><td  width="25%" align="right"><label id="selcarcdw1" name="selcarcdw1" style="font-family: Times new roman;"><s:property value="selcarcdw1"/></label></td></tr>
</table>

<table  width="100%"  style="line-height:0.1px;">
     <tr> <td width="31%"><b><p align="justify">Tariff : </p></b></td><td  width="19%" align="right"><label id="selcartarif" name="selcartarif" style="font-family: Times new roman;"><s:property value="selcartarif"/></label></td><td  width="5%" >&nbsp; </td>
    <td width="26%"><b><p align="justify">PAI :</p></b></td><td  width="25%" align="right"><label id="selcarpai" name="selcarpai" style="font-family: Times new roman;"><s:property value="selcarpai"/></label></td></tr>
    
    </table>
     <table  width="100%"  style="line-height:0.1px;">
    <tr> <td width="31%"><b><p align="justify">Restrict KMS : </p></b></td><td  width="19%" align="right"><label id="raextrakm" name="raextrakm" style="font-family: Times new roman;"><s:property value="raextrakm"/></label></td><td  width="5%" >&nbsp; </td>  
     <%-- <tr> <td width="15%">Delivery Chrges</td><td  width="10%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>
      --%>
     <td width="26%"><b><p align="justify">Delivery: </p></b></td><td  width="25%" align="right"><label id="laldelcharge" name="laldelcharge" style="font-family: Times new roman;"><s:property value="laldelcharge"/></label></td></tr>
      
    </table>
    
    <table  width="100%"  style="line-height:0.1px;">
      <tr> <td width="31%"><b><p align="justify">Excess KM Rate : </p></b></td><td  width="19%" align="right"><label id="raexxtakmchg" name="raexxtakmchg" style="font-family: Times new roman;"><s:property value="raexxtakmchg"/></label></td><td  width="5%" >&nbsp; </td>
       
       <td width="26%"><b><p align="justify">Miles PKg : </p></b></td><td  width="25%" align="right" ><label style="font-family: Times new roman;">0.00</label></td></tr>
       </table>
       
        
     <%--  <tr> <td width="15%">CDW</td><td  width="10%" align="right"><label id="selcarcdw" name="selcarcdw"><s:property value="selcarcdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
       <tr> <td width="15%">VMD</td><td  width="10%" align="right"><label id="selcarvmd" name="selcarvmd"><s:property value="selcarvmd"/></label></td><td  width="30%" >&nbsp; </td></tr>
      --%>   
      <table  width="100%"  style="line-height:0.1px;">  
         <tr> <td width="31%"><p align="justify"></p></td><td  width="19%" align="right"><label> </label></td><td  width="5%" >&nbsp; </td>
        <%--  <tr> <td width="15%">Add Driver Charge</td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
         --%> 
          <td width="26%"><b><p align="justify">Accessories : </p></b></td><td  width="25%" align="right"><label id="selcaracc" name="selcaracc" style="font-family: Times new roman;"><s:property value="selcaracc"/></label></td></tr>
          
      </table>
      
      
       
        <table  width="100%"  style="line-height:0.1px;">  
          <tr> <td width="31%"><p align="justify">*Plus 5% VAT</p></td><td  width="19%" align="right"><label></label></td><td  width="5%" >&nbsp; </td>
         <%--  <tr> <td width="15%">Add Driver Charge</td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
         --%> 
          <td width="26%"><b><p align="justify">Add. Drivers : </p></b></td><td  width="25%" align="right"><label id="raadditionalcge" name="raadditionalcge" style="font-family: Times new roman;"><s:property value="raadditionalcge"/></label></td></tr>
                   
      </table>
       <%--  <table  width="100%" border="1" >   
       
            
                    <tr> <td width="15%">Add Driver Charge</td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="15%">Chauffer Charge</td><td  width="10%" align="right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>      
                    
                 
                    
      <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
  </table> --%>
    </fieldset>
   <table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b><p align="justify">Accidents & Insurance</p></b></legend> 
 <label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">Auto Liability</label>
 <p>
All of our cars are insured and you will pay for the accident excess liability amounting to 
AED <label  id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> in case of an accident due to your fault, including a hit-and-run situation or an 
unknown party as evidenced by the Police Report.
The minimum driver age for full insurance coverage is 23 and above. For ages 21-23 years old 
is AED 1500 minimum depending on the car category. A driving license under 6 months old 
is liable for AED 1,500 minimum depending on the car category. A driver not covered by the 
policy is not insured and must pay the full/partial cost of the accident and AED 1000 penalty
       </p>
       
       <label style="color:#30B700; font-size:0.001vh;
	font-family: Times new roman;">CDW/ SCDW</label>
 <p align="justify">
I acknowledge that any accident involving CDW/SCDW must be accompanied by a 
police report.
 </p>
 <p>
CDW - Optional and additional charge to waive unknown damage excess liability 
(non-faulty report including of unknown party and hit & run)
SCDW - Optional and additional charge to waive the total accident excess liability into 
“Zero” (Faulty, Non-Faulty, single or unknown party report).
 </p>
</fieldset>
</td>
</tr>
</table>
<table width="100%">
 <tr>
 <td  >
  <fieldset>
  <legend><b><p align="justify"> تفاصيل سائق إضافية</p> </b></legend> 
 <p >
قد استعرضت ووافقت على جميع المصطلحات وشروط هذا الاتفاق وتؤكد أنه إذا دفع هو الذي سيدلي به بطاقة الائتمان الخاصة بي توقيعي المبينة أدناه تشكل سلطة الخصم بطاقة الائتمان الخاصة بي رشح أو سوف تدفع للشركة المبلغ الإجمالي المستحق نقدا. كما أوافق على دفع كل حركة المرور ومواقف السيارات وغيرها من ا نتهاكات (اتهم خلال فترة الإيجار). أتعهد بعدم قيادة السيارة خارج الدولة دون الحصول على موافقة خطية مسبقة من الشركة. أتعهد بعدم قيادة السيارة خارج الدولة دون الحصول على موافقة خطية مسبقة من الشركة. فترة الإيجار الحد الأدنى هو 24 ساعة. 4 * 4 السيارات هي لطريق معبد القيادة فقط. لا يسمح القيادة في الصحراء.  وستحمل العملاء بالكامل أو أي ضرر ناتج عن القيادة على الطرق الوعرة. في حال حدوث اي حادث تغريمه مبلغ 1500 في حال اي حادث حصل على المركبة.اذا كان المستأجر اصغر عن سن 25 عاما, أو رخصة قيادة وطنية أقل من سنة واحدة ثم لا بد له من دفع 20٪ من رسوم الضرر المسؤولية على النحو المذكور أعلاه. المستأجر يقر بأن الإنهاء المبكر للعقد الإيجار سوف يؤدي إلى ارتفاع معدل حساب الأسعار المطبقة على أساس إما يوميا،, أسبوعية أو شهرية أسعار الفائدة. السيارة التي تم الترقية إلىها هي فقط للاستخدام المؤقت. مرة واحدة في السيارة مجموعة نفقاتك متاح سوف اتصل بك  لتبادل. وسوف تتاح ثلاثة (3) محاولات للتبديل لو أن كل المحاولات الثلاث غير ناجحة وسيتم محاسبتك على السيارة التي تم الترقية اليها من تاريخ استلام  السيارة في المجموعة نفقاتك كانت متاحة.
       </p>
       </fieldset>
</td>
</tr>
 
</table>
  <fieldset width="100%">
    <legend>
     <b><p align="justify">Signature</p></b></legend>

     <table  width="100%"   >
           <tr>
    <td colspan="2"> <p>
      I have read and understood the terms & conditions on both sides of this agreement & 
agreed with my signature to the same and acknowledged that a) Disclaimer b) Credit Card 
Authorization c) Vehicle Checklist (for original and replacement vehicles) is part of this 
agreement  </p></tr>
    <tr><td colspan="2"><!--<hr noshade size=1>-->  </td></tr>
    <tr>
    <td  align="left" ><label style="color:#30B700"><p align="justify">Customer Signature : </p></label>
    <td width="40%" align="left" ><label style="color:#30B700"><p align="justify">Date : </p></label></td>
    </tr>
     <tr> <td align="left" ><label style="font-size:0.001vh;
	font-family: Times new roman">  Rental Agent  : </label> &nbsp;
      <label id="raagent" name="raagent" style="font-size:0.001vh;
	font-family: Times new roman"><s:property value="raagent"/></label>   </td>
          <td align="left" ><label style="font-size:0.001vh;
	font-family: Times new roman"> Date : </label> </td>
	    </tr>
 </fieldset>
  </td>
    </tr>
<tr>
    <td columnspan="1"><img src="<%=contextPath%>/icons/worldfooter.jpg" width="130%"/></td>
  </tr>
  </table>
 
 <!-- Page 2 -->
 
 

 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    