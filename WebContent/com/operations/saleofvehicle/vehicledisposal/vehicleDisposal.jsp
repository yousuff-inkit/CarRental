<%@page import="com.connection.ClsConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
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

<style>
.hidden-scrollbar {
    overflow: auto;
    height: 520px;
}
</style>
<script type="text/javascript">
var configs={};
$(document).ready(function() {
	document.getElementById("btnEdit").disabled=false;  
	document.getElementById("btnDelete").disabled=false;
	 $('#clientwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '53%' ,maxWidth: '50%' , title: 'Client Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '60%', height: '58%',  maxHeight: '58%' ,maxWidth: '50%' , title: 'Fleet Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#detailwindow').jqxWindow({ autoOpen:false,width: '90%', height: '70%',  maxHeight: '70%' ,maxWidth: '90%' , title: 'Asset List' ,position: { x: 100, y: 60 }, keyboardCloseKey: 27});
	   
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

$('#date').on('change', function (event) 
{  
    var jsDate = event.args.date; 
    var type = event.args.type; // keyboard, mouse or null depending on how the date was selected.
	if(configs.vehsaleinvfuturedate=="1"){
		//Restricts Future Date
		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
	}
	if(configs.forceDate=="1" && $('#mode').val()=="A"){
		var basedate=new Date();
		var docdate=new Date($('#date').jqxDateTimeInput('getDate'));
		basedate.setHours(0,0,0,0);
		docdate.setHours(0,0,0,0);
		if(docdate<basedate){
			$('#date').jqxDateTimeInput('setDate', new Date());
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Back Dates not allowed";
			return false;
		}
		else{
			document.getElementById("errormsg").innerText="";
		}
		
	}
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
function fleetnoSearchContent(url) {
    //alert(url);
      $.get(url).done(function (data) {
//alert(data);
    $('#fleetwindow').jqxWindow('setContent', data);

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
	  $('#disposalGrid').jqxGrid({ disabled: true});
		$('#frmVehicleDisposal input').attr('readonly', true );
		 $('#frmVehicleDisposal select').attr('disabled', true );
		 $('#frmVehicleDisposal textarea').attr('readonly', true );
		 $('#btncalculate').prop('disabled',true);

}
function funRemoveReadOnly(){  
	$('#date').jqxDateTimeInput({ disabled: false});
	$('#disposalGrid').jqxGrid({ disabled: false});
	$('#frmVehicleDisposal input').attr('readonly', false );
	$('#frmVehicleDisposal select').attr('disabled', false );
	$('#frmVehicleDisposal textarea').attr('readonly', false );
	$('#btncalculate').prop('disabled',false);
	$('#client').prop('readonly',true);
	$('#clientname').prop('readonly',true);
	$('#docno').prop('readonly',true);
	if(document.getElementById("mode").value=='A'){
		$("#disposalGrid").jqxGrid('clear');
		$("#disposalGrid").jqxGrid('addrow', null, {});
		$("#jvGrid").jqxGrid('clear');
	}
	 
	if(configs.forceDate=="1" && $('#mode').val()=="A"){
		var basedate=new Date();
		basedate=new Date(basedate.setDate(basedate.getDate()-1));
		$('#date').jqxDateTimeInput('setMinDate', basedate);
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
		$('#disposaldiv').load('vehDisposalGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("hidbranch").value+'&id=1');
		$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("trno").value+'&id=1');
	}
	//alert(document.getElementById("mode").value);
}
function funNotify(){
	if(configs.vehsaleinvfuturedate=="1"){
		//Restricts Future Date
		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
		
	}
	if(document.getElementById("cmbtype").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Type is Mandatory";
		document.getElementById("cmbtype").focus();
		return 0;
	}
	var rows = $("#disposalGrid").jqxGrid('getrows');
	if(!((rows[0].fleet_no=="undefined") || (rows[0].fleet_no==null) || (rows[0].fleet_no==""))){
	
		var rowlength=0;
		for(var i=0 ; i < rows.length ; i++){
		
			newTextBox = $(document.createElement("input"))
		    .attr("type", "dil")
		    .attr("id", "test"+i)
		    .attr("name", "test"+i)
		    .attr("hidden", "true");
			
			if((rows[i].pur_value=="0") && configs.vsinopurchasecost=="0"){
				document.getElementById("errormsg").innerText="";
				document.getElementById("errormsg").innerText="Purchase value can not be zero";
				return 0;
			}
			if(rows[i].fleet_no!="" && rows[i].fleet_no!="undefined" && rows[i].fleet_no!=null){
				
		newTextBox.val(rows[i].fleet_no+"::"+rows[i].flname+"::"+rows[i].salesprice+"::"+rows[i].dep_posted+"::"+rows[i].pur_value+"::"+rows[i].acc_dep+"::"+rows[i].cur_dep+"::"+rows[i].net_pl+"::"+rows[i].netbook);
		
		newTextBox.appendTo('form');
		rowlength++;
			}
			
			//alert("ddddd"+$("#test"+i).val());
		}
		
		$('#gridlength').val(rowlength);
		// alert($('#gridlength').val());
		
	}
 return 1;	
}

function deleteTempData(value){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			
		} else {
		}
	}
	x.open("GET", "deleteTempData.jsp?mdoc="+value, true);
	x.send();
}

function funCalculate(){
	
	
		deleteTempData(document.getElementById("mdoc").value);
	
	var date=$('#date').jqxDateTimeInput('val');
	if(configs.vehsaleinvfuturedate=="1"){
		//Restricts Future Date
		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return false;
		}
	}
	var rows=$('#disposalGrid').jqxGrid('getrows');
	var temp=0;
	var count=0;
	for(var i=0;i<rows.length;i++){
		var fleet=$("#disposalGrid").jqxGrid('getcellvalue',i,'fleet_no');
		temp=1;
		document.getElementById("errormsg").innerText="";
		if(fleet=="" || fleet=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Fleet is Mandatory";
			$('#disposalGrid').jqxGrid('selectcell', i, 'fleet_no');
			return false;
		}
		var salesprice=$("#disposalGrid").jqxGrid('getcellvalue',i,'salesprice');
		if(salesprice=="" || salesprice=="undefined"){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Sales Price is Mandatory";
			$('#disposalGrid').jqxGrid('selectcell', i, 'salesprice');
			return false;
		}
		
		if(document.getElementById("errormsg").innerText=="" && fleet!="" && fleet!="undefined" && fleet!=null){
			getCalData(fleet,salesprice,i,date);
			count++;
		}
			
	}
	

	if(temp==0){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select Fleet";
		return false;
	}
	
}


function getCalData(fleet,salesprice,row,date){
	var client=document.getElementById("client").value;
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items=items.split("::");
			
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'dep_posted',items[0]); 
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'pur_value',items[1]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'acc_dep',items[2]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'cur_dep',items[3]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'net_pl',items[4]);
			$('#disposalGrid').jqxGrid('setcellvalue', row, 'netbook',items[5]);
			var dep_posted=$('#disposalGrid').jqxGrid('getcelltext', row, 'dep_posted'); 
			var pur_value=$('#disposalGrid').jqxGrid('getcelltext', row, 'pur_value').replace(/,/g , "");
			var acc_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'acc_dep').replace(/,/g , "");
			var cur_dep=$('#disposalGrid').jqxGrid('getcelltext', row, 'cur_dep').replace(/,/g , "");
			var net_pl=$('#disposalGrid').jqxGrid('getcelltext', row, 'net_pl').replace(/,/g , "");
			var netbook=$('#disposalGrid').jqxGrid('getcelltext', row, 'netbook').replace(/,/g , "");
			var salesprice=$('#disposalGrid').jqxGrid('getcelltext', row, 'salesprice').replace(/,/g , "");
			var fleetno=$('#disposalGrid').jqxGrid('getcelltext', row, 'fleet_no').replace(/,/g , "");
			var dtype=document.getElementById("formdetailcode").value;
			//alert(dtype);
			document.getElementById("days").value=items[3];
			if(pur_value!=null && typeof(pur_value)!="undefined"){
				
				funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype,date);	
			}
			
		} else {
		}
	}
	x.open("GET", "getCalData.jsp?fleet="+fleet+"&salesprice="+salesprice+"&date="+date, true);
	x.send();
}
function funLoadTempJv(dep_posted,pur_value,acc_dep,cur_dep,net_pl,netbook,client,salesprice,fleetno,dtype,date){
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText.trim();
			//alert(items);
			document.getElementById("mdoc").value=items;
			$('#jvdiv').load('jvGrid.jsp?trno='+document.getElementById("mdoc").value+'&id=2');
		} else {
		}
	}
	x.open("GET", "loadTempJv.jsp?salesprice="+salesprice+"&dep_posted="+dep_posted+"&purvalue="+pur_value+"&accdep="+acc_dep+"&curdep="+cur_dep+"&netpl="+net_pl+"&netbook="+netbook+"&client="+client+"&fleetno="+fleetno+"&dtype="+dtype+"&date="+date, true);
	x.send();
}


