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
	font-size: 9px;
	 
} 
 .container {
            display: flex;
            justify-content: space-between;
        }
        .container div {
            width: 48%;
            text-align:justify;
        }
        

.tabheight{
height: 120px;
}
 .right-align {
            text-align: right;
             direction: rtl;
            unicode-bidi: embed; / Required for the right-to-left context /
            
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
     <table width="100%" >
 <tr>
    <td width="20%" rowspan="6" ><img src="<%=contextPath%>/icons/epic.jpg" width="200" height="70"  alt=""/></td> 
    <td width="40%" rowspan="2">&nbsp;</td>
    <td width="35%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
   <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Rental Agreement</font></b></td>
   <!--  <td rowspan="2"  align="center"><b><font size="4"> عقد ايجار</font></b></td>
    -->
 <td align="left"><b>Tel[هاتف]: </b>&nbsp;<label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Mobile[متحرك]: </b>&nbsp;<label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>RANO : </b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>MRA NO# : <label id="mrano" name="mrano"><s:property value="mrano"/></label></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <b>RA : </b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch[فرع]: </b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Location[موقع] :</b>&nbsp;<label id="location" name="location"><s:property value="location"/></label></td>
  </tr>
   <tr>
  <td>
  </td>
  </tr>
  <tr>
  	<td colspan="3" align="center"><b>Email[بريد إلكتروني] : <label id="lblindigoemail" name="lblindigoemail"><s:property value="lblindigoemail"/></label>&nbsp;&nbsp;&nbsp;Dubai Police[شرطة دبي] :
  	
  	 999&nbsp;&nbsp;&nbsp;Roadside Assistance[حالة الطوارئ] :
+971521883326</b></td>
  </tr>
  <tr>
  <td colspan="3">
  </td>
   <td colspan="3">
  </td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>
  </tr>
   <tr>
  <td colspan="3">
  </td>
   <td colspan="3">
  </td>
  </tr>
</table> 
<%-- <table width="100%" style="padding-top:110px;" >
	<tr>
		<td width="17%" align="left" style="font-size: 7px"><b>RANO[رقم عقد الايجار] :</td>
		<td style="font-size: 7px"><label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b>--<b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b></td>
		<td width="25%" style="font-size: 7px"></td>
		<td width="36%" align="left" style="font-size: 7px"><b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b></td>
	</tr>
</table>
<table width="100%" >
	<tr>
		<td colspan="2" width="27%" style="font-size: 7px"><b>Lessor[مؤجر](License Name)[اسم الرخصه ]: </b></td><td style="font-size: 7px"><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
		<td width="8%" style="font-size: 7px">&nbsp;</td>
		<td  width="6.5%" style="font-size: 7px"><b>Branch[فرع]</b>:</td>
		<td style="font-size: 7px"><label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
	</tr>
</table>
<table width="100%" >
	<tr>
		<td width="7%" style="font-size: 7px">Tel[هاتف]: </td>
		<td width="15%" style="font-size: 7px"><label id="lblindigobranchtel" name="lblindigobranchtel"><s:property value="lblindigobranchtel"/></label></td>
		<td width="10%" style="font-size: 7px">Branch Mob[جوال الفرع]: </td>
		<td style="font-size: 7px" width="10%"><label id="lblindigobranchmobile" name="lblindigobranchmobile"><s:property value="lblindigobranchmobile"/></label></td>
	<!-- 	<td width="8%" style="font-size: 7px">&nbsp;</td> -->
		<td width="12%" style="font-size: 7px">Dubai Police[شرطة دبي] :</td><td style="font-size: 7px" width="12%">999</td>
		<!-- &nbsp;&nbsp;&nbsp;Roadside Assistance[حالة الطوارئ] :</td><td> 0554013557 -->
	</tr>
</table>
<table width="100%">
	<tr>
		<td width="7%" style="font-size: 7px">Address[عنوان]: </td>
		<td width="15%" style="font-size: 7px"><label id="lblindigoaddress" name="lblindigoaddress"><s:property value="lblindigoaddress"/></label></td>
		<td width="10%" style="font-size: 7px">Email[بريد إلكتروني]: </td>
		<td style="font-size: 7px"  width="10%"><label id="lblindigoemail" name="lblindigoemail"><s:property value="lblindigoemail"/></label></td>
		<!-- <td width="8%" style="font-size: 7px">&nbsp;</td> -->
		<td width="12%" style="font-size: 7px">Roadside Assistance[حالة الطوارئ] :</td><td width="12%" style="font-size: 7px"> +971521883326</td>
	</tr>
</table> --%>
<table width="100%" >
  <tr>
  <td width="50%" style="font-size: 7px">
  <fieldset>
  <table width="100%" style="padding:0px"> 
  <tr>
  	<td width="33%" align="left" style="font-size: 7px">Client ID [رمز المستأجر]  </td>
    <td width="82%" style="font-size: 7px"><label id="lblindigocldocno" name="lblindigocldocno"><s:property value="lblindigocldocno"/></label></td>
    </tr>
  <tr>
      <td width="31%" align="left" style="font-size: 7px">Name [اسم] &nbsp;  </td>
    <td style="font-size: 7px"><label id="clname" name="clname"><s:property value="clname"/></label></td>
    </tr>
    <tr>
      <td  align="left" style="font-size: 7px">Nationality [الجنسيه] &nbsp;  </td>
    <td style="font-size: 7px"><label id="lblindigonationality" name="lblindigonationality"><s:property value="lblindigonationality"/></label></td>
    </tr>
      <tr>
    <td  align="left" style="font-size: 7px">Address [عنوان] </td>
    <td height="20px" style="font-size: 7px"><label id="claddress" name="claddress"><s:property value="claddress"/></label></td>
    </tr>
   </table>
  <table width="100%" style="padding:0px">
      <tr>
    <td width="33%" align="left" style="font-size: 7px">MOB [جوال]</td>
    <td width="82%" style="font-size: 7px"><label id="clmobno" name="clmobno"><s:property value="clmobno"/></label></td>
 </tr>
 <tr>
    <td width="30%" align="left" style="font-size: 7px">Email [بريد الاليكترونيه]  </td>
    <td style="font-size: 7px"><label id="clemail" name="clemail"><s:property value="clemail"/></label></td>
    </tr>
    </table>
</fieldset>
   <fieldset><legend><b>Driver Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل السائق</b></legend>
    <table  width="100%" style="padding:0px">
   <tr>
      <td width="34.5%" align="left" style="font-size: 7px">Name [اسم]</td>
    <td width="82%" colspan="3" style="font-size: 7px">&nbsp;&nbsp;&nbsp;<label id="radrname" name="radrname"><s:property value="radrname"/></label> &nbsp;&nbsp;اسم السائق</td>
      
    </tr>
    </table>
        <table  width="100%" style="padding:0px">
    <tr>
        <td  width="37%" align="left" style="font-size: 7px">D\L NO [رقم الرخصه القياده]</td>
    <td width="77%" colspan="3" style="font-size: 7px"><label id="radlno" name="radlno"><s:property value="radlno"/></label></td>
    </tr>
    <tr>
   <td width="34%" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
    <td width="20%" colspan="3" style="font-size: 7px"><label id="lblaccount" name="licexpdate" ><s:property value="licexpdate"/></label></td>
    </tr>
    <tr>
     <td width="34%" align="left" style="font-size: 7px">Passport NO [رقم الجواز]</td>
    <td colspan="3" style="font-size: 7px"> <label name="passno" id="passno" ><s:property value="passno"/></label></td>
    </tr>
    <tr>
    <td width="34%" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
    <td width="18%" style="font-size: 7px"><label name="passexpdate" id="passexpdate" ><s:property value="passexpdate"/></label></td>
   

    <td width="27%" align="right" style="font-size: 7px">DOB [تاريخ الميلاد]</td>
    <td width="32%"><label name="dobdate" id="dobdate" ><s:property value="dobdate"/></label></td>
    </tr>
    </table>
</fieldset>
  <fieldset><legend><b>Additional Driver Details &nbsp;&nbsp;&nbsp;&nbsp;    تفاصيل السائق الاضافى</b></legend>
    <table  width="100%" style="padding:0px">
<!--    <tr>
      <td width="20%" align="left"></td>
      <td width="40%" align="left" colspan="2">Additional Driver</td>
   </tr> -->
   <tr> 
  	  <td width="38%" align="left" style="font-size: 7px">Name [اسم]</td>
      <td width="18%" style="font-size: 7px"><label id="adddrname1" name="adddrname1"><s:property value="adddrname1"/></label></td>
      <td width="30%" style="font-size: 7px">Nationality [الجنسيه]</td>
      <td width="40%" style="font-size: 7px"><label id="lblindigoaddnationality" name="lblindigoaddnationality"><s:property value="lblindigoaddnationality"/></label></td>
    </tr>
    <tr>
      <td width="38%" align="left" style="font-size: 7px">D\L NO [رقم الرخصه القياده]</td>
      <td width="25%" style="font-size: 7px"><label id="addlicno1" name="addlicno1"><s:property value="addlicno1"/></label></td>
      <td width="30%" style="font-size: 7px">Mobile [جوال]</td>
      <td width="40%" style="font-size: 7px"><label id="lblindigoaddmobile" name="lblindigoaddmobile"><s:property value="lblindigoaddmobile"/></label></td>
    </tr>
    <tr>
      <td width="" align="left" style="font-size: 7px">Exp Date [تاريخ الانتهاء]</td>
        <td width="" style="font-size: 7px"><label id="expdate1" name="expdate1"><s:property value="expdate1"/></label></td>
        <td colspan="2" style="font-size: 7px">Signature [التوقيع]</td>
    </tr>
     <tr>
      <td width="" align="left" style="font-size: 7px">DOB [تاريخ الميلاد]</td>
        <td width="" style="font-size: 7px"><label id="adddob1" name="adddob1"><s:property value="adddob1"/></label></td>
    	<td height="25px" colspan="2"><fieldset style="height:100%;"></fieldset></td>
    </tr>
    </table>

</fieldset>

<fieldset style="margin-top:10px;">
	<table style="width:100%;">
		<tr>
			<td>In case the driver age is less than 25 or driving license is less than 3 years old customer will have to pay insurance excess of AED 1500 plus 30% of damages incurred as a result of the accident. In case the vehicle is declared total loss the 30% damage would be considered as 30% of the vehicle value. Vehicle value in such an event would be the purchase value of the vehicle purchased by Lessor.</td>
		</tr>
		<tr>
			<td>Every payment received from the lessor ( from the first payment ) will be charged under the rights of government fines & other expenses of the governement , salik , extra kilometers and damages and or any other penalty incurred during rental period. Once those rights are settled only then the remainder amount would be adjusted against rental amount.</td>
		</tr>
	</table>
</fieldset>

<%-- <table width="100%"  >
 <tr>
 <td   width="100%">
 <fieldset>
<legend><b>Accidents&nbsp;&nbsp;&nbsp;&nbsp; الحوادث   </b></legend>
<P style="text-align:right;display:inline-block;">التوقيع ادناه يعنى انه لديكم العلم بأنه فى حالة حدوث اية حادث و جب الحصول على تقرير من الشرطة و ان تم الذكر بأنك المتسبب سنقوم بحساب قيم التحمل للحادث  والتى قيمتها 750 درهم اماراتى</P>
By Initialing, you understand any accident, even if you have availed CDW, must be accompanied by a valid police report.
Failure to provide one will result in additional charges. Customer who opt out of CDW will be liable to pay the excess deductible amount of 750 AED
<label id="excessinsu" name="excessinsu"><s:property value="excessinsu"/></label>
<!-- <table width="100%"  >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>
</td>
</tr>
<tr>
<td width="100%">
 <fieldset >
<legend><b>Traffic Fines&nbsp;&nbsp;&nbsp;&nbsp; المخالفات المرورية </b></legend>
<P style="text-align:right;display:inline-block;">التوقيع ادناه يعنى انه لديكم العلم بأنه سيتم حساب ما قيمته 10% على كل قيمة مخالفة يتم تحريرها لكم اثناء استأجار السيارة من قبلكم</P>
By putting your initial in box provided,
 You agree to pay all traffic and parking 
 fines issued to you whilst the vehicle is
  rented in your name, you also agree to pay 
  a 10% admin charge in addition to the fine.
<!--   <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>

 </td>
 </tr>
<tr>
 <td>
 <fieldset width="100%">
<legend><b>Salik (Road tolls)&nbsp;&nbsp;&nbsp;&nbsp; تعرفة سالك </b></legend>
<P style="text-align:right;display:inline-block;">      التوقيع ادناه يعنى انه لديكم العلم بأنه سيتم حساب 5 دراهم اماراتية كرسم عبور لكل بوابة سالك</P> 
<br> By putting your initial in the box provided below you agree to pay salik charges of 4 Dhs for each crossing and 1 Dhs admin fee.
Total 5 Dhs per crossing.These charges will be added to the end of the rental, or as and when we are notified by the RTA.
<!-- <table width="100%" >
<tr><td  width="50%"></td><td width="50%" height="25px" > <fieldset style="height:100%;"></fieldset></td>
</tr>
</table> -->
</fieldset>
 </td></tr>
 </table> --%>
<!--  <table width="100%">
 	<tr>
 		<td width="50%">&nbsp;</td>
 		<td width="50%">
 			<table width="100%">
 				<tr>
 					<td colspan="2"><b>Documents</b></td>
 				</tr>
 				<tr>
 					<td width="10%"><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td width="90%">Passport & VISA</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Emirates ID</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Driving License</td>
 				</tr>
 				<tr>
 					<td><input type="checkbox" style="border:2px solid #000;box-shadow:none;width:25px;height:25px;background-color:transparent;"></td>
 					<td>Mulkiya Issued</td>
 				</tr>
 			</table>
 		</td>
 	</tr>
 </table> -->
 <!-- <table width="100%">
 <tr>
 <td>
<b>VEHICLE INSURED FOR UAE TERRITORY ONLY</b>
</td>
</tr>
<tr>
<td>
 
</td>
</TR>


</table> -->

  </td>
  <td width="50%">
  <fieldset>
  <legend><b style="font-size: 7px">Vehicle&nbsp;&nbsp;&nbsp;&nbsp;   نوع المركبة</b></legend>
     <table width="100%" style="padding:0px" >  
  <tr>
    
    <td width="23%" ><label id="ravehname" name="ravehname" style="font-size: 7px"><s:property value="ravehname"/></label></td>
    <td width="25%"></td>
    <%-- <td width="18%" >YOM&nbsp;<label id="rayom" name="rayom"><s:property value="rayom"/></label></td> --%>
    <td width="30%" colspan="2" style="font-size: 7px">Color[اللون]&nbsp;<label id="racolor" name="racolor"><s:property value="racolor"/></label></td>
    </tr>
      <tr>
      <td width="26%" align="left" style="font-size: 7px">Reg NO[رقم التسجيل]</td>
      <td style="font-size: 7px"><label id="ravehregno" name="ravehregno"><s:property value="ravehregno"/></label> &nbsp;&nbsp;رقم المركبة</td>
 
     <td align="left" style="font-size: 7px">Group&nbsp;<label id="ravehgroup" name="ravehgroup"><s:property value="ravehgroup"/></label></td> 
    </tr>
    </table>
    </fieldset>
         <fieldset>
    <legend><b style="font-size: 7px">Out Details  &nbsp;&nbsp;&nbsp;&nbsp;  تفاصيل خروج السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="22%" align="left" style="font-size: 7px">Date [تاريخ]</th>
       <th width="22%" align="left" style="font-size: 7px">Time [وقت]</th>
          <th width="25%" align="left" style="font-size: 7px">Km [كلوميتر]</th>
             <th width="25%" align="left" style="font-size: 7px">Fuel [البيترول]</th>
  </tr>
  <tr>
  <td style="font-size: 7px"><b><label id="outdetails" name="outdetails"><s:property value="outdetails"/></label></b></td> 
<td style="font-size: 7px"><label id="radateout" name="radateout"><s:property value="radateout"/></label></td>
<td style="font-size: 7px"><label id="ratimeout" name="ratimeout"><s:property value="ratimeout"/></label></td>
<td style="font-size: 7px"><label id="raklmout" name="raklmout"><s:property value="raklmout"/></label></td>
<td style="font-size: 7px"><label id="rafuelout" name="rafuelout"><s:property value="rafuelout"/></label></td>
  </tr>
   <tr>
  <td style="font-size: 7px"><b><label id="deldetailss" name="deldetailss"><s:property value="deldetailss"/></label></b></td>
<td style="font-size: 7px"><label id="deldates" name="deldates"><s:property value="deldates"/></label></td>
<td style="font-size: 7px"><label id="deltimes" name="deltimes"><s:property value="deltimes"/></label></td>
<td style="font-size: 7px"><label id="delkmins" name="delkmins"><s:property value="delkmins"/></label></td>
<td style="font-size: 7px"><label id="delfuels" name="delfuels"><s:property value="delfuels"/></label></td>
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
     <fieldset><legend><b style="font-size: 7px">Rental Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل الايجار</b></legend>  
      <table  width="100%" style="padding:0px">
      	<%-- <tr>
      		<td width="12%"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label>&nbsp;Tariff</td>
      		<td align="center" ><label id="tariff" name="tariff"><s:property value="tariff"/></label></td>
      		<td><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label>
       		<td width="18%" align="right">CDW&nbsp;&nbsp;</td>
       		<td align="left" ><label id="racdwscdw" name="racdwscdw"><s:property value="racdwscdw"/></label></td>
    	</tr> --%>
    	<tr>
    		<td style="font-size: 7px"><label id="lblindigorenttype" name="lblindigorenttype"><s:property value="lblindigorenttype"/></label>&nbsp;Tariff[سعر]</td>
    		<td style="font-size: 7px"><label id="lblindigorate" name="lblindigorate"><s:property value="lblindigorate"/></label></td>
    		<td style="font-size: 7px">Discount[الخصم]&nbsp;</td>
    		<td style="font-size: 7px"><label id="lblindigodiscount" name="lblindigodiscount"><s:property value="lblindigodiscount"/></label></td>
    		<td style="font-size: 7px">Net Total[صافي المجموع]</td>
    		<td style="font-size: 7px"><label id="lblindigonettotal" name="lblindigonettotal"><s:property value="lblindigonettotal"/></label></b></td>
    	</tr>
    </table>
    <table  width="100%" style="padding:0px" >
       <tr><td width="15%" style="font-size: 7px">Accessories[مستلزمات]</td><td width="5%" style="font-size: 8px"><label id="raaccessory" name="raaccessory"><s:property value="raaccessory"/></label></td>
       <td width="35%" style="font-size: 7px">Add Driver Charges[قيمة السائق الاضافي] </td><td width="10%" style="font-size: 8px"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td></tr>
        <tr><td width="15%" style="font-size: 7px">KM Limit[حد الكيلوميتر]</td><td width="25%" style="font-size: 8px"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td>
       <td width="35%" style="font-size: 7px">Extra per KM Charge[قيمة الاضافيه كيلوميتر]</td><td width="25%" style="font-size: 8px"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td></tr>
       <tr><td width=35% style="font-size: 7px">Daily Rate [تقييم يومي]</td><td width="25%" style="font-size: 8px"><label id="indigoradaily" name="indigoradaily"><s:property value="indigoradaily"/></label></td></tr>
  </table>
    </fieldset>
     <fieldset>
    <legend><b style="font-size: 7px">In Details &nbsp;&nbsp;&nbsp;&nbsp; تفاصيل دخول السيارة  </b></legend>  
       <table style="padding:0px">
  <tr>
    <th align="left" style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
    <th width="25%" align="left" style="font-size: 7px">Date [تاريخ]</th>
       <th width="20%" align="left" style="font-size: 7px">Time [وقت]</th>
          <th width="22%" align="left" style="font-size: 7px">Km [كلوميتر]</th>
             <th width="19%" align="left" style="font-size: 7px">Fuel [البيترول]</th>
             <th width="19%" align="center" style="font-size: 7px">Signature [التوقيع]</th>
  </tr>
  <tr>
  <td style="font-size: 7px"><b><label id="indetails" name="indetails"><s:property value="indetails"/></label></b></td>
<td style="font-size: 7px"><label id="indate" name="indate"><s:property value="indate"/></label></td>
<td style="font-size: 7px"><label id="intime" name="intime"><s:property value="intime"/></label></td>
<td style="font-size: 7px"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
<td style="font-size: 7px"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
  </tr>
   <tr>
  <td style="font-size: 7px"><b><label id="coldetails" name="coldetails"><s:property value="coldetails"/></label></b></td>
<td style="font-size: 7px"><label id="coldates" name="coldates"><s:property value="coldates"/></label></td>
<td style="font-size: 7px"><label id="coltimes" name="coltimes"><s:property value="coltimes"/></label></td>
<td style="font-size: 7px"><label id="colkmins" name="colkmins"><s:property value="colkmins"/></label></td>
<td style="font-size: 7px"><label id="colfuels" name="colfuels"><s:property value="colfuels"/></label></td>
  </tr>
 </table>
  </fieldset>   
  <fieldset><legend><b style="font-size: 8px">Insurance Type [نوع التأمين]</b></legend>
  	<table width="100%" style="padding:0px">
  		<tr>
  			<td  style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess AED 1500 + 30% Damage Value</td>
  			<td width="30%" style="font-size: 7px">[مبلغ تحمل التأمين+٣٠٪؜ قيمة الاضر]</td>
  		</tr>
  		<!--  <tr>
  		<td style="font-size: 7px">[مبلغ تحمل التأمين+٣٠٪؜ قيمة الاضر]</td>
  		</tr>  -->
  		<tr>
  			<td width="45%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess 1500</td>
  				<td width="40%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess Zero</td>
  	
  			<!-- <td width="40%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess 2500</td>
  			 -->
  		</tr>
  		
  		 <tr>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [مبلغ تحمل التامين  1500]</td>
  				<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[مبلغ تحمل التامين صفر]</td>
  		
  		<!-- 	<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [مبلغ تحمل التامين  2500]</td>
  		 --></tr>
  		
  	<!-- 	<tr>
  			<td width="45%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Insurance Excess Zero</td>
  			<td width="35%" style="font-size: 7px"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">Excess2500 + 30%Damage</td>
  		</tr>
  		 <tr>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[مبلغ تحمل التامين صفر]</td>
  			<td style="font-size: 7px">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[اضافي2500 + ضرا%30]</td>
  			 -->
  		</tr>
  	</table>
  </fieldset>  
  <%--  <fieldset><legend><b> Closing Details</b></legend> 
     <table width="100%" > 
           <tr>
    <td width="18%" align="left">In KM </td>
    <td width="36%"><label id="inkm" name="inkm"><s:property value="inkm"/></label></td>
 
    <td width="20%" align="left">In Fuel </td>
    <td width="26%"><label id="infuel" name="infuel"><s:property value="infuel"/></label></td>
    </tr>
       <tr>
    <td align="left">In Date </td>
    <td ><label id="indate" name="indate"><s:property value="indate"/></label></td>
 
    <td  align="left">In Time</td>
    <td><label id="intime" name="intime"><s:property value="intime"/></label></td>
    </tr>
     </table>
     </fieldset> --%>
        <table width="100%">
    <tr>
    <td width="100%">
 <%-- <div id="calcdiv">
  <jsp:include page="calculationGrid.jsp"></jsp:include></div> --%>
  <!-- <img src="../../../../icons/indigoprintcar.png" style="width:100%;"/> -->
  </td>
  </tr>
  </table> 
<%--   <fieldset width="100%">
    <legend>
     <b>Closing Balance Amount &nbsp;&nbsp;&nbsp;&nbsp; الرصيد عند الاغلاق  </b></legend>
     <table  width="100%">
      <tr>
     
         
    <td width="25%" align="left">Total Receipt</td>
    <td width="75%">&nbsp;&nbsp;<label id="totalpaids" name="totalpaids"><s:property value="totalpaids"/></label></td>
 </tr>
 <tr>
    <td width="25%" align="left">Invoice Amount </td>
    <td width="75%">&nbsp;&nbsp;<label id="invamount" name="invamount"><s:property value="invamount"/></label></td>
 </tr>
 <tr>
    <td align="left">Balance</td>
    <td >&nbsp;&nbsp;<label id="balance" name="balance"><s:property value="balance"/></label></td>
    </tr>
    
     </table>
    <hr noshade size=1>
     <table  width="100%"   >
           <tr>
    <td>
        <P style="text-align:right;display:inline-block;"> 
        من المهم ان تقوم بقرائة و فهم  القواعد و الشروط المترتبة على هذا التعاقد قبل التوقيع .
اذا تم الدفع المالى من قبلكم بواسطة البطاقة الأتمانية , سيكون التوقيع على هذا التعاقد بمثابة موافقة من قبلكم ليتم
حسابكم تلقائيا لقيم الايجار و المخالفات المرورية و الحوادث و تعرفة سالك و الوقود المستخدم  بدون الرجوع اليكم
حتى و ان كان تم غلق التعاقد مهما كانت المدة.   
         </P>
  <font style="font-size:8px ;text-align:right;">It is important that you have read and understood the terms
     and conditions that  will apply  to this contract before singing.
      Only sign this agreement if you wish to be bound by the terms and conditions 
      over the page. (Arabic translation overleaf is available on the rental 
       wallet) and if you are paying by Credit card, your signature is authorization 
       for Automatic  billing. Your signature also allows us to deduct any additional 
       charges pertaining to this  contract after the rental agreement has been closed.</font>
      </td>
    </tr>
    <tr>
    <td align="left" ><hr noshade size=1>Customer Signature
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date</td></tr>
  <!--   <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
     <tr> <td align="left" ><hr noshade size=1>Rental Agent
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date</td></tr>
     <!--  <tr> <td align="left" ><hr noshade size=1>Date</td></tr> -->
      <tr>
      <td align="left">
    <fieldset>
     <font style="font-size:7.5px">You are responsible for any damage to the vehicle by striking overhanging objects.</font>
     
      </fieldset>
      </td>
      </tr>
     </table>
 </fieldset>  --%>
  </td>
    </tr>
    <tr>
    	<td colspan="2">
    		<table width="100%" style="padding:0px">
    			<tr>
    				<td width="50%" style="font-size: 7px">
    					<fieldset><legend><b>Check In</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;" height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    					</fieldset>
    				</td>
    				<td width="50%" style="font-size: 7px">
    					<fieldset><legend><b>Check Out</b></legend>
    						<img src="../../../../icons/indigoprintcar.png" style="width:100%;"  height="100px"/>
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Spare Wheel[اطار الاحتياطى]&nbsp;&nbsp;
    						<input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Tool Kit[العره]
    						
    					</fieldset>
    				</td>
    		</table>
    	</td>
    	</tr>
    	<tr>
    	<td style="font-size: 7px">
    		<fieldset>
    		<legend><b>Documents Checklist</b></legend>
    			<table width="100%" style="padding:0px;">
    				<tr>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Passport & VISA[جواذ و اقامه]</td>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Emirates ID[هوية الاماراتيه]</td>
    				</tr>
 					<tr>
 						<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Driving License[رخصة القياده]</td>
    					<td width="50%" style="font-size: 7px;"><input type="checkbox" style="border:2px solid #000;box-shadow:none;background-color:transparent;">&nbsp;Mulkiya Issued[أصدار الملكيه]</td>
 					</tr>   				
    			</table>
    		</fieldset>
    	</td>
    	<td style="height:20px "><fieldset><p style="font-size:7px;"><b>In case of delayed payments rate will be changed to daily shelf rent of the contracted vehicle and all discounts will be removed from the contract. Tyres damages are not covered with insurance and shall be charged separately in case of a damage.</b></p></fieldset></td>
    	</tr>
  	<tr>
    		<td colspan="2" style="font-size:7px;padding:0px" >
    			<fieldset><legend><b style="font-size: 7px">Terms & Conditions</b></legend>
    				<p style="font-size:7px;padding:0px;margin:0px;">
    					Lesse is not allowed to pay fines directly to relevant authorities. Lessor reserve the right to not wait for the fine settlement and clear its 
    					traffic file without consent of the Lesse. Lesse is entitled to pay charges of AED 300 per black point. Moreover, it is Lessee's responsibility to 
    					ensure that the vehicle is serviced on time. In cases of delayed services the Lessee is responsible to pay AED 500 per extra thousand kilometers. 
    					In case a driver not mentioned on this agreement is caught driving the LESSOR is entitled to impose a penalty of AED 4000 other than state imposed 
    					penalties and or other incurred damages.Upon closing of the rental agreement Lesse must claim it's security deposit refund within 6 months have passed 
    					the security deposit will be forfeited and and lessor is no longer iable for the security deposit. In case of Additional Driver both Lesse and 
    					Additional Driver shall be responsible to abide by all terms and conditions of this contract. Moreover by signing this document Additional Driver
    					undertakes responsibility against this contract on individual level. All terms and conditions applicable to the LESSE shall be applicable on 
    					additional driver as well. The vehicle Insurance will only be covered in UAE. Personal Accident Insurance is not covered as part of this agreement.
    					This means any kind of bodily injuries or death of driver or/and any of the passengers will not be covered. Lessor does not provide this cover 
    					and lesse hereby agrees to hire vehicle without this cover. All contracts opened on monthly terms or transferred to monthly terms in future shall 
    					constituite 30 days as one month. I/We hereby agree to the Terms and Conditions mentioned on both sides of this agreement. I hereby confirm and 
    					authorize payment to be made by credit card/charge card. My signature on this agreement shall constitute authority to debit my nominated card 
    					company with all charges related to this transactions, which includes, but is not limited to, Rental Charges, Insurance Charges, Damage Liability, 
    					Salik/Tool Fees, Traffic Fines, Administration Fees, Fuel Charges, and any charges directly attributable to this rental agreement. I accept that 
    					Salik/Toll Fees & Traffic Fines may be debited to my account EVEN AFTER the contract is closed. All vehicles are monitored by DPS. I acknowledge 
    					in the event of accident I will obtain POLICE REPORT. Failure to do so could result in legal action, and further void all insurances, rendering me liable for all cost incurred by the Lessor. All charges to 
    					transfer security deposit shall be borne by the Lesse.The rental prices mentioned on this agreement are exclusive of any taxes. All applicable taxes levied by the state of UAE shall be applied separately on rental prices, delivery charges, CDW, damage charges, insurance excess, fine service charges, salik service charges and or any other charges incurred as a result of this rental agreement.Tinting on vehicles is strictly not allowed and will result in a penalty of AED 1000
    				</p>
    			</fieldset>	
    		</td>
    	</tr>
    	<tr>
    		<td>
    			<fieldset>
    				<table width="100%" style="padding:0px">
    					<tr>
    						<%-- <td width="50%" style="font-size: 7px">Fuel Charges&nbsp;&nbsp;&nbsp;<label id="lblfuelrate" name="lblfuelrate"><s:property value="lblfuelrate"/></label> per liter</td>
    						 --%>
    					<td width="50%" style="font-size: 7px">Fuel Charges&nbsp;&nbsp;&nbsp;5 AED per liter</td>
    					<td width="50%" style="font-size: 7px">Fine Service Charges&nbsp;&nbsp;&nbsp;50 AED</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">[قيمة الوقود]&nbsp;&nbsp;&nbsp;</td>
    						<td width="50%" style="font-size: 7px">[قيمة الخدمة المخالفات]&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">Next Service Km</td>
    						<td width="50%" style="font-size: 7px">Salik Charges&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5 AED</td>
    					
    					</tr>
    					<tr>
    						<td width="50%" style="font-size: 7px">[خدمة الكيلوميترات القادمه]</td>
    						<td width="50%" style="font-size: 7px">[قيمة السالك]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
    					
    					</tr>
    				</table>
    			</fieldset>
    		</td>
    		<td><fieldset>
    			<table width="100%" style="padding:0px">
    				<tr>
    					<td width="40%" style="font-size: 7px">Customer Signature[توقيع المستأجر]</td>
    					<td width="">&nbsp;</td>
    					<td width="15%" style="font-size: 7px">Date[تاريخ]</td>
    					<td width="15%" style="font-size: 7px">&nbsp;</td>
    				</tr>
    				<tr>
    					<td style="font-size: 7px">Rental Agent[وكيل الؤجر]</td>
    					<td style="font-size: 7px"><label id="lblindigorentalagent" name="lblindigorentalagent"><s:property value="lblindigorentalagent"/></label></td>
    					<td style="font-size: 7px">Date[تاريخ]</td>
    					<td>&nbsp;</td>
    				</tr>
    			</table>
    		</fieldset>
 </div>
 
<tr class="tabheight"><td >&nbsp;</td></tr>

 <div style="background-color:white;">
 
    <table>
  <tr>
            <td>
                <div class="container">
                    <div>
                        <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Terms & Conditions </h3>
                        <p>
Let’s Ride Rent A Car LLC, (hereinafter referred to as the LESSOR) being the lawful owner of the motor vehicle described overleaf (hereinafter called the vehicle) hereby rents to the customer (Hereinafter referred to as the LESSEE) who signed overleaf subject to all terms and provisions overleaf and provisions herein on this rental agreement in consideration whereof the LESSEE acknowledges and agrees that. 
<br><br>
1)	The LESSEE declares that he/she along with their representative/s whose name is mentioned overleaf in the column Username’s is licensed to drive the hired vehicle according to the UAE traffic laws. 
<br><br>
2)	In the agreement the expression period of hire’ shall mean the period from the renting of the vehicle including the replacement vehicle/s if any to the time it redelivered into the custody of the LESSOR. 
<br><br>
3)	The LESSEE acknowledges that the vehicle was delivered to him/her in good and road worthy condition and agrees to return the same condition with all accessories to the LESSOR’S sales / service center or other as specified overleaf on the date agreed or sooner upon demand of LESSOR. The LESSOR reserves the right to repossess the vehicle at any time without demand at Renters expense if vehicle is used in violation of this agreement. 
<br><br> 
4)	The LESSEE is responsible for the cost of fuel and oil consumed during the period of hire and has to ensure that all times the vehicle is correctly filled with suitable oil, coolant, battery water and the tyres are kept properly inflated and also the vehicle and instruments are not tampered with or damaged. A good standard of cleanliness should also be maintained during the period of hire. Failure to carry out these checks could result in damage to vehicle in which case the LESSEE will be responsible for all repair costs incurred. 
<br><br>
5)	The LESSOR absolves itself of any responsibility for any cash or valuables belonging to LESSEE that may be lost whilst the vehicle in his/her possession or after the entire period of hire or when the vehicle is taken for service repairs. 
<br><br> 
6)	The LESSEE should ensure that he/she signs the checks-out and checks-in documents at the time of delivery or return of vehicle, otherwise the time in and out date mentioned in the agreement overleaf will be treated as the time and date of hire and off-hire for billing purposes. 
<br><br> 
7)	The LESSEE shall be liable to keep the car clean otherwise AED 50 will be charged for exterior and AED 300 will be charged for interior cleaning. 
<br><br><br>
8)	Due date mentioned in agreement is the expected date of return of vehicle by the LESSEE which may be extended as mutually agreed in writing. 
<br><br>
9)	Payment:  
a.	For the delayed payment the LESSEE are giving maximum 2 weeks to clear the payment otherwise it will be considered as violation to this agreement and suitable action such as repossessing the vehicle or legal action, if so required, will be taken. Moreover, the lessor then reserves the right to change the rates mentioned on the contract to prevailing per day market rates of the subject vehicles. Non-payment, also releases the LESSOR from having provide back-up maintenance and/or replacement vehicle, any damages resulting due to this will be the LESSE’s responsibility who will be liable to compensate the LESSOR for the repairs. 
<br><br>  
b.	I/we hereby agree to the terms and conditions mentioned on both sides of this agreement. I hereby confirm and authorize payment to be made by credit/debit card. My signature on this agreement shall constitute authority to debit my card with all charges related to these transactions, which includes but is not limited to, Rental charges, insurance charges, damages liability, Salik/Tool fees, Traffic fines, Administration fees, Fuel charges and any other charges directly attributable to this rental agreement. I accept that salik/Toll fees Traffic fines or Damage (without police report) may be debited to my account even after the contract is closed. 
<br><br> 
c.	For customers who are paying by cash arrangements should clear off their dues soon as they incur. A grace period of 24 hours shall be granted after which the company has the right to confiscate their vehicles. In such an event the customer shall be liable to recovery charges and all other expenses incurred during the rental period. All these expenses if not paid shall be declared as liabilities on the customer, which would need to be cleared by customer. 
<br><br>  
d.	In case of payment by cheque every bounce cheque will be charged an extra AED 300/-as cheque bounce charged. 
<br><br> 
10)  The LESSEE is liable to pay the LESSOR: 

