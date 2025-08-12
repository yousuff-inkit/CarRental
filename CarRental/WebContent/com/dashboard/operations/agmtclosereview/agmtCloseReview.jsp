<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GatewayERP(i)</title>
	<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
	<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
	<style>
	.myButtons {
		-moz-box-shadow:inset 0px -1px 3px 0px #91b8b3;
		-webkit-box-shadow:inset 0px -1px 3px 0px #91b8b3;
		box-shadow:inset 0px -1px 3px 0px #91b8b3;
		background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #768d87), color-stop(1, #6c7c7c));
		background:-moz-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
		background:-webkit-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
		background:-o-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
		background:-ms-linear-gradient(top, #768d87 5%, #6c7c7c 100%);
		background:linear-gradient(to bottom, #768d87 5%, #6c7c7c 100%);
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#768d87', endColorstr='#6c7c7c',GradientType=0);
		background-color:#768d87;
		border:1px solid #566963;
		display:inline-block;
		cursor:pointer;
		color:#ffffff;
		
		font-size:8pt;
		
		padding:3px 17px;
		text-decoration:none;
		text-shadow:0px -1px 0px #2b665e;
	}
	.myButtons:hover {
		background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #6c7c7c), color-stop(1, #768d87));
		background:-moz-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
		background:-webkit-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
		background:-o-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
		background:-ms-linear-gradient(top, #6c7c7c 5%, #768d87 100%);
		background:linear-gradient(to bottom, #6c7c7c 5%, #768d87 100%);
		filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#6c7c7c', endColorstr='#768d87',GradientType=0);
		background-color:#6c7c7c;
	}
	.myButtons:active {
		position:relative;
		top:1px;
	}
	</style>

	<script type="text/javascript">
	
		$(document).ready(function () {
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
			$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
			   
			$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var onemonthbefore=new Date(new Date(fromdate).setMonth(fromdate.getMonth()-1));
			$('#fromdate').jqxDateTimeInput('setDate', new Date(onemonthbefore));
			
			$('#todate').on('change', function (event) {
				var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
				var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
				if(fromdates>todates){
					$.messager.alert('Message','To Date Less Than From Date  ','warning');   
					return false;
				}   
			});
			
		});
		
		function funExportBtn(){
			$("#agmtListGrid").excelexportjs({
				containerid: "agmtListGrid",
				datatype: 'json',
				dataset: null,
				gridId: "agmtListGrid",
				columns: getColumns("agmtListGrid") ,
				worksheetName:"Agreement Closed List"
			});
		}
			 
		function funreload(event){
			
			var fromdate=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			var todate=new Date($('#todate').jqxDateTimeInput('getDate'));
			if(fromdate>todate){
				$.messager.alert('Message','To Date Less Than From Date  ','warning');   
				return false;
			}
			
			var branch= document.getElementById("cmbbranch").value;
		    var fromdate= $("#fromdate").jqxDateTimeInput('val');
			var todate= $("#todate").jqxDateTimeInput('val');
			$("#overlay, #PleaseWait").show();
			$("#agmtlist").load("agmtListGrid.jsp?branch="+branch+"&fromdate="+fromdate+"&todate="+todate+"&id=1");
		}
	</script>
</head>
<body onload="getBranch();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%" >
				<tr>
					<td width="20%" valign="top">
    					<fieldset style="background: #ECF8E0;">
							<table width="100%" >
								<tr><td colspan="2"><jsp:include page="../../heading.jsp"></jsp:include></td></tr>
								<tr><td colspan="2">&nbsp;</td></tr>
								<tr>
									<td align="right" ><label class="branch">From</label></td>
									<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
								</tr>
                     			<tr>
                     				<td  align="right" ><label class="branch">To</label></td>
                     				<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                     			</tr>
 								<tr><td colspan="2"></td></tr>
	 							<tr>
	 								<td colspan="2" align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td>
	 							</tr>
      							<tr><td colspan="2"></td></tr>
     							<tr>
     								<td colspan="2" >
										<fieldset>
											<table width="100%">
												<tr><td align="right" width="40%"><label class="branch">Rental</label></td><td align="left"><input type="text" name="rt" id="rt" readonly="readonly" style="height:18px;width:45%;background-color: #FFEBEB;border:0; "  ></td></tr>
												<tr><td align="right" width="40%"><label class="branch">Lease</label></td><td align="left"><input type="text" name="lt" id="lt" readonly="readonly" style="height:18px;width:45%; border:0;border-color:white;"  ></td></tr>
											</table>
										</fieldset>
									</td>
								</tr>
								<tr><td colspan="2"><div style="height:14em;"></div></td></tr>
							</table>
						</fieldset>
					</td>
					<td width="80%" valign="top">
						<table width="100%">
							<tr>
			 					<td><div id="agmtlist"><jsp:include page="agmtListGrid.jsp"></jsp:include></div></td>
							</tr>
							<tr>
			 					<td><div id="invoicelist"><jsp:include page="invoiceGrid.jsp"></jsp:include></div></td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
	 