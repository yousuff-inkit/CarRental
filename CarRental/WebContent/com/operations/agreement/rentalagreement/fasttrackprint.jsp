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
p.page { page-break-after: always; }
 .hidden-scrollbar {
  overflow: auto;
/*height: 600px;*/
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
<body onload="gridload();" bgcolor="white" style="font: 9.5px Tahoma " >
<div id="mainBG" class="homeContent" data-type="background">
<div class='hidden-scrollbar'>
<form id="frmInvoicePrint" action="printrental" autocomplete="off" target="_blank">
 <div style="background-color:white;">
      <table width="100%">
 	 <tr>
  		<%-- <img src="<%=contextPath%>/icons/headercarfare.jpg"/> --%>
    <td rowspan="6"> <div style="width: 100%; height: 130px;">&nbsp;</div> 
    </td>
    </tr>
   </table>
 <table width="100%">
	 <tr><td align="center"><b><font size="3" >Rental Agreement</font></b></td></tr>
	 <tr><td align="center"><b><font size="3" >&nbsp;</font></b></td></tr>
 </table>
 
    <%-- <td width="36%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td> --%>
 
  <%-- <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"></font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Fax :</b>&nbsp;<label id="lblindigobranchfax" name="lblindigobranchfax"><s:property value="lblindigobranchfax"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center">
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
  
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr> --%>
</table> 
<table width="100%" >
	<tr>
		<td width="33.33%" align="left"><b>RA NO :<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b></td>
		<td width="36.5%" align="center"></td>
		<td width="33.33%" align="left"><b>RA STATUS:</b><b>&nbsp;<label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
	<tr>
	<td width="33.33%" align="left">Manual RA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></td>
	</tr>
</table>
<table width="100%">
	<tr>
		<td colspan="2" width="40%"><b>Lessor (License Name)</b> <label id="companyname" name="companyname"><s:property value="companyname"/></label></td>
		<td width="30%">&nbsp;</td>
		<td colspan="2" width="40%"><b>Branch</b>:&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
	<tr>
		<td colspan="2" width="40%"> </td>
		<td width="30%">&nbsp;</td>
		<td colspan="2" width="40%"><b>LPO NO</b>:&nbsp;<label id="clsiclpo" name="clsiclpo"><s:property value="clsiclpo"/></label></td>
	</tr>
	<tr>
		<%-- <td>Tel: <label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
		<td>Branch Mob: <label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
		 --%><td>&nbsp;</td>
		<td colspan="2"></td>
	</tr>
</table>
<table width="100%" >

  <tr>
  <td width="50%" valign="top">
  <fieldset><legend><b>Client Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل زبون</b></legend>

  <table width="100%" > 
  
  <tr>
  	<td width="18%" align="left" >Client ID &nbsp;  </td>
    <td width="82%" >:<label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td  align="left" >Name &nbsp;  </td>
    <td>:<label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
   
      <tr>
    <td  align="left">Address </td>
    <td height="20px" >:<label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="18%" align="left">MOB</td>
    <td width="82%">:<label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td  align="left">Email  </td>
    <td >:<label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق</b></legend>
    <table  width="100%">
   <tr>
      <td width="18%" align="left">Name</td>
    <td width="82%" colspan="3">:&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label> </td>
      
    </tr>
    <tr>
        <td  width="18%" align="left">D\L NO</td>
    <td width="82%" colspan="3">:&nbsp;<label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="18%" align="left">Exp Date</td>
    <td width="82%" colspan="3">:&nbsp;<label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td  width="18%" align="left">Passport NO</td>
    <td colspan="82">:&nbsp;<label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="18%" align="left">Exp Date</td>
    <td width="82%">:&nbsp;<label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   </tr>
     <tr>
     <td  align="left" >Nationality &nbsp;  </td>
    <td >:&nbsp;<label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
 
<tr>
    <td align="left">D.O.B&nbsp;&nbsp;</td>
    <td >:&nbsp;<label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    <tr>
    <td align="left">Mobile No.&nbsp;&nbsp;</td>
    <td>:&nbsp;<label name="drivermobno" id="drivermobno" ><s:property value="drivermobno"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="18%" align="left">Name</td>
      <td width="32%" >:<label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="18%">Nationality</td>
      <td width="32%">:<label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td align="left">D\L NO</td>
      <td >:<label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td>Mobile</td>
      <td>:<label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left">Exp Date</td>
        <td width="" >:<label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <td>Signature</td><td>:</td>
    </tr>
     <tr>
      <td width="" align="left">DOB</td>
        <td width="" >:<label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<td height="35px" colspan="2">____________________________</td>
    </tr>
    </table>

</fieldset>
<fieldset><legend><b>Credit Card Details</b></legend>
    						<table  width="100%"  >
   <tr> 
  	  <td width="20%" align="left">Cr. Card Type</td>
      <td width="30%" >:<label id="cardtype" name="cardtype"><s:property value="cardtype"/></label></td>
       </tr>
    
    <tr>
    <td width="20%">Credit Card No </td>
      <td width="30%">:<label id="lblcosmocreditcardno" name="lblcosmocreditcardno"><s:property value="lblcosmocreditcardno"/></label></td>
   
      <td width="40" align="left">Exp Date</td>
        <td width="" >:<label id="lblcosmocreditvaliddate" name="lblcosmocreditvaliddate"><s:property value="lblcosmocreditvaliddate"/></label></td>    
    </tr>
     
    </table>
    </fieldset>
    <fieldset><legend><b>Remarks</b></legend>
    						<table  width="100%"  >
   <tr> 
  	  <td width="20%" align="left">Remarks</td>
      <td width="80%" >:<label id="cldesc" name="cldesc"><s:property value="cldesc"/></label></td>
       </tr>
     
    </table>
    </fieldset>

  </td>
  <td width="50%" valign="top">
  <fieldset>
  <legend><b>Vehicle Details&nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل نوع المركبة </b></legend>
     <table width="100%" >  
  <tr>
    
    <td width="82%" >Vehicle Type&nbsp;:<label id="ravehname" name="ravehname"><s:property value="ravehname"/></label></td>
    <td align="left" >YOM&nbsp;:<label id="rayom" name="rayom"><s:property value="rayom"/></label></td>  
    
    </tr>
    </table>
    <table width="100%">
     <tr>
      <td  width="45%">Reg NO&nbsp;:<label id="ravehauthregno" name="ravehauthregno"><s:property value="ravehauthregno"/></label> &nbsp;&nbsp;</td>
      <td width="30%" >Color&nbsp;:<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>  
     <td width="25%">Group&nbsp;:<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b>Vehicle Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table>
  <tr>
    <th align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left">Date</th>
       <th width="22%" align="left">Time</th>
          <th width="22%" align="left">Km</th>
             <th width="19%" align="left">Fuel</th>
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
        
 
     <fieldset><legend><b>Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
      
    <table  width="100%" >
       <tr><td width="15%">Rent Type</td><td width="25%">:<label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td></tr>
       <tr>
       <td width="35%">Rate  </td><td width="25%">:<label id="tariff" name="tariff"><s:property value="tariff"/></label></td></tr>
        <tr><td width="35%">CDW (Collision Damage Waiver)</td><td width="25%">:<label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td></tr>
       <tr><td width="35%">PAI (Personal Accident Insurance)</td><td width="25%">:<label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td></tr>
       <tr><td width=35%>Delivery Charges </td><td width="25%">:<label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td></tr>
       <tr><td width=35%>Additional Driver Charges  </td><td width="25%">:<label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
       <tr><td width=35%>Approved Mileage KMs  </td><td width="25%">:<label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td></tr>
       <tr><td width=35%>Excess KM Rate  </td><td width="25%">:<label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width=35%>Fuel Charge </td><td width="25%">:<label id="lblcosmofuelin" name="lblcosmofuelin"><s:property value="lblcosmofuelin"/></label></td></tr>
  </table>
    </fieldset>
     <fieldset>
     <table>
    <legend><b>Return Date </b></legend>  
      
 <tr><td width=35%>Agreed Return Date & Time</td></tr>
 <tr>
 <td width="25%">Date:<label id="lbldatein" name="lbldatein"><s:property value="duedate"/></label></td></tr>
 <tr>
 <td width="25%">Time:<label id="lbltimein" name="lbltimein"><s:property value="duetime"/></label></td></tr>
 </table>
  </fieldset>   
     <fieldset><legend><b>Accident Excess Charge</b></legend>
    						<table  width="100%" >
   <tr> 
  	  <td width="20%" align="left">
  	  <p>Renter declines CDW (Collision Damage Waiver) and agrees to pay Accident Excess
  	   Charge of AED &nbsp;&nbsp;<b><s:property value="excessinsu"/></b>&nbsp;&nbsp; for each accident/ damage due to own mistake, or “Hit & Run” cases. 
  	   However, a valid POLICE REPORT is mandatory for both the cases. 
  	  </p></td>
       </tr>
       <tr hidden="true">
       <td>Customer Signature : _________________________________________
       </td></tr>
     
    </table>
    					</fieldset>
  </td>
    </tr>

    	<tr>
    		<td colspan="2">
    			<div><b><p>&nbsp;&nbsp;&nbsp;Note: Value Added Tax (VAT) will be applicable extra for the rental and other services </p></b></div>
    			<fieldset><legend><b>Terms & Conditions</b></legend>
    				<p >
    				    I acknowledge in the event of any accident, I will obtain a valid POLICE REPORT. 
    					Failure to do so could result in legal action, and further void all insurances, 
    					rendering me liable for all cost incurred by the Lessor. This vehicle cannot be taken outside the
    				    U.A.E without the permission of Owner. By this signature, I/ we hereby agree to the Terms & Conditions 
    				    mentioned on both sides of this agreement.
    				</p>
    				<table width="100%" >
    					<tr>
    				 		<td width="10%">Sales Person </td>
                      		<td width="40%" align="left">:<label id="salname" name="salname"><s:property value="salname"/></label></td>
                		</tr>
    				 	<tr>
    				  		<td width="10%">Rental Agent </td>
                      		<td width="40%" align="left">: <label id="raagent" name="raagent"><s:property value="raagent"/></label></td>
                      		<td width="10%">Customer</td>
                      		<td width="40%" align="left">:<label id="clname" name="clname"><s:property value="clname"/></label></td>
                     	</tr>
					</table>
                    <table width="100%">
                    	<tr>
                     		<td></td>
                     	</tr>
                     	<tr><td>&nbsp;</td></tr>
                     	<tr><td>&nbsp;</td></tr>
                     	<tr>
                     		<td width="10%" >Signature&nbsp;</td><td width="40%">: _____________________________________________</td>
                     		<td width="10%" >Signature&nbsp;</td><td width="40%" style="position:relative;">:<img src='<s:property value="signpath"/>' style="width:100px;height:auto;position:absolute;top:0;margin-top:-40px;">_____________________________________________</td>
                     	</tr>
                     	<tr>
                     		<td width="10%">Date&nbsp;</td><td width="40%">: <label id="lblcurrentdate" name="lblcurrentdate"><s:property value="lblcurrentdate"/></label></td>
                     		<td width="10%">Date&nbsp;</td><td width="40%">: </td>
                     	</tr>
                     <!-- <tr><td>&nbsp;</td>
                     </tr> -->
                     
    				</table>
    			</fieldset>	
    		</td>
    	</tr>
    	
    		</table>
    		
    		</div>
 <!--
   <table height="100%" hidden="true">
<tr><td align="left"  width="94%" rowspan="1"><img src="<%=contextPath%>/icons/fasttrackRental.jpg" width="100%" height="120%" alt=""/></td> 
<td width="46%" rowspan="1">&nbsp;</td>
  </tr></table> 
<br>
    		<table width="100%" style="height: 120%;" >
    	<tr><td align="center"><b><font size="3" > </font></b></td></tr>	 
	 <tr><td align="center"><b><font size="3" > Order</font></b></td></tr>   
	 <tr><td align="center"><b><font size="3" >&nbsp;</font></b></td></tr>
            </table>
           <table width="100%" >

  <tr>
  <td width="50%" valign="top">
  <fieldset><legend><b>Customer Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل زبون</b></legend>

  <table width="100%" > 
  
  <tr>
  	<td width="18%" align="left" >Client ID &nbsp;  </td>
    <td width="82%" >:<label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td  align="left" >Name &nbsp;  </td>
    <td>:<label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
   
      <tr>
    <td  align="left">Address </td>
    <td height="20px" >:<label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" >
      <tr>
    <td width="18%" align="left">MOB</td>
    <td width="82%">:<label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td  align="left">Email  </td>
    <td >:<label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
     <tr>
    <td  align="left">Nationality  </td>
    <td >:<label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق</b></legend>
    <table  width="100%">
   <tr>
      <td width="18%" align="left">Name</td>
    <td width="82%" colspan="3">:&nbsp;<label id="kmdriver" name="kmdriver"><s:property value="kmdriver"/></label> </td>
   </tr>
<tr>
    <td align="left">D.O.B&nbsp;&nbsp;</td>
    <td >:&nbsp;<label name="kmdob" id="kmdob" ><s:property value="kmdob"/></label></td>
    </tr>
    <tr>
    <td align="left">Mobile No.&nbsp;&nbsp;</td>
    <td>:&nbsp;<label name="kmmobno" id="kmmobno" ><s:property value="kmmobno"/></label></td>
    </tr>
     <td align="left">D\L No.&nbsp;&nbsp;</td>
    <td>:&nbsp;<label name="kmdlno" id="kmdlno" ><s:property value="kmdlno"/></label></td>
    </tr>
    </table>
</fieldset>
  -->
<!--<fieldset>
   <table width="100%" >  
 <tr> <td width="58%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td></tr> 
 <tr> <td width="58%" rowspan="6"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td></tr> 
 
  </table>
  </fieldset> -->
<!--
  </td>
  <td width="50%" valign="top">
  <fieldset>
  <legend><b>Vehicle Details&nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل نوع المركبة </b></legend>
     
    <table width="100%">
     <tr>
      <td  width="45%">Reg NO&nbsp;:<label id="ravehauthregno" name="ravehauthregno"><s:property value="ravehauthregno"/></label> &nbsp;&nbsp;</td>
      <td width="30%" >Color&nbsp;:<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>  
     </tr>
    </table>
    </fieldset>
    <fieldset>
    <legend><b>Vehicle Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table>
  <tr><td width="25%" align="left">Date</td><td><label id="radateout" name="radateout"><s:property value="radateout"/></label></td></tr>
  <tr><td width="22%" align="left">Time</td><td><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td></tr>
  <tr><td width="22%" align="left">Km</td><td><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td></tr>
  <tr><td width="19%" align="left">Fuel</td><td><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
 
 </table>
  </fieldset>
 -->
   
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
 