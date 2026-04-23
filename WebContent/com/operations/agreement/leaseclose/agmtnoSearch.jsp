<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<link href="../../../../css/body.css" rel="stylesheet" type="text/css">
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />

<style type="text/css">
#agmsearch {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 11px;
    color: #404040;
    padding: 15px;
    background-color: #fff;
    box-sizing: border-box;
    width: 100%;
}

#agmsearch .modern-panel {
    background-color: #fff !important;
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 15px;
    margin-bottom: 10px;
}

#agmsearch .search-table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 6px 8px;
}

/* All cells vertically centered — this fixes the button alignment */
#agmsearch .search-table td {
    vertical-align: middle;
}

#agmsearch .search-table td.lbl {
    text-align: right;
    font-weight: bold;
    white-space: nowrap;
    width: 52px;
    font-size: 11px;
    color: #404040;
}

#agmsearch .search-table td.val {
    width: 115px;
}

#agmsearch input[type="text"],
#agmsearch select {
    height: 24px !important;
    border: 1px solid #BDBDBD;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 11px;
    font-family: Tahoma, sans-serif;
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
}

#agmsearch input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF;
}

#agmsearch .date-wrap {
    width: 125px;
    max-width: 125px;
    overflow: hidden;
}

#agmsearch .jqx-datetimeinput {
    height: 24px !important;
}

/* Branch select + error message row */
#agmsearch .action-cell {
    display: flex;
    align-items: center;
    gap: 10px;
    white-space: nowrap;
}

#agmsearch select#cmbagmtbranch {
    height: 24px !important;
    width: 140px;
}

#agmsearch #errormsg {
    color: #cc0000;
    font-size: 11px;
    font-weight: bold;
    min-width: 10px;
}

#agmsearch .myButton {
    height: 26px;
    padding: 0 18px;
    background-color: #0056b3;
    color: #ffffff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    font-family: Tahoma, sans-serif;
    transition: background-color 0.2s;
    white-space: nowrap;
}

#agmsearch .myButton:hover {
    background-color: #004494;
}

#agmsearch .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    min-height: 200px;
}

.hidden-scrollbar {
    overflow: auto;
    height: 600px;
}
</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#searchdate").jqxDateTimeInput({
        width: '125px',
        height: '24px',
        formatString: "dd.MM.yyyy",
        value: null
    });

    setTimeout(function () {
        $("#searchdate").find("input").css({
            "margin-top": "0px",
            "line-height": "24px",
            "font-size": "11px",
            "font-family": "Tahoma, sans-serif",
            "padding": "0 6px",
            "box-sizing": "border-box"
        });
        $("#searchdate").find(".jqx-action-button").css({ "top": "0px", "height": "24px" });
    }, 0);
});

function loadSearch() {
    if (document.getElementById("cmbagmtbranch").value == "") {
        document.getElementById("errormsg").innerText = "Agreement Branch is Mandatory";
        return false;
    }
    document.getElementById("errormsg").innerText = "";

    var docnosearch1 = document.getElementById("docnosearch").value;
    var fleetsearch  = document.getElementById("fleetsearch").value;
    var regnosearch  = document.getElementById("regnosearch").value;
    var clientsearch = document.getElementById("clientsearch").value;
    var searchdate   = $('#searchdate').jqxDateTimeInput('val');
    var branch       = document.getElementById("cmbagmtbranch").value;
    var mobilesearch = document.getElementById("mobilesearch").value;

    getdata(docnosearch1, fleetsearch, regnosearch, clientsearch, searchdate, mobilesearch, branch);
}

function getdata(docnosearch, fleetsearch, regnosearch, clientsearch, searchdate, mobilesearch, branch) {
    $("#loadRaSearch").load(
        "gridRaSearch.jsp?docno="  + docnosearch +
        "&fleet="   + fleetsearch +
        "&regno="   + regnosearch +
        "&client="  + clientsearch +
        "&date="    + searchdate +
        "&mobile="  + mobilesearch +
        "&branch="  + branch
    );
}
</script>

</head>
<body>

<div id="agmsearch">
    <div class="modern-panel">
        <table class="search-table">

            <!-- ROW 1: Doc No | Fleet | Reg No | Search button -->
            <tr>
                <td class="lbl">Doc No</td>
                <td class="val">
                    <input type="text" name="docnosearch" id="docnosearch"
                           value='<s:property value="docnosearch"/>'>
                </td>
                <td class="lbl">Fleet</td>
                <td class="val">
                    <input type="text" name="fleetsearch" id="fleetsearch"
                           value='<s:property value="fleetsearch"/>'>
                </td>
                <td class="lbl">Reg No</td>
                <td class="val">
                    <input type="text" name="regnosearch" id="regnosearch"
                           value='<s:property value="regnosearch"/>'>
                </td>
                <!-- Button sits in its own td, vertical-align:middle keeps it flush -->
                <td style="padding-left: 6px;">
                    <input type="button" name="btnrasearch" id="btnrasearch"
                           class="myButton" value="Search" onclick="loadSearch();">
                </td>
                <td></td>
            </tr>

            <!-- ROW 2: Client | Date | Mobile | Branch + Error -->
            <tr>
                <td class="lbl">Client</td>
                <td class="val">
                    <input type="text" name="clientsearch" id="clientsearch"
                           value='<s:property value="clientsearch"/>'>
                </td>
                <td class="lbl">Date</td>
                <td class="val">
                    <div class="date-wrap">
                        <div id="searchdate" name="searchdate"></div>
                    </div>
                    <input type="hidden" name="hidsearchdate" id="hidsearchdate"
                           value='<s:property value="hidsearchdate"/>'>
                </td>
                <td class="lbl">Mobile</td>
                <td class="val">
                    <input type="text" name="mobilesearch" id="mobilesearch"
                           value='<s:property value="mobilesearch"/>'>
                </td>
                <td class="lbl">Branch</td>
                <td>
                    <div class="action-cell">
                        <select id="cmbagmtbranch" name="cmbagmtbranch">
                            <option value="">--Select--</option>
                            <s:iterator value="branchList">
                                <option value='<s:property value="branchCode"/>'
                                    <s:if test="branchCode == selectedBranch">selected</s:if>>
                                    <s:property value="branchName"/>
                                </option>
                            </s:iterator>
                        </select>
                        <span id="errormsg"></span>
                    </div>
                </td>
            </tr>

        </table>
    </div><!-- /.modern-panel -->

    <div class="grid-container">
        <div id="loadRaSearch">
            <jsp:include page="gridRaSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
