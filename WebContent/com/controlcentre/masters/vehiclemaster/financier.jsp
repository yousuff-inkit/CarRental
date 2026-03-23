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
    max-width: 100%; /* Master UI Requirement */
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
    margin-bottom: 25px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff; /* Signature Blue Line */
    color: #333;
    display: block;
}

/* ------------------------------
    FORM GRID SYSTEM
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
    font-size: 16px;
}

/* JQX Widget Overrides */
.jqx-datetimeinput {
    height: 32px !important;
    width: 100% !important;
}

.hidden-scrollbar {
    overflow-y: auto;
    height: 530px;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
}

form label.error {
    color:red;
    font-weight:bold;
    font-size: 12px;
}


#formdet {
    text-align: left !important;
    display: block;
}
.section-block legend {
    position: relative;
    padding-left: 12px;
}

.section-block legend::before {
    content: "";
    position: absolute;
    left: 0;
    top: 4px;
    height: 18px;
    width: 4px;
    background: #007bff;
}
fieldset legend {
    border-left: 4px solid #007bff;
    padding-left: 8px;
    font-weight: 600;
}

</style>
<script type="text/javascript">
      $(document).ready(function () {  
    	  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
    	  $("#findate").jqxDateTimeInput({ width : '125px', height : '15px', formatString : "dd.MM.yyyy" });
    	  
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
       						{name : 'fname', type: 'String'  },
       						{name : 'fid',type:'String'},
                            	{name : 'date', type: 'date'  },
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
                          //pagermode: 'default',
                          sortable: true,
                          //pageable: true,
                          altrows:true,
                          //Add row method
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
		//  $('#txtaccname').dblclick(function(){
			   var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchGL.jsp?dtype='+dtype);
			//  });  
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
      /*  function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
  	    $('#accountWindow').jqxWindow('focus');
		 }
		 else{
			 }
		 } */

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
		    		/* 	//document.getElementById("txtaccname").focus;
		    			$('#txtaccname').focus();
*/		    		return 0;
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
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">

<form id="frmFinancier" action="saveActionFinancier" autocomplete="off">

<jsp:include page="../../../../header.jsp" />

<!-- Date + Doc No Row -->
<div style="display:flex; align-items:center; width:100%; margin:10px 0;">

    <label style="margin-right:8px;">Date</label>

    <div style="width:130px;">
        <div id="findate" name="findate" value='<s:property value="findate"/>'></div>
    </div>

    <input type="hidden"
           name="hidfindate"
           id="hidfindate"
           value='<s:property value="hidfindate"/>'>

    <label style="margin-left:auto; margin-right:8px;">Doc No</label>

    <input type="text"
           name="docno"
           id="docno"
           value='<s:property value="docno"/>'
           readonly
           tabindex="-1"
           style="width:120px;">
</div>


<div class="financier-section">

<fieldset>
<legend>Financier Master</legend>

<table width="100%">

<tr>
    <td width="12%" align="right">Financier Code</td>
    <td width="25%">
        <input type="text"
               name="finid"
               id="finid"
               value='<s:property value="finid"/>'
               style="width:90%;">
    </td>

    <td width="12%" align="right">Name</td>
    <td width="30%">
        <input type="text"
               name="finname"
               id="finname"
               value='<s:property value="finname"/>'
               style="width:90%;">
    </td>
</tr>

<tr>
    <td align="right">Account</td>
    <td colspan="3">
        <input type="text"
               name="txtaccname"
               id="txtaccname"
               value='<s:property value="txtaccname"/>'
               style="width:60%;"
               ondblclick="funSearchdblclick();"
               onkeydown="getAcc(event);"
               placeholder="Press F3 to Search">
    </td>
</tr>

</table>

<input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'>
<input type="hidden" id="mode" name="mode">
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true">

</fieldset>

</div>
</form>

<br/>

<div id="jqxFinancierSearch1"></div>

<div id="accountWindow">
    <div></div>
    <div></div>
</div>

</div>
</body>
</html>