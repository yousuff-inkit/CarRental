<%@page import="com.controlcentre.masters.vehiclemaster.securitypass.ClsSecurityPassDAO" %>
<%ClsSecurityPassDAO DAO1=new ClsSecurityPassDAO(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    max-width: 1450px;
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
    font-weight: 600;
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
    height: 530px;
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
.pdc-cheque-row {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
    margin-left: 6%;
    flex-wrap: nowrap;
}

/* Checkbox with PDC text - keep them together */
.pdc-cheque-row input[type="checkbox"] {
    width: auto;
    margin: 0 4px 0 0;
    flex-shrink: 0;
}

/* Hidden inputs should not take space */
.pdc-cheque-row input[type="hidden"] {
    display: none;
}

/* Labels styling */
.pdc-cheque-row label {
    text-align: right;
    padding-right: 8px;
    white-space: nowrap;
    margin: 0;
    flex-shrink: 0;
    font-weight: 600;
}

/* Cheque No input */
.pdc-cheque-row #txtchequeno {
    width: 200px;
    flex-shrink: 0;
}

/* Cheque Date */
.pdc-cheque-row #jqxChequeDate {
    width: 200px;
    flex-shrink: 0;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	     $("#startdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	      $("#enddate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
	    document.getElementById("formdet").innerText="Security Pass(SPA)";
		document.getElementById("formdetail").value="Security Pass";
		document.getElementById("formdetailcode").value="SPA";
		window.parent.formCode.value="SPA";
		window.parent.formName.value="Security Pass";
 		
		
		/* Grid starts */
			var spdata='<%=DAO1.searchDetails()%>'; 
            var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'startdate', type: 'date'  },
                          	{name : 'enddate', type: 'date'  },
							{name : 'description',type:'string'},
							{name : 'qty',type:'string'},
                 ],
               localdata: spdata,
                //url: "/searchDetails",
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
            );
    
            $("#jqxSecpassSearch1").jqxGrid(
                    {
                    	width: '100%',
                    	height:350,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        //Add row method
                        columns: [
        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
							{ text: 'Description',datafield:'description',width:'50%',columntype: 'textbox', filtertype: 'input'},
							{ text: 'StartDate',columntype: 'textbox', filtertype: 'input', datafield: 'startdate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'EndDate',columntype: 'textbox', filtertype: 'input', datafield: 'enddate', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Qty',columntype: 'textbox', filtertype: 'input', datafield: 'qty', width: '10%' },
        	              ]
                    });
            $('#jqxSecpassSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("name").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "name");
				document.getElementById("description").value = $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "description");
                $("#date").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
				 var sdate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate");
				 var edate=$("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate");
                if(sdate==null ||sdate==""){
                 $("#startdate").val(new Date());
                }else{
                $("#startdate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "startdate"));
                
                }
                  if(edate==null ||edate==""){
                 $("#enddate").val(new Date());
                }else{
                 $("#enddate").jqxDateTimeInput('val', $("#jqxSecpassSearch1").jqxGrid('getcellvalue', rowindex1, "enddate"));
                
                }
                 
                  document.getElementById("qty").value= $('#jqxSecpassSearch1').jqxGrid('getcellvalue', rowindex1, "qty");
                $('#window').jqxWindow('close');
                // 
            });  
            
            /* Grid Ends */
        });
	
	
	
	function funSearchLoad(){
		changeContent('securityPassSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmSecpass input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			readonly : true
		});
		
		/* 	$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmSecpass input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
		 if(document.getElementById("mode").value=='A'){
		  $("#startdate").jqxDateTimeInput('setDate', new Date());
	    	 $("#enddate").jqxDateTimeInput('setDate', new Date());
	    	  $("#date").jqxDateTimeInput('setDate', new Date());
		 
		 
		 }
	}
	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmSecpass').validate({
	                 rules: {
	                 name: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  name: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("name").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxSecpassSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" class="hidden-scrollbar" >
<form id="frmSecpass" action="saveSecurityPass" method="get" autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<fieldset><legend>Security Pass Details</legend>
	<div class="section-block">
	  <div class="form-group pdc-cheque-row">
	    <label>Date</label>
	    <div id="date" name="date" value='<s:property value="date"/>'></div>
	    <label>StartDate</label>
	    <div id="startdate" name="startdate" value='<s:property value="startdate"/>'></div>
	    <label>EndDate</label>
	    <td width="22%"><div id="enddate" name="enddate" value='<s:property value="enddate"/>'></div></td>
	    </div>
	    <div class="form-group dual-input">
	    <label>Doc No.</label>
	    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly  tabindex="-1">
	    <label>Name</label>
	    <input type="text" name="name" id="name"  value='<s:property value="name"/>' >
	    </div>
	    <div class="form-group dual-input">
	    <label>Description</label>
	    <input type="text" name="description" id="description"  value='<s:property value="description"/>' >
	    <label>Qty</label>
	    <input type="text" name="qty" id="qty"  value='<s:property value="qty"/>' >
	  </div>
	  <tr>
		<td><input type="hidden" id="mode" name="mode"/></td>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
		<td><input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/></td>
	  </tr>
	</div>
	</fieldset>
    	
	</form>
<table width="100%">
      <tr>
        <td align="center"><div id="jqxSecpassSearch1"></div>  </td>
      </tr>
    </table>
<br/>
		
	

</body>
</html>