a.	Rental charges agreed between LESSOR and LESSEE as detailed overleaf and all charges accrued as a result of this agreement until the end of the period of hire. 
<br><br> 
b.	Additional LESSEE rental charges, including service charges/ parking charges if the vehicle is left elsewhere without informing the LESSOR in writing and/or without the written consent of the LESSOR. 
<br><br>
c.	Cost of repair due to any kind of misuse and negligence including but not limited to, running the vehicle without maintaining required water level, engine oil levels and all other basic requirements of smooth running of the vehicle and/or operating the vehicle off-road or on am uneven area. LESSEE shall be obliged to pay the LESSOR the basic rental charges until the repairs have been completed. 
<br><br> 
d.	TRAFFIC FINES and SALIK charges or any other related expense incurred as a result of traffic violation/committed during the term of rental agreement will have to be paid by the LESSEE irrespective of any time delay in notification of the same by the UAE traffic authorities. The LESSEE’s immediate response to such notification is required.  
The onus to obtain the documentary proof if any, from the authorities rests entirely with the LESSEE 
<br><br> 
e.	It will be deemed that the LESSEE has accepted the LESSORS invoice in the full in the event that the LESSEE has not lodged any written objections with the lessor within 7 days of the date on the invoice. 
<br><br> 
f.	Interest@12% per annum will be paid by the LESSEE on any amount outstanding over 30 days. 
<br><br>
g.	In case of early off-hire of the vehicle other than as specified in the Rental Agreement, the LESSOR reserves the right to change the rental on daily basis at daily basic rate as mentioned in the Let’s Ride Rent A Car LLC rate list. The LESSOR also reserves the right to disallow any discount in case of late or delayed payment. 
<br><br> 

