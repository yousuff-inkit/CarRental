<%@ taglib prefix="s" uri="/struts-tags" %>
 
<!DOCTYPE html>
<html>
<head>
<s:head/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <jsp:include page="../../../../includes.jsp"></jsp:include>

<script type="text/javascript">
$(document).ready(function() {
	//document.getElementById("btnEdit").disabled=true;  
	//document.getElementById("btnDelete").disabled=true;
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
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#clientwindow').jqxWindow('setContent', data);

}); 
}
function assetSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#assetwindow').jqxWindow('setContent', data);

}); 
}

function detailSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
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
			
			//alert("ddddd"+$("#test"+i).val());
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

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 14px Tahoma;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
    padding: 0px 8px 0px 0px; 
    text-align: right; 
}

/* ------------------------------
    CARD ROWS LAYOUT (MASTER UI)
------------------------------ */

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
    border-left: 4px solid #007bff; /* Blue line accent */
}

/* Standardized grid for form fields */
.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1fr auto 1fr; 
    gap: 15px 25px;
    align-items: center;
}

.input-group {
    display: flex;
    gap: 5px;
    width: 100%;
}

/* SCROLLING FIX */
.hidden-scrollbar {
    overflow-y: visible !important; 
    max-height: none !important; 
    min-height: 1px; 
    padding-right: 5px; 
}

/* Grid container styling */
.grid-container {
    margin-top: 20px;
    background: #fff;
    border-radius: 8px;
    border: 1px solid #e4e7ec;
    overflow: hidden;
}

#HeadIcons {
    height: auto;           /* FIX */
    display: flex;
    align-items: center;    /* vertical center */
}
#formdet {
    margin-left: 0;         /* remove -8px */
    width: auto;

    text-align: left;
    line-height: normal;
}

</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmAssetSalesInvoice" action="saveActionAssetSalesInvoice" autocomplete="off">

    <jsp:include page="../../../../header.jsp" />
    <br/> 

    <div class='hidden-scrollbar' style="padding: 10px;">
        
        <div class="section-block" style="margin-bottom: 20px;">
            <h2>Asset Sales Invoice Information</h2>
            
            <div class="agmt-info-grid">
                <label for="date">Date</label>
                <div>
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                    <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
                </div>

                <label for="vocno">Doc No</label>
                <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1" readonly>

                <label></label><div></div>

                <label for="client">Client</label>
                <div style="grid-column: span 5;">
                    <div class="input-group">
                        <input type="text" name="client" id="client" style="width: 20% !important;" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search" onkeydown="getClient(event);">
                        <input type="text" name="clientname" id="clientname" style="width: 80% !important;" value='<s:property value="clientname"/>' readonly>
                    </div>
                </div>

                <label for="description">Description</label>
                <div style="grid-column: span 3;">
                    <input type="text" name="description" id="description" value='<s:property value="description"/>'>
                </div>

                <label for="cmbtype">Type</label>
                <div class="input-group">
                    <select name="cmbtype" id="cmbtype">
                        <option value="">--Select--</option>
                        <option value="S">Sale</option>
                        <option value="L">Total Loss</option>
                    </select>
                    <input type="button" name="btncalculate" id="btncalculate" class="myButton" style="width: auto; padding: 0 15px;" onclick="funCalculate();" value="Calculate">
                </div>
            </div>
        </div>

        <div class="section-block">
            <h2>Invoice Details</h2>
            <div class="grid-container">
                <div id="assetInvoicediv">
                    <jsp:include page="assetInvoiceGrid.jsp"></jsp:include>
                </div>
            </div>
        </div>

        <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>' hidden="true"></div>
        <div id="todate" name="todate" value='<s:property value="todate"/>' hidden="true"></div>
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
        <input type="hidden" name="hidcmbtype" id="hidcmbtype" value='<s:property value="hidcmbtype"/>'>
        <input type="hidden" name="trno" id="trno" value='<s:property value="trno"/>'> 
        <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
        <input type="hidden" name="clientacno" id="clientacno" value='<s:property value="clientacno"/>'>
        <input type="hidden" name="hidbranch" id="hidbranch" value='<s:property value="hidbranch"/>'>
        <input type="hidden" name="days" id="days" value='<s:property value="days"/>'>
        <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly>
    </div>
</form>

<div id="clientwindow">
    <div></div>
</div>
<div id="assetwindow">
    <div></div>
</div>

</div>
</body>
</html>