<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=contextPath%>/js/resample.js"></script>
<style type="text/css">

/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

.btn-whatsapp {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #25D366;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-whatsapp:hover {
    background: #1ebe5d;
}

.btn-wa-direct {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #128C7E;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-wa-direct:hover { background: #0e7268; }

#waDirectModal {
    display: none;
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: rgba(0,0,0,0.52);
    z-index: 9999;
    align-items: center;
    justify-content: center;
}

#waDirectModal.open { display: flex; }

.wa-modal-box {
    background: #fff;
    border-radius: 12px;
    padding: 24px;
    width: 350px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.22);
}

.wa-modal-title {
    font-size: 16px;
    font-weight: 700;
    color: #128C7E;
    margin-bottom: 14px;
}

.wa-modal-box input[type="text"] {
    width: 100%;
    padding: 9px 12px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 14px;
    margin-bottom: 5px;
    box-sizing: border-box;
}

.wa-modal-hint {
    font-size: 11px;
    color: #888;
    margin-bottom: 10px;
}

.wa-modal-preview {
    width: 100%;
    height: 130px;
    font-size: 12px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    padding: 8px;
    box-sizing: border-box;
    margin-bottom: 14px;
    resize: none;
    background: #f8fafc;
    color: #333;
    font-family: monospace;
}

.wa-modal-actions { display: flex; gap: 8px; }
.wa-modal-actions button {
    flex: 1; padding: 10px; border: none;
    border-radius: 6px; font-size: 13px;
    font-weight: 600; cursor: pointer;
}

.wa-send-btn { background: #25D366; color: #fff; }
.wa-send-btn:hover { background: #1ebe5d; }
.wa-cancel-btn { background: #f0f4f8; color: #4e5e71; }
.wa-cancel-btn:hover { background: #e1e8ed; }

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}

</style>

<script type="text/javascript">

$(document).ready(function () 
{
	

	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>"); 
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});

	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
     
     getInitData();
     
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#agmtvocno').dblclick(function(){
		
		  agreementSearchContent('agreementDetailsSearch.jsp'); 
		});
});


	function getInitData(){
		$.get('getInitData.jsp',function(data){
			data=JSON.parse(data);
			var htmldata='<option value="">--Select--</option>';
			$.each(data.catdata,function(index,value){
				htmldata+='<option value="'+value.docno+'">'+value.refname+'</option>';
			});
			$('#cmbcategory').html($.parseHTML(htmldata));
			
		});
	}
	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getAgreement(event){
	    var x= event.keyCode;
	    if(x==114){
	    
	    	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp');
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	function funExportBtn(){
		 $("#rentalInvoiceGrid").excelexportjs({
			containerid: "rentalInvoiceGrid",
			datatype: 'json',
			dataset: null,
			gridId: "rentalInvoiceGrid",
			columns: getColumns("rentalInvoiceGrid") ,
			worksheetName:"Invoices To Dispatch List"
		});	  
	}

	function  funClearData(){
		 $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#todate').val(new Date());$('#clstatuss').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementno").value == "") {
		        $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
			   
			   var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#todate').jqxDateTimeInput('focus');
					return false;
				}
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#agmtvocno').val();
		 var clstatuss= $('#clstatuss').val();
		 var invtype=$('#cmbinvtype').val();
		 var catid=$('#cmbcategory').val();
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load("rentalInvoiceGrid.jsp?catid="+catid+"&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&clstatuss='+clstatuss+'&invtype='+invtype);
			   }
			   }
	function chktype()
	{
		
		
		 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  }
		
		
	}
	
	
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#agmtvocno').val('');
	}
	
	function funPrintData(){
		
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
		document.getElementById("printdocno").value="";
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid document');
			return false;
		}
		/* for(var j=0;j<rows.length;j++){
			for(var i=0;i<selectedrows.length;i++){
				if(selectedrows[i]==j){
					if(i==0){
						document.getElementById("printdocno").value+=rows[j].doc_no;
					}
					else{
						document.getElementById("printdocno").value+=","+rows[j].doc_no;	
					}
				}
			}	
		} */
		var cnodocarray=new Array();
		var invdocarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var dtype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
			if(i==0){
				
				if(dtype=="TCN" || dtype=="CNO"){
					cnodocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid'));
				}
				else if(dtype=="INV" || dtype=="INS" || dtype=="INT"){
					document.getElementById("printdocno").value=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
					invdocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no'));
				}
			}
			else{
				
				if(dtype=="TCN" || dtype=="CNO"){
					cnodocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no')+"::"+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid'));
				}
				else if(dtype=="INV" || dtype=="INS" || dtype=="INT"){
					document.getElementById("printdocno").value+=","+$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
					invdocarray.push($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no'));
				}
			}
		}
		if(cnodocarray.length>1){
			$.messager.alert('Warning','Cannot select multiple CNO');
			return false;
		}
		if(cnodocarray.length>0){
			var url=document.URL;
			var docno="";
			var reurl=url.split("/com");
	    	var win= window.open(reurl[0]+"/com/finance/transactions/creditnote/printCreditNote?docno="+cnodocarray[0].split("::")[0]+"&branch="+cnodocarray[0].split("::")[1]+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
			win.focus();
		}
		if(invdocarray.length>0){
			var url=document.URL;
			var docno="";
			var reurl=url.split("/com");
	    	var win= window.open(reurl[0]+"/com/operations/commtransactions/invoice/printManualInvoice?allbranch=1&printdocno="+document.getElementById("printdocno").value+"&hidheader=1&chkdeletedinvprint=0&bankdocno=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
	    	win.focus();	
		}
		 
		
	}
	function funSendWhatsApp(){
	var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select valid invoice');
		return false;
	}
	var lines=[];
	lines.push('*Invoice Details*');
	lines.push('─────────────────');
	for(var i=0;i<selectedrows.length;i++){
		var r=selectedrows[i];
		var docno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'doc_no')  ||'';
		var vocno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'voc_no')  ||'';
		var acname =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'acname')  ||'';
		var amount =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'amount')  ||'';
		var dtype  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'dtype')   ||'';
		var fdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'fromdate')||'';
		var tdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'todate')  ||'';
		if(selectedrows.length>1) lines.push('*#'+(i+1)+'*');
		lines.push('Doc No : '+docno+(vocno?'  ('+vocno+')':''));
		lines.push('Client : '+acname);
		lines.push('Type   : '+dtype);
		lines.push('Amount : '+amount);
		if(fdate||tdate) lines.push('Period : '+fdate+' – '+tdate);
		if(i<selectedrows.length-1) lines.push('─────────────────');
	}
	var msg=lines.join('\n');
	window.open('https://wa.me/?text='+encodeURIComponent(msg),'_blank');
}

