
 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<title>GatewayERP(i)</title>
<link rel="stylesheet" href="../../../../css/body.css">
<script type="text/javascript">

$(document).ready(function(){
	getPrintTrafficConfig();funbnkdetls();
	//hidedat();
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");    

	 $("#printfromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    $("#printtodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
    //$('#printGrid').jqxGrid({'disabled',true});
    $("#rdbncmprhnshow").hide();
	 $("#rdbncmprhnhide").hide();
	 $("#lblwithouttotal").hide();
	 $("#lblwithtotal").hide();
    
});
function isNumber(evt,id) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
     {
    	 $.messager.alert('Warning','Enter Numbers Only');
       $("#"+id+"").focus();
        return false;
        
     }
    
    return true;
}
 function changeRdo(){
 
 if(document.getElementById("rdosingle").checked==true){
 	document.getElementById("tono").disabled=true;
 	document.getElementById("printgriddiv").style.display="none";
 	$('.multiprint').attr('hidden',true);
 	document.getElementById("btnPrintSearch").style.display="none";
 	 	
 }
if(document.getElementById("rdomultiple").checked==true){
 	document.getElementById("tono").disabled=false;
 	 document.getElementById("printgriddiv").style.display="block";
 	$('.multiprint').attr('hidden',false);
 	document.getElementById("btnPrintSearch").style.display="block";
 }
  var voc='<%=request.getParameter("voc")%>';
 if(voc!=""){
	 document.getElementById("fromno").value=voc;
 }
 
 }
 

 function funcmprhncheck(){
 	if(document.getElementById("rdbncmprhnshow").checked){
 			$('#cmprhnstat').val("1");
 		}
 		if(document.getElementById("rdbncmprhnhide").checked){
 			$('#cmprhnstat').val("0");
 		}

 }
 
 function funbnkdetls()
	{
		
	   var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
		       var items= x.responseText.trim();
		       if(parseInt(items)>0){
		    	   document.getElementById("hidbnk").value="1";
					
		       }
				else{
					 document.getElementById("hidbnk").value="0";
					
				}
		       if(document.getElementById("hidbnk").value=="1") {
		    		
		    		$("#cmbprintbankname").show();
		    		getbankname();
		    		$('.bankrow').show();
		    	}
		    	else {
		    		$("#cmbprintbankname").hide();
		    		$('.bankrow').hide();
		    	}
				}
			else{
				
			}
			}
	x.open("GET","shwbnkdetls.jsp?",true);

	x.send();
			
	}
 function getbankname() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var banknameItems = items[0].split(",");
				var bankIdItems = items[1].split(",");
				var optionsbanknames = '<option value="">--Select--</option>';
				for (var i = 0; i < banknameItems.length; i++) {
					optionsbanknames += '<option value="' + bankIdItems[i] + '">'
							+ banknameItems[i] + '</option>';
				}
				$("select#cmbprintbankname").html(optionsbanknames);
				
			} else {
			}
		}
		x.open("GET", "getBankName.jsp", true);
		x.send();
	}
 
