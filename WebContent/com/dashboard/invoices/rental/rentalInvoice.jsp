<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>GatewayERP(i)</title>
		<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
	
		<script type="text/javascript">
			$(document).ready(function () {
				document.getElementById("btninvoicesave").style.display="none";
	 			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
	    		$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
	 			
	    		$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 			
	    		$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   			$('#clientwindow').jqxWindow('close');
	   			
	   			$('#client').dblclick(function(){
		    		$('#clientwindow').jqxWindow('open');
					$('#clientwindow').jqxWindow('focus');
		 			clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
				});
		  		
	   			document.getElementById("imgloading").style.display="none";
				document.getElementById("chkall").checked=true;
				setAll();
	   			setSalik();
	   			setTraffic();
	   			setFutureDate();
	   			$('#periodupto').on('change', function (event){  
		   			
	   				var futureconfig=$('#chkfuturedate').attr('data-config');
	   				if($('#chkfuturedate').is(':checked')==true && futureconfig=="1"){
		   				var curdate=new Date();
		   				var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
		   				if(curdate.getMonth()!=formdate.getMonth()){
		   					$.messager.alert('Warning','Please choose a valid month');
		   					return false;
		   				}
		   			}
	   				else if($('#chkfuturedate').is(':checked')==false){
		   				var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
						if(docdateval==0){
							$('#periodupto').jqxDateTimeInput('focus');
							return false;
						}	
		   			}
				});
	
	   			$.get("../getInitData.jsp", function(data, status){
		   			data=JSON.parse(data);
		   			$('#chkfuturedate').attr('data-config',data.invfuturedate);
					if(parseInt(data.invfuturedate)>0){
						$('.tr-futuredate').show();
					}
					else{
						$('.tr-futuredate').hide();
					}
				});
			});
			
			function getClient(event){
	 			var x= event.keyCode;
    			if(x==114){
    	  			$('#clientwindow').jqxWindow('open');
  					$('#clientwindow').jqxWindow('focus');
  		 			clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    			}
			}
			
			function clientSearchContent(url) {
				$.get(url).done(function (data) {
					$('#clientwindow').jqxWindow('setContent', data);
				}); 
			}
			
			function funreload(event){
				if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
					$.messager.alert('Warning','Please Select Branch');
					return false;
				}
				var futureconfig=$('#chkfuturedate').attr('data-config');
				if($('#chkfuturedate').is(':checked')==true && futureconfig=="1"){
					var curdate=new Date();
					var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
					if(curdate.getMonth()!=formdate.getMonth()){
						$.messager.alert('Warning','Please choose a valid month');
						return false;
					}
				}
	
				if($('#chkfuturedate').is(':checked')==true){
					var barchval = document.getElementById("cmbbranch").value;
    	 			var date1= $('#periodupto').jqxDateTimeInput('getText');
    		 		var client=document.getElementById("hidclient").value;
    				$('#rentalInvoiceGrid').jqxGrid('clear');
    				$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    				document.getElementById("btninvoicesave").style.display="none";
	  				$("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
				}
				else{
					var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));	
					if(dateval==1){
			 			var barchval = document.getElementById("cmbbranch").value;
		     	 		var date1= $('#periodupto').jqxDateTimeInput('getText');
		     		 	var client=document.getElementById("hidclient").value;
		     			$('#rentalInvoiceGrid').jqxGrid('clear');
		     			$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
		     			document.getElementById("btninvoicesave").style.display="none";
			  			$("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
					}
				}
			}
			
			function funCalculate(){
				var futureconfig=$('#chkfuturedate').attr('data-config');
				if($('#chkfuturedate').is(':checked')==true && futureconfig=="1"){
					var curdate=new Date();
					var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
					if(curdate.getMonth()!=formdate.getMonth()){
						$.messager.alert('Warning','Please choose a valid month');
						return false;
					}
				}
				
				if($('#chkfuturedate').is(':checked')==false){
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}	
				}
	
				$("#overlay, #PleaseWait").show(); 
				var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');
				if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
					return false;
				}
	 			
				var date1= $('#periodupto').jqxDateTimeInput('getText');
	 			var client=document.getElementById("hidclient").value;
	 			var branchvalue =document.getElementById("cmbbranch").value;
	 			$('#rentalinvoicediv').load('rentalInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1');
			}
	

			function funNotify(){
				var futureconfig=$('#chkfuturedate').attr('data-config');
				if($('#chkfuturedate').is(':checked')==true && futureconfig=="1"){
					var curdate=new Date();
					var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
					if(curdate.getMonth()!=formdate.getMonth()){
						$.messager.alert('Warning','Please choose a valid month');
						return false;
					}
				}
				
				if($('#chkfuturedate').is(':checked')==false){
					var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
					if(docdateval==0){
						$('#periodupto').jqxDateTimeInput('focus');
						return false;
					}	
				}
		
		
				var z=0;
    			var rows = $("#rentalInvoiceGrid").jqxGrid('getrows');                    
    			if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    				return false;
    			}
				
    			var selectedRecords = new Array();
                var selectedrows=$("#rentalInvoiceGrid").jqxGrid('selectedrowindexes');
        		if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            		$.messager.alert('Warning','Please Calculate the Amount');
            		return false;
        		}
				if(selectedrows.length==0){
					$.messager.alert('Warning','Select an Invoice');
					return false;
				}
		   		$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
	 				if (r){
	 					var i=0;
                    	$('#invgridlength').val(selectedrows.length);
    			    	for(var j=0;j<selectedrows.length;j++){
    			    		newTextBox = $(document.createElement("input"))
						    	.attr("type", "dil")
						    	.attr("id", "testinvoice"+z)
						    	.attr("name", "testinvoice"+z)
						    	.attr("hidden","true");
						    
							var rano=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'rano');
							var ratype=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'ratype');
							var fromdate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'fromdate');
							var todate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'todate');
							var acno=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'acno');
							var acname=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'acname');
							var amount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'amount');
							var cldocno=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'cldocno');
							var rentalsum=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'rentalsum');
							var accsum=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'accsum');
							var salikamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikamt');
							var trafficamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficamt');
							var saliksrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'saliksrvc');
							var trafficsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficsrvc');
							var datediff=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'datediff');
							var brhid=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'brhid');
							var curid=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'curid');
							var insurchg=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'insurchg');
							var salikcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikcount');
							var trafficcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'trafficcount');
							var salamount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salamount');
							var salrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salrate');
								
							var salikauhamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhamt');
							var salikdxbamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbamt');
							var salikauhsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhsrvc');
							var salikdxbsrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbsrvc');
							var salikauhcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhcount');
							var salikdxbcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbcount');
							var salikauhrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhrate');
							var salikdxbrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbrate');
							var salikauhsrvcrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikauhsrvcrate');
							var salikdxbsrvcrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikdxbsrvcrate');
							
							var salikparkamt=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkamt');
							var salikparksrvc=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparksrvc');
							var salikparkcount=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkcount');
							var salikparkrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkrate');
							var salikparksrvcrate=$("#rentalInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparksrvcrate');
							
							newTextBox.val(rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+acname+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+salikamt+"::"+trafficamt+"::"+saliksrvc+"::"+trafficsrvc+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+salikcount+"::"+trafficcount+"::"+salamount+"::"+salrate+"::"+salikauhamt+"::"+salikdxbamt+"::"+salikauhsrvc+"::"+salikdxbsrvc+"::"+salikauhcount+"::"+salikdxbcount+"::"+salikauhrate+"::"+salikdxbrate+"::"+salikauhsrvcrate+"::"+salikdxbsrvcrate+"::"+salikparkamt+"::"+salikparksrvc+"::"+salikparkcount+"::"+salikparkrate+"::"+salikparksrvcrate);
    			    	
    			    		newTextBox.appendTo('form');
							z++;
    			    	}
    			    
    			    	document.getElementById("mode").value='A';
						$("#overlay, #PleaseWait").show();
						document.getElementById("frmDashboardRentalInvoice").submit();
    			 
    		 		}
    			});
		
			}
			
			function setValues(){
				if($('#msg').val()!=""){
   		  			$.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  		}
			}
	
			function funExportBtn(){
				$("#rentalInvoiceGrid").excelexportjs({
		 			containerid: "rentalInvoiceGrid",
		 			datatype: 'json',
		 			dataset: null,
		 			gridId: "rentalInvoiceGrid",
		 			columns: getColumns("rentalInvoiceGrid") ,
		 			worksheetName:"Rental Invoice"
		 		});
			}
		
	
 			function setSalik(){
		
 				if(document.getElementById("chksalik").checked==true){
					document.getElementById("hidchksalik").value="1";
					document.getElementById("hidchkexsalik").value="0";
					document.getElementById("chkall").checked=false;
 				}
 				if(document.getElementById("chkexsalik").checked==true){
					document.getElementById("hidchkexsalik").value="1";
					document.getElementById("hidchksalik").value="0";
					document.getElementById("chkall").checked=false;
 				} 
			}
	
			function setTraffic(){
				if(document.getElementById("chktraffic").checked==true){
					document.getElementById("hidchktraffic").value="1";
					document.getElementById("hidchkextraffic").value="0";
					document.getElementById("chkall").checked=false;
				}
				if(document.getElementById("chkextraffic").checked==true){
					document.getElementById("hidchkextraffic").value="1";
					document.getElementById("hidchktraffic").value="0";
					document.getElementById("chkall").checked=false;
				}
			}
	
	 		function setAll(){
		 		if(document.getElementById("chkall").checked==true){
			 		document.getElementById("hidchkall").value="1";
			 		$('#chksalik').removeAttr('checked');
			 		$('#chkexsalik').removeAttr('checked');
			 		$('#chktraffic').removeAttr('checked');
			 		$('#chkextraffic').removeAttr('checked');
			 		document.getElementById("hidchksalik").value="0";
			 		document.getElementById("hidchkexsalik").value="0";
					document.getElementById("hidchktraffic").value="0";
					document.getElementById("hidchkextraffic").value="0";
				}
				else{
					document.getElementById("hidchkall").value="0";
				}
			}
	 
	 		function funClear(){
		 		$('#rentalInvoiceGrid,#invnoGrid').jqxGrid('clear');
		 		$('#periodupto').jqxDateTimeInput('setDate',new Date());
		 		document.getElementById("chkall").checked=true;
				setAll();
			   	setSalik();
			   	setTraffic();
			   	setFutureDate();
			   	document.getElementById("client").value=""; 
		    	document.getElementById("hidclient").value="";
				funreload("");
	 		}
	 		function setFutureDate(){
	 			if(document.getElementById("chkfuturedate").checked==true){
	 				$('#hidchkfuturedate').val(1);
	 			}
	 			else{
	 				$('#hidchkfuturedate').val(0);
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
    width: 100%;
    font-weight: 600;
    cursor: pointer;
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
}
</style>
	<body onload="getBranch();setValues();">
		<form id="frmDashboardRentalInvoice" action="saveDashboardRentalInvoice" method="post">
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
                    <tr class="tr-futuredate" hidden="true">
                        <td colspan="2">
                            <input type="checkbox" id="chkfuturedate" name="chkfuturedate" onchange="setFutureDate();">
                            <label class="branch" for="chkfuturedate">Future Date Invoicing</label>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Period Upto</td>
                        <td><div id="periodupto"></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td><input type="text" name="client" id="client" onkeydown="getClient(event);" readonly value='<s:property value="client"/>'></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center" style="padding: 5px 0;">
                            <label class="branch" for="chkall">All</label>
                            <input type="checkbox" name="chkall" id="chkall" onchange="setAll();">
                        </td>
                    </tr>
                </table>

                <fieldset>
                    <legend>Separate Invoice</legend>
                    <div style="display: flex; justify-content: center; gap: 15px;">
                        <label class="branch"><input type="radio" name="chksalik" id="chksalik" onChange="setSalik();"> Salik</label>
                        <label class="branch"><input type="radio" name="chktraffic" id="chktraffic" onchange="setTraffic();"> Traffic</label>
                    </div>
                </fieldset>

                <fieldset>
                    <legend>Not To Be Invoiced</legend>
                    <div style="display: flex; justify-content: center; gap: 15px;">
                        <label class="branch"><input type="radio" name="chksalik" id="chkexsalik" onChange="setSalik();"> Salik</label>
                        <label class="branch"><input type="radio" name="chktraffic" id="chkextraffic" onchange="setTraffic();"> Traffic</label>
                    </div>
                </fieldset>
            </div>

            <div id="Readygrid" style="margin-top: 10px; border: 1px solid #e3e8ee; border-radius: 8px; overflow: hidden;">
                <jsp:include page="invnoGrid.jsp"></jsp:include>
            </div>

            <div style="margin-top: 15px; display: flex; gap: 8px;">
                <input type="button" name="btnclear" id="btnclear" class="myButton" value="Clear" onclick="funClear();" style="flex: 1;">
                <input type="button" name="btninvoicesave" id="btninvoicesave" class="myButton" value="Generate" onclick="funNotify();" style="flex: 1;">
            </div>

            <input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>
            <input type="hidden" name="hidchksalik" id="hidchksalik" value='<s:property value="hidchksalik"/>'>
            <input type="hidden" name="hidchktraffic" id="hidchktraffic" value='<s:property value="hidchktraffic"/>'>
            <input type="hidden" name="hidchkexsalik" id="hidchkexsalik" value='<s:property value="hidchkexsalik"/>'>
            <input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'>
            <input type="hidden" name="hidclient" id="hidclient" >
            <input type="hidden" name="hidchkfuturedate" id="hidchkfuturedate" value='<s:property value="hidchkfuturedate"/>'>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="imgdiv">
                <img id="imgloading" alt="Loading..." src="../../../../icons/29load.gif"/>
            </div>
            
            <div id="rentalinvoicediv">
                <jsp:include page="rentalInvoiceGrid.jsp"></jsp:include>
            </div>

            <input type="hidden" name="gridlength" id="gridlength" >
            <input type="hidden" name="invgridlength" id="invgridlength" >
            <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
            <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        </div>
    </div>
</div>
						</div>
						<div id="clientwindow">
							<div></div>
						</div>
					</div>
				</form>
			</body>
		</html>