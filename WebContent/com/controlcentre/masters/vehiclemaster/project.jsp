<%@page import="com.controlcentre.masters.vehiclemaster.project.ClsProjectDAO" %>
<%ClsProjectDAO cpd=new ClsProjectDAO(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */

input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 700;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ------------------------------
   FORM ROWS LAYOUT (FIXED)
------------------------------ */

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}
.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* Special handling for the "to-account-row" - all items in one line */
.to-account-row {
    display: grid;
    grid-template-columns: 120px 110px 120px 140px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.to-account-row label {
    text-align: right;
    padding-right: 8px;
}

.to-account-row #cmbtotype {
    width: 100%;
}

.to-account-row #txttoaccid {
    width: 100%;
}

.to-account-row #txttoaccname {
    width: 100%;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
    height: 100vh;
}

/* Hide scrollbars (but allow scrolling) */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
</style>
<script type="text/javascript">

$(document).ready(function () {
	 $("#projectDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	
	 $('#clientDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Client Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $("#btnExcel").click(function() {
			$("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
		});
	 
	    document.getElementById("formdet").innerText="Project(PRJ)";
		document.getElementById("formdetail").value="Project";
		document.getElementById("formdetailcode").value="PRJ";
	 	window.parent.formCode.value="PRJ";
			window.parent.formName.value="Project";
	 var data= '<%=cpd.projectDetailsLoading() %>';
	           
	 var source =
	            {
	                datatype: "json",
	                datafields: [
	                          	{name : 'doc_no' , type: 'number' },
	                          	{name : 'date', type: 'date'  },
	                          	{name : 'refname', type: 'String'  },
	                          	{name : 'project_name', type: 'String'  }
	                 ],
	               localdata: data,
	                
	                pager: function (pagenum, pagesize, oldpagenum) {
	                    // callback called when a page or page size is changed.
	                }
	            };
	            var dataAdapter = new $.jqx.dataAdapter(source,
	            		 {
	                		loadError: function (xhr, status, error) {
		                    }
			            }		
	            );
	    
	            $("#jqxProjectSearch1").jqxGrid(
	                    {
	                    	width: 1450,
	                        source: dataAdapter,
	                        showfilterrow: true,
	                        filterable: true,
	                        selectionmode: 'multiplecellsextended',
	                        //Add row method
	                        columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Client Name',columntype: 'textbox', filtertype: 'input', datafield: 'refname', width: '30%' },
	        					{ text: 'Project Name',columntype: 'textbox', filtertype: 'input', datafield: 'project_name', width: '40%' }
	        	              ]
	                    });
	            $('#jqxProjectSearch1').on('rowdoubleclick', function (event) {
	                var rowindex1=event.args.rowindex;
	                document.getElementById("docno").value= $('#jqxProjectSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
	                document.getElementById("txtprojectname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "project_name");
	                $("#projectDate").jqxDateTimeInput('val', $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
	                document.getElementById("txtclientname").value = $("#jqxProjectSearch1").jqxGrid('getcellvalue', rowindex1, "refname");
	            }); 
	            
	            
	            
	            $('#txtclientname').dblclick(function(){
	            	clientSearchContent('clientDetailsGrid.jsp');
	       		});
          });

function clientSearchContent(url) {
    $('#clientDetailsWindow').jqxWindow('open');
	$.get(url).done(function (data) {
	$('#clientDetailsWindow').jqxWindow('setContent', data);
	$('#clientDetailsWindow').jqxWindow('bringToFront');
}); 
}

function funReadOnly(){
	$('#frmProject input').attr('readonly', true );
	$('#projectDate').jqxDateTimeInput({disabled: true});
}

function funRemoveReadOnly(){
	$('#frmProject input').attr('readonly', false );
	$('#projectDate').jqxDateTimeInput({disabled: false});
	$('#txtclientname').prop('readonly', true);
	$('#docno').prop('readonly', true);
}

function setValues(){	
   
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }

}

function funFocus(){
	$('#projectDate').jqxDateTimeInput('focus'); 
}
   
    /* Validations */
	   $(function(){
	        $('#frmProject').validate({
	                rules: {
	                txtclientname:"required",
	                txtprojectname:"required"
	                 },
	                 messages: {
	                 txtclientname:" *",
	                 txtprojectname:" *"
	                 }
	        });});
     
function funNotify(){
   return 1;
} 

function funSearchLoad(){
    changeContent('projectSearch.jsp');
}
     
function getClient(event){
  var x= event.keyCode;
  if(x==114){
	  clientSearchContent('clientDetailsGrid.jsp');
  }
  else{
   }
}
function funExcelBtn(){
	  $("#jqxProjectSearch1").jqxGrid('exportdata', 'xls', 'Project');
}
</script>
</head>
<body onload="setValues();" >
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmProject" action="saveActionProject" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>  
<fieldset><legend>Project Details</legend>
<div class="section-block">
<div class="form-group dual-input">
  <label>Date</label>
  <div id="projectDate" name="projectDate" value='<s:property value="projectDate"/>'></div>
    <input type="hidden" id="hidprojectDate" name="hidprojectDate" value='<s:property value="hidprojectDate"/>'/>
  <label>Doc No</label>
  <input type="text" id="docno" name="txtprojectdocno" style="width:25%;" value='<s:property value="txtprojectdocno"/>' tabindex="-1"/></td>
 </div>
<div class="form-group dual-input">
  <label>Client</label>
  <input type="text" name="txtclientname" id="txtclientname" style="width:80%;" placeholder="Press F3 to Search" value='<s:property value="txtclientname"/>' onkeydown="getClient(event);">
  <input type="hidden" id="txtcldocno" name="txtcldocno" value='<s:property value="txtcldocno"/>'/>
  <label>Project Name</label>
  <input type="text" name="txtprojectname"  id="txtprojectname"  style="width:70%;" value='<s:property value="txtprojectname"/>'>
</div>
</div>
<br/>
</fieldset><br/>
<div id="jqxProjectSearch1"></div> 
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
<div id="clientDetailsWindow">
	<div></div><div></div>
</div>
</div>
</body>
</html>