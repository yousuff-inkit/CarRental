 <%@ taglib prefix="s" uri="/struts-tags" %>
 <% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

	<script type="text/javascript">
	$(document).ready(function () {
	 $("#receiptdate").jqxDateTimeInput({ width: '110px', height: '15px',formatString:"dd.MM.yyyy",value:null});
	}); 

 	function loadSearch() {

 		var partyname=document.getElementById("txtpartyname").value;
 		var docNo=document.getElementById("txtdocno").value;
 		var date=document.getElementById("receiptdate").value;
 		var amount=document.getElementById("txtamount").value;
 		var check=1;
 		
		getdata(partyname,docNo,date,amount,check);
	}
 	
	function getdata(partyname,docNo,date,amount,check){
		 $("#refreshdiv").load('crvMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&check='+check);
	}

	</script>

<style type="text/css">
    /* 1. Reset and Container */
    #search-container {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: #ffffff;
        padding: 15px;
        border-radius: 8px;
        border: 1px solid #e1e8f0;
        max-width: 100%;
        box-sizing: border-box;
        margin: 0 auto;
    }

    /* 2. Compact Grid Layout */
    .search-row {
        display: flex;
        gap: 12px;
        margin-bottom: 12px;
        align-items: flex-end;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        flex: 1; /* Inputs take equal available space */
        min-width: 0; /* Prevents flex items from overflowing */
    }

    /* 3. Small, Modern Labels and Inputs */
    .form-group label {
        font-size: 11px;
        font-weight: 700;
        color: #7a8ba3;
        text-transform: uppercase;
        margin-bottom: 5px;
        letter-spacing: 0.5px;
    }

    input[type="text"] {
        height: 30px; /* Scaled down */
        padding: 0 10px;
        border: 1px solid #dbeafe;
        border-radius: 5px;
        font-size: 12px;
        color: #334155;
        background-color: #fcfdfe;
        box-sizing: border-box;
        width: 100%;
    }

    input[type="text"]:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.1);
    }

    /* 4. The Requested Button Style (Compact Version) */
    .btn-search-modern {
        font-weight: 700;
        font-size: 11px;
        width: 100px; /* Fixed small width */
        height: 30px; /* Matches input height */
        background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
        color: #ffffff !important;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        transition: transform 0.1s;
    }

    .btn-search-modern:hover {
        filter: brightness(1.1);
    }

    .btn-search-modern:active {
        transform: scale(0.98);
    }

    /* 5. Results Area (Ensures Grid shows up) */
    .results-wrapper {
        margin-top: 15px;
        border-top: 1px solid #f1f5f9;
        padding-top: 10px;
        width: 100%;
        overflow: visible; /* Keeps dynamic grid visible */
    }
</style>
</head>
<body>

<div id="search-container">
    <div class="search-row">
        <div class="form-group">
            <label>Account No</label>
            <input type="text" id="txtacctno" placeholder="e.g. 10002345">
        </div>
        
        <div class="form-group">
            <label>Currency</label>
            <input type="text" id="txtacctcurrency" placeholder="USD">
            <input type="hidden" id="txttypes">
            <input type="hidden" id="txtnewmaindate">
        </div>

        <a href="javascript:void(0)" class="btn-search-modern" onclick="loadAccountSearchGrid();">
            Search
        </a>
    </div>

    <div class="search-row">
        <div class="form-group">
            <label>Account Name</label>
            <input type="text" id="txtacctname" placeholder="Search by name...">
        </div>
        <div style="width: 112px;"></div> 
    </div>

    <div id="refreshAccountSearchDetailsDiv" class="results-wrapper">
        <jsp:include page="cashReceiptSearchGrid.jsp"/>
    </div>
</div>

</body>
</html>