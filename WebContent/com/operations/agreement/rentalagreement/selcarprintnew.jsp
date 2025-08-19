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
  overflow:hidden; 
/*  height: 900px;  */
} 

label {
    font: normal 10px ;
}


 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid #90a955;
  padding-left:2px;
  
  
 }
 
    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:10px;
        color:#90a955;
        font-family: Times new roman;
        font-size: 11px;

    }
    
p{
	
	font-size:8px;
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
line-height: 9px;



}
table tr td{
	cell-padding:0;
}
label{

    font-size: 8.5px;
	font-family: Times New Roman;
	line-height: 3px;
}
td{

    font-size: 8.5px;
	font-family: Times New Roman;

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
  					<td colspan="3"> <td> 
  					</tr>
  					<tr>
  					<td colspan="3" height="50px"> <td> 
  					</tr>
  					<tr> 
  							<td align="center"><b><label style="font-family: Times new roman; font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RENTAL AGREEMENT</label></b></td>
    						<td align="left">&nbsp;</td>
  						</tr>
  					<tr>
  					<td colspan="3" height="45px"> <td> 
  					</tr>
  						
						<!-- <tr>
    						<td align="left">&nbsp;</td>
  						</tr> -->  
  					
  <table width="100%" >
  	<tr>
  					<td colspan="3"> <td> 
  					</tr>
  <tr>
  <td width="10%"></td>
    <td rowspan="2" ><b><label style="font-family: Times new roman;font-size:12px;"><b>RANO : </b></label><b><label id="rentaldoc" name="rentaldoc"  style="font-family: Times new roman;font-size:12px;"><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;  <b><label style="font-family: Times new roman; font-size:12px;"> MRA NO : </label><label id="mrano" name="mrano"  style="font-family: Times new roman;font-size:12px;"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b><label style="font-family: Times new roman; font-size:12px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RA STATUS : </label></b><b><label  id="rastatus" name="rastatus"  style="font-family: Times new roman; font-size:12px;"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left" width="23%"><b><label style="font-family: Times new roman; font-size:12px;">Branch : </label></b><label id="barnchval" name="barnchval" style="font-family: Times new roman;font-size:12px;"><s:property value="barnchval"/></label></td>
  </tr>
  </table>
  <table width="100%">
  <tr>
   <td align="left" width="73%"> </td><td align="left" width="23%"><b><label style="font-family: Times new roman; font-size:12px;">Location : </label></b><label id="location" name="location" style="font-family: Times new roman; font-size:12px;"><s:property value="location"/></label></td>
  </tr>
  </table>
   <tr>
    <td colspan="3"><hr noshade size=1 color="#90a955" width="100%"></td>
  </tr>
</table>
<table width="100%">
 <tr>
  <td width="50%">
  <fieldset><legend><b>Details</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></b></legend> 
  <table width="100%" > 
  <tr>
      <td width="15%" align="left" height="15px" style="line-height:10px;">Name : </td>
    <td width="100%" style="line-height:13px;"><label id="clname" name="clname" ><s:property value="clname"/></label></td>
   
    </tr>
      <tr>
    <td  align="left" style="line-height:12px;">Address : </td>
    <td ><label style="line-height:12px;" height="40px" id="claddress" name="claddress" style="font-family: Times new roman;"><s:property value="claddress"/></label></td>
    </tr>
   
   </table>
  <table width="100%">
      <tr>
    <td width="15%" align="left">Email : </td>
    <td width="40%"><label id="clemail" name="clemail" ><s:property value="clemail"/></label></td>
  <td width="19%" align="right" >MOB : </td>
    <td><label id="clmobno" name="clmobno" ><s:property value="clmobno"/></label></td> 
  
</tr>
</table>
 <table width="100%" >
<tr>
  <td width="15%" align="left"  >Name : </td>
    <td width="100%" ><label id="radrname" name="radrname" ><s:property value="radrname"/></label></td>
   
      </tr>
      </table>
       <table width="100%" >
   <tr>
   <td  width="13%" align="left">D\L# : </td>
    <td><label id="radlno" name="radlno" ><s:property value="radlno"/></label></td>
   
   <td width="20%" align="right">Exp Date : </td>
    <td width="60%" colspan="3" ><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td align="left" width="13%">Passport : </td>
    <td > <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    <td width="20%" align="right">Exp Date : </td>
    <td width="20%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
    </tr>
   <tr>
     <td width="13%" align="left">DOB : </td>
    <td width="20%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
  
      <td width="22%" align="right">Nationality :</td>
    <td width="20%"><label name="lblnation" id="lblnation" ><s:property value="lblnation"/></label></td>
    </tr>
    </table>
</fieldset>

 
  <fieldset><legend ><b>Additional Drivers</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>
    <table  width="100%">
 
    <tr> <td width="30%" align="left" ><label style="color:#90a955; font-size:0.001vh;
	font-family: Times new roman;">Additional Driver One : </label></td></tr>
  </table>
    <table width="100%" style="line-height:0.1px;">
  
   <tr> 
     <td width="15%" align="left">Name : </td>  
        <td  width="100%" ><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
    </tr></table>
  <table  width="100%" >
  <tr>
      <td  width="15%" align="left">D\L#: </td>
        <td width="34%"><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
       <td width="20%" align="right">Exp Date : </td>
        <td width="60%" colspan="3"><label id="expdate1" name="expdate1" ><s:property value="expdate1"/></label></td>
    
    </tr>
   <tr>
      <td width="15%" align="left">DOB : </td>
        <td width="34%"><label id="adddob1" name="adddob1" ><s:property value="adddob1"/></label></td>
 
  <td width="22%" align="right">Nationality : </td>
  <td width="20%" ><label  id=lblindigoaddnationality name=lblindigoaddnationality   ><s:property value="lblindigoaddnationality"/></label></td>
     </tr>
</table>

 <table  width="100%" >
 <tr> <td width="30%" align="left"><label style="color:#90a955; font-size:0.001vh;
	font-family: Times new roman;">Additional Driver Two: </label></td></tr>
  </table>
    <table width="100%"  >
  <tr> 
      <td width="15%"align="left">Name : </td>  
      <td  width="100%"><label id="adddrname2" name="adddrname2" ><s:property value="adddrname2"/></label></td>
    </tr>
    </table>
  <table  width="100%" >
      <tr>
      <td width="15%" align="left">D\L#: </td>
      <td width="34%" ><label id="addlicno2" name="addlicno2" ><s:property value="addlicno2"/></label></td>
   <td width="20%" align="right">Exp Date : </td>
      <td width="60%" colspan="3"><label id="expdate2" name="expdate2" ><s:property value="expdate2"/></label></td>
    </tr>
     <tr>
      <td width="15%" align="left">DOB : </td>
      <td width="34%"><label id="adddob2" name="adddob2" ><s:property value="adddob2"/></label></td>
   <td width="22%" align="right">Nationality : </td>
   <td width="20%"  ><label id=nation2 name=nation2   ><s:property value="nation2"/></label></td>
    </tr>
     </table>
     <table  width="100%" style="line-height:0.1px;" >
 <tr><td td align="left"> <p>  If driver is not mentioned the primary driver will be penalized.</p></td></tr>
</table>
</fieldset>
<table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>


<legend><b>Traffic/Parking Fines/Salik (Tolls)</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>
<p style="line-height:10px;">
By initialing, I agree to pay all traffic/parking/other fines plus AED 20 Knowledge & Innovation fee (as 
per RTA) and a ___ surcharge on all fines above 500 or AED 50 minimum on all fines below 500. I 
agree to pay Salik and plus AED 1 per crossing. Fines will be paid as per the next billing date. Late fines 
are subject to an additional AED 10 per day.

<br></p>

<table width="100%">
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"><label style=" color:#90a955">Customer Signature: </label></fieldset></td>

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
  <legend><b>Fuel</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend> 
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
  <legend><b>Maintenance</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend> 
 <p style="line-height:9px;">
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
  <legend><b>Terms & Conditions</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend> 
 <p style="line-height:9px;">
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
  <legend><b> Vehicle</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>
     <table width="100%"  style="line-height: 15px;" >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="18%" >YOM:&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    <td width="30%">Color:&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td align="left">Reg No:&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
 <td width="18%" > Code:&nbsp;<label id="pltid" name="pltid"><s:property value="pltid"/></label></td>
  <td width="58%">Group:&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Vehicle Out</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>  
       <table width="100%" >
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="19%" align="left"  >Date</th>
       <th width="10%" align="left" >Time</th>
          <th width="13%" align="left"  >Km</th>
             <th width="20%" align="left"  >Fuel</th>
             
  </tr>
  <tr>
  <td width="35%"><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td><label id="radateout" name="radateout" ><s:property value="radateout"/></label></td>
<td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td><label id="raklmout" name="raklmout" ><s:property value="raklmout"/></label></td>
<td><label id="rafuelout" name="rafuelout" ><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td width="35%"><b>Delivery : </b></td>
<td><label id="deldates" name="deldates" ><s:property value="deldates"/></label></td>
<td><label id="deltimes" name="deltimes" ><s:property value="deltimes"/></label></td>
<td><label id="delkmins" name="delkmins" ><s:property value="delkmins"/></label></td>
<td><label id="delfuels" name="delfuels" ><s:property value="delfuels"/></label></td>
  </tr>
 <td width="35%"><b>Due Date : </b> </td> <td> <label id="duedate" name="duedate" ><s:property value="duedate"/></label></td>
 <td> <label id="duetime" name="duetime" ><s:property value="duetime"/></label></td>
  </tr>
 <tr> <td width="41%"><b>Next Service KM due : </b> </td><td> <td> </td><td><label id="srvckm" name="srvckm" ><s:property value="srvckm"/></label></td>
  </td></tr>

 </table>
   
  <table width="100%" style="line-height:15px;">
<tr></tr>
<tr><td width="40%" style="padding-top:20px;">
    <hr noshade size=1 color="#90a955"></td>
 <td width="60%"  height="10px"><fieldset style="height:100%;"><label style=" color:#90a955">Customer Signature: </label></fieldset>
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
    
    
        <fieldset><legend><b>Rental Rate</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>  
     
    <table  width="100%" >
    <tr>  <td width="50%"><label style="color:#90a955; 
	font-family: Times new roman;">Fixed </label></td> 
      <td width="50%"><label style="color:#90a955; 
	font-family: Times new roman;">Add Ons </label></td> 
 </tr></table>      
  
      <table  width="100%" style="line-height:11px;">
     <tr> <td width="20%"><b>Rent Type : </b></td><td  width=10% align="right"><label id="rarenttypes" name="rarenttypes" ><s:property value="rarenttypes"/></label></td><td  width="7%" >&nbsp; </td>
    <%--  <tr> <td width="40%">SUPER CDW</td><td  width="20%" align="right"><label id="selcarcdw1" name="selcarcdw1"><s:property value="selcarcdw1"/></label></td><td  width="30%" >&nbsp; </td></tr>
     --%>
      <td width="20%"><b>CDC/SCDW : </b></td><td  width="10%" align="right"><label id="selcarcdw1" name="selcarcdw1" ><s:property value="selcarcdw1"/></label></td><td  width="7%" >&nbsp; </td></tr>
</table>

<table  width="100%"  style="line-height:11px;">
     <tr> <td width="20%"><b>Tariff : </b></td><td  width="10%" align="right"><label id="selcartarif" name="selcartarif" ><s:property value="selcartarif"/></label></td><td  width="7%" >&nbsp; </td>
    <td width="20%"><b>PAI :</b></td><td  width="10%" align="right"><label id="selcarpai" name="selcarpai" ><s:property value="selcarpai"/></label></td><td  width="7%" >&nbsp; </td></tr>
    
    </table>
     <table  width="100%"  style="line-height:11px;">
    <tr> <td width="20%"><b>Restrict KMS : </b></td><td  width="10%" align="right"><label id="raextrakm" name="raextrakm" ><s:property value="raextrakm"/></label></td><td  width="7%" >&nbsp; </td>  
     <%-- <tr> <td width="15%">Delivery Chrges</td><td  width="10%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>
      --%>
     <td width="20%"><b>Delivery: </b></td><td  width="10%" align="right"><label id="laldelcharge" name="laldelcharge" ><s:property value="laldelcharge"/></label></td><td  width="7%" >&nbsp; </td></tr>
      
    </table>
    
    <table  width="100%"  style="line-height:11px;">
      <tr> <td width="20%"><b>Excess KM Rate : </b></td><td  width="10%" align="right"><label id="raexxtakmchg" name="raexxtakmchg" style="font-family: Times new roman;"><s:property value="raexxtakmchg"/></label></td><td  width="7%" >&nbsp; </td>
       
       <td width="20%"><b>Miles PKg :</b></td><td  width="10%" align="right" ><label style="font-family: Times new roman;">0.00</label></td><td  width="7%" >&nbsp; </td></tr>
       </table>
       
        
     <%--  <tr> <td width="15%">CDW</td><td  width="10%" align="right"><label id="selcarcdw" name="selcarcdw"><s:property value="selcarcdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
       <tr> <td width="15%">VMD</td><td  width="10%" align="right"><label id="selcarvmd" name="selcarvmd"><s:property value="selcarvmd"/></label></td><td  width="30%" >&nbsp; </td></tr>
      --%>   
      <table  width="100%"  style="line-height:11px;">  
         <tr> <td width="20%"></td><td  width="10%" align="right"><label> </label></td><td  width="7%" >&nbsp; </td>
        <%--  <tr> <td width="15%">Add Driver Charge</td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
         --%> 
          <td width="20%"><b>Accessories : </b></td><td  width="10%" align="right"><label id="selcaracc" name="selcaracc" ><s:property value="selcaracc"/></label></td><td  width="7%" >&nbsp; </td></tr>
          
      </table>
      
      
       
        <table  width="100%"  style="line-height:11px;">  
         <%--  <tr> <td width="15%">Add Driver Charge</td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
         --%> <tr><td width="20%">*Plus 5% VAT</td><td  width="10%" align="right"><label></label></td><td  width="7%" >&nbsp; </td>
          <td width="20%"><b>Add. Drivers : </b></td><td  width="10%" align="right"><label id="raadditionalcge" name="raadditionalcge" ><s:property value="raadditionalcge"/></label></td><td  width="7%" >&nbsp; </td></tr>
                  
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
  <legend><b>Accidents & Insurance</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend> 
 <label style="color:#90a955; 
	font-family: Times new roman;">Auto Liability</label>
 <p style="line-height:10px;">
All of our cars are insured within UAE and you will pay for the accident excess liability amounting to 
AED <label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> in case of an accident due to your fault, including a hit-and-run situation or an 
unknown party as evidenced by the Police Report.
The minimum driver age for full insurance coverage is 23 and above. For ages 21-23 years old 
is AED 1500 minimum depending on the car category. A driving license under 6 months old 
is liable for AED 1,500 minimum depending on the car category. A driver not covered by the 
policy is not insured and must pay the full/partial cost of the accident and AED 1000 penalty
       </p>
       
       <label style="color:#90a955; 
	font-family: Times new roman;">CDW/ SCDW</label>
 <p >
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
  <legend><b> تفاصيل سائق إضافية </b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend> 
<p style="text-align: unset; line-height:11px;">
لقدراجعتووافقتعلىجميعشروطوأحكامهذهالاتفاق يةوأؤكدأنهإذاكانسيتمالدفععنطريقبطاقةالائتمانالخاصةبي,  سيشكلتوقيعيأدناهسلطةخصمبطاقةالائتمان /الخصمالمرشحةالخاصةبيأوسأدفع المبلغالإجماليالمستحقنقداأوحوالةمصرفية.  تشكلشروطالدفعمقدماشهريا و 1000 درهمإلى 1500 وديعةتأمين (قابلةللاسترداد 30 يومامنتاريخالتأجير).  تطبقضريبةالقيمةالمضافةبنسبة 5% علىجميعالفواتير. سيؤديعدمالدفعإلىتجميدالسيارةفيغضون 48 ساعة.  أوافقعلىدفعرسومالمسؤوليةالتلقائيةكماهومذكورأعلاه. كماأتفقمعجميعغراماتالمرورومواقفالسياراتوأيانتهاكاتأخرى  (تمشحنهاخلالفترةالإيجار). أتعهدبعدمقيادةالسيارةخارجدولةالإماراتالعربيةالمتح دةدونموافقةخطيةمسبقةمنالشركة. الحدالأدنىلفترةالإيجارهو 24 ساعة.  إذاتمإرجاعالسيارةفيوقتأبكرمن 30 يوما، خلالالشهرالأولمنالإيجار، سيتمتطبيقأسعاريوميةأوأسبوعية. القيادةفيالصحراءغيرمسموحبها.  سيتمفرضرسومكاملةعلىالعملاءعنأيضررناتجعنالقيادةعلىالطرقالوعرة. جميعسياراتناغيرمدخنة؛ سيتمفرضعقوبةقدرها 500  درهملتنظيفوإزالةرائحةالسجائر. ترقيةالسيارةكبديلللاستخدامالمؤقتفقط.  سوفسيلاتصلبكلتبادل. سيتمإجراءثلاث (3) محاولاتوإذالمتنجحجميعالمحاولاتالثلاث ، فسيتممحاسبتكعلىمعدلالس يارةالمطورمنتاريختوفرالسيارةفيمجموعةالشحنالخاصةبك. القيادةتحتتأثيرالكحولغيرمسموحبها. قدتؤديأيمستحقاتغيرمحسومةمثلغراماتالمروروالرسوموالإيجاروالأض راروالرسومالأخرىإلىاتخاذإجراءاتقانونية.
</p>
     </fieldset>
</td>
</tr>
 
</table>
  <fieldset width="100%">
    <legend>
     <b>Signature</b>&nbsp;&nbsp;&nbsp;<img src="../../../../icons/greenleaf.png" width="10px" height="10px"/></legend>

     <table  width="100%"   >
           <tr>
    <td colspan="2"> <p style="line-height: 10px;">
      I have read and understood the terms & conditions on both sides of this agreement & 
agreed with my signature to the same and acknowledged that a) Disclaimer b) Credit Card 
Authorization c) Vehicle Checklist (for original and replacement vehicles) is part of this 
agreement  </p></tr>
    <tr><td colspan="2"><!--<hr noshade size=1>-->  </td></tr>
    <tr>
    <td  align="left" ><label style="color:#90a955">Customer Signature : </label>
    <td width="40%" align="left" ><label style="color:#90a955">Date : </label></td>
    </tr>
    
    <tr>
     
    <td colspan="3">&nbsp;</td>
     </tr>
     <tr> <td align="left" ><label >Rental Agent  : </label> &nbsp;
      <label id="raagent" name="raagent" ><s:property value="raagent"/></label>   </td>
        </table>
 
 </fieldset> 
 
    
    
  </td>
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
    