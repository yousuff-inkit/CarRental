<%@page import="com.controlcentre.masters.vehiclemaster.color.ClsColorAction" %>
<%ClsColorAction coa=new ClsColorAction(); %>

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
    min-height: 100vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%; /* Master UI requirement */
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    text-align: left !important;
}

/* ------------------------------
    SECTION BLOCKS & HEADERS
------------------------------ */
.section-block {
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
    border-left: 4px solid #007bff; /* Signature Blue Line */
    color: #333;
    display: block;
}

/* ------------------------------
    GRID SYSTEM (FORM LAYOUT)
------------------------------ */
.form-row {
    display: grid;
    grid-template-columns: 120px 1fr 120px 1fr; 
    gap: 15px 30px;
    align-items: center;
    margin-bottom: 12px;
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
    font-size: 14px;
    box-sizing: border-box;
    width: 100%;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
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

/* ------------------------------
    UTILITY STYLES
------------------------------ */
.hidden-scrollbar {
    overflow-y: auto;
    height: auto;
    min-height: 530px;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

form label.error {
    color: red;
    font-weight: bold;
}


#formdet {
    text-align: left !important;
    display: block;
}


</style>
<script type="text/javascript">
var data= '<%=coa.searchDetails() %>';
$(document).ready(function () { 	
    
    	document.getElementById("formdet").innerText="Color(CLR)";
		document.getElementById("formdetail").value="Color";
		document.getElementById("formdetailcode").value="CLR";
		window.parent.formCode.value="CLR";
		window.parent.formName.value="Color";
		
     var num = 0; 
    var source =
    {
        datatype: "json",
        datafields: [
                  	{name : 'DOC_NO' , type: 'number' },
						{name : 'color', type: 'String'  }
                  	
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

    $("#jqxColorSearch1").jqxGrid(
            {
            	width: '100%',
                height: 315,
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
					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'Color',columntype: 'textbox', filtertype: 'input', datafield: 'color', width: '60%' }
	              ]
            });
    $('#jqxColorSearch1').on('rowdoubleclick', function (event) 
    		{ 
    			var rowindex1=event.args.rowindex;
      		 	 document.getElementById("docno").value= $('#jqxColorSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
       			 document.getElementById("color").value = $("#jqxColorSearch1").jqxGrid('getcellvalue', rowindex1, "color");                
    	 		 $('#window').jqxWindow('hide');
    		 }); 
});
function funReadOnly(){
	$('#frmColor input').attr('readonly', true );
	/* $('#jqxDateTimeInput').jqxDateTimeInput({ disabled: true}); */
}
function funRemoveReadOnly(){
	$('#frmColor input').attr('readonly', false );
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
    	document.getElementById("color").focus();
    		
    }
   
    $(function(){
    	
        $('#frmColor').validate({
                 rules: {
                 color: {
                	 required:true,
                	 maxlength:45
                 }
                 
                 
                 },
                 messages: {
                  color:{
                	  required:" *",
                	  maxlength:"max 45 chars"
                  }
                  
                  
                 }
        });});
     function funNotify(){
    	
    		return 1;
	} 
     function funSearchLoad(){
			changeContent('colorSearch.jsp', $('#window')); 
		 }
     function funExcelBtn(){
		  $("#jqxColorSearch1").jqxGrid('exportdata', 'xls', 'Color');
	  }
</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
    <form id="frmColor" action="saveActionColor" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        <br/>
        
        <div class="section-block">
            <h2>Color Details</h2>
            
            <div class="form-row">
                <label>Color</label>
                <input type="text" name="color" id="color" value='<s:property value="color"/>'>
                
                <label>Doc No</label>
                <input type="text" name="docno" id="docno" readonly="readonly" value='<s:property value="docno"/>' tabindex="-1" style="width: 150px !important;">
            </div>

            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        </div>
    </form>

    <br/>
    <div class="section-block">
        <h2>Color Search List</h2>
        <div id="jqxColorSearch1" style="width: 100% !important;"></div>
    </div>
</div>
</body>
</html>