function funGetPrint(){
	document.getElementById("printdocno").value="";
	var header=0;
	if(document.getElementById("chkheader").checked==true){
		header=1;
	}
	else{
		header=0;
	}
	var chkdeletedinvprint=0;
	 if(document.getElementById("chkdeletedinvprint").checked==true){
	 	chkdeletedinvprint=1;
	 }
	 else{
	 	chkdeletedinvprint=0;
	 }
	if(parseFloat(document.getElementById("fromno").value)==0){
		$.messager.alert('Message',"Please Enter valid Inv No");
			document.getElementById("fromno").focus();
			return false;
	} 
	if(parseFloat(document.getElementById("tono").value)==0){
		$.messager.alert('Message',"Please Enter valid Inv No");
			document.getElementById("tono").focus();
			return false;
	}
	if(document.getElementById("rdosingle").checked==true){
 		if(document.getElementById("fromno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("fromno").focus();
 			return false;
 		}
	document.getElementById("tono").disabled=false;
 	
	document.getElementById("tono").value=document.getElementById("fromno").value;
 }
	else if(document.getElementById("rdomultiple").checked==true){
	
		var rows=$('#printGrid').jqxGrid('selectedrowindexes');
		for(var i=0;i<rows.length;i++){
			if(i==0){
				document.getElementById("printdocno").value+=$('#printGrid').jqxGrid('getcellvalue',rows[i],'voucherno');
			}
			else{
				document.getElementById("printdocno").value+=","+$('#printGrid').jqxGrid('getcellvalue',rows[i],'voucherno');
			}
		}
		
		if(document.getElementById("fromno").value=="" && document.getElementById("tono").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Both Inv Nos");
 			document.getElementById("fromno").focus();
 			return false;
 		}
		if(document.getElementById("fromno").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("fromno").focus();
 			return false;
 		}
		if(document.getElementById("tono").value=="" && document.getElementById("printdocno").value==""){
 			$.messager.alert('Message',"Please Enter Inv No");
 			document.getElementById("tono").focus();
 			return false;
 		}
		
		
	}
	var trafic=0;
	if(document.getElementById("rdbncmprhnshow").checked){
		
		trafic=1;
	}
	else
		{
		trafic=0;
		}
	var url=document.URL;
	 var reurl=url.split("printVoucherWindow.jsp");
	 var branch='<%=request.getParameter("branch")%>'; 
	 var cmprhnstat=$("#cmprhnstat").val();
	 var partsconfig=$("#partsconfig").val();
	 //alert(1)
	 var bankdocno=$('#cmbprintbankname').val();
		//alert("bankdocno--"+bankdocno)
		if($('#cmbprintbankname').val()=='' && document.getElementById("hidbnk").value=="1"){
			$.messager.alert('Message','Choose a Bank.','warning');
			return 0;
		}
		
    var win= window.open(reurl[0]+"printManualInvoice?fromno="+document.getElementById("fromno").value+"&tono="+document.getElementById("tono").value+"&branch="+branch+"&printdocno="+document.getElementById("printdocno").value+"&hidheader="+header+"&chkdeletedinvprint="+chkdeletedinvprint+"&cmprhnstat="+cmprhnstat+"&partsconfig="+partsconfig+"&trafic="+trafic+"&bankdocno="+bankdocno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
    win_voucher.close();
}

function getPrintTrafficConfig(){ 
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			items = x.responseText.trim();
			$('#partsconfig').val(items); 
			
			//alert("partsconfig=="+$('#partsconfig').val());
			if($('#partsconfig').val().trim()=='1'){
				 $("#rdbncmprhnshow").show();
				 $("#rdbncmprhnhide").show();
				 $("#lblwithtotal").show();
				 $("#lblwithouttotal").show();
			}
			/* else
				{
				$("#rdbncmprhnshow").show();
				 $("#rdbncmprhnhide").show();
				} */
				
		} else {
		}
	}
	x.open("GET", "getPrintTrafficConfig.jsp", true);
	x.send();
}

function funPrintGridLoad(){
	
	var agmtno=document.getElementById("printagmtno").value;
	var agmttype=document.getElementById("cmbprintagmttype").value;
	var client=document.getElementById("printclient").value;
	 var fromno=document.getElementById("fromno").value;
	 var  tono=document.getElementById("tono").value;
	 var chkdeletedinvprint=0;
	 
	 if(document.getElementById("chkdeletedinvprint").checked==true){
	 	chkdeletedinvprint=1;
	 }
	 else{
	 	chkdeletedinvprint=0;
	 }
	 
var branch='<%=request.getParameter("branch")%>';
if(agmttype=="" && agmtno!=""){
	$.messager.alert('Warning','Please Select Agmt Type');
	return false;
}
if(cmprhnstat==""){
		$.messager.alert('Message','Select a Comprehensive Option...','warning');
		return false;
	}
	//	$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1+"&branch="+document.getElementById("brchName").value);
$("#overlay, #PleaseWait").show();
	$("#printgriddiv").load("printGrid.jsp?fromdate="+$("#printfromdate").jqxDateTimeInput("getText")+"&todate="+$('#printtodate').jqxDateTimeInput('getText')+"&agmtno="+agmtno+"&agmttype="+agmttype+"&client="+client+"&branch="+branch+"&fromno="+fromno+"&tono="+tono+"&mode=1&chkdeletedinvprint="+chkdeletedinvprint);
}
</script>

