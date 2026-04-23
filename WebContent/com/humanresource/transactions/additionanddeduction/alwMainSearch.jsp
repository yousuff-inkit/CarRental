<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
<title>GatewayERP(i)</title>

<style>
/* =========================================================
   SCOPED UI: Segoe UI Font & Clean White Search Panel
========================================================= */
body {
    margin: 0;
    background-color: #fff;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif; 
}

.modern-ui {
    font-size: 12px;
    color: #333;
    padding: 10px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Styles */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px; 
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF; /* Client master focus color */
}

/* Panel Styling - Clean White Panel */
.modern-ui .search-panel {
    background-color: #fff !important; 
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px;
    margin-bottom: 10px;
}

/* Table Alignment */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
}

.modern-ui td {
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #222;
    font-size: 12px; 
    font-weight: 600;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Search Button - Standard Blue */
.modern-ui .myButton {
    height: 26px;
    padding: 0 20px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
    font-weight: bold;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    transition: all 0.2s;
}

.modern-ui .myButton:hover {
    background-color: #004494;
}

/* Grid Container */
.modern-ui .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    overflow: hidden;
}
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /* Aligning Date Widget with modern 24px height standard */
        $("#alwdate").jqxDateTimeInput({ width: '100%', height: '24px', formatString:"dd.MM.yyyy", value:null});
        
        // Force internal alignment AFTER render
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#BDBDBD", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-family": "'Segoe UI', 'Roboto', 'Arial', sans-serif", "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);

        getAlwYear();
        getAlwMonth();
    }); 
    
    function getAlwYear() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.split('####');
                var yearItems = items[0].split(",");
                var yearIdItems = items[1].split(",");
                var optionsyear = '<option value="">--Select--</option>';
                for (var i = 0; i < yearItems.length; i++) {
                    optionsyear += '<option value="' + yearIdItems[i] + '">' + yearItems[i] + '</option>';
                }
                $("select#cmbalwyear").html(optionsyear);
            }
        }
        x.open("GET", "getYear.jsp", true);
        x.send();
    }
    
    function getAlwMonth() {
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                var items = x.responseText.split('####');
                var monthItems = items[0].split(",");
                var monthIdItems = items[1].split(",");
                var optionsmonth = '<option value="">--Select--</option>';
                for (var i = 0; i < monthItems.length; i++) {
                    optionsmonth += '<option value="' + monthIdItems[i] + '">' + monthItems[i] + '</option>';
                }
                $("select#cmbalwmonth").html(optionsmonth);
            }
        }
        x.open("GET", "getMonth.jsp", true);
        x.send();
    }

    function loadSearch() {
        var date = $('#alwdate').jqxDateTimeInput('val') || "";
        var docNo = document.getElementById("txtdocno").value || "";
        var year = document.getElementById("cmbalwyear").value || "";
        var month = document.getElementById("cmbalwmonth").value || "";
        var description = document.getElementById("txtalwdescription").value || "";
        
        var employeebranchchk = "";
        if(window.parent && window.parent.employeebranchchk) {
            employeebranchchk = window.parent.employeebranchchk.value; 
        }
        
        var branch = "";
        if(document.getElementById("brchName")){
            branch = document.getElementById("brchName").value;
        }
        
        getdata(date, docNo, year, month, description, employeebranchchk, branch);
    }
    
    function getdata(date, docNo, year, month, description, employeebranchchk, branch){
         /* Safely encoding URI components */
         $("#refreshdiv").load('alwMainSearchGrid.jsp?date=' + date + 
                               '&docNo=' + encodeURIComponent(docNo) + 
                               '&year=' + encodeURIComponent(year) + 
                               '&month=' + encodeURIComponent(month) + 
                               '&description=' + encodeURIComponent(description) + 
                               '&branch=' + encodeURIComponent(branch) + 
                               '&employeebranchchk=' + encodeURIComponent(employeebranchchk));
    }
</script>
</head>

<body style="background-color: #fff; margin: 0;">

<div id="search" class="modern-ui">

    <div class="search-panel">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td class="lbl-right" width="10%">Date</td>
                <td width="15%">
                    <div id="alwdate" name="alwdate" value='<s:property value="alwdate"/>'></div>
                    <input type="hidden" name="hidalwdate" id="hidalwdate" value='<s:property value="hidalwdate"/>'>
                </td>

                <td class="lbl-right" width="10%">Doc No</td>
                <td width="15%">
                    <input type="text" name="txtdocno" id="txtdocno" value='<s:property value="txtdocno"/>'>
                </td>

                <td class="lbl-right" width="10%">Year</td>
                <td width="15%">
                    <select name="cmbalwyear" id="cmbalwyear">
                        <option value="">--Select--</option>
                    </select>
                </td>

                <td width="25%" rowspan="2" align="center" valign="middle">
                    <input type="button" name="btnsearch" id="btnsearch" class="myButton" value="Search" onclick="loadSearch();">
                </td>
            </tr>

            <tr>
                <td class="lbl-right">Month</td>
                <td>
                    <select name="cmbalwmonth" id="cmbalwmonth">
                        <option value="">--Select--</option>
                    </select>
                </td>

                <td class="lbl-right">Description</td>
                <td colspan="3">
                    <input type="text" name="txtalwdescription" id="txtalwdescription" value='<s:property value="txtalwdescription"/>'>
                </td>
            </tr>
        </table>
    </div>

    <div class="grid-container">
        <div id="refreshdiv">
            <jsp:include page="alwMainSearchGrid.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>