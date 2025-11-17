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
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
form label.error {
color:red;
  font-weight:bold;

}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}
#validrate{
    color:red;
}
#validrate1{
    color:red;
}

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
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}
</style>
<script type="text/javascript">
var data= '<%=ca.searchDetails() %>';

      $(document).ready(function (){   
    	  $("#authdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
    	  
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
   						{name : 'authname', type: 'String'  },
                        	{name : 'date', type: 'date'  },
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
                  	width: 850,
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'multiplecellsextended',
                      //pagermode: 'default',
                      sortable: true,
                      //pageable: true,
                      altrows:true,
                      //Add row method
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
	// $('#frmAuthority select').attr('disabled', true );
	
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
<%-- <%@include file="../../../../../header.jsp" %><br/> --%>
<form id="frmAuthority" action="saveActionAuthority" autocomplete="off">     
	<jsp:include page="../../../../header.jsp" />
	<br/>
    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;"><h3>Authority Details</h3><table class="cr-table" width="100%">

<tr>
  <td width="6%">&nbsp;</td>
  <td width="21%">&nbsp;</td>
  <td width="6%">&nbsp;</td>
  <td>&nbsp;</td>
  <td width="30%"><div align="right">Doc No    </div></td>
  <td width="16%"><input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>'></td>
<tr>
  <td><div align="right">Date</div></td>
  <td><div id="authdate" name="authdate"></div></td>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
  <td colspan="2">&nbsp;</td>
<tr><td><div align="right">Authority</div></td>
  <td><input type="text" name="auth" id="auth" value='<s:property value="auth"/>'></td>
  <td><div align="right">Name</div></td><td width="21%"><input type="text" name="authname" id="authname" value='<s:property value="authname"/>'style="width:85%;"></td><td colspan="2">&nbsp;</td>
</table>
</div>
<input type="hidden" id="authdatehidden" name="authdatehidden" value='<s:property value="authdatehidden"/>'/>					
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="mode" name="mode"/>
        <div id="jqxAuthoritySearch1"></div>
    </div>
</form>
<br/>
<%--
<div id="window">
<div id="windowHeader" class="windowHead">
<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
</div>
<div id="windowContent" class="windowCont" style="overflow: hidden;">
<jsp:include page="authoritySearch.jsp"></jsp:include>
</div></div> --%>
</div>
</body>
</html>