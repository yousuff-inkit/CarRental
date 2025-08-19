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
.tabheight{
height:180px;
}

</style>


<script type="text/javascript">

$(document).ready(function () {
	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	   document.getElementById("rdsalik").checked=true;
	   funtypechange();
	  
	  
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
});
function funtypechange(){
	 if (document.getElementById('rdsalik').checked) {
		   $('#uasalikGridDiv').show();$('#uatrafficGridDiv').hide();
		} else if (document.getElementById('rdtraffic').checked) {
			$('#uatrafficGridDiv').show();$('#uasalikGridDiv').hide();
		}
}
function funreload(event){
	var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	var todates=new Date($('#todate').jqxDateTimeInput('getDate'));
 	if(fromdates>todates){
		$.messager.alert('Message','To Date Less Than From Date  ','warning');   
		return false;
  	} 
 	if (!(document.getElementById('rdsalik').checked || document.getElementById('rdtraffic').checked)) {
		   $.messager.alert('Message','Select Traffic / Salik ','warning');
		   return false;
	} else {
	
   	
		    var fromdate= $("#fromdate").val();
			var todate= $("#todate").val(); 
			var load="yes";
			var chktype="";
			var chkdatails=$("#chkdatails").val(); 
			 if (document.getElementById('rdsalik').checked) {
				 chktype="salik";
				   document.getElementById("chktypes").value=chktype;
				 $('#uasalikGridDiv').show();$('#uatrafficGridDiv').hide();
			 		$("#overlay, #PleaseWait").show();
			 		$("#uasalikGridDiv").load("salikGrid.jsp?load="+load+"&fromdate="+fromdate+"&todate="+todate+"&chkdatails="+chkdatails);
				} else if (document.getElementById('rdtraffic').checked) {
					 chktype="traffic";
					  document.getElementById("chktypes").value=chktype;
					$('#uatrafficGridDiv').show();$('#uasalikGridDiv').hide();
			 		$("#overlay, #PleaseWait").show();
			  		$("#uatrafficGridDiv").load("trafficGrid.jsp?load="+load+"&fromdate="+fromdate+"&todate="+todate+"&chkdatails="+chkdatails);
			  
				}
   	}
}


function funUnallocate()
{

	var chkdatails=$("#chkdatails").val(); 
		if(chkdatails==1){
			var selectedrows=$('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
			
			if(selectedrows.length!=0){
				$.messager.alert('Warning','Already Allocated.');
				return false;
			}
		} 
		
    $.messager.confirm('Message', 'Do you want to Un Allocate?', function(r){
     	  
	        
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		
     		
     		var chktypes=$('#chktypes').val();
     		
     			
  			 if(chktypes=="salik"){
  				 
  				var selectedrows=$('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
  				if(selectedrows.length==0){
  					$.messager.alert('Warning','Select documents.');
  					return false;
  				}
  	  			  
  			var dataarray=new Array();
			for(var i=0;i<selectedrows.length;i++){
				
				var trans=$('#jqxsalikGrid').jqxGrid('getcelltext',selectedrows[i],'trans');
				dataarray.push(trans);
			}
			ajaxcall(dataarray,chktypes); 
  		  }else if(chktypes=="traffic"){
  			  
  			var selectedrows=$('#jqxtrafficGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					$.messager.alert('Warning','Select documents.');
					return false;
				}
	  			  
  			var dataarray=new Array();
			for(var i=0;i<selectedrows.length;i++){
				
				var trans=$('#jqxtrafficGrid').jqxGrid('getcelltext',selectedrows[i],'ticket_no');
				dataarray.push(trans);
				
			}
		
			ajaxcall(dataarray,chktypes); 
  		  }
    
    }
});
    }

function ajaxcall(dataarray,chktypes){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 	 if(parseInt(itemval)>0)
			    	{
			    	   $.messager.alert('Message', '  Record Successfully Un Allocated ');
			    	   funreload(event);
			    	}
			    else
			    	{
			    	  $.messager.alert('Message', '  Not Un Allocated ');
				      
			    	}
			    
			    
			}
		else
			{
			
			}
	}
	x.open("GET","savedata.jsp?dataarray="+dataarray+'&chktypes='+chktypes,true);
	x.send();
}


