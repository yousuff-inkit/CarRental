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
    /* Partial Pie Chart Starts*/
    $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#periodupto").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $('#clientwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	 $('#clientwindow').jqxWindow('close');
	 $('#agmtwindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#agmtwindow').jqxWindow('close');  
	   $('#client').dblclick(function(){
		    $('#clientwindow').jqxWindow('open');
		$('#clientwindow').jqxWindow('focus');
		 clientSearchContent('clientINgridsearch.jsp', $('#clientwindow'));
		});
	   $('#agmtno').dblclick(function(){
		   $('#agmtwindow').jqxWindow('open');
			$('#agmtwindow').jqxWindow('focus');
			 agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
		});
	  document.getElementById("imgloading").style.display="none";
	  document.getElementById("chkall").checked=true;
		setAll();
		setSalik();
	   setTraffic();
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
		if($('#chkfuturedate').is(':checked')==false){
			var docdateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
			if(docdateval==0){
				$('#periodupto').jqxDateTimeInput('focus');
				return false;
			}	
		}
	});
	$.get("../getInitData.jsp", function(data, status){
		data=JSON.parse(data);
		if(data.invfuturedate=="1"){
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
    else{
     }
}
function getAgmt(event){
	 var x= event.keyCode;
   if(x==114){
	   $('#agmtwindow').jqxWindow('open');
		$('#agmtwindow').jqxWindow('focus');
		 agmtSearchContent('agmtMasterSearch.jsp', $('#agmtwindow'));
   }
   else{
    }
}
function clientSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function agmtSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#agmtwindow').jqxWindow('setContent', data);

}); 
}
function funreload(event)
{
	if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
		 $.messager.alert('Warning','Please Select Branch');
         return false;
	}
	
	if($('#chkfuturedate').is(':checked')==true){
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
    		 //alert("barchval"+barchval);
    		 var client=document.getElementById("hidclient").value;
    		$('#leaseInvoiceGrid').jqxGrid('clear');
    		$("#leaseInvoiceGrid").jqxGrid("addrow", null, {});	
    		document.getElementById("btninvoicesave").style.display="none";
    		/* document.getElementById("client").value="";
    		document.getElementById("hidclient").value=""; */
	  $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
	}
	else{
		var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));	
		if(dateval==1){
			 var barchval = document.getElementById("cmbbranch").value;
		     	 var date1= $('#periodupto').jqxDateTimeInput('getText');
		     		 //alert("barchval"+barchval);
		     		 var client=document.getElementById("hidclient").value;
		     		$('#leaseInvoiceGrid').jqxGrid('clear');
		     		$("#leaseInvoiceGrid").jqxGrid("addrow", null, {});	
		     		document.getElementById("btninvoicesave").style.display="none";
		     		/* document.getElementById("client").value="";
		     		document.getElementById("hidclient").value=""; */
			  $("#Readygrid").load("invnoGrid.jsp?barchval="+barchval+"&date1="+date1+"&client="+client+"&status=1");
			}
	}
	}
