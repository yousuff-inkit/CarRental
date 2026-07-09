<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

<style type="text/css">
/* ===== AGGRESSIVE OVERRIDES TO DESTROY BLUE BACKGROUNDS & HOVERS ===== */
html, body, #mainBG, .homeContent, .hidden-scrollbar {
    height: 100%;
    margin: 0 !important;
    padding: 0 !important;
    overflow: hidden !important;
    background-color: #ffffff !important;
    background: #ffffff !important;
    background-image: none !important;
    box-sizing: border-box;
}
/* Force layout tables to white */
.master-layout-table, .master-layout-table > tbody > tr, .master-layout-table > tbody > tr > td {
    background-color: #ffffff !important;
    background: #ffffff !important;
}
/* Forcefully kill all hover states on tables applied by external CSS */
table tr:hover, table td:hover, table th:hover, tbody tr:hover {
    background-color: transparent !important;
    background: transparent !important;
}

/* ===== MASTER LAYOUT ===== */
.sidebar-filters {
    width: 330px;
    background: #ffffff !important;
    height: 100%; 
    box-sizing: border-box;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

/* Inline Flow CSS - Buttons naturally follow the inputs */
.sidebar-scroll-content {
    height: 100%;
    overflow-y: auto;
    padding: 15px 20px !important;
    box-sizing: border-box;
}

.sidebar-fixed-bottom {
    margin-top: 15px;
    padding: 0;
    background: transparent;
}

/* Cards */
.filter-card {
    background: #f8fafc !important;
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 15px; 
    margin-bottom: 12px;
}
/* Tables within the card */
.filter-table {
    width: 100%;
    border-spacing: 0 10px; 
    background: transparent !important;
}
.filter-table tr, .filter-table td {
    background: transparent !important;
    border: none !important;
}
.filter-table .label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    color: #4e5e71;
    font-weight: 600;
    width: 90px;
    white-space: nowrap; 
}
/* ===== UNIFORM 24px INPUTS & SELECTS ===== */
input[type="text"], select, .filter-table input[type="text"], .filter-table select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff !important;
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
input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: pointer;
}
/* ===== BUTTONS ===== */
.button-group {
    display: flex;
    gap: 10px;
    justify-content: center;
}
.btn-submit, .myButton, .myButtons {
    flex: 1;
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
    text-align: center;
    transition: background 0.2s;
    width: 100%;
    margin-top: 0;
}
.btn-submit:hover, .myButton:hover, .myButtons:hover { background: #1d4ed8 !important; }
.btn-submit:disabled, .myButton:disabled, .myButtons:disabled { background: #9ca3af !important; cursor: not-allowed; }

/* ---------- Report Type Heading ---------- */

.section-title{
    text-align:center;
    font-size:12px;
    font-weight:600;
    color:#4e5e71;
    margin-bottom:10px;
}

/* ---------- Radio Buttons ---------- */

.radio-cell{
    font-size:12px;
    color:#333;
    white-space:nowrap;
}

.radio-cell input[type="radio"]{
    vertical-align:middle;
    margin-right:5px;
}

.radio-cell label{
    font-size:12px;
    cursor:pointer;
    color:#333;
}

/* ---------- Search Textarea ---------- */

textarea#searchdetails{
    width:100%;
    height:90px;
    resize:none;
    padding:8px;
    border:1px solid #ccd6e0 !important;
    border-radius:4px;
    background:#ffffff;
    font-size:12px;
    box-sizing:border-box;
    font-family:inherit;
    color:#333;
}

/* ---------- + / - Buttons ---------- */

.myButtons1{
    width:28px;
    height:28px;
    border:none !important;
    border-radius:4px;
    background:#2563eb !important;
    color:#ffffff !important;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;
    line-height:28px;
    padding:0;
}

.myButtons1:hover{
    background:#1d4ed8 !important;
}
</style>
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		   
		 $('#clientSearchWindow').jqxWindow({ width: '62%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' , title: 'Client Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientSearchWindow').jqxWindow('close');
		 
		 $('#clientCategorySearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Category Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientCategorySearchWindow').jqxWindow('close');
		
		 $('#salesmanSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Salesman Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#salesmanSearchWindow').jqxWindow('close');
		
		 $('#clientStatusSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Client Status Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#clientStatusSearchWindow').jqxWindow('close');
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	   
	     /* $(".chcksummary").click(function() {
	 	        selectedBox = this.id;

	 	        $(".chcksummary").each(function() {
	 	            if ( this.id == selectedBox )
	 	            {
	 	                this.checked = true;
	 	            }
	 	            else
	 	            {
	 	                this.checked = false;
	 	            };        
	 	        });
	 	    });     */
	 		 
	     document.getElementById("rdall").checked=true;
	});
	
	function funExportBtn(){
	   /*  JSONToCSVConvertor(dataExcelExport, 'ClientAnalysis', true); */
	    $("#analysisDiv").excelexportjs({
			containerid: "analysisDiv",   
			datatype: 'json',
			dataset: null,
			gridId: "abcAnalysisGrid",
			columns: getColumns("abcAnalysisGrid") ,   
			worksheetName:"Client Analysis"  
		});   
	} 
	
	function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
		
	    var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
	    
	    var CSV = '';    
	    
	    CSV += ReportTitle + '\r\n\n';

	    //This condition will generate the Label/Header
	    if (ShowLabel) {
	        var row = "";
	        
	        //This loop will extract the label from 1st index of on array
	        for (var index in arrData[0]) {
	            
	            //Now convert each value to string and comma-seprated
	            row += index + ',';
	        }

	        row = row.slice(0, -1);
	        
	        //append Label row with line break
	        CSV += row + '\r\n';
	    }
	    
	    //1st loop is to extract each row
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        
	        //2nd loop will extract each column and convert it in string comma-seprated
	        for (var index in arrData[i]) {
	            row += '"' + arrData[i][index] + '",';
	        }

	        row.slice(0, row.length - 1);
	        
	        //add a line break after each row
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {        
	        alert("Invalid data");
	        return;
	    }   
	    
	    //Generate a file name
	    var fileName = "";
	    //this will remove the blank-spaces from the title and replace it with an underscore
	    fileName += ReportTitle.replace(/ /g,"_");   
	    
	    //Initialize file format you want csv or xls
	    var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
	    
	    // Now the little tricky part.
	    // you can use either>> window.open(uri);
	    // but this will not work in some browsers
	    // or you will not get the correct file extension    
	    
	    //this trick will generate a temp <a /> tag
	    var link = document.createElement("a");    
	    link.href = uri;
	    
	    //set the visibility hidden so it will not effect on your web-layout
	    link.style = "visibility:hidden";
	    link.download = fileName + ".csv";
	    
	    //this part will append the anchor tag and remove it after automatic click
	    document.body.appendChild(link);
	    link.click();
	    document.body.removeChild(link);
	}
	
	function getGridColumnCalculation(fromdate,todate){
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				 items = items.split('***');
		          var difference=items[0];
		          var columns=items[1];
		          
		          if(parseInt(columns)==1) {
						$.messager.alert('Message','Period is too Long,Limit Reached.','warning');
						return;
		          }else {
		        	  
		        	  var branchval = document.getElementById("cmbbranch").value;
		        	  var summarytype = $('#cmbsummarytype').val();
		        	  var hidclientcat=document.getElementById("hidclientcat").value;
		        	  var hidclient=document.getElementById("hidclient").value;
		        	  var hidclientslm=document.getElementById("hidclientslm").value;
					  var hidclientstatus=document.getElementById("hidclientstatus").value;
		        	  
		     		  var check=1;
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  if(document.getElementById("rdall").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=1&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }else if(document.getElementById("rdsummary").checked==true){
		        	  		$("#analysisDiv").load("abcAnalysisGrid.jsp?rptType=2&branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&summarytype='+summarytype+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidclientslm="+hidclientslm+"&hidclientstatus="+hidclientstatus+'&check='+check);
		        	  }
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	/* function clientcheck(){
		if(document.getElementById("chckclient").checked){
			 document.getElementById("hidchckclient").value = 1;document.getElementById("hidchckcategory").value = 0;
		 }
		 else{
			 document.getElementById("hidchckclient").value = 0;
		 }
	 } */
	
	/* function categorycheck(){
		if(document.getElementById("chckcategory").checked){
			 document.getElementById("hidchckcategory").value = 1;document.getElementById("hidchckclient").value = 0;
		 }
		 else{
			 document.getElementById("hidchckcategory").value = 0;
		 }
	 } */
	
	function summaryDisable(){
		if(document.getElementById("rdall").checked==true){
			$('#cmbsummarytype').attr('disabled', true);
		}else if(document.getElementById("rdsummary").checked==true){
			$('#cmbsummarytype').attr('disabled', false);
		}
	}
	
	function funreload(event){
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }
		 
		 if(document.getElementById("rdsummary").checked==true){
		 	if($('#cmbsummarytype').val()=='') {
				$.messager.alert('Message','Please Choose a Summary Type.','warning');
				return;
		 	}
         }
		 
		 getGridColumnCalculation(fromdate,todate);
	}
	
	function clientSearchContent(url) {
	    $('#clientSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientSearchWindow').jqxWindow('setContent', data);
		$('#clientSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientCategorySearchContent(url) {
	    $('#clientCategorySearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientCategorySearchWindow').jqxWindow('setContent', data);
		$('#clientCategorySearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function salesmanSearchContent(url) {
	    $('#salesmanSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#salesmanSearchWindow').jqxWindow('setContent', data);
		$('#salesmanSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function clientStatusSearchContent(url) {
	    $('#clientStatusSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientStatusSearchWindow').jqxWindow('setContent', data);
		$('#clientStatusSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(){
	 	 clientSearchContent('clientSearch.jsp');
	}

	function getClientCategory(){
		 clientCategorySearchContent('clientCategorySearch.jsp?id=1');
	}
	
	function getClientSalesman(){
		salesmanSearchContent('clientSalesManSearch.jsp?id=2');
	}

	function getClientStatus(){
		clientStatusSearchContent('clientStatusSearch.jsp?id=3');
	}
	
	function setSearch(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="clientslm"){
			getClientSalesman();
		}
		else if(value=="clientstatus"){
			getClientStatus();
		}
		else{}
	}
	
	function setRemove(){
		
		var value=$('#searchby').val().trim();
		
		if(value=="client"){
			document.getElementById("searchdetails").value="";
			document.getElementById("client").value="";
			document.getElementById("hidclient").value="";
			if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientcat"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientcat").value="";
			document.getElementById("hidclientcat").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientslm"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientslm").value="";
			document.getElementById("hidclientslm").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientstatus").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientstatus").value; 
			}
		} else if(value=="clientstatus"){
			document.getElementById("searchdetails").value="";
			document.getElementById("clientstatus").value="";
			document.getElementById("hidclientstatus").value="";
			if(document.getElementById("client").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("client").value; 
			} if(document.getElementById("clientcat").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientcat").value; 
			} if(document.getElementById("clientslm").value!=""){
				   document.getElementById("searchdetails").value+=document.getElementById("clientslm").value; 
			} 
		}
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		
		document.getElementById("rdall").checked=true;		
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("clientslm").value="";document.getElementById("hidclientslm").value="";document.getElementById("clientstatus").value="";
		document.getElementById("hidclientstatus").value="";
		summaryDisable();
	}
	
