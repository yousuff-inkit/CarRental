<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
	String contextPath=request.getContextPath();
 %>
 <link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="../../../../css/body.css"/>
        <style>
/* Scoped styles using .dashboard-header-wrapper class */
.dashboard-header-wrapper {
    --shadow-light: #ffffff;
    --shadow-dark: #d0d0d0;
    --primary-color: #2c3e50;
    --secondary-color: #34495e;
    --accent-color: #3498db;
    --bg-grey: #e8e8e8;
    --bg-grey-light: #f0f0f0;
    font-family: 'Poppins', sans-serif;
    max-height: 600px;
    overflow-y: auto;
    padding: 20px;
    background: linear-gradient(135deg, #ffffff 0%, #f5f5f5 100%);
}

/* Custom Scrollbar */
.dashboard-header-wrapper::-webkit-scrollbar {
    width: 10px;
}

.dashboard-header-wrapper::-webkit-scrollbar-track {
    background: #f1f1f1;
    border-radius: 10px;
}

.dashboard-header-wrapper::-webkit-scrollbar-thumb {
    background: #b0b0b0;
    border-radius: 10px;
}

.dashboard-header-wrapper::-webkit-scrollbar-thumb:hover {
    background: #909090;
}

/* Header Container */
.dashboard-header-wrapper .header-container {
    padding: 15px;
    text-align: center;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 16px;
    margin-bottom: 20px;
    box-shadow: -4px -4px 10px rgba(255, 255, 255, 0.8),
                4px 4px 10px rgba(0, 0, 0, 0.1);
}

/* Header Labels */
.dashboard-header-wrapper #lbldetail {
    font-size: 24px;
    font-weight: 500;
    color: var(--primary-color);
}

.dashboard-header-wrapper #lbldetailname {
    font-size: 22px;
    font-weight: 400;
    color: var(--secondary-color);
}

.dashboard-header-wrapper .separator {
    font-size: 22px;
    font-weight: 500;
    color: #7f8c8d;
}

/* Button Grid */
.dashboard-header-wrapper .btn-grid {
    display: grid;
    grid-template-columns: repeat(4, 90px);
    justify-content: center;
    column-gap: 8px;
    row-gap: 4px;
    width: 100%;
    margin: 20px 0;
}

