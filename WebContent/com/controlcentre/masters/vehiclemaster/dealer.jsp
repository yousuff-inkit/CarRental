<%@page import="com.controlcentre.masters.vehiclemaster.dealer.ClsDealerAction" %>
<%ClsDealerAction cda=new ClsDealerAction(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Dealer Master</title>
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
        font-size: 1.1rem;
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

    .form-row.double-input {
        /* Layout for Acc. No. and Account Name (spans 3 columns) */
        grid-template-columns: 120px 150px 1fr 120px 1fr; 
    }
    .form-row.dealer-row {
        /* Layout for Acc. No. row: Label | Acc No | Dealer Label | Dealer Input */
        grid-template-columns: 120px 300px 120px 1fr;
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
    
    /* FIX: JQ Date Picker size and alignment */
    .jqx-datetimeinput-container {
         height: 32px;
         width: 100% !important;
    }
    #dealerdate {
        height: 32px !important;
        width: 100% !important;
        line-height: 32px !important;
    }
    .jqx-datetimeinput {
        height: 32px !important;
        line-height: 32px !important;
    }


    /* JQWigets/Grid Styling */
    #jqxDealerSearch1 {
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
      $(document).ready(function () {          
    	  $("#dealerdate").jqxDateTimeInput({ width : '100%', height : '32px', formatString : "dd.MM.yyyy" });  
    	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		  document.getElementById("formdet").innerText="Dealer(VDR)";
		  document.getElementById("formdetail").value="Dealer";
		  document.getElementById("formdetailcode").value="VDR";
		  window.parent.formCode.value="VDR";
		  window.parent.formName.value="Dealer";
 		 var data1= '<%=cda.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'DOC_NO' , type: 'int' },
      						{name : 'name', type: 'String'  },
                           	{name : 'acc_no', type: 'String'  },
                           	{name : 'date',type:'date'},
                           	{name : 'description',type:'string'}
                           	
                  ],
                  localdata: data1,
                 
                 
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
           
             $("#jqxDealerSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 315,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         sortable: true,
                         altrows:true,
                         columns: [
         					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
         					{ text: 'Dealer',columntype: 'textbox', filtertype: 'input', datafield: 'name', width: '30%' },
         					{ text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
         					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
         					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
         					]
                     });

             $('#jqxDealerSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxDealerSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
 		                document.getElementById("dealername").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "name");
 		                $("#dealerdate").jqxDateTimeInput('val',$("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 		                document.getElementById("txtaccname").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "description");
 		                document.getElementById("txtaccno").value = $("#jqxDealerSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
             		 });           		 
           		 });
      function accountSearchContent(url) {
		  $('#accountWindow').jqxWindow('open');
			 $.get(url).done(function (data) {
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
     function funSearchdblclick(){
       	 var dtype="VDR";
			  var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
	}
    function getAcc(event){
     	 var dtype="VDR";
         var x= event.keyCode;
         if(x==114){
        	 var url=document.URL;
		     var reurl=url.split("/com/");
			  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
         }
         else{
          }
         }
      function funSearchLoad(){
			changeContent('dealerSearch.jsp', $('#window')); 
		 }
	function funReadOnly() {
		$('#frmDealer input').attr('readonly', true);
		 $('#dealerdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmDealer input').attr('readonly', false);
		 $('#dealerdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#dealername').attr('readonly', true);
	}
	 function setValues(){	
		    if($('#dealerdatehidden').val()){
				$("#dealerdate").jqxDateTimeInput('val', $('#dealerdatehidden').val());
			}
			
		    if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }

			}
		    function funFocus()
		    {
		    	document.getElementById("dealername").focus();
		    		
		    }
		    $(function(){
		    
		        $('#frmDealer').validate({
		                 rules: {
		                 dealername:{
		                	 required:true,
		                	 maxlength:45
		                 } 
		             
		                
		                 },
		                 messages: {
		                  dealername:{
		                	  required:" *",
		                	  maxlength:"max 45 chars"
		                  }
		              
		                 }
		        });
		        });
		     function funNotify(){
		    		//alert($('#txtaccname').val());	 
		    		if(document.getElementById("txtaccname").value==''){
		    			document.getElementById("errormsg").innerText="A/c is Mandatory";
		    		return 0;
		    		}
		    		else{
		    			document.getElementById("errormsg").innerText="";
		    		}
		    		return 1;
			} 
		     function funExcelBtn(){
				  $("#jqxDealerSearch1").jqxGrid('exportdata', 'xls', 'Dealer');
			  }
</script>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDealer" action="saveActionDealer" autocomplete="off" >
	<jsp:include page="../../../../header.jsp" />
	
    <div class="section-block">
        <h2>Dealer Details</h2>
        
        <div class="form-row">
            <label>Date</label>
            <div class="jqx-datetimeinput-container">
                <div id="dealerdate" name="dealerdate" value='<s:property value="dealerdate"/>'></div>
            </div>

            <label>Doc No</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>
        
        <div class="form-row double-input">
            <label>Acc. No.</label>
            
            <input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' style="width: 100%;" readonly tabindex="-1">
            <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' style="width: 100%;" ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" readonly placeholder="Press F3 to Search" required>
            
            <label>Dealer</label>
            <input type="text" name="dealername" id="dealername" value='<s:property value="dealername"/>'>
        </div>

        <input type="hidden" id="dealerdatehidden" name="dealerdatehidden" value='<s:property value="dealerdatehidden"/>'>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxDealerSearch1"></div>
</div>

<div id="accountWindow">
    <div></div><div></div>
</div>
</body>
</html>