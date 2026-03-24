<%@ taglib prefix="s" uri="/struts-tags" %>
<%@page import="com.controlcentre.masters.vehiclemaster.brand.ClsBrandAction" %>
<%ClsBrandAction cba=new ClsBrandAction(); %>
<%
String contextPath=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>GatewayERP(i) - Brand Master</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
    
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
    }
    
    /* Ensure outer container can scroll if content is too tall */
    .scrollable-content {
        overflow-y: auto;
        max-height: calc(100vh - 64px); 
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
    border-left: 4px solid #007bff; /* Blue line accent */
}

    .form-row {
        display: grid;
        /* Layout: Label | Input | Label | Input */
        grid-template-columns: 120px 1fr 120px 1fr;
        gap: 15px 30px;
        align-items: center;
        margin-bottom: 12px;
    }
    
    .form-row.single-field {
        grid-template-columns: 120px 1fr 1fr; /* 1fr for spacing/alignment */
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
    #jqxBrandSearch1 {
        margin-top: 20px;
        /* Ensure the grid fits well within the container */
        width: 100% !important; 
    }
    .jqx-grid-cell {
        font-size: 13px !important;
    }

</style>
<script type="text/javascript">
	$(document).ready(function () {    
	    $("#date_brand").jqxDateTimeInput({ width: '100%', height: '32px' ,formatString : "dd.MM.yyyy" }); // Adjusted size for new layout
	    
	    document.getElementById("formdet").innerText="Brand(BRD)";
		document.getElementById("formdetail").value="Brand";
		document.getElementById("formdetailcode").value="BRD";
		window.parent.formCode.value="BRD";
		window.parent.formName.value="Brand";
 		var data= '<%=cba.searchDetails() %>';
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'BRAND_NAME', type: 'String'  },
                          	{name : 'DATE', type: 'date'  }
                 ],
               localdata: data,
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
    
            $("#jqxBrandSearch1").jqxGrid(
                    {
                    	width: '100%', // Use 100% width
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'multiplecellsextended',
                        columns: [
        					{ text: 'DOC NO', datafield: 'DOC_NO', width: '10%' },
        					{ text: 'BRAND',columntype: 'textbox', filtertype: 'input', datafield: 'BRAND_NAME', width: '50%' },
        					{ text: 'DATE',columntype: 'textbox', filtertype: 'input', datafield: 'DATE', width: '40%',cellsformat:'dd.MM.yyyy' }
        	              ]
                    });
            $('#jqxBrandSearch1').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxBrandSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("brand").value = $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "BRAND_NAME");
                $("#date_brand").jqxDateTimeInput('val', $("#jqxBrandSearch1").jqxGrid('getcellvalue', rowindex1, "DATE"));
            }); 
        });
	function funSearchLoad(){
		changeContent('brandSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmBrand input').attr('readonly', true);
		$('#date_brand').jqxDateTimeInput({
			readonly : true
		});
	}
	function funRemoveReadOnly() {
		$('#frmBrand input').attr('readonly', false);
		$('#date_brand').jqxDateTimeInput({
			readonly : false
		});
		$('#docno').attr('readonly', true);
	}
	function setValues() {
		if($('#datehidden').val()){
			$("#date_brand").jqxDateTimeInput('val', $('#datehidden').val());
		}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
	}
	
	 $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });});
	     function funNotify(){
	    
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("brand").focus();
	     }
	  function funExcelBtn(){
		  $("#jqxBrandSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background"> 
    <form id="frmBrand" action="saveBrand" method="get" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        <div class="form-row" style="display:flex; align-items:center; width:100%;">

    <label style="margin-right:8px;">Date</label>

    <div id="date_brand"
         name="date_brand"
         class="jqx-datetimeinput-container"
         style="width:130px; max-width:130px;"></div>

    <label style="margin-left:auto; margin-right:8px;">Doc No.</label>

    <input type="text"
           name="docno"
           id="docno"
           value='<s:property value="docno"/>'
           readonly
           tabindex="-1"
           style="width:110px;">

</div>
        <div class="scrollable-content">
            <div class="section-block">
                <h2 style="margin-top: 0;">Brand Details</h2>
                
                <div class="form-row single-field">
                    <label>Brand</label>
                    <input type="text" name="brand" id="brand" value='<s:property value="brand"/>' >
                    <div></div> </div>
                
                <input type="hidden" id="mode" name="mode"/>
                <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
                <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
                <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
            </div>
            
            <div style="padding: 0 20px;">
                <div id="jqxBrandSearch1"></div>
            </div>
        </div>
    </form>
</div>
</body>
</html>