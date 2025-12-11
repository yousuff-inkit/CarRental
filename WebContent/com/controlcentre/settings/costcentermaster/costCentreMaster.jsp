<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<s:head/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
/* ---------- Master UI + Cost Master overrides ---------- */

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
    max-width: 1200px;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* header / top row */
.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 12px;
    margin-bottom: 18px;
    padding: 12px 18px;
    border-radius: 10px;
    background: transparent;
}

.receipt-header .left,
.receipt-header .right {
    display: flex;
    align-items: center;
    gap: 8px;
}

.receipt-header label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    background: #fff;
    transition: border-color 0.2s;
    width: 140px;
}

.receipt-header .date-box {
    min-width: 220px;
}

/* global small helpers */
form label.error { color:red; font-weight:bold; }

/* layout for the three sections */
.section-row {
    display: flex;
    gap: 18px;
    margin-bottom: 22px;
    flex-wrap: wrap;
}

.section-block {
    flex: 1 1 32%;
    min-width: 260px;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.02rem;
    font-weight: 600;
    margin: 0 0 12px 0;
    color: #253858;
    padding-left: 6px;
    border-left: 3px solid #007bff;
}

/* form rows inside sections */
.form-row {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.form-row label {
    min-width: 110px;
    text-align: right;
    font-weight: 600;
    color: #253858;
}

.form-row .field {
    flex: 1;
}

.form-row input[type="text"],
.form-row select {
    width: 100%;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 7px 10px;
    background: #fff;
    font-size: 14px;
    box-sizing: border-box;
}

.form-row input[type="text"]:focus,
.form-row select:focus {
    border-color: #007bff;
    outline: none;
}

/* smaller inline pair for dropdown + name (sub/transaction) */
.inline-pair {
    display: flex;
    gap: 8px;
}
.inline-pair select { flex: 0 0 45%; }
.inline-pair input[type="text"] { flex: 1 1 auto; }

/* tables */
.table-section { margin-top: 14px; }
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 14px;
}
.cr-table th { background: #eef0f6; font-weight: 600; color: #354B6A; }

/* hidden scrollbar utility (kept as original) */
.hidden-scrollbar { overflow: auto; max-height: 520px; }
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }

/* responsiveness */
@media (max-width: 920px) {
    .section-block { flex-basis: 100%; }
    .receipt-header input[type="text"] { width: 120px; }
}
/* ---------- MASTER TEXTBOX STYLE (MATCH EXACT UI) ---------- */

input[type="text"],
select {
    height: 32px !important;
    width: 100%;
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

/* Inline dropdown + text fields */
.inline-pair select,
.inline-pair input[type="text"] {
    height: 32px !important;
}
#transSection .form-row input[type="text"] {
    width: 100% !important;
    max-width: 290px !important;   /* SAME as Main section */
}

#transSection .form-row select {
    width: 100% !important;
    max-width: 290px !important;
}

</style>
<script type="text/javascript">

