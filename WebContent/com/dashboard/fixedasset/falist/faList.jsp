<link href="../../../../css/dashboard.css" media="screen"
	rel="stylesheet" type="text/css" />
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%>
<style>
/* ===== MASTER LAYOUT ===== */
.master-container {
	display: flex;
	width: 100%;
	height: 100%;
	font-family: 'Segoe UI', Tahoma, sans-serif;
	background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
	width: 330px;
	flex: 0 0 330px;
	background: #fff;
	border-right: 1px solid #e1e8ed;
	display: flex;
	flex-direction: column;
	height: 100vh;
	box-shadow: 2px 0 8px rgba(0, 0, 0, .05);
}

.sidebar-fixed-top {
	padding: 15px 20px;
	border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
	flex: 1;
	overflow-y: auto;
	padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
	background: #f8fafc;
	border: 1px solid #e3e8ee;
	border-radius: 12px;
	padding: 15px;
	margin-bottom: 12px;
}

/* Tables */
.filter-table {
	width: 100%;
	border-collapse: separate !important;
	border-spacing: 0 14px !important;
}

.label-cell {
	text-align: right;
	padding-right: 10px;
	font-size: 13px;
	font-weight: 600;
	color: #4e5e71;
	width: 90px;
}

/* Inputs */
input[type="text"], select {
	width: 100%;
	padding: 7px 10px;
	border: 1px solid #ccd6e0;
	border-radius: 6px;
	font-size: 13px;
}

/* Buttons */
.btn-submit {
	width: 100%;
	padding: 11px;
	margin-top: 10px;
	background: #2563eb;
	color: #fff;
	border: none;
	border-radius: 6px;
	font-size: 14px;
	font-weight: 600;
	cursor: pointer;
}

.btn-submit:hover {
	background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
	height: 100%;
	margin: 0;
	overflow: hidden;
}

td[width="80%"] {
	height: 100vh;
	vertical-align: top;
	background: #fff;
}
/* 🔹 Inputs + Dropdowns */
input[type="text"], select {
	width: 100%;
	height: 24px !important;
	padding: 0 8px !important;
	border: 1px solid #ccd6e0;
	border-radius: 4px;
	font-size: 13px;
	box-sizing: border-box;
	line-height: 24px;
}

/* 🔹 Dropdown text */
select {
	font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit, .myButtons, .myButton, input[type="button"], button {
	width: 100%;
	height: 24px !important;
	padding: 0 10px !important;
	border-radius: 4px;
	font-size: 13px;
	font-weight: 600;
	box-sizing: border-box;
	line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input, .jqx-widget select {
	height: 24px !important;
	line-height: 24px !important;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {

		/*  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1001; display: none;"></div>');
		    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:200;right:600;'><img src='../../../../icons/31load.gif'/></div>");    
		 */$("#periodupto").jqxDateTimeInput({
			width : '125px',
			height : '15px',
			formatString : "dd.MM.yyyy"
		});
		$('#assetwindow').jqxWindow({
			width : '40%',
			height : '60%',
			maxHeight : '60%',
			maxWidth : '40%',
			title : 'Asset Group Search',
			position : {
				x : 250,
				y : 60
			},
			keyboardCloseKey : 27
		});
		$('#assetwindow').jqxWindow('close');

		$('#assetgrp').dblclick(function() {
			$('#assetwindow').jqxWindow('open');
			$('#assetwindow').jqxWindow('focus');
			assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
		});
	});
	function getAssetGroup(event) {
		var x = event.keyCode;
		if (x == 114) {
			$('#assetwindow').jqxWindow('open');
			$('#assetwindow').jqxWindow('focus');
			assetSearchContent('assetGroupSearch.jsp', $('#assetwindow'));
		} else {
		}
	}
	function assetSearchContent(url) {
		//alert(url);
		$.get(url).done(function(data) {
			//alert(data);
			$('#assetwindow').jqxWindow('setContent', data);

		});
	}
	function funreload(event) {
		/* if(document.getElementById("cmbbranch").value=="" || document.getElementById("cmbbranch").value=='a'){
			$.messager.alert('Warning','Please Select Branch');
			return false;
		}
		 */
		$("#falistdiv").load(
				"faListGrid.jsp?branch="
						+ document.getElementById("cmbbranch").value
						+ "&assetgroup="
						+ document.getElementById("hidassetgrp").value
						+ '&check=1');
	}

	function setValues() {

		if ($('#msg').val() != "") {
			$.messager.alert('Message', $('#msg').val());
		}
	}
	function funExportBtn() {
		JSONToCSVCon(exportdata, 'Fixed Asset List', true);

	}
</script>
</head>
<body onload="getBranch();setValues();">
	<form id="frmFAList" action="frmFAList" method="post">

		<div id="mainBG" class="homeContent" data-type="background">
			<div class="hidden-scrollbar">

				<table width="100%">
					<tr>

						<!-- ===== LEFT PANEL ===== -->
						<td width="20%" valign="top">

							<fieldset class="filter-card scrollable-left">
								<table width="100%" class="filter-table">

									<!-- HEADING (UNCHANGED â WILL APPEAR) -->
									<jsp:include page="../../heading.jsp"></jsp:include>

									<tr>
										<td class="label-cell">Period Upto</td>
										<td>
											<div id="periodupto"></div>
										</td>
									</tr>

									<tr>
										<td class="label-cell">Asset Group</td>
										<td><input type="text" name="assetgrp" id="assetgrp"
											class="master-input" readonly
											placeholder="Press F3 to Search"
											onkeydown="getAssetGroup(event);"> <input
											type="hidden" name="hidassetgrp" id="hidassetgrp"></td>
									</tr>

								</table>
							</fieldset>

						</td>

						<!-- ===== RIGHT GRID ===== -->
						<td width="80%" valign="top">

							<table width="100%">
								<tr>
									<td>
										<div id="falistdiv">
											<jsp:include page="faListGrid.jsp"></jsp:include>
										</div>
									</td>

									<input type="hidden" name="mode" id="mode"
										value='<s:property value="mode"/>'>
									<input type="hidden" name="msg" id="msg"
										value='<s:property value="msg"/>'>
								</tr>
							</table>

						</td>

					</tr>
				</table>

			</div>

			<div id="assetwindow">
				<div></div>
			</div>

		</div>
	</form>
</body>

</html>