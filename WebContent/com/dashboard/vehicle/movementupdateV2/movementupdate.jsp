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
<style type="text/css">
  
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

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
</style>
<body onload="hiddenbrh();disitems();">

<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>

<table width="100%">
<tr>

<!-- ================= LEFT PANEL (20%) ================= -->
<td width="20%" valign="top">

    <div class="master-container">
        <div class="sidebar-filters">

            <!-- Heading -->
            <div class="sidebar-fixed-top">
                <div class="filter-card">
                    <jsp:include page="../../heading.jsp"></jsp:include>
                </div>
            </div>

            <!-- Scrollable Content -->
            <div class="sidebar-scroll-content">

                <!-- Date & Fleet Filter -->
                <div class="filter-card">
                    <table class="filter-table">

                        <tr>
                            <td class="label-cell">From</td>
                            <td><div id='fromdate'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">To</td>
                            <td><div id='todate'></div></td>
                        </tr>

                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td>
                                <input type="text"
                                       id="fleetno"
                                       name="fleetno"
                                       placeholder="Press F3 To Search"
                                       readonly
                                       value='<s:property value="fleetno"/>'
                                       onkeydown="getfleetdata(event);">
                            </td>
                        </tr>

                    </table>
                </div>

                <!-- Out Details -->
                <div class="filter-card">
                    <fieldset>
                        <legend>Out Details</legend>

                        <table class="filter-table">

                            <tr>
                                <td class="label-cell">Date</td>
                                <td><div id='dateout'></div></td>
                            </tr>

                            <tr>
                                <td class="label-cell">Time</td>
                                <td><div id='timeout'></div></td>
                            </tr>

                            <tr>
                                <td class="label-cell">KM</td>
                                <td>
                                    <input type="text"
                                           name="outkm"
                                           id="outkm"
                                           value='<s:property value="outkm"/>'
                                           onkeypress="return isNumber(event)">
                                </td>
                            </tr>

                            <tr>
                                <td class="label-cell">Fuel</td>
                                <td>
                                    <select id="outfuel" name="outfuel">
                                        <option value="">-Select-</option>
                                        <option value="0.000">Level 0/8</option>
                                        <option value="0.500">Level 4/8</option>
                                        <option value="1.000">Level 8/8</option>
                                    </select>
                                </td>
                            </tr>

                        </table>
                    </fieldset>
                </div>

                <!-- In Details -->
                <div class="filter-card">
                    <fieldset>
                        <legend>In Details</legend>

                        <table class="filter-table">

                            <tr>
                                <td class="label-cell">Date</td>
                                <td><div id='datein'></div></td>
                            </tr>

                            <tr>
                                <td class="label-cell">Time</td>
                                <td><div id='timein'></div></td>
                            </tr>

                            <tr>
                                <td class="label-cell">KM</td>
                                <td>
                                    <input type="text"
                                           name="inkm"
                                           id="inkm"
                                           value='<s:property value="inkm"/>'
                                           onblur="inchkkm()"
                                           onkeypress="return isNumber(event)">
                                </td>
                            </tr>

                            <tr>
                                <td class="label-cell">Fuel</td>
                                <td>
                                    <select id="infuel" name="infuel">
                                        <option value="">-Select-</option>
                                        <option value="0.000">Level 0/8</option>
                                        <option value="0.500">Level 4/8</option>
                                        <option value="1.000">Level 8/8</option>
                                    </select>
                                </td>
                            </tr>

                        </table>
                    </fieldset>
                </div>

                <!-- Update Button (Full Width like master) -->
                <button type="button"
                        id="savedata"
                        class="btn-submit"
                        onclick="funupdate();">
                    Update
                </button>

                <!-- Hidden Fields -->
                <input type="hidden" name="status" id="status" value='<s:property value="status"/>'>
                <input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
                <input type="hidden" name="vmdocno" id="vmdocno" value='<s:property value="vmdocno"/>'>
                <input type="hidden" name="vmrdocno" id="vmrdocno" value='<s:property value="vmrdocno"/>'>
                <input type="hidden" name="maxdin" id="maxdin" value='<s:property value="maxdin"/>'>
                <input type="hidden" name="maxtin" id="maxtin" value='<s:property value="maxtin"/>'>
                <input type="hidden" name="maxkm" id="maxkm" value='<s:property value="maxkm"/>'>

            </div>
        </div>
    </div>

</td>

<!-- ================= RIGHT PANEL (80%) ================= -->
<td width="80%" valign="top">
    <table width="100%">
        <tr>
            <td>
                <div id="vehdiv">
                    <jsp:include page="movementupdateGrid.jsp"></jsp:include>
                </div>
            </td>
        </tr>
    </table>
</td>

</tr>
</table>

<div id='maxdate' style="visibility:hidden;"></div>
<div id='maxtime' style="visibility:hidden;"></div>

</div>

<div id="fleetwindow">
    <div></div>
</div>

</div>
</body>
</html>