</script>
</head>
<body onload="getBranch();summaryDisable();">

<div id="mainBG" class="homeContent" data-type="background" style="height:100%;overflow:hidden;box-sizing:border-box;">

    <div class="hidden-scrollbar" style="height:100%;box-sizing:border-box;">

        <table class="master-layout-table" width="100%" height="100%" cellpadding="0" cellspacing="0" border="0" style="background:#ffffff !important;table-layout:fixed;height:100%;">

            <tr style="height:100%;">

                <!-- LEFT FILTER PANEL -->
                <td width="330px" valign="top" style="vertical-align:top;padding:0 !important;margin:0 !important;background:#ffffff !important;border-right:1px solid #e1e8ed;height:100%;">

                    <div class="sidebar-filters">

                        <div class="sidebar-scroll-content">

                            <!-- Date -->
                            <div class="filter-card">
                                <table class="filter-table">
                                    <tr>
                                        <td class="label-cell">From</td>
                                        <td>
                                            <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label-cell">To</td>
                                        <td>
                                            <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                                        </td>
                                    </tr>
                                </table>
                            </div>

                            <!-- Report Type -->
                            <div class="filter-card">

                                <div class="section-title">Report Type</div>

                                <table class="filter-table">

                                    <tr>
                                        <td colspan="2" class="radio-cell">
                                            <input type="radio" id="rdall" name="rdo" onclick="summaryDisable();" value="rdall">
                                            <label for="rdall">All</label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="radio-cell" style="width:40%;">
                                            <input type="radio" id="rdsummary" name="rdo" onclick="summaryDisable();" value="rdsummary">
                                            <label for="rdsummary">Summary</label>
                                        </td>

                                        <td style="width:60%;">
                                            <select id="cmbsummarytype" name="cmbsummarytype" onchange="clearAccountInfo();" value='<s:property value="cmbsummarytype"/>'>
                                                <option value="">--Select--</option>
                                                <option value="CRM">Client</option>
                                                <option value="CAT">Client Category</option>
                                                <option value="PCASE">Client Status</option>
                                                <option value="SLM">Salesman</option>
                                            </select>
                                        </td>
                                    </tr>

                                </table>

                            </div>

                            <!-- Search -->
                            <div class="filter-card">

                                <table class="filter-table">

                                    <tr>
                                        <td class="label-cell">Search By</td>
                                        <td>
                                            <select name="searchby" id="searchby">
                                                <option value="">--Select--</option>
                                                <option value="client">Client</option>
                                                <option value="clientcat">Client Category</option>
                                                <option value="clientstatus">Client Status</option>
                                                <option value="clientslm">Salesman</option>
                                            </select>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" style="padding-top:8px;text-align:center;">

                                            <button type="button"
                                                    id="additem"
                                                    class="myButtons1"
                                                    onclick="setSearch();">+</button>

                                            &nbsp;

                                            <button type="button"
                                                    id="btnremoveitem"
                                                    class="myButtons1"
                                                    onclick="setRemove();">-</button>

                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" style="padding-top:10px;">

                                            <textarea id="searchdetails"
                                                      name="searchdetails"
                                                      readonly="readonly"><s:property value="searchdetails"></s:property></textarea>

                                        </td>
                                    </tr>

                                </table>

                            </div>

                            <!-- Button -->
                            <div class="sidebar-fixed-bottom">

                                <div class="button-group">

                                    <input type="button"
                                           name="btnclear"
                                           id="btnclear"
                                           value="Clear"
                                           class="myButtons"
                                           onclick="funClearData();">

                                </div>

                            </div>

                            <!-- Hidden Fields -->

                            <input type="hidden" name="client" id="client">
                            <input type="hidden" name="hidclient" id="hidclient">

                            <input type="hidden" name="clientcat" id="clientcat">
                            <input type="hidden" name="hidclientcat" id="hidclientcat">

                            <input type="hidden" name="clientstatus" id="clientstatus">
                            <input type="hidden" name="hidclientstatus" id="hidclientstatus">

                            <input type="hidden" name="clientslm" id="clientslm">
                            <input type="hidden" name="hidclientslm" id="hidclientslm">

                        </div>

                    </div>

                </td>

                <!-- RIGHT PANEL -->

                <td valign="top" style="padding:15px;background:#ffffff !important;height:100%;">

                    <div style="display:flex;flex-direction:column;height:100%;box-sizing:border-box;">

                        <div style="width:100%;margin-bottom:10px;flex-shrink:0;">
                            <jsp:include page="../../heading.jsp"></jsp:include>
                        </div>

                        <div id="analysisDiv"
                             style="flex:1;overflow:auto;min-height:0;background:#ffffff;">

                            <div id="delupdiv"></div>

                            <jsp:include page="abcAnalysisGrid.jsp"></jsp:include>

                        </div>

                    </div>

                </td>

            </tr>

        </table>

    </div>

</div>

<div id="clientSearchWindow">
    <div></div>
    <div></div>
</div>

<div id="clientCategorySearchWindow">
    <div></div>
    <div></div>
</div>

<div id="salesmanSearchWindow">
    <div></div>
    <div></div>
</div>

<div id="clientStatusSearchWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>