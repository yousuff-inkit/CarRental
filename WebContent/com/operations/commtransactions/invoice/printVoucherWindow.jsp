<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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

<style>
/* =========================================================
SCOPED UI: Compact Print Modal Layout
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: Arial, sans-serif;
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
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
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
}

/* Panel Styling */
.modern-ui .search-panel {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px;
    margin-bottom: 10px;
}

.modern-ui td {
    padding: 6px 5px;
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

/* Radio & Checkbox Styling */
.modern-ui .radio-group {
    display: flex;
    align-items: center;
    gap: 15px;
    font-weight: bold;
    color: #444;
}

.modern-ui .radio-group input {
    margin: 0 5px 0 0;
    cursor: pointer;
}

.modern-ui .radio-group label {
    cursor: pointer;
}

/* Modern Button */
.modern-ui .myButton {
    height: 26px;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
    transition: all 0.2s;
    text-transform: uppercase;
}

.modern-ui .myButton:hover {
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    transform: translateY(-1px);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
    margin-top: 10px;
}
</style>

<script type="text/javascript">
$(document).ready(function(){
	getPrintTrafficConfig();
	funbnkdetls();
	
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:50%;left:50%;'><img src='../../../../icons/31load.gif'/></div>");    

    /* COMPACT DATE/TIME SIZING (120px width, 24px height) */
	$("#printfromdate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
    $("#printtodate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy", value:null});
    
    /* Force internal alignment AFTER render */
    setTimeout(function () {
        $(".jqx-datetimeinput").find("input").css({
            "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
            "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
        });
        $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
    }, 0);

    $("#rdbncmprhnshow").hide();
	$("#rdbncmprhnhide").hide();
	$("#lblwithouttotal").hide();
	$("#lblwithtotal").hide();
    
});

function isNumber(evt,id) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)) {
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
    	$('.multiprint').hide();
    	document.getElementById("btnPrintSearch").style.display="none";
    }
    if(document.getElementById("rdomultiple").checked==true){
    	document.getElementById("tono").disabled=false;
    	document.getElementById("printgriddiv").style.display="block";
    	$('.multiprint').show();
    	document.getElementById("btnPrintSearch").style.display="block";
    }
    
    var voc='<%=request.getParameter("voc")%>';
    if(voc!="" && voc!="null"){
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

function funbnkdetls() {
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200) {
	       var items= x.responseText.trim();
	       if(parseInt(items)>0){
	    	   document.getElementById("hidbnk").value="1";
	       } else{
				 document.getElementById("hidbnk").value="0";
			}
	       if(document.getElementById("hidbnk").value=="1") {
	    		$("#cmbprintbankname").show();
	    		getbankname();
	    		$('.bankrow').show();
	    	} else {
	    		$("#cmbprintbankname").hide();
	    		$('.bankrow').hide();
	    	}
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
	} else{
		header=0;
	}
	var chkdeletedinvprint=0;
	 if(document.getElementById("chkdeletedinvprint").checked==true){
	 	chkdeletedinvprint=1;
	 } else{
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
	} else {
		trafic=0;
	}
	
	var url=document.URL;
	var reurl=url.split("printVoucherWindow.jsp");
	var branch='<%=request.getParameter("branch")%>'; 
	var cmprhnstat=$("#cmprhnstat").val();
	var partsconfig=$("#partsconfig").val();
	var bankdocno=$('#cmbprintbankname').val();
	
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
			
			if($('#partsconfig').val().trim()=='1'){
				 $("#rdbncmprhnshow").show();
				 $("#rdbncmprhnhide").show();
				 $("#lblwithtotal").show();
				 $("#lblwithouttotal").show();
			}
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
	 } else{
	 	chkdeletedinvprint=0;
	 }
	 
	var branch='<%=request.getParameter("branch")%>';
	if(agmttype=="" && agmtno!=""){
		$.messager.alert('Warning','Please Select Agmt Type');
		return false;
	}
	if(typeof cmprhnstat !== 'undefined' && cmprhnstat==""){
		$.messager.alert('Message','Select a Comprehensive Option...','warning');
		return false;
	}
	
	$("#overlay, #PleaseWait").show();
	$("#printgriddiv").load("printGrid.jsp?fromdate="+$("#printfromdate").jqxDateTimeInput("getText")+"&todate="+$('#printtodate').jqxDateTimeInput('getText')+"&agmtno="+agmtno+"&agmttype="+agmttype+"&client="+client+"&branch="+branch+"&fromno="+fromno+"&tono="+tono+"&mode=1&chkdeletedinvprint="+chkdeletedinvprint);
}
</script>
</head>

