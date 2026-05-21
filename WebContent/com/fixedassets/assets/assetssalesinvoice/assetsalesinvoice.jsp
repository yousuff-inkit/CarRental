<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<style type="text/css">
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #222;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 12px;
    padding: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

/* Scrollable Container */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 40px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

table {
    border-collapse: separate;
    border-spacing: 0 8px; 
}

td {
    padding: 2px 5px;
    font-size: 12px;
    vertical-align: middle;
}

td[align="right"] {
    font-weight: bold;
    color: #444;
    white-space: nowrap;
    padding-right: 5px;
}

input[type="text"], 
select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 4px;
    padding: 2px 4px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    transition: all 0.2s;
}

input[type="text"]:focus, 
select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

input[readonly] {
    background-color: #f8f9fa;
    color: #666;
}

fieldset {
    border: 1px solid #c5d3e0;
    border-radius: 8px;
    padding: 5px;
    background: #fdfdfd;
    margin-bottom: 10px;
}

.myButton {
    height: 28px !important;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 4px;
    font-weight: bold;
    font-size: 11px;
    cursor: pointer;
    text-transform: uppercase;
    transition: 0.3s;
}
.myButton:hover { 
    background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%);
    box-shadow: 0 2px 8px rgba(37, 99, 235, 0.3);
}

.myButton:disabled {
    background: #ccc;
    cursor: not-allowed;
}

button.icon {
    background: transparent;
    border: 1px solid #e1e4e8;
    border-radius: 4px;
    cursor: pointer;
    padding: 3px;
    transition: background 0.2s;
}
button.icon:hover { background: #f0f3f5; }
button.icon img { width: 20px; height: 20px; }

#divMCPGrid {
    border: 1px solid #c5d3e0;
    border-radius: 6px;
    overflow: hidden;
    margin-top: 10px;
}

#errormsg, #validrate {
    color: #d93025;
    font-size: 11px;
    font-weight: bold;
    display: block;
    padding-top: 2px;
}

.jqx-datetimeinput {
    height: 24px !important;
}

legend {
    font-size: 14px;
    font-weight: bold;
    padding: 0 10px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
        border-left: 3px solid #0b45a2;
    line-height: 1.2;
    margin-bottom: 5px;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
    // Disable Approval button
    $('#btnApprove, #btnApproval').prop('disabled', true)
        .css({'pointer-events': 'none', 'opacity': '0.5'});

	 $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#assetwindow').jqxWindow({ width: '30%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Asset Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#assetwindow').jqxWindow('close');
	   
	   
$("#date").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#fromdate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$("#todate").jqxDateTimeInput({
	width : '125px',
	height : '15px',
	formatString : "dd.MM.yyyy"
});
$('#client').dblclick(function(){
    $('#clientwindow').jqxWindow('open');
$('#clientwindow').jqxWindow('focus');
clientSearchContent('masterClientSearch.jsp');
});
});
function getClient(event){
	 var x= event.keyCode;
     if(x==114){
    	 $('#clientwindow').jqxWindow('open');
    	 $('#clientwindow').jqxWindow('focus');
    	 clientSearchContent('masterClientSearch.jsp');
     }
     else{
      }
}
function funSearchLoad(){
	 changeContent('mainSearch.jsp', $('#window')); 
}
function clientSearchContent(url) {
      $.get(url).done(function (data) {
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function assetSearchContent(url) {
      $.get(url).done(function (data) {
    $('#assetwindow').jqxWindow('setContent', data);

}); 
}

function detailSearchContent(url) {
      $.get(url).done(function (data) {
    $('#detailwindow').jqxWindow('setContent', data);

}); 
}
function funChkButton(){
	
}
function funReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: true}); 
	 $('#assetInvoiceGrid').jqxGrid({ disabled: true}); 
		$('#frmAssetInvoice input').attr('readonly', true );
		 $('#frmAssetInvoice select').attr('disabled', true );
		 $('#frmAssetInvoice textarea').attr('readonly', true );
		 $('#btncalculate').prop('disabled',true);

}
function funRemoveReadOnly(){
	 $('#date').jqxDateTimeInput({ disabled: false});
	 $('#assetInvoiceGrid').jqxGrid({ disabled: false}); 
		$('#frmAssetInvoice input').attr('readonly', false );
		 $('#frmAssetInvoice select').attr('disabled', false );
		 $('#frmAssetInvoice textarea').attr('readonly', false );
		 $('#btncalculate').prop('disabled',false);
		 $('#client').prop('readonly',true);
		 $('#clientname').prop('readonly',true);
		 $('#docno').prop('readonly',true);
		 $('#vocno').prop('readonly',true);
		 if(document.getElementById("mode").value=='A'){
			 $("#assetInvoiceGrid").jqxGrid('clear');
			 $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
		 }
}
function funFocus(){
	document.getElementById("client").focus();
}
function setValues(){
funSetlabel();
	
	 if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
	 if ($('#hidcmbtype').val() != null) {
			$('#cmbtype').val($('#hidcmbtype').val());
		}
	 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	if(document.getElementById("docno").value!=""){
		document.getElementById("brchName").disabled=false;
		$('#assetInvoicediv').load('assetInvoiceGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
		
	}
}
function funNotify(){
	if(document.getElementById("cmbtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Type is Mandatory";
		document.getElementById("cmbtype").focus();
		return 0;
	}
	var rows = $("#assetInvoiceGrid").jqxGrid('getrows');
	if(!((rows[0].assetno=="undefined") || (rows[0].assetno==null) || (rows[0].assetno==""))){
	
		var rowlength=0;
		for(var i=0 ; i < rows.length ; i++){
		
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
			if(rows[i].assetno!="" && rows[i].assetno!="undefined" && rows[i].assetno!=null){
				
		newTextBox.val(rows[i].assetno+"::"+rows[i].assetname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
		
		newTextBox.appendTo('form');
		rowlength++;
			}
		}
		
		$('#gridlength').val(rowlength);
		
	}
 return 1;	
}


function funCalculate(){

	var date=$('#date').jqxDateTimeInput('val');
	
	var rows=$('#assetInvoiceGrid').jqxGrid('getrows');
	var temp=0;
	for(var i=0;i<rows.length;i++){
		var asset=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetid');
		var assetno=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'assetno');
		temp=1;
		document.getElementById("errormsg").innerText="";
		if(asset=="" || asset=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Asset is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'assetid');
			return false;
		}
		var salesprice=$("#assetInvoiceGrid").jqxGrid('getcellvalue',i,'salesprice');
		if(salesprice=="" || salesprice=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Sales Price is Mandatory";
			$('#assetInvoiceGrid').jqxGrid('selectcell', i, 'salesprice');
			return false;
		}
		
		if(document.getElementById("errormsg").innerText=="" && asset!="" && asset!="undefined" && asset!=null){
			getCalData(assetno,salesprice,i,date);
		}
			
	}
	if(temp==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Asset";
		return false;
	}
	
}


function getCalData(asset,salesprice,row,date){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items=items.split("::");
			
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
			$('#assetInvoiceGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
			document.getElementById("days").value=items[3];
		} else {
		}
	}
	x.open("GET", "getCalData.jsp?asset="+asset+"&salesprice="+salesprice+"&date="+date, true);
	x.send();
}