/* Modern Grey Buttons */
.dashboard-header-wrapper .nbtn {
    min-width: 90px;
    padding: 5px 8px;
    border-radius: 12px;
    background: linear-gradient(145deg, #ffffff, #f5f5f5);
    border: 1px solid #e0e0e0;
    color: var(--primary-color);
    font-weight: 600;
    font-size: 10px;
    font-family: "Poppins", sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: -4px -4px 10px rgba(255, 255, 255, 0.9),
                4px 4px 10px rgba(0, 0, 0, 0.1);
}

.dashboard-header-wrapper .nbtn:hover {
    transform: translateY(-2px);
    background: linear-gradient(145deg, #ffffff, #eeeeee);
    box-shadow: -6px -6px 14px rgba(255, 255, 255, 1),
                6px 6px 14px rgba(0, 0, 0, 0.15);
}

.dashboard-header-wrapper .nbtn:active {
    transform: translateY(0);
    box-shadow: inset -2px -2px 6px rgba(255, 255, 255, 0.7),
                inset 2px 2px 6px rgba(0, 0, 0, 0.15);
}

.dashboard-header-wrapper .nbtn img {
    width: 10px;
    height: 10px;
    filter: none;
    opacity: 0.8;
}

.dashboard-header-wrapper .nbtn svg {
    width: 10px;
    height: 10px;
}

/* Branch Section */
.dashboard-header-wrapper .branch-section {
    display: flex;
    align-items: center;
    gap: 15px;
    margin: 20px 0;
    padding: 0 20px;
}

.dashboard-header-wrapper .branch-label-wrapper {
    min-width: 80px;
    text-align: right;
}

.dashboard-header-wrapper #branchlabel {
    font-size: 10px;
    font-weight: 600;
    color: var(--primary-color);
}

.dashboard-header-wrapper .branch-select-wrapper {
    flex: 1;
    max-width: 69%;
}

/* Styled Select Dropdown */
.dashboard-header-wrapper .styled-select {
    background: linear-gradient(145deg, #ffffff, #f5f5f5);
    padding: 12px 16px;
    width: 100%;
    border-radius: 14px;
    box-shadow: inset -4px -4px 10px rgba(255, 255, 255, 0.8),
                inset 4px 4px 10px rgba(0, 0, 0, 0.08);
    border: 1px solid #e0e0e0;
}

.dashboard-header-wrapper .styled-select select {
    width: 100%;
    border: none;
    background: transparent;
    font-size: 10px;
    font-weight: 500;
    color: var(--primary-color);
    outline: none;
    cursor: pointer;
}

.dashboard-header-wrapper .styled-select select option {
    background: #ffffff;
    color: var(--primary-color);
    padding: 8px;
}

/* Submit Section */
.dashboard-header-wrapper .submit-section {
    padding: 5px 10px;
}

.dashboard-header-wrapper .submit-container {
    display: flex;
    
    max-width: 70%;
    margin-left: 55px;
}

.dashboard-header-wrapper #btnSubmit {
    max-width: 120px;
    padding: 4px 6px;
}</style>
        <script type="text/javascript">
            $(document).ready(function () {

                document.addEventListener('contextmenu', event => event.preventDefault());

                $("body").prepend('<div id="overlay1" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
                $("body").prepend("<div id='PleaseWait1' style='display: none;position:absolute; z-index: 1;top:200px;right:750px;'><img src='../../../../icons/31load.gif'/></div>");

                <%String main2=request.getParameter("main")==null?"":request.getParameter("main");
                String name2=request.getParameter("name")==null?"":request.getParameter("name");
                String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
                String value=request.getParameter("value")==null?"":request.getParameter("value");%>


                document.getElementById("txtallbrch").value = '<%=value%>';
                if ($('#detailname').val() == "") {
                    document.getElementById("lbldetailname").innerText = '<%=name2%>';
                    document.getElementById("lbldetail").innerText = '<%=main2.equalsIgnoreCase("0")?"Vehicle":main2%>';
                    $('#detail').val(document.getElementById("lbldetail").innerText);
                    $('#detailname').val(document.getElementById("lbldetailname").innerText);

                    document.getElementById("txtdetailpermissiondocno").value = '<%=docno%>';
                } else {
                    document.getElementById("lbldetailname").innerText = $('#detailname').val();
                    document.getElementById("lbldetail").innerText = $('#detail').val();
                    document.getElementById("txtdetailpermissiondocno").value = '<%=docno%>';
                }

                $('#windowattach').jqxWindow({
                    width: '51%',
                    height: '61%',
                    maxHeight: '70%',
                    maxWidth: '51%',
                    title: 'Attach',
                    position: {x: 300, y: 87},
                    theme: 'energyblue',
                    showCloseButton: true
                });
                $('#windowattach').jqxWindow('close');

                $('#windowguideline').jqxWindow({
                    width: '78%',
                    height: '85%',
                    maxHeight: '85%',
                    maxWidth: '78%',
                    title: 'Guideline',
                    position: {x: 280, y: 10},
                    theme: 'energyblue',
                    showCloseButton: true,
                    showCollapseButton: true
                });
                $('#windowguideline').jqxWindow('close');

                $("input").click(function (evt) {
                    this.placeholder = '';
                });

                funChkHeaderButton();
            });

            function funDateInPeriod(value) {
                var styear = new Date(window.parent.txtaccountperiodfrom.value);
                var edyear = new Date(window.parent.txtaccountperiodto.value);
                var mclose = new Date(window.parent.monthclosed.value);
                mclose.setHours(0, 0, 0, 0);
                edyear.setHours(0, 0, 0, 0);
                styear.setHours(0, 0, 0, 0);
                var currentDate = new Date(new Date());
                //alert(styear+"==="+edyear)
                if (value < styear || value > edyear) {
                    $.messager.alert('Warning', "Transaction prior or after Account Period is not valid.");
                    $('#txtvalidation').val(1);
                    return 0;
                }
                if (value > currentDate) {
                    $.messager.alert('Warning', "Future Date, Transaction Restricted. ");
                    $('#txtvalidation').val(1);
                    return 0;
                }
                if (value <= mclose) {
                    $.messager.alert('Warning', "Closing Done, Transaction Restricted. ");
                    $('#txtvalidation').val(1);
                    return 0;
                }

                $('#txtvalidation').val(0);
                return 1;
            }

            function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {

                var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;

                // alert("arrData");
                var CSV = '';
                //Set Report title in first row or line

                CSV += ReportTitle + '\r\n\n';

                //This condition will generate the Label/Header
                if (ShowLabel) {
                    var row = "";

                    //This loop will extract the label from 1st index of on array
                    for (var index in arrData[0]) {

                        //Now convert each value to string and comma-seprated
                        row += index + ',';
                    }

                    row = row.slice(0, -1);

                    //append Label row with line break
                    CSV += row + '\r\n';
                }

                //1st loop is to extract each row
                for (var i = 0; i < arrData.length; i++) {
                    var row = "";

                    //2nd loop will extract each column and convert it in string comma-seprated
                    for (var index in arrData[i]) {
                        row += '"' + arrData[i][index] + '",';
                    }

                    row.slice(0, row.length - 1);

                    //add a line break after each row
                    CSV += row + '\r\n';
                }

                if (CSV == '') {
                    alert("Invalid data");
                    return;
                }

                //Generate a file name
                var fileName = "";
                //this will remove the blank-spaces from the title and replace it with an underscore
                fileName += ReportTitle.replace(/ /g, "_");

                // newly added
                var temp = CSV;
                blob = new Blob([temp], {type: 'text/csv'});
                var bigcsv = window.webkitURL.createObjectURL(blob);


                //Initialize file format you want csv or xls
                //  var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);

                // Now the little tricky part.
                // you can use either>> window.open(uri);
                // but this will not work in some browsers
                // or you will not get the correct file extension

                //this trick will generate a temp <a /> tag
                var link = document.createElement("a");
                //  link.href = uri;
                link.href = bigcsv;

                //set the visibility hidden so it will not effect on your web-layout
                link.style = "visibility:hidden";
                link.download = fileName + ".csv";

                //this part will append the anchor tag and remove it after automatic click
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }

            function JSONToSIFCon(JSONData, ReportTitle, ShowLabel) {
                var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;

                var SIF = '';

                for (var i = 0; i < arrData.length; i++) {

                    var row = "";

                    for (var index in arrData[i]) {
                        row += '' + arrData[i][index] + ',';
                    }

                    row.slice(0, row.length - 1);

                    SIF += row.slice(0, -1) + '\r\n';

                }

                if (SIF == '') {
                    alert("Invalid data");
                    return;
                }

                var fileName = "";
                fileName += ReportTitle.replace(/ /g, "_");

                var uri = 'data:text/csv;charset=utf-8,' + escape(SIF);
                var link = document.createElement("a");
                link.href = uri;

                link.style = "visibility:hidden";
                link.download = fileName + ".sif";

                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }

            function funDateInPeriodNew(value) {
                //Date Validation Method without Future date Validation
                var styear = new Date(window.parent.txtaccountperiodfrom.value);
                var edyear = new Date(window.parent.txtaccountperiodto.value);
                var mclose = new Date(window.parent.monthclosed.value);
                mclose.setHours(0, 0, 0, 0);
                edyear.setHours(0, 0, 0, 0);
                styear.setHours(0, 0, 0, 0);
                var currentDate = new Date(new Date());
                if (value < styear || value > edyear) {
                    $.messager.alert('Warning', "Transaction prior or after Account Period is not valid.");
                    $('#txtvalidation').val(1);
                    return 0;
                }

                if (value <= mclose) {
                    $.messager.alert('Warning', "Closing Done, Transaction Restricted. ");
                    $('#txtvalidation').val(1);
                    return 0;
                }

                $('#txtvalidation').val(0);
                return 1;
            }

            function funIBDateInPeriod(date, branch) {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function () {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        items = items.split('***');
                        var monthCloseDate = items[0];
                        var monthClose = items[1];
                        var Date = items[2].trim();

                        if (parseInt(monthClose) == 1) {
                            $.messager.alert('Message', 'Closing Done on ' + Date + ' For Inter-Branch, Transaction Restricted. ', 'warning');
                            $('#txtibvalidation').val(1);
                            $('#txtibbranchid').val('');
                            $('#txtibbranch').val('');

                            if (document.getElementById("txtibbranch").value == "") {
                                $('#txtibbranch').attr('placeholder', 'Press F3 to Search');
                            }

                            return 0;
                        }

                        $('#txtibvalidation').val(0);
                        return 1;
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/getIBMonthClose.jsp?date=" + date + "&branch=" + branch, true);
                x.send();
            }

            function funChkHeaderButton() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function () {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        items = items.split('##');

                        var email = items[0].split(",");
                        var excel = items[1].split(",");

                        if (parseInt(email) == 0) {
                            $("#btnSendingEmail").attr('disabled', true);
                        } else {
                            $("#btnSendingEmail").attr('disabled', false);
                        }

                        if (parseInt(excel) == 0) {
                            $("#btnExcel").attr('disabled', true);
                        } else {
                            $("#btnExcel").attr('disabled', false);
                        }


                    } else {
                    }
                }

                x.open("GET", "<%=contextPath%>/com/dashboard/chkheaderbuttons.jsp?docno=" + $('#txtdetailpermissiondocno').val().trim(), true);
                x.send();

            }

            function getMessengerCount() {
                var x = new XMLHttpRequest();
                var msgcnt;
                var user;
                x.onreadystatechange = function () {

                    if (x.readyState == 4 && x.status == 200) {

                        items = x.responseText;

                        items = items.trim().split('####');
                        user = items[0];
                        msgcnt = items[1];

                        if (msgcnt > 0) {
                            window.parent.document.getElementById("iconnm").style.display = 'none';
                            window.parent.document.getElementById("iconym").style.display = 'inline-block';
                        } else {
                            window.parent.document.getElementById("iconym").style.display = 'none';
                            window.parent.document.getElementById("iconnm").style.display = 'inline-block';

                        }


                    } else {
                    }
                }
                x.open("GET", <%=contextPath+"/"%>+"com/messenger/getMsgCount.jsp", true);
                x.send();
            }

            function changeDashBoardAttachContent(url) {
                $.get(url).done(function (data) {
                    $('#windowattach').jqxWindow('open');
                    $('#windowattach').jqxWindow('setContent', data);
                    $('#windowattach').jqxWindow('bringToFront');
                });
            }

            function changeDashBoardGuidelineContent(url) {
                $('#windowguideline').jqxWindow('focus');
                $.get(url).done(function (data) {
                    $('#windowguideline').jqxWindow('setContent', data);
                });
            }

            function getBranch() {
                var x = new XMLHttpRequest();
                x.onreadystatechange = function () {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText;
                        //alert(items);
                        items = items.split('####');

                        var branchIdItems = items[0].split(",");
                        var branchItems = items[1].split(",");
                        var perm = items[2];
                        var optionsbranch;
//				alert($('#txtallbrch').val()+"===="+$('#txtallbrch').val()==99);
                        if (perm == 0 || $('#txtallbrch').val() == 99) {
                            optionsbranch = '<option value="a" selected>All</option>';
                        } else {

                        }
                        for (var i = 0; i < branchItems.length; i++) {
                            optionsbranch += '<option value="' + branchIdItems[i].trim() + '">'
                                + branchItems[i] + '</option>';
                        }
                        $("select#cmbbranch").html(optionsbranch);
                        /* if ($('#hidcmbbranch').val() != null) {
                            $('#cmbbranch').val($('#hidcmbbranch').val());
                        } */
                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/getBranch.jsp", true);
                x.send();
            }

            function funRoundAmt(value, id) {
                var res = parseFloat(value).toFixed(window.parent.amtdec.value);
                var res1 = (res == 'NaN' ? "0" : res);
                document.getElementById(id).value = res1;
            }

            function funRoundRate(value, id) {
                var res = parseFloat(value).toFixed(window.parent.curdec.value);
                var res1 = (res == 'NaN' ? "0" : res);
                document.getElementById(id).value = res1;
            }

            function funGuideline() {

                $('#windowguideline').jqxWindow('setContent', '');
                $('#windowguideline').jqxWindow('open');

                changeDashBoardGuidelineContent("<%=contextPath%>/com/dashboard/viewDashBoardGuideline.action?formDetail=" + document.getElementById("lbldetail").innerText + "&formDetailName=" + document.getElementById("lbldetailname").innerText);
            }

            function funMclose(value) {

                if (value == "a") {
                    window.parent.monthclosed.value = window.parent.txtaccountperiodfrom.value;
                    return 0;
                }

                var x = new XMLHttpRequest();
                x.onreadystatechange = function () {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (items != 'null') {

                            window.parent.monthclosed.value = items;
                        } else {


                            window.parent.monthclosed.value = window.parent.txtaccountperiodfrom.value;
                        }

                    } else {
                        //alert("Error");
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/getMclose.jsp?branch=" + value, true);
                x.send();
            }

            function getformbranch() {
                $('#cmbbranch').attr('disabled', false);
                var branchval = document.getElementById('cmbbranch').value;
                if ($('#cmbbranch').val() != null && $('#cmbbranch').val() != 'a') {
                    window.parent.branchid.value = $('#cmbbranch').val();
                }

                var x = new XMLHttpRequest();
                x.onreadystatechange = function () {
                    if (x.readyState == 4 && x.status == 200) {
                        var items = x.responseText.trim();
                        if (parseInt(items) == 0) {


                            // $.messager.alert('Message','Your Secure Session Has Expired ,Please Login Again.....!','warning');
                            $.messager.confirm('Confirm', 'Your Secure Session Has Expired ,Please Login Again.....!', function (r) {
                                if (r) {
                                    window.parent.location.href = <%=contextPath+"/"%>+"login.jsp";
                                }
                            });


                            /* window.history.back(); */

                            Exit();
                            return 0;
                        }
                    }
                }
                x.open("GET", "<%=contextPath%>/com/dashboard/sessionset.jsp?sessionbrch=" + branchval, true);
                x.send();

            }

        </script>
</head>
<body onclick="getformbranch();">
<div class="dashboard-header-wrapper">
    <!-- ===== HEADER ===== -->
    <div class="header-container">
        <label id="lbldetail"></label>
        <span class="separator"> - </span>
        <label id="lbldetailname"></label>
    </div>

    <!-- ===== BUTTON GRID ===== -->
    <div class="btn-grid">
        <button type="button" class="nbtn" id="btnGuideline" onclick="funGuideline();">
            <img src="<%=contextPath%>/icons/guidelinedb.png" alt=""> Guideline
        </button>

        <button type="button" class="nbtn" id="btnSendingEmail" onclick="funSendingEmail();">
            <img src="<%=contextPath%>/icons/sendemail.png" alt=""> Email
        </button>

        <button type="button" class="nbtn" id="btnExcel" onclick="funExportBtn();">
            <img src="<%=contextPath%>/icons/excel_new.png" alt=""> Export
        </button>

        <button type="button" class="nbtn" id="btnCalculate" onclick="funCalculate();">
            <img src="<%=contextPath%>/icons/calculate_new.png" alt=""> Calculate
        </button>
    </div>

    <!-- ===== BRANCH SECTION ===== -->
    <div class="branch-section">
        <div class="branch-label-wrapper">
            <label id="branchlabel">Branch</label>
        </div>

        <div class="branch-select-wrapper">
            <div class="styled-select" id="branchdiv">
                <select id="cmbbranch" name="cmbbranch" onchange="funMclose(this.value);getformbranch();">
                    <option value="">--Select--</option>
                </select>
            </div>
        </div>
    </div>

    <!-- ===== SUBMIT BUTTON ===== -->
    <div class="submit-section">
        <div class="submit-container">
            <button type="button" class="nbtn" id="btnSubmit" onclick="funreload(event);">
                <svg width="18" height="18" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M5 12l5 5V7l-5 5zm6-5v10l8-5-8-5z"/>
                </svg>
                Submit
            </button>
        </div>
    </div>

    <!-- ===== REMAINING HIDDEN FIELDS & WINDOWS ===== -->
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" name="detail" id="detail" value="<s:property value="detail"/>" />
    <input type="hidden" name="detailname" id="detailname" value="<s:property value="detailname"/>" />
    <input type="hidden" name="txtdetailpermissiondocno" id="txtdetailpermissiondocno" value="<s:property value="txtdetailpermissiondocno"/>" />
    <input type="hidden" name="txtallbrch" id="txtallbrch" value="<s:property value="txtallbrch"/>" />

    <div id="windowattach"><div></div></div>
    <div id="windowguideline"><div></div></div>
</div>
</body>