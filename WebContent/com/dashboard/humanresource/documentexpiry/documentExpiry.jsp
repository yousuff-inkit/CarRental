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

/* Cards */
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
    cursor: pointer;
    font-size: 13px;
    font-weight: 600;
    padding: 10px 15px;
    width: 100%;
}

.myButtons:hover, .myButton:hover {
    background-color: #1d4ed8 !important;
}

/* 🔹 Inputs + Dropdowns */
input[type="text"],
select {
    width: 100%;
    height: 24px !important;
    padding: 0 8px !important;
    border: 1px solid #ccd6e0;
    border-radius: 4px;
    font-size: 13px;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Dropdown text */
select {
    font-size: 13px !important;
}

/* 🔹 Buttons */
.btn-submit,
.myButtons,
.myButton,
input[type="button"],
button {
    width: 100%;
    height: 24px !important;
    padding: 0 10px !important;
    border-radius: 4px;
    font-size: 13px;
    font-weight: 600;
    box-sizing: border-box;
    line-height: 24px;
}

/* 🔹 Fix for any library overriding (like jqx / external CSS) */
.jqx-widget input,
.jqx-widget select {
    height: 24px !important;
    line-height: 24px !important;
}
</style>

<script type="text/javascript">

	$(document).ready(function () {
		
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#expiryDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
	});

	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				
				var srno  = items[0].split(",");
				var process = items[1].split(",");
				var optionsbranch = '<option value="" selected>-- Select -- </option>';
				for (var i = 0; i < process.length; i++) {
					optionsbranch += '<option value="' + srno[i].trim() + '">'
							+ process[i] + '</option>';
				}
				$("select#cmbprocess").html(optionsbranch);
				
			} else {}
		}
		x.open("GET","getProcess.jsp", true);
		x.send();
	}

	function  funClearData(){
		$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#empinfo').val('');$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
		$('#expiryDate').val(new Date());$('#txtempdocno').val('');$('#txtempid').val('');$('#txtbranch').val('');$('#txtdocument').val('');$('#txtdocumentid').val('');disable();
		$("#documentsExpiry").jqxGrid('clear');$("#documentsExpiry").jqxGrid('addrow', null, {});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
	}
	
	function funExportBtn(){
		$("#documentExpiryDiv").excelexportjs({
			containerid: "documentExpiryDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "documentsExpiry", 
			columns: getColumns("documentsExpiry") ,   
			worksheetName:"DocumentsExpiry"
			});
	}  
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();

		 $('#cmbprocess').val('');$('#date').val(new Date());$('#expiryDate').val(new Date());$('#txtbranch').val('');$('#txtempdocno').val('');$('#txtremarks').val('');
		 $('#txtempid').val('');$('#txtdocument').val('');$('#txtdocumentid').val('');$('#btnupdate').attr("disabled",true);$('#cmbprocess').attr("disabled",true);$('#date').jqxDateTimeInput({ disabled: true});
		 $("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
		 $("#overlay, #PleaseWait").show();
		 
		 $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&check=1');
	}

	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess option:selected').text();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var empdocno = $('#txtempdocno').val();
		var expirydate = $('#expiryDate').val();
		var remarks = $('#txtremarks').val();
		var empid = $('#txtempid').val();
		var documentid = $('#txtdocumentid').val();
		var document = $('#txtdocument').val();
		
		if(process==''){
			 $.messager.alert('Message','Choose a Process.','warning');
			 return 0;
		 }

		 if(remarks==''){
			 $.messager.alert('Message','Please Enter Remarks.','warning');   
			 return 0;
		 }
		
		 $.messager.confirm('Message', 'Do you want to save changes?', function(r){
		        
		     	if(r==false)
		     	  {
		     		return false; 
		     	  }
		     	else{
		     		saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid);	
		     	}
		});
	}
	
	function saveGridData(process,date,branchid,empdocno,expirydate,remarks,empid,document,documentid){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				var process = $('#cmbprocess').val('');
				$('#date').val(new Date());
				var branchid = $('#txtbranch').val('');
				var empdocno = $('#txtempdocno').val('');
				$('#expiryDate').val(new Date());
				var remarks = $('#txtremarks').val('');
				var empid = $('#txtempid').val('');
				var document = $('#txtdocument').val('');
				var documentid = $('#txtdocumentid').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				funreload(event); 
				disable();
				$('#empinfo').val('');
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&empdocno="+empdocno+"&expirydate="+expirydate+"&remarks="+remarks+"&empid="+empid+"&document="+document+"&documentid="+documentid,true);
	x.send();
			
	}
	
</script>
</head>
<body onload="getBranch();getProcess();disable();">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar" style="height:100%;">

<table width="100%">
<tr>

<!-- ================= LEFT PANEL ================= -->
<td width="20%" valign="top">

<div class="master-container">
<div class="sidebar-filters">

    <!-- FIXED HEADER -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- SCROLLABLE FILTER CONTENT -->
    <div class="sidebar-scroll-content">

        <div class="filter-card">
        <table class="filter-table">

            <tr>
                <td class="label-cell">Up To</td>
                <td>
                    <div id="uptodate"
                         name="uptodate"
                         value='<s:property value="uptodate"/>'>
                    </div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <textarea id="empinfo"
                              name="empinfo"
                              readonly
                              style="
                                  width:100%;
                                  height:80px;
                                  resize:none;
                                  font:10px Tahoma;">
<s:property value="empinfo"/>
                    </textarea>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Process</td>
                <td>
                    <select id="cmbprocess"
                            name="cmbprocess">
                    </select>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Date</td>
                <td>
                    <div id="date"
                         name="date"
                         value='<s:property value="date"/>'>
                    </div>
                </td>
            </tr>

            <tr>
                <td class="label-cell">Remarks</td>
                <td>
                    <input type="text"
                           id="txtremarks"
                           name="txtremarks"
                           value='<s:property value="txtremarks"/>'>
                </td>
            </tr>

        </table>
        </div>

   <div class="filter-card">
    <div style="display:flex; gap:10px;">

        <button type="button"
                class="myButtons"
                onclick="funClearData();"
                style="flex:1;">
            Clear
        </button>

        <button type="button"
                class="myButton"
                id="update"
                onclick="funUpdate(event);"
                style="flex:1;">
            Update
        </button>

    </div>
</div>

        <!-- HIDDEN FIELDS -->
        <input type="hidden" id="expiryDate" name="expiryDate"
               value='<s:property value="expiryDate"/>'>

        <input type="hidden" id="txtempdocno" name="txtempdocno"
               value='<s:property value="txtempdocno"/>'>

        <input type="hidden" id="txtempid" name="txtempid"
               value='<s:property value="txtempid"/>'>

        <input type="hidden" id="txtbranch" name="txtbranch"
               value='<s:property value="txtbranch"/>'>

        <input type="hidden" id="txtdocument" name="txtdocument"
               value='<s:property value="txtdocument"/>'>

        <input type="hidden" id="txtdocumentid" name="txtdocumentid"
               value='<s:property value="txtdocumentid"/>'>

    </div>
</div>
</div>

</td>

<!-- ================= RIGHT PANEL ================= -->
<td width="80%" valign="top">

<table width="100%">
<tr>
    <td>
        <div id="documentExpiryDiv">
            <jsp:include page="documentExpiryGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>

<tr>
    <td>
        <div id="detailDiv">
            <jsp:include page="detailGrid.jsp"></jsp:include>
        </div>
    </td>
</tr>
</table>

</td>

</tr>
</table>

</div>
</div>

</body>

