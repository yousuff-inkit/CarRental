
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen"
	rel="stylesheet" type="text/css" />

<style type="text/css">
.myButtons {
	display: inline-block;
	margin-right: 4px;
	margin-left: 4px;
	margin-bottom: 0;
	font-weight: normal;
	line-height: 1.3;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	border: 1px solid transparent;
	border-radius: 4px;
	color: #fff;
	background-color: grey;
}

.myButtons:hover {
	color: #fff;
	background-color: #31b0d5;
}

.myButtons:active {
	color: #fff;
	background-color: #31b0d5;
}

.myButtons:focus {
	color: #fff;
	background-color: grey;
}

.hidden-scrollbar {
	overflow: auto;
	height: 800px;
}

#rowheight {
	height: 387px;
}
</style>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#fromdate").jqxDateTimeInput({
							width : '125px',
							height : '15px',
							formatString : "dd.MM.yyyy"
						});
						$("#todate").jqxDateTimeInput({
							width : '125px',
							height : '15px',
							formatString : "dd.MM.yyyy"
						});
						$("body")
								.prepend(
										'<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
						$("body")
								.prepend(
										"<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
						$('#accountSearchwindow').jqxWindow({
							width : '30%',
							height : '40%',
							maxHeight : '40%',
							maxWidth : '50%',
							title : 'Category Search',
							position : {
								x : 150,
								y : 60
							},
							keyboardCloseKey : 27
						});
						$('#accountSearchwindow').jqxWindow('close');

						$('#account').dblclick(function() {
							$('#accountSearchwindow').jqxWindow('open');
							accountSearchContent('accountsDetailsFromGrid.jsp');
						});
						var curfromdate = $('#fromdate').jqxDateTimeInput(
								'getDate');
						var oneyeardate = new Date(new Date(curfromdate)
								.setMonth(curfromdate.getMonth() - 1));
						var oneyearbackdate = new Date(new Date(oneyeardate)
								.setDate(oneyeardate.getDate()));
						$('#fromdate ').jqxDateTimeInput('setDate',
								new Date(oneyearbackdate));
					});

	function funExportBtn() {
		$("#invoicediv").excelexportjs({
			containerid : "invoicediv",
			datatype : 'json',
			dataset : null,
			gridId : "deprtmtlist",
			columns : getColumns("deprtmtlist"),
			worksheetName : "Rental Ivoice List"
		});
		$("#trafficdiv").excelexportjs({
			containerid : "trafficdiv",
			datatype : 'json',
			dataset : null,
			gridId : "trafficfineGrid",
			columns : getColumns("trafficfineGrid"),
			worksheetName : "Traffic Fine List"
		});
		$("#tolldiv").excelexportjs({
			containerid : "tolldiv",
			datatype : 'json',
			dataset : null,
			gridId : "tollGrid",
			columns : getColumns("tollGrid"),
			worksheetName : "Toll List"
		});
		$("#damagediv").excelexportjs({
			containerid : "damagediv",
			datatype : 'json',
			dataset : null,
			gridId : "damageGrid",
			columns : getColumns("damageGrid"),
			worksheetName : "Damage List"
		});
	}

	function getaccountdetails(event) {
		var x = event.keyCode;

		if (x == 114) {
			$('#accountSearchwindow').jqxWindow('open');

			accountSearchContent('accountsDetailsFromGrid.jsp');
		} else {
		}

	}
	function accountSearchContent(url) {

		$.get(url).done(function(data) {

			$('#accountSearchwindow').jqxWindow('setContent', data);

		});
	}
	function funreload(event) {
		var barchval = document.getElementById("cmbbranch").value;
		var acno = $("#acno").val();
		var fromdate=$('#fromdate').jqxDateTimeInput('val');
		var todate=$('#todate').jqxDateTimeInput('val');		
		
		var check = 1;
		if (acno == "" || acno == null) {
			$.messager.alert('Message', 'Please Select a Client', 'warning');
		} else {
			$("#overlay, #PleaseWait").show();
			$("#invoicediv").load("rentalInvoiceGrid.jsp?cldoc=" + acno + '&check=' + check + '&fromdate='+fromdate+'&todate='+todate);
			$("#trafficdiv").load("trafficfine.jsp?cldoc=" + acno + '&check=' + check+ '&fromdate='+fromdate+'&todate='+todate);
			$('#tolldiv').load('toll.jsp?cldoc=' + acno + '&check=' + check+ '&fromdate='+fromdate+'&todate='+todate);
			$("#damagediv").load("damage.jsp?cldoc=" + acno + '&check=' + check + '&fromdate='+fromdate+'&todate='+todate);
			
			//$("#damagediv").load("damage.jsp?cldoc=" + acno + '&check=' + check+ '&fromdate='+fromdate+'&todate='+todate);
		}

	}

	function funUpdate() {

		var list1 = new Array();
		var cldoc = $("#acno").val();
		var rows1 = $("#deprtmtlist").jqxGrid('getrows');
		if (rows1 == "" || rows1 == null) {
			$.messager.alert('Message', 'Please select the client');
		} else {
			for (var i = 0; i < rows1.length; i++) {
				list1.push(rows1[i].alias + "::" + rows1[i].ddocno);
			}
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText;
					var itemval = items.trim();
					if (itemval > 0) {
						$.messager.alert('Message', 'Successfully Updated');
						funreload(event);

					} else {

						$.messager.alert('Message', 'Not Updated');
						//$('#updatdata').attr('disabled', false);
						$("#overlay, #PleaseWait").hide();
					}

				} else {

				}
			}
		}

		x.open("GET", "savedata.jsp?gridarray=" + encodeURIComponent(list1)
				+ '&cldoc=' + cldoc);
		x.send();

	}
	function funClear() {
		$('#account').val('');
		$("#deprtmtlist").jqxGrid('clear');
		$("#account").attr('placeholder', 'Press F3 to Search');
		document.getElementById("txtproductname").setAttribute("placeholder",
				"Press F3 to Search");

	}
