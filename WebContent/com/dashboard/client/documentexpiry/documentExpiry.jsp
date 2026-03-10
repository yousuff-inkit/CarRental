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
		 document.getElementById('activeradio').checked=true;    
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#expiryDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
		 $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search'  , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
		 $('#clientwindow').jqxWindow('close');
		 
		 $('#clientname').dblclick(function(){  
		   $('#clientwindow').jqxWindow('open');
		   clientSearchContent('clientsearch.jsp', $('#clientwindow')); 
		 });
	});
	function getclinfo(event){
		 var x= event.keyCode;
		if(x==114){
	 		$('#clientwindow').jqxWindow('open');
			clientSearchContent('clientsearch.jsp', $('#clientwindow'));    }
		else{}
	} 

	function clientSearchContent(url) {
		 	$.get(url).done(function (data) {
			$('#clientwindow').jqxWindow('open');
			$('#clientwindow').jqxWindow('setContent', data);
	}); 
	} 
		
	function getProcess() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
			//alert(items);
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
		$('#clientname').val(''); $('#cldocno').val('');$('#cmbbranch').val('a');$('#uptodate').val(new Date());$('#clientinfo').val('');$('#cmbprocess').val('');$('#date').val(new Date());$('#txtremarks').val('');
		$('#expiryDate').val(new Date());$('#txtcldocno').val('');$('#txtdriver').val('');$('#txtbranch').val('');$('#txtdocument').val('');disable();
		$("#documentExpiry").jqxGrid('clear');$("#documentExpiry").jqxGrid('addrow', null, {});$("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
	 }
	
	function funreload(event){
		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = $('#uptodate').val();
		 var cldocno = $('#cldocno').val();   
		 var active=1;  
		 if(document.getElementById('inactiveradio').checked){
			 active=0;
		 }else if(document.getElementById('activeradio').checked){
			 active=1;  
		 }else{}
		 $('#cmbprocess').val('');$('#date').val(new Date());$('#expiryDate').val(new Date());$('#txtbranch').val('');$('#txtcldocno').val('');$('#txtremarks').val('');
		 $('#txtdriver').val('');$('#txtdocument').val('');$('#btnupdate').attr("disabled",true);$('#cmbprocess').attr("disabled",true);$('#date').jqxDateTimeInput({ disabled: true});
		 $("#documentDetailsGrid").jqxGrid('clear');$("#documentDetailsGrid").jqxGrid('addrow', null, {});
		 $("#overlay, #PleaseWait").show();
		 
		 $("#documentExpiryDiv").load("documentExpiryGrid.jsp?branchval="+branchval+'&active='+active+'&cldocno='+cldocno+'&uptodate='+uptodate+'&check=1');
	}

	function disable(){
		 $('#date').jqxDateTimeInput({ disabled: true});
		 $('#cmbprocess').attr("disabled",true);
		 $('#txtremarks').attr("readonly",true);
		 $('#btnupdate').attr("disabled",true);
	}
	
	function funUpdate(event){
		var process = $('#cmbprocess').val();
		var date =  $('#date').val();
		var branchid = $('#txtbranch').val();
		var cldocno = $('#txtcldocno').val();
		var expirydate = $('#expiryDate').val();
		var remarks = $('#txtremarks').val();
		var driversrno = $('#txtdriver').val();
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
		     		saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document);	
		     	}
		});
	}
	
	function saveGridData(process,date,branchid,cldocno,expirydate,remarks,driversrno,document){
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200){
	     			
				var items=x.responseText;
				
				var process = $('#cmbprocess').val('');
				$('#date').val(new Date());
				var branchid = $('#txtbranch').val('');
				var cldocno = $('#txtcldocno').val('');
				$('#expiryDate').val(new Date());
				var remarks = $('#txtremarks').val('');
				var driversrno = $('#txtdriver').val('');
				var document = $('#txtdocument').val('');
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			    });
				funreload(event); 
				disable();
				$('#clientinfo').val('');
				}
		}
			
	x.open("GET","saveData.jsp?process="+process+"&date="+date+"&branchid="+branchid+"&cldocno="+cldocno+"&expirydate="+expirydate+"&remarks="+remarks+"&driversrno="+driversrno+"&document="+document,true);
	x.send();
			
	}
	
	/* function funExportBtn(){
		 if(parseInt(window.parent.chkexportdata.value)=="1") {
		  	JSONToCSVCon(data, 'DocumentExpiry', true);
		 } else {
			 $("#documentExpiry").jqxGrid('exportdata', 'xls', 'DocumentExpiry');
		 }
	} */
	function funExportBtn(){
		// JSONToCSVCon(DocumentExpiryexcel, 'Document Expiry', true);
	     $("#documentExpiryDiv").excelexportjs({
				containerid: "documentExpiryDiv",   
				datatype: 'json',
				dataset: null,
				gridId: "documentExpiry",
				columns: getColumns("documentExpiry") ,   
				worksheetName:"Document Expiry"  
			});   
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
.main-content-wrapper{
    flex:1;
    width:100%;
}

.scrollable-grid-area{
    width:100%;
}

#delupdiv{
    width:100%;
}
</style>
<body onload="getBranch();getProcess();disable();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td><div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td><input type="text" name="clientname" id="clientname" placeholder="Press F3 To Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' " value='<s:property value="clientname"/>'></td>
                    </tr>
                </table>
                <div style="display: flex; justify-content: center; gap: 15px; margin-top: 10px;">
                    <label class="branch"><input type="radio" id="inactiveradio" name="activity"> Inactive</label>
                    <label class="branch"><input type="radio" id="activeradio" name="activity"> Active</label>
                </div>
            </div>

            <div class="filter-card">
                <textarea id="clientinfo" name="clientinfo" readonly="readonly" style="height:80px; font-size: 11px; resize:none;"><s:property value="clientinfo" ></s:property></textarea>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Process</td>
                        <td><select name="cmbprocess" id="cmbprocess" value='<s:property value="cmbprocess"/>'></select></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td><div id="date" name="date" value='<s:property value="date"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td><input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/></td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px 5px;">
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funClearData();">
                <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Update</button>
            </div>

            <div hidden="true">
                <div id='expiryDate' name='expiryDate' value='<s:property value="expiryDate"/>'></div>
                <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
                <input type="hidden" id="txtdriver" name="txtdriver" value='<s:property value="txtdriver"/>'/>
                <input type="hidden" id="txtbranch" name="txtbranch" value='<s:property value="txtbranch"/>'/>
                <input type="hidden" id="cldocno" name="cldocno" value='<s:property value="cldocno"/>'/>      
                <input type="hidden" id="txtdocument" name="txtdocument" value='<s:property value="txtdocument"/>'/>
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="documentExpiryDiv">
                <jsp:include page="documentExpiryGrid.jsp"></jsp:include>
            </div>
            <div id="detailDiv">
                <jsp:include page="detailGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="clientwindow">  
   <div></div>
</div>
</div>
</body>
