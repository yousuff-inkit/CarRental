<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.dashboard.analysis.collectionanalysis.ClsCollectionAnalysis"%>
<%ClsCollectionAnalysis DAO= new ClsCollectionAnalysis(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String group=request.getParameter("group")==null?"":request.getParameter("group");
     String distribution=request.getParameter("distribution")==null?"":request.getParameter("distribution");
     String hidclientcat=request.getParameter("hidclientcat")==null?"":request.getParameter("hidclientcat");
     String hidclient=request.getParameter("hidclient")==null?"":request.getParameter("hidclient");
     String hidsalesman=request.getParameter("hidsalesman")==null?"":request.getParameter("hidsalesman");
     String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
     String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
     String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
     String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom"); 
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
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

<style type="text/css">

/* ===========================================
   COLLECTION ANALYSIS PAGE - EXTRA CSS
   (Add below Master CSS)
=========================================== */

/* Section Heading */

.section-title{
    text-align:center;
    font-size:12px;
    font-weight:600;
    color:#4e5e71;
    margin-bottom:10px;
}

/* Search Buttons */

.myButtons1{
    width:28px;
    height:28px;
    border:none !important;
    border-radius:4px;
    background:#2563eb !important;
    color:#ffffff !important;
    font-size:18px;
    font-weight:bold;
    line-height:28px;
    text-align:center;
    cursor:pointer;
    padding:0;
    display:inline-block;
}

.myButtons1:hover{
    background:#1d4ed8 !important;
}

/* Search Details */

#searchdetails{
    width:100%;
    height:120px;
    resize:none;
    border:1px solid #ccd6e0 !important;
    border-radius:4px;
    background:#ffffff !important;
    padding:8px;
    font-size:12px;
    color:#333;
    font-family:inherit;
    box-sizing:border-box;
}

/* Totals Area */

.totals-bar{
    margin-top:10px;
    padding:10px 15px;
    background:#f8fafc;
    border:1px solid #e3e8ee;
    border-radius:8px;
    flex-shrink:0;
}

.totals-bar table{
    width:100%;
}

.totals-bar input[type="text"]{
    width:100%;
    height:24px !important;
    text-align:right;
    font-weight:bold;
    color:#000;
}

/* Grid */

#collectionDiv,
#analysisDiv{
    height:100%;
    background:#ffffff;
}

/* Hidden Grid */

#analysisDiv[hidden]{
    display:none !important;
}

/* Search Buttons Alignment */

.search-button-row{
    text-align:center;
    padding-top:6px;
}

/* Hidden Inputs */

input[type="hidden"]{
    display:none;
}

