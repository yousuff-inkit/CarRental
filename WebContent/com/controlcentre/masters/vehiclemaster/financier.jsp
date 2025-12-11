<%@page import="com.controlcentre.masters.vehiclemaster.financier.ClsFinancierAction" %>
<%ClsFinancierAction cfa=new ClsFinancierAction(); %>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i) - Financier Master</title>
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
        /* Layout: Label | Input/Date | Label | Input */
        grid-template-columns: 120px 1fr 120px 1fr; 
        gap: 15px 30px;
        align-items: center;
        margin-bottom: 12px;
    }
    
    .form-row.code-name {
        grid-template-columns: 120px 150px auto 120px 1fr;
    }
    .form-row.account {
        grid-template-columns: 120px 1fr 1fr; 
    }
    .form-row.account input[type="text"] {
        grid-column: 2 / span 2;
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
        transition: border-color 0.2s, box-shadow 0.2s;
        font-size: 14px;
        box-sizing: border-box;
        width: 100%;
    }
    
    /* FIX: BLUE HOVER EFFECT */
    input[type="text"]:focus, select:focus,
    .jqx-datetimeinput:hover,
    input[type="text"]:not([readonly]):hover {
        border-color: #007bff; /* Blue Border */
        box-shadow: 0 0 0 1px #007bff; /* Light blue glow/shadow */
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
    
    form label.error {
        color:red;
        font-weight:bold;
        font-size: 12px;
    }
    
    /* JQ Date Picker size and alignment */
    .jqx-datetimeinput-container {
         height: 32px;
    }
    #findate {
        height: 32px !important;
        width: 100% !important;
        line-height: 32px !important;
    }
    .jqx-datetimeinput {
        height: 32px !important;
        line-height: 32px !important;
    }


    /* JQWigets/Grid Styling */
    #jqxFinancierSearch1 {
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
    	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
    	  $("#findate").jqxDateTimeInput({ width : '100%', height : '32px', formatString : "dd.MM.yyyy" }); // Adjusted size
    	  
    	  document.getElementById("formdet").innerText="Financier(VFI)";
		  document.getElementById("formdetail").value="Financier";
		  document.getElementById("formdetailcode").value="VFI";
		  window.parent.formCode.value="VFI";
		  window.parent.formName.value="Financier";
    	  var data1= '<%=cfa.searchDetails() %>';
              
              var num = 0; 
              var source =
              {
                  datatype: "json",
                  datafields: [
                            	{name : 'DOC_NO' , type: 'number' },
       						{name : 'fname', type: 'String'  },
       						{name : 'fid',type:'String'},
                            	{name : 'date', type: 'date'  },
                            	{name : 'acc_no',type:'String'},
                            	{name : 'description',type:'String'}
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
           
              $("#jqxFinancierSearch1").jqxGrid(
                      {
                      	width: '100%',
                          height: 350,
                          source: dataAdapter,
                          showfilterrow: true,
                          filterable: true,
                          selectionmode: 'singlerow',
                          sortable: true,
                          altrows:true,
                          columns: [
          					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
          					{ text: 'F ID',columntype:'textbox', filtertype:'input',datafield:'fid',width:'10%',hidden:true},
          					{ text: 'Financier',columntype: 'textbox', filtertype: 'input', datafield: 'fname', width: '30%' },
          					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
          					{ text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
          					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
          					]
                      });
              $('#jqxFinancierSearch1').on('rowdoubleclick', function (event) 
              		{ 
  		            	var rowindex1=event.args.rowindex;
  		                document.getElementById("docno").value= $('#jqxFinancierSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
  		                document.getElementById("finid").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "fid");
  		                document.getElementById("finname").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "fname");
  		                $("#findate").jqxDateTimeInput('val',$("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
  		                document.getElementById("txtaccname").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "description");
  		                document.getElementById("txtaccno").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
              		 });
        
            		 });
      function accountSearchContent(url) {
		  $('#accountWindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				 
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
      function funSearchdblclick(){
    	  var dtype="VFI"; 
		//  $('#txtaccname').dblclick(function(){
			   var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchGL.jsp?dtype='+dtype);
			//  });  
	}
     function getAcc(event){
    	 var dtype="VFI";
          var x= event.keyCode;
          if(x==114){
        	 
        	  var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchGL.jsp?dtype='+dtype);
          }
          else{
           }
          }
      function funSearchLoad(){
  		changeContent('financierSearch.jsp', $('#window')); 
  	 }
	function funReadOnly() {
		$('#frmFinancier input').attr('readonly', true);
		 $('#findate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmFinancier input').attr('readonly', false);
		 $('#findate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#finname').attr('readonly', true);
	}
	
	 function setValues(){	
		    if($('#hidfindate').val()){
				$("#findate").jqxDateTimeInput('val', $('#hidfindate').val());
			}
		    if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }

			}
		    function funFocus()
		    {
		    	document.getElementById("finid").focus();
		    		
		    }
		    $(function(){
		        $('#frmFinancier').validate({
		                 rules: {
		                 finid:{
		                	 required:true,
		                	 maxlength:8
		                 }, 
		                 txtaccname:{
		                	required:true
		                	},
		                	finname:{
		                		maxlength:40
		                	}
		                
		                 },
		                 messages: {
		                	 finid:{
		                	  required:" *",
		                	  maxlength:"max 8 chars"
		                  },
		                  txtaccname:{
		                	  required:" *"
		                  },
		                  finname:{
		                	  maxlength:"max 40 chars"
		                  }
		                 }
		        });});
		     function funNotify(){
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
				  $("#jqxFinancierSearch1").jqxGrid('exportdata', 'xls', 'Financier');
			  }
</script>


</head>
<body onload="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmFinancier" action="saveActionFinancier" autocomplete="off">
<jsp:include page="../../../../header.jsp" />
    
    <div class="section-block">
        <h2>Financier Master</h2>
        
        <div class="form-row">
            <label>Date</label>
            <div class="jqx-datetimeinput-container">
                <div id="findate" name="findate" value='<s:property value="findate"/>'></div>
            </div>
            <input type="hidden" name="hidfindate" id="hidfindate" value='<s:property value="hidfindate"/>'>

            <label>Doc No</label>
            <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>
        
        <div class="form-row code-name">
            <label>Financier Code</label>
            <input type="text" name="finid" id="finid" value='<s:property value="finid"/>'>
            
            <div></div> <label>Name</label>
            <input type="text" name="finname" id="finname" value='<s:property value="finname"/>'>
        </div>
        
        <div class="form-row account">
            <label>Account</label>
            <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" >
            
            <input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'>
        </div>

        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxFinancierSearch1"></div>
</div>
 
<div id="accountWindow">
    <div></div><div></div>
</div>
</div>
</body>
</html>