<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>

<jsp:include page="../../../../includes.jsp"></jsp:include>

<!-- ====================================================== -->
<!--      JAVASCRIPT (NO CHANGES MADE, JUST CLEANED)        -->
<!-- ====================================================== -->
<script type="text/javascript">

$(document).ready(function() {

    $('#btnEdit').attr('disabled', true);
    $('#btnDelete').attr('disabled', true);
    $('#btnAttach').attr('disabled', true);

    $("#terminationDate").jqxDateTimeInput({ formatString:"dd.MM.yyyy" });
    $("#notifyDate").jqxDateTimeInput({ formatString:"dd.MM.yyyy" });
    $("#joiningDate").jqxDateTimeInput({ formatString:"dd.MM.yyyy", value:null });
    $("#appraisalDate").jqxDateTimeInput({ formatString:"dd.MM.yyyy", value:null });

    $('#employeeDetailsWindow').jqxWindow({
        width: '51%',
        height: '58%',
        maxHeight: '70%',
        maxWidth: '51%',
        title: 'Employees Search',
        position: { x: 300, y: 87 },
        theme: 'energyblue',
        showCloseButton: true,
        keyboardCloseKey: 27
    });

    $('#employeeDetailsWindow').jqxWindow('close');
});


/* your existing functions stay unchanged... */
</script>

<!-- ====================================================== -->
<!--             ⭐ FINAL USERMASTER STYLE ⭐                -->
<!-- ====================================================== -->
<style>

body {
    background: #E6EEFF !important;
    font-family: 'Segoe UI', sans-serif !important;
    margin: 0;
    padding: 0;
    font-size: 16px;
}

/* MAIN CARD */
#mainBG {
    background: #fff !important;
    padding: 35px 40px !important;
    max-width: 1250px !important;
    border-radius: 15px !important;
    margin: 30px auto !important;
    box-shadow: 0 4px 18px rgba(0,0,0,0.08) !important;
}

/* SECTION HEADER */
.section-title {
    font-size: 20px;
    font-weight: 600;
    color: #233A6A;
    margin-bottom: 20px;
}

/* SECTION BOX */
.section-box {
    background: white;
    border-radius: 14px;
    padding: 30px;
    margin-bottom: 35px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.05);
}

/* GRID (4 Columns like UserMaster) */
.form-grid {
    display: grid;
    grid-template-columns: 18% 32% 18% 32%;
    column-gap: 35px;
    row-gap: 26px;
    align-items: center;
}

/* LABELS */
.form-label {
    font-weight: 600;
    color: #233A6A;
    text-align: right;
    padding-right: 12px;
}

/* INPUTS */
.form-input, .form-select {
    width: 100%;
    height: 42px;
    border-radius: 8px;
    border: 1px solid #C9D4E6;
    background: #FFFFFF;
    padding: 10px 12px;
    font-size: 15px;
}

/* JQX DATETIME INPUT FIX */
#terminationDate, #notifyDate, #joiningDate, #appraisalDate {
    width: 100% !important;
    height: 42px !important;
}

.jqx-widget, .jqx-widget-content, .jqx-input {
    width: 100% !important;
    height: 42px !important;
    line-height: 42px !important;
    border-radius: 8px !important;
}

.jqx-input-content {
    padding-left: 10px !important;
    padding-top: 10px !important;
    font-size: 15px !important;
}

.jqx-calendar-button, .jqx-action-button {
    margin-top: 6px !important;
}

/* BUTTONS */
.action-btn {
    background: #1A73E8;
    border: none;
    color: white;
    padding: 10px 22px;
    border-radius: 6px;
    cursor: pointer;
}

.action-btn:hover {
    background: #0F5FCC;
}
/* ========================================================== */
/*   FINAL OVERRIDE — THIS FORCES THE ALIGNMENT TO APPLY     */
/* ========================================================== */

