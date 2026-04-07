 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
 
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%> 
<style>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

</style>

	<script type="text/javascript">
	$(document).ready(function () {
		 $("#searchdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy",value:null});
		getGroup();
		getColor();
	
	}); 
function getGroup() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var groupItems = items[0].split(",");
				var groupIdItems = items[1].split(",");
			
				var optionsgroup = '<option value="">--Select--</option>';
				for (var i = 0; i < groupItems.length; i++) {
					optionsgroup += '<option value="' + groupIdItems[i] + '">'
							+ groupItems[i] + '</option>';
				}
		
				$("select#searchgroup").html(optionsgroup);
				
				
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getGroup.jsp", true);
		x.send();
	}
	
	
	function getColor() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				//alert(items);
				items = items.split('####');
				var colorItems = items[0].split(",");
				var colorIdItems = items[1].split(",");
				var optionscolor = '<option value="">--Select--</option>';
				for (var i = 0; i < colorItems.length; i++) {
					optionscolor += '<option value="' + colorIdItems[i] + '">'
							+ colorItems[i] + '</option>';
				}
				$("select#searchcolor").html(optionscolor);
			} else {
			}
		}
		x.open("GET", "../../../../com/controlcentre/masters/vehiclemaster/getColor.jsp", true);
		x.send();
	}
 	function mainloadSearch() {
 		
 		//var client=document.getElementById("searchclient").value;
 	//	var reftype=document.getElementById("cmbsearchrtype").value;
 		var searchdate=$('#searchdate').jqxDateTimeInput('val');
 		//var agmtno=document.getElementById("searchagmtno").value;
 		var fleetno=document.getElementById("searchfleetno").value;
 		var docno=document.getElementById("searchdocno").value;
 		var regno=document.getElementById("searchregno").value;
 		//var status=document.getElementById("cmbsearchstatus").value;
		var color=document.getElementById("searchcolor").value;
		var group=document.getElementById("searchgroup").value;
 		var branch=document.getElementById("brchName").value;
		getdata(searchdate,fleetno,docno,regno,color,group,branch);
 

	}

	 function getdata(searchdate,fleetno,docno,regno,color,group,branch){
		
		// $("#tariffDivId").load('rateDescription.jsp?txtrentaldocno='+indexVal1+'&revehGroup='+revehGroup);
		
		 $("#srefreshdiv").load('fleetSearch.jsp?searchdate='+searchdate+'&fleetno='+fleetno+'&docno='+docno+'&regno='+regno+'&color='+color+'&group='+group+'&branch='+branch);
		 

		  
/* x.open("GET", "dissearch.jsp?sclname="+sclname+"&smob="+smob+"&rno="+rno+"&flno="+flno+"&sregno="+sregno+"&smra="+smra, true);
		x.send(); */
		}
 
	</script>
<style type="text/css">
:root {
    --primary-teal: #3ba294;
    --btn-blue: #348fe2;
    --text-color: #666;
    --border-color: #e2e2e2;
    --bg-light: #f5f6f8;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #E0ECF8;
    margin: 0;
    padding: 20px;
    color: var(--text-color);
}

/* Container */
.modal-container {
    background: #fff;
    border-radius: 4px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    max-width: 1200px;
    margin: auto;
    display: flex;
    flex-direction: column;
    padding-bottom: 20px;
}

/* Header */
.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    border-bottom: 1px solid var(--border-color);
    margin-bottom: 20px;
}

.modal-header h2 {
    margin: 0;
    font-size: 18px;
    color: #444;
    font-weight: normal;
}

.modal-header span {
    color: #888;
    font-size: 14px;
}

/* Form Grid */
.search-section {
    padding: 0 20px;
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 20px 30px;
    align-items: end;
    margin-bottom: 20px;
}

/* Inputs */
.input-group {
    display: flex;
    flex-direction: column;
}

.input-group label {
    font-size: 13px;
    color: #999;
    margin-bottom: 5px;
    font-weight: 500;
}

.input-group input,
.input-group select {
    border: none;
    border-bottom: 1px solid var(--border-color);
    padding: 6px 0;
    font-size: 14px;
    color: #333;
    outline: none;
    background: transparent;
    width: 100%;
    transition: border-bottom-color 0.2s;
}

.input-group input:focus,
.input-group select:focus {
    border-bottom: 2px solid var(--primary-teal);
}

/* Date input override */
#searchdate {
    border-bottom: 1px solid var(--border-color);
    padding: 6px 0;
}

#searchdate:focus-within {
    border-bottom: 2px solid var(--primary-teal);
}

/* Button */
.action-buttons {
    display: flex;
    justify-content: flex-end;
}

.btn {
    border: none;
    border-radius: 3px;
    padding: 8px 18px;
    color: #fff;
    cursor: pointer;
    font-size: 14px;
    height: 34px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.btn-search {
    background-color: var(--primary-teal);
    font-weight: 600;
    width : 120px;
}

.btn:hover {
    opacity: 0.9;
}

/* Grid container */
.grid-container {
    padding: 0 20px;
    margin-top: 10px;
}

.input-group select {
    border: none;
    border-bottom: 1px solid var(--border-color);
    padding: 6px 30px 6px 0; /* space for arrow */
    font-size: 14px;
    color: #333;
    background: transparent;
    width: 100%;
    outline: none;

    /* Fix arrow visibility */
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;

    /* Custom arrow */
    background-image: url("data:image/svg+xml;utf8,<svg fill='%23666' height='20' viewBox='0 0 24 24' width='20' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
    background-repeat: no-repeat;
    background-position: right 0px center;
    background-size: 18px;
}
</style>

<body bgcolor="#E0ECF8">
<div class="modal-container" id="search">

    <!-- Header -->
    <div class="modal-header">
        <h2>Fleet Search <span>Main Grid</span></h2>
    </div>

    <!-- Search Section -->
    <div class="search-section">
        <div class="form-grid">

            <!-- Row 1 -->
            <div class="input-group">
                <label>Doc No</label>
                <input type="text" name="searchdocno" id="searchdocno">
            </div>

            <div class="input-group">
                <label>Date</label>
                <div id="searchdate" name="searchdate"></div>
            </div>

            <div class="input-group">
                <label>Color</label>
                <select name="searchcolor" id="searchcolor">
                    <option value="">--Select--</option>
                </select>
            </div>

            <div class="input-group">
                <label>Fleet No</label>
                <input type="text" name="searchfleetno" id="searchfleetno">
            </div>

            <!-- Row 2 -->
            <div class="input-group">
                <label>Reg No</label>
                <input type="text" name="searchregno" id="searchregno">
            </div>

            <div class="input-group">
                <label>Group</label>
                <select name="searchgroup" id="searchgroup">
                    <option value="">--Select--</option>
                </select>
            </div>
  <button type="button" id="btnSearchExt" class="btn btn-search" onclick="mainloadSearch();">
                Search
            </button>
        </div>


  
    <!-- Grid -->
    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="fleetSearch.jsp" /> 
        </div>
    </div>

</div></body>
</html>