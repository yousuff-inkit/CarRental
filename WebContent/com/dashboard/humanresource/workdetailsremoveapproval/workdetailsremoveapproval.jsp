<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script> 
<style type="text/css">

.tabheight{
height:230px;

}
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

.myButtonses {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #599bb3), color-stop(1, #408c99));
 background:-moz-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-webkit-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-o-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:-ms-linear-gradient(top, #599bb3 5%, #408c99 100%);
 background:linear-gradient(to bottom, #599bb3 5%, #408c99 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#599bb3', endColorstr='#408c99',GradientType=0);
 background-color:#599bb3;
 -moz-border-radius:4px;
 -webkit-border-radius:4px;
 border-radius:4px;
 display:inline-block;
 cursor:pointer;
 color:#ffffff;
 font-family:Verdana;
 font-size:10px;
 padding:4px 8px;
 text-decoration:none;
}
.myButtonses:hover {
 background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #408c99), color-stop(1, #599bb3));
 background:-moz-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-webkit-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-o-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:-ms-linear-gradient(top, #408c99 5%, #599bb3 100%);
 background:linear-gradient(to bottom, #408c99 5%, #599bb3 100%);
 filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#408c99', endColorstr='#599bb3',GradientType=0);
 background-color:#408c99;
}
.myButtonses:active {
 position:relative;
 top:1px;
}
.myButtonReCheck {
	-moz-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	-webkit-box-shadow:inset 0px 1px 0px 0px #3dc21b;
	box-shadow:inset 0px 1px 0px 0px #3dc21b;
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #44c767), color-stop(1, #5cbf2a));
	background:-moz-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-webkit-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-o-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:-ms-linear-gradient(top, #44c767 5%, #5cbf2a 100%);
	background:linear-gradient(to bottom, #44c767 5%, #5cbf2a 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#44c767', endColorstr='#5cbf2a',GradientType=0);
	background-color:#44c767;
	-moz-border-radius:42px;
	-webkit-border-radius:42px;
	border-radius:42px;
	border:6px solid #18ab29;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:10px;
	font-weight:bold;
	padding:3px 8px;
	text-decoration:none;
	text-shadow:0px 1px 0px #2f6627;
}
.myButtonReCheck:hover {
	background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5cbf2a), color-stop(1, #44c767));
	background:-moz-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-webkit-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-o-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:-ms-linear-gradient(top, #5cbf2a 5%, #44c767 100%);
	background:linear-gradient(to bottom, #5cbf2a 5%, #44c767 100%);
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5cbf2a', endColorstr='#44c767',GradientType=0);
	background-color:#5cbf2a;
}
.myButtonReCheck:active {
	position:relative;
	top:1px;
}
</style>
<script type="text/javascript">
$(document).ready(function () {
	  $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
	  $('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );
    window.parent.formCode.value="WDRA";
	window.parent.formName.value="Work Details Remove Approval";
	getYear();
	 var curmonth=new Date().getMonth()-1;
	   $('#cmbmonth').prop('selectedIndex',curmonth);
	   
	   $('#txtcomments').attr('readonly', true);
	   $('#txtemployeeid').attr('readonly', true);
		 $('#txtemployeename').attr('readonly', true);
		
});
	
    function getYear() {
   	 var curyear=new Date().getFullYear();
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var yearItems = items[0].split(",");
				var yearIdItems = items[1].split(",");
				var optionsyear ;
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
    
    function setValues(){
		//document.getElementById("cmbmonth").value=document.getElementById("hidcmbmonth").value;
		//document.getElementById("cmbyear").value=document.getElementById("hidcmbyear").value;

	 
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 

      
	}
    
    
    function funViewAttendance(){
		 document.getElementById("errormsg").innerText="";

					
		    	if($('#cmbyear').val()==''){
		    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
					 return 0;
				 }
		    	
		    	if($('#cmbmonth').val()==''){
		    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
					 return 0;
				 }
		    	
		    	var x = document.getElementById("cmbday").length; 
		    	var totdays=(x-1);
				var year=$("#cmbyear").val();
				var month=$("#cmbmonth").val();
				var empid=$("#txtemployeedocno").val().trim();
		 		var branch=document.getElementById("brchName").value;    
		 		var check=1;    
		    	
		    	$("#overlay, #PleaseWait").show();
		    	$("#attendanceDiv").load("attendanceGrid.jsp?totdays="+totdays+"&year="+year+"&month="+month+"&check="+check+"&branch="+branch+"");

	 }
	 
    
	

    
    function getUser() {
    	var x = new XMLHttpRequest();
    	var items, nameItems, IdItems,docItems;
    	x.onreadystatechange = function() {
    		if (x.readyState == 4 && x.status == 200) {
    			items = x.responseText;
    			items = items.split('***');
    			IdItems = items[0];
    			nameItems = items[1];
    			docItems = items[2];

  			    $('#txtemployeename').val(nameItems);
  			    $('#txtemployeeid').val(IdItems);
  			    $('#txtemployeedocno').val(docItems);

    		}
    	}
    	x.open("GET", "getuser.jsp", true);
    	x.send();
    }
    
function funReadOnly(){} 
	
	function funRemoveReadOnly(){
		
	}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
    

    function funConfirm() {
		
		var year=$("#cmbyear").val();
		var month=$("#cmbmonth").val();
 		var branch=document.getElementById("brchName").value;    
	 	var length=0;
 		var confirmed=0;
 		if($('#cmbyear').val()==''){
    		 document.getElementById("errormsg").innerText="Year is Mandatory.";
			 return 0;
		 }
    	
    	if($('#cmbmonth').val()==''){
    		 document.getElementById("errormsg").innerText="Month is Mandatory.";
			 return 0;
		 }
		
	    var temp1="",temp2="";
		var rows = $("#attendanceGridID").jqxGrid('getrows');	
		var selectedrows=$("#attendanceGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select an Employee to be Confirmed.');
			return false;
		}
		var i=0;var j=0;var k=0;var temp="",tempcnfm="",tempdbname="",temp3="";
		
		
	    for (i = 0; i < rows.length; i++) {
	    	
	    	
	    	
				if(selectedrows[j]==i){
					if(k==0){
						temp=rows[i].srno;
						tempcnfm=rows[i].confirmed;
						tempdbname=rows[i].dbs;
						tempemp=rows[i].emp;
						k=1;
					}
					else{
						temp=temp+"::"+rows[i].srno;
						tempcnfm=tempcnfm+"::"+rows[i].confirmed;
						tempdbname=tempdbname+"::"+rows[i].dbs;
						tempemp=tempemp+"::"+rows[i].emp;

					}
					temp1=temp+"::";
					temp2=tempcnfm+"::";
					temp3=tempdbname+"::";
					temp4=tempemp;
				j++; 
			  }
            }
	    $('#txtselectedsrno').val(temp1);
	    $('#txtselectedcnfm').val(temp2);
	    $('#txtselecteddb').val(temp3);
	    $('#hidempid').val(temp4);

	    $.messager.confirm('Confirm', 'Do you want to Remove ?', function(r){
  	 		if (r){
  	 			  var selectedsrno = $('#txtselectedsrno').val();
  	 			//  $("#overlay, #PleaseWait").show();
  	 			 var selectedcnfm = $('#txtselectedcnfm').val();
  	 			 var selecteddb = $('#txtselecteddb').val();
  	 			var selectedempid= $('#hidempid').val();

  	 			 if((selectedcnfm.includes("0")))
  	 				 {
  	 				 document.getElementById("errormsg").innerText="Unable to remove!";
					 return 0;
					
  	 				 }
  	 			 else
  	 				 {
  	 				 
  	 				 
  	 				 confirmed=0;
  	 				 }
  	 			  saveGridData(selectedsrno,confirmed,selecteddb,selectedempid);
  	 	  }
  	  });  
		
	}
 
	function saveGridData(selectedsrno,confirmed,selecteddb,selectedempid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0){
					
	  	 			
	  	 		
					$.messager.alert('Message', 'Approval Removed ', function(r){
				    });
					$('#attendanceGridID').jqxGrid('clearfilters', true);  
				
			      
				} else {
					$.messager.alert('Message', 'Not Removed ', function(r){
				    });
					
				} 
				$("#overlay, #PleaseWait").hide();
				$('#attendanceGridID').jqxGrid('clearfilters', true);  
			
		  }
		}
			
	x.open("GET","confirmData.jsp?selectedsrno="+selectedsrno+"&confirmed="+confirmed+"&selecteddb="+selecteddb+"&selectedempid="+selectedempid,true);
	x.send();
	}

 
 </script>

<body onload="getUser();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmWorkDetailsremoveApproval" action="saveWorkDetailsremoveApproval" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>   

<div class='hidden-scrollbar'>
<table width="99%"  >
  <tr>
    <td width="15%">
<fieldset style="background-color: #EBDEF0;">
<table width="80%"  >
<tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
  <tr>
    <td width="1%" ></td>
    </tr>
  <tr>
    <td ></td>
    </tr><tr>
  <tr>
    <td ></td>
    </tr> 
    <tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
<tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr>
<tr>
    <td ></td>
    </tr>
    <tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr><tr>
    <td ></td>
    </tr>
  <tr>
    <td width="1%" align="left">Year</td>
    <td  width="15%"><select id="cmbyear" name="cmbyear" style="width:80%;" onchange="getDay();" value='<s:property value="cmbyear"/>'>
      </select>
      <input type="hidden" id="hidcmbyear" name="hidcmbyear" value='<s:property value="hidcmbyear"/>'/></td>
  </tr>
  <tr>
    <td width="1%" align="left">Month</td>
    <td><select id="cmbmonth" name="cmbmonth" style="width:80%;" onchange="getDay();" value='<s:property value="cmbmonth"/>'>
      <option value="01">January</option><option value="02">February</option><option value="03">March</option>
      <option value="04">April</option><option value="05">May</option><option value="06">June</option><option value="07">July</option>
      <option value="08">August</option><option value="09">September</option><option value="10">October</option><option value="11">November</option>
      <option value="12">December</option></select>
      <input type="hidden" id="hidcmbmonth" name="hidcmbmonth" value='<s:property value="hidcmbmonth"/>'/></td>
  </tr>
  <tr hidden="true">
     <td align="left">Day</td>
    <td><select id="cmbday" name="cmbday" style="width:80%;" value='<s:property value="cmbday"/>'>
      <option value="">--Select--</option></select>
      <input type="hidden" id="hidcmbday" name="hidcmbday" value='<s:property value="hidcmbday"/>'/></td>
  
     </tr>
   <tr hidden="true">
   
    <td  align="left">Comments</td>
    <td width="20%"><textarea id="txtcomments" style="height:80px;width:100%;font: 10px Tahoma;resize:none" name="txtcomments" ><s:property value="txtcomments" ></s:property></textarea></td></tr>
     <tr><td >&nbsp;</td></tr>
  <tr>
    <td>
    </td>
    </tr>
     <tr>
    <td ></td>
    </tr>
    <tr>
    <td>
    </td>
    </tr><tr>
    <td>
    </td>
    </tr>
     <tr>
    <td ></td>
    </tr>
    <tr>
    <td>
    </td>
    </tr>
    <tr>
    <td>
    </td>
    </tr>
     <tr>
    <td ></td>
    </tr>
    <tr>
    <td>
    </td>
    </tr><tr>
    <td>
    </td>
    </tr>
     <tr>
    <td ></td>
    </tr>
    <tr>
    <td>
    </td>
    </tr><tr>
    <td>
    </td>
    </tr>
     <tr>
    <td ></td>
    </tr>
    <tr>
    <td>
    </td>
    </tr>
  <tr hidden="true">
    <td  align="left">Employee</td>
    <td ><input type="text" id="txtemployeeid" name="txtemployeeid" style="width:90%;"  value='<s:property value="txtemployeeid"/>'  />
    <input type="hidden" id="txtemployeedocno" name="txtemployeedocno" value='<s:property value="txtemployeedocno"/>'/></td>
  </tr>
   <tr hidden="true">
    <td ><input type="text" id="txtemployeename" name="txtemployeename" placeholder="Employee Name" style="width:90%;" tabindex="-1" value='<s:property value="txtemployeename"/>'/></td>
  </tr>
 
  <tr>
    <td ></td>
    </tr>
  <tr>
    <td >
	
	</td>
    </tr>
    <tr >
    <td ></td>
    </tr>
 
    <tr>
        <td colspan="2" >&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <input type="button" class="myButtonses" name="btnView" id="btnView"  value="View" style="width:30%" onclick="funViewAttendance();"/>
    &nbsp;  &nbsp;  <input type="button" class="myButtonses" id="btnConfirmed" name="btnConfirmed" value="Remove" style="width:35%"  onclick="funConfirm();"></td>
  
    </td></tr>
    <tr>
    <td colspan="2" > 
  <tr class="tabheight"><td >&nbsp;</td></tr>
</table>
</fieldset>
    </td>
   <td width="70%" >
    	<table width="100%">
    <tr><td><div id="attendanceDiv"><jsp:include page="attendanceGrid.jsp"></jsp:include></div></td></tr>
   
</table>
</td> 
</tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="txtattendancedocno" style="width:75%;" value='<s:property value="txtattendancedocno"/>'/>
<input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
<input type="hidden" id="txtselectedemployee" name="txtselectedemployee" value='<s:property value="txtselectedemployee"/>'/>
<input type="hidden" id="txtselectedcellrow" name="txtselectedcellrow" value='<s:property value="txtselectedcellrow"/>'/>
<input type="hidden" id="txtselectedcellcolumn" name="txtselectedcellcolumn" value='<s:property value="txtselectedcellcolumn"/>'/>
<input type="hidden" id="txtselectedcellvalue" name="txtselectedcellvalue" value='<s:property value="txtselectedcellvalue"/>'/>
<input type="hidden" id="txtselectedcelltextvalue" name="txtselectedcelltextvalue" value='<s:property value="txtselectedcelltextvalue"/>'/>
<input type="hidden" id="txtselectedcellleave1totalvalue" name="txtselectedcellleave1totalvalue" value='<s:property value="txtselectedcellleave1totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave2totalvalue" name="txtselectedcellleave2totalvalue" value='<s:property value="txtselectedcellleave2totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave3totalvalue" name="txtselectedcellleave3totalvalue" value='<s:property value="txtselectedcellleave3totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave4totalvalue" name="txtselectedcellleave4totalvalue" value='<s:property value="txtselectedcellleave4totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave5totalvalue" name="txtselectedcellleave5totalvalue" value='<s:property value="txtselectedcellleave5totalvalue"/>'/>
<input type="hidden" id="txtselectedcellleave6totalvalue" name="txtselectedcellleave6totalvalue" value='<s:property value="txtselectedcellleave6totalvalue"/>'/>
<input type="hidden" id="txtemptotalleaves" name="txtemptotalleaves" value='<s:property value="txtemptotalleaves"/>'/>
<input type="hidden" id="txtemptotalleavesgridlength" name="txtemptotalleavesgridlength" value='<s:property value="txtemptotalleavesgridlength"/>'/>
<input type="hidden" id="txtselectedcellovertimevalue" name="txtselectedcellovertimevalue" value='<s:property value="txtselectedcellovertimevalue"/>'/>
<input type="hidden" id="txtselectedcellholidayovertimevalue" name="txtselectedcellholidayovertimevalue" value='<s:property value="txtselectedcellholidayovertimevalue"/>'/>
<input type="hidden" id="txtholidaysofmonth" name="txtholidaysofmonth" value='<s:property value="txtholidaysofmonth"/>'/>
<input type="hidden" id="txtmonthlypayrollprocessed" name="txtmonthlypayrollprocessed" value='<s:property value="txtmonthlypayrollprocessed"/>'/>
<input type="hidden" id="txtattendanceleaveseditgrid" name="txtattendanceleaveseditgrid" value='<s:property value="txtattendanceleaveseditgrid"/>'/>
<input type="hidden" id="txtmarkedattendance" name="txtmarkedattendance" value='<s:property value="txtmarkedattendance"/>'/>
<input type="hidden" id="txtrecheckemptotalleaves" name="txtrecheckemptotalleaves" value='<s:property value="txtrecheckemptotalleaves"/>'/>
<input type="hidden" id="txtrecheckemptotalleavesgridlength" name="txtrecheckemptotalleavesgridlength" value='<s:property value="txtrecheckemptotalleavesgridlength"/>'/>
<input type="hidden" id="gridlength" name="gridlength" style="width:75%;" value='<s:property value="gridlength"/>'/>
<input type="hidden" id="hidcostcode" name="hidcostcode" style="width:75%;" value='<s:property value="hidcostcode"/>'/>
<input type="hidden" id="hidcosttype" name="hidcosttype" style="width:75%;" value='<s:property value="hidcosttype"/>'/>
<input type="hidden" id="hidempid" name="hidempid" style="width:75%;" value='<s:property value="hidempid"/>'/>
<input type="hidden" id="hiddbname" name="hiddbname" style="width:75%;" value='<s:property value="hiddbname"/>'/>
<input type="hidden" id="hiddate" name="hiddate" style="width:75%;" value='<s:property value="hiddate"/>'/>
<input type="hidden" id="txtselectedcnfm" name="txtselectedcnfm" style="width:75%;" value='<s:property value="txtselectedcnfm"/>'/>
<input type="hidden" id="txtselectedsrno" name="txtselectedsrno" style="width:75%;" value='<s:property value="txtselectedsrno"/>'/>
<input type="hidden" id="txtselecteddb" name="txtselecteddb" style="width:75%;" value='<s:property value="txtselecteddb"/>'/>
<input type="hidden" id="hidsdate" name="hidsdate" style="width:75%;" value='<s:property value="hidsdate"/>'/>
<input type="hidden" id="hidedate" name="hidedate" style="width:75%;" value='<s:property value="hidedate"/>'/>

</div>
</form>

<div id="employeeDetailsWindow">
   <div></div>
</div>
</div>
</body>

</body>
</html>