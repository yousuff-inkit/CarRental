<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>
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
      $(document).ready(function () {          
    	  $("#modeldate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });  
     
    	    document.getElementById("formdet").innerText="Model(MOD)";
			document.getElementById("formdetail").value="Model";
			document.getElementById("formdetailcode").value="MOD";
			window.parent.formCode.value="MOD";
			window.parent.formName.value="Model";
          var data= '<%=cma.searchDetails() %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'DOC_NO' , type: 'int' },
       						{name : 'vtype', type: 'String'  },
                            	{name : 'date', type: 'date'  },
                            	{name : 'brand_name',type:'String'},
                            	{name : 'brandid',type:'String'}
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
      


              $("#jqxModelSearch1").jqxGrid(
                      {
                      	width: '70%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                        //  pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '20%' },
          					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%' },
          					{ text: 'Model',columntype: 'textbox', filtertype: 'input', datafield: 'vtype', width: '30%' },
          					{ text: 'Date',columntype: 'textbox',filtertype: 'input',datafield:'date',width: '20%',cellsformat:'dd.MM.yyyy'},
          					{ text: 'Brand',columntype: 'textbox', filtertype: 'input', datafield: 'brand_name', width: '30%' },

          	              ]
                      });

              $('#jqxModelSearch1').on('rowdoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxModelSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
  		                document.getElementById("model").value = $("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "vtype");
  		              $('#frmModel select').attr('disabled', false);
  		    		$('#modeldate').jqxDateTimeInput({disabled: false});
  		                $("#modeldate").jqxDateTimeInput('val',$("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		               // $('#brandid').val($("#jqxModelSearch").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		                $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              $('#frmModel select').attr('disabled', true);
  		    		$('#modeldate').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 
              //$("#jqxModelSearch").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmModel input').attr('readonly', true);
		$('#frmModel select').attr('disabled', true);
		$('#modeldate').jqxDateTimeInput({disabled: true});
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
		
	}
	function funRemoveReadOnly() {
		$('#frmModel input').attr('readonly', false);
		$('#frmModel select').attr('disabled', false);
		$('#modeldate').jqxDateTimeInput({disabled: false});
		$('#docno').attr('readonly', true);
		

	}

	function getBrand() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('***');
				var brandItems = items[0].split(",");
				var brandidItems = items[1].split(",");
				var optionsbrand = '<option value="">--Select--</option>';
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}
				$("select#brand").html(optionsbrand);
				$('#brand').val($('#brandid').val());
				} else {
			}
		}
		x.open("GET", "getBrand.jsp", true);
		x.send();
	}
	
	function funFocus(){
		document.getElementById("brand").focus();
	}
	 $(function(){
	        $('#frmModel').validate({
	                 rules: {
	                 brand:{
	                	 required:true
	                 },
	                 model:{
	                	 required:true,
	                	 maxlength:20
	                 }
	                 },
	                 messages: {
	                  brand:{
	                	  required:" *"
	                  },
	                  model:{
	                	  required:" *",
	                	  maxlength:"max 20 chars"
	                  }
	                 }
	        });});
	     function funNotify(){
	    	
	    		return 1;
		} 
	     
	function setValues() {
		//$('#brand').val($('#brandid').val());
if ($('#brandid').val() != null) {
	//alert("ghcj");
			$('#brand').val($('#brandid').val());
}
if($('#msg').val()!=""){
	   $.messager.alert('Message',$('#msg').val());
	  }
	}
	
	 function funExcelBtn(){
		  $("#jqxModelSearch1").jqxGrid('exportdata', 'xls', 'Model');
	  }
</script>
</head>
<body onLoad="getBrand();setValues();"><div id="mainBG" class="homeContent" data-type="background">
<form id="frmModel" action="saveActionModel"  autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
    <div class='hidden-scrollbar receipt-header'>
<div class="table-section" style="width: 100%;"><h3>Model Details</h3>
<input type="text" id="brandid" name="brandid" value='<s:property value="brandid"/>' hidden="true">
<table class="cr-table" width="100%">
<tr>
  <td width="14%"><div align="right">Date</div></td>
  <td width="12%"><div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div></td>
  <td width="23%"><div align="right">Doc No</div></td>
  <td width="51%"><input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly"  tabindex="-1"></td>
</tr>
<tr><td><div align="right">Brand</div></td>
<td> 
<!-- <option value="">--Select--</option> -->
 <select name="brand" id="brand" style="width:100%;">
</select></td><td><div align="right">Model</div></td><td><input type="text" name="model" id="model" value='<s:property value="model"/>'></td></tr>
</table> 
</div>
										        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" id="mode" name="mode"/>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
        <div id="jqxModelSearch1"></div>
    </div>
</form>
<br/>

<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="modelSearch.jsp"></jsp:include>
	</div></div> --%>

</div>
</body>
</html>