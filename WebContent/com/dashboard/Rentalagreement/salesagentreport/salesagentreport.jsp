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
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; /* UNIFORM FONT */
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
    font-size: 12px; /* Uniform 12px label */
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

input[readonly], input:disabled, select:disabled {
    background-color: #f3f6f9 !important;
    color: #555;
    cursor: not-allowed;
}

/* ===== BUTTONS ===== */
.btn-submit, .myButton {
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

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

.btn-submit:disabled, .myButton:disabled {
    background: #9ca3af !important;
    cursor: not-allowed;
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

legend {
    font-size: 11px;
    font-weight: bold;
    color: #2563eb;
    text-transform: uppercase;
    margin-bottom: 5px;
}

fieldset {
    border: 1px solid #e3e8ee;
    border-radius: 8px;
    padding: 10px;
    margin: 0;
}

/* Strips inherited green background */
.sidebar-filters label.branch, 
.sidebar-filters .filter-card label,
.sidebar-filters .branch {
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    background: transparent !important;
}
</style>
  

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#agentWindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Sales Agent Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#agentWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '50%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  
});

	function agentSearchContent(url) {
	    $('#agentWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agentWindow').jqxWindow('setContent', data);
		$('#agentWindow').jqxWindow('bringToFront');
	}); 
	}
	
	    
	function getrental()
	{

		 $('#agreementDetailsWindow').jqxWindow('open');
			$('#agreementDetailsWindow').jqxWindow('focus');
			agreementSearchContent('agreementDetailsSearch.jsp', $('#agreementDetailsWindow'));
		
		}

	function getsalesagent()
	{

		 $('#agentWindow').jqxWindow('open');
			$('#agentWindow').jqxWindow('focus');
			agentSearchContent('salesagentSearch.jsp', $('#agentWindow'));
		
		}

	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
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
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 var clstatuss = document.getElementById("clstatuss").value; 
		 var hidrag = document.getElementById("hidrag").value;
		 var hidsag = document.getElementById("hidsag").value;
		 
		 var type = document.getElementById("type").value; 
			if(type=="summary")
				{
		   $("#overlay, #PleaseWait").show();
		 $("#summarydiv").load("summarygrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+"&hidrag="+hidrag+"&hidsag="+hidsag+"&clstatuss="+clstatuss);
			   
				}
			else
				{
				
				
				 $("#overlay, #PleaseWait").show();
				 $("#detaildiv").load("detailsgrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&type='+type+"&hidrag="+hidrag+"&hidsag="+hidsag+"&clstatuss="+clstatuss);
				
				}
			
			
			
			   }
			   }
	 
	function funClearData(){
		$('input[type=text],[type=hidden]').val('');
		$('input[type=radio]').prop("checked", false);
		$('textarea').val('');
		$('#type').val('summary');
		
		
		$('#clstatuss').val('');
		$('#searchby').val('');
		 
	} 
	function changegrid()
	{
		 var type = document.getElementById("type").value;
		if(type=="summary")
			{
			  $("#detaildiv").hide();
			  $("#summarydiv").show(); 
			   
			  
			  $("#detailgrid").jqxGrid('clear');
		      $("#detailgrid").jqxGrid('addrow', null, {});
		      
			  
			   $("#summarygrid").jqxGrid('clear');
		      $("#summarygrid").jqxGrid('addrow', null, {});
		      
		      
			}
		else
			{
		
			  $("#detaildiv").show();
			  $("#summarydiv").hide(); 
			   
			  
			  $("#detailgrid").jqxGrid('clear');
		      $("#detailgrid").jqxGrid('addrow', null, {});
		      
			  
			   $("#summarygrid").jqxGrid('clear');
		      $("#summarygrid").jqxGrid('addrow', null, {});
			}
		
		}

	function setSearch(){
		var value=$('#searchby').val().trim();
 
		 
         if(value=="RAG"){     
			getrental();
		}
		else if(value=="SAG"){
			getsalesagent();
		}
		 
		 
		
		else{
			
		}



	}
	
	function setRemove(){
		var value=$('#searchby').val().trim();
		 
		if(value=="RAG"){  
			
			document.getElementById("searchdetails").value="";
			document.getElementById("rag").value="";
			document.getElementById("hidrag").value="";
			
		}
		if(value=="SAG"){
			document.getElementById("searchdetails").value="";
			document.getElementById("sag").value="";
			document.getElementById("hidsag").value="";
		}
		
	 
		 
		
		if(document.getElementById("rag").value!=""){
			
		var	text = document.getElementById("rag").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
		}
		if(document.getElementById("sag").value!=""){
			
			
			var	text = document.getElementById("sag").value.split("::").join("\n");
			
			document.getElementById("searchdetails").value+="\n\n"+text;	
			 
		}
		
		
 
	
 
	}
	function funExportBtn(){
		
		 var type = document.getElementById("type").value;
			if(type=="summary")
				{
				
				
				 
		   $("#summarygrid").jqxGrid('exportdata', 'xls', 'Sales Agent Report ');
		 
		
				}
			else
				{
				
				 JSONToCSVConvertor(exceldata, 'Sales Agent Report ', true);
				
				 
				}
		     
		  /*  

		   JSONToCSVConvertor(invoiceexceldata, 'Invoices List', true); */
		   }
		  
		  
	  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
 
		      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		   
		      var CSV = '';    
		  
		      
		      CSV += ReportTitle + '\r\n\n';

		 
		      if (ShowLabel) {
		          var row = "";
		          
		          
		          for (var index in arrData[0]) {
		              
		            
		              row += index + ',';
		          }

		          row = row.slice(0, -1);
		          
		          
		          CSV += row + '\r\n';
		      }
		      
 
		      for (var i = 0; i < arrData.length; i++) {
		          var row = "";
		      
		          for (var index in arrData[i]) {
		              row += '"' + arrData[i][index] + '",';
		          }

		          row.slice(0, row.length - 1);
		       
		          CSV += row + '\r\n';
		      }

		      if (CSV == '') {        
		          alert("Invalid data");
		          return;
		      }   
		      
		 
		      var fileName = "";
	 
		      fileName += ReportTitle.replace(/ /g,"_");   
		      
		      
		      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		      
		    
		      var link = document.createElement("a");    
		      link.href = uri;
		      
		      
		      link.style = "visibility:hidden";
		      link.download = fileName + ".csv";
		 
		      document.body.appendChild(link);
		      link.click();
		      document.body.removeChild(link);
		  }
	
	  
	
	
	
	
	

