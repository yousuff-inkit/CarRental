
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	
	 $("#insuexpdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	  $('#invcomSearchwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Insurance Company Search' ,position: { x: 600, y: 60 }, keyboardCloseKey: 27});
	    $('#invcomSearchwindow').jqxWindow('close');

   
});


function funExportBtn(){
	$("#insuexp").excelexportjs({
		containerid: "insuexp", 
		datatype: 'json', 
		dataset: null, 
		gridId: "insexpgrid", 
		columns: getColumns("insexpgrid") ,   
		worksheetName:"Insurance Expiry"
		});
}
function inscompanySearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#invcomSearchwindow').jqxWindow('open');
		$('#invcomSearchwindow').jqxWindow('setContent', data);

	}); 
	}  

function funreload(event)
{
	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#insuexpdate').val();
 
	  $("#insuexp").load("insuranceExpairyGrid.jsp?barchval="+barchval+'&exdate='+exdate);
	
	
	}


function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
		  
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}


</script>
</head>
<style type="text/css">
    /* Force high-visibility and reset legacy backgrounds */
    html, body {
        height: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
        background-color: #f4f7f9;
    }

    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        width: 100%;
        height: 100vh !important;
        color: black !important;
    }

    /* Sidebar Structure */
    .sidebar-filters {
        width: 330px; 
        flex: 0 0 330px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Card Styling */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 10px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 12px;
        font-size: 13px;
        font-weight: 600;
        width: 85px;
    }

    /* RHS Grid Area & Scroll Fix */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 330px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        overflow-x: hidden !important; 
        padding: 20px;
    }

    /* Chart Container */
    #pieChart1 {
        background-color: #ffffff !important;
        border: 1px solid #e3e8ee;
        border-radius: 8px;
        margin-top: 20px;
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
<body onload="getBranch();">
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
                        <td class="label-cell">Up To</td>
                        <td>
                            <div id="insuexpdate" name="insuexpdate" value='<s:property value="insuexpdate"/>'></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div id='pieChart1' style="width: 100%; height: 170px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="insuexp">
                <jsp:include page="insuranceExpairyGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
	 <div id="invcomSearchwindow">
	   <div></div>
	</div> 
	
</div>
</body>
</html>