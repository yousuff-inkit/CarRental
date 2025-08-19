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
			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 999; display: none;"></div>');
			$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 999;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
			   
			$('#agmtwindow').jqxWindow({ width: '60%', height: '60%',  maxHeight: '65%' ,maxWidth: '70%' , title: 'Agreement Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
			$('#agmtwindow').jqxWindow('close');
			  
			$('#agmtvocno').dblclick(function(){
		  		$('#agmtwindow').jqxWindow('open');
		   		agmtSearchContent('agmtSearchMaster.jsp'); 
	      	});
		});
		
		function agmtSearchContent(url) {
			$.get(url).done(function (data) {
				$('#agmtwindow').jqxWindow('open');
				$('#agmtwindow').jqxWindow('setContent', data);
			});
		}  
		
		function getAgreement(event){
			var agmttype=$('#cmbagmttype').val();
			if(agmttype==""){
				$.messager.alert('Warning','Please Select Agreement Type');
				return false;
			}
			var x= event.keyCode;
			if(x==114){
				$('#agmtwindow').jqxWindow('open');
		   		agmtSearchContent('agmtSearchMaster.jsp', $('#agmtwindow'));
			}
		} 
		
		function funExportBtn(){
			var agmttype=$('#cmbagmttype').val();
			var agmtvocno=$('#agmtvocno').val();
			$("#invoiceGrid").excelexportjs({
				containerid: "invoiceGrid",
				datatype: 'json',
				dataset: null,
				gridId: "invoiceGrid",
				columns: getColumns("invoiceGrid") ,
				worksheetName:"Invoices on Closing "+agmttype+" #"+agmtvocno
			});
		}
			 
		function funreload(event){
			var branch= document.getElementById("cmbbranch").value;
			var agmtdocno=$('#agmtdocno').val();
			var agmttype=$('#cmbagmttype').val();
			if(agmttype==""){
				$.messager.alert('Warning','Please select Agreement Type');
				return false;
			}
			if(agmtdocno=="" || agmtdocno=="0" || agmtdocno=="undefined"){
				$.messager.alert('Warning','Please select Agreement');
				return false;
			}
			$("#overlay, #PleaseWait").show();
			$('#invoicelist').load('invoiceGrid.jsp?id=1&agmtdocno='+agmtdocno+'&agmttype='+agmttype);
		}
		
		function funUpdate(){
			var agmtdocno=$('#agmtdocno').val();
			var agmttype=$('#cmbagmttype').val();
			if(agmttype==""){
				$.messager.alert('Warning','Please select Agreement Type');
				return false;
			}
			if(agmtdocno=="" || agmtdocno=="0" || agmtdocno=="undefined"){
				$.messager.alert('Warning','Please select Agreement');
				return false;
			}
			var invvocno=$('#invvocno').val();
			var rows=$('#invoiceDetailGrid').jqxGrid('getrows');
			if(rows.length==0){
				$.messager.alert('Warning','Please update valid invoices');
				return false;
			}
			var totalcreditamt=0.0;
			var totalinvoiceamt=0.0;
			var changecount=0;
			var strcreditarray="";
			var strinvoicearray="";
			for(var i=0;i<rows.length;i++){
				var creditamt=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'amount');
				var invoiceamt=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'auditamt');
				if(parseFloat(creditamt)!=parseFloat(invoiceamt)){
					totalcreditamt+=parseFloat(creditamt);
					totalinvoiceamt+=parseFloat(invoiceamt);
					changecount++;
					var acno=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'acno');
					var units=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'units');
					var idno=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'idno');
					var detdesc=$('#invoiceDetailGrid').jqxGrid('getcellvalue',i,'description');
					
					if(strcreditarray==""){
						strcreditarray=acno+"::"+creditamt+"::"+units+"::"+idno+"::"+detdesc;
						strinvoicearray=acno+"::"+invoiceamt+"::"+units+"::"+idno+"::"+detdesc;
					}
					else if(strcreditarray!=""){
						strcreditarray+=","+acno+"::"+creditamt+"::"+units+"::"+idno+"::"+detdesc;
						strinvoicearray+=","+acno+"::"+invoiceamt+"::"+units+"::"+idno+"::"+detdesc;
					}
				}
			}
			if(parseInt(changecount)==0){
				$.messager.alert('Warning','No change in audit amount');
				return false;
			}
			if(parseInt(changecount)>0){
				var invvocno=$('#invvocno').val();
				$.messager.confirm('Confirm', 'Do you want to audit changes of INV #'+invvocno, function(r){
					if (r){
						$("#overlay, #PleaseWait").show();
						var creditdesc=$('#creditdesc').val();
						var invoicedesc=$('#invoicedesc').val();
						var oldinvtrno=$('#oldinvtrno').val();
						console.log({'creditdesc':creditdesc,'invoicedesc':invoicedesc,'strcreditarray':strcreditarray,'strinvoicearray':strinvoicearray,'agmtdocno':agmtdocno,'agmttype':agmttype,'creditamt':totalcreditamt,'invoiceamt':totalinvoiceamt});
						$.post('updateAudit.jsp',{'oldinvtrno':oldinvtrno,'creditdesc':creditdesc,'invoicedesc':invoicedesc,'strcreditarray':strcreditarray,'strinvoicearray':strinvoicearray,'agmtdocno':agmtdocno,'agmttype':agmttype,'creditamt':totalcreditamt,'invoiceamt':totalinvoiceamt},function(data,status){
							data=JSON.parse(data);
							$("#overlay, #PleaseWait").hide();
							if(data.errorstatus=="0"){
								var successmsg=" CNO #"+data.CNOvoucher+", INV #"+data.INVvoucher;
								$.messager.alert('Message','Successfully Generated'+successmsg);
								$('#invoiceGrid,#invoiceDetailGrid').jqxGrid('clear');
								$('#cmbagmttype,#agmtvocno,#agmtdocno,#creditdesc,#invoicedesc').val('');
							}
							else if(data.errorstatus=="2"){
								$.messager.alert('Warning','Session Expired');
							}
							else{
								$.messager.alert('Warning','Not Updated');
							}
						});
					}
				});
			}
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
									<td align="right"><label class="branch">Agmt Type</label></td>
									<td align="left">
										<select name="cmbagmttype" id="cmbagmttype" style="min-width:132px;">
											<option value="">--Select--</option>
											<option value="RAG">Rental</option>
											<option value="LAG">Lease</option>
										</select>
									</td>
								</tr>
                     			<tr>
                     				<td  align="right" width="30%"><label class="branch">Agreement #</label></td>
                     				<td align="left">
                     					<input readonly type="text" name="agmtvocno" id="agmtvocno" placeholder="Press F3 to Search" onkeydown="getAgreement(event);" style="height:18px;">
                     					<input type="hidden" name="agmtdocno" id="agmtdocno">	
                     				</td>
                     			</tr>
 								<tr><td colspan="2"></td></tr>
 								<tr>
 									<td align="right"><label class="branch">CNO.Desc</label></td>
 									<td><input type="text" name="creditdesc" id="creditdesc" placeholder="Credit Note Description" style="height:18px;"></td>
	 							<tr>
	 							<tr>
 									<td align="right"><label class="branch">INV.Desc</label></td>
 									<td><input type="text" name="invoicedesc" id="invoicedesc" placeholder="Invoice Description" style="height:18px;"></td>
	 							<tr>
	 								<td colspan="2" align="center">
	 									<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()">&nbsp;&nbsp;
	 									<input type="button" class="myButton" name="btnupdate" id="btnupdate"  value="Update" onclick="funUpdate();">
	 								</td>
	 							</tr>
      							<tr><td colspan="2"></td></tr>
								<tr><td colspan="2"><div style="height:13em;"></div></td></tr>
							</table>
						</fieldset>
					</td>
					<td width="80%" valign="top">
						<table width="100%">
							<tr>
			 					<td><div id="invoicelist"><jsp:include page="invoiceGrid.jsp"></jsp:include></div></td>
							</tr>
							<tr>
			 					<td><div id="invoicedetaillist"><jsp:include page="invoiceDetailGrid.jsp"></jsp:include></div></td>
							</tr>
							
						</table>
					</td>
				</tr>
			</table>
			<div id="agmtwindow">
   				<div></div>
			</div>
		</div>
	</div>
</body>
</html>
	 