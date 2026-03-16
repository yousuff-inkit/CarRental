<%@page import="com.controlcentre.masters.vehiclemaster.authority.ClsAuthorityAction" %>
<%ClsAuthorityAction ca=new ClsAuthorityAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Authority Master</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (Adopted)
    ------------------------------ */
    body {
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
        color: #222;
        margin: 0;
        padding: 32px 0;
        min-height: 100vh;
        box-sizing: border-box;
    }

    #mainBG {
        background: #fff;
        border-radius: 16px;
        padding: 20px;
        max-width: 1450px;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
        max-height: calc(100vh - 64px); 
        overflow-y: auto; 
    }
    
    /* ------------------------------
       HEADER & TITLE FIXES
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }
    
    #formdet {
        font-size: 24px !important;
        font-weight: 700 !important;
        color: #2c3e50;
        margin-bottom: 15px;
        display: block;
        text-align: left !important;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ------------------------------
       GRID SYSTEM & SECTIONS
    ------------------------------ */
    .section-block {
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px; 
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        margin-bottom: 30px;
    }
    .section-block h2 {
        font-size: 17.6px
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }


    .form-row {
        display: grid;
        grid-template-columns: 120px 1fr 120px 1fr; 
        gap: 15px 30px;
        align-items: center;
        margin-bottom: 12px;
    }
    
    .form-row.double-input {
        grid-template-columns: 120px 180px auto 120px 1fr;
    }


    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select {
        height: 32px !important;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        padding: 6px 10px;
        background: #fff;
        transition: border-color 0.2s;
        font-size: 16px;
        box-sizing: border-box;
        width: 100%;
    }

    input[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
    }
    
    /* FIX: JQ Date Picker size and alignment */
    /* Ensure the input container itself uses the desired height for alignment */
    .jqx-datetimeinput-container {
         height: 32px;
    }
    /* Ensure the JQ widget inside the container fills the space and aligns with the grid */
    #authdate, #date_brand, #vehpurorderDate, #vehpurinvDate {
        height: 32px !important;
        width: 100% !important;
        /* Vertical align the widget content (if necessary, though grid handles the wrapper) */
        vertical-align: middle; 
    }
    .jqx-datetimeinput {
        /* Overriding JQWigets internal default padding/sizing */
        height: 32px !important;
        line-height: 32px !important;
    }


    /* JQWigets/Grid Styling */
    #jqxAuthoritySearch1 {
        margin-top: 20px;
        width: 100% !important; 
    }
    .jqx-grid-cell {
        font-size: 13px !important;
    }

    /* ------------------------------
       UTILITY STYLES
    ------------------------------ */
    fieldset {
        border: none;
        padding: 0;
        margin: 0;
    }

</style>
<script type="text/javascript">
var data= '<%=ca.searchDetails() %>';

      $(document).ready(function (){   
    	  $("#authdate").jqxDateTimeInput({ width: '100%', height: '32px', formatString:"dd.MM.yyyy"}); 
    	  
    	  document.getElementById("formdet").innerText="Authority(AUT)";
  		  document.getElementById("formdetail").value="Authority";
  		  document.getElementById("formdetailcode").value="AUT";
		  window.parent.formName.value="Authority";
  			window.parent.formCode.value="AUT";    	  
    	  var num = 0; 
          var source =
          {
              datatype: "json",
              datafields: [
                        	{name : 'DOC_NO' , type: 'number' },
   						{name : 'authname', type: 'String'  },
                        	{name : 'date', type: 'date'  },
                        	{name : 'authid',type:'String'}
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
          $("#jqxAuthoritySearch1").jqxGrid(
                  {
                  	width: '100%',
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'multiplecellsextended',
                      sortable: true,
                      altrows:true,
                      columns: [
      					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
      					{ text: 'Auth Id', datafield: 'authid', width: '20%' },
      					{ text: 'Authority',columntype: 'textbox', filtertype: 'input', datafield: 'authname', width: '50%' },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
    					

      	              ]
                  });
     
          $('#jqxAuthoritySearch1').on('rowdoubleclick', function (event) 
          		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxAuthoritySearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
		                document.getElementById("authname").value = $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authname");
		            	$('#authdate').jqxDateTimeInput({ disabled: false});

		                $("#authdate").jqxDateTimeInput('val', $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("auth").value= $("#jqxAuthoritySearch1").jqxGrid('getcellvalue', rowindex1, "authid");
		            	$('#authdate').jqxDateTimeInput({ disabled: true});

          		 }); 
      });
     
      function funSearchLoad(){
			changeContent('authoritySearch.jsp', $('#window')); 
		 }

function funReadOnly(){
	$('#frmAuthority input').attr('readonly', true );
	 $('#authdate').jqxDateTimeInput({ disabled: true}); 
	
}
function funRemoveReadOnly(){
	$('#frmAuthority input').attr('readonly', false );
	$('#authdate').jqxDateTimeInput({ disabled: false});
	$('#docno').attr('readonly', true);
}
function setValues() {
	 if($('#authdatehidden').val()){
			$("#authdate").jqxDateTimeInput('val', $('#authdatehidden').val());

	 }
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
}
function funFocus(){
	document.getElementById("auth").focus();
	}
	function funNotify(){
		return 1;
	}
	    $(function(){
	        $('#frmAuthority').validate({
	                 rules: {
	                 auth: {
	                	required:true,
	                	maxlength:8
	                 },
	                authname:{
	                	required:true,
	                	maxlength:25
	                }
	                 },
	                 messages: {
	                  auth:{
	                	  required:" *",
	                	  maxlength:"max 8 chars"
	                  },
	                  authname:{
	                	  required:" *",
	                	  maxlength:"max 25 chars"
	                  }
	                 }
	        });});
	    function funExcelBtn(){
	    	 $("#jqxAuthoritySearch1").jqxGrid('exportdata', 'xls', 'Authority');
	    }
</script>

</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAuthority" action="saveActionAuthority" autocomplete="off">     
	<jsp:include page="../../../../header.jsp" />
	<div class="form-row" style="display:flex; align-items:center; width:100%;">

    <label style="margin-right:8px;">Date</label>

    <div class="jqx-datetimeinput-container" style="width:130px;">
        <div id="authdate" name="authdate"></div>
    </div>

    <label style="margin-left:auto; margin-right:8px;">Doc No</label>

    <input type="text"
           name="docno"
           id="docno"
           readonly="readonly"
           value='<s:property value="docno"/>'
           tabindex="-1"
           style="width:110px;">

</div>
    <div class="section-block">
        <h2>Authority Details</h2>
        
       
        
        <div class="form-row double-input">
            <label>Authority</label>
            <input type="text" name="auth" id="auth" value='<s:property value="auth"/>'>

            <label>Name</label>
            <input type="text" name="authname" id="authname" value='<s:property value="authname"/>'>
        </div>

        <input type="hidden" id="authdatehidden" name="authdatehidden" value='<s:property value="authdatehidden"/>'/>					
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode"/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxAuthoritySearch1"></div>
</div>

</div>
</body>
</html>