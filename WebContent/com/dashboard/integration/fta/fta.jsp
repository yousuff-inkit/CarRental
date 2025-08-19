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
		<style type="text/css">
			.hidden-scrollbar{
				height:82vh;
				overflow-y:auto;
			}
		</style>
		<script type="text/javascript">
 
			$(document).ready(function () {
				$("#branchlabel").attr('hidden',true);
				$("#branchdiv").attr('hidden',true);
				
	 			$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"MMM/yyyy"});
	  			
	 			$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  			$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
    
			});

			function funreload(event){
				var date=new Date($('#date').jqxDateTimeInput('getDate'));
				var month=0,year=0;
				month=date.getMonth()+1;
				year=date.getFullYear();
				$('#detaildiv').load('detailGrid.jsp?month='+month+'&year='+year+'&id=1');
			}

			function funExportBtn(){
				var date=$('#date').jqxDateTimeInput('val');
				$("#detailGrid").excelexportjs({
					containerid: "detailGrid",
					datatype: 'json',
					dataset: null,
					gridId: "detailGrid",
					columns: getColumns("detailGrid") ,
					worksheetName:"FTA Log for "+date
				});
	 		}
			function funCopyData(){
				$('#overlay,#PleaseWait').show();
				
				var date=new Date($('#date').jqxDateTimeInput('getDate'));
				var month=0,year=0;
				month=date.getMonth()+1;
				year=date.getFullYear();
				$.post('copyData.jsp',{'month':month,'year':year},function(data,status){
					data=JSON.parse(data);
					$('#overlay,#PleaseWait').hide();
					if(data.errorstatus=="0"){
						$.messager.alert('Message','Successfully Copied');
						funreload("");
					}
					else{
						$.messager.alert('Warning','Not Copied');
						return false;
					}
				});
			}
	
		    function checkValidation() {
		    	var selectedDate = $("#date").jqxDateTimeInput('val');
		    	var dateObj = new Date(selectedDate);
		    	var day = ("0" + dateObj.getDate()).slice(-2);
		    	var month = ("0" + (dateObj.getMonth() + 1)).slice(-2);  
		    	var year = dateObj.getFullYear();
		    	var formattedDate = day + '.' + month + '.' + year;

		    	console.log(formattedDate);   
		        
		        $.ajax({
		            url: 'getvalidation.jsp',  
		            type: 'POST',
		            data: { date: formattedDate },
		            success: function(response) {
		                 if(parseInt(response.trim()) == 1){
		                	 $.messager.alert('Warning','Data cannot be copied! All vehicles should have a TCNO.');
								return false;
		                 }else if(parseInt(response.trim()) == 2){
		                	 $.messager.alert('Warning','Month-end closing not done , cannot be  posted.');
								return false;
		                 }else{
		                	 funCopyData();
		                 }
		            },
		            error: function() {
		                console.log('An error occurred while processing the request.');
		            }
		        });
		    }
		</script>
	</head>
	<body ><!-- onload="hiddenbrh();" -->
		<div id="mainBG" class="homeContent" data-type="background"> 
			<div class='hidden-scrollbar'>
				<table width="100%" style="height:100%;">
					<tr>
						<td width="20%" >
    						<fieldset style="background: #ECF8E0;height:90%;">
								<table width="100%"  >
									<jsp:include page="../../heading.jsp"></jsp:include>
									<tr><td colspan="2">&nbsp;</td></tr>
	 								<tr>
	 									<td  align="right" ><label class="branch">Date</label></td>
	 									<td align="left"><div id='date' name='date' value='<s:property value="date"/>'></div></td>
	 								</tr>
	 								<tr><td colspan="2">&nbsp;</td></tr>
	 								<tr><td colspan="2" align="center"><button type="button" id="btncopy" name="btncopy" class="myButton" onclick="checkValidation();">Copy Data</button></td></tr>
 								</table>
							</fieldset>
						</td>
						<td width="80%">
							<table width="100%">
								<tr>
			 						<td><div id="detaildiv"><jsp:include page="detailGrid.jsp"></jsp:include></div></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</body>
</html>