function getDetail(){
	if(document.getElementById("docno").value==""){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select a Document";
		return false;
	}
	var detail="";
	
	if(document.getElementById("rdosummary").checked==false && document.getElementById("rdodetail").checked==false && document.getElementById("rdotabular").checked==false){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Please Select any Valid Option";
		return false;
	}
	$('#detailwindow').jqxWindow('open');
	 $('#detailwindow').jqxWindow('focus');
	if(document.getElementById("rdosummary").checked==true){
		detailSearchContent('getGridSummary.jsp');
	}
	else if(document.getElementById("rdodetail").checked==true){
		detailSearchContent('getGridDetail.jsp');
	}
	else{
		detailSearchContent('getGridTabular.jsp?docno='+document.getElementById("docno").value+'&fromdate='+$('#fromdate').jqxGrid('val')+'&todate='+$('#todate').jqxGrid('val'));
	}
	
}
/* function funPrintBtn(){
	var url=document.URL;
	var reurl=url.split("saveActionVehicleDisposal");
    var win= window.open(reurl[0]+"printSaleInvoice?doc_no="+document.getElementById("doc_no").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    win.focus();
}
 */
function funPrintBtn() {
 	   if(document.getElementById("docno").value=='' || document.getElementById("docno").value=='0'){
		 $.messager.alert('Warning','Select a Document');
		 return false;
	}
	 var url=document.URL;
         //alert(url);
		 var reurl=url.split("com/");	
		 //alert(reurl);
		 var dtype=document.getElementById("formdetailcode").value;
		// alert(dtype);
	 	 var win= window.open(reurl[0]+"printSaleInvoice.action?docno="+document.getElementById("docno").value+"&trno="+document.getElementById("trno").value+"&dtype="+dtype,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
		 win.focus();      
	 
	 }
	 function getConfigs(){
	 	$.get('getConfigs.jsp',function(data){
	 		configs=JSON.parse(data);
	 		console.log(configs);
	 	});
	 }
</script>
</head>
<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT (From Master)
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
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important;
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons) (From Master)
    ------------------------------ */
    center {
        text-align: left !important;
        display: block;
        width: 100%;
        margin-left: 0;
    }

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
       GRID SYSTEM (FORM LAYOUT) (From Master)
    ------------------------------ */
    .receipt-header {
        display: block; /* Header block container */
        padding: 0 0 0 5px;
    }

    .form-group {
        display: grid;
        grid-template-columns: 120px 1fr;
        align-items: center;
        gap: 12px;
        margin-bottom: 12px;
    }

    .form-group.dual-input {
        grid-template-columns: 120px 1fr 120px 1fr;
    }

    .form-group.single-label-dual-input {
        /* Used for Client Code/Name */
        grid-template-columns: 120px 1fr 1fr;
    }
    
    .form-group.three-field-input {
        /* Used for Description/Type/Calculate */
        grid-template-columns: 120px 1fr 60px 1fr 1fr; /* Custom grid for alignment */
        gap: 12px 10px;
    }
    
    .form-group .calculate-button {
        display: flex;
        justify-content: flex-end;
    }


    .section-row {
        display: flex;
        gap: 26px;
        margin-bottom: 30px;
        flex-wrap: wrap;
    }

    .section-block {
        flex: 1;
        background: #f6f8fa; /* Uniform background color */
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
        min-width: 45%;
    }

    .full-width-block {
        flex: 1 1 100%;
    }

    .section-block h2, .section-block h3, .fieldset-legend-replacement {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
        border-radius: 0; /* Ensure straight line */
    }
    
    .fieldset-legend-replacement {
        background: none;
        padding: 0 0 0 10px;
        margin-bottom: 10px;
    }


    /* ------------------------------
       INPUTS & CONTROLS (From Master)
    ------------------------------ */
    input[type="text"], input[type="email"], select, textarea {
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

    input[type="text"]:focus, input[type="email"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }

    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }
    
    /* Button styling from Master UI */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
        height: 32px; /* Match input height */
    }
    .myButton:hover { background: #0056b3; }


    label {
        font : Tahoma;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */

    /* SCROLLBAR FIX */
    .hidden-scrollbar { 
        overflow: auto; 
        height: 520px; /* Kept original height */
        padding: 0 5px; /* Added padding for grid alignment */
    }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

</style>

<body onload="setValues();getConfigs();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmVehicleDisposal" action="saveActionVehicleDisposal" autocomplete="off" >

	<jsp:include page="../../../../header.jsp" />
	<br/> 
    
    <div class="section-block full-width-block" style="padding-top: 5px; padding-bottom: 5px;">
        <h3 class="fieldset-legend-replacement">Vehicle Disposal</h3>
        
        <div class="hidden-scrollbar">

            <div class="form-group dual-input">
                <label>Date</label>
                <div>
                    <div id="date" name="date" value='<s:property value="date"/>'></div>
                </div>
                
                <label>Doc No</label>
                <input type="text" name="vocno" id="vocno" value='<s:property value="vocno"/>' tabindex="-1" readonly>
            </div>

            <div class="form-group single-label-dual-input">
                <label>Client</label>
                <input type="text" name="client" id="client" value='<s:property value="client"/>' readonly placeholder="Press F3 to Search" onkeydown="getClient(event);">
                <input type="text" name="clientname" id="clientname" value='<s:property value="clientname"/>' readonly>
            </div>

            <div class="form-group three-field-input" style="grid-template-columns: 120px 1.5fr 60px 1fr auto;">
                <label>Description</label>
                <input type="text" name="description" id="description" value='<s:property value="description"/>'>

                <label style="text-align:left; padding-right: 0; padding-left: 10px; min-width: 60px;">Type</label>
                <select name="cmbtype" id="cmbtype" >
                    <option value="">--Select--</option>
                    <option value="S">Sale</option>
                    <option value="L">Total Loss</option>
                </select>
                
                <div class="calculate-button">
                    <input type="button" name="btncalculate" id="btncalculate" class="myButton" onclick="funCalculate();" value="Calculate">
                </div>
            </div>

            <div id="disposaldiv" style="margin-top: 15px;"><jsp:include page="vehDisposalGrid.jsp"></jsp:include></div>

            <div id="jvdiv" style="margin-top: 15px;"><jsp:include page="jvGrid.jsp"></jsp:include></div>

            <div style="display: none;">
                <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
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
                <input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly>
                <input type="hidden" name="mdoc" id="mdoc" value='<s:property value="mdoc"/>' tabindex="-1" readonly>
            </div>
        </div>
    </div>
</form>

<div id=clientwindow>
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="detailwindow">
   <div ></div>
</div>

</div>
</body>
</html>