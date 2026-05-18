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
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
	$("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	$('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#clientwindow').jqxWindow('close');
	$('#projectwindow').jqxWindow({ width: '50%', height: '65%',  maxHeight: '65%' ,maxWidth: '65%' , title: 'Project Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	$('#projectwindow').jqxWindow('close');
	$('#client').dblclick(function(){
		$('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
	});
	$('#project').dblclick(function(){
		$('#projectwindow').jqxWindow('open');
		$('#projectwindow').jqxWindow('focus');
		projectSearchContent('projectSearchGrid.jsp?id=1');
	});
	
	document.getElementById("imgloading").style.display="none";
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			
			$('#periodupto').jqxDateTimeInput('val',items);
			
		} else {

		}
	}
	x.open("GET","getLastDay.jsp?date="+$('#periodupto').jqxDateTimeInput('val'), true);
	x.send();
	
	$.get("../getInitData.jsp", function(data, status){
		   data=JSON.parse(data);
			if(data.invfuturedate=="1"){
				$('.tr-futuredate').show();
			}
			else{
				$('.tr-futuredate').hide();
			}
		});
	
	$('#periodupto').on('change', function (event) 
			{  
			if($('#chkfuturedate').is(':checked')==true){
					var curdate=new Date();
					var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
					if(curdate.getMonth()!=formdate.getMonth()){
						$.messager.alert('Warning','Please choose a valid month');
						return false;
					}
			}
			else{
				var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#periodupto').jqxDateTimeInput('focus');
					return false;
				}
			}
			
			
				
			    var jsDate = event.args.date; 
			    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
			 	var date=$('#uptodate').jqxDateTimeInput('val');
				var x = new XMLHttpRequest();
				x.onreadystatechange = function() {
					if (x.readyState == 4 && x.status == 200) {
						var items = x.responseText.trim();
						if(items=="0"){
							$.messager.alert('Warning','Date should be month end');
							return false;
						}
						else{
							return true;
						}
					} else {

					}
				}
				x.open("GET","checkMonthEnd.jsp?date="+date, true);
				x.send();

			});
	
	setAgmtType("RAG");
});
function getClient(event){
	var x= event.keyCode;
    if(x==114){
    	$('#clientwindow').jqxWindow('open');
  		$('#clientwindow').jqxWindow('focus');
  		clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
    }
    else{
    }
}

function clientSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#clientwindow').jqxWindow('setContent', data);
	}); 
}
function projectSearchContent(url) {
	$.get(url).done(function (data) {
    	$('#projectwindow').jqxWindow('setContent', data);
	}); 
}

function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		$.messager.alert('Warning','Please Select Branch');
        return false;
	}
	
	if($('#cmbtype').val()==''){
		$.messager.alert('Warning','Please Select Type');
        return false;
	}
	if($('#chkfuturedate').is(':checked')==true){
		var curdate=new Date();
		var formdate=new Date($('#periodupto').jqxDateTimeInput('getDate'));
		if(curdate.getMonth()!=formdate.getMonth()){
			$.messager.alert('Warning','Please choose a valid month');
			return false;
		}
		var date=$('#periodupto').jqxDateTimeInput('val');
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();
				if(items=="0"){
					$.messager.alert('Warning','Date should be month end');
					return false;
				}
				else{
					$("#overlay, #PleaseWait").show(); 
					var branchvalue = document.getElementById("cmbbranch").value;
			     	var date1= $('#periodupto').jqxDateTimeInput('getText');
					var client=document.getElementById("hidclient").value;
			     	var agmttype='';
			     	var rpttype='';
			     	if(document.getElementById("chkclient").checked==true){
			     		rpttype="CRM";
			     	}
			     	else if(document.getElementById("chkproject").checked==true){
			     		rpttype="PRJ"
			     	}
			     	if(document.getElementById("chkrental").checked==true){
			     		agmttype="RAG";
			     	}
			     	else if(document.getElementById("chklease").checked==true){
			     		agmttype="LAG"
			     	}
			     	var projectdocno="";
			     	if($('#hidproject').val()!=''){
			     		projectdocno=$('#hidproject').val();
			     	}
			     	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?date1='+date1+'&branch='+branchvalue+'&client='+client+'&id=1&type='+agmttype+'&rpttype='+rpttype+'&projectdocno='+projectdocno);
				}
			} else {

			}
		}
		x.open("GET","checkMonthEnd.jsp?date="+date, true);
		x.send();
	}
	else{
		var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(dateval==1){
			var date=$('#periodupto').jqxDateTimeInput('val');
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					if(items=="0"){
						$.messager.alert('Warning','Date should be month end');
						return false;
					}
					else{
						$("#overlay, #PleaseWait").show(); 
						var branchvalue = document.getElementById("cmbbranch").value;
				     	var date1= $('#periodupto').jqxDateTimeInput('getText');
						var client=document.getElementById("hidclient").value;
				     	var agmttype='';
				     	var rpttype='';
				     	if(document.getElementById("chkclient").checked==true){
				     		rpttype="CRM";
				     	}
				     	else if(document.getElementById("chkproject").checked==true){
				     		rpttype="PRJ"
				     	}
				     	if(document.getElementById("chkrental").checked==true){
				     		agmttype="RAG";
				     	}
				     	else if(document.getElementById("chklease").checked==true){
				     		agmttype="LAG"
				     	}
				     	var projectdocno="";
				     	if($('#hidproject').val()!=''){
				     		projectdocno=$('#hidproject').val();
				     	}
				     	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?date1='+date1+'&branch='+branchvalue+'&client='+client+'&id=1&type='+agmttype+'&rpttype='+rpttype+'&projectdocno='+projectdocno);
					}
				} else {

				}
			}
			x.open("GET","checkMonthEnd.jsp?date="+date, true);
			x.send();
			
			
			
		}	
	}
	
	}
