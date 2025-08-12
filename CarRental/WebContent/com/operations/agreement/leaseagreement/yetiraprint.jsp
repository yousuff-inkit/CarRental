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
  border: 1px solid rgb(139,136,120);

 }
 
    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
    
p{
	font-size: 10px;
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
    <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Lease Agreement</font></b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>&nbsp;&nbsp;LTNO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
   <%--  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b> --%>&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>LA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
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
    <td width="30%"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td> 

<td width="15%" align="right">Salesman</td>
   <td width="36%"><label id="salname" name="salname"><s:property value="salname"/></label></td> 
 

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
    <td width="77%" colspan="3"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="22%" align="left">Exp Date</td>
    <td width="20%" colspan="3"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
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
<table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>

<legend><b>Accidents</b></legend>
By initialing, I understand that in case of accident, even though availed CDW/SUPER CDW, must be accompanied by a valid police report. 
If without CDW/SUPER CDW, I will be liable to pay excess deductible  amount __________ <%-- amount of  AED .<label   id="excessinsu" name="excessinsu"><s:property value="excessinsu"/> --%></label>

<table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
<%-- <label style="text-align: right;display: block;" id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label> --%>
</tr>
</table>
</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend><b>Traffic/Parking Fines/Salik (Toll)</b></legend>
By initialing, I agree to pay all traffic/parking/other fines plus AED.50/-per fine and plus AED <label id="salikcharge"><s:property value="salikcharge"/></label> /- per Salik crossing  as surcharge, occurring during the agreement period. 
  <table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
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
  <legend><b>Terms & Conditions</b></legend> 
 <p align="justify">
  &nbsp;&nbsp;&nbsp;&nbsp;Lessee shall pay the Lessor the agreed rate charges as well as Taxes imposed. 
  The contract will be automatically extended on the due date without any intimation from the Lessee. 
  Rent Paid is non refundable and non adjustable. No Refund will be provided upon early termination of the rental agreement. Smoking in the car is strictly prohibited.
  If the vehicle returned with cigarette smell or unacceptable odor, the company reserves the right to charge AED1500. 
  In case of returning the car with dirty exterior and interior the Lessee shall pay AED 600 for interior cleaning and AED 100 for exterior. 
  The Lessee is responsible to return the car with the same fuel amount as given, otherwise Lessee shall pay the cost of a full tank of petrol that will be estimated by the Lessor.
  The Lessee is responsible for any Salik Charges, Toll Fees, Mall Parking Fees or Traffic Fines incurred during the time of the rental and Lessee authorizes the Lessor to debit the cost of penalties and/or damages to the vehicle to the Lessee's credit card. Toll fees/Salik Charges will be charged AED 5.00 per crossing whilst 15% service fee will be charged on top of each Traffic Fine including the knowledge fee and 10% service fee will be charged in addition to the Mall Parking charges.
  In case the Lessee incurred a traffic fine with black points, Lessee has to visit the respective traffic department within 24 hours period to remove black points failing which the Lessor will remove the black points on behalf of the Lessee and apply AED 1000.00 service charge per 4 black points. Fine related charges must be paid within 24hrs.
  If the vehicle has been damaged by the fault of Lessee or by an unknown third party, the lessee shall pay the damage excess charge of AED <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label> .
  Electric Vehicles should be returned with at least 100km charge, otherwise, a fee equivalent to 1 day rent will be applied. Vehicle recovery and any damage to the vehicle due to battery draining of Electric Cars will be charged to the Lessee. Lost Electric Vehicle Accessories will be charged to Lessee.
    

       </p>
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
    
    
        <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%"  >
   
        <tr> <td width="40%">Rent Type</td><td  width="20%" align="right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td><td  width="30%" >&nbsp; </td></tr>
        
       <tr> <td width="40%">Tariff</td><td  width="20%" align="right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td><td  width="30%" >&nbsp; </td></tr>
                
      <tr> <td width="40%">CDW</td><td  width="20%" align="right"><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
     
     <tr> <td width="40%">SUPER CDW</td><td  width="20%" align="right"><label id="rasupercdw" name="rasupercdw"><s:property value="rasupercdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
     
                 
      <tr> <td width="40%">PAI</td><td  width="20%" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
        <tr> <td width="40%">VMD</td><td  width="20%" align="right"><label id="ravmd" name="ravmd"><s:property value="ravmd"/></label></td><td  width="30%" >&nbsp; </td></tr>
         
       <tr> <td width="40%">Accessories</td><td  width="20%" align="right"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td><td  width="30%" >&nbsp; </td></tr>
       
              <tr> <td width="40%">Delivery Chrges</td><td  width="20%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
                    <tr> <td width="40%">Add Driver Charge</td><td  width="20%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="40%">Chaufer Charge</td><td  width="20%" align="right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>      
                    
              <tr> <td width="40%">Restrict KMS</td><td  width="20%" align="right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td><td  width="30%" >&nbsp; </td></tr>  
              
              
                <tr> <td width="40%">Excess KM Rate</td><td  width="20%" align="right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td><td  width="30%" >&nbsp; </td></tr>
                   
                    
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
  </table>
    </fieldset>
    
  
  
        <fieldset><legend><b>Termination Clauses</b></legend>  
      <table  width="100%"   >
   
        <tr><td  >&nbsp;<label id="termi1" name="termi1"><s:property value="termi1"/></label></td></tr> 
         <tr><td  >&nbsp;<label id="termi2" name="termi2"><s:property value="termi2"/></label></td></tr>
         <tr><td  >&nbsp;<label id="termi3" name="termi3"><s:property value="termi3"/></label></td></tr>
         <tr><td  >&nbsp;<label id="termi4" name="termi4"><s:property value="termi4"/></label></td></tr>
         <tr><td  >&nbsp;<label id="termi5" name="termi5"><s:property value="termi5"/></label></td></tr>      
               </table>     
 </fieldset>
  
  
  
 
  <table width="100%">
 <tr>
 <td  >
  <fieldset>
  <legend><b> تفاصيل سائق إضافية </b></legend> 
 <p  style="text-align: justify;text-align-last: right;">
ﯾ ﻰﻠﻋ رﺟﺄﺗﺳﻣﻟا ﻊﻓد ةرﺟﻷا قﻔﺗﻣﻟا ﺎﮭﯾﻠﻋ ﺔﻓﺎﺿﻹﺎﺑ ﻰﻟإ بﺋارﺿﻟا .ﺔﺿورﻔﻣﻟا مﺗﯾﺳ دﯾدﻣﺗ دﻘﻌﻟا ﺎﯾﺋﺎﻘﻠﺗ ﻲﻓ ﺦﯾرﺎﺗ قﺎﻘﺣﺗﺳﻻا نود يأ
 رﺎﻌﺷإ نﻣ .رﺟﺄﺗﺳﻣﻟا رﺎﺟﯾﻹا عوﻓدﻣﻟا رﯾﻏ لﺑﺎﻗ دادرﺗﺳﻼﻟ رﯾﻏو لﺑﺎﻗ .لﯾدﻌﺗﻠﻟ نﻟ مﺗﯾ مﯾدﻘﺗ يأ دادرﺗﺳا دﻧﻋ ءﺎﮭﻧإ دﻘﻋ رﺎﺟﯾﻹا .ارﻛﺑﻣ
 نﯾﺧدﺗﻟا ﻲﻓ ةرﺎﯾﺳﻟا عوﻧﻣﻣ .ﺎﻣﺎﻣﺗ اذإ مﺗ عﺎﺟرإ ةرﺎﯾﺳﻟا ﺔﺣﺋارﺑ رﺋﺎﺟﺳﻟا وأ ﺔﺣﺋار رﯾﻏ ،ﺔﻟوﺑﻘﻣ ظﻔﺗﺣﺗ ﺔﻛرﺷﻟا قﺣﻟﺎﺑ ﻲﻓ ضرﻓ ﺔﻣارﻏ ﺎھردﻗ
 1500 .مھرد ﻲﻓ ﺔﻟﺎﺣ ةدﺎﻋإ ةرﺎﯾﺳﻟا ﺢطﺳﺑ ﻲﺟرﺎﺧ ﻲﻠﺧادو ،ﺦﺳﺗﻣ بﺟﯾ ﻰﻠﻋ رﺟﺄﺗﺳﻣﻟا ﻊﻓد 600 مھرد فﯾظﻧﺗﻟ لﺧادﻟا و 100 مھرد
 فﯾظﻧﺗﻟ .جرﺎﺧﻟا لﻣﺣﺗﯾ رﺟﺄﺗﺳﻣﻟا ﺔﯾﻟوؤﺳﻣ ةدﺎﻋإ ةرﺎﯾﺳﻟا سﻔﻧﺑ ﺔﯾﻣﻛ دوﻗوﻟا ،ةﺎطﻌﻣﻟا ﻻإو فوﺳ نﯾﻌﺗﯾ ﮫﯾﻠﻋ ﻊﻓد ﺔﻔﻠﻛﺗ نازﺧ دوﻗو لﻣﺎﻛ
 ﻲﺗﻟاو ردﻘﺗﺳ نﻣ لﺑﻗ .رﺟؤﻣﻟا لﻣﺣﺗﯾ رﺟﺄﺗﺳﻣﻟا ﺔﯾﻟوؤﺳﻣ يأ موﺳر ،كﻟﺎﺳ موﺳر ،رورﻣ موﺳر فﻗوﻣ تارﺎﯾﺳﻟا ﻲﻓ ،لوﻣﻟا وأ تﺎﻣارﻏ
 رورﻣﻟا ﻲﺗﻟا ثدﺣﺗ لﻼﺧ ةرﺗﻓ ،رﺎﺟﯾﻹا ضوﻔﯾو رﺟﺄﺗﺳﻣﻟا رﺟؤﻣﻟا مﺻﺧﺑ ﺔﻔﻠﻛﺗ تﺎﻣارﻐﻟا وأ/و رارﺿﻷا ﻲﺗﻟا تﻘﺣﻟ ةرﺎﯾﺳﻟﺎﺑ نﻣ ﺔﻗﺎطﺑ
 نﺎﻣﺗﺋﻻا ﺔﺻﺎﺧﻟا .رﺟﺄﺗﺳﻣﻟﺎﺑ ضرﻔﺗﺳ موﺳر كﻟﺎﺳ/رورﻣﻟا لدﻌﻣﺑ 5.00 مھرد لﻛﻟ ،روﺑﻋ ﺎﻣﻧﯾﺑ ضرﻔﺗﺳ موﺳر ﺔﻣدﺧ ﺔﺑﺳﻧﺑ 15 % ﻰﻠﻋ
 لﻛ ﺔﻣارﻏ رورﻣ ﺎﻣﺑ ﻲﻓ كﻟذ موﺳر ،ﺔﻓرﻌﻣﻟا ضرﻔﺗﺳو موﺳر ﺔﻣدﺧ ﺔﺑﺳﻧﺑ 10 % ﺔﻓﺎﺿﻹﺎﺑ ﻰﻟإ موﺳر فﻗوﻣ تارﺎﯾﺳﻟا ﻲﻓ .لوﻣﻟا ﻲﻓ ﺔﻟﺎﺣ
 ضرﻌﺗ رﺟﺄﺗﺳﻣﻟا يﻷ ﺔﻣارﻏ ﺔﯾرورﻣ ﻊﻣ طﺎﻘﻧ ،ءادوﺳ بﺟﯾ ﻰﻠﻋ رﺟﺄﺗﺳﻣﻟا ةرﺎﯾز ةرادإ رورﻣﻟا ﺔﯾﻧﻌﻣﻟا لﻼﺧ 24 ﺔﻋﺎﺳ ﺔﻟازﻹ طﺎﻘﻧﻟا
 ،ءادوﺳﻟا ﻻإو موﻘﯾﺳ رﺟؤﻣﻟا ﺔﻟازﺈﺑ طﺎﻘﻧﻟا ءادوﺳﻟا ﺔﺑﺎﯾﻧ نﻋ رﺟﺄﺗﺳﻣﻟا ضرﻓو موﺳر ﺔﻣدﺧ ﺎھردﻗ 1000 مھرد لﻛﻟ 4 طﺎﻘﻧ .ءادوﺳ بﺟﯾ
 ﻊﻓد تﺎﻣارﻐﻟا ﺔﻘﻠﻌﺗﻣﻟا موﺳرﻟﺎﺑ لﻼﺧ 24 .ﺔﻋﺎﺳ اذإ تﺿرﻌﺗ ةرﺎﯾﺳﻟا فﻠﺗﻠﻟ بﺑﺳﺑ ﺄطﺧ نﻣ رﺟﺄﺗﺳﻣﻟا وأ نﻣ فرط ثﻟﺎﺛ رﯾﻏ ،فورﻌﻣ
 بﺟﯾ ﻰﻠﻋ رﺟﺄﺗﺳﻣﻟا ﻊﻓد موﺳر ضﯾوﻌﺗﻟا نﻋ رارﺿﻷا ﻎﻠﺑﻣﺑ <label id="lblcosmoexcessamt" name="lblcosmoexcessamt"><s:property value="lblcosmoexcessamt"/></label> . .مھرد بﺟﯾ ةدﺎﻋإ تﺎﺑﻛرﻣﻟا ﺔﯾﺋﺎﺑرﮭﻛﻟا ﻊﻣ نﺣﺷ ﻻ لﻘﯾ نﻋ
 100 ،مﻛ ﻻإو قﺑطﺗﺳ موﺳر لدﺎﻌﺗ رﺎﺟﯾإ موﯾ .دﺣاو مﺗﯾﺳ لﯾﻣﺣﺗ رﺟﺄﺗﺳﻣﻟا فﯾﻟﺎﻛﺗ ةدﺎﻌﺗﺳا ةرﺎﯾﺳﻟا يأو رارﺿأ قﺣﻠﺗ ﺎﮭﺑ ﺔﺟﯾﺗﻧ دﺎﻔﻧ ﺔﯾرﺎطﺑ
 تارﺎﯾﺳﻟا .ﺔﯾﺋﺎﺑرﮭﻛﻟا مﺗﯾﺳ لﯾﻣﺣﺗ رﺟﺄﺗﺳﻣﻟا ﺔﻔﻠﻛﺗ تﺎﻘﺣﻠﻣﻟا ةدوﻘﻔﻣﻟا ةرﺎﯾﺳﻠﻟ .
       </p>
       </fieldset>
</td>
</tr>
 
</table>
  <fieldset width="100%">
    <legend>
     <b>Signature</b></legend>
      
  
     <table  width="100%"   >
           <tr>
    <td> 
       I have read and understood the terms & conditions above  and agree with my signature to the same and acknowledge that 
       a) Disclaimer b) Credit Card Authorization  c) Vehicle Checklist (for original and replacement vehicles) are part of this agreement.</td>
    </tr>
    <tr><td><hr noshade size=1> <br></td></tr>
  
    <tr>
    <td align="left" > Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
 
     </table>
     <br>
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