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
		<script type="text/javascript">
			$(document).ready(function () {
	 
				$("#dateout").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
				$("#maxdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
				$("#maxtime").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
				$("#timeout").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
				$("#datein").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
				$("#timein").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false,value: new Date() });
				
				$("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
				$("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
				
				$('#fleetwindow').jqxWindow({ width: '30%', height: '65%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 60 }, keyboardCloseKey: 27});
				$('#fleetwindow').jqxWindow('close');
				    
				$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
				$("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
				   
				$('#fleetno').dblclick(function(){
	 				$('#fleetwindow').jqxWindow('open');
					fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
    			});
	 
	 			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 			var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    		$('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 
	 
	 			$('#todate').on('change', function (event) {
					var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 			// out date
		 	 		var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 			if(fromdates>todates){
			   			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
						return false;
		  			}   
	 			});
	 
				
	 			$('#savedata').click(function(){
	 				var gridindex=$('#gridindex').val();
	 				var movdocno=$('#vehmovement').jqxGrid('getcellvalue',gridindex,'doc_no');
	 				var rdocno=$('#vmrdocno').val();
	 				var rdtype=$('#vehmovement').jqxGrid('getcellvalue',gridindex,'rdtype').trim();
	 				var vocno=$('#vehmovement').jqxGrid('getcellvalue',gridindex,'rdocno');
	 				if($('#vehmovement').jqxGrid('getcellvalue',gridindex,'status').trim()=='IN'){
	 					//Checking Out and In details of the current row
	 					var outdate=new Date($('#dateout').jqxDateTimeInput('getDate'));
	 					var indate=new Date($('#datein').jqxDateTimeInput('getDate'));
	 					
	 					outdate.setHours(0,0,0,0);
	 					indate.setHours(0,0,0,0);
							 					
	 					if(indate<outdate){
	 						$.messager.alert('Message','In Date cannot be less than Out Date','warning');   
							return false;
	 					}
	 					
	 					var outtime=new Date($('#timeout').jqxDateTimeInput('getDate'));
	 					var intime=new Date($('#timein').jqxDateTimeInput('getDate'));
	 					
	 					if(indate-outdate==0){
	 						if(intime.getHours()<outtime.getHours()){
	 							$.messager.alert('Message','In Time cannot be less than Out Time','warning');   
								return false;
	 						}
	 						//console.log(intime.getHours()+"::"+outtime.getHours());
	 						//console.log(intime.getMinutes()+"::"+outtime.getMinutes());
	 						
	 						if(intime.getHours()==outtime.getHours()){
		 						if(intime.getMinutes()<outtime.getMinutes()){
		 							$.messager.alert('Message','In Time cannot be less than Out Time','warning');   
									return false;
		 						}
	 						}
	 					}
	 					var outkm=parseFloat($('#outkm').val());
	 					var inkm=parseFloat($('#inkm').val());
	 					
	 					if(inkm<outkm){
	 						$.messager.alert('Message','In Km cannot be less than Out Km','warning');   
							return false;
	 					}
	 					
	 					//Checking Out Details with Last In Details
	 					var gridrows=$('#vehmovement').jqxGrid('getrows');
	 					//Checking if its not last row
	 					if(parseInt(gridindex)!=0){
	 						var nextoutdate=new Date($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)-1,'dout'));
	 						var nextouttime=new Date();
	 						var strbasetime=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)-1,'tout');
	 						strbasetime=strbasetime.trim();
	 						nextouttime.setHours(strbasetime.split(":")[0],strbasetime.split(":")[1]);
	 						
	 						var nextoutkm=parseFloat($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)-1,'kmout'));
							var nexttran=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)-1,'trancode');
							nextoutdate.setHours(0,0,0,0);
	 						//console.log([nextoutdate,nextouttime,nextoutkm,indate,intime]);
							if(indate>nextoutdate){
	 							$.messager.alert('Message','In Date cannot be greater than Next Out Date','warning');   
								return false;
	 						}
	 						if(indate-nextoutdate==0){
	 							if(intime.getHours()>nextouttime.getHours()){
	 								$.messager.alert('Message','In Time cannot be greater than Next Out Time','warning');
									return false;
	 							}
	 							if(intime.getHours()==nextouttime.getHours()){
	 								if(intime.getMinutes()>nextouttime.getMinutes()){
	 									$.messager.alert('Message','In Time cannot be greater than Next Out Time','warning');
										return false;
		 							}	
	 							}
	 						}
	 						if(inkm>nextoutkm){
	 							$.messager.alert('Message','In Km cannot be less than Next Out Km','warning');
								return false;
	 						}
	 					}
	 					if(gridindex!=(gridrows.length-1)){
	 						var lastindate=new Date($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'din'));
	 						var lastintime=new Date();

	 						var strbasetime=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'tin');
	 						strbasetime=strbasetime.trim();
	 						lastintime.setHours(strbasetime.split(":")[0],strbasetime.split(":")[1]);

	 						var lastinkm=parseFloat($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'kmin'));
							var lasttran=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'trancode');
	 						lastindate.setHours(0,0,0,0);
	 						
	 						if(outdate<lastindate){
	 							$.messager.alert('Message','Out Date cannot be less than Last In Date','warning');   
								return false;
	 						}
	 						if(outdate-lastindate==0){
	 							if(outtime.getHours()<lastintime.getHours()){
	 								$.messager.alert('Message','Out Time cannot be less than Last In Time','warning');   
									return false;
	 							}
	 							if(outtime.getHours()==lastintime.getHours()){
	 								if(outtime.getMinutes()<lastintime.getMinutes()){
		 								$.messager.alert('Message','Out Time cannot be less than Last In Time','warning');
										return false;
		 							}	
	 							}
	 						}
	 						if(outkm<lastinkm){
	 							$.messager.alert('Message','Out Km cannot be less than Last In Km','warning');   
								return false;
	 						}
	 					}
	 					//console.log({'fleetno':$('#fleetno').val(),'outdate':$('#dateout').jqxDateTimeInput('val'),'outtime':$('#timeout').jqxDateTimeInput('val'),'outkm':$('#outkm').val(),'outfuel':$('#outfuel').val(),'indate':$('#datein').jqxDateTimeInput('val'),'intime':$('#timein').jqxDateTimeInput('val'),'inkm':$('#inkm').val(),'infuel':$('#infuel').val(),'movdocno':movdocno,'rdocno':rdocno,'rdtype':rdtype});
	 					//return false;
	 					
	 					$.messager.confirm('Message', 'Do you want to update '+rdtype+' '+vocno, function(r){
				     		if(r==false){
			        			return false;
			        	  	}
				     		else{
				     			$.post('saveData.jsp',{'fleetno':$('#fleetno').val(),'outdate':$('#dateout').jqxDateTimeInput('val'),'outtime':$('#timeout').jqxDateTimeInput('val'),'outkm':$('#outkm').val(),'outfuel':$('#outfuel').val(),'indate':$('#datein').jqxDateTimeInput('val'),'intime':$('#timein').jqxDateTimeInput('val'),'inkm':$('#inkm').val(),'infuel':$('#infuel').val(),'movdocno':movdocno,'rdocno':rdocno,'rdtype':rdtype},function(data,status){
			 						data=JSON.parse(data);
			 						if(data.errorstatus=="0"){
			 							$.messager.alert('Message','Successfully Saved');
			 							funreload("");
			 						}
			 						else{
			 							$.messager.alert('Warning','Not Saved','warning');
			 							return false;
			 						}
			 					});		
				     		}
	 					});
	 					
	 				}
	 				else if($('#vehmovement').jqxGrid('getcellvalue',gridindex,'status').trim()=='OUT'){
	 					//Checking Out and In details of the current row
	 					var outdate=new Date($('#dateout').jqxDateTimeInput('getDate'));	 					
	 					outdate.setHours(0,0,0,0);
	 					
	 					var outtime=new Date($('#timeout').jqxDateTimeInput('getDate'));
	 					var outkm=parseFloat($('#outkm').val());

	 					//Checking Out Details with Last In Details
	 					var gridrows=$('#vehmovement').jqxGrid('getrows');
	 					//Checking if its not last row
	 					
	 					if(gridindex!=(gridrows.length-1)){
	 						var lastindate=new Date($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'din'));
	 						var lastintime=new Date();

	 						var strbasetime=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'tin');
	 						strbasetime=strbasetime.trim();
	 						lastintime.setHours(strbasetime.split(":")[0],strbasetime.split(":")[1]);

	 						var lastinkm=parseFloat($('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'kmin'));
							var lasttran=$('#vehmovement').jqxGrid('getcellvalue',parseInt(gridindex)+1,'trancode');
	 						lastindate.setHours(0,0,0,0);
	 						
	 						if(outdate<lastindate){
	 							$.messager.alert('Message','Out Date cannot be less than Last In Date','warning');   
								return false;
	 						}
	 						if(outdate-lastindate==0){
	 							if(outtime.getHours()<lastintime.getHours()){
	 								$.messager.alert('Message','Out Time cannot be less than Last In Time','warning');   
									return false;
	 							}
	 							if(outtime.getHours()==lastintime.getHours()){
	 								if(outtime.getMinutes()<lastintime.getMinutes()){
		 								$.messager.alert('Message','Out Time cannot be less than Last In Time','warning');
										return false;
		 							}	
	 							}
	 						}
	 						if(outkm<lastinkm){
	 							$.messager.alert('Message','Out Km cannot be less than Last In Km','warning');   
								return false;
	 						}
	 					}
	 					//Save Data
	 					$.messager.confirm('Message', 'Do you want to update '+rdtype+' '+vocno, function(r){
				     		if(r==false){
			        			return false;
			        	  	}
				     		else{
				     			$.post('saveDataOut.jsp',{'fleetno':$('#fleetno').val(),'outdate':$('#dateout').jqxDateTimeInput('val'),'outtime':$('#timeout').jqxDateTimeInput('val'),'outkm':$('#outkm').val(),'outfuel':$('#outfuel').val(),'indate':$('#datein').jqxDateTimeInput('val'),'intime':$('#timein').jqxDateTimeInput('val'),'inkm':$('#inkm').val(),'infuel':$('#infuel').val(),'movdocno':movdocno,'rdocno':rdocno,'rdtype':rdtype},function(data,status){
			 						data=JSON.parse(data);
			 						if(data.errorstatus=="0"){
			 							$.messager.alert('Message','Successfully Saved');
			 							funreload("");
			 						}
			 						else{
			 							$.messager.alert('Warning','Not Saved','warning');
			 							return false;
			 						}
			 					});		
				     		}
	 					});
	 				}
	 				
	 			});
			});

			function hiddenbrh(){
				$("#branchlabel").attr('hidden',true);
				$("#branchdiv").attr('hidden',true);
			}
			
			function fleetSearchContent(url) {
 				$.get(url).done(function (data) {
 			 		$('#fleetwindow').jqxWindow('open');
 					$('#fleetwindow').jqxWindow('setContent', data);
 				}); 
 			} 

			function getfleetdata(event){
	 			var x= event.keyCode;
	 			if(x==114){
	  				$('#fleetwindow').jqxWindow('open');
					fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));
				}
	 		}

			function funreload(event){
				disitems();
				var fleetno = document.getElementById("fleetno").value;
				if(fleetno==""){
		   			$.messager.alert('Message','Search Fleet  ','warning'); 
		   			return 0;
		 		}
	 			else{
		  			var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
					var todates=new Date($('#todate').jqxDateTimeInput('getDate'));  
		 			if(fromdates>todates){
			   			$.messager.alert('Message','To Date Less Than From Date  ','warning');   
						return false;
		  			} 
		   			else{
						var fromdate= $("#fromdate").val();
	 					var todate= $("#todate").val();
	 					$("#overlay, #PleaseWait").show();
	  					$("#vehdiv").load("movementupdateGrid.jsp?fleetno="+fleetno+"&fromdate="+fromdate+"&todate="+todate);
		   			}
		 		}
			}

			function funExportBtn(){
	  			$("#vehdiv").excelexportjs({
			 		containerid: "vehdiv",
			 		datatype: 'json',
			 		dataset: null,
			 		gridId: "vehmovement",
			 		columns: getColumns("vehmovement") ,
			 		worksheetName:"'Movement Update"
			 	});
	 		}

			function isNumber(evt) {
    			var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    			if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57)){
    				$.messager.alert('Message', 'Enter Numbers Only');
    				return false;
    			}
  				return true;
			}


			function disitems(){
				document.getElementById("status").value="";
				document.getElementById("vmrdocno").value="";
				document.getElementById("vmrdocno").value="";
				document.getElementById("inkm").value="";
				document.getElementById("outkm").value="";
				document.getElementById("outfuel").value="";
				document.getElementById("infuel").value="";
				$('#dateout').val(new Date());
				$('#timeout').val(new Date());
				$('#datein').val(new Date());
				$('#timein').val(new Date());
				$("#in *").attr("disabled", "disabled");
	 			$("#out *").attr("disabled", "disabled");
	 			$('#dateout').jqxDateTimeInput({ disabled: true});
	 			$('#datein').jqxDateTimeInput({ disabled: true});
	 			$("#savedata").attr("disabled", true);
	 			$("#deletedata").attr("disabled", true);
	 		}
			
			
	</script>
