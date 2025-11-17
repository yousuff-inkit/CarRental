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
<%--    <style>--%>

<%--        /* css - update file: WebContent/css/body.css */--%>

<%--        /* Base typography */--%>
<%--        :root {--%>
<%--            --base-font-size: 16.5px; /* adjust here to make everything bigger/smaller */--%>
<%--            --body-font: "Segoe UI", Roboto, Arial, sans-serif;--%>
<%--            --body-color: #222;--%>
<%--            --muted-color: #4b5563;--%>
<%--            --accent: #007bff;--%>
<%--        }--%>

<%--        html {--%>
<%--            font-size: 100%; /* keep browser default -> rem = 1rem = 16px baseline */--%>
<%--        }--%>

<%--        body {--%>
<%--            font-family: var(--body-font);--%>
<%--            font-size: calc(var(--base-font-size));--%>
<%--            line-height: 1.45;--%>
<%--            color: var(--body-color);--%>
<%--            -webkit-font-smoothing: antialiased;--%>
<%--            -moz-osx-font-smoothing: grayscale;--%>
<%--            margin: 0;--%>
<%--            padding: 32px 0;--%>
<%--            min-height: 100vh;--%>
<%--            box-sizing: border-box;--%>
<%--        }--%>

<%--        /* Container and headings */--%>
<%--        #mainBG {--%>
<%--            background: #fff;--%>
<%--            border-radius: 16px;--%>
<%--            padding: 12px;--%>
<%--            max-width: 1200px;--%>
<%--            margin: 0 auto;--%>
<%--        }--%>

<%--        /* Header area */--%>
<%--        .receipt-header {--%>
<%--            display: flex;--%>
<%--            flex-wrap: wrap;--%>
<%--            align-items: center;--%>
<%--            margin-bottom: 16px;--%>
<%--            border-radius: 12px;--%>
<%--            padding: 8px 24px;--%>
<%--            gap: 12px;--%>
<%--            font-size: 1rem; /* equal to base font */--%>
<%--        }--%>

<%--        .receipt-header label {--%>
<%--            font-weight: 600;--%>
<%--            color: #26303a;--%>
<%--            margin-right: 8px;--%>
<%--            font-size: 0.95rem;--%>
<%--        }--%>

<%--        /* Inputs, selects, buttons scale with rem */--%>
<%--        input[type="text"],--%>
<%--        select,--%>
<%--        button,--%>
<%--        .myButton {--%>
<%--            font-size: 1rem; /* readable size */--%>
<%--            line-height: 1.4;--%>
<%--            -webkit-appearance: none;--%>
<%--            -moz-appearance: none;--%>
<%--            appearance: none;--%>
<%--            box-sizing: border-box;--%>
<%--        }--%>

<%--        /* Inputs styling */--%>
<%--        .receipt-header input[type="text"],--%>
<%--        .section-block input[type="text"],--%>
<%--        .section-block select {--%>
<%--            border: 1px solid #d1d5db;--%>
<%--            border-radius: 6px;--%>
<%--            padding: 0.45rem 0.6rem;--%>
<%--            background: #fff;--%>
<%--            transition: border-color 0.15s;--%>
<%--            color: var(--body-color);--%>
<%--            width: 100%;--%>
<%--            font-size: 1rem;--%>
<%--        }--%>

<%--        /* Focus states */--%>
<%--        .receipt-header input[type="text"]:focus,--%>
<%--        .section-block input[type="text"]:focus,--%>
<%--        .section-block select:focus {--%>
<%--            border-color: var(--accent);--%>
<%--            outline: none;--%>
<%--            box-shadow: 0 0 0 3px rgba(0,123,255,0.08);--%>
<%--        }--%>

<%--        /* Buttons */--%>
<%--        .receipt-header button,--%>
<%--        .myButton {--%>
<%--            background: var(--accent);--%>
<%--            color: #fff;--%>
<%--            border: none;--%>
<%--            border-radius: 6px;--%>
<%--            padding: 0.45rem 0.9rem;--%>
<%--            font-weight: 600;--%>
<%--            cursor: pointer;--%>
<%--            font-size: 1rem;--%>
<%--        }--%>

<%--        /* Table */--%>
<%--        .cr-table {--%>
<%--            width: 100%;--%>
<%--            border-collapse: collapse;--%>
<%--            background: #f9fafb;--%>
<%--            border-radius: 8px;--%>
<%--            overflow: hidden;--%>
<%--            box-shadow: 0 0 0 1px #eef0f6;--%>
<%--            font-size: 0.98rem; /* slightly smaller than base but still readable */--%>
<%--        }--%>

<%--        .cr-table th,--%>
<%--        .cr-table td {--%>
<%--            padding: 0.6rem 0.7rem;--%>
<%--            border-bottom: 1px solid #e4e7ec;--%>
<%--            text-align: left;--%>
<%--            color: #2b3948;--%>
<%--        }--%>

<%--        /* Table header */--%>
<%--        .cr-table th {--%>
<%--            background: #eef0f6;--%>
<%--            color: #354B6A;--%>
<%--            font-weight: 700;--%>
<%--            font-size: 0.98rem;--%>
<%--        }--%>

<%--        /* Section headings */--%>
<%--        .section-block h2,--%>
<%--        .table-section h3 {--%>
<%--            font-size: 1.05rem;--%>
<%--            font-weight: 600;--%>
<%--            color: #253858;--%>
<%--            margin: 0 0 12px 0;--%>
<%--        }--%>

<%--        /* Make sure inputs inside table cells inherit font size */--%>
<%--        .cr-table input,--%>
<%--        .cr-table select {--%>
<%--            font-size: 0.98rem;--%>
<%--        }--%>