#mainBG .form-grid {
    display: grid !important;
    grid-template-columns: 180px 350px 180px 350px !important;
    column-gap: 35px !important;
    row-gap: 26px !important;
    align-items: center !important;
}

#mainBG .form-label {
    text-align: right !important;
    font-size: 16px !important;
    font-weight: 600 !important;
    color: #233A6A !important;
    padding-right: 12px !important;
}

#mainBG .form-input,
#mainBG .form-select {
    width: 100% !important;
    height: 42px !important;
    font-size: 15px !important;
    border: 1px solid #C9D4E6 !important;
    padding: 10px 12px !important;
    border-radius: 8px !important;
}

/* jqx Date Fields Full Override */
#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate,
#terminationDate .jqx-widget,
#notifyDate .jqx-widget,
#joiningDate .jqx-widget,
#appraisalDate .jqx-widget {
    width: 100% !important;
    height: 42px !important;
}

.jqx-widget,
.jqx-widget-content,
.jqx-input {
    height: 42px !important;
    border-radius: 8px !important;
    border: 1px solid #C9D4E6 !important;
}

.jqx-input-content {
    padding-top: 10px !important;
    padding-left: 10px !important;
    font-size: 15px !important;
}

.jqx-calendar-button, .jqx-action-button {
    margin-top: 6px !important;
}
/* ========================================================== */
/*   SMALLER TEXTBOX + DATE FIELD SIZE (UserMaster style)     */
/* ========================================================== */

#mainBG .form-input,
#mainBG .form-select,
#mainBG .jqx-widget,
#mainBG .jqx-widget-content,
#mainBG .jqx-input {
    height: 34px !important;
    line-height: 34px !important;
    padding: 6px 10px !important;
    font-size: 14px !important;
}

.jqx-input-content {
    padding-top: 6px !important;
    font-size: 14px !important;
}

#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    height: 34px !important;
}

/* Reduce column width for smaller input look */
#mainBG .form-grid {
    grid-template-columns: 150px 280px 150px 280px !important;
}
/* ========================================================== */
/*        ⭐ MEDIUM SIZE TEXTBOX + DATE FIELD STYLE ⭐         */
/* ========================================================== */

/* Medium input + select size */
#mainBG .form-input,
#mainBG .form-select,
#mainBG .jqx-widget,
#mainBG .jqx-widget-content,
#mainBG .jqx-input {
    height: 38px !important;
    line-height: 38px !important;
    padding: 8px 12px !important;
    font-size: 15px !important;
    border-radius: 8px !important;
}

/* Medium date text alignment */
.jqx-input-content {
    padding-top: 8px !important;
    padding-left: 10px !important;
    font-size: 15px !important;
}

/* Medium date widgets */
#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    height: 38px !important;
}

/* Adjust column widths for medium size */
#mainBG .form-grid {
    grid-template-columns: 160px 310px 160px 310px !important;
}
/* ========================================================== */
/*        ⭐ SMALL SIZE TEXTBOX + DATE FIELD STYLE ⭐          */
/* ========================================================== */

/* Small inputs */
#mainBG .form-input,
#mainBG .form-select,
#mainBG .jqx-widget,
#mainBG .jqx-widget-content,
#mainBG .jqx-input {
    height: 32px !important;
    line-height: 32px !important;
    padding: 5px 10px !important;
    font-size: 14px !important;
    border-radius: 6px !important;
}

/* Small date text alignment */
.jqx-input-content {
    padding-top: 5px !important;
    padding-left: 10px !important;
    font-size: 14px !important;
}

/* Apply small height to date containers */
#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    height: 32px !important;
}

/* Smaller column sizes for compact look */
#mainBG .form-grid {
    grid-template-columns: 140px 260px 140px 260px !important;
}

/* ========================================================== */
/*        ⭐ PREMIUM BLUE LABELS (Luxury ERP Blue) ⭐          */
/* ========================================================== */