function funCalculate(){
	/* $("#overlay, #PleaseWait").show();  */
	/* var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	 var date1= $('#periodupto').jqxDateTimeInput('getText');
		 var client=document.getElementById("hidclient").value;
		 var agmtno=document.getElementById("hidagmtno").value;
		 var branchvalue =document.getElementById("cmbbranch").value;
	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1&agmtno='+agmtno);
 */
	}
	

/* 	function funNotify(){
		
		var z=0;
    			    var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');                    
    	if(rows.length>0 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
    		return false;
    	}
    			    var selectedRecords = new Array();
                    var selectedrows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
        if(rows[0].amount=="undefined" || rows[0].amount==null || rows[0].amount==""){
            $.messager.alert('Warning','Please Calculate the Amount');
            return false;
        }
		if(selectedrows.length==0){
			$.messager.alert('Warning','Select an Invoice');
			return false;
		}
		var dataarray=new Array();
		$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
		var i=0;
                    $('#invgridlength').val(selectedrows.length);
    			     for (i = 0; i < rows.length; i++) {
						for(var j=0;j<selectedrows.length;j++){
							if(selectedrows[j]==i){
								
								//alert("Inside"+z);
								//selectedRecords[j]=$("#rentalInvoiceGrid").jqxGrid('getrowdata', selectedrows[j]);
								/* newTextBox = $(document.createElement("input"))
							    .attr("type", "dil")
							    .attr("id", "testinvoice"+z)
							    .attr("name", "testinvoice"+z)
							    .attr("hidden","true");
						if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){		
							dataarray.push(rows[i].rano+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate);
							
							}
							//alert("ddddd"+$("#testinvoice"+z).val());
							z++;
							
							}
							
						}
						 var temprows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
						
						for(var i=0;i<temprows.length;i++){
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							var rano=$('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano');
							+"::"+rows[i].ratype+"::"+rows[i].fromdate+"::"+rows[i].todate+"::"+rows[i].acno+"::"+rows[i].acname+"::"+rows[i].amount+"::"+rows[i].cldocno+"::"+rows[i].rentalsum+"::"+rows[i].accsum+"::"+rows[i].salikamt+"::"+rows[i].trafficamt+"::"+rows[i].saliksrvc+"::"+rows[i].trafficsrvc+"::"+rows[i].datediff+"::"+rows[i].brhid+"::"+rows[i].curid+"::"+rows[i].insurchg+"::"+rows[i].salikcount+"::"+rows[i].trafficcount+"::"+rows[i].salamount+"::"+rows[i].salrate
							checkarray.push($('#leaseInvoiceGrid').jqxGrid('getcellvalue',temprows[i],'rano'));
						} 
						$('#reqhidden').val(dataarray);
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
	    	    				document.getElementById("frmDashboardLeaseInvoice").submit();
						
		 }
    		 		
    	    			   
    		 			}
    		 	 		});

	} */
	
	function funNotify(){
		
		var selectedrows=$('#agmtDetailGrid').jqxGrid('selectedrowindexes');
		if(selectedrows.length==0){
			$.messager.alert('Warning','Please select valid documents');
			return false;
		}
		$.messager.confirm('Confirm', 'Do you want to Generate Invoice?', function(r){
 			if (r){
		var agmtarray=new Array();
		for(var i=0;i<selectedrows.length;i++){
			var rano=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rano');
			var ratype=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'ratype');
			var fromdate=$('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'fromdate');
			var todate=$('#agmtDetailGrid').jqxGrid('getcelltext',selectedrows[i],'todate');
			var acno=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acno');
			var amount=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'amount');
			var cldocno=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'cldocno');
			var rentalsum=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'rentalsum');
			var accsum=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'accsum');
			var datediff=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'datediff');
			var brhid=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'brhid');
			var curid=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'curid');
			var insurchg=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'insurchg');
			var acname=$('#agmtDetailGrid').jqxGrid('getcellvalue',selectedrows[i],'acname');
			agmtarray.push(rano+"::"+ratype+"::"+fromdate+"::"+todate+"::"+acno+"::"+amount+"::"+cldocno+"::"+rentalsum+"::"+accsum+"::"+datediff+"::"+brhid+"::"+curid+"::"+insurchg+"::"+acname);
			
		}
		document.getElementById("selectedagmt").value=agmtarray;
		$('#mode').val('A');
		document.getElementById("frmDashboardBulkInvoice").submit();
 			}
		});
	}
	function setValues(){

		 if($('#msg').val()!=""){
   		   $.messager.alert('Message','<center>'+$('#msg').val()+'</center>');
   		  }
		
	}
	 function funExportBtn(){
		if(parseInt(window.parent.chkexportdata.value)=="1")
		  {
		  	JSONToCSVCon(invoicedata, 'Lease Invoice', true);
		  }
		 else
		  {
			 $("#leaseInvoiceGrid").jqxGrid('exportdata', 'xls', 'Lease Invoice');
		  }
		 
	}

	function setAgmtType(value){
		if(document.getElementById("chkrental").checked==true){
			document.getElementById("hidchkagmttype").value="RAG";
		}
		else if(document.getElementById("chklease").checked==true){
			document.getElementById("hidchkagmttype").value="LAG";
		}
	}
	function getProject(){
		var x= event.keyCode;
	    if(x==114){
	    	$('#projectwindow').jqxWindow('open');
			$('#projectwindow').jqxWindow('focus');
			projectSearchContent('projectSearchGrid.jsp?id=1');
	    }
	    else{
	    }	
	}
	function setReportType(value){
		
	}
	function funClearData(){
		$('#leaseInvoiceGrid,#agmtDetailGrid').jqxGrid('clear');
		$('#project,#hidproject,#client,#hidclient').val('');
		
	}