</script>
<style>
.myButtons {
	-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
	box-shadow:inset 0px -1px 3px 0px #91b8b3;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
	background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
	background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
	background-color:#768d87;
	border:1px solid #566963;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	
	font-size:8pt;
	
	padding:3px 17px;
	text-decoration:none;
	text-shadow:0px -1px 0px #2b665e;
}
.myButtons:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
	background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
	background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
	background-color:#6c7c7c;
}
 .myButtons:active {
	position:relative;
	top:1px;
}

     
  

</style>

</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
<tr>

<td width="330px" valign="top">

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
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="type" onchange="changegrid()">
                                <option value="summary">Summary</option>
                                <option value="detail">Detail</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="clstatuss" name="clstatuss" value='<s:property value="clstatuss"/>'>
                                <option value="">--Select--</option>
                                <option value="0">Open</option>
                                <option value="1">Close</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Filter</td>
                        <td>
                            <div style="display: flex; gap: 4px; align-items: center;">
                                <select name="searchby" id="searchby" style="flex: 1;">
                                    <option value="">--Select--</option>
                                    <option value="RAG">Rental Agreement</option>  
                                    <option value="SAG">Sales Agent</option>
                                </select>
                                <button type="button" name="btnadditem" id="additem" class="btn-submit" style="width: auto; padding: 0 10px; margin: 0; height: 24px !important; line-height: 22px !important;" onClick="setSearch();">+</button>
                                <button type="button" name="btnremoveitem" id="btnremoveitem" class="btn-submit btn-danger" style="width: auto; padding: 0 10px; margin: 0; height: 24px !important; line-height: 22px !important; background: #ef4444 !important;" onclick="setRemove();">-</button>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <textarea id="searchdetails" name="searchdetails" style="width: 100%; height: 250px; resize: none; font-family: 'Segoe UI', Tahoma, sans-serif; font-size: 12px; padding: 8px; border: 1px solid #ccd6e0; border-radius: 4px; box-sizing: border-box; background-color: #f3f6f9;" readonly></textarea>
                
                <button type="button" name="btnclear" id="btnclear" class="btn-submit" onclick="funClearData();">
                    Clear
                </button>
            </div>

            <div style="display:none;">
                <input type="hidden" name="hidrag" id="hidrag">
                <input type="hidden" name="hidsag" id="hidsag">
                <input type="hidden" name="rag" id="rag">
                <input type="hidden" name="sag" id="sag">
            </div>

        </div>
    </div>

</td>

<td valign="top">
    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            
            <table width="100%"> 
                <tr>
                    <td>
                        <div id="summarydiv">
                            <jsp:include page="summarygrid.jsp"></jsp:include>
                        </div>
                        
                        <div id="detaildiv" style="display:none;">
                            <jsp:include page="detailsgrid.jsp"></jsp:include>
                        </div>
                    </td>
                </tr>
            </table>

        </div>
    </div>
</td>

</tr>
</table>

</div>

<div id="agentWindow">
    <div></div><div></div>
</div>
<div id="agreementDetailsWindow">
    <div></div><div></div>
</div>

</div> 
</div>
</body>
</html>