function funSendWhatsAppDirect(){
	var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
	if(selectedrows.length==0){
		$.messager.alert('Warning','Please select valid invoice');
		return false;
	}
	var lines=['*Invoice Details*','─────────────────'];
	for(var i=0;i<selectedrows.length;i++){
		var r=selectedrows[i];
		var docno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'doc_no')  ||'';
		var vocno  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'voc_no')  ||'';
		var acname =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'acname')  ||'';
		var amount =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'amount')  ||'';
		var dtype  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'dtype')   ||'';
		var fdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'fromdate')||'';
		var tdate  =$('#rentalInvoiceGrid').jqxGrid('getcellvalue',r,'todate')  ||'';
		if(selectedrows.length>1) lines.push('*#'+(i+1)+'*');
		lines.push('Doc No : '+docno+(vocno?'  ('+vocno+')':''));
		lines.push('Client : '+acname);
		lines.push('Type   : '+dtype);
		lines.push('Amount : '+amount);
		if(fdate||tdate) lines.push('Period : '+fdate+' – '+tdate);
		if(i<selectedrows.length-1) lines.push('─────────────────');
	}
	document.getElementById('waDirectMsg').value=lines.join('\n');
	document.getElementById('waDirectModal').classList.add('open');
	setTimeout(function(){ document.getElementById('waDirectPhone').focus(); },100);
}

function funWaDirectSend(){
	var phone=document.getElementById('waDirectPhone').value.trim();
	var msg=document.getElementById('waDirectMsg').value.trim();
	if(!phone){
		alert('Please enter a WhatsApp number with country code');
		return;
	}
	document.getElementById('waDirectModal').classList.remove('open');
	$("#overlay, #PleaseWait").show();
	$.post('sendWhatsAppDirect.jsp',{phone:phone,message:msg},function(data){
		$("#overlay, #PleaseWait").hide();
		try{ data=JSON.parse(data); }catch(e){ data={success:false,error:'Invalid response'}; }
		if(data && data.success){
			$.messager.alert('Message','WhatsApp message sent successfully');
		} else {
			$.messager.alert('Warning','Failed: '+(data.error||'Check API credentials in sendWhatsAppDirect.jsp'));
		}
	});
}