function funPrintBtn() {
	   if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		 $.messager.alert('Warning','Select a Document');
		 return false;
	}
	 var url=document.URL;

		 var reurl=url.split("com/");   
	 	 var win= window.open(reurl[0]+"com/fixedassets/assets/assetssalesinvoice/printAssetsInvoice.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		 win.focus();       
	 
	 }


</script>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAssetSalesInvoice" action="saveActionAssetSalesInvoice" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/> 

<fieldset>
<legend>Invoice Header</legend>
<table class="form-table" >
  <tr>
    <td width="6%" align="right">Date</td>
    <td width="8%" align="left"><div id="date" name="date" value='<s:property value="date"/>'></div></td>
        
  
    <td width="10%" align="right">Doc No</td>
    <td width="8%" align="left"><input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1"  readonly></td>

  </tr>
  <tr>
    <td align="right">Client</td>
    <td align="left"><input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search" onkeydown="getClient(event);"></td>
    <td  colspan="2" align="left"><input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' style="width:99%;" readonly></td>
   <td  align="right">Description</td>
    <td colspan="2" align="left"><input type="text" name="description" id="description" value='<s:property value="description"/>' style="width:97.5%;"></td>
    <td align="right">Type</td>
    <td align="left"><select name="cmbtype" id="cmbtype" >
      <option value="">--Select--</option>
      <option value="S">Sale</option>
      <option value="L">Total Loss</option>
    </select></td>
    <td align="center"><input type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funCalculate();" value="Calculate"></td>
  </tr>
 
  
  </table>
  </fieldset>
  <div class="grid-wrapper">
<div id="assetInvoicediv"><jsp:include page="assetInvoiceGrid.jsp"></jsp:include></div>
</div>

<div style="display:none;">
    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' hidden=true></div>
    <div id="todate" name="todate" value='<s:property value="todate"/>' hidden=true></div>
    <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
    <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
    <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
    <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
    <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
    <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
     <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
     <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
     <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
     <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1"  readonly>
 </div>
</form>
<div id=clientwindow>
   <div ></div>
</div>
<div id="assetwindow">
   <div ></div>
</div>
</div>
</body>
</html>