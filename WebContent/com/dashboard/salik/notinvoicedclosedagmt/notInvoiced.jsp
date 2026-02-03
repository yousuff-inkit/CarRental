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
<style>
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

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    $("#overlay, #PleaseWait").hide();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:new Date()});
	
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
	 	$("#btnExcel").click(function() {
		
 		 if(parseInt(window.parent.chkexportdata.value)=="1")
   		  {
   		  	JSONToCSVCon(data1, 'To Be Invoiced Sailk', true);
   		  }
   		 else
   		  {
   			$("#jqxNotInvoiced").jqxGrid('exportdata', 'xls', 'To Be Invoiced Sailk');
   		  }
   		
 		
		}); 
	 /* var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
     $('#fromdate').jqxDateTimeInput('setDate', new Date(oneyearbackdate)); */
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
		  clientSearchContent('clientDetailsSearchGrid.jsp?id=1');
		});
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
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp?id=1');
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
		 $('#txtclientname').val('');$('#agmtvocno').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#fromdate').val(new Date());$('#todate').val(new Date());
		$('#cmbtype').val('');
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
	
	function funreload(event){
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Warning','Please Select a Single Branch');
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
		 var branchval =document.getElementById("cmbbranch").value.trim();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
		 var type=$('#cmbtype').val();
		 var agmtstatus=$('#cmbagmtstatus').val();
		 
		 $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load('notInvoicedGrid.jsp?branchval='+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&type='+type+'&agmtstatus='+agmtstatus);
	}
	
	function funSalikInvoicePrint(){
        var url=document.URL;
        var reurl=url.split("notInvoiced.jsp");
        var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
        var win= window.open(reurl[0]+"printSalikToBeInvoiced?&branch="+document.getElementById("cmbbranch").value+'&fromDate='+document.getElementById("fromdate").value+'&toDate='+$("#todate").val()+'&agmtno='+agmtno+'&rentaltype='+rentaltype+'&cldocno='+cldocno,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
        win.focus();
   }
	
	function setValues(){
		 if($('#msg').val()!=""){
	   		   $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
	   		  }
	}
	
	function funGenerate(){
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
		var rows=$('#jqxNotInvoiced').jqxGrid('getrows');
		if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Warning','Please Select a Single Branch');
			return false;
		}
		
		if(rows.length==0){
			$.messager.alert('Message','Not Valid Data','warning');
			return false;
		}
		else{
			 $.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
		 			if (r){
		 				document.getElementById("mode").value="A";
		 				$("#overlay, #PleaseWait").show();
		 				
		 				document.getElementById("frmNotInvoicedSalikClosedAgmt").submit();
		 				funClearData();
		 			}
			 });
		}
	}
</script>

</head>
<body onload="getBranch();setValues();">

<form id="frmNotInvoicedSalikClosedAgmt"
      action="saveNotInvoicedSalikClosedAgmt"
      method="post">

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

        <!-- Filters -->
        <div class="filter-card">
            <table class="salik-filter-table">

                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>

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
                    <td class="label-cell">Agmt Status</td>
                    <td>
                        <select id="cmbagmtstatus" name="cmbagmtstatus">
                            <option value="1">Closed</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agmt Type</td>
                    <td>
                        <select id="rentaltype" name="rentaltype">
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

                <tr>
                    <td class="label-cell">Tariff Type</td>
                    <td>
                        <select id="cmbtype" name="cmbtype">
                            <option value="">--Select--</option>
                            <option value="Daily">Daily</option>
                            <option value="Weekly">Weekly</option>
                            <option value="Monthly">Monthly</option>
                            <option value="Lease">Lease</option>
                        </select>
                    </td>
                </tr>

            </table>

            <!-- Actions -->
            <div class="salik-actions">
                <button type="button"
                        id="btngenerate"
                        class="btn-submit"
                        onclick="funGenerate();">
                    Generate
                </button>

                <button type="button"
                        class="btn-submit"
                        onclick="funClearData();">
                    Clear
                </button>

                <button type="button"
                        id="btnSalikInvoicePrint"
                        class="btn-submit"
                        onclick="funSalikInvoicePrint();">
                    Print
                </button>
            </div>
        </div>

        <!-- Hidden Fields -->
        <input type="hidden" id="msg" name="msg"
               value='<s:property value="msg"/>'>
        <input type="hidden" id="mode" name="mode"
               value='<s:property value="mode"/>'>

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
        <jsp:include page="notInvoicedGrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>

<!-- POPUPS -->
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="agreementDetailsWindow"><div></div><div></div></div>

</div>
</form>
</body>
</html>