function funWaDirectCancel(){
	document.getElementById('waDirectModal').classList.remove('open');
}

function funDispatchData(){
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		document.getElementById("printdocno").value="";
		var docarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var trno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
			var dtype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
			var doc_no=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			var brhid=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			docarray.push(trno+"::"+dtype+"::"+doc_no+"::"+brhid);
		}
		$("#overlay, #PleaseWait").show();
		$.post('dispatchData.jsp',{'docarray':docarray.join(",")},function(data,status){
			$("#overlay, #PleaseWait").hide();
			if(parseInt(data)>0){
		 		$.messager.alert('Message','Record Successfully Dispatched','warning');   
		 	}
		 	else{
		 		$.messager.alert('Message','Not Dispatched','warning');
		 		return false;
		 	}
		 	funreload("");
		});
	}

function validateEmail(email){
	var res,part1,part2,dotsplt;
	
	if(email.indexOf("@")>=0) {
	    res = email.split('@');
	    part1=res[0];
	    part2=res[1];
	    dotsplt=part2.split('.');
    }
	else{
		return false;
	}
	
	if(email.trim()=="" || typeof(email.trim())=="undefined" || typeof(email.trim())=="NaN") {
		  console.log(1);
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
	  } else if(email.indexOf("@")<0) {
		  console.log(2);
		  $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
	  } else if(email.split('@').length!=2) {
		  console.log(3);
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
	  } else if(part1.length==0) {
		  console.log(4);
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
	  } else if(part1.split(" ").length>2) {
		  console.log(5);
		    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
  } else if(part2.split(".").length<2) {
  	console.log(6);
	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
  } else if(dotsplt[0].length==0 ) {
  	console.log(7);
	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
  } else if(dotsplt[1].length<2 ||dotsplt[1].length>4) {
  	console.log(8);
	    $.messager.alert('Message','Email is not Configured Properly.','warning');
			return false;
  }
	
	return true;
}
function funSendingEmail() {  
		var selectedrows=$('#rentalInvoiceGrid').jqxGrid('selectedrowindexes');
		var rows=$('#rentalInvoiceGrid').jqxGrid('getrows');
		var email="";
		var printdoc="";
		var vocno="";
		
	
		var docno="";
		
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid invoice');
			return false;
		}
		
		var doctype="";
		var emailinvalid="0";
		for(var i=0;i<selectedrows.length;i++){
			var emailstatus=validateEmail($('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'mail1'));
			if(emailstatus==false){
				emailinvalid="1";
				return false;
			}
		}
		
		if(emailinvalid=="1"){
			return false;
		}
		
		var docarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			/*email=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'mail1');
			printdoc=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			vocno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'voc_no');
			brhid=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
			doctype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');*/
			
			docno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'doc_no');
			var trno=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'tr_no');
			brhid=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
			doctype=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',selectedrows[i],'dtype');
			docarray.push(trno+"::"+brhid+"::"+doctype);
		}
		
    	var mailurl="";
    	
		var mailtype=$('input[name="chkmailtype"]:checked').val();
    	$("#overlay, #PleaseWait").show();
		    //console.log("printManualInvoiceJasper.action?fromno="+docno+"&tono="+docno+"&branch="+document.getElementById("cmbbranch").value+"&printdocno="+printdoc+"&email="+email+"&vocno="+vocno+"&brhid="+brhid+"&allbranch=1");
	 	$.ajaxFileUpload ({  
	 		url: "sendInvDispatchMail.action?docarray="+docarray.join(",")+"&mailtype="+mailtype,  
	    	secureuri:false,//false  
	    	fileElementId:'file', //id  <input type="file" id="file" name="file" />  
	    	dataType: 'string',// json  
	    	success: function (data, status) {
	    		console.log(data);
	    		console.log(status);
	    		if(status=='success'){
					$("#overlay, #PleaseWait").hide();
					$.messager.alert('Message','E-Mail Send Successfully');
					funreload("");
	    		}
	    	    if(status=='error'){
	    	    	$("#overlay, #PleaseWait").hide();
	    	        $.messager.alert('Message','E-Mail Sending failed');
	    	    }
			},  
	    	error: function (data, status, e)
	    	{  
	    		$("#overlay, #PleaseWait").hide();
	    		$.messager.alert('Message','E-Mail Sending failed');
	    		console.log(e);
	    	}  
	    }) 
	    return false;
	} 



