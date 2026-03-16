<%@page import="com.controlcentre.masters.vehiclemaster.model.ClsModelAction" %>
<%ClsModelAction cma=new ClsModelAction(); %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Model Master</title>
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
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        text-align: left !important; 
        /* Allow internal scrolling if content is too tall */
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
        font-size: 17.6px;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }


    .form-row {
        display: grid;
        /* Layout: Label | Input | Label | Input */
        grid-template-columns: 120px 1fr 120px 1fr;
        gap: 15px 30px;
        align-items: center;
        margin-bottom: 12px;
    }
    
    .form-row.date-docno {
        /* Specific layout for the top row (Date, Doc No) */
        grid-template-columns: 120px 180px 1fr 120px 180px 1fr; /* Add spacers */
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
        font-size: 14px;
    }
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
    }
    
    /* JQWigets/Grid Styling */
    #jqxModelSearch1 {
        margin-top: 20px;
        width: 100% !important; 
    }
    .jqx-grid-cell {
        font-size: 13px !important;
    }
    
    /* JQ Date Picker size fix */
    .jqx-datetimeinput-container .jqx-datetimeinput {
        height: 32px !important;
        width: 100% !important;
        padding: 0;
        margin: 0;
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
      $(document).ready(function () {          
    	  $("#modeldate").jqxDateTimeInput({ width: '100%', height: '32px' ,formatString : "dd.MM.yyyy" }); // Adjusted size for new layout
     
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
       						{name : 'vtype', type: 'String'  },
                            	{name : 'date', type: 'date'  },
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
                      	width: '100%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'multiplecellsextended',
                          sortable: true,
                          altrows:true,
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '20%' },
          					{ text: 'Brand ID',columntype: 'textbox', filtertype: 'input', datafield: 'brandid', width: '30%', hidden: true },
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
  		                $('#brand').val($("#jqxModelSearch1").jqxGrid('getcellvalue', rowindex1, "brandid")) ;
  		              $('#frmModel select').attr('disabled', true);
  		    		$('#modeldate').jqxDateTimeInput({disabled: true});
              		 }); 
              $("#jqxModelSearch1").jqxGrid('hidecolumn', 'brandid'); 

          });
    
      function funSearchLoad(){
			changeContent('modelSearch.jsp', $('#window')); 
		 }

	function funReadOnly() {
		$('#frmModel input').attr('readonly', true);
		$('#frmModel select').attr('disabled', true);
		$('#modeldate').jqxDateTimeInput({disabled: true});
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
<body onLoad="getBrand();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmModel" action="saveActionModel"  autocomplete="off">
<jsp:include page="../../../../header.jsp" />
   <div class="form-row date-docno" style="display:flex; align-items:center; width:100%;">

    <label style="margin-right:8px;">Date</label>

    <div class="jqx-datetimeinput-container" style="width:130px;">
        <div id="modeldate" name="modeldate" value='<s:property value="modeldate"/>'></div>
    </div>

    <label style="margin-left:auto; margin-right:8px;">Doc No</label>

    <input type="text"
           name="docno"
           value='<s:property value="docno"/>'
           id="docno"
           readonly="readonly"
           tabindex="-1"
           style="width:110px;">

</div>
    <div class="section-block">
        <h2>Model Details</h2>
        
         <div class="form-row">
            <label>Brand</label>
            <select name="brand" id="brand" style="width:100%;"></select>
            
            <label>Model</label>
            <input type="text" name="model" id="model" value='<s:property value="model"/>'>
        </div>
        
        <input type="hidden" id="brandid" name="brandid" value='<s:property value="brandid"/>'>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxModelSearch1"></div>
</div>

</div>
</body>
</html>