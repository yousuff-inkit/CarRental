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
    font-weight: 600;
    cursor: pointer;
    width: 100%;
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
<script type="text/javascript">

	$(document).ready(function () {
		 $("#uptodate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 $("#chequeDate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
		 
		 $('#txtremarks').attr('readonly', true);$('#btnupdate').attr("disabled",true);
		 
	});
	
	function funreload(event){
		 $('#txtremarks').val('');$('#txtdocno').val('');$('#txtbrhid').val('');
		 $('#btnupdate').attr("disabled",true);
			var cmbtype= document.getElementById("cmbtype").value;	

		 var branchval = document.getElementById("cmbbranch").value;
		 var uptodate = "";
		 if(document.getElementById("chktest").checked){  
		  uptodate = $('#uptodate').val();
	     }
		 $("#overlay, #PleaseWait").show();
		 
		 $("#securityChequeListDiv").load("securityChequeListGrid.jsp?branchval="+branchval+'&uptodate='+uptodate+'&cmbtype='+cmbtype+'&check=1');
		}
	
	function funUpdate(event){
		var docno = $('#txtdocno').val();
		var date = $('#date').val();
		var chequeno = $('#txtchequeno').val();
		var chequedate = $('#chequeDate').val();
		var branchid = $('#txtbrhid').val();
		var remarks = $('#txtremarks').val();
		var cmbtype= $('#cmbtype').val();	
		if(docno==''){
			 $.messager.alert('Message','Please Choose a Cheque.','warning');
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
		     		 saveGridData(docno,date,chequeno,chequedate,branchid,remarks);	
		     	}
		 });
	}
	
	function saveGridData(docno,date,chequeno,chequedate,branchid,remarks) {
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText;

				var docno = $('#txtdocno').val('');
				var date = $('#date').val(new Date());
				var chequeno = $('#txtchequeno').val('');
				var chequedate = $('#chequeDate').val(new Date()); 
				var branchid = $('#txtbrhid').val('');
				var remarks = $('#txtremarks').val('');
				var info = $('#txtinfo').val(' ');
				
				
				$.messager.alert('Message', '  Record Successfully Updated ', function(r){
			  });
		      funreload(event); 
		  }
		}
			
	x.open("GET","saveData.jsp?docno="+docno+"&date="+date+"&chequeno="+chequeno+"&chequedate="+chequedate+"&branchid="+branchid+"&remarks="+remarks,true);
	x.send();
	}

	function funExportBtn(){
		// JSONToCSVCon(data, 'Security Cheque List', true);
		$("#securityChequeListDiv").excelexportjs({  
       		containerid: "securityChequeListDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "securityChequeList", 
       		columns: getColumns("securityChequeList") , 
       		worksheetName:"Security Cheque List"
       		});
	 }
	function disable(){
		 $('#uptodate').jqxDateTimeInput("disabled",true);
	}
	
	 function intro1check(){
		 if(document.getElementById("chktest").checked){  
			 $('#uptodate').jqxDateTimeInput({ disabled: false});  
		 }
		 else{
			 $('#uptodate').jqxDateTimeInput({ disabled: true});
		 }
	 }
	
</script>
</head>
<body onload="getBranch();disable();">
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
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="cmbtype" name="cmbtype" value='<s:property value="cmbtype"/>'>
                                <option value="all">All</option>
                                <option value="open">Open</option>
                                <option value="closed">Closed</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Up To</td>
                        <td>
                            <div id="uptodate" name="uptodate" value='<s:property value="uptodate"/>'></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="padding-top: 5px;">
                            <div style="display: flex; align-items: center; gap: 8px;">
                                <input type="checkbox" id="chktest" name="chktest" onchange="intro1check();" onclick="$(this).attr('value', this.checked ? 1 : 0)"/>
                                <label class="branch" style="font-size: 12px;">Toggle Check</label>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="filter-card">
                <textarea id="txtinfo" name="txtinfo" readonly="readonly" style="height:80px; margin-bottom: 10px;"><s:property value="txtinfo" ></s:property></textarea>
                
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td>
                            <input type="text" id="txtremarks" name="txtremarks" value='<s:property value="txtremarks"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px 5px;">
                <button class="myButton" type="button" id="btnupdate" name="btnupdate" onclick="funUpdate(event);">Close</button>
            </div>

            <input type="hidden" id="txtchequeno" name="txtchequeno" value='<s:property value="txtchequeno"/>'/>
            <div hidden="true" id='chequeDate' name='chequeDate' value='<s:property value="chequeDate"/>'></div>
            <div hidden="true" id='date' name='date' value='<s:property value="date"/>'></div>
            <input type="hidden" name="txtbrhid" id="txtbrhid" value='<s:property value="txtbrhid"/>'>
            <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
            <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="securityChequeListDiv">
                <jsp:include page="securityChequeListGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>

</div> 
</body>
</html>