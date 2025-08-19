<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Timesheet Review</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" /> 

<style type="text/css">
.tabheight{
height:210px;
} 
</style>
<script type="text/javascript">

$(document).ready(function () {
	getYear();
	 var curmonth=new Date().getMonth()-1;
	   $('#cmbmonth').prop('selectedIndex',curmonth);

     $('#employeeDetailsWindow').jqxWindow({width: '50%', height: '59%',  maxHeight: '48%' ,maxWidth: '32%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#employeeDetailsWindow').jqxWindow('close');
		 $('#managerDetailsWindow').jqxWindow({width: '50%', height: '59%',  maxHeight: '48%' ,maxWidth: '32%' , title: 'Manager Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#managerDetailsWindow').jqxWindow('close');
		 
		 
		 $('#cmbemp').dblclick(function(){
	  			employeeSearchContent("employeesearchGrid.jsp");
			  });
		 $('#cmbmanager').dblclick(function(){
	  			managerSearchContent("managersearchGrid.jsp");
			  });
		
 
});




function employeeSearchContent(url) {
 	$('#employeeDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#employeeDetailsWindow').jqxWindow('setContent', data);
	$('#employeeDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getEmployeeId(event){
    var x= event.keyCode;
    if(x==114){
    	employeeSearchContent("employeesearchGrid.jsp");
    }
    else{}
    }
    
function managerSearchContent(url) {
 	$('#managerDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#managerDetailsWindow').jqxWindow('setContent', data);
	$('#managerDetailsWindow').jqxWindow('bringToFront');
}); 
}

function getManager(event){
    var x= event.keyCode;
    if(x==114){
    	managerSearchContent("managersearchGrid.jsp");
    }
    else{}
    }
 
function funreload(event){
	
	 $("#overlay, #PleaseWait").show();
	 
	 var year = $('#cmbyear').val();
	 var month = $('#cmbmonth').val();
	 var hidcmbemp=$('#hidcmbemp').val();
	 var hidcmbmanager=$('#hidcmbmanager').val(); 
	 var status=$('#cmbstatus').val();
	
	 $("#emptimesheetrevDiv").load("employeetimesheetreviewGrid.jsp?check=1&year="+year+'&month='+month+'&hidcmbemp='+hidcmbemp+'&hidcmbmanager='+hidcmbmanager+'&status='+status);
}

 
 function getYear() {
	 var curyear=new Date().getFullYear();

		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear = '<option value="">--Select--</option>';
				for (var i = 0; i < yearItems.length; i++) {
					optionsyear += '<option value="' + yearIdItems[i] + '">'
							+ yearItems[i] + '</option>';
				}
				$("select#cmbyear").html(optionsyear);
				if ($('#hidcmbyear').val() != null) {
					$('#cmbyear').val($('#hidcmbyear').val());
				}
				if (curyear != null) {

					document.getElementById("cmbyear").value=curyear;
					}
			} else {
			}
		}
		x.open("GET", "getYear.jsp", true);
		x.send();
	}
 function funExportBtn() {
	 	 $("#emptimesheetrevDiv").excelexportjs({  
		 containerid: "emptimesheetrevDiv", 
		 datatype: 'json', 
		 dataset: null, 
		 gridId: "employeetymsheetrevGridId", 
		 columns: getColumns("employeetymsheetrevGridId") ,   
		 worksheetName:"Timesheet Review"
		 });
 }

 
 function  funClearInfo() {
	    $('#cmbemp').val('');
		$('#hidcmbemp').val('');
		$('#cmbmanager').val(''); 
		$('#hidcmbmanager').val(' ');
		$("#employeetymsheetrevGridId").jqxGrid('clear');
		
		if (document.getElementById("cmbemp").value == "") {
	        $('#txtusername').attr('placeholder', 'Press F3 to Search'); 
	    }
		
		if (document.getElementById("cmbemp").value == "") {
	        $('#cmbemp').attr('placeholder', 'Press F3 to Search'); 
	    }if (document.getElementById("cmbmanager").value == "") {
	        $('#cmbmanager').attr('placeholder', 'Press F3 to Search'); 
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
	<tr ><td >&nbsp;</td></tr>
	<tr ><td >&nbsp;</td></tr>
	
	<tr>
    
		<tr><td align="right"><label class="branch">Year</label></td>
	<td align="left"><select id="cmbyear" name="cmbyear" style="width:80%;" value='<s:property value="cmbyear"/>'></select>
    <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td>
  <tr>
    <tr><td align="right"><label class="branch">Month</label></td>
	 <td ><select id="cmbmonth" name="cmbmonth" style="width:80%;" value='<s:property value="cmbmonth"/>'>
      <option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
       <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td>
        </tr>
        <tr><td align="right"><label class="branch">Employee</label></td>
	<td align="left"><input id="cmbemp" name="cmbemp" style="width:80%;" placeholder="Press F3 to Search"  value='<s:property value="cmbemp"/>'></select>
    <input type="hidden" id="hidcmbemp" name="hidcmbemp" value='<s:property value="hidcmbemp"/>'/></td>
 <tr><td align="right"><label class="branch">Manager</label></td>
	<td align="left"><input id="cmbmanager" name="cmbmanager" style="width:80%;" placeholder="Press F3 to Search"  value='<s:property value="cmbmanager"/>'></select>
    <input type="hidden" id="hidcmbmanager" name="hidcmbmanager" value='<s:property value="hidcmbmanager"/>'/></td>
 <tr><td align="right"><label class="branch">Status</label></td>
	 <td ><select id="cmbstatus" name="cmbstatus" style="width:80%;" value='<s:property value="cmbstatus"/>'>
      <option value="1">ALL</option><option value="2">Approved</option><option value="3">Pending</option></select></td>
  
  <tr><td colspan="2">&nbsp;</td></tr>
  
   	<tr><td  colspan="2"align="center"><input type="button" class="myButtons" name="clear" id="clear"  value="Clear" onclick="funClearInfo();"></td></tr>
  <tr class="tabheight"><td ></td></tr>
    
	<tr>
   </table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="emptimesheetrevDiv"><jsp:include page="employeetimesheetreviewGrid.jsp"></jsp:include></div></td>
		</tr>
		
		<tr>
			 <td><div id="attendanceDiv"><jsp:include page="attendanceGrid.jsp"></jsp:include></div></td>
		</tr>
	</table>
</tr>
</table>
</div>
<div id="employeeDetailsWindow">
	<div></div>
</div>
<div id="managerDetailsWindow">
	<div></div>
</div>

</div>

</body>
</html>
	


