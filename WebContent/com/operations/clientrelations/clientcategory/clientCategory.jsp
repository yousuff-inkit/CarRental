<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryDAO"%>
<% ClsClientCategoryDAO DAO= new ClsClientCategoryDAO(); %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
MASTER UI: Compact Input Sizing (Plain Colors)
*Note: Excludes any header/center overrides so header.jsp is safe*
========================================================= */
body {
background: #f4f6f9;
font-family: Arial, sans-serif; color: #333;
font-size: 12px; margin: 0; padding: 10px;
box-sizing: border-box; overflow-x: hidden;
}

#mainBG { background: #fff; border-radius: 4px; padding: 15px; max-width: 100%; margin: auto;
box-shadow: 0 1px 4px rgba(0,0,0,0.1); box-sizing: border-box;
}

/* Master Input Heights - Set to 24px */ input[type="text"], select, textarea {
height: 24px !important; border: 1px solid #ccc; border-radius: 3px;
 
padding: 2px 6px; font-size: 12px;
box-sizing: border-box; background-color: #fff; color: #333;
}

/* Compact Width Classes */
.input-xs { width: 60px !important; }
.input-sm { width: 100px !important; }
.input-md { width: 140px !important; }
.input-lg { width: 220px !important; }
.input-xl { width: 350px !important; }
.input-full { width: 100% !important; }

input[type="text"]:focus, select:focus, textarea:focus { border-color: #007bff;
outline: none;
}

input[readonly], textarea[readonly], select:disabled, input:disabled { background-color: #f3f4f6;
color: #6b7280;
}

/* Layout Utilities */
.field-row { display: flex;
align-items: center; gap: 8px;
margin-bottom: 10px; flex-wrap: wrap;
}

.lbl-right {
text-align: right; color: #444; font-size: 12px;
font-weight: bold; white-space: nowrap; padding-right: 5px;
}

.chk-container {
 
display: flex;
align-items: center; gap: 4px;
cursor: pointer; color: #444; font-size: 12px;
font-weight: bold; white-space: nowrap;
}

.chk-container input { margin: 0;
padding: 0;
}

/* Middle Section Panels */
.middle-panel {
border: 1px solid #e1e4e8; padding: 20px 10px 10px 10px; background: #fff;
position: relative; border-radius: 4px; margin-bottom: 15px;
}

.middle-panel-title { position: absolute; top: -10px;
left: 10px; background: #fff; padding: 0 5px 0 6px; color: #0056b3;
font-weight: bold; font-size: 13px;
border-left: 3px solid #0056b3;
}

#jqxCategorySearch1 { border-radius: 4px;
border: 1px solid #d1d5db;
box-shadow: 0 1px 3px rgba(0,0,0,0.05); margin-top: 10px;
}
</style>
 
<script type="text/javascript">

/* Grid */
var data= '<%= DAO.category() %>';
$(document).ready(function () { getAccountGroup(); getconfig();
var source =
{
datatype: "json", datafields: [
{name : 'doc_no', type: 'int' },
{name : 'dtypes', type: 'String' },
{name : 'category', type: 'String' },
{name : 'cat_name', type: 'String' },
{name : 'description', type: 'String' },
{ name: 'approved', type: 'bool' },
{name : 'dtype', type: 'String' },
{ name: 'approval', type: 'int' },
{name : 'acc_group', type: 'String' }
],
localdata: data,

pager: function (pagenum, pagesize, oldpagenum) {
// callback called when a page or page size is changed.
}
};


var dataAdapter = new $.jqx.dataAdapter(source,
{
loadError: function (xhr, status, error) { alert(error);
}
}
);

$("#jqxCategorySearch1").jqxGrid(
{
width: '100%',
height: 375,
source: dataAdapter, showfilterrow: true,
 
filterable: true, selectionmode: 'singlerow', theme: 'energyblue',

 


'8%' },
 
columns: [
{ text: 'Type',columntype: 'textbox', filtertype: 'input', datafield: 'dtypes', width:

{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category',
 
width: '20%' },
{ text: 'Category Name',columntype: 'textbox', filtertype: 'input', datafield:
'cat_name', width: '34%' },
{ text: 'Account Group',columntype: 'textbox', filtertype: 'input', datafield:
'description' },
{ text: 'Approval', datafield: 'approved', columntype: 'checkbox', filterable:
false, checked: true, width: '8%',cellsalign: 'center', align: 'center' },
{ text: 'Doc No', datafield: 'doc_no', hidden: true, filterable: false, width: '10%'
 
},


'10%' },

width: '10%' },

]
});
 

{ text: 'Dtype', datafield: 'dtype', hidden: true, filterable: false, width: '10%' },
{ text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width:

{ text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true,
 




$('#jqxCategorySearch1').on('rowdoubleclick', function (event) { var rowindex1=event.args.rowindex;
getAccountGroup($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype")); document.getElementById("docno").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "doc_no"); document.getElementById("cmbtype").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "dtype"); document.getElementById("txtcategory").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "category"); document.getElementById("txtcategoryname").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "cat_name"); document.getElementById("cmbaccountgroup").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group"); document.getElementById("hidcmbaccountgroup").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "acc_group");
 
document.getElementById("hidchckapproval").value =
$("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval");

if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==1){ document.getElementById("chckapproval").checked = true;
}
else if($("#jqxCategorySearch1").jqxGrid('getcellvalue', rowindex1, "approval")==0){ document.getElementById("chckapproval").checked = false;
 


});
 
}
});
 