11) SERVICE/MAINTACE  
a.	The rental charges include free periodical servicing firstly at 1000 km. for a new vehicle and thereafter at every 3000 km. Prior notice (2days) for service or complaints is necessary from the LESSEE so as to provide a replacement vehicle which may or may not be similar type of vehicle for duration of maintenance and servicing of the hired vehicle. In case of breakdown replacement will be provided with the least possible delay. The LESSEE is responsible for returning the replacement of vehicle within 24 hours from notification from Let’s Ride Rent A Car LLC that the original vehicles servicing or maintenance is complete. Failure to do so will be deemed as a breach of the terms and conditions of this agreements, and full charges will apply. 
<br><br> 
b.	The LESSEE also undertakes to return the vehicle the LESSOR for periodical service. In case of delayed service, a fine of AED 500 will be issued on per1000 km. In case of serious damage to the engine due to late service customer will be liable to pay the total amount of damages.  
<br><br> 
 
c.	The period of hire shall then be extended to cover the time taken to repair such damages. LESSEE must not let any work of vehicle without Let’s Ride Rent A Car LLC written permission. 
<br><br> 
d.	The LESSEE agrees to pay the LESSOR for any damages caused to tyres and or/ rims whilst the vehicle is in his/her possession, furthermore any driving in puddle of water or any other territory which possesses risk of damage to the vehicle resulting in any kind of damages shall be responsibilities of the LESSEE as the same cannot be claimed from the insurers. Punctures if any are to be repaired by the LESSEE. Damage to the tyres due to punctures will be charged to be LESSEE. 
<br><br> 
 
 
12) INSURANCE/ ACCIDENT LIABILITY: 
a.	All accidents will be immediately reported to the appropriate police authorities and necessary police reports obtained. Accident reports can eb lodges on telephone number 999 for all Emirates. Further, all accidents involving the vehicle will also be reported to the LESSOR in writing immediately. 
<br><br> 
b.	The vehicles are comprehensively insured in accordance with the UAE laws. The LESSEE will be responsible for minimum liability against accidents/ damages of Dhs 1750 or actual charges if more for any damage or repair costs, as mentioned in police report. Police report which does not mention third party or in other words which cannot be recovered against any third party shall not be entertained and will be considered responsibility of the LESSEE. In the absence of police report the LESSEE’s liability will not be limited to the amount stated above overleaf. Personal accident insurance cover for the driver and his immediate relatives in respect of death or bodily injures will not be covered in any case whatsoever. 
<br><br> 
 
