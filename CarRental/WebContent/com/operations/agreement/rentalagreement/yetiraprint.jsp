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
    font: normal 9px ;
}


 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 
    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
    
p{
	font-size: 9px;
	font-family: Times new roman;
	align: justify;
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
#notes{
font-size: 9px;
 
	align: justify;
}
#sign{
font-size: 9px;   
 
	align: justify;
} 

table {
     font-size: 9px;
	
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
    <td width="20" rowspan="6" > &nbsp;
     </td> 
    <td width="56%" rowspan="2">&nbsp;</td>
    <td width="26%"> &nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Rental Agreement</font></b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>&nbsp;&nbsp;<font size="3">RANO :</font></b><b><font size="3"><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></font></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
</table>
<table width="100%" >
  <tr>
  <td width="50%">
  <fieldset>
  <table width="100%"> 
  <tr>
      <td width="18%" align="left" >Name &nbsp;  </td>
    <td width="82%" ><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
      <tr>
    <td  align="left">Address </td>
    <td height="40px" ><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="18%" align="left">MOB</td>
    <td width="82%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td> 
 <tr>
    <td  align="left">Email  </td>
    <td ><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details</b></legend>
    <table  width="100%" >
   <tr>
      <td width="20%" align="left">Name</td>
    <td width="82%" colspan="3">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label></td>
      
    </tr>
    </table>
        <table  width="100%" >
    <tr>
        <td  width="23%" align="left">D\L NO</td>
    <td width="30%" ><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
   
   <td width="22%" align="right">Exp Date</td>
    <td width="20%"  ><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td align="left">Passport NO</td>
    <td colspan="3"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="20%" align="left">Exp Date</td>
    <td width="30%"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   

    <td width="15%" align="right">DOB&nbsp;&nbsp;</td>
    <td width="30%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    <tr>
    
      <td width="15%" align="left">Nationality&nbsp;&nbsp;</td>
    <td width="30%" colspan="3"><label name="lblnation" id="lblnation" ><s:property value="lblnation"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details</b></legend>
    <table  width="100%"  >
   <tr>
      <td width="20%" align="left"></td>
          <td width="40%" align="left">Additional Driver One</td>
    
     <td width="40%" align="left">Additional Driver Two</td>
   
    </tr>
     <tr> 
      <td width="" align="left">Name</td>  
        <td width="" ><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
   
      <td width="" ><label id="adddrname2" name="adddrname2"><s:property value="adddrname2"/></label></td>
   
    </tr>
      <tr>
      <td width="" align="left">D\L NO</td>
        <td width="" ><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
   
      <td width="" ><label id="addlicno2" name="addlicno2"><s:property value="addlicno2"/></label></td>
   
    </tr>
    <tr>
      <td width="" align="left">Exp Date</td>
        <td width="" ><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
   
      <td width="" ><label id="expdate2" name="expdate2"><s:property value="expdate2"/></label></td>
   
    </tr>
     <tr>
      <td width="" align="left">DOB</td>
        <td width="" ><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
   
      <td width="" ><label id="adddob2" name="adddob2"><s:property value="adddob2"/></label></td>
   
    </tr>
    </table>

</fieldset>
<table width="100%"  id="notes">
 <tr>
 <td   width="100%">
 <fieldset>

<legend><b>Accidents</b></legend>
&nbsp;&nbsp;Be initialling, I understand that in case of accident, even though availed CDW, must be accompanied by a valid police report. If without CDW, I will be liable to pay excess deductible amount. If Police report is not available, I’ll be liable for any damages according to company pricelist. Insurance is not covering scratches occurring without accident, damage to tyres and windows. 

 
</fieldset>
</td>
</tr>
<tr>
<td width="100%">

 <fieldset >
<legend><b>Security</b></legend>

  <table width="100%"  >
<tr><td  width="28%">Credit Card Number</td><td width="31%"  >: <label id="securitycardno" name="securitycardno"><s:property value="securitycardno"/></label> </td><td  width="21%">Expiry Date</td><td width="17%"  >: <label id="securityexpdate" name="securityexpdate"><s:property value="securityexpdate"/></label></td></tr>
<tr><td   >Pre Auth No.</td><td   >: <label id="securitypreauthno" name="securitypreauthno"><s:property value="securitypreauthno"/></label></td><td  >Pre Auth Amt.</td><td>: <label id="securitypreauthamt" name="securitypreauthamt"><s:property value="securitypreauthamt"/></label></td></tr>
<%-- <label style="text-align: right;display: block;" id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
 
</table>

&nbsp;&nbsp;By providing this card for pre-authorization, Lessee hereby authorizes the Lessor to debit any outstanding charges related to the use of the vehicle from this card, including, but not limited by: Rent Payment, Salik, Traffic Fines, Smoking Fine, Damages to the vehicle, insurance excess amount; even if the amount is bigger then the pre-authorisation amount. 

</fieldset>
 </td>
 </tr>
 
 </table>
 
 <table width="100%">
 <tr>
 <td>
  <fieldset>
  <legend><b>Terms & Conditions</b></legend> 
 <p align="justify">
 <%--  &nbsp; &nbsp; &nbsp;Lessee shall pay the Lessor the agreed rate charges as well as Taxes imposed. The contract will be automatically extended on the due date without any intimation from the Lessee. Rent Paid is non-refundable and non-adjustable. No Refund will be provided upon early termination of the rental agreement. Smoking in the car is strictly prohibited. If the vehicle returned with cigarette smell or unacceptable odor, the company reserves the right to charge AED1500. In case of returning the car with dirty exterior and interior the Lessee shall pay AED 600 for interior cleaning and AED 100 for exterior. The Lessee is responsible to return the car with the same fuel amount or charge percentage (for electric cars) as given, otherwise Lessee shall pay the cost of a full tank of petrol or AED 100 for electric cars. Electric Vehicles should be returned with at least 100 km charge, otherwise, a fee equivalent to 1 day rent will be applied. The cost of charging the electric vehicle using Superchargers will be the responsibility of the Lessee. Charges will be based on the amount of charging consumption during each individual charging session. Idle Fees might also be applied for leaving the car in charging station while the charging session is complete, and fees depends on the idle period. The Lessee is responsible for any Salik Charges, Toll Fees, Mall Parking Fees or Traffic Fines incurred during the time of the rental and Lessee authorizes the Lessor to debit the cost of penalties and/or damages to the vehicle to the Lessee's credit card. Toll fees/Salik Charges will be charged AED 5.00 per crossing whilst AED 60.00 service fee will be charged on top of each Traffic Fine including the knowledge fee and 10% service fee will be charged in addition to the Mall Parking charges. In case the Lessee incurred a traffic fine with black points, Lessee has to visit the respective traffic department within 24 hours period to remove black points failing which the Lessor will remove the black points on behalf of the Lessee and apply AED 1000.00 service charge per 4 black points. Fine related charges must be paid within 48hrs. If the vehicle has been damaged by the fault of Lessee or by an unknown third party, the lessee shall pay the damage excess charge of AED   <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label> 
plus 10% of the claim amount to be added for Coupe / Sport / Electric vehicles. Vehicle recovery and any damage to the vehicle due to battery draining of Electric Cars will be charged to the Lessee. Lost Electric Vehicle Accessories will be charged to Lessee.       </p>
 --%>  
  &nbsp; &nbsp; &nbsp;Lessee shall pay the Lessor the agreed rate charges as well as Taxes imposed. The contract will be automatically extended on the due date without any intimation from the Lessee. Rent Paid is non refundable and non adjustable. No Refund will be provided upon early termination of the rental agreement. Smoking in the car is strictly prohibited. If the vehicle returned with cigarette smell or unacceptable odor, the company reserves the right to charge AED1500. In case of returning the car with dirty exterior and interior the Lessee shall pay AED 600 for interior cleaning and AED 100 for exterior. The Lessee is responsible to return the car with the same fuel amount or charge percentage (for electric cars) as given, otherwise Lessee shall pay the cost of a full tank of petrol or AED 100 for electric cars. Electric Vehicles should be returned with at least 100 km charge, otherwise, a fee equivalent to 1 day rent will be applied. The cost of charging the electric vehicle using Superchargers will be the responsibility of the Lessee. Charges will be based on the amount of charging consumption during each individual charging session. Idle Fees might also be applied for leaving the car in charging station while the charging session is complete, and fees depends on the idle period.The Lessee is responsible for any Salik Charges, Toll Fees, Mall Parking Fees or Traffic Fines incurred during the time of the rental and Lessee authorizes the Lessor to debit the cost of penalties and/or damages to the vehicle to the Lessee's credit card. Toll fees/Salik Charges will be charged AED 6.00 (Peak hrs) and AED 4.00 (Off-Peak hrs) per crossing whilst AED 60.00 service fee will be charged on top of each Traffic Fine including the knowledge fee and 10% service fee will be charged in addition to the Mall Parking charges. In case the Lessee incurred a traffic fine with black points, Lessee has to visit the respective traffic department within 24 hours period to remove black points failing which the Lessor will remove the black points on behalf of the Lessee and apply AED 1000.00 service charge per 4 black points. Fine related charges must be paid within 48hrs. If the vehicle has been damaged by the fault of Lessee or by an unknown third party, the lessee shall pay the damage excess charge of AED <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label>
   plus 10% of the claim amount to be added for Coupe / Sport / Electric vehicles . Vehicle recovery and any damage to the vehicle due to battery draining of Electric Cars will be charged to the Lessee. Lost Electric Vehicle Accessories will be charged to Lessee.   </p>
 
      </fieldset>
</td>
</tr>
 
</table>

  </td>
  <td width="50%">
  <fieldset>
  <legend><b> Vehicle</b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="52%" ><label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>
    <td width="30%">Color&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td align="left">Reg NO&nbsp;<label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label></td>
 
     <td align="left" colspan="2">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Out Details</b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="10%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
             <th width="19%" align="center">Signature</th>
  </tr>
  <tr>
  <td><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
<td><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
  </tr>
  <tr>
 <td>Due Date </td> <td> <label id="duedate" name="duedate"><s:property value="duedate"/></label></td>
 </tr>
 <tr>
  <td>Date In </td> <td>  &nbsp;</td>
  
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
    
    <table width="100%">
    <tr>
    <td width="60%">
        <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%"  >
   
        <tr> <td width="49%">Rent Type</td><td  width="20%" align="right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td><td  width="20%" align="right" >Total </td><td width="1%">&nbsp;</td></tr>
        
       <tr> <td width="49%">Tariff</td><td  width="20%" align="right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td><td  width="20%" align="right" ><label id="tarifftotal" name="tarifftotal"><s:property value="tarifftotal"/></label> </td><td width="1%">&nbsp;</td></tr>
      <tr> <td width="49%">Extra Shield</td><td  width="20%" align="right"><label id="Selcarcdw" name="Selcarcdw"><s:property value="Selcarcdw"/></label></td><td  width="20%" align="right" ><label id="Selcarcdwtotal" name="Selcarcdwtotal"><s:property value="Selcarcdwtotal"/></label> </td><td width="1%">&nbsp;</td></tr>
        
     <%--  <tr> <td width="49%">CDW</td><td  width="20%" align="right"><label id="Selcarcdw" name="Selcarcdw"><s:property value="Selcarcdw"/></label></td><td  width="20%" align="right" ><label id="Selcarcdwtotal" name="Selcarcdwtotal"><s:property value="Selcarcdwtotal"/></label> </td><td width="1%">&nbsp;</td></tr> --%>
      <tr> <td width="49%">Cardoo</td><td  width="20%" align="right"><label id="selcarcdw1" name="Selcarcdw1"><s:property value="Selcarcdw1"/></label></td><td  width="20%" align="right" ><label id="Selcarcdw1total" name="Selcarcdw1total"><s:property value="Selcarcdw1total"/></label> </td><td width="1%">&nbsp;</td></tr>
  
                
    <%--  <tr> <td width="49%">CDW</td><td  width="20%" align="right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td><td  width="20%" align="right" ><label id="racdwscdwtotal" name="racdwscdwtotal"><s:property value="racdwscdwtotal"/></label> </td><td width="1%">&nbsp;</td></tr>
     
      <tr> <td width="40%">SUPER CDW</td><td  width="20%" align="right"><label id="rasupercdw" name="rasupercdw"><s:property value="rasupercdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
     
                 
      <tr> <td width="40%">PAI</td><td  width="20%" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
        <tr> <td width="40%">VMD</td><td  width="20%" align="right"><label id="ravmd" name="ravmd"><s:property value="ravmd"/></label></td><td  width="30%" >&nbsp; </td></tr>
          --%>
       <tr> <td width="49%">Accessories</td><td  width="20%" align="right"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td><td  width="20%" align="right" ><label id="raaccessorytotal" name="raaccessorytotal"><s:property value="raaccessorytotal"/></label> </td><td width="1%">&nbsp;</td></tr>
       
              <tr> <td width="49%">Delivery Chrges</td><td  width="20%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="20%" align="right" ><label id="laldelchargetotal" name="laldelchargetotal"><s:property value="laldelchargetotal"/></label> </td><td width="1%">&nbsp;</td></tr>
      
                <%--     <tr> <td width="40%">Add Driver Charge</td><td  width="20%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="40%">Chaufer Charge</td><td  width="20%" align="right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>       --%>
               </table>
               </fieldset>

 <fieldset><legend><b>Advance</b></legend>  
      <table  width="100%"  >
      
              <tr> <td width="40%">Total</td><td  width="20%" align="right"><label id="advtotalamont" name="advtotalamont"><s:property value="advtotalamont"/></label></td><td  width="30%" >&nbsp; </td></tr>  
              
              
                <tr> <td width="40%">Paid Amount</td><td  width="20%" align="right"><label id="advpaidamount" name="advpaidamount"><s:property value="advpaidamount"/></label></td><td  width="30%" >&nbsp; </td></tr>
                
                 <tr> <td width="40%">Balance</td><td  width="20%" align="right"><label id="advbalance" name="advbalance"><s:property value="advbalance"/></label></td><td  width="30%" >&nbsp; </td></tr>
            </table>       
          </fieldset> 
          <br>
          <fieldset> 
   
            <table  width="100%"  >
      
              <tr> <td width="40%">Restrict KMS</td><td  width="20%" align="right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td><td  width="30%" >&nbsp; </td></tr>  
              
              
                <tr> <td width="40%">Excess KM Rate</td><td  width="20%" align="right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td><td  width="30%" >&nbsp; </td></tr>
            </table>
          
            </fieldset>  
            </td>
            <td width="40%">&nbsp;
            
            <fieldset><legend><b>Close Details</b></legend>  
            
            <table width="100%">
 
<tr><td>Tariff</td><td> &nbsp;</td>  </tr>
<tr><td>Advance</td><td> &nbsp;</td>  </tr>
<tr><td>Balance</td><td> &nbsp;</td>  </tr>
<tr><td>Salik</td><td> &nbsp;</td>  </tr>
<tr><td>Fine</td><td> &nbsp;</td>  </tr>
<tr><td>Collection Charge</td><td> &nbsp;</td>  </tr>
<tr><td>Excess KM</td><td> &nbsp;</td>  </tr>
<tr><td>Fuel Charge</td><td> &nbsp;</td>  </tr>
<tr><td>Damage Charge</td><td> &nbsp;</td>  </tr>
<tr><td>Other Charge</td><td> &nbsp;</td>  </tr>
<tr><td>Total Balance</td><td> &nbsp;</td>  </tr>
  <tr><td>&nbsp;</td><td> &nbsp;</td>  </tr>
  <tr><td>&nbsp;</td><td> &nbsp;</td>  </tr>
            </table>
            </fieldset>
           
            </td>
            </tr>
            </table>
          
           
                
<%--       <tr>
      <td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>   <td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
       <td width="18%" align="right">CDW&nbsp;&nbsp;</td>   <td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    </tr>
    </table>
     
    <table  width="100%"  >
       <tr><td width="15%">Accessories</td><td width="25%"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%">Add Driver Charges </td><td width="25%"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%">Extra KM</td><td width="25%"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%">Extra KM Charge</td><td width="25%"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr> --%>
 
  
    
 
    

 
  <table width="100%">
 <tr>
 <td  >
  <fieldset>
  <legend><b> تفاصيل سائق إضافية </b></legend> 
<%-- <p  style="text-align: justify;text-align-last: right;"> 
يجب على المستأجر دفع الرسوم المتفق عليها بالإضافة إلى الضرائب المفروضة. سيتم تمديد العقد تلقائيًا في تاريخ الاستحقاق دون أي إشعار من المستأجر. الإيجار المدفوع غير قابل للاسترداد وغير قابل للتعديل. لا يتم تقديم أي استرداد في حال إنهاء العقد مبكرًا. يُمنع التدخين في السيارة تمامًا. إذا تم إعادة السيارة مع رائحة السجائر أو رائحة غير مقبولة، تحتفظ الشركة بالحق في فرض رسوم قدرها 1500 درهم. في حال إعادة السيارة مع خارج وداخل متسخ، يجب على المستأجر دفع 600 درهم لتنظيف الداخل و 100 درهم لتنظيف الخارج. يتحمل المستأجر مسؤولية إعادة السيارة بنفس كمية الوقود أو النسبة المئوية للشحن (بالنسبة للسيارات الكهربائية) كما كانت عند الاستلام، وإلا يجب على المستأجر دفع تكلفة خزان وقود كامل أو 100 درهم للسيارات الكهربائية. يجب إعادة السيارات الكهربائية مع شحن لا يقل عن 100 كم، وإلا سيتم فرض رسوم تعادل إيجار يوم كامل. سيكون المستأجر مسؤولاً عن تكلفة شحن السيارة الكهربائية باستخدام محطات الشحن السريع ، وستكون الرسوم بناءً على كمية استهلاك الشحن في كل جلسة شحن فردية. قد يتم فرض رسوم انتظار أيضًا في حال ترك السيارة في محطة الشحن بعد إتمام عملية الشحن، وتعتمد الرسوم على مدة الانتظار. يتحمل المستأجر المسؤولية عن أي رسوم سالك، ورسوم المرور، ورسوم مواقف المولات أو المخالفات المرورية التي يتم تكبدها أثناء فترة الإيجار، ويصرح المستأجر للمؤجر بخصم تكلفة المخالفات و/أو الأضرار التي تلحق بالسيارة من بطاقة الائتمان الخاصة بالمستأجر. سيتم فرض رسوم سالك/رسوم عبور بمقدار 5.00 درهم لكل عبور، بالإضافة إلى رسوم خدمة قدرها 60.00 درهم على كل مخالفة مرورية تشمل رسوم المعرفة، كما سيتم فرض رسوم خدمة بنسبة 10% على رسوم مواقف المولات. في حال تعرض المستأجر لمخالفة مرورية مع نقاط سوداء، يجب على المستأجر زيارة دائرة المرور المعنية خلال 24 ساعة لإزالة النقاط السوداء، وفي حال عدم القيام بذلك، سيتولى المؤجر إزالة النقاط السوداء نيابة عن المستأجر مع فرض رسوم خدمة قدرها 1000.00 درهم لكل 4 نقاط سوداء. يجب دفع رسوم المخالفات خلال 48 ساعة. في حال تم تلف السيارة بسبب خطأ من المستأجر أو بواسطة طرف ثالث مجهول، يجب على المستأجر دفع رسوم تحمل الضرر التي تبلغ  <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label> درهم. بالإضافة إلى 10% من مبلغ المطالبة ليتم إضافتها للمركبات الكوبيه / الرياضية / الكهربائية. سيتم تحميل المستأجر تكلفة استرداد المركبة وأي ضرر للمركبة بسبب نفاد البطارية للمركبات الكهربائية. سيتم تحميل المستأجر تكلفة ملحقات المركبة الكهربائية المفقودة

 </p> --%>
 
 
 <p  style="text-align: justify;text-align-last: right;"> 

يجب على المستأجر دفع الرسوم المتفق عليها بالإضافة إلى الضرائب المفروضة. سيتم تمديد العقد تلقائيًا في تاريخ الاستحقاق دون أي إشعار من المستأجر. الإيجار المدفوع غير قابل للاسترداد وغير قابل للتعديل. لا يتم تقديم أي استرداد في حال إنهاء العقد مبكرًا. يُمنع التدخين في السيارة تمامًا. إذا تم إعادة السيارة مع رائحة السجائر أو رائحة غير مقبولة، تحتفظ الشركة بالحق في فرض رسوم قدرها 1500 درهم. في حال إعادة السيارة مع خارج وداخل متسخ، يجب على المستأجر دفع 600 درهم لتنظيف الداخل و 100 درهم لتنظيف الخارج. يتحمل المستأجر مسؤولية إعادة السيارة بنفس كمية الوقود أو النسبة المئوية للشحن (بالنسبة للسيارات الكهربائية) كما كانت عند الاستلام، وإلا يجب على المستأجر دفع تكلفة خزان وقود كامل أو 100 درهم للسيارات الكهربائية. يجب إعادة السيارات الكهربائية مع شحن لا يقل عن 100 كم، وإلا سيتم فرض رسوم تعادل إيجار يوم كامل. سيكون المستأجر مسؤولاً عن تكلفة شحن السيارة الكهربائية باستخدام محطات الشحن السريع ، وستكون الرسوم بناءً على كمية استهلاك الشحن في كل جلسة شحن فردية. قد يتم فرض رسوم انتظار أيضًا في حال ترك السيارة في محطة الشحن بعد إتمام عملية الشحن، وتعتمد الرسوم على مدة الانتظار. يتحمل المستأجر المسؤولية عن أي رسوم سالك، ورسوم المرور، ورسوم مواقف المولات أو المخالفات المرورية التي يتم تكبدها أثناء فترة الإيجار، ويصرح المستأجر للمؤجر بخصم تكلفة المخالفات و/أو الأضرار التي تلحق بالسيارة من بطاقة الائتمان الخاصة بالمستأجر. سيتم فرض رسوم سالك/رسوم عبور بمقدار 6.00 درهم لكل عبور في  ( وقت الذروة ) وخارج ( وقت الذروة ) 4.00 درهم ، بالإضافة إلى رسوم خدمة قدرها 60.00 درهم على كل مخالفة مرورية تشمل رسوم المعرفة، كما سيتم فرض رسوم خدمة بنسبة 10% على رسوم مواقف المولات. في حال تعرض المستأجر لمخالفة مرورية مع نقاط سوداء، يجب على المستأجر زيارة دائرة المرور المعنية خلال 24 ساعة لإزالة النقاط السوداء، وفي حال عدم القيام بذلك، سيتولى المؤجر إزالة النقاط السوداء نيابة عن المستأجر مع فرض رسوم خدمة قدرها 1000.00 درهم لكل 4 نقاط سوداء. يجب دفع رسوم المخالفات خلال 48 ساعة. في حال تم تلف السيارة بسبب خطأ من المستأجر أو بواسطة طرف ثالث مجهول، يجب على المستأجر دفع رسوم تحمل الضرر التي تبلغ  <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label> درهم. بالإضافة إلى 10% من مبلغ المطالبة ليتم إضافتها للمركبات الكوبيه / الرياضية / الكهربائية. سيتم تحميل المستأجر تكلفة استرداد المركبة وأي ضرر للمركبة بسبب نفاد البطارية للمركبات الكهربائية. سيتم تحميل المستأجر تكلفة ملحقات المركبة الكهربائية المفقودة 

 </p>
       </fieldset>
</td>
</tr>
 
</table>
  <fieldset width="100%">
    <legend>
     <b>Signature</b></legend>
      
  
     <table  width="100%"  id="sign" >
           <tr>
    <td> 
      I have read and understood the T&C of this contract printed on both sides. I agree with my signature and acknowledge that Vehicle Check In/Out report for original and replacement vehicles are the part of this agreement. All replaces vehicles apply with the same T&C.</td>
    </tr>
    <tr><td><hr noshade size=1>  </td></tr>
  
    <tr>
    <td align="left" > Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
   <tr><td><hr noshade size=1>  </td></tr>
     <tr> <td align="left" > Sales Agent	
      &nbsp; <label id="salagent" name="salagent"><s:property value="salagent"/></label></td></tr>
            <tr> <td align="left" >  Date </td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
        <tr> <td align="left" >  Rental Agent   &nbsp;
      <label id="raagent" name="raagent"><s:property value="raagent"/></label>   </td></tr>
      
      
      <tr> <td align="left" >  Date </td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      
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
    