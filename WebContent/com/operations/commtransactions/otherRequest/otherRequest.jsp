<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   SCOPED UI: Stable Modern Layout (Table-Based Alignment)
========================================================= */
body {
    background: #ffffff; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 15px; 
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 8px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    border: 1px solid #e5e7eb; 
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 0;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Stable 24px */
.modern-ui input[type="text"],
.modern-ui input[type="email"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui input[type="email"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Restored Table Alignment for Perfect Input Sizing */
.modern-ui table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 6px 8px;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 18px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 20px;
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -10px; 
    left: 10px; 
    background: #ffffff; 
    padding: 0 6px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 13px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
    display: flex;
    align-items: center;
}

/* Search Icon Wrapper */
.modern-ui .input-search-container {
    position: relative;
    display: block;
    width: 100%;
}
.modern-ui .input-search-container input {
    padding-right: 25px !important;
}
.modern-ui .magnifier-icon {
    position: absolute;
    right: 4px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
.modern-ui .magnifier-icon:hover { color: #2563eb; }

/* Custom UI Buttons */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 12px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

.icon-btn {
    background: #f4f6f9;
    border: 1px solid #c5d3e0;
    border-radius: 3px;
    padding: 2px;
    cursor: pointer;
    height: 24px;
    width: 28px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}
.icon-btn:hover { background: #e0ecf8; }
.icon-btn img { height: 16px; }

form label.error { color: red; font-weight: bold; font-size: 11px; }
#errormsg { color: red; font-weight: bold; font-size: 12px; margin-bottom: 5px; display: block; height:15px;}

.hidden-scrollbar {
    overflow-y: auto;
    max-height: calc(100vh - 100px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );
		 
		 /* STRICT 24px DATE INPUTS */
		 $("#jqxOtherRequestDate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy" });
		 $("#maindate").jqxDateTimeInput({ width: '100%', height: 24, formatString:"dd.MM.yyyy" });
		 
         /* Force exactly 24px styling onto JQX elements */
         setTimeout(function () {
             $(".jqx-datetimeinput").css({
                 "border": "1px solid #b8c6d8", "border-radius": "3px", "height": "24px", "box-sizing": "border-box"
             });
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "22px", "height": "22px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box",
                 "border": "none", "background": "transparent"
             });
             $(".jqx-datetimeinput").find(".jqx-action-button").css({
                 "top": "0px", "height": "22px", "border": "none", "background-color": "transparent"
             });
         }, 0);
		 
		 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#clientDetailsWindow').jqxWindow('close');
		 
		 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#agreementDetailsWindow').jqxWindow('close');
		 
		 $('#driverDetailsWindow').jqxWindow({width: '55%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Driver Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#driverDetailsWindow').jqxWindow('close');
		 
		 $('#nationalityWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#nationalityWindow').jqxWindow('close');
		 
    	 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#stateWindow').jqxWindow('close');
		 
		 $('#serviceWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Extra Service Request Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#serviceWindow').jqxWindow('close');
		 
	});
	
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
	
	function driverSearchContent(url) {
	 	$('#driverDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#driverDetailsWindow').jqxWindow('setContent', data);
		$('#driverDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function nationalitySearchContent(url) {
	 	$('#nationalityWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#nationalityWindow').jqxWindow('setContent', data);
		$('#nationalityWindow').jqxWindow('bringToFront');
	}); 
	}
  
  function stateSearchContent(url) {
	 	$('#stateWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#stateWindow').jqxWindow('setContent', data);
		$('#stateWindow').jqxWindow('bringToFront');
	}); 
	}
  
  function serviceSearchContent(url) {
	 	$('#serviceWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#serviceWindow').jqxWindow('setContent', data);
		$('#serviceWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
        var x= event.keyCode;
        if(x==114){
        	var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate');
			$("#maindate").jqxDateTimeInput('val', date);
			clientSearchContent("<%=contextPath%>/com/operations/clientAccountDetailsSearch.jsp?atype=AR&date="+date);
			$('#txtforsearch').val(2);
        }
       }
	
	function getAgreement(event){
        var x= event.keyCode;
        if(x==114){
        	agreementSearchContent('agreementSearch.jsp');
        }
       }
	
	function funReadOnly(){
		$('#frmOtherRequest input').attr('readonly', true );
		$('#frmOtherRequest select').attr('disabled', true);
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: true});
		$("#btnAdditionalDriverSearch").prop("disabled", true);
		$("#btnAdditionalDriverAdd").prop("disabled", true);
		$("#jqxOtherRequest").jqxGrid({ disabled: true});
		$("#jqxDriver").jqxGrid({ disabled: true});
  }
	
 function funRemoveReadOnly(){
		$('#frmOtherRequest input').attr('readonly', false);
		$('#frmOtherRequest select').attr('disabled', false);
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: false});
		$("#btnAdditionalDriverSearch").prop("disabled", true);
		$("#btnAdditionalDriverAdd").prop("disabled", true);
		$("#jqxOtherRequest").jqxGrid({ disabled: false});
		$("#jqxDriver").jqxGrid({ disabled: true});
		$('#docno').attr('readonly', true);
		$('#txtamount').attr('readonly', true);
		$('#txtdescription').attr('readonly', true);
		$('#txtclientname').attr('readonly', true);
		$('#txtravocher').attr('readonly', true);
		
		if ($("#mode").val() == "A") {
			$('#jqxOtherRequestDate').val(new Date());
			$("#jqxOtherRequest").jqxGrid('clear');
			$("#jqxOtherRequest").jqxGrid('addrow', null, {});
			$("#jqxDriver").jqxGrid('clear');
		}
 }
 
 function funSearchLoad(){
     changeContent('oreMainSearch.jsp');  
 }
	
 function funChkButton() {}
 
 function funFocus(){
    	$('#jqxOtherRequestDate').jqxDateTimeInput('focus'); 	    		
    }
 
 /* Validations */
     $(function(){
        $('#frmOtherRequest').validate({
        	    rules: {
                cmbratype:"required",
                txtamount:{number:true},
                txtdescription:{maxlength:400},
                txtremarks:{maxlength:400}
                 },
                 messages: {
                 cmbratype:" *",
                 txtamount:{number:"Invalid"},
                 txtdescription: {maxlength:"    Max 400 chars"},
                 txtremarks: {maxlength:"    Max 400 chars"}
                 }
        });}); 
   
  function funNotify(){	 
	  
	  if($('#txtrano').val()==""){
		  document.getElementById("errormsg").innerText="Choose an Agreement.";
		  return 0;
	  }
	  
	  /* Other Request Grid  Saving*/
		 var rows = $("#jqxOtherRequest").jqxGrid('getrows');
		 var length=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].amount;
				var chks=rows[i].typeid;
				if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
				  if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+length)
				    .attr("name", "test"+length)
					.attr("hidden", "true");
					length=length+1;
					
		    newTextBox.val(rows[i].type+"::"+rows[i].remarks+"::"+rows[i].amount+"::"+rows[i].typeid);
			newTextBox.appendTo('form');
			  }
			 }
			}
		 $('#gridlength').val(length);
		 
		 var rows = $("#jqxDriver").jqxGrid('getrows');
		 var length1=0;
			 for(var i=0 ; i < rows.length ; i++){
				var chk=rows[i].name;
				if(typeof(chk) != "undefined"){
					length1=length1+1;
					newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "tested"+i)
				    .attr("name", "tested"+i)
				    .attr("hidden", "true");
			
			newTextBox.val(rows[i].name+" :: "+rows[i].hiddob+":: "+rows[i].nation1+":: "+rows[i].mobno+":: "+rows[i].passport_no+":: "+rows[i].hidpassexp+":: "+rows[i].dlno+":: "+rows[i].hidissdate+":: "+rows[i].issfrm+":: "+rows[i].hidled+":: "+rows[i].ltype+":: "+rows[i].visano+":: "+rows[i].hidvisaexp+"::"+rows[i].dr_id);
			newTextBox.appendTo('form');
			 }
			}
		 $('#drivergridlength').val(length1);
	   /* Other Request Grid  Saving Ends*/
	   
	   
	   if($('#gridlength').val()==0 && $("#adddriverintickval").val()==0){
			  document.getElementById("errormsg").innerText="Choose an Service Type or Additional Driver.";
			  return 0;
		  }
	   
	   if($('#gridlength').val()==0 && $("#adddriverintickval").val()==1){
		   if($('#drivergridlength').val()==0){
			  document.getElementById("errormsg").innerText="Enter Atleast One Additional Driver.";
			  return 0;
		   }
	  }
	   
	   if($('#drivergridlength').val()==0 && $("#adddriverintickval").val()==1){
				  document.getElementById("errormsg").innerText="Enter Atleast One Additional Driver.";
				  return 0;
		  }
	   
		$('#jqxOtherRequestDate').jqxDateTimeInput({disabled: false});
    	return 1;
	} 
  
  function setValues(){
	  
	  document.getElementById("cmbratype").value=document.getElementById("hidcmbratype").value;
	  
	  if($('#hidjqxOtherRequestDate').val()){
			 $("#jqxOtherRequestDate").jqxDateTimeInput('val', $('#hidjqxOtherRequestDate').val());
		  }

	  if(document.getElementById("adddriverintickval").value==1){
			 document.getElementById("chkadddriver").checked = true;
		 }
		 else if(document.getElementById("adddriverintickval").value==0){
			document.getElementById("chkadddriver").checked = false;
		 }
	  
	   if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	   
	   document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	   funSetlabel();
	   
	   var indexVal = document.getElementById("docno").value;
	   var indexVal1 = document.getElementById("txtclientdocno").value;
	   if(indexVal>0){
      		$("#otherRequestGridDiv").load("otherRequestGrid.jsp?txtotherrequestdocno2="+indexVal);
      		$("#DriverDiv").load("driver.jsp?docNo="+indexVal+"&clientId="+indexVal1);
	   }
	}
  
  function funPrintBtn() {
	    if (($("#mode").val() == "view") && $("#docno").val() != "") {
	        
	        var url = document.URL;
	        var reurl = url.split("saveOtherRequest");
	        
	        $("#docno").prop("disabled", false);  
	     
	        var printUrl = reurl[0] + "printExtraServiceRequest?docno=" + document.getElementById("docno").value + 
	                       "&branch=" + document.getElementById("brchName").value;

	        var win = window.open(printUrl, "_blank", "top=150,left=250,Width=1020,Height=600,location=no,scrollbars=yes,toolbar=yes");

	        if (win) {
	            var checkReady = setInterval(function() {
	                try {
	                    
	                    if (win.document && win.document.readyState === 'complete' && win.document.body.innerHTML.length > 500) {
	                        clearInterval(checkReady);
	                        
	                        setTimeout(function() {
	                            win.focus();
	                            win.print();
	                            
	                            win.onafterprint = function () {
	                                win.close();
	                            };
	                        }, 1000); 
	                    }
	                } catch (e) {
	                    clearInterval(checkReady);
	                }
	            }, 500);
	        } else {
	            $.messager.alert('Message', 'Popup blocked by browser. Please allow popups for this site.', 'warning');
	        }
	        
	    } else {
	        $.messager.alert('Message', 'Select a Document....!', 'warning');
	        return;
	    }
	}
  
  function checkAdditionalDriver(){
  	if(document.getElementById("chkadddriver").checked==true){
  		$('#txtamount').attr('readonly', false);
  		$('#txtdescription').attr('readonly', false);
  		$("#btnAdditionalDriverSearch").prop("disabled", false);
  		$("#btnAdditionalDriverAdd").prop("disabled", false);
  		$("#jqxDriver").jqxGrid({ disabled: true});
  		document.getElementById("adddriverintickval").value=1;	
  		}
  	else{
  		 $("#btnAdditionalDriverSearch").prop("disabled", true);
  		 $("#btnAdditionalDriverAdd").prop("disabled", true);
  		 $('#txtamount').attr('readonly', true);
  		 $('#txtdescription').attr('readonly', true);
  		 $("#jqxDriver").jqxGrid({ disabled: true});
  		 document.getElementById("adddriverintickval").value=0;	
  		}
  	}
  
  function funAdditionalDriverSearch(){
	  var indexVal = document.getElementById("adddriverintickval").value;
	  var indexVal1 = document.getElementById("txtclientdocno").value;
	  var indexVal2 = document.getElementById("cmbratype").value;
	  var indexVal3 = document.getElementById("txtrano").value;
		 
	     if(indexVal1==''){
			 $.messager.alert('Message','Client is Mandatory.','warning');
			 return 0;
		 }
	  
		if(indexVal2==''){
			 $.messager.alert('Message','Please Choose RA Type.','warning');
			 return 0;
		 }
		 
		 if(indexVal3==''){
			 $.messager.alert('Message','Agreement No. is Mandatory.','warning');
			 return 0;
		 }
		 
	   if(indexVal==1){
		   if(indexVal1>0 && indexVal3!=""){
			   driverSearchContent("clientDriverSearch.jsp?clientId="+indexVal1+"&raType="+indexVal2+"&raNo="+indexVal3);
		   }
	   }  
  }
  
  function funAdditionalDriverAdd(){
	  var rows = $('#jqxDriver').jqxGrid('getrows');
  	  var rowlength= rows.length;
  	  var rowindex1 = rowlength - 1;
	  var driverId=$("#jqxDriver").jqxGrid('getcellvalue', rowindex1, "dr_id");
	  if(typeof(driverId) != "undefined"){
	  	$("#jqxDriver").jqxGrid({ disabled: false});
	  	$("#jqxDriver").jqxGrid('addrow', null, {});
	  }
  }
  
  function datechange(){
	  var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate');
	  var validdate=funDateInPeriod(date);
		 if(parseInt(validdate)==0){
			document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
			return 0;	
		 }
	  $("#maindate").jqxDateTimeInput('val', date);
  }
  
  function clearAgreement(){
	    document.getElementById("txtravocher").value="";
		document.getElementById("txtrano").value="";
		 if (document.getElementById("txtravocher").value == "") {
		        $('#txtravocher').attr('placeholder', 'Press F3 to Search'); 
		    }
   }
			
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmOtherRequest" action="saveOtherRequest" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class='modern-ui hidden-scrollbar'>
<span id="errormsg"></span>