/* Validations */
$(function(){
$('#frmClientCategory').validate({ rules: {
cmbtype:"required", txtcategory:"required", txtcategoryname:"required", cmbaccountgroup:"required"
},
messages: { cmbtype:" *", txtcategory:" *", txtcategoryname:" *", cmbaccountgroup:" *"
}
});});

function getconfig() {
var x = new XMLHttpRequest(); x.onreadystatechange = function() {
if (x.readyState == 4 && x.status == 200) { items = x.responseText;
items = items.split('####'); if (items[0]==1)
{
$('#chckapproval').hide();
$('#appr').hide();
$('.chk-container').hide();
$('#config').val(1);
$('#jqxCategorySearch1').jqxGrid('hidecolumn','approved');
}
}
 
else {
$('#chckapproval').show();
$('#appr').show();
$('.chk-container').show();
$('#config').val(0);
$('#jqxCategorySearch1').jqxGrid('showcolumn','approved');
}
}
x.open("GET", "getconfig.jsp", true); x.send();
}

function getAccountGroup(type) { var x = new XMLHttpRequest();
x.onreadystatechange = function() {
if (x.readyState == 4 && x.status == 200) { var items = x.responseText;
items = items.split('####');
var groupItems = items[0].split(","); var groupIdItems = items[1].split(",");
var optionsgroup = '<option value="">--Select--</option>'; for (var i = 0; i < groupItems.length; i++) {
optionsgroup += '<option value="' + groupIdItems[i] + '">'
+ groupItems[i] + '</option>';
}
$("select#cmbaccountgroup").html(optionsgroup); if ($('#hidcmbaccountgroup').val() != null) {
$('#cmbaccountgroup').val($('#hidcmbaccountgroup').val());
}
} else {
}
}
x.open("GET", "getAccountGroup.jsp?type="+type, true); x.send();
}

function approval(){ if(document.getElementById("chckapproval").checked){
document.getElementById("hidchckapproval").value = 1;
}
else{
document.getElementById("hidchckapproval").value = 0;
}
}
 
function funReadOnly() { getconfig();
$('#frmClientCategory input').attr('readonly', true);
$('#frmClientCategory select').attr('disabled', true);
$('#chckapproval').attr('disabled', true);
}

function funRemoveReadOnly() { getconfig();
$('#frmClientCategory input').attr('readonly', false);
$('#frmClientCategory select').attr('disabled', false);
$('#chckapproval').attr('disabled', false);

if ($("#mode").val() == "A") {
$('#hidchckapproval').val(0); document.getElementById("chckapproval").checked = false;
}
}

function funNotify(){ return 1;
}

function funChkButton() {
/* funReset(); */
}

function funSearchLoad(){ changeContent('categoryMainSearchGrid.jsp?check=1');
}

function funFocus()
{
document.getElementById("cmbtype").focus();
}

function setValues(){

document.getElementById("cmbtype").value=document.getElementById("hidcmbtype").value; if(document.getElementById("hidchckapproval").value==1){
document.getElementById("chckapproval").checked = true;
 
}
else if(document.getElementById("hidchckapproval").value==0){ document.getElementById("chckapproval").checked = false;
}

if($('#msg').val()!=""){
$.messager.alert('Message',$('#msg').val());
}

document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
funSetlabel();
}

</script>

</head>
<body onload="setValues(); getconfig();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmClientCategory" action="saveClientCategory" method="post" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include>

<div style="padding-top: 15px;">

<div class="middle-panel">
<span class="middle-panel-title">Category Master</span>
<div style="padding-top: 5px;">

<div class="field-row">
<label class="lbl-right" style="width: 80px;">Type</label>
<select id="cmbtype" name="cmbtype" class="input-md" onchange="getAccountGroup($('#cmbtype').val());" value='<s:property value="cmbtype"/>'>
<option value="">--Select--</option>
<option value="CRM">CLIENT</option>
<option value="VND">VENDOR</option>
</select>
<input type="hidden" id="hidcmbtype" name="hidcmbtype" value='<s:property value="hidcmbtype"/>'/>

<label class="lbl-right" style="width: 80px;">Category</label>
<input type="text" id="txtcategory" name="txtcategory" class="input-lg" value='<s:property value="txtcategory"/>'>
 
<label class="lbl-right" style="width: 100px;">Category Name</label>
<input type="text" id="txtcategoryname" name="txtcategoryname" class="input-xl" value='<s:property value="txtcategoryname"/>'>
</div>

<div class="field-row">
<label class="lbl-right" style="width: 80px;">Account Group</label>
<select id="cmbaccountgroup" name="cmbaccountgroup" class="input-lg" value='<s:property value="cmbaccountgroup"/>'>
<option value="">--Select--</option>
</select>
<input type="hidden" id="hidcmbaccountgroup" name="hidcmbaccountgroup" value='<s:property value="hidcmbaccountgroup"/>'/>

<div class="chk-container" style="margin-left: 20px;">
<input type="checkbox" id="chckapproval" name="chckapproval" value="" onchange="approval();" onclick="$(this).attr('value', this.checked ? 1 : 0)">
<label id="appr" for="chckapproval" style="text-align: left; padding: 0; padding-left: 4px; margin: 0; cursor: pointer; color: #444; font-size: 12px; font-weight: bold;">Approval</label>
<input type="hidden" id="hidchckapproval" name="hidchckapproval" value='<s:property value="hidchckapproval"/>'/>
<input type="hidden" id="config" name="config"/>
</div>
</div>

</div>
</div>

<div id="jqxCategorySearch1"></div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" id="docno" name="hidtxtclientcategorydocno" value='<s:property value="hidtxtclientcategorydocno"/>'/>

</div>

</form>
</div>
</body>
</html>
