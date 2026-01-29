
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
 
	 $("#nonrevenuedate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
    
    
});


function funreload(event)
{

	 var barchval = document.getElementById("cmbbranch").value;
	 var exdate = $('#nonrevenuedate').val();
 
	  $("#nondiv").load("nonrevenueGrid.jsp?barchval="+barchval+'&exdate='+exdate);
	
	
	}
	
function funExportBtn(){
$("#nondiv").excelexportjs({
	containerid: "nondiv", 
	datatype: 'json', 
	dataset: null, 
	gridId: "nonmovement", 
	columns: getColumns("nonmovement") ,   
	worksheetName:"Non Revenue Movement"
	});
}

</script>

<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
    }

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

    /* Cleaned Cards - Stripping legacy backgrounds */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 10px;
    }

    /* HARD RESET: Force black fonts and remove unwanted backgrounds */
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

    /* RHS Visibility & Scrollbar Kill */
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

    .branch { font-size: 13px; font-weight: 600; }

    /* Chart Container Styling */
    #pieChart1 {
        background-color: #ffffff !important;
        border-radius: 8px;
        border: 1px solid #e3e8ee;
        margin-top: 20px;
    }
</style>
</head>
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
                            <div id="nonrevenuedate" name="nonrevenuedate" value='<s:property value="nonrevenuedate"/>'></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div id='pieChart1' style="width: 100%; height: 170px;"></div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="nondiv">
                <jsp:include page="nonrevenueGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

</div>
</div>
</body>
</html>