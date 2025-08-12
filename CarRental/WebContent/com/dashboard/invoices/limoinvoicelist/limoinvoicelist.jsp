 
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
 .myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
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

<script type="text/javascript">

$(document).ready(function () {
	
	     $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 $('#docWindow').jqxWindow({width: '50%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: ' Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#docWindow').jqxWindow('close');
		 $('#accountDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsWindow').jqxWindow('close');
		 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     
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
	 

	     $('#txtaccid').dblclick(function(){
			  accountsSearchContent('accountsDetailsSearch.jsp');
	     });
	   
	  
	     
	  
});

function  funcleardata()
{
	document.getElementById("txtaccname").value="";
	document.getElementById("fromdocno").value="";
	document.getElementById("todocno").value="";
	document.getElementById("txtaccid").value="";
	document.getElementById("txtdocno").value="";
 	document.getElementById("statusselect").value="All";
       $('#txtaccid').attr('placeholder', 'Press F3 TO Search'); 
       $('#invlistdet').jqxGrid('clear');   
}
	


function funExportBtn(){
		// JSONToCSVCon(datass, 'Limo Invoice List', true);   
		  $("#listdivsumm").excelexportjs({  
       		containerid: "listdivsumm", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "invlistdet", 
       		columns: getColumns("invlistdet") , 
       		worksheetName:"Limo Invoice List"
       		}); 

	 }
function accountsSearchContent(url) {
    $('#accountDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#accountDetailsWindow').jqxWindow('setContent', data);
	$('#accountDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getAccTypeFrom(event){
    var x= event.keyCode;
    if(x==114){
  		accountsSearchContent('accountsDetailsSearch.jsp');
    }
    else{}
    }

function isNumberKey(evt){
    var charCode = (evt.which) ? evt.which : event.keyCode
    if (charCode > 31 && ((charCode < 48) || (charCode > 57)))          
        return false;
    return true;
}

function funPrint(){
	var selectedrows=$("#invlistdet").jqxGrid('selectedrowindexes');
	selectedrows = selectedrows.sort(function(a,b){return a - b});  
	if(selectedrows.length>100){
		$.messager.alert('Message','Selected documents not more than 100...!!!','warning');	
		return false;
	}
	
			var i=0;
			var tempdocno="0";
		    var j=0;
		    for (i = 0; i < selectedrows.length; i++) {
		    
						var srvdetmdocno= $('#invlistdet').jqxGrid('getcellvalue', selectedrows[i], "doc_no");
								tempdocno=tempdocno+","+srvdetmdocno;
								j++;
		    }  
		    $('#srvdetmdocno').val(tempdocno); 
		  // alert(j);
		 
		     if(j==0)   
		    	 {
		  	 //  alert(8);
		    	 $.messager.alert('Message','Please Select a Document ','warning');	
		    	 }
		     else
		    	 {
		  	//   alert(7);
		        var url=document.URL;
		        var reurl=url.split("limoinvoicelist.jsp");
		        alert(reurl[0]+"printLimoInvoiceList?docno="+$('#srvdetmdocno').val()+"&branch="+document.getElementById("cmbbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        var win= window.open(reurl[0]+"printLimoInvoiceList?docno="+$('#srvdetmdocno').val()+"&branch="+document.getElementById("cmbbranch").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
		        win.focus();
	}	     
	}
                

function funreload(event)
{
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var Accno = $('#txtdocno').val();
	 var fromdocno = $('#fromdocno').val();
	 var todocno = $('#todocno').val();
	 var branchval = document.getElementById("cmbbranch").value;

	 $("#listdivsumm").load("limodetinvoicelistGrid.jsp?Accno="+Accno+"&fromdate="+fromdate+"&todate="+todate+"&fromdocno="+fromdocno+"&todocno="+todocno+"&branchval="+branchval+"&status=1");
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
	<table width="100%" >
	<jsp:include page="../../heading.jsp"></jsp:include>
		
	 
	  <tr><td  align="right" width="30%"><label class="branch">From</label></td><td align="left"><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div>
      </td></tr>
                    
      <tr><td  align="right" ><label class="branch">To</label></td><td align="left"><div id='todate' name='todate' value='<s:property value="todate"/>'></div>
      </td></tr>

	<tr><td align="right"><label class="branch">Account</label></td>
	<td align="left"><input type="text" id="txtaccid" name="txtaccid" style="width:60%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtaccid"/>' onkeydown="getAccTypeFrom(event);"/></td></tr> 
	<tr><td>&nbsp;</td>
	<td><input type="text" id="txtaccname" name="txtaccname" style="width:100%;height:20px;" readonly="readonly" value='<s:property value="txtaccname"/>' tabindex="-1"/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    </td></tr> 
 	 <tr>
<td align="right" ><label class="branch">From Docno</label></td>
<td ><input type="text" name="fromdocno" id="fromdocno" value='<s:property value="fromdocno"/>'     style="height:20px;width:70%;" onkeypress="return isNumberKey(event)"  >  </td></tr>
 <tr><td align="right"><label class="branch">To Docno</label></td><td><input type="text" name="todocno" id="todocno" value='<s:property value="todocno"/>'  Style="height:20px;width:70%;" onkeypress="return isNumberKey(event)" ></td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>	
   <tr><td><input type="button" style="display:none;" class="myButtons" name="print" id="print" value="Print" onclick="funPrint()"></td>
 <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funcleardata()"></td></tr>
    <tr><td colspan="2" align="center">   
	   
	   	  <div id="summs"  style="resize:none;font: 10px Tahoma;hight:20px" >
	   	 <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	     	 <br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;<br> &nbsp;
	   	     	  <br> &nbsp;<br> &nbsp;<br> &nbsp;
	
	   	  </div></td></tr>

	</table>
	</fieldset>
   <input type="hidden" id="acno" name="acno" value='<s:property value="acno"/>'>
   
     <input type="hidden" id="invdocnomaster" name="invdocnomaster" value='<s:property value="invdocnomaster"/>'> 
</td>
<td width="80%">
	
	
	
	<table width="100%">
		<tr>
			 <td><div id="listdivsumm"><jsp:include page="limodetinvoicelistGrid.jsp"></jsp:include></div></td>
		</tr>
		    
	</table>
	</td>
</tr>
</table>
     <input type="hidden" id="statusselect" name="statusselect" value="All"> 
     <input type="hidden" id="srvdetmdocno" name="srvdetmdocno">      
		

</div>
<div id="accountDetailsWindow">
	<div></div><div></div>
</div> 
 
<div id="docWindow">
   <div ></div>
</div> 




</div>
</body>
</html>