function funInvoice()
{


    $.messager.confirm('Message', 'Do you want to Mark as Invoiced?', function(r){
     	  
	        
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		
     		
     		var chktypes=$('#chktypes').val();
  		
  			 if(chktypes=="salik"){
  				 
  				var selectedrows=$('#jqxsalikGrid').jqxGrid('getselectedrowindexes');
  				if(selectedrows.length==0){
  					$.messager.alert('Warning','Select documents.');
  					return false;
  				}
  	  			  
  			var dataarray=new Array();
			for(var i=0;i<selectedrows.length;i++){
				
				var trans=$('#jqxsalikGrid').jqxGrid('getcelltext',selectedrows[i],'trans');
				dataarray.push(trans);
			}
			ajaxcallinv(dataarray,chktypes); 
  		  }else if(chktypes=="traffic"){
  			  
  			var selectedrows=$('#jqxtrafficGrid').jqxGrid('getselectedrowindexes');
				if(selectedrows.length==0){
					$.messager.alert('Warning','Select documents.');
					return false;
				}
	  			  
  			var dataarray=new Array();
			for(var i=0;i<selectedrows.length;i++){
				
				var trans=$('#jqxtrafficGrid').jqxGrid('getcelltext',selectedrows[i],'ticket_no');
				dataarray.push(trans);
				
			}
			
		
			ajaxcallinv(dataarray,chktypes); 
  		  }
    
    }
});
    }

function ajaxcallinv(dataarray,chktypes){
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 	 if(parseInt(itemval)>0)
			    	{
			    	   $.messager.alert('Message', '  Record Successfully Marked as Invoice ');
			    	   funreload(event);
			    	}
			    else
			    	{
			    	  $.messager.alert('Message', '  Not Updated ');
				      
			    	}
			    
			    
			}
		else
			{
			
			}
	}
	x.open("GET","savedatainv.jsp?dataarray="+dataarray+'&chktypes='+chktypes,true);
	x.send();
}







function funExportBtn(){
	if(document.getElementById('rdsalik').checked){
		$("#jqxsalikGrid").excelexportjs({
			containerid: "jqxsalikGrid",
			datatype: 'json',
			dataset: null,
			gridId: "jqxsalikGrid",
			columns: getColumns("jqxsalikGrid") ,
			worksheetName:"Salik Allocation List"
		});	
	}else if(document.getElementById('rdtraffic').checked){
		$("#jqxtrafficGrid").excelexportjs({
			containerid: "jqxtrafficGrid",
			datatype: 'json',
			dataset: null,
			gridId: "jqxtrafficGrid",
			columns: getColumns("jqxtrafficGrid") ,
			worksheetName:"Traffic Allocation List"
		});	
	}
	
 }
 
function funsetaval()
{
	  if (document.getElementById('Unallocated').checked) {
	
	document.getElementById("chkdatails").value="1";
	   }
	  else
		  {
		  document.getElementById("chkdatails").value="0";
		   }
}
	 </script>
</head>
<body onload="getBranch()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%">
<tr>
<td width="20%">
    <fieldset style="background: #ECF8E0;">
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>

	<!--  <tr><td colspan="2">&nbsp;</td></tr> -->
<!--  <tr><td colspan="2" align="center"><label class="branch">Detail</label><input type="checkbox" id="det_chk"  name="det_chk" value="0"   onclick="funsetaval()" >
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>  -->
	 <tr><td colspan="2">&nbsp;</td></tr>
	  <tr><td  align="right" ><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
                    </td></tr>
                     <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
                    </td></tr>
                     <tr><td colspan="2"></td></tr>
                    <tr>
                  <td><input type="checkbox" name="Unallocated" id="Unallocated" onChange="funsetaval();" ></td>
                <td ><span class="branch">Unallocated</span></td>
                </tr>
     <tr><td colspan="2"></td></tr>
                    <tr><td colspan="2">
         <fieldset><legend><b><label class="branch">Type</label></b></legend>
	   <table width="100%">
       <tr>
       <td width="52%" align="center"><input type="radio" id="rdtraffic" name="rdcategory" onchange="funtypechange();"  value="rdtraffic"><label for="rdtraffic" class="branch" id="lbltraffic">Traffic</label></td>
       <td width="48%" align="center"><input type="radio" id="rdsalik" name="rdcategory"  onchange="funtypechange();"  value="rdsalik"><label for="rdsalik" class="branch">Salik</label></td>
       </tr>
       <tr><td>
        <input type="hidden" id="chktypes" name="chktypes" />
         <input type="hidden" id="chkdatails" name="chkdatails" value='<s:property value="chkdatails"/>'>
           
    </td></tr>
       </table>
	  </fieldset>
	
	</td></tr>
	<tr colspan="3"><td >&nbsp;</td></tr>
	<tr colspan="3"><td >&nbsp;</td></tr>
	<tr><td colspan="2" align="center">
	<button class="myButton" type="button" id="btnunallocate" name="btnunallocate" onclick="funUnallocate(event);">Unallocate</button>
	 <button class="myButton" type="button" id="btninvoiced" name="btninvoiced" onclick="funInvoice(event);">Mark as Invoiced</button></td></tr>
	  
<tr class="tabheight"><td >&nbsp;</td></tr>

	</table>
	</fieldset>
	</td>
	<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="uasalikGridDiv"><jsp:include page="salikGrid.jsp"></jsp:include></div></td>
		</tr>
		<tr>
			 <td><div id="uatrafficGridDiv"><jsp:include page="trafficGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</td>
	</tr>
</table>

</div>
</div>

</body>
</html>