<%--        /* css */--%>
<%--        .receipt-header input[type="text"],--%>
<%--        .section-block input[type="text"],--%>
<%--        .section-block select,--%>
<%--        input[type="text"] {--%>
<%--            box-sizing: border-box;          /* include padding in width/height */--%>
<%--            font-size: 1rem;                 /* consistent readable size */--%>
<%--            line-height: 1.2;                /* vertical rhythm for text */--%>
<%--            padding: 0.55rem 0.75rem;        /* increase vertical padding to enlarge control */--%>
<%--            min-height: 2.6rem;              /* forces a taller field across browsers */--%>
<%--            height: auto;                    /* avoid fixed heights that cut off text */--%>
<%--            border-radius: 6px;--%>
<%--        }--%>

<%--        /* Target specific fields if you want an even taller appearance */--%>
<%--        #txtaccountsno,--%>
<%--        #txtaccountsname {--%>
<%--            min-height: 2.8rem;--%>
<%--        }--%>

<%--        /* If inline styles force a smaller height, use a specific selector with !important */--%>
<%--        .table-section .receipt-header input[type="text"] {--%>
<%--            min-height: 2.6rem !important;--%>
<%--            padding: 0.55rem 0.75rem !important;--%>
<%--        }--%>


<%--        /* Responsive small-screen adjustments */--%>
<%--        @media (max-width: 480px) {--%>
<%--            :root { --base-font-size: 15px; }--%>
<%--            .receipt-header { font-size: 0.95rem; padding: 8px; }--%>
<%--            .cr-table th, .cr-table td { padding: 0.5rem; font-size: 0.95rem; }--%>
<%--        }--%>

<%--        /* Utility: increase entire page quickly by changing --base-font-size */--%>

<%--    </style>--%>

<script type="text/javascript">
	$(document).ready(function () {
		if(document.getElementById("txtforsearch").value=="2"){
		   document.getElementById("txtatypes").value=document.getElementById("cmbtype").value;
		}
		else if(document.getElementById("txtforsearch").value=="3"){
			   document.getElementById("txtatypes").value=document.getElementById("cmbacctype").value;
		}else{
			document.getElementById("txtatypes").value=document.getElementById("cmbtotype").value;
		}
		 document.getElementById("txtdocumenttypes").value=document.getElementById("formdetailcode").value;
		 document.getElementById("txtcreditdebit").value=document.getElementById("txtforsearch").value;
		 document.getElementById("txtnewdate").value=$('#maindate').val();
	}); 
	
	function loadClientAccountSearch() {
			var clientaccountno=document.getElementById("accountsno").value;
			var clientaccountname=document.getElementById("accountsname").value;
			var clientmobile=document.getElementById("clientmobileno").value;
			var curr=document.getElementById("txtcurrencies").value;
			var accounttype=document.getElementById("txtatypes").value;
			var code=document.getElementById("txtdocumenttypes").value;
			var debitcredit=document.getElementById("txtcreditdebit").value;
			var date=document.getElementById("txtnewdate").value;
			var checked = 1;
			checkapprvl(code);    
			getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,code,debitcredit,date,checked);
	}
		
	function getClientAccountDetails(clientaccountno,clientaccountname,clientmobile,curr,accounttype,code,debitcredit,date,checked){
		 $("#refreshClientAccountDiv").load("../../clientAccountDetailsSearchGrid.jsp?accountno="+clientaccountno+'&accountname='+clientaccountname.replace(/ /g, "%20")+'&mobile='+clientmobile+'&currency='+curr+'&atype='+accounttype+'&dtype='+code+'&debitcredit='+debitcredit+'&date='+date+'&check='+checked);
	}

</script>
<body>
<div class="receipt-header">
<div class="table-section" id=search>
<table class="cr-table" width="100%">
  <tr>
    <td width="10%" align="right">Account No</td>
    <td width="34%"><input type="text" name="accountsno" id="accountsno" style="width:85%;" value='<s:property value="accountsno"/>'></td>
    <td width="9%" align="right">Currency</td>
    <td width="14%"><input type="text" name="txtcurrencies" id="txtcurrencies" style="width:83%;" value='<s:property value="txtcurrencies"/>'>
    <input type="hidden" name="txtatypes" id="txtatypes" value='<s:property value="txtatypes"/>'>
    <input type="hidden" name="txtdocumenttypes" id="txtdocumenttypes" value='<s:property value="txtdocumenttypes"/>'></td>
    <td width="8%" align="right">Mobile</td>
    <td width="25%"><input type="text" name="clientmobileno" id="clientmobileno" style="width:85%;" value='<s:property value="clientmobileno"/>'>
    <input type="hidden" name="txtcreditdebit" id="txtcreditdebit" value='<s:property value="txtcreditdebit"/>'>
    <input type="hidden" name="txtnewdate" id="txtnewdate" value='<s:property value="txtnewdate"/>'>
   <input type="hidden" id="hidapprvlcheck"/></td>
  </tr>
  <tr>
    <td align="right">Account Name</td>
    <td colspan="4"><input type="text" name="accountsname" id="accountsname" style="width:85%;" value='<s:property value="accountsname"/>'></td>
    <td align="center"><input type="button" name="btnClientAccountSearch" id="btnClientAccountSearch" class="myButton" value="Search"  onclick="loadClientAccountSearch();"></td>
  </tr>
  <tr>
    <td colspan="6"><div id="refreshClientAccountDiv"><jsp:include page="clientAccountDetailsSearchGrid.jsp"></jsp:include></div></td>
  </tr>
</table>
</div>
</div>
</body>
</html>