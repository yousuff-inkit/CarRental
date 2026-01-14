<html>
<% String contextPath=request.getContextPath();%>
<head>

<link href="<%=contextPath%>/css/jqx-10.1.6/jqx.base.css" rel="stylesheet"  type="text/css" />
<link href="<%=contextPath%>/css/table.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath%>/css/myButton.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.mobile.css" media="screen" rel="stylesheet" type="text/css" /> 
<link href="<%=contextPath%>/css/jqx.energyblue.css" media="screen" rel="stylesheet" type="text/css" />  
<link rel="stylesheet" type="text/css"
      href="<%=contextPath%>/css/jqx-date-global.css" />


    <script type="text/javascript" src="<%=contextPath%>/js/jquery-1.11.1.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxcore.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/demos.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatetimeinput.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxcalendar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxmenu.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtabs.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxbuttons.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxscrollbar.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqx-10.1.6/jqxgrid.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.edit.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.filter.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdata.js"></script> 
    <script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxpanel.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxlistbox.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="<%=contextPath%>/js/jqxcheckbox.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxtooltip.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/globalize.js"></script>  
	<script type="text/javascript" src="<%=contextPath%>/js/jqxwindow.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtree.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.aggregates.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxexpander.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdatatable.js"></script>
  	<script type="text/javascript" src="<%=contextPath%>/js/jqxtreegrid.js"></script>
	
	<%-- <script type="text/javascript" src="<%=contextPath%>/js/alert/jquery-1.4.4.min.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/alert/jquery.easyui.min.js"></script>--%>
	
	<script type="text/javascript" src="<%=contextPath%>/js/jqxchart.core.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdraw.js"></script>
	<%--<script type="text/javascript" src="<%=contextPath%>/js/jqxslider.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxradiobutton.js"></script> --%>
	
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=contextPath%>/css/icon.css">
  	
  	<script type="text/javascript" src="<%=contextPath%>/js/additional-methods.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jquery.validate.min.js"></script>
	
	<script type="text/javascript" src="<%=contextPath%>/js/pace.min.js"></script>
	<script type="text/javascript" src="<%=contextPath%>/js/jqxdata.export.js"></script> 
	<script type="text/javascript" src="<%=contextPath%>/js/jqxgrid.export.js"></script> 
	 <script type="text/javascript" src="<%=contextPath%>/js/jqxinput.js"></script>
	 <script type="text/javascript" src="<%=contextPath%>/js/exportExcel.js"></script>
	 
	 <link href="<%=contextPath%>/css/body.css" media="screen" rel="stylesheet" type="text/css" />
	 
	 
	 <script>
$(function () {
    $('input[placeholder^="Press F3" i]').each(function () {

        // add title only if not already set
        if (!this.title || this.title.trim() === "") {
            this.title = "Double click on this to search";
        }
    });
});

	 
	 
<!-- Fullscreen page loader (used only for page actions) -->

function showLoader() {
    var loader = document.getElementById("pageLoader");
    if (loader) loader.style.display = "flex";
}

function hideLoader() {
    var loader = document.getElementById("pageLoader");
    if (loader) loader.style.display = "none";
}



<!-- HIDE fullscreen loader when any jqxGrid finishes loading -->

if (window.$ && $.jqx) {
    $(document).on("bindingcomplete", ".jqx-grid", function () {
        hideLoader();
    });
}



<!-- =============== POPUP LOADER (ONLY INSIDE #window) =============== -->


// create popup loader if not exists
function attachPopupLoader() {
    if ($("#window .popup-loader").length === 0) {
        
$("#window .popup-loader").css("display", "flex");
        $("#window .jqx-window-content").append(`
            <div class="popup-loader">
                <div class="spinner"></div>
                <div class="loader-text">
                    <div class="hourglass"></div>
                    <span>Loading Please wait</span>
                </div>
            </div>
        `);
    }
}




function showPopupLoader() {
    attachPopupLoader();
    $("#window .popup-loader").css("display", "flex");
}

function hidePopupLoader() {
    $("#window .popup-loader").hide();
}



<!-- Show popup loader ONLY when popup Search button is clicked -->

$(document).on("click", "#window button, #window input[type='button']", function () {

    var text = ($(this).text() || $(this).val() || "")
        .trim().toLowerCase();

    if (text === "search") {
        showPopupLoader();   
    }
});

function showAccountPopupLoader() {
    attachAccountPopupLoader();
    
    $("#accountPopupLoader").css("display", "flex");
}

<!-- Hide popup loader after grid loads -->

$(document).on("bindingcomplete", "#window .jqx-grid", function () {
    hidePopupLoader();
});
</script>











<script>
function attachAccountPopupLoader() {

    if ($("#search #accountPopupLoader").length === 0) {

        $("#search").css("position", "relative");

        $("#search").append(`
            <div id="accountPopupLoader" class="popup-loader">
                <div class="spinner"></div>
                <div class="loader-text">
                <div class="hourglass"></div>
                <span>Loading Please wait</span>
                </div>
            </div>
        `);
    }
}
</script>

<script>
function showAccountPopupLoader() {
    attachAccountPopupLoader();
    $("#accountPopupLoader").css("display", "flex");
}

function hideAccountPopupLoader() {
    $("#accountPopupLoader").hide();
}
</script>


<script>
$(document).on("click", "#btnAccountSearch", function () {
    showAccountPopupLoader();
});
</script>


<script>
$(document).on("bindingcomplete", "#jqxAccountsSearch", function () {
    hideAccountPopupLoader();
});
</script>


</head> 
</html>