#mainBG .form-label {
    color: #0B4F9F !important;   /* Premium blue */
    font-weight: 600 !important;
}
/* ========================================================== */
/*  ⭐ FIX: JQX CALENDAR POPUP + DATE INPUT FUNCTIONALITY ⭐   */
/* ========================================================== */

/* Allow jqx date widget to auto-handle internal height */
#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    height: auto !important;
}

/* Fix the main jqx input box */
.jqx-widget,
.jqx-widget-content,
.jqx-input {
    min-height: 32px !important;   /* small size but not restrictive */
    height: auto !important;
    line-height: normal !important;
}

/* Fix text alignment inside date input */
.jqx-input-content {
    padding-top: 6px !important;
    padding-bottom: 6px !important;
    font-size: 14px !important;
}

/* FIX: Calendar dropdown not opening fully */
.jqx-popup,
.jqx-calendar,
.jqx-calendar-content {
    z-index: 999999 !important; /* bring calendar to front */
}

/* FIX: Calendar gets cut due to parent overflow */
#mainBG,
.section-box {
    overflow: visible !important;
}
/* ⭐ FINAL FIX — Correct Date Height + Calendar Working ⭐ */

#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
    display: block !important;
    height: 32px !important;          /* your required small size */
    min-height: 32px !important;
}

#terminationDate .jqx-widget,
#notifyDate .jqx-widget,
#joiningDate .jqx-widget,
#appraisalDate .jqx-widget,
.jqx-widget,
.jqx-widget-content,
.jqx-input {
    height: 32px !important;
    min-height: 32px !important;
    line-height: 32px !important;
    border-radius: 6px !important;
}

.jqx-input-content {
    padding-top: 6px !important;
    padding-bottom: 6px !important;
    font-size: 14px !important;
}

/* Fix calendar popup cutting issue */
.jqx-popup,
.jqx-calendar,
.jqx-calendar-content {
    z-index: 999999 !important;
}

/* Prevent container from hiding calendar */
#mainBG,
.section-box {
    overflow: visible !important;
}
/* === FORCE: jqx date inputs exact small height + popup safety === */

#terminationDate,
#notifyDate,
#joiningDate,
#appraisalDate {
  display: block !important;
  width: 100% !important;
  min-height: 32px !important;
  height: 32px !important;      /* small size you wanted */
  box-sizing: border-box !important;
}

/* Ensure internal jqx elements obey the size */
#terminationDate .jqx-widget,
#notifyDate .jqx-widget,
#joiningDate .jqx-widget,
#appraisalDate .jqx-widget,
.jqx-widget,
.jqx-widget-content,
.jqx-input {
  width: 100% !important;
  min-height: 32px !important;
  height: 32px !important;
  line-height: 32px !important;
  border-radius: 6px !important;
  box-sizing: border-box !important;
}

/* text area inside jqx */
.jqx-input-content {
  padding-top: 6px !important;
  padding-bottom: 6px !important;
  padding-left: 8px !important;
  font-size: 14px !important;
  box-sizing: border-box !important;
}

/* Make sure calendar popup is on top */
.jqx-popup, .jqx-calendar, .jqx-calendar-content {
  z-index: 999999 !important;
}

/* Prevent parent containers clipping the popup */
#mainBG, .section-box {
  overflow: visible !important;
}

</style>
</head>

<body onload="setValues();">

<div id="mainBG">

<form id="frmTermination" action="saveTermination" method="post">
<jsp:include page="../../../../header.jsp"></jsp:include>

<br>

<!-- ===================== -->
<!-- TERMINATION DETAILS -->
<!-- ===================== -->
<div class="section-box">
    <div class="section-title">Termination Details</div>

    <div class="form-grid">
        <label class="form-label">Date</label>
        <div id="terminationDate"></div>

        <label class="form-label">Doc No.</label>
        <input type="text" class="form-input" id="docno"
               name="txtterminationdocno"
               value='<s:property value="txtterminationdocno"/>' readonly>
    </div>