<div class="middle-panel">
    <span class="middle-panel-title">Request Info</span>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="lbl-right" width="8%">Date</td>
            <td width="15%">
                <div id="jqxOtherRequestDate" name="jqxOtherRequestDate" onchange="datechange();" value='<s:property value="jqxOtherRequestDate"/>'></div>
                <input type="hidden" id="hidjqxOtherRequestDate" name="hidjqxOtherRequestDate" value='<s:property value="hidjqxOtherRequestDate"/>'/>
            </td>
            
            <td class="lbl-right" width="8%">Ref. No.</td>
            <td width="20%">
                <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>
            </td>
            
            <td class="lbl-right" width="8%">Doc No.</td>
            <td width="20%">
                <input type="text" id="docno" name="txtotherrequestdocno" value='<s:property value="txtotherrequestdocno"/>' tabindex="-1" readonly/>
            </td>
        </tr>
        <tr>
            <td class="lbl-right">Client</td>
            <td>
                <div class="input-search-container">
                    <input type="text" id="txtclientname" name="txtclientname" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);" placeholder="Press F3"/>
                    <svg class="magnifier-icon" onclick="var date = $('#jqxOtherRequestDate').jqxDateTimeInput('getDate'); $('#maindate').jqxDateTimeInput('val', date); clientSearchContent('<%=contextPath%>/com/operations/clientAccountDetailsSearch.jsp?atype=AR&date='+date); $('#txtforsearch').val(2);" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="hidden" id="txtclientdocno" name="txtclientdocno" value='<s:property value="txtclientdocno"/>'/>
            </td>
            
            <td class="lbl-right">RA Type</td>
            <td>
                <select id="cmbratype" name="cmbratype" onchange="clearAgreement();" value='<s:property value="cmbratype"/>'>
                    <option value="RAG">Rental</option>
                    <option value="LAG">Lease</option>
                </select>
                <input type="hidden" id="hidcmbratype" name="hidcmbratype" value='<s:property value="hidcmbratype"/>'/>
            </td>
            
            <td class="lbl-right">RA No.</td>
            <td>
                <div class="input-search-container">
                    <input type="text" id="txtravocher" name="txtravocher" value='<s:property value="txtravocher"/>' onkeydown="getAgreement(event);" placeholder="Press F3"/>
                    <svg class="magnifier-icon" onclick="agreementSearchContent('agreementSearch.jsp?clientId='+$('#txtclientdocno').val());" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                <input type="hidden" id="txtrano" name="txtrano" value='<s:property value="txtrano"/>'/>
            </td>
        </tr>
        <tr>
            <td class="lbl-right">Remarks</td>
            <td colspan="5">
                <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
            </td>
        </tr>
    </table>
