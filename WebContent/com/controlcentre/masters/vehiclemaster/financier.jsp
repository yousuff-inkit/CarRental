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
    max-width: 1450px;
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

/* ------------------------------
   FORM ROWS LAYOUT (FIXED)
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
    font-size:1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* For rows with multiple input pairs (Currency/Rate, Amount/Base Amount) */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}
.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Special case: One label with two equal-width inputs */
.form-group.single-label-dual-input {
    grid-template-columns: 120px 1fr 1fr;
}

.form-group.single-label-dual-input input[type="text"]:first-of-type {
    width: 100%;
}

.form-group.single-label-dual-input input[type="text"]:nth-of-type(2) {
    width: 100%;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 30px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
}

/* Special handling for the "to-account-row" - all items in one line */
.to-account-row {
    display: grid;
    grid-template-columns: 120px 110px 120px 140px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.to-account-row label {
    text-align: right;
    padding-right: 8px;
}

.to-account-row #cmbtotype {
    width: 100%;
}

.to-account-row #txttoaccid {
    width: 100%;
}

.to-account-row #txttoaccname {
    width: 100%;
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
    height: 530px;
}

/* Hide scrollbars (but allow scrolling) */
.hidden-scrollbar::-webkit-scrollbar {
    width: 0px;
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
.form-row {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 12px;
}

.form-row label {
    min-width: 120px;
    text-align: right;
}

.form-row input {
    flex: 1;
}

.single-row {
    display: flex;
    align-items: center;
    gap: 20px;
    margin-bottom: 12px;
}

.single-row label {
    min-width: 120px;
}

</style>
<script type="text/javascript">
� � � $(document).ready(function () {��
� � 	� $('#accountWindow').jqxWindow({width: '51%', height: '58%',� maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true});
		� $('#accountWindow').jqxWindow('close');
� � 	� $("#findate").jqxDateTimeInput({ width : '100%', height : '32px', formatString : "dd.MM.yyyy" }); // Adjusted size
� � 	��
� � 	� document.getElementById("formdet").innerText="Financier(VFI)";
		� document.getElementById("formdetail").value="Financier";
		� document.getElementById("formdetailcode").value="VFI";
		� window.parent.formCode.value="VFI";
		� window.parent.formName.value="Financier";
� � 	� var data1= '<%=cfa.searchDetails() %>';
� � � � � � ��
� � � � � � � var num = 0;�
� � � � � � � var source =
� � � � � � � {
� � � � � � � � � datatype: "json",
� � � � � � � � � datafields: [
� � � � � � � � � � � � � � 	{name : 'DOC_NO' , type: 'number' },
� � � �						{name : 'fname', type: 'String'� },
� � � �						{name : 'fid',type:'String'},
� � � � � � � � � � � � � � 	{name : 'date', type: 'date'� },
� � � � � � � � � � � � � � 	{name : 'acc_no',type:'String'},
� � � � � � � � � � � � � � 	{name : 'description',type:'String'}
� � � � � � � � � �],
� � � � � � � � � �localdata: data1,
� � � � � � � � � pager: function (pagenum, pagesize, oldpagenum) {
� � � � � � � � � � � // callback called when a page or page size is changed.
� � � � � � � � � }
� � � � � � � };
� � � � � � ��
� � � � � � � var dataAdapter = new $.jqx.dataAdapter(source,
� � � � � � � 		 {
� � � � � � � � � 		loadError: function (xhr, status, error) {
� 	� � � � � � � � � � alert(error);� ��
� 	� � � � � � � � � � }
� 		� � � � � � }		
� � � � � � � );
� � � � � �
� � � � � � � $("#jqxFinancierSearch1").jqxGrid(
� � � � � � � � � � � {
� � � � � � � � � � � 	width: '100%',
� � � � � � � � � � � � � height: 350,
� � � � � � � � � � � � � source: dataAdapter,
� � � � � � � � � � � � � showfilterrow: true,
� � � � � � � � � � � � � filterable: true,
� � � � � � � � � � � � � selectionmode: 'singlerow',
� � � � � � � � � � � � � sortable: true,
� � � � � � � � � � � � � altrows:true,
� � � � � � � � � � � � � columns: [
� � � � � 					{ text: 'Doc No',filtertype: 'number', datafield: 'DOC_NO', width: '10%' },
� � � � � 					{ text: 'F ID',columntype:'textbox', filtertype:'input',datafield:'fid',width:'10%',hidden:true},
� � � � � 					{ text: 'Financier',columntype: 'textbox', filtertype: 'input', datafield: 'fname', width: '30%' },
� � � � � 					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy' },
� � � � � 					{ text: 'Acc No',columntype: 'textbox', filtertype: 'input', datafield: 'acc_no', width: '20%',hidden:true },
� � � � � 					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '40%' },
� � � � � 					]
� � � � � � � � � � � });
� � � � � � � $('#jqxFinancierSearch1').on('rowdoubleclick', function (event)�
� � � � � � � 		{�
� 		� � � � � � 	var rowindex1=event.args.rowindex;
� 		� � � � � � � � document.getElementById("docno").value= $('#jqxFinancierSearch1').jqxGrid('getcellvalue', rowindex1, "DOC_NO");�
� 		� � � � � � � � document.getElementById("finid").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "fid");
� 		� � � � � � � � document.getElementById("finname").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "fname");
� 		� � � � � � � � $("#findate").jqxDateTimeInput('val',$("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "date"));
� 		� � � � � � � � document.getElementById("txtaccname").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "description");
� 		� � � � � � � � document.getElementById("txtaccno").value = $("#jqxFinancierSearch1").jqxGrid('getcellvalue', rowindex1, "acc_no");
� � � � � � � 		 });
� � � ��
� � � � � � 		 });
� � � function accountSearchContent(url) {
		� $('#accountWindow').jqxWindow('open');

			 $.get(url).done(function (data) {
				�
			$('#accountWindow').jqxWindow('setContent', data);
		});�
		}
