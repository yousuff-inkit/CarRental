<%@page import="com.controlcentre.masters.vehiclemaster.insurance.ClsInsuranceAction" %>
<% ClsInsuranceAction cia =new ClsInsuranceAction();%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<% String contextPath=request.getContextPath();%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ------------------------------
   GLOBAL STYLES
------------------------------ */

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1350px;
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

/* ------------------------------
   HEADER SECTION
------------------------------ */

.receipt-header {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section_row {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* ------------------------------
   FORM ROWS LAYOUT
------------------------------ */

.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size: 1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* Dual input rows (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Date/Ref/Doc row - 3 pairs */
.form-group.date-ref-doc-row {
    grid-template-columns: 80px 200px 80px 1fr 80px 200px;
    align-items: center;
    gap: 12px;
}

.form-group.date-ref-doc-row label {
    text-align: right;
    padding-right: 8px;
}

.form-group.date-ref-doc-row .date-wrapper,
.form-group.date-ref-doc-row .ref-wrapper {
    display: flex;
    align-items: center;
    gap: 8px;
}

.form-group.date-ref-doc-row #jqxDebitNoteDate {
    flex: 1;
}

.form-group.date-ref-doc-row #txtrefno {
    flex: 1;
    min-width: 120px;
}

.form-group.date-ref-doc-row .myButton {
    white-space: nowrap;
    flex-shrink: 0;
}

/* Type/AccID/AccName row */
.form-group.type-acc-row {
    grid-template-columns: 120px 120px 120px 200px 1fr;
    align-items: center;
    gap: 12px;
}

.form-group.type-acc-row label {
    text-align: right;
    padding-right: 8px;
}

/* Full width description row */
.form-row.full-row {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.form-row.full-row label {
    text-align: right;
    padding-right: 8px;
    font-weight: 600;
    color: #253858;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */

.table-section {
    margin: 20px 0;
}

.table-section h3 {
    color: #253858;
    font-size: 1.05rem;
    font-weight: 600;
    margin-bottom: 12px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
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

/* ------------------------------
   SCROLL AREAS
------------------------------ */

.hidden-scrollbar {
    overflow: auto;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 10px;
}

/* ------------------------------
   BUTTONS
------------------------------ */

button, .myButton {
    background: #007bff;
    border: none;
    padding: 6px 16px;
    color: #fff;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    transition: background 0.2s;
    font-size: 13px;
}

button:hover, .myButton:hover {
    background: #0056b3;
}

/* ------------------------------
   ERROR LABELS
------------------------------ */

#validrate,
#validrate1 {
    color: red;
    font-size: 12px;
    grid-column: 2 / -1;
}

/* ------------------------------
   APPROVAL TABLE
------------------------------ */

#approval-table td {
    font-size: 14px;
    padding: 8px;
}

#approval-table tr:nth-child(even) {
    background: #f9fafb;
}
</style>
<script type="text/javascript">
      $(document).ready(function () {          
          $("#insurdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"}); 
          $('#accountWindow').jqxWindow({width: '51%', height: '61%',  maxHeight: '61%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#accountWindow').jqxWindow('close');
		  
		    document.getElementById("formdet").innerText="Insurance(VIS)";
			document.getElementById("formdetail").value="Insurance";
			document.getElementById("formdetailcode").value="VIS";
			window.parent.formCode.value="VIS";
			window.parent.formName.value="Insurance";
		  var data1= '<%=cia.searchDetails() %>';
             
             var num = 0; 
             var source =
             {
                 datatype: "json",
                 datafields: [
                           	{name : 'doc_no' , type: 'number' },
      						{name : 'inname', type: 'String'  },
                           	{name : 'date', type: 'date'  },
                           	{name : 'description',type:'String'},
                           	{name : 'acc_no',type:'String'}
                           	
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
        
             $("#jqxInsuranceSearch1").jqxGrid(
                     {
                     	width: '100%',
                         height: 350,
                         source: dataAdapter,
                         showfilterrow: true,
                         filterable: true,
                         selectionmode: 'singlerow',
                         //pagermode: 'default',
                         sortable: true,
                        // pageable: true,
                         altrows:true,
                         //Add row method
                         columns: [
 							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
 					{ text: 'Insurance', datafield: 'inname', width: '50%' },
 					{text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},
 					{text: 'Account',datafield:'description',width:'20%'},
 					{text: 'Acc No',datafield:'acc_no',width:'20%',hidden:true}
         			  ]
                     });
             $('#jqxInsuranceSearch1').on('rowdoubleclick', function (event) 
             		{ 
 		            	var rowindex1=event.args.rowindex;
 		                document.getElementById("docno").value= $('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
 		                document.getElementById("insurcompany").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "inname");
 		                $("#insurdate").jqxDateTimeInput('val',$("#jqxInsuranceSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
 						document.getElementById("txtaccname").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "description");
 						document.getElementById("txtaccno").value=$('#jqxInsuranceSearch1').jqxGrid('getcellvalue', rowindex1, "acc_no");
             		 }); 
      }); 

             function accountSearchContent(url) {
       		  $('#accountWindow').jqxWindow('open');
       			 $.get(url).done(function (data) {
       				// alert(data);
       			$('#accountWindow').jqxWindow('setContent', data);
       		}); 
       		}
            function funSearchdblclick(){
            	var dtype="VIS";
              	 //alert("here");
       		//  $('#txtaccname').dblclick(function(){
       			   var url=document.URL;
			     var reurl=url.split("/com/");
				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
       			//  });  
       	}
           function getAcc(event){
        	   var dtype="VIS";
                var x= event.keyCode;
                if(x==114){
              	 //alert("here");
                	 var url=document.URL;
    			     var reurl=url.split("/com/");
    				  	  accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchAP.jsp?dtype='+dtype);
                }
                else{
                 }
                }
	function funReadOnly() {
		$('#frmInsurance input').attr('readonly', true);
		 $('#insurdate').jqxDateTimeInput({ disabled: true}); 
	}
	function funRemoveReadOnly() {
		$('#frmInsurance input').attr('readonly', false);
		$('#insurdate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#insurcompany').attr('readonly', true);
	}
	function setValues() {
		 if($('#insurdatehidden').val()){
				$("#insurdate").jqxDateTimeInput('val', $('#insurdatehidden').val());
			}
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }

	}
	function funSearchLoad(){
		changeContent('insuranceSearch.jsp', $('#window')); 
	 }
	 function funFocus()
	    {
	    	document.getElementById("insurcompany").focus();
	    		
	    }
	    $(function(){
	        $('#frmInsurance').validate({
	                 rules: {
	                 insurcompany:{
	                	 required:true,
	                	 maxlength:40
	                 }, 
	                txtaccname:{
	                	required:true
	                	}
	                
	                 },
	                 messages: {
	                  insurcompany:{
	                	  required:" *",
	                	  maxlength:"max 40 chars"
	                  },
	                  txtaccname:{
	                	  required:" *"
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
			  $("#jqxInsuranceSearch1").jqxGrid('exportdata', 'xls', 'Insurance');
		  }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmInsurance" action="saveActionInsurance"  autocomplete="off">
	<jsp:include page="../../../../header.jsp" />
	<br/> 
	<div  class='receipt-header'>
	<fieldset>
    <legend>Insurance Details</legend>

    <!-- ROW 1 -->
    <div class="form-group dual-input">
        <label>Date</label>
        <div id="insurdate" name="insurdate"
             value='<s:property value="insurdate"/>'></div>

        <label>Doc No</label>
        <input type="text" name="docno" id="docno"
               value='<s:property value="docno"/>' readonly tabindex="-1">
    </div>

    <!-- ROW 2 -->
    <div class="form-group dual-input">
        <label>Account</label>
        <input type="text" name="txtaccname" id="txtaccname"
               value='<s:property value="txtaccname"/>'
               ondblclick="funSearchdblclick();"
               onkeydown="getAcc(event);"
               placeholder="Press F3 to Search">

        <label>Company</label>
        <input type="text" name="insurcompany" id="insurcompany"
               value='<s:property value="insurcompany"/>'>
    </div>

    <!-- ✅ HIDDEN FIELDS (UNCHANGED) -->
    <input type="hidden" name="txtaccno" id="txtaccno"
           value='<s:property value="txtaccno"/>'>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="msg" name="msg"
           value='<s:property value="msg"/>'/>

    <input type="text" name="deleted" id="deleted"
           value='<s:property value="deleted"/>' hidden="true"/>

    <input type="hidden" id="insurdatehidden" name="insurdatehidden"
           value='<s:property value="insurdatehidden"/>'/>
</fieldset>
</div>
</form>
<br/>
<div id="jqxInsuranceSearch1"></div>
<%-- <div id="window">
	<div id="windowHeader" class="windowHead">
		<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Search</span>
	</div>
	<div id="windowContent" class="windowCont" style="overflow: hidden;">
		<jsp:include page="insuranceSearch.jsp"></jsp:include>
	</div></div>
</div>
	<div id="accountWindow">
	<div class="windowsHead">
	<span> <img src="../../../../icons/search_new.png" alt="" style="margin-right: 15px" />Accounts
	</span>
	</div>
	<div class="windowsCont">
	<jsp:include page="../../../search/accountsearch/accountsSearchAP.jsp"></jsp:include>
	</div>
	 </div>  --%> 
	  <div id="accountWindow">
				<div></div><div></div>
				</div> 

</body>
</html>