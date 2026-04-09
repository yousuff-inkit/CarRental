<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Search</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function () {
    // Kept your jqxDateTimeInput initialization
    $("#receiptdate").jqxDateTimeInput({ 
        width: '100%', 
        height: '28px', 
        formatString: "dd.MM.yyyy", 
        value: null,
        theme: 'light' // Optional: if you have a cleaner jqx theme
    });
}); 

function loadSearch() {
    var partyname = document.getElementById("txtpartyname").value;
    var docNo = document.getElementById("txtdocno").value;
    var date = document.getElementById("receiptdate").value;
    var amount = document.getElementById("txtamount").value;
    var check = 1;
    
    getdata(partyname, docNo, date, amount, check);
}

function getdata(partyname, docNo, date, amount, check){
    $("#refreshdiv").load('crvMainSearchGrid.jsp?partyname='+partyname.replace(/ /g, "%20")+'&docNo='+docNo+'&date='+date+'&amount='+amount+'&check='+check);
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
        background-color: #f0f0f0;
        margin: 0;
        padding: 20px;
        color: var(--text-color);
    }

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

    /* Header Styling */
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
    .modal-header h2 span {
        color: #888;
        font-size: 14px;
        margin-left: 5px;
    }

    /* Search Form Layout */
    .search-section {
        padding: 0 20px;
    }
    .form-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 4 columns to fit all inputs neatly */
        gap: 20px 30px;
        align-items: end; /* Aligns inputs and buttons at the bottom */
        margin-bottom: 20px;
    }
    
    /* Input Styling */
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
    .input-group input[type="text"] {
        border: none;
        border-bottom: 1px solid var(--border-color);
        padding: 5px 0;
        font-size: 14px;
        color: #333;
        outline: none;
        background: transparent;
        width: 100%;
        transition: border-bottom-color 0.2s;
    }
    .input-group input[type="text"]:focus {
        border-bottom: 2px solid var(--primary-teal);
    }

    /* Override for jqxDateTimeInput to look more like standard inputs */
    .jqx-widget-content {
        border: none !important;
        border-bottom: 1px solid var(--border-color) !important;
        border-radius: 0 !important;
        background: transparent !important;
    }
    .jqx-widget-content:focus-within {
        border-bottom: 2px solid var(--primary-teal) !important;
    }

    /* Action Buttons */
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
        display: flex;
        align-items: center;
        justify-content: center;
        transition: opacity 0.2s;
        height: 34px; /* Matches input heights nicely */
    }
    .btn:hover {
        opacity: 0.9;
    }
    .btn-search {
        background-color: var(--primary-teal);
        font-weight: 600;
    }
    .btn-search i {
        margin-right: 6px;
    }

    /* Grid Container */
    .grid-container {
        padding: 0 20px;
        margin-top: 10px;
    }
</style>
</head>
<body>

<div class="modal-container" id="search">
    <div class="modal-header">
        <h2>Receipt Search <span>Main Grid</span></h2>
    </div>

    <div class="search-section">
        <div class="form-grid">
            
            <div class="input-group">
                <label>Date</label>
                <div id="receiptdate" name="receiptdate" value='<s:property value="receiptdate"/>'></div>
                <input type="hidden" name="hidreceiptdate" id="hidreceiptdate" value='<s:property value="hidreceiptdate"/>'>
            </div>

            <div class="input-group">
                <label>Doc No</label>
                <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'>
            </div>

            <div class="input-group">
                <label>Name</label>
                <input type="text" name="txtpartyname" id="txtpartyname" value='<s:property value="txtpartyname"/>'>
            </div>

            <div class="input-group">
                <label>Amount</label>
                <input type="text" name="txtamount" id="txtamount" value='<s:property value="txtamount"/>'>
            </div>

        </div>
        
        <div class="action-buttons">
            <button type="button" name="btnsearch" id="btnsearch" class="btn btn-search" onclick="loadSearch(); return false;">
                <i class="fas fa-search"></i> Search
            </button>
        </div>
    </div>

    <hr style="border: 0; border-top: 1px solid #e2e2e2; margin: 15px 0;">

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="crvMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>