c.	Insurance will not be covered for any driver whose age less than 25 years old or any driver whose driving licensee is less than one year old. 
<br><br> 
13) LESSEE’S CAUTION: 
      a) The vehicle will not be used: 
      i. By any person who: 
 a) Is not properly licensed to drive the vehicle and/or& not authorized in writing in advance by the LESSOR NOT AUTHORISEO BY LESSOR. 
b) Has given a fictitious or false name, age, address, telephone number and license details.  
c) Is under the influence of alcoholic drinks or drugs/ narcotics, or any other Substance impairing consciousness or ability to react. 
d) Has at any time been convicted of any motoring offence unless details have been disclosed to the LESSOR and LESSOR’s approval in writing is sought and obtained.  
e)  Is under the age of 25 years or possesses a license which is less than one-year old. 
ii. in any manner which would or might render the insurance void.  
iii. TO subject or to carry passengers or property for life or reward for the LESSEE’s business purposes unless he has the necessary license or permits. 
 iv. TO carry a greater number persons than that for which it was designed. 
 v. For any illegal purposes. 
 vi. To carry a toad which is improperly secured or loaded or which overloads the vehicle or which would or might cause damage to the vehicle or other road users and/or public property, including hazardous substances. 
 vii.TO propel or tow another vehicle, trailer or other Object, 
 viii. For racing, pace making, reliability trails, rallies, speed testing. Driving tuition or similar Purposes. 
 ix. To carry any sort of alcoholic drinks and/or drugs/narcotics. Additionally in case the vehicle is impounded / detained by the police the LESSEE will be liable to pay the LESSOR all charges (including accrued rental), losses, damages, fines and penalties and expenses by this reason or in respect thereof. 
