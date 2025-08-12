
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

	 getCurrency();
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	  $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");

	     
	     var curfromdate= $('#fromdate').jqxDateTimeInput('getDate');
	     var oneyeardate=new Date(new Date(curfromdate).setMonth(curfromdate.getMonth()-1));
	     var oneyearbackdate=new Date(new Date(oneyeardate).setDate(oneyeardate.getDate()));
	     $('#fromdate ').jqxDateTimeInput('setDate', new Date(oneyearbackdate));
		});
		
		
function funreload(event)
{
	 var fromdate = $('#fromdate').val();
	 var todate = $('#todate').val();
	 var currid = $('#currencyid').val();
	  
	 
	  $("#overlay, #PleaseWait").show();
	  $("#curlist").load("curbookGrid.jsp?fromdate="+fromdate+"&todate="+todate+"&currid="+currid+"&chk=1");
		
		  
	}

function getCurrency() {
    var x = new XMLHttpRequest();
    var items, currIdItems, currCodeItems;
    x.onreadystatechange = function() {
        if (x.readyState == 4 && x.status == 200) {
            items = x.responseText;
            items = items.split('####');
            currIdItems = items[0].split(",");
            currCodeItems = items[1].split(",");

            var optionscurr = '<option value="">--Select--</option>';
            for (var i = 0; i < currCodeItems.length; i++) {
                optionscurr += '<option value="' + currIdItems[i] + '">' + currCodeItems[i] + '</option>';
            }
            $("select#currencyid").html(optionscurr);
           
        } else {}

        if ($('#hidcurid').val()) {
            $("#currencyid").val($('#hidcurid').val());
        }
    }
    x.open("GET", "getCurrency.jsp", true);
    x.send();
}	

function funExportBtn(){
  
    $("#curlist").excelexportjs({
			containerid: "curlist",   
			datatype: 'json',
			dataset: null,
			gridId: "curdetailsgrid",
			columns: getColumns("curdetailsgrid") ,   
			worksheetName:"Currency Book Report"  
		});   
} 

</script>
<style>
.hidden-scrollbar{
    height: 82vh;
    overflow-x: hidden;

}

</style>
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
		
	 <tr><td colspan="2">&nbsp;</td></tr>
	 	

	 
	 
	   <tr>
	<td align="right" width="20%"><label class="branch">From </label></td>
            <td align="left"><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td></tr>
            <tr>
<td align="right" width="20%"><label class="branch">To </label></td>
            <td align="left"><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
            </tr>
            <tr><td colspan="2">&nbsp;</td></tr>  
            
            <tr>
            <td width="17%" align="right"><label class="branch">Currency</label></td>
                                       <td width="83%" align="left">  
                                          <select id="currencyid" name="currencyid"  value='<s:property value="currencyid"/>'>
                                             <option value="">--Select--</option>
                                          </select></td>
                 </tr>                         
     <tr><td colspan="2">&nbsp;</td></tr>  
     <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>  
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>
	 <tr><td colspan="2">&nbsp;</td></tr>	
	 <tr><td colspan="2">&nbsp;</td></tr>
            
       </table>       
      </fieldset>

</td>

            
            <td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="curlist"><jsp:include page="curbookGrid.jsp"></jsp:include></div></td>
		</tr>
            
            </table>
</tr>
</table>

</div>

</div>

</body>
</html>