</div>
<!-- ===================== -->
<!-- EMPLOYEE DETAILS -->
<!-- ===================== -->
<div class="section-box">
    <div class="section-title">Employee Details</div>

    <div class="form-grid">

        <label class="form-label">Employee ID</label>
        <input type="text" class="form-input" id="txtemployeeid"
               placeholder="Press F3 to Search"
               onkeydown="getEmployeeDetails(event);"
               value='<s:property value="txtemployeeid"/>'>

        <label class="form-label">Employee Name</label>
        <input type="text" class="form-input" id="txtemployeename"
               value='<s:property value="txtemployeename"/>' readonly>

        <label class="form-label">Designation</label>
        <input type="text" class="form-input" id="txtemployeedesignation"
               value='<s:property value="txtemployeedesignation"/>' readonly>

        <label class="form-label">Department</label>
        <input type="text" class="form-input" id="txtemployeedepartment"
               value='<s:property value="txtemployeedepartment"/>' readonly>

        <label class="form-label">Category</label>
        <input type="text" class="form-input" id="txtemployeecategory"
               value='<s:property value="txtemployeecategory"/>' readonly>

        <label class="form-label">Notify Date</label>
        <div id="notifyDate"></div>

        <label class="form-label">Type</label>
        <select id="cmbtype" name="cmbtype" class="form-select">
            <option value="TER">Termination</option>
            <option value="RES">Resignation</option>
        </select>

        <label class="form-label">Date of Join</label>
        <div id="joiningDate"></div>

        <label class="form-label">Appraisal Date</label>
        <div id="appraisalDate"></div>

    </div>

    <div style="margin-top:25px; display:flex; gap:20px;">
        <button type="button" id="btnProcessing" class="action-btn"
                onclick="funProcessBtn();">Process</button>

        <button type="button" id="btnCalculate" class="action-btn"
                onclick="funCalculateBtn();">Calculate</button>
    </div>
</div>


<!-- ===================== -->
<!-- SETTLEMENT GRID -->
<!-- ===================== -->
<div class="section-box">
    <div class="section-title">Settlement Details</div>

    <div id="terminationDiv">
        <jsp:include page="terminationGrid.jsp"></jsp:include>
    </div>
</div>


<!-- ===================== -->
<!-- ACCOUNT SUMMARY GRID -->
<!-- ===================== -->
<div class="section-box">
    <div class="section-title">Account Summary</div>

    <div id="accountDiv">
        <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
    </div>
</div>


<!-- ===================== -->
<!-- TOTALS SECTION -->
<!-- ===================== -->
<div class="section-box">
    <div class="form-grid">

        <label class="form-label">Dr. Total</label>
        <input type="text" id="txtdrtotal" class="form-input"
               value='<s:property value="txtdrtotal"/>' readonly>

        <label class="form-label">Cr. Total</label>
        <input type="text" id="txtcrtotal" class="form-input"
               value='<s:property value="txtcrtotal"/>' readonly>

    </div>
</div>


<!-- ===================== -->
<!-- HIDDEN FIELDS -->
<!-- ===================== -->
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="journalgridlength" name="journalgridlength"/>
<input type="hidden" id="journalsgridlength" name="journalsgridlength"/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="txtgridload" name="txtgridload" value='<s:property value="txtgridload"/>'/>
<input type="hidden" id="txtchkgridload" name="txtchkgridload" value='<s:property value="txtchkgridload"/>'/>
<input type="hidden" id="txtchksalarypaid" name="txtchksalarypaid" value='<s:property value="txtchksalarypaid"/>'/>
<input type="hidden" id="txtchkdate" name="txtchkdate" value='<s:property value="txtchkdate"/>'/>

</form>
</div> <!-- mainBG -->

<div id="employeeDetailsWindow">
   <div></div>
</div>

</body>
</html>
