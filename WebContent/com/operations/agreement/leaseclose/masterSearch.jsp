<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<% String contextPath=request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<style type="text/css">
#search {
    font-family: Tahoma, Geneva, sans-serif;
    font-size: 11px;
    color: #404040;
    padding: 15px;
    background-color: #fff;
    box-sizing: border-box;
    width: 100%;
}

#search .modern-panel {
    background-color: #fff !important;
    border: 1px solid #BDBDBD;
    border-radius: 4px;
    padding: 12px 15px;
    margin-bottom: 10px;
}

/* Shared input reset */
#search input[type="text"],
#search select {
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

#search input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
    background-color: #FFD6FF;
}

/* Base row */
.field-row {
    display: grid;
    align-items: center;
    gap: 6px 10px;
    margin-bottom: 8px;
}

/* ROW 1: Name | MOB | Date — all columns fixed so nothing overflows */
.field-row.row1 {
    grid-template-columns: 42px minmax(80px, 1fr) 34px 110px 34px 125px;
}

/* ROW 2: Agmt NO | Fleet NO | Reg NO | actions */
.field-row.row2 {
    grid-template-columns: 50px 60px 50px 60px 44px 60px auto;
    margin-bottom: 0;
}

#search .lbl-right {
    text-align: right;
    font-weight: bold;
    white-space: nowrap;
}

/* Keeps jqx date widget from stretching */
.date-wrap {
    width: 130px;
    max-width: 130px;
    overflow: hidden;
}

/* Checkbox + Search button cell */
.action-cell {
    display: flex;
    align-items: center;
    gap: 10px;
    justify-content: flex-end;
    white-space: nowrap;
}

.action-cell label {
    font-size: 11px;
    font-weight: bold;
    color: #444;
    cursor: pointer;
    margin: 0;
}

#search .myButton {
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

#search .myButton:hover { background-color: #004494; }

#search .grid-container {
    border: 1px solid #BDBDBD;
    background: #fff;
    min-height: 200px;
}

#search .jqx-datetimeinput { height: 24px !important; }


.jqx-grid-header {
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}


.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important;
    border-width: 0px 0px 1px 0px !important; 
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}


.jqx-grid-cell-alt {
    background: #f1f3f5 !important; 
}


.jqx-grid-cell-hover {
    background: #dee2e6 !important; 
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; 
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}


.jqx-grid {
    border: 1px solid #adb5bd !important; 
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}


.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}


.jqx-grid-pager {
    background: #e9ecef !important; 
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}


.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; 
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; 
    border-radius: 4px !important;
}


</style>

<script type="text/javascript">
$(document).ready(function () {
    $("#searchdate").jqxDateTimeInput({
        width: '130px',
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

function mainloadSearch() {
    var sclname    = document.getElementById("SCl_name").value;
    var smob       = document.getElementById("Sl_mob").value;
    var rno        = document.getElementById("rno").value;
    var flno       = document.getElementById("flno").value;
    var sregno     = document.getElementById("sregno").value;
    var searchdate = $('#searchdate').jqxDateTimeInput('val');

    var branch = "";
    if (document.getElementById("brchName")) {
        branch = document.getElementById("brchName").value;
    }

    var allbranch = "0";
    if (document.getElementById("branch_chk")) {
        allbranch = document.getElementById("branch_chk").value;
    }

    getdata(sclname, smob, rno, flno, sregno, searchdate, branch, allbranch);
}

function getdata(sclname, smob, rno, flno, sregno, searchdate, branch, allbranch) {
    $("#srefreshdiv").load(
        'submainSearch.jsp?sclname=' + sclname +
        '&smob='        + smob +
        '&rno='         + rno +
        '&flno='        + flno +
        '&sregno='      + sregno +
        '&searchdate='  + searchdate +
        '&branch='      + branch +
        '&allbranch='   + allbranch
    );
}
</script>
</head>
<body>

<div id="search" class="search-popup-ui">

    <div class="modern-panel">

        <!-- ROW 1: Name | MOB | Date -->
        <div class="field-row row1">
            <label class="lbl-right" for="SCl_name">Name</label>
            <input type="text" name="SCl_name" id="SCl_name"
                   value='<s:property value="SCl_name"/>'>

            <label class="lbl-right" for="Sl_mob">MOB</label>
            <input type="text" name="Sl_mob" id="Sl_mob"
                   value='<s:property value="Sl_mob"/>'>

            <label class="lbl-right" for="searchdate">Date</label>
            <div class="date-wrap">
                <div id="searchdate" name="searchdate"></div>
            </div>
        </div>

        <!-- ROW 2: Agmt NO | Fleet NO | Reg NO | All Branch + Search -->
        <div class="field-row row2">
            <label class="lbl-right" for="rno">Agmt NO</label>
            <input type="text" name="rno" id="rno"
                   value='<s:property value="rno"/>'>

            <label class="lbl-right" for="flno">Fleet NO</label>
            <input type="text" name="flno" id="flno"
                   value='<s:property value="flno"/>'>

            <label class="lbl-right" for="sregno">Reg NO</label>
            <input type="text" id="sregno" name="sregno"
                   value='<s:property value="sregno"/>'>

            <div class="action-cell">
                <input type="checkbox" id="branch_chk" name="branch_chk" value="0"
                       onclick="$(this).attr('value', this.checked ? 1 : 0)">
                <label for="branch_chk">All Branch</label>
                <input type="button" name="mbtnrasearch" id="mbtnrasearch"
                       class="myButton" value="Search" onclick="mainloadSearch();">
            </div>
        </div>

    </div>

    <div class="grid-container">
        <div id="srefreshdiv">
            <jsp:include page="submainSearch.jsp"></jsp:include>
        </div>
    </div>

</div>

</body>
</html>
