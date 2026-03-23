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

<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#overlay, #PleaseWait").hide();
	$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	document.getElementById("chksaperate").checked=true;
	setSaperate();
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 $('#fromdate').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#fromdate').jqxDateTimeInput('focus');
						return false;
					}
				});
	 $('#todate').on('change', function (event) 
				{  
					var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#todate').jqxDateTimeInput('focus');
						return false;
					}
				});
/* 	 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); */
     
	  if(document.getElementById("mode").value==""){

	         var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
	         var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
	         $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
	     }
     
	  $('#agmtvocno').dblclick(function(){
		  if($('#rentaltype').val()==""){
	   	         $.messager.alert('Message','Choose a Type.','warning');   
	   	         return false;
	   	        }
		  var branchval = document.getElementById("cmbbranch").value; 
		  agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
		});
	  
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
	  });
});

	function funExportBtn(){
	 
	 
	 if(parseInt(window.parent.chkexportdata.value)=="1")
	  {
	  	JSONToCSVCon(data1, 'Traffic-Fine-ToBeInvoiced', true);
	  }
	 else
	  {
	                 
		 $("#jqxNotInvoiced").jqxGrid('exportdata', 'xls', 'Traffic-Fine-ToBeInvoiced');
	  }
	 
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
	    	if($('#rentaltype').val()==""){
	   	         $.messager.alert('Message','Choose a Type.','warning');   
	   	         return false;
	   	        }
	    	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
	    }
	    else{}
	    }

	function  funClearData(){
		 $('#txtclientname,#ticketno').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		/* 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-12));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     */
         var curfromdate=$('#fromdate').jqxDateTimeInput('getDate');
         var onemonthbackdate=new Date(curfromdate.setMonth(curfromdate.getMonth()-1));
         $('#fromdate').jqxDateTimeInput('setDate', onemonthbackdate); 
		     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("txtagreementno").value == "") {
		        $('#txtagreementno').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funTrafficToBeInvoicedPrint(){
        var url=document.URL;
        var reurl=url.split("com");
        var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
        var win= window.open(reurl[0]+"com/dashboard/trafficfine/notinvoiced/printTrafficToBeInvoiced?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+$('#fromdate').jqxDateTimeInput('val')+'&toDate='+$("#todate").val()+'&agmtno='+agmtno+'&rentaltype='+rentaltype+'&cldocno='+cldocno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
   }
	
	function funreload(event){
		if(document.getElementById("cmbbranch").value=='a' || document.getElementById("cmbbranch").value==""){
			$.messager.alert('Message',"Please Select Single Branch");
			return false;
		}
		var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(docdateval1==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return false;
		}
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
		 var agmtno = $('#txtagreementno').val();
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load('notInvoicedGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno);
	}
	function funGenerate(){
		if(document.getElementById("cmbbranch").value=='a' || document.getElementById("cmbbranch").value==""){
			$.messager.alert('Message',"Please Select Single Branch");
			return false;
		}
		var docdateval1=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(docdateval1==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return false;
		}
		var docdateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#todate').jqxDateTimeInput('focus');
			return false;
		}
		var rows=$('#jqxNotInvoiced').jqxGrid('getselectedrowindexes');
		if(rows.length==0){
			$.messager.alert('Message','Not Valid Data','warning');
			return false;
		}
		
		else{
			 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
		 			if (r){
		 				var selectedtickets="";
		 				for(var i=0;i<rows.length;i++){
		 					if(i==0){
		 						selectedtickets+=$('#jqxNotInvoiced').jqxGrid('getcellvalue',rows[i],'ticket_no');
		 					}
		 					else{
		 						selectedtickets+=","+$('#jqxNotInvoiced').jqxGrid('getcellvalue',rows[i],'ticket_no');
		 					}
		 				}
		 				document.getElementById("ticketno").value=selectedtickets;
		 				document.getElementById("mode").value="A";
		 				$("#overlay, #PleaseWait").show();
		 				document.getElementById("frmNotInvoicedTraffic").submit();
		 				funClearData();
		 			}
			 });
		}
	}
	
	function setValues(){
		 if($('#msg').val()!=""){
	   		   $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
	}
	function setSaperate(){
		if(document.getElementById("chksaperate").checked==true){
			document.getElementById("hidchksaperate").value="1";
		}
		else{
			document.getElementById("hidchksaperate").value="0";
		}
	}
</script>

</head>
<style type="text/css">
  
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    font-weight: 600;
    cursor: pointer;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
</style>
<body onload="getBranch();setValues();">
<form id="frmNotInvoicedTraffic" action="saveNotInvoicedTrafficSaperate" method="post">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="padding: 10px 0;">
                            <input type="checkbox" name="chksaperate" id="chksaperate" onchange="setSaperate();">
                            <label class="branch" for="chksaperate">Separate Invoice</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text" id="txtclientname" name="txtclientname" readonly placeholder="Press F3 to Search" onkeydown="getClient(event);" value='<s:property value="txtclientname"/>'/>
                            <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="">--Select--</option>
                                <option value="RAG">Rental</option>
                                <option value="LAG">Lease</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Agreement</td>
                        <td>
                            <input type="text" id="agmtvocno" name="agmtvocno" readonly placeholder="Press F3 to Search" onkeydown="getAgreement(event);" value='<s:property value="agmtvocno"/>'/>
                        </td>
                    </tr>
                </table>
            </div>
<div class="filter-card">

    <input type="button"
           name="btnGenerate"
           id="btnGenerate"
           value="Generate"
           class="myButton"
           onclick="funGenerate();"
           style="width:100%; margin-bottom:6px;">

    <input type="button"
           name="clear"
           id="clear"
           value="Clear"
           class="myButton"
           onclick="funClearData();"
           style="width:100%; margin-bottom:6px;">

    <button class="myButton"
            type="button"
            id="btnTrafficToBeInvoicedPrint"
            name="btnTrafficToBeInvoicedPrint"
            onclick="funTrafficToBeInvoicedPrint();"
            style="width:100%;">
        Print
    </button>

</div>
            <div style="height: 150px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="notInvoicedDiv">
                <jsp:include page="notInvoicedGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>

<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
<div id="agreementDetailsWindow">
	<div></div><div></div>
</div>
</div> 
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' />
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>' />
<input type="hidden" id="txtagreementno" name="txtagreementno" style="width:100%;height:20px;" readonly placeholder="Press F3 to Search"  onkeydown="getAgreement(event);" value='<s:property value="txtagreementno"/>'/>
<input type="hidden" id="ticketno" name="ticketno" value='<s:property value="ticketno"/>'/>
<input type="hidden" id="hidchksaperate" name="hidchksaperate" value='<s:property value="hidchksaperate"/>'/>
</form>
</body>
</html>