� � � function funSearchdblclick(){
� � 	� var dtype="VFI";�
		//� $('#txtaccname').dblclick(function(){
			� �var url=document.URL;
			� � �var reurl=url.split("/com/");
				� 	� accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchGL.jsp?dtype='+dtype);
			//� });��
	}
� � �function getAcc(event){
� � 	 var dtype="VFI";
� � � � � var x= event.keyCode;
� � � � � if(x==114){
� � � � 	�
� � � � 	� var url=document.URL;
			� � �var reurl=url.split("/com/");
				� 	� accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsSearchGL.jsp?dtype='+dtype);
� � � � � }
� � � � � else{
� � � � � �}
� � � � � }
� � � function funSearchLoad(){
� 		changeContent('financierSearch.jsp', $('#window'));�
� 	 }
	function funReadOnly() {
		$('#frmFinancier input').attr('readonly', true);
		 $('#findate').jqxDateTimeInput({ disabled: true});�
	}
	function funRemoveReadOnly() {
		$('#frmFinancier input').attr('readonly', false);
		 $('#findate').jqxDateTimeInput({ disabled: false});�
		$('#docno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
		$('#finname').attr('readonly', true);
	}
	
	 function setValues(){	
		� � if($('#hidfindate').val()){
				$("#findate").jqxDateTimeInput('val', $('#hidfindate').val());
			}
		� � if($('#msg').val()!=""){
				� �$.messager.alert('Message',$('#msg').val());
				� }

			}
		� � function funFocus()
		� � {
		� � 	document.getElementById("finid").focus();
		� � 		
		� � }
		� � $(function(){
		� � � � $('#frmFinancier').validate({
		� � � � � � � � �rules: {
		� � � � � � � � �finid:{
		� � � � � � � � 	 required:true,
		� � � � � � � � 	 maxlength:8
		� � � � � � � � �},�
		� � � � � � � � �txtaccname:{
		� � � � � � � � 	required:true
		� � � � � � � � 	},
		� � � � � � � � 	finname:{
		� � � � � � � � 		maxlength:40
		� � � � � � � � 	}
		� � � � � � � ��
		� � � � � � � � �},
		� � � � � � � � �messages: {
		� � � � � � � � 	 finid:{
		� � � � � � � � 	� required:" *",
		� � � � � � � � 	� maxlength:"max 8 chars"
		� � � � � � � � � },
		� � � � � � � � � txtaccname:{
		� � � � � � � � 	� required:" *"
		� � � � � � � � � },
		� � � � � � � � � finname:{
		� � � � � � � � 	� maxlength:"max 40 chars"
		� � � � � � � � � }
		� � � � � � � � �}
		� � � � });});
		� � �function funNotify(){
		� � 	 if(document.getElementById("txtaccname").value==''){
		� � 			document.getElementById("errormsg").innerText="A/c is Mandatory";
		� � 		return 0;
		� � 		}
		� � 		else{
		� � 			document.getElementById("errormsg").innerText="";
		� � 		}
		� � 		return 1;
			}�
		� � �function funExcelBtn(){
				� $("#jqxFinancierSearch1").jqxGrid('exportdata', 'xls', 'Financier');
			� }
</script>


</head>
<body onload="setValues();" >
<div id="mainBG" class=" hidden-scrollbar homeContent" data-type="background">
<form id="frmFinancier" action="saveActionFinancier" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/> 
<div style="100%;">
<fieldset>
    <legend>Financier Master</legend>
<div class="section-block">
<div class="form-group dual-input">
    <label>Date</label>
    <div id="findate" name="findate" value='<s:property value="findate"/>'></div>
    <input type="hidden" name="hidfindate" id="hidfindate" value='<s:property value="hidfindate"/>'>
    <label>Doc No</label>
    <input type="text" name="docno" id="docno"  value='<s:property value="docno"/>' readonly tabindex="-1">
  </div>
  <div class="form-group dual-input">
    <label>Financier Code</label>
    <input type="text" name="finid" id="finid" value='<s:property value="finid"/>'>
    <label>Name</label>
    <input type="text" name="finname"  id="finname" value='<s:property value="finname"/>'>
  </div>
  <div class="form-group ">
  <label>Account</label>
  <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>'  ondblclick="funSearchdblclick();" onkeydown="getAcc(event);" placeholder="Press F3 to Search" > 
  </div>
</div>
<input type="hidden" id="txtaccno" name="txtaccno" value='<s:property value="txtaccno"/>'> 
<input type="hidden" id="mode" name="mode"/>
				        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

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
        <input type="hidden" id="msg" name="msg"� value='<s:property value="msg"/>'/>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
    </div>
</form>

<div style="padding: 0 20px;">
    <div id="jqxFinancierSearch1"></div>
</div>
�
<div id="accountWindow">
    <div></div><div></div>
</div>
</div>
</body>
</html>