<body onload="changeRdo();getPrintTrafficConfig();">
	<div id=search style="padding-left:100px;padding-right:100px;">
		<table style="width:100%;" border="0">
			<tr>
				<td>&nbsp;</td>
				<td>
					<input type="radio" name="rdoprint" id="rdosingle" checked onChange="changeRdo();">
					<label for="rdosingle">Single</label>
				</td>
				<td>&nbsp;</td>
				<td colspan="2">
					<input type="radio" name="rdoprint" id="rdomultiple"  onChange="changeRdo();">
      				<label for="rdomultiple">Multiple</label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td >
					<input type="checkbox" name="chkheader" id="chkheader"><label for="chkheader"> Header</label>
				</td>
				<td>&nbsp;</td>
				<td colspan="2">
					<input type="checkbox" name="chkdeletedinvprint" id="chkdeletedinvprint"><label for="chkdeletedinvprint"> Deleted Invoices</label>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td ><input type="radio" id="rdbncmprhnshow" name="rdbncmprhn" onchange="funcmprhncheck();" value="With Traffic fine" checked="checked"><label id="lblwithtotal">With Traffic fine</label></td>
				<td>&nbsp;</td>
				<td colspan="2"><input type="radio" id="rdbncmprhnhide" name="rdbncmprhn" onchange="funcmprhncheck();" value="Separate traffic fine"><label id="lblwithouttotal">Seperate Traffic fine</label>
					<input type="hidden" id="cmprhnstat" name="cmprhnstat" value="1" />
				</td>
			</tr>
			<tr class="bankrow">
    <td width="25%" align="center" colspan="3">Bank&nbsp;&nbsp;<select id="cmbprintbankname" name="cmbprintbankname" style="width:50%;" value='<s:property value="cmbprintbankname"/>'>
      <option value="">--Select--</option></select></td>
     
  </tr>
			<tr>
    			<td width="16%" height="21" align="right"><label class="branch">Doc No From</label></td>
    			<td width="25%" align="left"><input type="text" name="fromno" id="fromno" onkeypress="javascript:return isNumber (event,id)"></td>
    			<td width="15%" align="right"><label class="branch">Doc No To</label></td>
    			<td colspan="2" align="left"><input type="text" name="tono" id="tono" onkeypress="javascript:return isNumber (event,id)"></td>
    			<td width="21%" align="left"><button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()">Print</button></td>
  			</tr>	
  			<tr>
    			<td align="right"><label class="multiprint">From Date</label></td>
    			<td align="left"><div id="printfromdate" class="multiprint"></div></td>
    			<td align="right"><label class="multiprint">To Date</label></td>
    			<td width="14%" align="left"><div id="printtodate" class="multiprint"></div></td>
    			<td width="9%" align="right"><label class="multiprint">Agmt Type</label></td>
    			<td align="left"><select name="cmbprintagmttype" id="cmbprintagmttype" class="multiprint">
      				<option value="">--Select--</option>
      				<option value="RAG">Rental</option>
      				<option value="LAG">Lease</option>
    			</select></td>
  			</tr>
  			<tr>
			    <td align="right"><label class="multiprint">Client</label></td>
			    <td align="left"><input type="text" name="printclient" id="printclient" class="multiprint"></td>
			    <td align="right"><label class="multiprint">Agmt No</label></td>
			    <td align="left"><input type="text" name="printagmtno" id="printagmtno" class="multiprint"></td>
			    <td align="left">&nbsp;</td>
			    <td align="left"><button type="button" name="btnPrintSearch" id="btnPrintSearch" class="myButton" onclick="funPrintGridLoad();">Search</button></td>
  			</tr>
  			<tr>
  				<td colspan="6"><div id="printgriddiv"><jsp:include page="printGrid.jsp"/></div></td>
  			</tr>
		</table>

<input type="hidden" name="printdocno" id="printdocno">
<input type="hidden" name="partsconfig" id="partsconfig">
<input type="hidden" name="hidbnk" id="hidbnk">
</div>
</body>
</html>