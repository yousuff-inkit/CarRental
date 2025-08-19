<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.nationality.ClsNationalityDAO"%>
<% ClsNationalityDAO DAO= new ClsNationalityDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">

	/* Grid */
	 var data= '<%= DAO.nationality() %>'; 
	 $(document).ready(function () {
		 $("#btnDelete").attr('disabled', true ); 		
		    var source =
		     {
		         datatype: "json",
		         datafields: [
							{name : 'doc_no', type: 'int'  },
		                   	{name : 'name', type: 'String'  },
		                   
		          ],
		        localdata: data, 
		         
		         pager: function (pagenum, pagesize, oldpagenum) {
		             // callback called when a page or page size is changed.
		         }
		     };
		  
		   
		     var dataAdapter = new $.jqx.dataAdapter(source,
		     		 {
		         		loadError: function (xhr, status, error) {
		                 alert(error);    
		                 }
			            }		
		     );
		    
		     $("#jqxnationality1").jqxGrid(
		             {
		             	 width: '70%',
		                 height: 375,
		                 source: dataAdapter,
		                 showfilterrow: true,
		                 filterable: true,
		                 selectionmode: 'singlerow',
		                 
		                 columns: [
		                	 { text: 'Doc No', datafield: 'doc_no', filterable: false, width: '10%' },
						    { text: 'Name',columntype: 'textbox', filtertype: 'input', datafield: 'name'},
		 	              ]
		             });
		    
		     $('#jqxnationality1').on('rowdoubleclick', function (event) {
		         var rowindex1=event.args.rowindex;
		         document.getElementById("docno").value = $("#jqxnationality1").jqxGrid('getcellvalue', rowindex1, "doc_no");
		         document.getElementById("txtname").value = $("#jqxnationality1").jqxGrid('getcellvalue', rowindex1, "name");
		         
		     }); 
	});
 
    /* Validations */
      $(function(){
	        $('#frmNationality').validate({
	                rules: {
	                name:"required"
	                },
	                messages: {
	                name:" *"
	                }
	         });}); 
    
	function funReadOnly() {
		$('#frmNationality input').attr('readonly', true);
		$('#frmNationality select').attr('disabled', true);
		 //$("#jqxnationality1").jqxGrid({disabled:true});
	}
	
	function funRemoveReadOnly() {
		$('#frmNationality input').attr('readonly', false);
		$('#frmNationality select').attr('disabled', false);
		 //$("#jqxnationality1").jqxGrid({disabled:false});
	}
	
	function funNotify(){
		 
		 name=document.getElementById("txtname").value;
		if(name==""){
			 document.getElementById("errormsg").innerText="Please Enter Name";
			 return 0;
		 }
		   return 1;
	} 
	 
	
	function funSearchLoad(){
	   changeContent('nationalitySearch.jsp?check=1');  
	}
	 
	function funFocus()
	 {
		document.getElementById("txtname").focus();
	 }
	
	function setValues(){
	
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
	}
	 
</script>

<style>
.hidden-scrollbar {
  overflow: auto;
  height: 530px;
}
</style>
			
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmNationality" action="saveNationality" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<fieldset>
<legend>Nationality</legend>
<table width="100%">
  <tr><td width="8%" align="right">Name</td><td width="62%"><input type="text" name="txtname" id="txtname" value='<s:property value="txtname"/>'></td>
  <td width="14%" align="right">Doc No</td>
  <td width="16%"><input type="text" name="docno"  id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1"></td>
</tr>
</table>
</fieldset><br/>
<div id="jqxnationality1"></div>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</div>
</form>
</div>
</body>
</html>