$(document).ready(function () {    
    $("#date_costmaster").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });

  //  getHead();getMainac();

});
function funFocus(){
	
}
 function funReset() {
	
	
} 
function funReadOnly() {
	$('#frmCostmaster input').attr('readonly', true);
	
		
		$('#category1').attr('disabled', true);
		$('#category2').attr('disabled', true);
		$('#category3').attr('disabled', true);
		$('#frmCostmaster select').attr('disabled', true);
	
	delvalueChange();
	
}
function funRemoveReadOnly() {
	$('#frmCostmaster input').attr('readonly', true);

	$('#category1').attr('disabled', false);
	$('#category2').attr('disabled', false);
	$('#category3').attr('disabled', false);
	 if ($("#mode").val() =="A") {
		 $('#date_costmaster').val(new Date());
		
		 $('#frmAccountmaster select').attr('disabled', true);
		 
		 var disother=document.getElementById("otherdis").value; 
		 
		 if(disother==1)
	 {
			 
	 $("table#main input").prop("disabled", false);
	 $("table#main input").prop("readonly", false);
	 $("table#main select").prop("disabled", false);
	 $('#category1').attr('disabled', false);
	 $('#category2').attr('disabled', true);
		$('#category3').attr('disabled', true);
		 $("table#sub input").prop("readonly", true);
		
		 $("table#trans input").prop("readonly", true);
		
	
	 }
 if(disother==2)
 {
	 $("table#sub input").prop("disabled", false);
	 $("table#sub input").prop("readonly", false);
	 $("table#sub select").prop("disabled", false);
	 $('#subaccgpname').attr('readonly', true);
	 $('#category2').attr('disabled', false);
     $('#category1').attr('disabled', true);
	 $('#category3').attr('disabled', true);

	 $("table#trans input").prop("readonly", true);
	
	 $("table#main input").prop("readonly", true);
	
 }
 if(disother==3)
 {
	 $("table#trans input").prop("disabled", false);
	 $("table#trans input").prop("readonly", false);
	 $("table#trans select").prop("disabled", false);
	 $('#transcaccgpname').attr('readonly', true);
	 
	 $('#category3').attr('disabled', false);
     $('#category1').attr('disabled', true);
	 $('#category2').attr('disabled', true);
	 $("table#sub input").prop("readonly", true);


	 $("table#main input").prop("readonly", true);

 }
		 
		 
	 }
	
	 if ($("#mode").val() =="E") {
		 $('#frmCostmaster input').attr('readonly', false);
		 $('#frmCostmaster select').attr('readonly', false);
		 var disother=document.getElementById("otherdis").value; 
		 
				 if(disother==1)
			 {
					 
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $('#category1').attr('disabled', false);
			 $('#category2').attr('disabled', true);
				$('#category3').attr('disabled', true);
				 $("table#sub input").prop("readonly", true);
				
				 $("table#trans input").prop("readonly", true);
				
			
			 }
		 if(disother==2)
		 {
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			 $('#subaccgpname').attr('readonly', true);
			 $('#category2').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			$('#category3').attr('disabled', true);

			 $("table#trans input").prop("readonly", true);
			
			 $("table#main input").prop("readonly", true);
			
		 }
		 if(disother==3)
		 {
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $('#transcaccgpname').attr('readonly', true);
			 
			 $('#category3').attr('disabled', false);
		 $('#category1').attr('disabled', true);
			$('#category2').attr('disabled', true);
			 $("table#sub input").prop("readonly", true);
		
	
			 $("table#main input").prop("readonly", true);
		
		 }
		 
	 }
	 if ($("#mode").val() =="D") {
			$('#frmCostmaster input').attr('readonly', false);
			
		
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			$('#frmCostmaster select').attr('disabled', false);
	 }
	$('#docno').attr('readonly', true);
}
function funSearchLoad(){
	
	changeContent('masterSearch.jsp'); 
 }
function fundisable(){
	
	
	if (document.getElementById('category1').checked) {
		$('#frmCostmaster input').attr('readonly', false);
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#main input").prop("disabled", false);
		 $("table#main select").prop("disabled", false);
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 $('#docno').attr('readonly', true); 
		// radiotick for tick 
		 document.getElementById('radiotick').value=1;
		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		
		 document.getElementById('maindel').value=1;
		 document.getElementById('otherdis').value=1;
		 document.getElementById('main_account').value="mainacc";
		
		}
	else if (document.getElementById('category2').checked) {
		$('#frmCostmaster input').attr('readonly', false);
		 $("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#trans input").prop("disabled", true);
		 $("table#trans select").prop("disabled", true);
		 $("table#sub input").prop("disabled", false);
		 $("table#sub select").prop("disabled", false);
		 $('#subaccgpname').attr('readonly', true);
		 $('#docno').attr('readonly', true); 
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('transcaccgpname').value="";
		 document.getElementById('transacccode').value="";
		 document.getElementById('transaccname').value="";
		 
		 document.getElementById('radiotick').value=2;
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=2;
		 document.getElementById('otherdis').value=2;
		 document.getElementById('sub_account').value="subacc";
		}
	else if (document.getElementById('category3').checked) {
		$('#frmCostmaster input').attr('readonly', false);
		$("table#main input").prop("disabled", true);
		 $("table#main select").prop("disabled", true);
		 $("table#sub input").prop("disabled", true);
		 $("table#sub select").prop("disabled", true);
		 $("table#trans input").prop("disabled", false);
		 $("table#trans select").prop("disabled", false);
		 $('#transcaccgpname').attr('readonly', true);
		 document.getElementById('mainacccode').value="";
		 document.getElementById('mainacconame').value="";
		 document.getElementById('subaccgpname').value="";
		 document.getElementById('subacccode').value="";
		 document.getElementById('subaccname').value="";
		 $('#docno').attr('readonly', true);
			document.getElementById('radiotick').value=3;
			
			 document.getElementById('radiosaveval').value=1;
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById('maindel').value=3;
			 document.getElementById('otherdis').value=3;
			 
			 document.getElementById('tran_account').value="tranacc";
			 
		}
	

	 }
	 


