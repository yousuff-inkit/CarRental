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
/* =========================================================
   AUTHORITY - EXACT TEXT & UI MATCH TO CLIENT MASTER
========================================================= */
body, .homeContent {
    background: #f4f6f9 !important;
    font-family: Arial, sans-serif !important;
    color: #333 !important;
    font-size: 12px !important;
    margin: 0;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

.hidden-scrollbar {
    overflow-y: auto;
    overflow-x: hidden;
    height: calc(100vh - 140px);
    padding-bottom: 60px;
    box-sizing: border-box;
}

form label.error {
    color: red;
    font-weight: bold;
}

input[type="text"], input[type="email"], select {
    height: 24px !important; 
    border: 1px solid #ccc !important;
    border-radius: 3px !important;
    padding: 2px 6px !important;
    font-size: 12px !important;
    box-sizing: border-box;
    background-color: #fff !important;
    color: #333 !important;
}

input[type="text"]:focus, input[type="email"]:focus, select:focus {
    border-color: #007bff !important;
    outline: none !important;
}

input[readonly], input:disabled, select:disabled {
    background-color: #f4f5f7 !important;
    color: #5e6c84 !important;
    border-color: #e1e4e8 !important;
}

fieldset {
    border: 1px solid #e1e4e8 !important;
    background-color: #fff !important;
    margin-bottom: 10px !important;
    padding: 12px 10px 10px 10px !important;
    border-radius: 4px !important;
}

legend {
    font-size: 13px !important;
    font-weight: bold !important;
    color: #0056b3 !important;
    padding: 0 0 0 6px !important;
    border-left: 3px solid #0056b3 !important;
    margin-bottom: 5px !important;
    background: #fff;
}

table td {
    padding: 6px !important;
    font-size: 12px !important;
    color: #444 !important;
    font-weight: bold !important;
    vertical-align: middle;
}

.myButton {
    background-color: #0056b3 !important;
    color: #ffffff !important;
    border: none !important;
    border-radius: 3px !important;
    padding: 4px 15px !important;
    font-weight: bold !important;
    font-size: 12px !important;
    cursor: pointer !important;
    height: 24px !important;
}

.myButton:hover {
    background-color: #004494 !important;
}
</style>

<script type="text/javascript">
var data= '<%=ca.searchDetails() %>';

      $(document).ready(function (){   
          $("#authdate").jqxDateTimeInput({ width: '125px', height: '24px',formatString:"dd.MM.yyyy"}); 
          
          // FIX: Force sync the widget date to the hidden input so Struts receives the data
          $('#authdate').on('valueChanged', function (event) {
              var date = event.args.date;
              if (date) {
                  var formattedDate = $.jqx.dataFormat.formatdate(date, 'dd.MM.yyyy');
                  $('#authdatehidden').val(formattedDate);
              }
          });
          
          if(document.getElementById("formdet")){
              document.getElementById("formdet").innerText="Authority(AUT)";
              document.getElementById("formdetail").value="Authority";
              document.getElementById("formdetailcode").value="AUT";
          }
          if(window.parent && window.parent.formName){
              window.parent.formName.value="Authority";
              window.parent.formCode.value="AUT"; 
          }
            	  
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
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source, {
              loadError: function (xhr, status, error) { }
          }); 

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
          // FIX: Ensure hidden fields are populated securely on page load
          if($('#authdatehidden').val()){
              $("#authdate").jqxDateTimeInput('val', $('#authdatehidden').val());
          } else {
              // Initialize hidden field with the default UI widget date
              var currentDate = $('#authdate').jqxDateTimeInput('val');
              $('#authdatehidden').val(currentDate);
          }
          
          if($('#msg').val()!=""){
              $.messager.alert('Message',$('#msg').val());
          }
      }

      function funFocus(){
          if(document.getElementById("auth")) {
              document.getElementById("auth").focus();
          }
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
          });
      });

      function funExcelBtn(){
          $("#jqxAuthoritySearch1").jqxGrid('exportdata', 'xls', 'Authority');
      }
</script>

</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmAuthority" action="saveActionAuthority" autocomplete="off" method="post">     
	<jsp:include page="../../../../header.jsp" />
	<br/> 

<fieldset>
    <legend>Authority Details</legend>
    <table width="100%">
        <tr>
            <td width="15%" align="right">Date</td>
            <td width="35%"><div id="authdate" name="authdate"></div></td>
            <td width="15%" align="right">Doc No</td>
            <td width="35%"><input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' style="width:60%;"></td>
        </tr>
        <tr>
            <td align="right">Authority</td>
            <td><input type="text" name="auth" id="auth" value='<s:property value="auth"/>' style="width:60%;"></td>
            <td align="right">Name</td>
            <td><input type="text" name="authname" id="authname" value='<s:property value="authname"/>' style="width:60%;"></td>
        </tr>
    </table>
</fieldset>

<input type="hidden" id="authdatehidden" name="authdatehidden" value='<s:property value="authdatehidden"/>'/>					
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' />
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'/>

</form>
<br/>

<div id="jqxAuthoritySearch1"></div>

</div>
</body>
</html>