</script>

<style type="text/css">
/* ===== MASTER LAYOUT ===== */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar dynamically fills the left TD */
.sidebar-filters {
    width: 100%;
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
    padding: 15px 20px 15px; 
}

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px; 
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* ===== UNIFORM 24px TEXT INPUTS ===== */
input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
    outline: none;
}

select {
    padding: 2px 24px 2px 8px !important; 
    font-family: inherit;
    cursor: pointer;
    appearance: none;
    -webkit-appearance: none;
    background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%234e5e71' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
    background-repeat: no-repeat;
    background-position: right 6px center;
    background-size: 12px;
}

input[readonly],
input:disabled,
select:disabled {
    background-color: #ffffff !important;
    color: #555;
    cursor: text !important;
}

/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}

.btn-submit {
    flex: 1;
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    white-space: nowrap;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover {
    background: #1d4ed8 !important;
}

/* Layout Utilities */
.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}

input[type="radio"], input[type="checkbox"] {
    margin: 0 4px 0 0;
    vertical-align: middle;
}

.radio-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
}

.radio-group label {
    display: flex;
    align-items: center;
    cursor: pointer;
}

.sidebar-filters label.branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>

</head>
<body onload="getBranch();setValues();">
<form id="frmDashboardBulkInvoice" action="saveDashboardBulkInvoice" method="post" >
<input type="hidden" id="selectedagmt" name="selectedagmt">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

    <!-- LEFT SIDEBAR -->
    <div class="sidebar-filters" style="width:320px; min-width:320px;">

        <!-- HEADER -->
        <div class="sidebar-fixed-top">

            <jsp:include page="../../heading.jsp"></jsp:include>

        </div>


        <!-- SCROLL CONTENT -->
        <div class="sidebar-scroll-content">

            <!-- MAIN FILTER CARD -->
            <div class="filter-card" style="
                padding:16px;
                border-radius:18px;
            ">

                <table class="filter-table">

                    <!-- FUTURE DATE -->
                    <tr class="tr-futuredate" hidden="true">

                        <td colspan="2">

                            <label class="branch" style="
                                display:flex;
                                align-items:center;
                                gap:6px;
                                cursor:pointer;
                            ">

                                <input 
                                    type="checkbox"
                                    id="chkfuturedate"
                                    name="chkfuturedate">

                                Future Date Invoicing

                            </label>

                        </td>

                    </tr>



                    <!-- PERIOD -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Period Upto</label>
                        </td>

                        <td>
                            <div 
                                id="periodupto"
                                name="periodupto">
                            </div>
                        </td>

                    </tr>



                    <!-- AGREEMENT TYPE -->
                    <tr>

                        <td colspan="2">

                            <div class="radio-group">

                                <label class="branch" style="
                                    display:flex;
                                    align-items:center;
                                    gap:6px;
                                ">

                                    <input 
                                        type="radio"
                                        name="chkagmttype"
                                        id="chkrental"
                                        value="RAG"
                                        checked
                                        onchange="setAgmtType(value);">

                                    Rental

                                </label>


                                <label class="branch" style="
                                    display:flex;
                                    align-items:center;
                                    gap:6px;
                                ">

                                    <input 
                                        type="radio"
                                        name="chkagmttype"
                                        id="chklease"
                                        value="LAG"
                                        onchange="setAgmtType(value);">

                                    Lease

                                </label>

                            </div>

                        </td>

                    </tr>



                    <!-- REPORT TYPE -->
                    <tr>

                        <td colspan="2">

                            <div class="radio-group">

                                <label class="branch" style="
                                    display:flex;
                                    align-items:center;
                                    gap:6px;
                                ">

                                    <input 
                                        type="radio"
                                        name="chkrpttype"
                                        id="chkclient"
                                        value="CRM"
                                        checked
                                        onchange="setReportType(value);">

                                    Client

                                </label>


                                <label class="branch" style="
                                    display:flex;
                                    align-items:center;
                                    gap:6px;
                                ">

                                    <input 
                                        type="radio"
                                        name="chkrpttype"
                                        id="chkproject"
                                        value="PRJ"
                                        onchange="setReportType(value);">

                                    Project

                                </label>

                            </div>

                        </td>

                    </tr>



                    <!-- PROJECT -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Project</label>
                        </td>

                        <td>

                            <input 
                                type="text"
                                name="project"
                                id="project"
                                readonly
                                placeholder="Press F3 to Search"
                                onkeydown="getProject(event);">

                        </td>

                    </tr>



                    <!-- CLIENT -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Client</label>
                        </td>

                        <td>

                            <input 
                                type="text"
                                name="client"
                                id="client"
                                readonly
                                placeholder="Press F3 to Search"
                                onkeydown="getClient(event);"
                                value='<s:property value="client"/>'>

                        </td>

                    </tr>



                    <!-- TYPE -->
                    <tr>

                        <td class="label-cell">
                            <label class="branch">Type</label>
                        </td>

                        <td>

                            <select name="cmbtype">

                                <option value="1">Month End</option>
                                <option value="2">Period</option>

                            </select>

                        </td>

                    </tr>

                </table>

            </div>



            <!-- ACTION BUTTONS -->
            <div class="button-group" style="
                margin-top:18px;
            ">

                <input 
                    type="button"
                    name="btninvoicesave"
                    id="btninvoicesave"
                    class="btn-submit"
                    value="Generate"
                    onclick="funNotify();">


                <input 
                    type="button"
                    name="btncleardata"
                    id="btncleardata"
                    class="btn-submit"
                    value="Clear"
                    onclick="funClearData();"
                    style="
                        background:#64748b !important;
                    ">

            </div>


            <!-- SPACER -->
            <div style="height:40px;"></div>

        </div>

    </div>



    <!-- RIGHT CONTENT -->
    <div class="main-content-wrapper">

        <div class="scrollable-grid-area">

            <!-- LOADER -->
            <div id="imgdiv" style="
                position:absolute;
                z-index:1;
                top:200px;
                right:600px;
            ">

                <img 
                    id="imgloading"
                    alt=""
                    src="../../../../icons/31load.gif"/>

            </div>



            <!-- LEASE INVOICE GRID -->
            <div id="leaseinvoicediv" class="filter-card" style="
                margin-bottom:18px;
                padding:0;
                overflow:hidden;
            ">

                <jsp:include page="leaseInvoiceGrid.jsp"></jsp:include>

            </div>



            <!-- AGREEMENT GRID -->
            <div id="leaseagmtdiv" class="filter-card" style="
                padding:0;
                overflow:hidden;
            ">

                <jsp:include page="agmtDetailGrid.jsp"></jsp:include>

            </div>

        </div>

    </div>

</div>



<!-- HIDDEN FIELDS -->
<input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>

<input type="hidden" name="hidproject" id="hidproject" value='<s:property value="hidproject"/>'>

<input type="hidden" name="hidchkagmttype" id="hidchkagmttype" value='<s:property value="hidchkagmttype"/>'>

<input type="hidden" name="hidclient" id="hidclient">

<input type="hidden" name="gridlength" id="gridlength">

<input type="hidden" name="invgridlength" id="invgridlength">

<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>

<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="agmtwindow">
<div></div>
</div>
<div id="projectwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>