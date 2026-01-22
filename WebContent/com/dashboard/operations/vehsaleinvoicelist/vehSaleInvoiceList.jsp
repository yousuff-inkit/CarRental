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
		 
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 
		 $('#inspectionWindow').jqxWindow({ autoOpen: false,width: '78%', height: '85%',  maxHeight: '85%' ,maxWidth: '78%' , title: 'Inspection Details' , theme: 'energyblue', position: { x: 280, y: 10 }, keyboardCloseKey: 27, showCloseButton: true,closeButtonAction:'hide'});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	    
	});
	
	
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	 
	
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var type = $('#cmbtype').val();
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 
		 if(type==''){
			 $.messager.alert('Message','Please Choose a Type','warning');
			 return 0;
		 }

		$("#overlay, #PleaseWait").show();
		 
		 if(type==1){
			 $("#detailDiv").prop("hidden", true);
	       	 $("#summaryDiv").prop("hidden", false);
	          $("#summaryDiv").load("summaryGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
		 }
		 else{
			 $("#summaryDiv").prop("hidden", true); 
	      	 $("#detailDiv").prop("hidden", false);
	     
	          $("#detailDiv").load("detailGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&check=1');
		 }
		}
	
	
	   
	    function funExportBtn(){
	    	var type = $('#cmbtype').val();
	    	  
			   if(type==1)
			   {
				   // JSONToCSVCon(summaryexceldata, 'Vehicle sale Invoice List(Summary)', true);

			        $("#summarydiv").excelexportjs({
							containerid: "summarydiv",   
							datatype: 'json',
							dataset: null,
							gridId: "summary",
							columns: getColumns("summary") ,   
							worksheetName:"Vehicle sale Invoice List(Summary)"  
						});   
			   }
			    
			   else
			   {
			
				   // JSONToCSVCon(detailexceldata, 'Vehicle sale Invoice List(Detail)', true);
	 		 

			        $("#detailDiv").excelexportjs({
							containerid: "detailDiv",   
							datatype: 'json',
							dataset: null,
							gridId: "detailGrid",
							columns: getColumns("detailGrid") ,   
							worksheetName:"Vehicle sale Invoice List(Detail)"  
						});   
				   
			   }
	 } 
	
</script>
</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">From</td>
                <td>
                    <div id="fromdate" name="fromdate"
                         value='<s:property value="fromdate"/>'>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">To</td>
                <td>
                    <div id="todate" name="todate"
                         value='<s:property value="todate"/>'>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Type</td>
                <td>
                    <select id="cmbtype" name="cmbtype"
                            value='<s:property value="cmbtype"/>'>
                        <option value="1">Summary</option>
                        <option value="2">Detail</option>
                    </select>
                </td>
            </tr>

        </table>
        </div>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>

        <div id="summaryDiv">
            <jsp:include page="summaryGrid.jsp"></jsp:include>
        </div>

        <div id="detailDiv" hidden="true">
            <jsp:include page="detailGrid.jsp"></jsp:include>
        </div>

    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<!-- POPUP WINDOW -->
<div id="inspectionWindow">
    <div></div>
</div>

</div>
</body>

</html>