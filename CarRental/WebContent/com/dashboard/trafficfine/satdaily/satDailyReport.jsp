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
<script type="text/javascript">

	$(document).ready(function () {
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $('#userwindow').jqxWindow({ width: '25%', height: '68%',  maxHeight: '68%' ,maxWidth: '25%' , title: 'Username Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		 $('#userwindow').jqxWindow('close');
		 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
	     
	     document.getElementById("rdticketdate").checked=true;
	     document.getElementById("rdsalik").checked=true;
	     fundisable();
	     $('#username').dblclick(function(evt){
		    	var satcategory="";
				if (document.getElementById('rdsalik').checked==true) {
					satcategory="Salik";
				} else if (document.getElementById('rdtraffic').checked==true) {
					satcategory="Traffic";
				}
				var saliksource=$('#cmbsaliksource').val();
				$('#userwindow').jqxWindow('open');
				$('#userwindow').jqxWindow('focus');
				usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1'); 
		    });
		
	});
	
	function usernameSearchContent(url) {
		$.get(url).done(function (data) {
			$('#userwindow').jqxWindow('setContent', data);
		}); 
	}
	function getDailyCount(fromdate,todate,satcateg) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200) {
		               items= x.responseText;
		        	   document.getElementById("searchdetails").value=items;
		    } else {}
		}
		x.open("GET",'getDailyCount.jsp?fromdate='+fromdate+'&todate='+todate+'&satcateg='+satcateg,true);
		x.send();
	}

	function funreload(event){
		 
  		 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); 
	 	 
	   	 if(fromdates>todates){
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
	   	   return false;
	     }
	   	 
	   	if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
			   $.messager.alert('Message','Select Salik / Traffic','warning');
			   return false;
		} else {
		
			 var barchval = document.getElementById("cmbbranch").value;
		     var fromdate= $("#fromdate").val();
			 var todate= $("#todate").val();
			 var check=1;
	         var satcateg="";
	         var datefilter="";
	         var saliksource=$('#cmbsaliksource').val();
	         var username=$('#username').val();
	         if (document.getElementById('rdticketdate').checked) {
	        	 datefilter="1";
	         } else if (document.getElementById('rddownloaddate').checked) {
	        	 datefilter="2";
	         }
	   			  
	         
	         if (document.getElementById('rdticketdate').checked) {
	        	 datefilter="1";
	         } else if (document.getElementById('rddownloaddate').checked) {
	        	 datefilter="2";
	         }
	         
			 if (document.getElementById('rdsalik').checked) {
				satcateg="salik";
		 		$("#overlay, #PleaseWait").show();
		  		$("#satSalikDiv").load("satSalikGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=salik&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&username="+username);
		  
			} else if (document.getElementById('rdtraffic').checked) {
				satcateg="traffic";
		 		$("#overlay, #PleaseWait").show();
		  		$("#satTrafficDiv").load("satTrafficGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg=traffic&datefilter="+datefilter+"&check="+check+"&username="+username);
		  
			}
	 
	 		$("#satCountDiv").load("satCountGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&satcateg="+satcateg+"&datefilter="+datefilter+"&check="+check+"&saliksource="+saliksource+"&userName="+username);
	 		//getDailyCount(fromdate,todate,satcateg);
		 
			}
	   	
		}

		function clearUserName(){
			$('#username').val('');
		}
		
		function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	if (document.getElementById('rdsalik').checked) {
			 	/* JSONToCSVCon(salikdailyexceldata, 'Salik Daily List', true); */
			 	$("#satSalikDiv").excelexportjs({
					 containerid: "satSalikDiv",
					 datatype: 'json',
					 dataset: null,
					 gridId: "jqxloaddataGrid",
					 columns: getColumns("jqxloaddataGrid") ,
					 worksheetName:"Salik Daily List"
					 });
		    } 
		  	if (document.getElementById('rdtraffic').checked) {
				/* JSONToCSVCon(trafficdailyexceldata, 'Traffic Daily List', true); */
				$("#satTrafficDiv").excelexportjs({
					 containerid: "satTrafficDiv",
					 datatype: 'json',
					 dataset: null,
					 gridId: "jqxloadtrafficdataGrid",
					 columns: getColumns("jqxloadtrafficdataGrid") ,
					 worksheetName:"Traffic Daily List"
					 });
			}
		 }
	 }
		
	function fundisable(){
		if (document.getElementById('rdsalik').checked) {
			  $('#satSalikDiv').show();$('#satTrafficDiv').hide();
		} else if (document.getElementById('rdtraffic').checked) {
			  $('#satSalikDiv').hide();$('#satTrafficDiv').show();
		}
	}
	function funGetUsername(evt){
		var x= event.keyCode;
		if(x==114){
			var satcategory="";
			if (document.getElementById('rdsalik').checked) {
				satcategory="Salik";
			} else if (document.getElementById('rdtraffic').checked) {
				satcategory="Traffic";
			}
			var saliksource=$('#cmbsaliksource').val();
			$('#userwindow').jqxWindow('open');
			$('#userwindow').jqxWindow('focus');
			usernameSearchContent('usernameSearchGrid.jsp?satcategory='+satcategory+'&saliksource='+saliksource+'&id=1');
		}
		else{
		}
	}
</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr>
	 <td align="right"><label class="branch">From</label></td>
     <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr> 
	<tr>
	<td align="right"><label class="branch">To</label></td>
    <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
	</tr>  
	<tr>
		<td align="right"><label class="branch">Salik Source</label></td>
    	<td align="left"><select name="cmbsaliksource" id="cmbsaliksource" style="width:125px;"><option value="">All</option><option value="AUH">AUH</option><option value="DXB">DXB</option></select></td>
	</tr> 
	<tr><td colspan="2">
	  <fieldset><legend><b><label class="branch">Report Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="50%" align="left"><input type="radio" id="rdticketdate" name="rddatefilter" value="rdticketdate"><label for="rdticketdate" class="branch">Ticket Date</label></td>
       <td width="50%" align="left"><input type="radio" id="rddownloaddate" name="rddatefilter" value="rddownloaddate"><label for="rddownloaddate" class="branch">Download Date</label></td>
       </tr>
       <tr>
       <td width="50%" align="left"><input type="radio" id="rdsalik" name="rdcategory" onchange="fundisable();" value="rdsalik"><label for="rdsalik" class="branch">Salik</label></td>
       <td width="50%" align="left"><input type="radio" id="rdtraffic" name="rdcategory" onchange="fundisable();" value="rdtraffic"><label for="rdtraffic" class="branch">Traffic</label></td>
       </tr>
       </table>
	  </fieldset>
	</td></tr>
	<tr>
		<td align="right"><label class="branch">User</label></td>
    	<td align="left" style="width:100px;" ><input type="text" name="username" id="username" style="height:18px;" onkeydown="funGetUsername(event);">   <button style="color:#e63946;text-align:center;border:none;font-weight: bold;" onclick="clearUserName()">X</button></td>
	</tr>
	<tr><td colspan="2"><div id="satCountDiv"><jsp:include page="satCountGrid.jsp"></jsp:include></div></td></tr> 
	<tr><td colspan="2"><textarea id="searchdetails" hidden="true" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="10"  readonly></textarea></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="satSalikDiv"><jsp:include page="satSalikGrid.jsp"></jsp:include></div>
			 <div id="satTrafficDiv"><jsp:include page="satTrafficGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
<div id="userwindow">
   <div ></div>
</div>
</div>
</div>
</body>
</html>