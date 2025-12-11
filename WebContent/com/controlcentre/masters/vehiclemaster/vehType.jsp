<%@page import="com.controlcentre.masters.vehiclemaster.vehtype.*" %>
<%ClsVehTypeDAO dao=new ClsVehTypeDAO();%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
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
</style>
		<script type="text/javascript">
			var data='<%=dao.getVehTypeData("1")%>';

      		$(document).ready(function (){   
    	  		$("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	  
    	  		document.getElementById("formdet").innerText="Vehicle Type(VTP)";
  		  		document.getElementById("formdetail").value="Vehicle Type";
  		  		document.getElementById("formdetailcode").value="VTP";
		  		window.parent.formName.value="Vehicle Type";
  				window.parent.formCode.value="VTP";    	  
          		var source =
          		{
              		datatype: "json",
              		datafields: [
                    	{name : 'doc_no' , type: 'number' },
                        {name : 'date', type: 'date'  },
                        {name : 'name',type:'String'}
               		],
               		localdata: data,
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
          		$("#vehTypeGrid").jqxGrid(
                {
                	width: '200%',
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    altrows:true,
                    columns: [
      					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
      					{ text: 'Vehicle Type',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '70%' },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
      	            ]
                });
     
          		$('#vehTypeGrid').on('rowdoubleclick', function (event) 
          		{ 
		        	var rowindex1=event.args.rowindex;
		            document.getElementById("docno").value= $('#vehTypeGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		            document.getElementById("name").value = $("#vehTypeGrid").jqxGrid('getcellvalue', rowindex1, "name");
		            $('#date').jqxDateTimeInput({ disabled: false});
		            $("#date").jqxDateTimeInput('val', $("#vehTypeGrid").jqxGrid('getcellvalue', rowindex1, "date")); 
		            $('#date').jqxDateTimeInput({ disabled: true});
          		}); 
      		});
     
      		function funSearchLoad(){
				changeContent('vehTypeSearchGrid.jsp?id=1', $('#window')); 
		 	}

			function funReadOnly(){
				$('#frmVehType input').attr('readonly', true );
				$('#date').jqxDateTimeInput({ disabled: true}); 	
				$("#vehTypeGridDiv").jqxGrid({ disabled: true}); 	
			}
			function funRemoveReadOnly(){
				$('#frmVehType input').attr('readonly', false );
				$("#vehTypeGridDiv").jqxGrid({ disabled: false}); 
				$('#date').jqxDateTimeInput({ disabled: false});
				$('#docno').attr('readonly', true);
				if($("#mode").val() == "A"){
					$('#vehTypeGridDiv').jqxGrid('clear');
				}
				if ($("#mode").val() == "A" || $("#mode").val() == "E") {
					$("#vehTypeGridDiv").jqxGrid('addrow', null, {});
				}
				
			}
			function setValues() {
				if($('#msg').val()!=""){
					$.messager.alert('Message',$('#msg').val());
				}
				 var maindoc=document.getElementById("docno").value;
				  if(maindoc>0)
					  {
					  $("#vehTypeGridMain").load("vehtypegrid.jsp?rdocno="+maindoc+"&chk=1");
					  }
			}
			
			function funFocus(){
				document.getElementById("name").focus();
			}
			function funNotify(){
				var rows = $("#vehTypeGridDiv").jqxGrid('getrows');
				var lengthupdate=0;
				 for(var i=0 ; i < rows.length ; i++){
					 var chka=rows[i].name;
					 var chkt=rows[i].tyre;
		  				if((typeof(chkt) != "undefined" && typeof(chkt) != "NaN" && chkt != "") && (typeof(chka) != "undefined" && chka != "")){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+lengthupdate)
					    .attr("name", "test"+lengthupdate)
					    .attr("hidden", "true");
						
					newTextBox.val(rows[i].name+" :: "+rows[i].tyre+" :: "+rows[i].rowno+" :: ");
					newTextBox.appendTo('form');
					lengthupdate=lengthupdate+1;
					}
	  			  }
				 if(lengthupdate<=0) {
					 $.messager.alert('Message','Please enter tyre and axle details','warning');
					 return 0;
				 }
				$('#gridlength').val(lengthupdate);
				$('#deletedrows').val(deleted);
				return 1;
			}
			
			function funload(){
				$("#vehTypeGridMain").load("vehtypegrid.jsp?chk="+aa);
			}
			
	    	$(function(){
	        	$('#frmVehType').validate({
	            	rules: {
	                	name: {
	                		required:true,
	                		maxlength:45
	                 	}
	                },
	                messages: {
	                	name:{
	                		required:" *",
	                	  	maxlength:"max 45 chars"
	                  	}
	               	}
	        	});
	       	});
	    	
	    	function funExcelBtn(){
	    		//$("#vehTypeGrid").jqxGrid('exportdata', 'xls', 'Authority');
	    	}
		</script>
	</head>
	<body onload="setValues();" >
		<div id="mainBG" class=" hidden-scrollbar homeContent" data-type="background">
			<form id="frmVehType" action="saveActionVehType" autocomplete="off">     
				<jsp:include page="../../../../header.jsp" />
				<fieldset><legend>Vehicle Type Details</legend>
					<div class="section-block">
						<div class="form-group dual-input">
							<label>Date</label>
						  	<div id="date" name="date"></div>
						  	
						  	<label>Doc No</label>
						  	<input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>'>
						</div>
						<div class="form-group">
  							<label>Name</label>
  							<input type="text" name="name" id="name" value='<s:property value="name"/>'style="width:85%;">
  						</div>
					</div>
				</fieldset>
				<table style="width:100%;">
					<tr><td><div id="vehTypeGridMain" style="width:100%"><jsp:include page="vehtypegrid.jsp"></jsp:include></div></td></tr>
					<tr><td><div id="vehTypeGrid" hidden=true></div></td></tr>
				</table>
				<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        		<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
				<input type="hidden" id="mode" name="mode"/>
				<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'/>
				<input type="hidden" id="deletedrows" name="deletedrows" value='<s:property value="deletedrows"/>'/>
			</form>
			
			
		</div>
	</body>
</html>