function getHead() {
	
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var headItems = items[0].split(",");
			var headIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value="">-- select -- </option>';
			for (var i = 0; i < headItems.length; i++) {
				optionsauth += '<option value="' + headIdItems[i].trim() + '">'
						+ headItems[i] + '</option>';
			}
			$("select#mainaccgroup").html(optionsauth);
			
			delvalueChange();
		} else {
		}
	}
	x.open("GET", "getMain.jsp", true);
	x.send();
	
}


function getMainac() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
			items = items.split('####');
			var mainacItems = items[0].trim().split(",");
			var mainacIdItems = items[1].trim().split(",");
			var optionsauth = '';
			optionsauth += '<option value=""> -- select --</option>';
			for (var i = 0; i < mainacItems.length; i++) {
				//alert(mainacIdItems[i]);
				optionsauth += '<option value="' + mainacIdItems[i].trim() + '">'
						+ mainacItems[i].trim()+ '</option>';
			}
			//$("select#mainaccountgroup").html(optionsauth);
			$("select#subaccgroup").html(optionsauth);
			
			$("select#tansaccgroup").html(optionsauth);
			
			delvalueChange();
		} 
		else {
		}
	}
	x.open("GET", "getSubTranAccmain.jsp", true);
	x.send();
	
}

function getAcgroup(value,check)
{

	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText;
		 	
		 	if (check==1)
		 		{
		 		
		 		 $('#subaccgpname').val(items) ;
		 		}		 		
		 	else if (check==2)
		 		{
		 	
		 		 $('#transcaccgpname').val(items) ;
		 		}
		 }
	       else
		  {
		  }
    }
     x.open("GET","disAcgroup.jsp?subaccountgroup="+value,true);
    x.send();
   
  }
function funChkButton(){

	
	
	frmCostmaster.submit();		
}

function funNotify(){
	
	
	 if ($("#mode").val() =="A") {
		 var radval=document.getElementById("radiosaveval").value; 
		
		 if(radval=="")
			 {
			 document.getElementById("errormsg").innerText=" *Select One Account";
			 return 0;
			 }
		 var codeval=document.getElementById("codeval").value; 
		 if(codeval==1)
		 {
			 document.getElementById("errormsg").innerText="Cost Code Already Exists";
		 return 0;
		 }
		 else{
		 document.getElementById("errormsg").innerText="";
		
		 }
		 
		 
		 var radiotick=document.getElementById("radiotick").value; 
		 if(radiotick==1)
		 {
			 
			 var mainval=document.getElementById("mainaccgroup").value;
			 if(mainval=="")
				 {
			 document.getElementById("errormsg").innerText="Select   Cost Group";
			 document.getElementById("mainaccgroup").focus();
		     return 0;
				 }
			 
			 var mainacc=document.getElementById("mainacconame").value;
			 if(mainacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("mainacconame").focus();
		     return 0;
				 }
			 
			 
			 
		 }
		 
		 else if(radiotick==2)
		 {
			 
			 var subval=document.getElementById("subaccgroup").value;
	
			 if(subval=="")
				 {
			 
			 document.getElementById("errormsg").innerText="Select  Cost Group";
			 document.getElementById("subaccgroup").focus();
		     return 0;
				 }
			 var subacc=document.getElementById("subaccname").value;
			 if(subacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("subaccname").focus();
		     return 0;
				 }
		 }
		 
		 else if(radiotick==3)
		 {
			 
		var tranval=document.getElementById("tansaccgroup").value;
			 if(tranval=="")
			 {
			 document.getElementById("errormsg").innerText=" Select  Cost Group";
			 document.getElementById("tansaccgroup").focus();
		     return 0;
			 }
			 
			 var tranacc=document.getElementById("transaccname").value;
			 if(tranacc=="")
				 {
			 document.getElementById("errormsg").innerText="Enter Cost Name";
			 document.getElementById("transaccname").focus();
		     return 0;
				 }
			 
		 }
		 
		 
		 else{
		 document.getElementById("errormsg").innerText="";
		
		 } 
		 
		 
	         }
	 
	 if($("#mode").val() =="E")
	 {
	 var codeval=document.getElementById("codeval").value; 
	 if(codeval==1)
	 {
		 document.getElementById("errormsg").innerText="Cost Code Already Exists";
	 return 0;
	 }
	 else{
		 document.getElementById("errormsg").innerText="";
		
		 }
	 }
	 
	 if ($("#mode").val() =="view") {
		
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
		 $('#mainaccgroup').attr('disabled', false);
	 }
	

	return 1;
			
}

function maincheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";	
if(document.getElementById("mainacccode").value!=""){
	var code=document.getElementById("mainacccode").value;
	
	funtest(code);
	
	
}
else {}
	
}
function subcheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";	
if(document.getElementById("subacccode").value!=""){
	var code=document.getElementById("subacccode").value;
	
	funtest(code);
	
	
}
else {}
	
}
function trancheck()
{
	document.getElementById("errormsg").innerText="";
	document.getElementById("codeval").value="";	
if(document.getElementById("transacccode").value!=""){
	var code=document.getElementById("transacccode").value;
	
	funtest(code);
	
	
}
else {}
	
}



   function funtest(code)
           {
	   var masterdoc=document.getElementById("docno").value;
	  // alert("masterdoc"+masterdoc);
	var x=new XMLHttpRequest();
	
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	
		 	
		 		 if(items!="")
		 		{
		 			document.getElementById("codeval").value=1;
		 			document.getElementById("errormsg").innerText="Cost Code Already Exists";
		 			 
		 			 
		 		}
		 		 else
		 			 {
		 			document.getElementById("codeval").value="";
		 			document.getElementById("errormsg").innerText="";
		 			 }
		 		
		 }
	       else
		  {
	    	   
		  }
    }
	x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
	}  
   

   function delvalueChange()
   {
 	
 	  if(document.getElementById("radiotick").value==1)
 		  {
 		 
 		  document.getElementById("category1").checked = true;
 		  }
 	  else if(document.getElementById("radiotick").value==2)
 		  {
 		  document.getElementById("category2").checked = true;
 		  }
 	 else if(document.getElementById("radiotick").value==3)
	  {
	  document.getElementById("category3").checked = true;
	  }
 	  
 	  if($('#checksetval').val()!="")
 	  {
 		  
 	 $('#mainaccgroup').val($('#checksetval').val());
 	  }
 
 	  if($('#subchecksetval').val()!="")
	  {
	 $('#subaccgroup').val($('#subchecksetval').val());
	  }
 	  if($('#tranchecksetval').val()!="")
	  {
	 $('#tansaccgroup').val($('#tranchecksetval').val());
	  }
 	
 
 
 
 	 
   }
   function funclear1()
   {
	   document.getElementById("subchecksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
	   
   }
   function funclear2()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("tranchecksetval").value=="";
	   
   }
   function funclear3()
   {
	   document.getElementById("checksetval").value=="";
	   document.getElementById("subchecksetval").value=="";
	   
   }

   
   
function setValues() {
	if($('#datehidden').val()){
		$("#date_costmaster").jqxDateTimeInput('val', $('#datehidden').val());
	}
	if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
		
	document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	 delvalueChange();
}

function checkreq()
{
	
if(document.getElementById('radiotick').value==1)
	{
	

	if(document.getElementById("mainacconame").value=="")
		{ 
		
		 document.getElementById("errormsg").innerText=" Enter Account Name";
		 return 0;
		
		}
	}
else  if(document.getElementById('radiotick').value==2)
{
     if(document.getElementById("subaccname").value=="")
	{
    	 
    	 document.getElementById("errormsg").innerText=" Enter SubAccount Name";
    	 return 0;
	}
}
else  if(document.getElementById('radiotick').value==3)
{
    if(document.getElementById("transaccname").value=="")
	{ 
    	
    	document.getElementById("errormsg").innerText=" Enter TraAccount Name";
    	return 0;
	}
}
else
	{
	 document.getElementById("errormsg").innerText="";
	}

}
function dismassge()
{
	document.getElementById("errormsg").innerText="";
	
	}
function funExcelBtn(){
    var url=document.URL;
    var reurl=url.split("costcentermaster");
    top.addTab("ChartOfCost",reurl[0]+"costcentermaster/chartOfCost.jsp");
}
</script>

</head>