function funCalculate(){
	$("#overlay, #PleaseWait").show(); 
	var rows = $("#leaseInvoiceGrid").jqxGrid('getrows');
	if(rows.length==1 && (rows[0].rano=="undefined" || rows[0].rano==null || rows[0].rano=="")){
		return false;
	}
	if($('#chkfuturedate').is(':checked')==true){
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
	
	var date1= $('#periodupto').jqxDateTimeInput('getText');
	var client=document.getElementById("hidclient").value;
	var agmtno=document.getElementById("hidagmtno").value;
	var branchvalue =document.getElementById("cmbbranch").value;
	$('#leaseinvoicediv').load('leaseInvoiceGrid.jsp?temp='+null+'&desc1='+document.getElementById("desc").value+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=1&agmtno='+agmtno);

	}
	

	function funNotify(){
		
		if($('#chkfuturedate').is(':checked')==true){
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
							    .attr("hidden","true"); */
							    

								var salikparkamt=$("#leaseInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkamt');
								var salikparksrvc=$("#leaseInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparksrvc');
								var salikparkcount=$("#leaseInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkcount');
								var salikparkrate=$("#leaseInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparkrate');
								var salikparksrvcrate=$("#leaseInvoiceGrid").jqxGrid('getcellvalue',selectedrows[j],'salikparksrvcrate');
								
						if(typeof(rows[i].rano)!="undefined" && rows[i].rano!="" && typeof(rows[i].acno)!="undefined" && rows[i].acno!="" && typeof(rows[i].amount)!="undefined" && rows[i].amount!=""){		
							dataarray.push(rows[i].rano+" :: "+rows[i].ratype+" :: "+rows[i].fromdate+" :: "+rows[i].todate+" :: "+rows[i].acno+" :: "+rows[i].acname+" :: "+rows[i].amount+" :: "+rows[i].cldocno+" :: "+rows[i].rentalsum+" :: "+rows[i].accsum+" :: "+rows[i].salikamt+" :: "+rows[i].trafficamt+" :: "+rows[i].saliksrvc+" :: "+rows[i].trafficsrvc+" :: "+rows[i].datediff+" :: "+rows[i].brhid+" :: "+rows[i].curid+" :: "+rows[i].insurchg+" :: "+rows[i].salikcount+" :: "+rows[i].trafficcount+" :: "+rows[i].salamount+" :: "+rows[i].salrate+"::"+rows[i].salikauhamt+"::"+rows[i].salikdxbamt+"::"+rows[i].salikauhsrvc+"::"+rows[i].salikdxbsrvc+"::"+rows[i].salikauhcount+"::"+rows[i].salikdxbcount+"::"+rows[i].salikauhrate+"::"+rows[i].salikdxbrate+"::"+rows[i].salikauhsrvcrate+"::"+rows[i].salikdxbsrvcrate+"::"+salikparkamt+"::"+salikparksrvc+"::"+salikparkcount+"::"+salikparkrate+"::"+salikparksrvcrate);
							}
//							    alert(dataarray);
							//alert("ddddd"+$("#testinvoice"+z).val());
							z++;
							
							}
							
						}
						//alert(i+"::::::"+rows.length);
						
						/* var temprows=$("#leaseInvoiceGrid").jqxGrid('selectedrowindexes');
						
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
						} */
						$('#reqhidden').val(dataarray);
							 document.getElementById("mode").value='A';
							 $("#overlay, #PleaseWait").show();
	    	    				document.getElementById("frmDashboardLeaseInvoice").submit();
						
			}
    		 		
    	    			   
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
<form id="frmDashboardLeaseInvoice" action="saveDashboardLeaseInvoice" method="post" >
<input type="hidden" id="reqhidden" name="reqhidden">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <div class="sidebar-filters">

    <!-- HEADER -->
    <div class="sidebar-fixed-top">

        <jsp:include page="../../heading.jsp"></jsp:include>

    </div>


    <!-- SCROLLABLE CONTENT -->
    <div class="sidebar-scroll-content" style="
        overflow-y:auto;
        padding-bottom:90px;
        box-sizing:border-box;
    ">

        <!-- FILTER CARD -->
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
                        <div id="periodupto"></div>
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
                            onkeydown="getClient(event);"
                            value='<s:property value="client"/>'
                            placeholder="Press F3 To Search">
                    </td>
                </tr>


                <!-- AGMT -->
                <tr>
                    <td class="label-cell">
                        <label class="branch">Agmt No</label>
                    </td>

                    <td>
                        <input 
                            type="text" 
                            name="agmtno" 
                            id="agmtno"
                            readonly
                            onkeydown="getAgmt(event);"
                            value='<s:property value="agmtno"/>'
                            placeholder="Press F3 To Search">
                    </td>
                </tr>


                <!-- ALL -->
                <tr>
                    <td colspan="2" style="
                        text-align:center;
                        padding-top:2px;
                    ">

                        <label class="branch" style="
                            display:inline-flex;
                            flex-direction:column;
                            align-items:center;
                            gap:2px;
                            cursor:pointer;
                        ">

                            <span>All</span>

                            <input 
                                type="checkbox" 
                                name="chkall" 
                                id="chkall"
                                onchange="setAll();">

                        </label>

                    </td>
                </tr>

            </table>

        </div>



        <!-- SEPARATE INVOICE -->
        <div class="filter-card" style="
            margin-top:14px;
            padding:14px 16px;
            border-radius:16px;
        ">

            <div style="
                font-size:13px;
                font-weight:500;
                color:#3f5368;
                margin-bottom:14px;
            ">
                Separate Invoice
            </div>

            <div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding-right:10px;
            ">

                <label class="branch" style="
                    display:flex;
                    align-items:center;
                    gap:8px;
                    font-size:12px;
                    font-weight:600;
                    color:#000;
                    cursor:pointer;
                ">

                    <input 
                        type="radio" 
                        name="chksalik" 
                        id="chksalik"
                        onchange="setSalik();">

                    Salik

                </label>


                <label class="branch" style="
                    display:flex;
                    align-items:center;
                    gap:8px;
                    font-size:12px;
                    font-weight:600;
                    color:#000;
                    cursor:pointer;
                ">

                    <input 
                        type="radio" 
                        name="chktraffic" 
                        id="chktraffic"
                        onchange="setTraffic();">

                    Traffic

                </label>

            </div>

        </div>



        <!-- NOT TO BE INVOICED -->
        <div class="filter-card" style="
            margin-top:14px;
            padding:14px 16px;
            border-radius:16px;
        ">

            <div style="
                font-size:13px;
                font-weight:500;
                color:#3f5368;
                margin-bottom:14px;
            ">
                Not To Be Invoiced
            </div>

            <div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                padding-right:10px;
            ">

                <label class="branch" style="
                    display:flex;
                    align-items:center;
                    gap:8px;
                    font-size:12px;
                    font-weight:600;
                    color:#000;
                    cursor:pointer;
                ">

                    <input 
                        type="radio" 
                        name="chksalik" 
                        id="chkexsalik"
                        onchange="setSalik();">

                    Salik

                </label>


                <label class="branch" style="
                    display:flex;
                    align-items:center;
                    gap:8px;
                    font-size:12px;
                    font-weight:600;
                    color:#000;
                    cursor:pointer;
                ">

                    <input 
                        type="radio" 
                        name="chktraffic" 
                        id="chkextraffic"
                        onchange="setTraffic();">

                    Traffic

                </label>

            </div>

        </div>



        <!-- GRID -->
        <div class="filter-card" style="
            margin-top:18px;
            padding:0;
            overflow:hidden;
        ">

            <div id="Readygrid">

                <jsp:include page="invnoGrid.jsp"></jsp:include>

            </div>

        </div>



        <!-- BUTTON -->
        <div style="
            margin-top:16px;
            margin-bottom:25px;
        ">

            <input 
                type="button"
                name="btninvoicesave"
                id="btninvoicesave"
                class="btn-submit"
                value="Generate"
                onclick="funNotify();">

        </div>

    </div>

</div>



<!-- HIDDEN FIELDS -->
<input type="hidden" name="hidchkall" id="hidchkall" value='<s:property value="hidchkall"/>'>

<input type="hidden" name="hidchksalik" id="hidchksalik" value='<s:property value="hidchksalik"/>'>

<input type="hidden" name="hidchktraffic" id="hidchktraffic" value='<s:property value="hidchktraffic"/>'>

<input type="hidden" name="hidchkexsalik" id="hidchkexsalik" value='<s:property value="hidchkexsalik"/>'>

<input type="hidden" name="hidchkextraffic" id="hidchkextraffic" value='<s:property value="hidchkextraffic"/>'>

<input type="hidden" name="hidagmtno" id="hidagmtno" value='<s:property value="hidagmtno"/>'>

<input type="hidden" name="hidclient" id="hidclient">
<td width="80%">
	<table width="100%">
		<tr>
			 <td> <div id="imgdiv" style="position:absolute; z-index: 1;top:200;right:600;">
<img id="imgloading" alt="" src="../../../../icons/31load.gif"/></div> <div id="leaseinvoicediv"> <!-- 29load -->
<jsp:include page="leaseInvoiceGrid.jsp"></jsp:include></div> </td>
			 <input type="hidden" name="gridlength" id="gridlength" >
			  <input type="hidden" name="invgridlength" id="invgridlength" >
			  <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
			  <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="clientwindow">
<div></div>
</div>
<div id="agmtwindow">
<div></div>
</div>
</div>
</form>
</body>
</html>