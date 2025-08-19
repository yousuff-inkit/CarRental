
<jsp:include page="../../../../includes.jsp"></jsp:include>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<%
	String contextPath = request.getContextPath();

%>
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
</style>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
						$("body")
								.prepend(
										'<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
						$("body")
								.prepend(
										"<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
						$('#accountSearchwindow').jqxWindow({
							width : '50%',
							height : '62%',
							maxHeight : '75%',
							maxWidth : '50%',
							title : 'Client Search',
							position : {
								x : 150,
								y : 60
							},
							keyboardCloseKey : 27
						});
						$('#accountSearchwindow').jqxWindow('close');
						$('#account').dblclick(function() {
							$('#accountSearchwindow').jqxWindow('open');
							accountSearchContent('driverSearch.jsp');
						});
						
						$('#branchlabel').hide();
						$('#branchdiv').hide();
					});

	function funExportBtn() {
		$("#userdriverdiv").excelexportjs({
			containerid : "userdriverdiv",
			datatype : 'json',
			dataset : null,
			gridId : "userlist",
			columns : getColumns("userlist"),
			worksheetName : "User Driver Link" 
		});
	}

	function getaccountdetails(event) {
		var x = event.keyCode;

		if (x == 114) {
			$('#accountSearchwindow').jqxWindow('open');

			accountSearchContent('driverSearch.jsp');
		} else {
		}

	}
	function accountSearchContent(url) {

		$.get(url).done(function(data) {

			$('#accountSearchwindow').jqxWindow('setContent', data);

		});
	}
	function funreload(event) {

		var acno = $("#acno").val();
		var check = 1;
		var rx = 0;
		
		$("#overlay, #PleaseWait").show();
		$("#userdriverdiv").load(
				"userDetailsGrid.jsp?cldoc=" + acno + '&check=' + check
						+ '&rx=' + rx);


	}
	function funUpdate() {
        var acno = $("#acno").val();
       
		var rows1 = $("#userlist").jqxGrid('getrows');
		var len=0;
		var userid= $("#userid").val();
		if(userid== '' || userid == null ){
			$.messager.alert("Message","Please Select User");
			return false;
		}
		
if(acno== '' || acno == null ){
	$.messager.alert("Message","Please Select Driver");
	return false;
		}
			var x=new XMLHttpRequest();
		    x.onreadystatechange=function()
		    {
		         
		    	if (x.readyState == 4 && x.status == 200)
		        {
		        	var msg=x.responseText.trim();
		            if(msg=="1")
		            {
		            	funreload();
		              	funClear();
		               	$.messager.alert("Message","Updated Successfully");
		            }
		            else
		            {
		                    
		            	$.messager.alert("Message","Not Updated");
		            }
		    }
		    }
		    x.open("GET", "savedata.jsp?driverid="+acno+'&userid='+userid, true);
		    x.send();
}
	function funClear() {
		$('#account').val('');
		$("#acno").val('');
		$("#userid").val('');
		//$("#userlist").jqxGrid('clear');
		$("#account").attr('placeholder', 'Press F3 to Search');
		document.getElementById("account").setAttribute("placeholder",
				"Press F3 to Search");

	}
	
	
	
	
	
	function sessionSet() {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			
		  }
		}
			
	x.open("GET","setSession.jsp",true);
	x.send();
	}
	
	
</script>
</head>
<body onload="getBranch();">
<form id="frmClientAlias" action="clienalias" method="post" autocomplete="off">
	<div id="mainBG" class="homeContent" data-type="background">
		<div class='hidden-scrollbar'>
			<table width="100%" >
				<tr>
					<td width="20%">
						<fieldset style="background: #ECF8E0;">
							<table width="100%">
								<jsp:include page="../../heading.jsp"></jsp:include>


								<tr>
									<td align="right"><label class="branch">Driver</label></td>
									<td><input type="text" name="account" id="account"
										value='<s:property value="account"/>' readonly="readonly"
										placeholder="Press F3 To Search"
										style="height: 20px; width: 70%;"
										onKeyDown="getaccountdetails(event);"></td>
								</tr>
								<!-- <tr>
									<td align="right"><label class="branch">RX</label></td>
									<td><input type="checkbox" id="rx"
										onchange="funRxClear();funSetRx();"></td>
								</tr>
 -->

								<tr>
									<td><input type="hidden" id="txtproductname"
										name="txtproductname" style="width: 100%; height: 20px;"
										readonly="readonly"
										value='<s:property value="txtproductname"/>' tabindex="-1" />
								<tr>
									<td colspan="2" align="center"></td>
								</tr>

								<tr>
									<td colspan="2" align="center"><input type="button"
										class="myButtons" name="clear" id="clear"
										onclick="funClear();" value="Clear"><input
										type="button" class="myButtons" name="update" id="update"
										onclick="funUpdate();" value="Update"></td>
								</tr>
								<%-- <tr>
									<td colspan="2" width="28%" align="right">
									<table width="100%">
									<tr>
									<td width="80%">
									<input type="file" id="fileexcelimport" name="file" />
									</td>
									<td width="20%">
									<button class="icon" id="btnsearch" name="btnsearch"
											title="Import Excel" type="button" onclick="return upload();">
											<img alt="Import Excel"
												src="<%=contextPath%>/icons/import_excel.png">
										</button>
									</td>
									</tr>
									</table>
									
									
										
										</td>

								</tr> --%>
								

							 	<tr>
									<td colspan="2" align="center">



										<div id="summs"
											style="resize: none; font: 10px Tahoma; hight: 20px">
											<br> &nbsp;<br> &nbsp;<br> &nbsp;<br>
											&nbsp;<br> &nbsp; <br> &nbsp;<br> &nbsp;<br>
											&nbsp;<br> &nbsp;<br> &nbsp; <br> &nbsp;<br>
											&nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp; <br>
											&nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br>
											&nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
										</div>
									</td>
								</tr> 


							</table>
						</fieldset> <input type="hidden" id="acno" name="acno"
						value='<s:property value="acno"/>'>
					</td>
					<td width="80%">
						<table width="100%">
							<tr>
								<td><div id="userdriverdiv"><jsp:include
											page="userDetailsGrid.jsp"></jsp:include></div></td>
							</tr>

						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" id="cldoc" name="cldoc">
			<input type="hidden" id="mode" name="mode"  value='<s:property value="mode"/>'/>
			  <input type="hidden" id="cagridlength" name="cagridlength"/>
			  <input type="hidden" id="rx1" name="rx1" value='<s:property value="rx1"/>'/>
			  <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
			  <input type="hidden" id="userid" name="userid" value='<s:property value="userid"/>'/>
			
			


		</div>
		<div id="accountSearchwindow">
			<div></div>
		</div>
	</div>
	</form>
</body>
</html>