</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Heading -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Filters -->
    <div class="sidebar-scroll-content">

        <!-- Date -->
        <div class="filter-card">
            <table class="dispatch-filter-table">
                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>
                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>
            </table>
        </div>

        <!-- Mail Settings -->
        <div class="filter-card">
            <div class="mail-type-group">
                <div class="mail-type-row">
                    <input type="radio" name="chkmailtype" id="chkclientwise" value="CRM" checked>
                    <label class="branch" for="chkclientwise">Client Wise</label>

                    <input type="radio" name="chkmailtype" id="chkagmtwise" value="AGMT">
                    <label class="branch" for="chkagmtwise">Agreement Wise</label>
                </div>

                <div class="mail-type-row">
                    <input type="radio" name="chkmailtype" id="chksaperate" value="SEP">
                    <label class="branch" for="chksaperate">Separate</label>
                </div>
            </div>
        </div>

        <!-- Filters -->
        <div class="filter-card">
            <table class="dispatch-filter-table">

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text"
                               id="txtclientname"
                               name="txtclientname"
                               readonly
                               placeholder="Press F3 to Search"
                               onkeydown="getClient(event);"
                               value='<s:property value="txtclientname"/>'>
                        <input type="hidden"
                               id="txtcldocno"
                               name="txtcldocno"
                               value='<s:property value="txtcldocno"/>'>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <textarea id="clienthtml"></textarea>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Category</td>
                    <td>
                        <select id="cmbcategory" name="cmbcategory">
                            <option value="">--Select--</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Inv Type</td>
                    <td>
                        <select id="cmbinvtype" name="cmbinvtype">
                            <option value="">--Select--</option>
                            <option value="rental">Rental</option>
                            <option value="lease">Lease</option>
                            <option value="traffic">Traffic</option>
                            <option value="salik">Salik</option>
                            <option value="damage">Damage</option>
                            <option value="extrasrvc">Extra Services</option>
                            <option value="extrakm">Extra KM</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Status</td>
                    <td>
                        <select id="clstatuss" name="clstatuss">
                            <option value="">--Select--</option>
                            <option value="0">Open</option>
                            <option value="1">Close</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agmt Type</td>
                    <td>
                        <select id="rentaltype"
                                name="rentaltype"
                                onchange="clearagno();">
                            <option value="">--Select--</option>
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agreement</td>
                    <td>
                        <input type="text"
                               id="agmtvocno"
                               name="agmtvocno"
                               readonly
                               placeholder="Press F3 to Search"
                               onkeydown="getAgreement(event);"
                               value='<s:property value="agmtvocno"/>'>
                    </td>
                </tr>

            </table>

            <!-- Actions -->
            <div class="dispatch-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funClearData();">
                    Clear
                </button>

                <button type="button"
                        class="btn-submit"
                        onclick="funPrintData();">
                    Print
                </button>

                <button type="button"
                        class="btn-whatsapp"
                        onclick="funSendWhatsApp();">
                    &#128904; WhatsApp
                </button>

                <button type="button"
                        class="btn-wa-direct"
                        onclick="funSendWhatsAppDirect();">
                    &#128222; WhatsApp Direct
                </button>

                <button type="button"
                        class="btn-submit"
                        onclick="funDispatchData();">
                    Dispatch
                </button>
            </div>
        </div>

        <!-- Hidden -->
        <input type="hidden" id="printdocno" name="printdocno">
        <input type="hidden"
               id="txtagreementno"
               name="txtagreementno"
               value='<s:property value="txtagreementno"/>'>

    </div>
</div>
</div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <div id="notInvoicedDiv">
        <jsp:include page="rentalInvoiceGrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>

<!-- POPUPS -->
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="agreementDetailsWindow"><div></div><div></div></div>

<!-- WhatsApp Direct Modal -->
<div id="waDirectModal">
    <div class="wa-modal-box">
        <div class="wa-modal-title">&#128904; Send via WhatsApp</div>
        <input type="text" id="waDirectPhone"
               placeholder="e.g. 971501234567 (country code, no +)"
               onkeydown="if(event.keyCode==13)funWaDirectSend();">
        <div class="wa-modal-hint">Country code + number, no spaces or + symbol&nbsp;&nbsp;(UAE: 971xxxxxxxxx)</div>
        <textarea id="waDirectMsg" class="wa-modal-preview"></textarea>
        <div class="wa-modal-actions">
            <button class="wa-cancel-btn" onclick="funWaDirectCancel();">Cancel</button>
            <button class="wa-send-btn"   onclick="funWaDirectSend();">Send</button>
        </div>
    </div>
</div>

</div>
</body>
</html>