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

* {
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
}

#mainBG {
    background: #ffffff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ==============================
   INPUTS & FORM CONTROLS
============================== */

input[type="text"],
select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #ffffff;
    font-size: 14px;
    transition: border-color 0.2s;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

/* ==============================
   HEADER / TOP AREA
============================== */

.receipt-header {
    display: flex;
    flex-direction: column;
    margin-bottom: 16px;
    padding: 0 10px 10px;
}

.receipt-header table {
    width: 100%;
}

.receipt-header td {
    padding: 6px 4px;
    vertical-align: middle;
}

#txtStatus {
    font-size: 14px;
    font-weight: 600;
    color: #e67e22;
}

/* ==============================
   FORM LAYOUT HELPERS
============================== */

.form-row,
.single-row {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 12px;
}

.form-row label,
.single-row label {
    min-width: 120px;
    text-align: right;
}

.form-row input,
.single-row input {
    flex: 1;
}




/* ==============================
   TABLE SECTIONS
============================== */

.table-section {
    margin: 20px 0;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #ffffff;
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #e5e7eb;
}

.cr-table th,
.cr-table td {
    padding: 8px 12px;
    border-bottom: 1px solid #eef0f6;
    font-size: 14px;
}

.cr-table th {
    background: #eef0f6;
    font-weight: 600;
    color: #354B6A;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ==============================
   SCROLL AREAS
============================== */

.hidden-scrollbar {
    overflow: auto;
    height: 100vh;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 0;
}

/* ==============================
   BUTTONS
============================== */

button,
.myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #ffffff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
}

button:hover,
.myButton:hover {
    background: #0056b3;
}

/* ==============================
   ERROR LABELS
============================== */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
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

<!-- PAGE-LEVEL STYLE (BODY ONLY) -->
<style>
    fieldset {
        border: none;
        padding: 0;
        margin: 0;
    }

    legend {
        background: #e6f0ff;
        color: #0b3c8a;
        font-weight: 600;
        padding: 6px 14px;
        font-size: 14px;
        border-left: 4px solid #2b6fd6;
        width: 100%;
        box-sizing: border-box;
        margin-bottom: 10px;
    }

    .financier-section {
        background: #ffffff;
        box-shadow: 0 1px 4px rgba(0,0,0,0.08);
        border-radius: 6px;
        padding: 10px 12px 14px 12px;
    }
</style>

<form id="frmFinancier" action="saveActionFinancier" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>

<div style="width:1053px;" class="financier-section">

<fieldset>
    <legend>Financier Master</legend>

    <table width="1043">
        <tr>
            <td width="89" align="right">Date</td>
            <td width="196">
                <div id="findate" name="findate" value='<s:property value="findate"/>'></div>
            </td>
            <input type="hidden" name="hidfindate" id="hidfindate" value='<s:property value="hidfindate"/>'>

            <td colspan="2">&nbsp;</td>

            <td width="97" align="right">Doc No</td>
            <td width="313">
                <input type="text" name="docno" id="docno"
                       value='<s:property value="docno"/>'
                       readonly tabindex="-1">
            </td>
        </tr>

        <tr>
            <td align="right">Financier Code</td>
            <td>
                <input type="text" name="finid" id="finid"
                       value='<s:property value="finid"/>'>
            </td>

            <td colspan="2">&nbsp;</td>

            <td align="right">Name</td>
            <td>
                <input type="text" name="finname" id="finname"
                       value='<s:property value="finname"/>'>
            </td>
        </tr>

        <tr>
            <td align="right">Account</td>
            <td align="left">
                <input type="text" name="txtaccname" id="txtaccname"
                       value='<s:property value="txtaccname"/>'
                       style="width:99%;"
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