</style>
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
		 
		 $('#brandSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#brandSearchWindow').jqxWindow('close');
		   
		 $('#modelSearchWindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#modelSearchWindow').jqxWindow('close');
		   
		 $('#groupSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Group Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#groupSearchWindow').jqxWindow('close');
		  
		 $('#yomSearchWindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'YOM Search' ,position: { x: 250, y: 60 }, theme: 'energyblue', keyboardCloseKey: 27});
		 $('#yomSearchWindow').jqxWindow('close');
		
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	 		
	});
	
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
	
	function brandSearchContent(url) {
	    $('#brandSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#brandSearchWindow').jqxWindow('setContent', data);
		$('#brandSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function modelSearchContent(url) {
	    $('#modelSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#modelSearchWindow').jqxWindow('setContent', data);
		$('#modelSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function groupSearchContent(url) {
	    $('#groupSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#groupSearchWindow').jqxWindow('setContent', data);
		$('#groupSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function yomSearchContent(url) {
	    $('#yomSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#yomSearchWindow').jqxWindow('setContent', data);
		$('#yomSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function funExportBtn(){
		$("#collectionDiv").load("collectionGrid.jsp?branchval="+$('#cmbbranch').val()+"&fromdate="+$('#fromdate').val()+"&todate="+$('#todate').val()+"&hidclientcat="+$('#hidclientcat').val()+"&hidclient="+$('#hidclient').val()+"&hidsalesman="+$('#hidsalesman').val()+"&hidbrand="+$('#hidbrand').val()+"&hidmodel="+$('#hidmodel').val()+"&hidgroup="+$('#hidgroup').val()+"&hidyom="+$('#hidyom').val()+"&excelexport=EXCEL");
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
		        	  
		        	  var branch = $('#cmbbranch').val();
		     		  var fromdate = $('#fromdate').val();
		     		  var todate = $('#todate').val();
		     		  var group = $('#cmbgroup').val();
		     		  var distribution = $('#cmbdistribution').val();
		     		  var hidclientcat = $('#hidclientcat').val();
		     	      var hidclient = $('#hidclient').val();
		     	      var hidsalesman = $('#hidsalesman').val();
		     	      var hidbrand = $('#hidbrand').val();
		     	      var hidmodel = $('#hidmodel').val();
		     	      var hidgroup = $('#hidgroup').val();
		     	      var hidyom = $('#hidyom').val();
		        	  
		        	  $("#overlay, #PleaseWait").show();
		     		 
		        	  $("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&distribution="+distribution+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=2");
		          }
    		}
		}
		x.open("GET", "getGridColumnCalculation.jsp?fromdate="+fromdate+"&todate="+todate, true);
		x.send();
   }
	
	function funreload(event){
		 var branch = $('#cmbbranch').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var group = $('#cmbgroup').val();
		 var hidclientcat = $('#hidclientcat').val();
	     var hidclient = $('#hidclient').val();
	     var hidsalesman = $('#hidsalesman').val();
	     var hidbrand = $('#hidbrand').val();
	     var hidmodel = $('#hidmodel').val();
	     var hidgroup = $('#hidgroup').val();
	     var hidyom = $('#hidyom').val();

	     if(fromdate==todate) {
				$.messager.alert('Message','Not a Valid Period,From Date & To Date are Same.','warning');
				return;
         }

	     if($('#cmbgroup').val()!='' && $('#cmbdistribution').val()==''){
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		$("#analysisDiv").load("collectionAnalysisGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&group="+group+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&check=1");
	    		
	    } 
	     
	     else if($('#cmbdistribution').val()!=''){
	    		if($('#cmbdistribution').val()=='quarterwise'){
	    			var d1=$('#fromdate').jqxDateTimeInput('getDate');
	       		 	var d2=$('#todate').jqxDateTimeInput('getDate');
	       		 	months = (d2.getFullYear() - d1.getFullYear()) * 12;
	       		    months -= d1.getMonth() + 1;
	       		    months += d2.getMonth();
	       		    months=months <= 0 ? 0 : months;
	       		    
	       		    if(months<3){
	       		    	$.messager.alert('Message','Quarterwise Must Contain Minimum 3 Months.','warning');
	       		    	return false;
	       		    }
	    		}
	    		
	    		$("#overlay, #PleaseWait").show();$('#collectionDiv').hide();$('#analysisDiv').show();
	    		
	    		getGridColumnCalculation(fromdate,todate);
	    		
	    		//$("#analysisDiv").load("collectionAnalysisGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&grpby1="+grpby1+"&distribution="+cmbfrequency+"&check=1&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidrentalagent="+hidrentalagent);
	    	 }
	    	 else{
	    		 $("#overlay, #PleaseWait").show();$('#collectionDiv').show();$('#analysisDiv').hide();
	    		 
	    		 $("#collectionDiv").load("collectionGrid.jsp?branchval="+branch+"&fromdate="+fromdate+"&todate="+todate+"&hidclientcat="+hidclientcat+"&hidclient="+hidclient+"&hidsalesman="+hidsalesman+"&hidbrand="+hidbrand+"&hidmodel="+hidmodel+"&hidgroup="+hidgroup+"&hidyom="+hidyom);	 
	    	 }
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

	function getBrand(){
		brandSearchContent('brandSearch.jsp?id=1');
	}

	function getModel(){
		modelSearchContent('modelSearch.jsp?id=1');
	}

	function getGroup(event){
		 groupSearchContent('groupSearch.jsp?id=1');
	}
	
	function getYom(event){
		 yomSearchContent('yomSearch.jsp?id=1');
	}
	
	function setSearch(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			getClientCategory();
		}
		else if(value=="client"){
			getClient();
		}
		else if(value=="salesman"){
			getClientSalesman();
		}
		else if(value=="brand"){
			getBrand();
		}
		else if(value=="model"){
			getModel();
		}
		else if(value=="group"){
			getGroup();
		}
		else if(value=="yom"){
			getYom();
		}
		else{}
	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		
		if(value=="clientcat"){
			document.getElementById("searchdetails").value="";document.getElementById("clientcat").value="";document.getElementById("hidclientcat").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("client").value;
			
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			} */
			
		}
		else if(value=="client"){
			document.getElementById("searchdetails").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			} */		
		}
		else if(value=="salesman"){
			document.getElementById("searchdetails").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";

			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			/* if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}*/	
		}
		/* else if(value=="brand"){
			document.getElementById("searchdetails").value="";document.getElementById("brand").value="";document.getElementById("hidbrand").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="model"){
			document.getElementById("searchdetails").value="";document.getElementById("model").value="";document.getElementById("hidmodel").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="group"){
			document.getElementById("searchdetails").value="";document.getElementById("group").value="";document.getElementById("hidgroup").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("yom").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("yom").value;	
			}
		}
		else if(value=="yom"){
			document.getElementById("searchdetails").value="";document.getElementById("yom").value="";document.getElementById("hidyom").value="";
			
			document.getElementById("searchdetails").value=document.getElementById("clientcat").value;
			
			if(document.getElementById("client").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("client").value;	
			}
			if(document.getElementById("salesman").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("salesman").value;	
			}
			if(document.getElementById("brand").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("brand").value;	
			}
			if(document.getElementById("model").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("model").value;	
			}
			if(document.getElementById("group").value!=""){
				document.getElementById("searchdetails").value+="\n"+document.getElementById("group").value;	
			}
		} */
	}
	
	function funClearData(){
		$('#cmbbranch').val('a');
   	    $('#fromdate').val(new Date());
   	    var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	    var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	    var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	    $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
		$('#todate').val(new Date());
		  
		document.getElementById("searchdetails").value="";document.getElementById("searchby").value="";document.getElementById("clientcat").value="";
		document.getElementById("hidclientcat").value="";document.getElementById("client").value="";document.getElementById("hidclient").value="";
		document.getElementById("group").value="";document.getElementById("hidgroup").value="";document.getElementById("model").value="";
		document.getElementById("hidmodel").value="";document.getElementById("salesman").value="";document.getElementById("hidsalesman").value="";
		document.getElementById("yom").value="";document.getElementById("hidyom").value="";document.getElementById("brand").value="";
		document.getElementById("hidbrand").value="";
	}
	
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background"
     style="height:100%;overflow:hidden;box-sizing:border-box;">

<div class="hidden-scrollbar" style="height:100%;box-sizing:border-box;">

<table class="master-layout-table"
       width="100%"
       height="100%"
       cellpadding="0"
       cellspacing="0"
       border="0"
       style="background:#fff !important;table-layout:fixed;height:100%;">

<tr style="height:100%;">

<!-- ================= LEFT FILTER PANEL ================= -->

<td width="330px"
    valign="top"
    style="vertical-align:top;padding:0 !important;margin:0 !important;background:#fff !important;border-right:1px solid #e1e8ed;">

<div class="sidebar-filters">

<div class="sidebar-scroll-content">

<!-- Date -->

<div class="filter-card">

<table class="filter-table">

<tr>
<td class="label-cell">From</td>
<td>
<div id="fromdate"
     name="fromdate"
     value='<s:property value="fromdate"/>'></div>
</td>
</tr>

<tr>
<td class="label-cell">To</td>
<td>
<div id="todate"
     name="todate"
     value='<s:property value="todate"/>'></div>
</td>
</tr>

</table>

</div>

<!-- Group -->

<div class="filter-card">

<table class="filter-table">

<tr>
<td class="label-cell">Grouping</td>

<td>

<select name="cmbgroup" id="cmbgroup">

<option value="">--Select--</option>
<option value="clientcat">Client Category</option>
<option value="client">Client</option>
<option value="salesman">Salesman</option>

</select>

</td>

</tr>

<tr>

<td class="label-cell">Distribution</td>

<td>

<select name="cmbdistribution" id="cmbdistribution">

<option value="">--Select--</option>
<option value="1">Branchwise</option>
<option value="2">Monthwise</option>
<option value="3">Quarterwise</option>
<option value="4">Yearwise</option>
<option value="5">Client Category</option>
<option value="6">Salesman</option>

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
<option value="salesman">Salesman</option>

</select>

</td>

</tr>

<tr>

<td colspan="2" class="search-button-row">

<button type="button"
        id="additem"
        class="myButtons1"
        onclick="setSearch();">+</button>

&nbsp;&nbsp;

<button type="button"
        id="btnremoveitem"
        class="myButtons1"
        onclick="setRemove();">-</button>

</td>

</tr>

<tr>

<td colspan="2">

<textarea id="searchdetails"
          name="searchdetails"
          readonly="readonly"><s:property value="searchdetails"></s:property></textarea>

</td>

</tr>

</table>

</div>

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

<input type="hidden" name="clientcat" id="clientcat">
<input type="hidden" name="hidclientcat" id="hidclientcat">

<input type="hidden" name="client" id="client">
<input type="hidden" name="hidclient" id="hidclient">

<input type="hidden" name="group" id="group">
<input type="hidden" name="hidgroup" id="hidgroup">

<input type="hidden" name="model" id="model">
<input type="hidden" name="hidmodel" id="hidmodel">

<input type="hidden" name="salesman" id="salesman">
<input type="hidden" name="hidsalesman" id="hidsalesman">

<input type="hidden" name="yom" id="yom">
<input type="hidden" name="hidyom" id="hidyom">

<input type="hidden" name="brand" id="brand">
<input type="hidden" name="hidbrand" id="hidbrand">

</div>

</div>

</td>

<!-- ================= RIGHT PANEL ================= -->

<td valign="top"
    style="padding:15px;background:#ffffff !important;height:100%;">

<div style="display:flex;flex-direction:column;height:100%;box-sizing:border-box;">

<div style="width:100%;margin-bottom:10px;flex-shrink:0;">

<jsp:include page="../../heading.jsp"></jsp:include>

</div>

<div style="flex:1;overflow:auto;min-height:0;background:#fff;">

<div id="collectionDiv">
<jsp:include page="collectionGrid.jsp"></jsp:include>
</div>

<div id="analysisDiv" hidden="true">
<jsp:include page="collectionAnalysisGrid.jsp"></jsp:include>
</div>

<div class="totals-bar">

<table width="100%">

<tr>

<td align="right"
    style="font-size:13px;font-weight:bold;color:#000;">

Net Amount :

</td>

<td width="150">

<input type="text"
       id="txtnetamount"
       name="txtnetamount"
       readonly
       value='<s:property value="txtnetamount"/>'
       style="text-align:right;font-weight:bold;">

</td>

</tr>

</table>

</div>

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

<div id="brandSearchWindow">
    <div></div>
    <div></div>
</div>

<div id="modelSearchWindow">
    <div></div>
    <div></div>
</div>

<div id="groupSearchWindow">
    <div></div>
    <div></div>
</div>

<div id="yomSearchWindow">
    <div></div>
    <div></div>
</div>

</body>
</html>