</head>
<body onload="hiddenbrh();disitems();">
	<div id="mainBG" class="homeContent" data-type="background"> 
		<div class='hidden-scrollbar'>
			<table width="100%" >
				<tr>
					<td width="20%" >
    					<fieldset style="background: #ECF8E0;">
							<table width="100%">
								<jsp:include page="../../heading.jsp"></jsp:include>
	 							<tr>
	 								<td  align="right"><label class="branch">From</label></td>
	 								<td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
	 							</tr>
                     			<tr>
                     				<td  align="right" ><label class="branch">To</label></td>
                     				<td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                     			</tr>
       	 						<tr>
       	 							<td align="right"><label class="branch">Fleet</label></td>
	 								<td align="left"><input type="text" id="fleetno" style="height:20px;width:61%;" name="fleetno" placeholder="Press F3 To Search" onfocus="this.placeholder = ''" readonly="readonly" value='<s:property value="fleetno"/>' onkeydown="getfleetdata(event);" > </td>
	 							</tr>
								<tr>
									<td colspan="2">
										<table width="100%"  >
										<tr>
											<td>
												<div id="out" style="width: 100% ; align:left; height: 120px;  "  > 
													<fieldset>
														<legend>Out Details</legend> 
														<table width="100%" >
 															<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='dateout' name='dateout' value='<s:property value="dateout"/>'></div>
  															<tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timeout'  style="height:20px;width:100%;" name='timeout' value='<s:property value="timeout"/>'  ></div>
															<tr><td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="outkm" id="outkm"  style="height:20px;width:70%;" value='<s:property value="outkm"/>' onkeypress="javascript:return isNumber (event)"></td></tr>
															<tr>
																<td  align="right"><label class="branch">Fuel</label></td>
																<td align="left">
 																	<select  id="outfuel" style="width:70%;" name="outfuel"  value='<s:property value="outfuel"/>'>
																    	<option value="" selected>-Select-</option>  
																     	<option value=0.000 >Level 0/8</option>
																     	<option value=0.125>Level 1/8</option>
																     	<option value=0.250>Level 2/8</option>
																     	<option value=0.375>Level 3/8</option>
																     	<option value=0.500>Level 4/8</option>
																     	<option value=0.625>Level 5/8</option>
																     	<option value=0.750>Level 6/8</option>
																     	<option value=0.875>Level 7/8</option>
																     	<option value=1.000>Level 8/8</option>
																	</select>
																</td>
															</tr>
														</table>
													</fieldset>
												</div>
											</td>
										</tr>	
										<tr> 
											<td colspan="2">
												<div id="in" style="width: 100% ; align:left; height: 120px;">
													<fieldset>
														<legend>In Details</legend>
														<table width="100%">
															<tr><td  align="right" ><label class="branch">Date</label></td><td align="left"><div id='datein' name='datein' value='<s:property value="datein"/>'></div>
		  													<tr><td  align="right"><label class="branch">Time</label></td><td align="left" ><div id='timein' name='timein' value='<s:property value="timein"/>'  ></div>
		                   									<tr><td  align="right"><label class="branch">KM</label></td> <td align="left"><input type="text" name="inkm" id="inkm"  style="height:20px;width:70%;" value='<s:property value="inkm"/>' onblur="inchkkm()"  onkeypress="javascript:return isNumber (event)"></td></tr>
		 													<tr>
		 														<td  align="right"><label class="branch">Fuel</label></td>
		 														<td align="left">
		 															<select  id="infuel" style="width:70%;" name="infuel"  value='<s:property value="infuel"/>'> 
		       															<option value="" selected>-Select-</option>  
																	    <option value=0.000 >Level 0/8</option>
																	    <option value=0.125>Level 1/8</option>
																	    <option value=0.250>Level 2/8</option>
																	    <option value=0.375>Level 3/8</option>
																	    <option value=0.500>Level 4/8</option>
																	    <option value=0.625>Level 5/8</option>
																	    <option value=0.750>Level 6/8</option>
																	    <option value=0.875>Level 7/8</option>
																	    <option value=1.000>Level 8/8</option>
																	</select>
																</td>
															</tr>
														</table>
													</fieldset>
	 											</div>
										</td>
									</tr>
	 								<tr><td colspan="2">&nbsp;</td></tr>
	 								<tr><td colspan="2">&nbsp;</td></tr>
									<tr>
										<td colspan="2" align="center"><input type="Button" name="savedata" id="savedata" class="myButton" value="Update"><!-- &nbsp;
										<input type="Button" hidden="true" name="deletedata" id="deletedata" class="myButton" value="Delete" onclick="fundeletedata();"> --></td>
									</tr>
								</table>
								<input type="hidden" name="status" id="status" style="height:20px;width:70%;" value='<s:property value="status"/>' >
								<input type="hidden" name="dtype" id="dtype" style="height:20px;width:70%;" value='<s:property value="dtype"/>' >
								<input type="hidden" name="vmdocno" id="vmdocno" style="height:20px;width:70%;" value='<s:property value="vmdocno"/>' >
								<input type="hidden" name="vmrdocno" id="vmrdocno" style="height:20px;width:70%;" value='<s:property value="vmrdocno"/>' >
								<input type="hidden" name="maxdin" id="maxdin" style="height:20px;width:70%;" value='<s:property value="maxdin"/>' >
								<input type="hidden" name="maxtin" id="maxtin" style="height:20px;width:70%;" value='<s:property value="maxtin"/>' >
								<input type="hidden" name="maxkm" id="maxkm" style="height:20px;width:70%;" value='<s:property value="maxkm"/>' >
							</td>
 						</tr> 
					</table>
				</fieldset>
			</td>
			<td width="80%">
				<table width="100%">
					<tr>
			 			<td><div id="vehdiv"><jsp:include page="movementupdateGrid.jsp"></jsp:include></div></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div id='maxdate' style="visibility:hidden;" name='maxdate' value='<s:property value="maxdate"/>'></div>
	<div id='maxtime' style="visibility:hidden;" name='maxtime' value='<s:property value="maxtime"/>'></div>
</div>
<div id="fleetwindow"><div></div>
</div>
</div>
</body>
</html>