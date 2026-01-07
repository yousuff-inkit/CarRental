<%@page import="com.common.ClsExeFolio" %>
<% ClsExeFolio cef = new ClsExeFolio(); %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GatewayERP(i)</title>
    
    <jsp:include page="../../includes.jsp"></jsp:include>
    <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

    <style>
        /* 1. Base Setup: Fix body height to 100% and hide default scroll to prevent double bars */
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow: hidden; /* We will scroll the wrapper instead */
        }

        /* 2. Scroll Wrapper: This is the window that scrolls */
        .scroll-wrapper {
            height: 100%;
            overflow-y: auto; /* Forces the vertical scrollbar */
            width: 100%;
            padding: 20px;
            box-sizing: border-box; /* Ensures padding doesn't add to width */
        }

        /* 3. Main Layout Container */
        .main-container {
            max-width: 100%;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
            padding-bottom: 50px; /* Extra space at bottom for comfortable scrolling */
        }

        /* Header Section */
        .page-header {
            display: flex;
            align-items: center;
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            border-bottom: 3px solid #007bff;
            flex-shrink: 0; /* Prevents header from shrinking */
        }

        .page-header h2 {
            margin: 0 0 0 15px;
            font-size: 22px;
            color: #2c3e50;
            font-weight: 600;
            text-transform: uppercase;
        }

        /* Reload Button */
        #btnReload {
            background-color: #eef2f7;
            border: 1px solid #dce1e6;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            outline: none;
        }

        #btnReload:hover {
            background-color: #dbe4ef;
            transform: rotate(15deg);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        /* Content Card Styling */
        .content-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            padding: 20px;
            /* Allow height to grow with content */
            height: auto; 
            min-height: 200px;
        }

        /* Iframe Container */
        .iframe-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            padding: 10px;
            height: 600px; /* Fixed height for iframe area */
            flex-shrink: 0;
        }

        #folio {
            width: 100%;
            height: 100%;
            border: none;
            display: block;
        }

        /* Utility */
        .redClass { color: #d9534f; }
        
        /* Loader Overlay */
        #overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.3); z-index: 999;
        }
        #PleaseWait {
            position: fixed; top: 50%; left: 50%;
            transform: translate(-50%, -50%); z-index: 1000;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $("body").prepend('<div id="overlay" style="display: none;"></div>');
            $("body").prepend("<div id='PleaseWait' style='display: none;'><img src='../../icons/31load.gif' alt='Loading...'/></div>");
        });

        function funload(){
            $("#overlay, #PleaseWait").show();
            var path = "";
            $("#folio").attr("src", path);
            $("#approvalDataGrid").load("approvalDataGridNew.jsp", function() {
                 // Optional: hide loader here if needed
            });
        }
    </script>
</head>
<body>

    <div class="scroll-wrapper">
        
        <div class="main-container">

            <header class="page-header">
                <button type="button" id="btnReload" title="Reload Data" onclick="funload();">
                    <img alt="Reload" src="<%=contextPath%>/icons/icon-reload.png" style="width: 20px; height: 20px;">
                </button>
                <h2>Executive Management Folio</h2>
            </header>

            <section class="content-card" id="approvalData">
                <jsp:include page="approvalDataNew.jsp"></jsp:include>
            </section>

            <div style="display:none;">
                <input type="hidden" id="formData" />
                <input type="hidden" id="branchid" />
                <input type="hidden" id="mode" />
                <input type="hidden" id="backdateallowed" name="backdateallowed" value='<s:property value="backdateallowed"/>' />
                <input type="hidden" id="pdcascdcdateallowed" name="pdcascdcdateallowed" value='<s:property value="pdcascdcdateallowed"/>' />
                <input type="hidden" id="monthclosed" name="monthclosed" value='<s:property value="monthclosed"/>' />
                <input type="hidden" id="taxdateval" name="taxdateval" value='<s:property value="taxdateval"/>' />
                <input type="hidden" name="formcurrencytype" id="formcurrencytype" value='<s:property value="formcurrencytype"/>' />
                <input type="hidden" id="curdec" name="curdec" value='<s:property value="curdec"/>' />
                <input type="hidden" id="amtdec" name="amtdec" value='<s:property value="amtdec"/>' />
                <input type="hidden" id="chkexportdata" name="chkexportdata" value='<s:property value="chkexportdata"/>' />
            </div>

            <section class="iframe-container">
                <iframe id="folio" scrolling="yes"></iframe>
            </section>

        </div>
    </div>

</body>
</html>