x. Outside the country of rental unless pre-authorized by written permission of the LESSOR also in geographical areas that have been deemed by the LESSOR as restricted ones. 
<br><br>
14) The LESSEE must ensure that the vehicle is parked in a safe and secure place and locked when it is not in use. Any damage caused to the vehicle and lost keys. The LESSEE will be liable for the amount as mentioned in clause 14 (a) and (b) 
<br><br>
15) All vehicles including but not limited to 4 x 4 are for driving on paved roads only. Any off-road usage should be prearranged and with permission obtained in writing from the LESSOR for all vehicles including 4WD, otherwise driving off-road is not permitted. LESSEE will be charged for any damage caused due to driving in breach with the above stipulations. 
In the event of a breakdown off-road or away from a public road it is the LESSEE’s responsibility to bring the vehicle back onto the road at the LESSEE’s expense.  
<br><br> 
16) If Any breach of the terms this agreement is committed then the LESSOR shall be entitled, but without prejudice to any Other rights and remedies it may have, to immediately terminate the rental of the recover possession thereof’ 
<br><br> 
17) Salik will be billed as AED 5/- per Salik toll. 
<br><br> 
18) Fuel Charges Will Be Applicable as AED 5 Per Liter. 
<br><br> 
19) Daily Mileage Allowance Will Be 200km, Anything Above Will Be Charged As 0.50fils Per Kilometer 
<br><br> 
20) A grace period of 2 hours shall be allowed on return date. Further delay shall cause excess charge of complete day. 
<br><br> 
21) All fines and RTA liabilities shall be responsibility of the customer. Cash deposit shall be kept for 25 days after check in date to compensate for fines. After 25 days the deposit shall be returned but the LESSEE shall still be liable to clear any RTA liabilities incurred during the rental period. In case of credit cards, Let’s Ride Rent A Car LLC has all the rights to charge fines or any other liabilities resulting in rental period. The LESSEE duly authorizes such action. Documentation and handling charges Of AED 80/- shall be charged per fine. 
<br><br> 
22) Latest Time for Check in Shall Be 6:00pm. No Check In On Sundays And Government Holidays. 
<br><br> 
23) In case of confiscation of vehicles, a charge of AED 500/- Shall be levied for recovering the vehicle from the LESSEE. 
<br><br>
24) Minimum charges for lost Keys with be AED 1800/-. AED 290/- will be Charged upon Spare Key Request. 
<br><br> 
25) In case of expired registration, the customer will pay a fine of AED 300 per month on expired tenure. 
<br><br> 
26) The LESSOR reserves the right to change its terms and conditions without any notice to any parties. Lessor reserves the right to charge amount on card without any notice. 
<br><br> 
27)  This agreement shall be governed by and construed according to the laws of the UAE. All legal charges and solicitors’ fees shall be borne by the LESSEE and both parties agree accordingly. 
<br><br> 
28) Language – In the event of conflict that between the text of this agreement in the English language and the text of this agreement in the Arabic language or any other Arabic translation and any competent court determining that such Arabic text to translation shall prevail, it is agreed the English text of this agreement shall nevertheless be used to assist in any interpretation. 
<br><br> 
29) The LESSEE acknowledges that person- related data to this rental agreement will be automated processed. He/She agrees expressly that this data can be communicated to third parties, especially for credit protection purposes.  
<br><br> 
30) In case a driver not mentioned on this agreement is caught driving, the lessor is entitled to impose a penalty of AED4000 other than penalties imposed by the state and other incurred damages. In case of additional driver both lessee and additional driver shall be responsible to abide by all terms and conditions of this contract. 
 </div>
  <div>
                        <h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;الشروط والأحكام</h3>
