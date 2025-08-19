<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <%@ page pageEncoding="utf-8" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<% String contextPath=request.getContextPath();%>
<!--  <title>GatewayERP(i)</title> --> 
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
	font-size: 8px;
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
.border {
 /*  position: fixed; */
  top: 0;
  left: 0;
  bottom:0;
  
  border: 3px groove #ABB2B9;
  width: 100%;
  height: 100%;
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
#rowheight{
height:80px;
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
    <td width="22" rowspan="6" ><img src="<%=contextPath%>/icons/epic.jpg" width="200" height="70"  alt=""/></td> 
    <td width="52%" rowspan="2">&nbsp;</td>
    <td width="26%"><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
  </tr>
  <tr>
    <td><b><label id="address" name="address"><s:property value="address"/></label></b></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b><font size="4"> &nbsp;&nbsp; &nbsp;&nbsp;Rental Agreement</font></b></td>
    <td align="left"><b>Tel :</b>&nbsp;<label id="mobileno" name="mobileno"><s:property value="mobileno"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Email :</b>&nbsp;<label id="lblcompmail" name="lblcompmail"><s:property value="lblcompmail"/></label></td>
  </tr>
  <tr>
    <td rowspan="2"  align="center"><b>&nbsp;&nbsp;RANO :</b><b><label id="rentaldoc" name="rentaldoc" ><s:property value="barnchval"/>&nbsp;-&nbsp;<s:property value="rentaldoc"/></label></b>
    &nbsp;&nbsp; <%-- <b>MRA NO# :<label id="mrano" name="mrano"><s:property value="mrano"/></label></b> --%>&nbsp;&nbsp; 
    <b>RA :</b><b><label  id="rastatus" name="rastatus"><s:property value="rastatus"/></label></b>
     </td>
    <td align="left"><b>Branch :</b>&nbsp;<label id="barnchval" name="barnchval"><s:property value="barnchval"/></label></td>
  </tr>
  <tr>
    <td align="left"><b>Website :</b>&nbsp;<label id="lblcompwebsite" name="lblcompwebsite"><s:property value="lblcompwebsite"/></label></td>
  </tr>
  <tr>
    <td colspan="3"><hr noshade size=1 width="100%"></td>  
  </tr>
</table>
<table width="100%" >
  <tr>
  <td width="50%">
  <fieldset>
  <table width="100%" > 
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
 <br>&nbsp;
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
        <fieldset><legend><b>Rental Rates</b></legend>  
      <table  width="100%"  >
   
        <tr> <td width="40%">Rent Type</td><td  width="20%" align="right"><label id="rarenttypes" name="rarenttypes"><s:property value="rarenttypes"/></label></td><td  width="30%" >&nbsp; </td></tr>
        
       <tr> <td width="40%">Tariff</td><td  width="20%" align="right"><label id="tariff" name="tariff"><s:property value="tariff"/></label></td><td  width="30%" >&nbsp; </td></tr>
                
      <tr> <td width="40%">CDW</td><td  width="20%" align="right"><label id="Selcarcdw" name="Selcarcdw"><s:property value="Selcarcdw"/></label></td><td  width="30%" >&nbsp; </td></tr>
                        
      <tr> <td width="40%">PAI</td><td  width="20%" align="right"><label id="lblpai" name="lblpai"><s:property value="lblpai"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
        <tr> <td width="40%">Cardoo</td><td  width="20%" align="right"><label id="racardoo" name="racardoo"><s:property value="racardoo"/></label></td><td  width="30%" >&nbsp; </td></tr>
       <tr> <td width="40%">Accessories</td><td  width="20%" align="right"><label id="raaccessorysum" name="raaccessorysum"><s:property value="raaccessorysum"/></label></td><td  width="30%" >&nbsp; </td></tr>
       
              <tr> <td width="40%">Delivery Chrges</td><td  width="20%" align="right"><label id="laldelcharge" name="laldelcharge"><s:property value="laldelcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>
      
                    <tr> <td width="40%">Add Driver Charge</td><td  width="20%" align="right"><label id="raadditionalcge" name="raadditionalcge"><s:property value="raadditionalcge"/></label></td><td  width="30%" >&nbsp; </td></tr>
                    
                <tr> <td width="40%">Chaufer Charge</td><td  width="20%" align="right"><label id="lblchafcharge" name="lblchafcharge"><s:property value="lblchafcharge"/></label></td><td  width="30%" >&nbsp; </td></tr>      
                    
              <tr> <td width="40%">Restrict KMS</td><td  width="20%" align="right"><label id="raextrakm" name="raextrakm"><s:property value="raextrakm"/></label></td><td  width="30%" >&nbsp; </td></tr>  
              
              
                <tr> <td width="40%">Excess KM Rate</td><td  width="20%" align="right"><label id="raexxtakmchg" name="raexxtakmchg"><s:property value="raexxtakmchg"/></label></td><td  width="30%" >&nbsp; </td></tr>
                   
                    

  </table>
    </fieldset>  
     <br> <br>&nbsp;
  </td>   </tr>
  <tr>
  <td colspan="2">
	  <fieldset><legend style="width: 400px;"><b>Terms</b></legend>
	    <table width="100%">
		 <tr>
		  <td width="50%">
		  <fieldset>
			  <p align="justify">We do hereby authorize Abaan Enterprises RENT A CAR CO.L.L.C  to charge the above-mentioned credit card in Absent Environment</p><br>   
			  <p align="justify">I/We agree the rate agreed is valid only for the aforementioned duration and the rate may change if there is any change to the duration.</p><br> 
			  <p align="justify">VAT @ 5% will be charged on all rental, non-rental and other services charges.</p><br> 
			  <p align="justify">Smoking in this car is prohibited, charge of AED 500 will apply in case of violation.</p><br> 
			  <p align="justify">SALIK / DARB: AED.5.00/- plus VAT per crossing of SALIK Road toll gates will be charged and traffic fines with an admin fee of AED 50 plus VAT per instance if any of these are incurred.</p><br> 
			  <p align="justify">I/We acknowledge that we have read and understood the terms & conditions printed above and overleaf and hereby acknowledge myself/ourselves to be bound thereby</p><br> 
			  <p align="justify"> Excess Insurance Deduction -<label   id="Lblcosmoexcessamt" name="Lblcosmoexcessamt"><s:property value="Lblcosmoexcessamt"/></label></p><br>
			  <p align="justify">Hirer's Signature</p><br> 
		  </fieldset></td>
		 <td width="50%">
		 <fieldset>
		  <p  align="right">نفوض بموجب الاتفاق شركة دبليو تي آي لتأجير السيارات للخصم من بطاقة الائتمان المذكورة أعلاه في غياب صاحب البطاقة</p><br>
		  <p  align="right">نوافق على أن السعر المتفق عليه ساري فقط للمدة المذكورة أعلاه وقد يتغير السعر في حال حدوث أي تغيير في المدة.</p><br><br>
		  <p  align="right">تُفرض ضريبة القيمة المضافة بنسبة 5% على جميع رسوم الإيجار وغير الإيجار ورسوم الخدمات الأخرى.</p><br>
		  <p  align="right">التدخين ممنوع في هذه السيارة، وتطبق غرامة قدرها 500 درهم في حالة المخالفة.</p><br>
		  <p  align="right">سالك / درب: -/5.00 درهم إماراتي بالإضافة إلى ضريبة القيمة المضافة لكل عبور لبوابات طريق سالك وغرامات المرور مع رسوم إدارية قدرها 50 درهم إماراتي بالإضافة إلى ضريبة القيمة المضافة لكل حالة على حدة في حالة حدوث أي منها.</p><br>
		  <p  align="right">نقر بأننا قد قرأنا وفهمنا الشروط والأحكام المبينة أعلاه وفي الصفحة التالية ونقر بموجبه أننا ملتزمون بذلك.</p><br><br><br><br>
		  <p  align="right">توقيع المستأجر</p><br>
</fieldset> 
</td></tr>
</table></fieldset>  
  </td>
    </tr>
   <tr id="rowheight"><td colspan="2">&nbsp;</td></tr>
    <tr><td colspan="2">&emsp;&emsp;Sign of Hirer&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Sign of Driver
    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;Sign of Employeer&emsp;&emsp;</td></tr>  
  </table>
  	<div style="page-break-after:always;"></div>
  	<br><br><br><br><br><br>	
	<table width="100%">          
		<tr><td width="100%"><img src="wtiprintterms.jpg" style="max-width: 100%; max-height: 100%; width: auto; height: auto;" alt=""/></td></tr>
	</table>      
 </div>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="docnoval" id="docnoval" value='<s:property value="docnoval"/>'  />
</form>
</div>
</div>
</body>
</html>
    