<body onload="changeRdo();getPrintTrafficConfig();">

<div class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            
            <tr>
                <td colspan="6">
                    <div class="radio-group" style="margin-bottom: 10px;">
                        <div>
                            <input type="radio" name="rdoprint" id="rdosingle" checked onchange="changeRdo();">
                            <label for="rdosingle">Single</label>
                        </div>
                        <div>
                            <input type="radio" name="rdoprint" id="rdomultiple" onchange="changeRdo();">
                            <label for="rdomultiple">Multiple</label>
                        </div>
                    </div>
                </td>
            </tr>
            
            <tr>
                <td colspan="6">
                    <div class="radio-group" style="margin-bottom: 10px;">
                        <div>
                            <input type="checkbox" name="chkheader" id="chkheader">
                            <label for="chkheader">Header</label>
                        </div>
                        <div>
                            <input type="checkbox" name="chkdeletedinvprint" id="chkdeletedinvprint">
                            <label for="chkdeletedinvprint">Deleted Invoices</label>
                        </div>
                    </div>
                </td>
            </tr>
            
            <tr>
                <td colspan="6">
                    <div class="radio-group" style="margin-bottom: 15px;">
                        <div>
                            <input type="radio" id="rdbncmprhnshow" name="rdbncmprhn" onchange="funcmprhncheck();" value="With Traffic fine" checked="checked">
                            <label id="lblwithtotal" for="rdbncmprhnshow">With Traffic fine</label>
                        </div>
                        <div>
                            <input type="radio" id="rdbncmprhnhide" name="rdbncmprhn" onchange="funcmprhncheck();" value="Separate traffic fine">
                            <label id="lblwithouttotal" for="rdbncmprhnhide">Separate Traffic fine</label>
                            <input type="hidden" id="cmprhnstat" name="cmprhnstat" value="1" />
                        </div>
                    </div>
                </td>
            </tr>

            <tr class="bankrow" style="display:none;">
                <td class="lbl-right" width="12%">Bank</td>
                <td width="20%">
                    <select id="cmbprintbankname" name="cmbprintbankname" value='<s:property value="cmbprintbankname"/>'>
                        <option value="">--Select--</option>
                    </select>
                </td>
                <td colspan="4"></td>
            </tr>

            <tr>
                <td class="lbl-right" width="12%">Doc No From</td>
                <td width="20%">
                    <input type="text" name="fromno" id="fromno" onkeypress="javascript:return isNumber(event, this.id)">
                </td>
                <td class="lbl-right" width="12%">Doc No To</td>
                <td width="20%">
                    <input type="text" name="tono" id="tono" onkeypress="javascript:return isNumber(event, this.id)">
                </td>
                <td width="36%" colspan="2">
                    <button type="button" name="btnGetPrint" id="btnGetPrint" class="myButton" onclick="funGetPrint()" style="margin-left: 10px;">Print</button>
                </td>
            </tr>
            
            <tr class="multiprint" style="display:none;">
                <td class="lbl-right" style="padding-top: 15px;">From Date</td>
                <td style="padding-top: 15px;">
                    <div id="printfromdate"></div>
                </td>
                <td class="lbl-right" style="padding-top: 15px;">To Date</td>
                <td style="padding-top: 15px;">
                    <div id="printtodate"></div>
                </td>
                <td class="lbl-right" style="padding-top: 15px;" width="12%">Agmt Type</td>
                <td style="padding-top: 15px;" width="24%">
                    <select name="cmbprintagmttype" id="cmbprintagmttype">
                        <option value="">--Select--</option>
                        <option value="RAG">Rental</option>
                        <option value="LAG">Lease</option>
                    </select>
                </td>
            </tr>
            
            <tr class="multiprint" style="display:none;">
                <td class="lbl-right">Client</td>
                <td>
                    <input type="text" name="printclient" id="printclient">
                </td>
                <td class="lbl-right">Agmt No</td>
                <td>
                    <input type="text" name="printagmtno" id="printagmtno">
                </td>
                <td colspan="2">
                    <button type="button" name="btnPrintSearch" id="btnPrintSearch" class="myButton" onclick="funPrintGridLoad();" style="margin-left: 10px;">Search</button>
                </td>
            </tr>

        </table>
    </div>

    <input type="hidden" name="printdocno" id="printdocno">
    <input type="hidden" name="partsconfig" id="partsconfig">
    <input type="hidden" name="hidbnk" id="hidbnk">

    <div id="printgriddiv" class="grid-container" style="display:none;">
        <jsp:include page="printGrid.jsp"/>
    </div>

</div>

</body>
</html>