<p class="right-align">
تقوم شركة لتس رايد لتأجير السيارات ذ.م.م (يُشار إليها فيما بعد باسم المؤجر) بصفتها المالك الشرعي للمركبة الآلية المذكورة في الصفحة التالية (يُشار إليها فيما بعد باسم السيارة) بموجبه بتأجير السيارة محل الذكر للعميل (يُشار إليه فيما بعد باسم المستأجر) الذي أمهر توقيعه على الصفحة التالية مع مراعاة جميع الشروط والأحكام الواردة في عقد الإيجار الماثل وبموجبه يُقر المستأجر ويوافق على ذلك.
<br><br><br>
١)	ويُقر المستأجر أنه/أنها، إلى جانب ممثله/ ممثليهم الوارد ذكر اسمهم في الصفحة التالية في العمود المخصص "باسم المستخدم"، يحمل رخصة قيادة السيارة المستأجرة وفقاً للقوانين المرورية المعمول بها في دولة الإمارات العربية المتحدة.
<br><br>

٢)	ويُقصد بعبارة "مدة الإيجار" الواردة في العقد المدة التي يقوم المستأجر فيها بإيجار السيارة المذكورة أو السيارة/ السيارات البديلة إن وجدت وحتى إعادة تسليمها إلى المؤجر.
<br><br><br>

٣)	يُقر المستأجر أن السيارة تم تسليمها إليه/ إليها بحالة جيدة وفي حالة جديرة بالسير على الطرق، كما يُقر أيضاً بإعادتها بنفس الحالة التي كانت عليها مع جميع الملحقات إلى مركز المبيعات/ الخدمة الخاص بالمؤجر أو مكان آخر يرد ذكره في الصفحة التالية متبوعاً بالتاريخ المتفق عليه أو قبل ذلك عند طلب المؤجر. يحتفظ المؤجر بحق استعادة السيارة في أي وقت دون طلب على نفقة المستأجر في حالةانتهاك شروط وأحكاماستخدام السيارة الواردة بهذا العقد.

<br><br>
٤)	يتحمل المستأجر تكلفة الوقود والبنزين المستهلك خلال مدة الإيجار وعليه التأكد من أن السيارة مملوءة بشكل صحيح بالوقود المناسب ومياه التبريد ومياه البطارية في جميع الأوقات وأن الإطارات مضغوطة بشكل صحيح وأن السيارة والأجهزة ليست فاسدة أو تالفة.

 ويجب أيضاً الحفاظ على نظافة السيارة خلال فترة الإيجار. قد يؤدي عدم إجراء هذه الفحوصات إلى تلف السيارة، وفي هذه الحالة يكون المستأجر مسؤولاً عن جميع تكاليف الإصلاح المتكبدة.
<br><br><br><br>
٥)	يعفي المؤجر نفسه من أي مسؤولية تتعلق بأي نقود أو مقتنيات قيمة تعود ملكيتها للمستأجر والتي قد يمكن فقدها أثناء وجود السيارة بحوزته أو بعد انتهاء فترة الإيجار بالكامل أو عند استخدام السيارة لإصلاحات الصيانة.

<br><br>
٦)	يجب على المستأجر التأكد من إمهار توقيعه على مستندات تسليم السيارة واستلامها عند وقت تسليم السيارة أو إعادتها، وإلا سيتم التعامل مع تاريخي الدخول والخروج المذكورين في العقد في الصفحة التالية على أنهما تاريخي الإيجار وإلغاء الإيجار لأغراض الفوترة.
 
<br><br>
٧)	يتحمل المستأجر مسؤولية الحفاظ على نظافة السيارة، وإلا سيتم فرض رسوم تبلغ قيمتها ٥٠ درهماً إماراتياً لتنظيف السيارة من الخارج و٣٠٠ درهم إماراتي لتنظيف السيارة من الداخل.
<br><br>
٨)	يُعد تاريخ الاستحقاق المذكور في العقد و التاريخ المزمع فيه إعادةالسيارةمن قبل المستأجر، والذي قد يتم تمديده كما يتم الاتفاق عليه خطياً بشكل متبادل.
<br><br>

٩)	السداد: 
أ‌.	بالنسبة لدفعات السداد المتأخرة، يمنح المستأجرون فترة قصوى مدتها أسبوعان لتسوية المبالغ المتأخرة، وإلا سيتم اعتباره انتهاكاً لهذا العقد وسيتم اتخاذ إجراء مناسب مثل استعادة السيارة أو اتخاذ الإجراء القانوني المناسب، إذا لزم الأمر.
  علاوة على ذلك، للمؤجر بعد ذلك الحق في تغيير الأسعار المذكورة في العقد إلى الأسعار السائدة في السوق الخاصة بأسعار السيارات لكل يوم.  يُعفى المؤجر أيضاً من سداد مصاريف الصيانة الاحتياطية و/أو السيارة البديلة في حالة عدم الدفع، وتقع مسؤولية أي أضرار ناتجة عن ذلك على المستأجر الذي سيكون مسؤولاً عن تعويض المؤجر عن الإصلاحات.