</script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background">
		<div class='hidden-scrollbar'>
			<table width="100%">
				<tr>
					<td width="20%">
						<fieldset style="background: #ECF8E0;">
							<table width="100%">
								<jsp:include page="../../heading.jsp"></jsp:include>
								<td align="right"><label class="branch">From</label></td>
								<td align="left"><div id="fromdate" name="fromdate"
										value='<s:property value="fromdate"/>'></div></td>
								</tr>
								<tr>
									<td align="right"><label class="branch">To</label></td>
									<td align="left"><div id="todate" name="todate"
											value='<s:property value="todate"/>'></div></td>
								</tr>

								<tr>
									<td align="right"><label class="branch">Client</label></td>
									<td><input type="text" name="account" id="account"
										value='<s:property value="account"/>' readonly="readonly"
										placeholder="Press F3 To Search"
										style="height: 20px; width: 70%;"
										onKeyDown="getaccountdetails(event);"></td>
								</tr>


								<tr>
									<td><input type="hidden" id="txtproductname"
										name="txtproductname" style="width: 100%; height: 20px;"
										readonly="readonly"
										value='<s:property value="txtproductname"/>' tabindex="-1" />
								<tr>
									<td colspan="2" align="center"></td>
								</tr>

								<!-- <tr>
									<td colspan="2" align="center"><input type="button"
										class="myButtons" name="clear" id="clear"
										onclick="funClear();" value="Clear"><input
										type="button" class="myButtons" name="update" id="update"
										onclick="funUpdate();" value="Update"></td>
								</tr> -->
								<tr id="rowheight">
									<td colspan="2" align="center">
								</tr>

							</table>
						</fieldset> <input type="hidden" id="acno" name="acno"
						value='<s:property value="acno"/>'>

					</td>
					<td width="80%">
						<table width="100%">
							<tr>
								<td>
								<fieldset><legend>RENTAL INVOICE</legend>
								<div id="invoicediv"><jsp:include
											page="rentalInvoiceGrid.jsp"></jsp:include></div>
											</fieldset></td>
							</tr>
							<tr>
								<td>
								<fieldset><legend>TRAFFIC FINE</legend>
								<div id="trafficdiv"><jsp:include
											page="trafficfine.jsp"></jsp:include></div></fieldset></td>
							</tr>
							<tr>
								<td><fieldset><legend>SALIK LIST</legend><div id="tolldiv"><jsp:include page="toll.jsp"></jsp:include></div></fieldset></td>
							</tr>
							<tr>
								<td><fieldset><legend>DAMAGE LIST</legend><div id="damagediv"><jsp:include
											page="damage.jsp"></jsp:include></div></fieldset></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" id="cldoc" name="cldoc">


		</div>
		<div id="accountSearchwindow">
			<div></div>
		</div>
	</div>
</body>
</html>