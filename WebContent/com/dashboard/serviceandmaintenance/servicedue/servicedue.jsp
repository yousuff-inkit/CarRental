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

<script type="text/javascript">

	$(document).ready(function () {
		 
		 
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		
	     
	    
	});
	
	
	
	function inspectionSearchContent(url) {
		 $('#inspectionWindow').jqxWindow('focus'); 
		 $.get(url).done(function (data) {
		 $('#inspectionWindow').jqxWindow('setContent', data);
		}); 
		}
	 
	
	
	function funreload(event){
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var avgkm = document.getElementById("avgkm").value;
		
		 var uptodate = $('#uptodate').val();
		 
		 if(avgkm==""){
			 $.messager.alert('Message','Please Enter Avg KM/Month','warning');
			 return 0;
		 }

		$("#overlay, #PleaseWait").show();
		 
		
	          $("#servicedueDiv").load("servicedueGrid.jsp?branchval="+branchval+'&avgkm='+avgkm+'&uptodate='+uptodate);
		 
		}
	
	
	  /*  
	    function funExportBtn(){
	    	var type = $('#cmbtype').val();
	    	  
			   if(type==1)
			   {
				   JSONToCSVCon(summaryexceldata, 'Vehicle sale Invoice List(Summary)', true);
	 		 
			   }
			    
			   else
			   {
			
				   JSONToCSVCon(detailexceldata, 'Vehicle sale Invoice List(Detail)', true);
	 		 
			   }
	 }  */
	 function funExportBtn(){
			$("#servicedueDiv").excelexportjs({
				containerid: "servicedueDiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "servicedueGrid", 
				columns: getColumns("servicedueGrid") ,   
				worksheetName:"Service Due List"
				});
			
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
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">

    <!-- LEFT SIDE -->
    <div class="sidebar-filters" style="width:20%; min-width:280px;">

        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">

            <div class="filter-card">

                <table class="filter-table">

                    <tr>
                        <td class="label-cell">
                            <label class="branch">Up To</label>
                        </td>

                        <td>
                            <div id="uptodate" 
                                 name="uptodate" 
                                 value='<s:property value="uptodate"/>'>
                            </div>
                        </td>
                    </tr>


                    <tr>
                        <td class="label-cell">
                            <label class="branch">Avg KM/Month</label>
                        </td>

                        <td>

                            <input type="text"
                                   name="avgkm"
                                   id="avgkm"
                                   value='<s:property value="avgkm"/>'>

                        </td>
                    </tr>

                </table>

            </div>

        </div>

    </div>



    <!-- RIGHT SIDE -->
    <div class="main-content-wrapper">

        <div class="scrollable-grid-area">

            <div id="servicedueDiv">

                <jsp:include page="servicedueGrid.jsp"></jsp:include>

            </div>

        </div>

    </div>

</div>
</div>


</div> 
</body>
</html>