<br><br><br><br>
ب‌.	أُقر أنا/نحن بالموافقة على الشروط والأحكام المذكورة على جانبي هذا العقد. كما أؤكد وأوافق على إتمام عملية سداد المبالغ المستحقة باستخدام بطاقة الائتمان/ الخصم. يعد توقيعي على هذا العقد بمثابة تفويضاً لسحب المبالغ المتعلقة بهذه المعاملات من بطاقتي، والتي تشمل، على سبيل المثال لا الحصر، رسوم الإيجار، ورسوم التأمين، ومسؤولية الأضرار، ورسوم سالك/المرور، والغرامات المرورية، والرسوم الإدارية، ورسوم الوقود، وأي رسوم أخرى تعزى مباشرة إلى عقد الإيجار الماثل. وأقر بموافقتي على أن يتم سحب رسوم سالك/المرور، أو الغرامات المرورية، أو الأضرار الناجمة (بدون إبلاغ الشرطة) من حسابي حتى بعد انتهاء العقد.
<br><br>
ت‌.	بالنسبة للعملاء الذين يدفعون المبالغ المستحقة عليهم نقداً، يجب عليهم تسوية ديونهم فور حدوثها. وتمنح فترة سماح مدتها ٢٤ ساعة، وبعد ذلك يكون للشركة الحق في مصادرة سياراتهم. وفي مثل هذه الحالة، يكون العميل مسؤولاً عن سداد رسوم الاسترداد وجميع النفقات الأخرى المتكبدة خلال فترة الإيجار. سيتم اعتبار جميع هذه النفقات، إذا لم يتم سدادها، ملزمة على العميل، والتي يجب على العميل تسويتها وسدادها.

<br><br><br>
ث‌.	في حالة السداد عن طريق شيك، سيتم فرض رسوم إضافية قدرها ٣٠٠ درهم إماراتي لكل شيك مرتد.
<br><br>
١٠) يكون المستأجر مسؤولاً عن سداد ما يلي للمؤجر:
أ‌.	رسوم الإيجار المتفق عليها بين المؤجر والمستأجر كما هو موضح في الصفحة التالية وجميع الرسوم المتراكمة نتيجة لهذا الاتفاق حتى نهاية مدة الإيجار.
<br><br>
ب‌.	رسوم إيجار إضافية، بما في ذلك رسوم الخدمة/ رسوم المواقف إذا تم ترك السيارة في مكان آخر دون إبلاغ المؤجر خطياً و/أو دون موافقة المؤجر على ذلك خطياً.
<br><br><br>
ت‌.	تكلفة الإصلاحات الناجمة عن أي نوع من سوء الاستخدام والإهمال، بما في ذلك، على سبيل المثال لا الحصر، قيادة السيارة دون الحفاظ على مستوى المياه المطلوب ومستويات زيت المحرك وجميع المتطلبات الأساسية الأخرى لقيادة السيارة بسلاسة و/أو قيادتها خارج الطريق أو على طرق غير مستوية.
 يلتزم المستأجر بسداد رسوم الإيجار الأساسية للمؤجر حتى الانتهاء من الإصلاحات.
<br><br>
ث‌.	يتعين على المستأجر سداد الغرامات المرورية ورسوم نظام سالك أو أي نفقات أخرى ذات صلة تكبدها نتيجة لخرق المرور/ارتكاب المخالفات خلال مدة عقد الإيجار، بغض النظر عن أي تأخير في الوقت في إشعار سلطات المرور الإماراتية. على المستأجر الاستجابة لمثل هذه الإشعارات على الفور. 
تقع مسؤولية الحصول على الأدلة الوثائقية، إن وجد، من السلطات بالكامل على المستأجر.
<br><br><br>
ج‌.	في حالة عدم تقديم المستأجر أي اعتراضات خطية للمؤجر في غضون ٧ أيام من تاريخ الفاتورة، يُعد ذلك بمثابة موافقة منه على الفواتير الكاملة المرسلة له من قبل المؤجر.
<br><br><br>
ح‌.	سيدفع المستأجر فائدة سنوية قدرها ١٢% عن أي مبلغ مستحق لمدة تزيد عن ٣٠ يوماً.
<br><br><br>

خ‌.	في حالة الإلغاء المبكر لعقد إيجار للسيارة بخلاف ما هو محدد ووارد في العقد، يحتفظ المؤجر بحقه في تغيير قيمة الإيجار على أساس يومي وفقاً للسعر الأساسي اليومي المذكور في قائمة أسعار شركة لتس رايد لتأجير السيارات ذ.م.م. يحتفظ المؤجر أيضاً بحقه في عدم إجراء أي خصم في حالة التأخر أو التأخير في السداد.
<br><br>



١١) الخدمة/الصيانة 
أ‌.	تتضمن رسوم الإيجار تقديم الخدمة الدورية المجانية أولاً عند ١٠٠٠ كم للسيارة الجديدة، وبعد ذلك يجب على المستأجر تقديم إشعاراً مسبقاً (يومين) عند كل ٣٠٠٠ كم للخدمة أو الشكاوى لتوفير سيارة بديلة قد تكون أو لا تكون من نفس نوع السيارة المستأجرة أثناء فترة تقديم الصيانة والخدمة.

 في حالة حدوث عطل، سيتم توفير سيارة بديلة بأسرع وقت ممكن. يتحمل المستأجر مسؤولية إرجاع السيارة البديلة في غضون ٢٤ ساعة من إرسال شركة لتس رايد لتأجير السيارات ذ.م.م الإشعار الذي ينص على أن خدمة السيارة الأصلية أو صيانتها قد اكتملت. وفي حالة عدم تنفيذ ذلك، يعد بمثابة انتهاكاً للشروط والأحكام الواردة بهذا العقد، وتُطبق الرسوم الكاملة.
<br><br><br><br>
ب‌.	يتعهد المستأجر أيضاً بإعادة السيارة إلى المؤجر لإجراء الخدمات الدورية. في حالة التأخير في تلقي الخدمة، سيتم فرض غرامة قدرها ٥٠٠ درهم إماراتي عن كل ١٠٠٠ كم، وفي حالة حدوث ضرر خطير للمحرك بسبب التأخر عن تلقي الخدمة، سيكون العميل مسؤولاً عن دفع المبلغ الإجمالي للأضرار. 

<br><br>
ت‌.	وسيتم بعد ذلك تمديد فترة الإيجار لتغطية الوقت المستغرق لإصلاح هذه الأضرار. ويجب على المستأجر عدم السماح بأي عمل للسيارة دون إذن خطي من شركة لتس رايد لتأجير السيارات ذ.م.م.
<br><br>
ث‌.	يوافق المستأجر على تعويض المؤجر عن أي أضرار لحقت بالإطارات و/ أو جنوط السيارة أثناء وجودها بحوزته، ويتحمل المستأجر أيضاً مسؤولية الأضرار الناتجة عن قيادة السيارة في بركة من الماء أو أي منطقة أخرى قد تسبب حدوث تلف للسيارة حيث لا يمكن مطالبة شركات التأمين بالتعويض عن مثل هذه الأضرار.
يجب على المستأجر إصلاح الثقوب، إن وجدت. وتُفرض رسوم على المستأجر عن الأضرار التي لحقت بالإطارات بسبب الثقوب.
<br><br><br>

١٢) التأمين/ المسؤولية عن الحوادث:
أ‌.	يجب الإبلاغ فوراً عن جميع الحوادث لسلطات الشرطة المختصة وسيتم الحصول على تقارير الشرطة اللازمة. يمكن تقديم تقارير الحوادث على رقم الهاتف ٩٩٩ لكافة الإمارات. علاوة على ذلك، يجب أيضاً إبلاغ المؤجر كتابياً بجميع الحوادث التي تتعلق بالسيارة على الفور.
<br><br><br>
ب‌.	تُؤمَّن المركبات تأميناً شاملاً وفقاً لقوانين الإمارات العربية المتحدة. سيكون المستأجر مسؤولاً عن الحد الأدنى من المسؤولية تجاه الحوادث/ الأضرار بقيمة ۱۷٥۰ درهماً إماراتياً أو التكاليف الفعلية إذا كانت أكثر لأي أضرار أو تكاليف إصلاح، كما هو مذكور في تقرير الشرطة. لا يجوز النظر في تقرير الشرطة الذي لا يذكر الغير أو بعبارة أخرى الذي لا يمكن استردادها من الغير، وسيُعتبر من مسؤولية المستأجر. في غياب تقرير الشرطة، لن تقتصر مسؤولية المستأجر على المبلغ المذكور أعلاه في الصفحة التالية. لن يتم تغطية التأمين ضد الحوادث الشخصية للسائق وأقاربه المباشرين فيما يتعلق بالوفاة أو الإصابات الجسدية بأي حال من الأحوال.
<br><br><br>
ت‌.	لن يتم تغطية التأمين لأي سائق يقل عمره عن ۲٥ عاماً أو لأي سائق تكون رخصة قيادته أقل من سنة واحدة.
<br><br>
١٣) تنبيه المستأجر:

      أ) لن تُستخدم السيارة:
      ١- من قِبل أي شخص:
 أ) غير مرخص بشكل صحيح لقيادة السيارة و/أو غير مرخص له كتابياً مسبقاً أو مفوض من قِبل المؤجر.
