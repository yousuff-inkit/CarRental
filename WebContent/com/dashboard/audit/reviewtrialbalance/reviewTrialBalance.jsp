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

<style type="text/css">
/* ===== MASTER LAYOUT (Modern Flexbox) ===== */
html, body, #mainBG {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background-color: #f4f7f9;
}

.master-container {
    display: flex;
    width: 100%;
    height: 100vh;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* ===== LEFT SIDEBAR ===== */
.sidebar-filters {
    width: 280px; 
    flex: 0 0 280px; 
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100%;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
    z-index: 10;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 15px 25px; 
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 15px;
}

/* ===== BUTTONS ===== */
.btn-submit {
    width: 100%;
    height: 30px;            
    padding: 0 12px;         
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 4px;      
    font-size: 13px;
    font-weight: 600;
    cursor: pointer;
    line-height: 30px;       
    text-align: center;
    transition: background 0.2s;
}

.btn-submit:hover { background: #1d4ed8; }
.btn-submit:disabled {
    background: #cbd5e1 !important;
    cursor: not-allowed;
    color: #64748b !important;
}

/* ===== RIGHT CONTENT AREA ===== */
.main-content-area {
    flex: 1; 
    display: flex;
    flex-direction: column;
    background: #ffffff;
    height: 100%;
    overflow: hidden;
}

.top-toolbar-container {
    width: 100%;
    padding: 10px 15px;
    background: #ffffff;
    border-bottom: 1px solid #e1e8ed;
    box-sizing: border-box;
}

/* Block layout required for JQX grids to calculate percentage height properly */
.grid-content-container {
    flex: 1;
    padding: 15px;
    overflow: auto; 
    box-sizing: border-box;
    display: block; 
}

.grid-content-container > div {
    margin-bottom: 20px;
}

/* Fix for jqx widget overrides */
.jqx-widget input, .jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

    $(document).ready(function () {
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1002;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        
        $("#reviewTrialBalanceSubGridId").jqxGrid({ disabled: true});
    });
    
    function funreload(event){ 
         var branchval = document.getElementById("cmbbranch").value;
         $("#reviewTrialBalanceSubGridId").jqxGrid('clear');
         $("#reviewTrialBalanceSubGridId").jqxGrid('clearselection');
         $("#reviewTrialBalanceSubGridId").jqxGrid({ disabled: true});
         $("#overlay, #PleaseWait").show();
         $("#reviewTrialBalanceDiv").load("reviewTrialBalanceGrid.jsp?check=1&branchval="+branchval);
    }

    function reviewTrail(event){ 
        $("#overlay, #PleaseWait").show();

        var x=new XMLHttpRequest();
        x.onreadystatechange=function(){
            if (x.readyState==4 && x.status==200) {
                var items= x.responseText;
                if(parseInt(items)>0){
                     $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','Record Successfully Refreshed','warning');   
                }
                else{
                     $("#overlay, #PleaseWait").hide();
                    $.messager.alert('Message','Not Refreshed','warning');
                }
            }
        }
        x.open("GET","clearReview.jsp",true);
        x.send();
    }
    
    function funExportBtn(){
         JSONToCSVCon(data1, 'Trial Balance Review', true);
     }

</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent" data-type="background">

    <div class="master-container">

        <div class="sidebar-filters">
            <div class="sidebar-scroll-content">

                <div class="filter-card">
                    <button type="button" id="btnRAG" name="btnRAG" class="btn-submit" onclick="reviewTrail(event);">
                        Refresh
                    </button>
                </div>

            </div>
        </div>

        <div class="main-content-area">
            
            <div class="top-toolbar-container">
                <jsp:include page="../../heading.jsp"></jsp:include>
            </div>

            <div class="grid-content-container">
                <div id="reviewTrialBalanceDiv">
                    <jsp:include page="reviewTrialBalanceGrid.jsp"></jsp:include>
                </div>

                <div id="reviewTrialBalanceSubDiv">
                    <jsp:include page="reviewTrialBalanceSubGrid.jsp"></jsp:include>
                </div>
            </div>

        </div>

    </div>

    <div id="clientWindow">
        <div></div><div></div>
    </div>

</div>
</body>
</html>