 <%@page import="com.controlcentre.masters.vehiclemaster.unit.ClsUnitAction" %>
<% ClsUnitAction cua =new ClsUnitAction();%>

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
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
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
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 16px Segoe UI;
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
}

/* ------------------------------
    CARD ROWS LAYOUT
------------------------------ */
.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

/* Grid for Unit Info */
.unit-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr; 
    gap: 12px 25px;
    align-items: center;
}

.desc-full-row {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 12px 25px;
    align-items: center;
    margin-top: 12px;
}

.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding: 10px; 
}

/* ------------------------------
    TABLES & DYNAMIC GRIDS (Preserved)
------------------------------ */
#jqxUnitSearch1 {
    width: 100%;
    margin-top: 15px;
}
</style>
<script type="text/javascript">
var data= '<%=cua.searchDetails() %>';
$(document).ready(function () { 	

	document.getElementById("formdet").innerText="Unit(UOM)";
	document.getElementById("formdetail").value="Unit";
	document.getElementById("formdetailcode").value="UOM";
	window.parent.formCode.value="UOM";
	window.parent.formName.value="Unit";
    
    var num = 0; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	    {name : 'DOC_NO' , type: 'number' },
						{name : 'unit', type: 'String'  },
						{name : 'unit_desc', type:  'String'}
                  	
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
  
    $("#jqxUnitSearch1").jqxGrid(
            {
            	
            	width: '100%',
                height: 337,
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
					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '30%' },
					{ text: 'Unit',columntype: 'textbox', filtertype: 'input', datafield: 'unit', width: '30%' },
					{ text: 'Description',columntype: 'textbox', filtertype: 'input', datafield: 'unit_desc',width: '40%'}
	              ]
            });
    $('#jqxUnitSearch1').on('rowdoubleclick', function (event) 
    		{ 
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxUnitSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("unit").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit");
                document.getElementById("unitdesc").value = $("#jqxUnitSearch1").jqxGrid('getcellvalue', rowindex1, "unit_desc");
    		 });
});

function funSearchLoad(){
		changeContent('unitSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmUnit input').attr('readonly', true);
		/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
	}
	function funRemoveReadOnly() {
		$('#frmUnit input').attr('readonly', false);
		//$('#jqxDateTimeInput').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
	}
	 function setValues(){	
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

			}
		    function funFocus()
		    {
		    	document.getElementById("unit").focus();
		    		
		    }
		    $(function(){
		        $('#frmUnit').validate({
		                 rules: {
		                 unit:{
		                	 required:true,
		                	 maxlength:3
		                 }, 
		                unitdesc:{
		                	maxlength:25
		                	}
		                
		                 },
		                 messages: {
		                  unit:{
		                	  required:" *",
		                	  maxlength:"max 3 chars"
		                  },
		                  unitdesc:{
		                	  maxlength:"max 25 chars"
		                  }
		                 }
		        });});
		     function funNotify(){
		    	 
		    		return 1;
			} 
		     function funExcelBtn(){
		   	  $("#jqxUnitSearch1").jqxGrid('exportdata', 'xls', 'Unit');
		   }
</script>
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmUnit" action="saveActionUnit" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Unit Details</h2>
                
                <div class="unit-info-grid">
                    <label>Unit</label>
                    <input type="text" name="unit" value='<s:property value="unit"/>' id="unit">

                    <label>Doc No</label>
                    <input type="text" name="docno" value='<s:property value="docno"/>' id="docno" readonly="readonly" tabindex="-1">
                </div>

                <div class="desc-full-row">
                    <label>Description</label>
                    <input type="text" name="unitdesc" value='<s:property value="unitdesc"/>' id="unitdesc">
                </div>
            </div>

            <div id="jqxUnitSearch1"></div>

            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="text" name="deleted" hidden="hidden" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" hidden="hidden" name="mode"/>
            
        </div>
    </form>
</div>

</body>
</html>