ب) أُعطى له اسماً وهمياً وعمراً وعنواناً ورقم هاتف وبيانات ترخيص زائفة وغير صحيحة.	
ج) كان تحت تأثير المشروبات الكحولية أو العقاقير/ المواد المخدرة أو أي مادة أخرى تُؤثر على الوعي أو القدرة على التفاعل.
د) تمت إدانته في أي وقت بارتكاب أي جريمة تتعلق بالسيارات ما لم يُكشف عن التفاصيل للمؤجر وطلب موافقة المؤجر كتابياً والحصول عليها. 
هـ) أن لا يقل عمره عن ۲٥ سنة أو حاصل على رخصة لم يمض عليها أكثر من سنة.

٢- بأي طريقة من شأنها أن تجعل التأمين لاغياً. 
٣- إخضاع أو نقل الركاب أو الممتلكات مدى الحياة أو المكافأة لأغراض أعمال المستأجر ما لم يكن لديه الترخيص أو التصاريح اللازمة.
 ٤- نقل عدد أكبر من الأشخاص مقارنة بالعدد الذي صُممت السيارة من أجله.
 ٥- لأي أغراض غير قانونية.
 ٦- نقل حمولة غير مؤمنة بشكل صحيح أو محمَّلة بشكل غير مناسب أو التي تتجاوز قدرة السيارة أو التي قد تسبب ضرراً للسيارة أو لمستخدمي الطريق الآخرين و/أو الممتلكات العامة، بما في ذلك المواد الخطرة.
 ٧- دفع أو سحب مركبة أخرى أو مقطورة أو أي جسم آخر،
 ٨- لأغراض السباقات وتحديد السرعة واختبارات الموثوقية وسباقات السرعة والاختبارات المتعلقة بها. دروس القيادة أو الأغراض المماثلة.
 ٩- نقل أي نوع من المشروبات الكحولية و/أو العقاقير/ المواد المخدرة. بالإضافة إلى ذلك، في حال حجز أو احتجاز السيارة من قِبل الشرطة، يكون المستأجر ملزماً بسداد جميع الرسوم (بما في ذلك الإيجار المستحق) والخسائر والأضرار والغرامات والعقوبات والنفقات إلى المؤجر بسبب هذا الأمر أو فيما يتعلق به.
١٠- خارج بلد الإيجار ما لم يتم الحصول على إذن كتابي مسبق من المؤجر، وكذلك في المناطق الجغرافية التي يعتبرها المؤجر مناطق مقيدة.
<br><br><br><br><br><br>
١٤) يجب على المستأجر التأكد من إيقاف السيارة في مكان آمن ومؤمّن وأن تكون مقفلة عندما لا تكون قيد الاستخدام. في حال إلحاق أي ضرر بالسيارة وفقدان المفاتيح. سيكون المستأجر مسؤولاً عن المبلغ المذكور في البند ۱٤ (أ) و (ب).
<br><br>
١٥) جميع المركبات، بما في ذلك على سبيل المثال لا الحصر، سيارات الدفع الرباعي "٤ × ٤"، مخصصة للقيادة على الطرق المرصوفة فقط. يجب ترتيب أي استخدام خارج الطرق المرصوفة مسبقاً والحصول على إذن كتابي من المؤجر لجميع السيارات بما في ذلك الدفع الرباعي، وإلا فإن القيادة خارج الطرق المرصوفة غير مسموح بها. سيُفرض على المستأجر رسوماً عن أي ضرر يتسبب به نتيجة للقيادة بطريقة مخالفة للشروط المذكورة أعلاه.
في حال حدوث عطل خارج الطرق المرصوفة أو بعيداً عن الطرق العامة، فإن مسؤولية إعادة السيارة إلى الطريق تقع على عاتق المستأجر وعلى نفقته. 
<br><br>

١٦) في حال حدوث أي خرق لشروط هذا العقد، يحق للمؤجر، دون المساس بأي حقوق أو تعويضات أخرى قد تكون له، إنهاء الإيجار على الفور واستعادة ملكية السيارة.
<br><br><br>


١٧) ستُفرض رسوم لقيمة بطاقة سالك بمقدار ٥ دراهم إماراتية لكل رسوم سالك.
<br><br>
١٨) ستُطبق رسوم الوقود بمقدار ٥ دراهم إماراتية لكل لتر.
<br><br>
١٩) سيكون الحد الأقصى للمسافة اليومية ۲۰۰ كيلومتر، وأي مسافة تتجاوز ذلك ستُحتسب بمقدار ۰.٥۰ فلس لكل كيلومتر
<br><br>
٢٠) ستُمنح فترة سماح مدتها ساعتان في تاريخ الإرجاع. أي تأخير إضافي سيؤدي إلى فرض رسوم عن يوم كامل.
<br><br>
٢١) تقع جميع الغرامات والتزامات هيئة الطرق والمواصلات (RTA) على مسؤولية العميل. يُحتفظ بالوديعة النقدية لمدة ۲٥ يوماً بعد تاريخ تسجيل الدخول لتعويض الغرامات. وبعد مرور ۲٥ يوماً، ستُرجع الوديعة، ولكن سيظل المستأجر مسؤولاً عن تسوية أي التزامات تتعلق بهيئة الطرق والمواصلات (RTA) التي نشأت خلال فترة الإيجار. في حال استخدام بطاقات الائتمان، يحق لشركة "لتس رايد لتأجير السيارات ذ.م.م" فرض الغرامات أو أي التزامات أخرى ناتجة عن فترة الإيجار. يُسمح للمستأجر بمثل هذا الإجراء حسب الأصول. ستُفرض رسوم توثيق وتعامل قدرها ۸۰ درهماً إماراتياً لكل غرامة.
<br><br>
٢٢) سيكون آخر موعد لتسجيل الدخول الساعة ٦:۰۰ مساءً. لا يُسمح بتسجيل الدخول في أيام الأحد والعطلات الرسمية.
<br><br>
٢٣) في حال مصادرة السيارات، ستُفرض رسوم قدرها ٥۰۰ درهم إماراتي مقابل استرداد السيارة من المستأجر.
<br><br>
٢٤) سيكون الحد الأدنى لرسوم المفاتيح المفقودة ۱۸۰۰ درهم إماراتي. ستُفرض رسوم قدرها ۲۹۰ درهماً إماراتياً عند طلب مفتاح احتياطي.
<br><br>
٢٥) في حال انتهاء صلاحية التسجيل، سيدفع العميل غرامة قدرها ۳۰۰ درهم إماراتي شهرياً على انتهاء مدة التسجيل.
<br><br>
٢٦) يحتفظ المؤجر بالحق في تغيير شروطه وأحكامه دون أي إخطار للطرف الآخر. يحتفظ المؤجر بالحق في تحصيل المبلغ من البطاقة دون أي إخطار.
<br><br><br>
٢٧) يخضع هذا العقد ويُفسر وفقاً للقوانين المعمول بها في دولة الإمارات العربية المتحدة. يتحمل المستأجر جميع الرسوم القانونية وأتعاب المحاماة ويتفق الطرفان على ذلك.
<br><br><br>
٢٨) اللغة – في حال وجود تعارض بين نص هذا العقد باللغة الإنجليزية ونص هذا العقد باللغة العربية أو أي ترجمة عربية أخرى وأي محكمة مختصة تقرر أن النص أو الترجمة العربية هو الذي يسود، فإنه يُتفق على أن النص الإنجليزي لهذا العقد سيُستخدم رغم ذلك للمساعدة في أي تفسير.
<br><br><br>
٢٩) يُقر المستأجر بأن البيانات المتعلقة بالشخص في عقد الإيجار هذا سيتم معالجته تلقائياً. ويوافق صراحةً على أنه يمكن إرسال هذه البيانات إلى الغير، وخاصة لأغراض حماية الائتمان. 
<br><br>
٣٠) في حال ضبط سائق غير مذكور في هذا العقد وهو يقود السيارة، يحق للمؤجر فرض غرامة قدرها ٤۰۰۰ درهم إماراتي بخلاف الغرامات التي تفرضها الدولة والأضرار الأخرى المتكبدة. في حال وجود سائق إضافي، يكون كل من المستأجر والسائق الإضافي مسؤولين عن الالتزام بجميع شروط وأحكام هذا العقد.
</p></div>
                </div>
            </td>
        </tr></table>
        </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    