</div>

<div id="otherRequestGridDiv"><jsp:include page="otherRequestGrid.jsp"></jsp:include></div>

<div class="middle-panel" style="margin-top: 20px;">
    <span class="middle-panel-title" style="padding:0 5px; display:flex; align-items:center; gap:5px;">
        <input type="checkbox" id="chkadddriver" name="chkadddriver" onchange="checkAdditionalDriver();" style="margin:0;">
        <span>Additional Driver</span>
    </span>
    <input type="hidden" id="adddriverintickval" name="adddriverintickval" value='<s:property value="adddriverintickval"/>'>

    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-bottom:10px;">
        <tr>
            <td width="10%" align="center">
                <button type="button" class="icon-btn" id="btnAdditionalDriverSearch" title="Search Additional Driver" onclick="funAdditionalDriverSearch();" style="margin-right:5px;">
                    <img alt="Search Additional Driver" src="<%=contextPath%>/icons/driverSearch.png">
                </button>
                <button type="button" class="icon-btn" id="btnAdditionalDriverAdd" title="Add Additional Driver" onclick="funAdditionalDriverAdd();">
                    <img alt="Add Additional Driver" src="<%=contextPath%>/icons/driverAdd.png">
                </button>
            </td>
            
            <td class="lbl-right" width="8%">Amount</td>
            <td width="15%">
                <input type="text" id="txtamount" name="txtamount" style="text-align: right;" value='<s:property value="txtamount"/>' onblur="funRoundAmt(this.value,this.id);" />
            </td>
            
            <td class="lbl-right" width="10%">Description</td>
            <td width="57%">
                <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
            </td>
        </tr>
    </table>

    <div id="DriverDiv"><jsp:include page="driver.jsp"></jsp:include></div>
</div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
<input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="drivergridlength" name="drivergridlength"/>
</div>
</form>

<div id="clientDetailsWindow"><div></div><div></div></div> 
<div id="agreementDetailsWindow"><div></div><div></div></div>
<div id="driverDetailsWindow"><div></div><div></div></div>
<div id="nationalityWindow"><div></div></div>
<div id="stateWindow"><div></div></div>
<div id="serviceWindow"><div></div></div>

</div>
</body>
</html>