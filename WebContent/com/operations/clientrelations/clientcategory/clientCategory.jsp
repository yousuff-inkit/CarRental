<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryDAO"%>
<% ClsClientCategoryDAO DAO= new ClsClientCategoryDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">

	/* Grid */
	 var data= '<%= DAO.category() %>'; 
	 $(document).ready(function () {
		 getAccountGroup();
		 getconfig();
	     var source =
	     {
	         datatype: "json",
	         datafields: [
						{name : 'doc_no', type: 'int'  },
						{name : 'dtypes', type: 'String'  },
					    {name : 'category', type: 'String'  },
	                   	{name : 'cat_name', type: 'String'  },
	                   	{name : 'description', type: 'String'  },
	                   	{ name: 'approved', type: 'bool' },
	                   	{name : 'dtype', type: 'String'  },
	                   	{ name: 'approval', type: 'int' },
	                   	{name : 'acc_group', type: 'String'  }
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
	    
	     $("#jqxCategorySearch1").jqxGrid(
	             {
	             	 width: '70%',
	                 height: 375,
	                 source: dataAdapter,
	                 showfilterrow: true,
	                 filterable: true,
	                 selectionmode: 'singlerow',
	                 
	                 columns: [
							  { text: 'Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtypes', width: '8%' },
	 						  { text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '20%' },
	 						  { text: 'Category Name',columntype: 'textbox', filtertype: 'input', datafield: 'cat_name', width: '34%' },
	 						  { text: 'Account Group',columntype: 'textbox', filtertype: 'input', datafield: 'description' },
	 						  { text: 'Approval', datafield: 'approved', columntype: 'checkbox', filterable: false, checked: true, width: '8%',cellsalign: 'center', align: 'center' },
	 						  { text: 'Doc No', datafield: 'doc_no', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Dtype', datafield: 'dtype', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width: '10%' },
	 						  { text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true, width: '10%' },
	 					
	 	              ]
	             });
	    
	 	    
	     
	    	 
	     $('#jqxCategorySearch1').on('rowdoubleclick', function (event) {
	         var rowindex1=event.args.rowindex;
			 getAccountGroup($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype"));
	         document.getElementById("docno").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "doc_no");
	         document.getElementById("cmbtype").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype");
	         document.getElementById("txtcategory").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "category");
	         document.getElementById("txtcategoryname").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "cat_name");
	         document.getElementById("cmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
			 document.getElementById("hidcmbaccountgroup").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
	         document.getElementById("hidchckapproval").value = $("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval");
	         
	         if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==1){
	 			 document.getElementById("chckapproval").checked = true;
	 		 }
	 		 else if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==0){
	 			document.getElementById("chckapproval").checked = false;
	 		 }
	     }); 
	});
 
    /* Validations */
      $(function(){
	        $('#frmClientCategory').validate({
	                rules: {
	                cmbtype:"required",	
	                txtcategory:"required",
	                txtcategoryname:"required",
	                cmbaccountgroup:"required"
	                },
	                messages: {
	                cmbtype:" *",
	                txtcategory:" *",
	                txtcategoryname:" *",
	                cmbaccountgroup:" *"
	                }
	         });}); 
    
      function getconfig() {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					items = x.responseText;
					items = items.split('####');
					//alert(items[0])
					if (items[0]==1) 
					{
						$('#chckapproval').hide();
						$('#appr').hide();
						$('#config').val(1);
					$('#jqxCategorySearch1').jqxGrid('hidecolumn','approved');
					    	 
		      		}

				} 
				else {
					$('#chckapproval').show();
					$('#appr').show();
					$('#config').val(0);
				$('#jqxCategorySearch1').jqxGrid('showcolumn','approved');
				}
			}
			x.open("GET", "getconfig.jsp", true);
			x.send();
		}		

 
    
      function getAccountGroup(type) {
    		var x = new XMLHttpRequest();
    		x.onreadystatechange = function() {
    			if (x.readyState == 4 && x.status == 200) {
    				var items = x.responseText;
    				items = items.split('####');
    				var groupItems = items[0].split(",");
    				var groupIdItems = items[1].split(",");
    				var optionsgroup = '<option value="">--Select--</option>';
    				for (var i = 0; i < groupItems.length; i++) {
    					optionsgroup += '<option value="' + groupIdItems[i] + '">'
    							+ groupItems[i] + '</option>';
    				}
    				$("select#cmbaccountgroup").html(optionsgroup);
    				if ($('#hidcmbaccountgroup').val() != null) {
    					$('#cmbaccountgroup').val($('#hidcmbaccountgroup').val());
    				}
    			} else {
    			}
    		}
    		x.open("GET", "getAccountGroup.jsp?type="+type, true);
    		x.send();
    	} 
    
      function approval(){
  		 if(document.getElementById("chckapproval").checked){
  			 document.getElementById("hidchckapproval").value = 1;
  		 }
  		 else{
  			 document.getElementById("hidchckapproval").value = 0;
  		 }
  	 }
	
	function funReadOnly() {
		getconfig();
		$('#frmClientCategory input').attr('readonly', true);
		$('#frmClientCategory select').attr('disabled', true);
		$('#chckapproval').attr('disabled', true);
	}
	
	function funRemoveReadOnly() {
		getconfig();
		$('#frmClientCategory input').attr('readonly', false);
		$('#frmClientCategory select').attr('disabled', false);
		$('#chckapproval').attr('disabled', false);
		
		if ($("#mode").val() == "A") {
		
			 $('#hidchckapproval').val(0);
			 document.getElementById("chckapproval").checked = false;
		}
		
	}
	
	function funNotify(){	
		   return 1;
	} 
	 
	function funChkButton() {
		/* funReset(); */
	}
	
	function funSearchLoad(){
	   changeContent('categoryMainSearchGrid.jsp?check=1');  
	}
	 
	function funFocus()
	 {
		document.getElementById("cmbtype").focus();
	 }
	
	function setValues(){
		
		document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value;
		
		 if(document.getElementById("hidchckapproval").value==1){
 			 document.getElementById("chckapproval").checked = true;
 		 }
 		 else if(document.getElementById("hidchckapproval").value==0){
 			document.getElementById("chckapproval").checked = false;
 		 }
		
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
			
</head>
<body onload="setValues(); getconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientCategory" action="saveClientCategory" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;">
<h3>Category Master</h3>
<table class="cr-table" width="100%">
  <tr>
  <td width="5%" align="right">Type</td>
  <td width="7%"><select id="cmbtype" name="cmbtype" style="width:75%;" onchange="getAccountGroup($('#cmbtype').val());" value='<s:property value="cmbtype"/>'>
      <option value="">--Select--</option>
      <option value="CRM">CLIENT</option><option value="VND">VENDOR</option></select>
      <input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/></td>
    <td width="12%" align="right">Category</td>
    <td width="20%"><input type="text" id="txtcategory" name="txtcategory" style="width:70%;" value='<s:property value="txtcategory"/>'></td>
    <td width="7%" align="right">Category Name</td>
    <td width="49%"><input type="text" id="txtcategoryname" name="txtcategoryname" style="width:37%;" value='<s:property value="txtcategoryname"/>'></td>
  </tr>
  <tr>
    <td colspan="2" align="right">Account Group</td>
  <td colspan="2"><select id="cmbaccountgroup" name="cmbaccountgroup"  style="width:83%;" value='<s:property value="cmbaccountgroup"/>'>
      <option value="">--Select--</option></select>
       <input type="hidden" id="hidcmbaccountgroup" name="hidcmbaccountgroup" value='<s:property value="hidcmbaccountgroup"/>'/></td>
  <td colspan="3"><input type="checkbox" id="chckapproval" name="chckapproval" value="" onchange="approval();" onclick="$(this).attr('value', this.checked ? 1 : 0)"><label id="appr" >Approval</label>     
				    <input type="hidden" id="hidchckapproval" name="hidchckapproval" value='<s:property value="hidchckapproval"/>'/>
				   <input type="hidden" id="config" name="config"/> </td>
  </tr>
  
</table>
</div><br/>
<div style="width: 100%;" id="jqxCategorySearch1"></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="hidtxtclientcategorydocno" value='<s:property value="hidtxtclientcategorydocno"/>'/>
</div>
</form>
</div>
</body>
</html>