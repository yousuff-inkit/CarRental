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
.myButtons, .myButton {
    background-color: #2563eb !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 6px;
    padding: 10px 15px;
    width: 100%;
    font-weight: 600;
    cursor: pointer;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}

</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 /* Searching Window */
     	 $('#employeeDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Employee Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
  		 $('#employeeDetailsWindow').jqxWindow('close');
  		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	     $('#txtemployeeid').dblclick(function(){
	  		employeeSearchContent("employeeDetailsSearch.jsp");
		 });
	     
	});
	
	function employeeSearchContent(url) {
	 	$('#employeeDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#employeeDetailsWindow').jqxWindow('setContent', data);
		$('#employeeDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getDepartment() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var departmentItems = items[0].split(",");
				var departmentIdItems = items[1].split(",");
				var optionsdepartments = '<option value="">--Select--</option>';
				for (var i = 0; i < departmentItems.length; i++) {
					optionsdepartments += '<option value="' + departmentIdItems[i] + '">'
							+ departmentItems[i] + '</option>';
				}
				$("select#cmbdepartment").html(optionsdepartments);
				
			} else {
			}
		}
		x.open("GET", "getDepartment.jsp", true);
		x.send();
	}
	
	function getDesignation() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var designationItems = items[0].split(",");
				var designationIdItems = items[1].split(",");
				var optionsdesignation = '<option value="">--Select--</option>';
				for (var i = 0; i < designationItems.length; i++) {
					optionsdesignation += '<option value="' + designationIdItems[i] + '">'
							+ designationItems[i] + '</option>';
				}
				$("select#cmbdesignation").html(optionsdesignation);
				
			} else {
			}
		}
		x.open("GET", "getDesignation.jsp", true);
		x.send();
	}
	
	function getCategory() {
  		var x = new XMLHttpRequest();
  		x.onreadystatechange = function() {
  			if (x.readyState == 4 && x.status == 200) {
  				var items = x.responseText;
  				items = items.split('####');
  				var payrollcategoryItems = items[0].split(",");
  				var payrollcategoryIdItems = items[1].split(",");
  				var optionspayrollcategory = '<option value="">--Select--</option>';
  				for (var i = 0; i < payrollcategoryItems.length; i++) {
  					optionspayrollcategory += '<option value="' + payrollcategoryIdItems[i] + '">'
  							+ payrollcategoryItems[i] + '</option>';
  				}
  				$("select#cmbcategory").html(optionspayrollcategory);
  				
  			} else {
  			}
  		}
  		x.open("GET", "getCategory.jsp", true);
  		x.send();
  	}
	
	function getEmployeeId(event){
        var x= event.keyCode;
        if(x==114){
        	employeeSearchContent("employeeDetailsSearch.jsp");
        }
        else{}
    }
	
	function saveGridData(selecteddocs,selectedempid,uptodate,branchid){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;
				if(parseInt(items)>0){
					
					$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#txtselecteddocs').val('');$('#txtselectedempid').val('');
	  	 			$('#cmbdepartment').val('');$('#cmbdesignation').val('');$('#cmbcategory').val('');$('#txtemployeeid').val('');
	  	 			$('#txtemployeename').val('');$('#txtemployeedocno').val('');
	  	 			
	  	 			if (document.getElementById("txtemployeeid").value == "") {
	  	 		        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	  	 		        $('#txtemployeename').attr('placeholder', 'Employee Name');
	  	 		    }
	  	 			
					$.messager.alert('Message', '  Leave Confirmed ', function(r){
				    });
					funreload(event);
					 
			      
				} else {
					$.messager.alert('Message', '  Leave Not Confirmed ', function(r){
				    });
					$("#overlay, #PleaseWait").hide();
				} 
		  }
		}
			
	x.open("GET","saveData.jsp?selecteddocs="+selecteddocs+"&selectedempid="+selectedempid+"&uptodate="+uptodate+"&uptodate="+uptodate+"&branchid="+branchid,true);
	x.send();
	}

	function funConfirm() {
		
	    var temp1="",tempempid1="";
		var rows = $("#leaveAcceptanceDetailsGridID").jqxGrid('getrows');
		if(rows.length==1 && (rows[0].docno=="undefined" || rows[0].docno==null || rows[0].docno=="")){
			return false;
		}
		
		var selectedrows=$("#leaveAcceptanceDetailsGridID").jqxGrid('selectedrowindexes');
		selectedrows = selectedrows.sort(function(a,b){return a - b});
		if(selectedrows.length==0){
			$("#overlay, #PleaseWait").hide();
			$.messager.alert('Warning','Select Leaves to be Confirmed.');
			return false;
		}
		
		var i=0;var j=0;var k=0;var temp="",tempempid="";
	    for (i = 0; i < rows.length; i++) {
				if(selectedrows[j]==i){
					if(k==0){
						temp=rows[i].docno;
						tempempid=rows[i].empdocno;
						k=1;
					}
					else{
						temp=temp+"::"+rows[i].docno;
						tempempid=tempempid+","+rows[i].empdocno;
					}
					temp1=temp+"::";
					tempempid1=tempempid+",";
					
				j++; 
			  }
            }
	    $('#txtselecteddocs').val(temp1);
	    $('#txtselectedempid').val(tempempid1);
	
	    $.messager.confirm('Confirm', 'Do you want to Confirm ?', function(r){
  	 		if (r){
  	 			  var selecteddocs = $('#txtselecteddocs').val();
  	 			  var selectedempid = $('#txtselectedempid').val();
  	 			  var uptodate = $('#uptodate').val();
  	 			  var branchid = $('#cmbbranch').val();
  	 			  
  	 			  $("#overlay, #PleaseWait").show();
  	 			
  	 			  saveGridData(selecteddocs,selectedempid,uptodate,branchid);
  	 	  }
  	  });  
		
	}
	
	function  funClearInfo(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());
		$('#cmbdepartment').val('');$('#cmbdesignation').val('');$('#cmbcategory').val('');
		$('#txtemployeeid').val('');$('#txtemployeename').val('');$('#txtemployeedocno').val('');
		$("#leaveAcceptanceDetailsGridID").jqxGrid('clear');$("#leaveAcceptanceDetailsGridID").jqxGrid('addrow', null, {});
		
		if (document.getElementById("txtemployeeid").value == "") {
	        $('#txtemployeeid').attr('placeholder', 'Press F3 to Search'); 
	        $('#txtemployeename').attr('placeholder', 'Employee Name');
	    }
		
	 }
	
	function funreload(event){
		 var branchval = $('#cmbbranch').val(); 
		 var uptodate = $('#uptodate').val();
		 var department = $('#cmbdepartment').val();
		 var designation = $('#cmbdesignation').val();
		 var category = $('#cmbcategory').val();
		 var employee = $('#txtemployeedocno').val();
		 var employeebranchchk=window.parent.employeebranchchk.value; 
		 $("#overlay, #PleaseWait").show();
		 $('#txtselecteddocs').val('');$('#txtselectedempid').val('');
		 $("#leaveAcceptanceDiv").load("leaveAcceptanceGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&department='+department+'&designation='+designation+'&category='+category+'&employee='+employee+'&check=1'+'&employeebranchchk='+employeebranchchk);
	}
	
	function funExportBtn(){
		  $("#leaveAcceptanceDiv").excelexportjs({
		  			containerid: "leaveAcceptanceDiv", 
		  			datatype: 'json', 
		  			dataset: null, 
		  			gridId: "leaveAcceptanceDetailsGridID", 
		  			columns: getColumns("leaveAcceptanceDetailsGridID") ,    
		  			worksheetName:"LeaveAcceptanceDetails"
		  			});
	 } 
		
</script>
</head>
<body onload="getBranch();getDepartment();getDesignation();getCategory();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Up To</td>
                <td><div id="uptodate"></div></td>
            </tr>

            <tr>
                <td class="label-cell">Department</td>
                <td>
                    <select id="cmbdepartment" name="cmbdepartment"></select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Designation</td>
                <td>
                    <select id="cmbdesignation" name="cmbdesignation"></select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Category</td>
                <td>
                    <select id="cmbcategory" name="cmbcategory"></select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Employee</td>
                <td>
                    <input type="text"
                           id="txtemployeeid"
                           name="txtemployeeid"
                           placeholder="Press F3 to Search"
                           readonly
                           onkeydown="getEmployeeId(event);"
                           value='<s:property value="txtemployeeid"/>'>

                    <input type="hidden"
                           id="txtemployeedocno"
                           name="txtemployeedocno"
                           value='<s:property value="txtemployeedocno"/>'>
                </td>
            </tr>

            <tr>
                <td></td>
                <td>
                    <input type="text"
                           id="txtemployeename"
                           name="txtemployeename"
                           readonly
                           placeholder="Employee Name"
                           tabindex="-1"
                           value='<s:property value="txtemployeename"/>'>
                </td>
            </tr>

        </table>
        </div>

       <div class="filter-card">
    <div style="display:flex; gap:8px;">

        <button type="button"
                class="myButtons"
                onclick="funClearInfo();"
                style="flex:1;">
            Clear
        </button>

        <button type="button"
                class="myButton"
                onclick="funConfirm();"
                style="flex:1;">
            Confirm
        </button>

    </div>
</div>
        
        <input type="hidden" id="txtselecteddocs" name="txtselecteddocs"
               value='<s:property value="txtselecteddocs"/>'>

        <input type="hidden" id="txtselectedempid" name="txtselectedempid"
               value='<s:property value="txtselectedempid"/>'>

    </div>
</div>
</div>

</td>

<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="leaveAcceptanceDiv">
            <jsp:include page="leaveAcceptanceGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>

<div id="employeeDetailsWindow">
    <div></div>
</div>

</div>
</body>