<body onload="getHead();getMainac();setValues();">
<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br/>

    <form id="frmCostmaster" action="saveCostmaster" method="post" autocomplete="off">
        <!-- TOP HEADER ROW: Date | Doc No -->
        <div class="receipt-header">
            <div class="left date-box">
                <label for="date_costmaster">Date</label>
                <div id="date_costmaster" name="date_costmaster" style="display:inline-block; margin-left:8px;" value='<s:property value="date_costmaster"/>'></div>
            </div>

            <div class="right" style="margin-left:auto;">
                <label for="docno">Doc No.</label>
                <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' />
            </div>
        </div>

        <!-- RADIO OPTIONS (kept for behaviour) -->
        <div style="margin-bottom:12px; display:flex; gap:14px; align-items:center;">
            <div>
                <input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();" checked>
                <label for="category1">Main</label>
            </div>
            <div>
                <input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();">
                <label for="category2">Sub</label>
            </div>
            <div>
                <input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();">
                <label for="category3">Transaction</label>
            </div>
            <div style="margin-left:12px; color:#666; font-size:13px;">(All three sections visible — radio controls behavior/validation)</div>
        </div>

        <!-- 3 sections row -->
        <div class="section-row">
            <!-- MAIN SECTION -->
            <div class="section-block" id="mainSection">
                <h2>Main</h2>

                <div class="form-row">
                    <label for="mainaccgroup">Cost Group</label>
                    <div class="field">
                        <select name="mainaccgroup" id="mainaccgroup" value='<s:property value="mainaccgroup"/>' onchange="funclear1();" >
                            <option value="-1">--Select--</option>
                            <!-- options preserved from server side -->
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <label for="mainacccode">Cost Code</label>
                    <div class="field">
                        <input type="text" id="mainacccode" name="mainacccode" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="mainacconame">Cost Name</label>
                    <div class="field">
                        <input type="text" id="mainacconame" name="mainacconame" value='<s:property value="mainacconame"/>' onblur="dismassge()" />
                        <input type="hidden" name="main_account" id="main_account" value='<s:property value="main_account"/>' />
                    </div>
                </div>
            </div>

            <!-- SUB SECTION -->
            <div class="section-block" id="subSection">
                <h2>Sub</h2>

                <div class="form-row">
                    <label for="subaccgroup">Main Cost Group</label>
                    <div class="field inline-pair">
                        <select name="subaccgroup" id="subaccgroup" value='<s:property value="subaccgroup"/>' onChange="getAcgroup(this.value,1);" onfocus="funclear2();" >
                            <option value="-1">--Select--</option>
                        </select>
                        <input type="text" id="subaccgpname" name="subaccgpname" value='<s:property value="subaccgpname"/>' placeholder="Group Name" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="subacccode">Cost Code</label>
                    <div class="field">
                        <input type="text" id="subacccode" name="subacccode" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="subaccname">Cost Name</label>
                    <div class="field">
                        <input type="text" id="subaccname" name="subaccname" value='<s:property value="subaccname"/>' onblur="dismassge()" />
                        <input type="hidden" name="sub_account" id="sub_account" value='<s:property value="sub_account"/>' />
                    </div>
                </div>
            </div>

            <!-- TRANSACTION SECTION -->
            <div class="section-block" id="transSection">
                <h2>Transaction</h2>

                <div class="form-row">
                    <label for="tansaccgroup">Main Cost Group</label>
                    <div class="field inline-pair">
                        <select id="tansaccgroup" name="tansaccgroup" onChange="getAcgroup(this.value,2);" onfocus="funclear3();" >
                            <option value="-1">--Select--</option>
                        </select>
                        <input type="text" id="transcaccgpname" name="transcaccgpname" value='<s:property value="transcaccgpname"/>' placeholder="Group Name" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="transacccode">Cost Code</label>
                    <div class="field">
                        <input type="text" id="transacccode" name="transacccode" value='<s:property value="transacccode"/>' onblur="trancheck(this.value)" />
                    </div>
                </div>

                <div class="form-row">
                    <label for="transaccname">Cost Name</label>
                    <div class="field">
                        <input type="text" id="transaccname" name="transaccname" value='<s:property value="transaccname"/>' onblur="dismassge()" />
                        <input type="hidden" name="tran_account" id="tran_account" value='<s:property value="tran_account"/>' />
                    </div>
                </div>
            </div>
        </div>

        <!-- Hidden fields (preserved) -->
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>' />
        <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>' />
        <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>' />
        <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>' />
        <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>' />
        <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>' />
        <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>' />
        <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>' />
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>' />
        <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>' />

    </form>
</div>

<!-- Keep any windows/popups you used previously (preserved placeholders) -->
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</body>
  </html>
  