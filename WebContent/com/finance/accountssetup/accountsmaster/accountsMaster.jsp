<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>GatewayERP(i) - Account Master (Modernized)</title>
<meta charset="UTF-8">
<s:head/>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* ---------- Master UI (based on your provided master) ---------- */

/* general */
* { box-sizing: border-box; }
body {
  background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%);
  font-family: "Poppins", "Segoe UI", sans-serif;
  color: #1f2f46;
  margin: 0;
  padding: 28px 0;
  min-height: 100vh;
}

/* main container */
#mainBG {
  background: #f4f8ff;
  border-radius: 14px;
  box-shadow: 0 6px 30px rgba(30, 80, 200, 0.08);
  padding: 18px;
  max-width: 1220px;
  margin: 0 auto;
}

/* subtle inner card */
.receipt-header {
  background: #fff;
  border-radius: 12px;
  padding: 18px;
  margin-bottom: 18px;
  border: 1px solid #e6eefc;
  box-shadow: 0 3px 12px rgba(80,130,240,0.04);
}

/* Top grid: date / docno on same row */
.top-grid {
  display: grid;
  grid-template-columns: 200px 1fr 200px;
  gap: 12px 18px;
  align-items: center;
  width: 100%;
}
.top-grid .form-item { display:flex; align-items:center; gap:10px; }
.top-grid label { font-weight:600; color:#274b8f; min-width:70px; }

/* Clean grid form used for main account & transaction */
.clean-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px 22px;
  align-items: start;
  margin-top: 16px;
}

/* label row above inputs when required */
.clean-grid .label-row {
  display: contents;
}
.clean-grid .label {
  font-weight:600;
  color:#1a2d4d;
  padding-bottom:4px;
}

/* inputs */
input[type="text"], select {
  width: 100%;
  height: 38px;
  padding: 6px 12px;
  border-radius: 8px;
  border: 1px solid #d1d9ee;
  background: #fff;
  font-size: 14px;
  color: #1f2f46;
}
input[type="text"]:focus, select:focus {
  outline: none;
  border-color: #4da3ff;
  box-shadow: 0 0 6px rgba(77,163,255,0.20);
}

/* grouped titled blocks */
.block {
  background: #f6f9ff;
  padding: 14px;
  border-radius: 10px;
  border: 1px solid #e9f0ff;
  box-shadow: 0 2px 10px rgba(100,130,220,0.03);
}
.block h3 {
  margin: 0 0 10px 0;
  color:#16325a;
  font-size:16px;
}

/* Sub-block where labels appear on top row and inputs below */
.labels-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  margin-bottom:6px;
}
.inputs-row {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}

/* transaction special layout (3 rows as requested) */
.transaction-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}
.transaction-grid .full { grid-column: 1 / -1; }

/* small helper */
.helper { font-size: 13px; color:#6a7ba1; }

/* responsive */
@media (max-width: 980px) {
  .clean-grid, .labels-row, .inputs-row, .top-grid, .transaction-grid {
    grid-template-columns: 1fr;
  }
  .top-grid { grid-template-columns: 1fr; gap:8px; }
}

/* table style fallback */
.cr-table {
  width:100%;
  border-collapse: collapse;
  margin-top:12px;
  background:transparent;
}
.cr-table td { padding:6px; vertical-align:top; }
.ui-block {
    background: #f7faff;
    padding: 14px;
    margin-bottom: 18px;
    border-radius: 12px;
    box-shadow: 0 1px 6px rgba(0,0,0,0.07);
}

.block-title {
    font-size: 1rem;
    font-weight: 600;
    color: #1a2d4d;
    display: block;
    margin-bottom: 12px;
}

.ui-row-labels,
.ui-row-inputs {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 14px;
    margin-bottom: 10px;
}

.inline-field {
    display: flex;
    gap: 10px;
}

.ui-row-labels span {
    font-size: 0.9rem;
    color: #3a4b6a;
    font-weight: 600;
}

</style>

<script type="text/javascript">

$(document).ready(function () {    
    $("#date_accountmaster").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
    
    
    $('#accountSearchwindow').jqxWindow({ width: '20%', height: '50%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Currency  Search' ,position: { x: 600, y: 150 }, keyboardCloseKey: 27});
    $('#accountSearchwindow').jqxWindow('close');
   
	 $('#currs').dblclick(function(){
		 
		 
	  		if($('#mode').val()!= "view" && document.getElementById('category3').checked)
 		{
		  	    $('#accountSearchwindow').jqxWindow('open');
		 
		
		  	  accountSearchContent('accountGridSearch.jsp');
 		} 
}); 
	
});

 
	 
	 function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 
	 	if($('#mode').val()!= "view" && document.getElementById('category3').checked)
		{
		 	 if(x==114){
		 	  $('#accountSearchwindow').jqxWindow('open');
		 
		 
		 	 accountSearchContent('accountGridSearch.jsp');   }
		 	 else{
		 		 }
		  } 
	 	 }  
		  function accountSearchContent(url) {
	       //alert(url);
	          $.get(url).done(function (data) {
	//alert(data);
	        $('#accountSearchwindow').jqxWindow('setContent', data);
	
		}); 
	    	}
function funFocus(){

}
 function funReset() {

} 
function funReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);
	
		$('#localcurrency').attr('disabled', true);
		$('#ageingdetails').attr('disabled', true);
		$('#interbranch').attr('disabled', true);
		$('#category1').attr('disabled', true);
		$('#category2').attr('disabled', true);
		$('#category3').attr('disabled', true);
		$('#frmAccountmaster select').attr('disabled', true);
	
	
	
		 delvalueChange();
	
}
function funRemoveReadOnly() {
	$('#frmAccountmaster input').attr('readonly', true);
	$('#localcurrency').attr('disabled', true);
	$('#ageingdetails').attr('disabled', true);
	$('#interbranch').attr('disabled', false);
	$('#category1').attr('disabled', false);
	$('#category2').attr('disabled', false);
	$('#category3').attr('disabled', false);
	
	 if ($("#mode").val() =="A") {
		 $('#date_accountmaster').val(new Date());
		 document.getElementById("interbranch").checked = false;
		 $('#frmAccountmaster select').attr('disabled', true);
		 
		 var disother=document.getElementById("otherdis").value; 
		 //alert(""+disother);
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
				$('#interbranch').attr('disabled', true);
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
			$('#interbranch').attr('disabled', true);
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
			$('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="E") {
		
		 $('#frmAccountmaster input').attr('readonly', false);
		 $('#frmAccountmaster select').attr('readonly', false);
		
		 var disother=document.getElementById("otherdis").value; 
		 //alert(""+disother);
				 if(disother==1)
			 {
					 $("table#main input").prop("disabled", false);
					 $("table#main select").prop("disabled", false);
					 $('#category1').attr('disabled', false);
					 $('#category2').attr('disabled', true);
						$('#category3').attr('disabled', true);
						 $("table#sub input").prop("readonly", true);
						
						 $("table#trans input").prop("readonly", true);
				$('#interbranch').attr('disabled', true);
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
			$('#interbranch').attr('disabled', true);
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
			 $('#currs').attr('readonly', true);
	
			 $("table#main input").prop("readonly", true);
			$('#interbranch').attr('disabled', false);
		 }
		 
	 }
	 if ($("#mode").val() =="D") {
			$('#frmAccountmaster input').attr('readonly', false);
			
			$('#localcurrency').attr('disabled', false);
			$('#ageingdetails').attr('disabled', false);
			$('#interbranch').attr('disabled', false);
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
			 $("table#trans input").prop("disabled", false);
			 $("table#trans select").prop("disabled", false);
			 $("table#main input").prop("disabled", false);
			 $("table#main select").prop("disabled", false);
			 $("table#sub input").prop("disabled", false);
			 $("table#sub select").prop("disabled", false);
			$('#frmAccountmaster select').attr('disabled', false);
	 }
	
	$('#docno').attr('readonly', true);
	 funhidden();
}
function funSearchLoad(){
	
	changeContent('masterSearch.jsp', $('#window')); 
 }
function fundisable(){
	
	
	if (document.getElementById('category1').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
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
		
		
		 document.getElementById('otherdis').value=1;
		 document.getElementById('radiotick').value=1;
		
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 
		 document.getElementById('maindel').value=1;
		 
		 document.getElementById('main_account').value="mainacc";
		 
		
		
		
		}
	else if (document.getElementById('category2').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
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
		 document.getElementById('otherdis').value=2;
		 document.getElementById('radiotick').value=2;
		 document.getElementById('radiosaveval').value=1;
		 document.getElementById("errormsg").innerText=""; 
		 document.getElementById('maindel').value=2;
		 
		 document.getElementById('sub_account').value="subacc";
		 
		}
	else if (document.getElementById('category3').checked) {
		$('#frmAccountmaster input').attr('readonly', false);
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
		 document.getElementById('otherdis').value=3;
			document.getElementById('radiotick').value=3;
			 $('#docno').attr('readonly', true);	
			 
			 $('#currs').attr('readonly', true);
			 document.getElementById('radiosaveval').value=1;
			 document.getElementById("errormsg").innerText=""; 
			 document.getElementById('maindel').value=3;
			 
			 
			 
			 document.getElementById('tran_account').value="tranacc";
			 
		}
	

	 }
	 
function funhidden(){
	
	
	
	 if (document.getElementById('interbranch').checked) {
		 document.getElementById('intertick').value=1;
		 
		$("#branch").prop("hidden", false);
	}
	else {
		document.getElementById('intertick').value="";
		$("#branch").prop("hidden", true);
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
				optionsauth += '<option value="' + headIdItems[i] + '">'
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
			var mainacItems = items[0].split(",");
			var mainacIdItems = items[1].split(",");
			var optionsauth = '';
			optionsauth += '<option value=""> -- select --</option>';
			for (var i = 0; i < mainacItems.length; i++) {
				//alert(mainacIdItems[i]);
				optionsauth += '<option value="' + mainacIdItems[i] + '">'
						+ mainacItems[i] + '</option>';
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

	
	
	//frmAccountmaster.submit();		
}

/* function checkden(tran)
{
	
	
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText.trim();

		
				if(parseInt(items)==255 || parseInt(items)==340)
					{
					
					document.getElementById("errormsg").innerText=" Transaction  ";
					return 0;
					}
				
				
				else{
				
					 
					 if ($("#mode").val() =="view") {
							$('#category1').attr('disabled', false);
							$('#category2').attr('disabled', false);
							$('#category3').attr('disabled', false);
						 $('#mainaccgroup').attr('disabled', false);
					 }
					  
					 
				$('#frmAccountmaster').submit();
					
				}
				
				
				//setValues();
			} else {
			}
		}
		x.open("GET", 'checkden.jsp?tran='+tran, true);
		x.send();
} */
function funNotify(){
	
	//alert(document.getElementById("tansaccgroup").value);
	
if (document.getElementById('category3').checked) {
	 
	 var currs=document.getElementById("currs").value; 
		
	 if(currs=="")
		 {
		 document.getElementById("errormsg").innerText=" * Select Currency";
		 return 0;
		 }
	
	 var ratess=document.getElementById("ratess").value; 
		
	 if(parseFloat(ratess)>0)
		 {
		 
		 }
	 else
		 {
		 document.getElementById("ratess").focus();
		 document.getElementById("errormsg").innerText=" * Rate Should Be Greater Than Zero";
		 return 0;
		 }
	
}
	
	
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
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
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
			 document.getElementById("errormsg").innerText="Account Code Already Exists";
		 return 0;
		 }
		 else{
			 document.getElementById("errormsg").innerText="";
			
			 }
		 }
	/* 	var tran=document.getElementById("tansaccgroup").value;
		
		if(parseInt(tran)>0)
			{
			//alert("-"+tran);
			checkden(tran);
			
			}
		
		else{ */
			
	
	 
	 if ($("#mode").val() =="view") {
			$('#category1').attr('disabled', false);
			$('#category2').attr('disabled', false);
			$('#category3').attr('disabled', false);
		 $('#mainaccgroup').attr('disabled', false);
	  /*  } */
	 
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
	  
	var x=new XMLHttpRequest();
	
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		 	var items= x.responseText.trim();
		 	
		 	
		 		 if(items!="")
		 		{
		 			document.getElementById("codeval").value=1;
		 			document.getElementById("errormsg").innerText="Account Code Already Exists";
		 			return  false;
		 			 
		 		}
		 		 else
		 			 {
		 			document.getElementById("codeval").value="";
		 			document.getElementById("errormsg").innerText="";
		 			return  true;
		 			 }
		 		
		 }
	       else
		  {
	    	   
		  }
    }
	x.open("GET", 'checkAcccode.jsp?code='+code+'&masterdoc='+masterdoc, true);
    x.send();
	}  
   function getbranch() {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchone").html(optionsauth);
				if($('#interbr1').val()!="")
		 		{
		 		//alert("1");
		 		$('#branchone').val($('#interbr1').val());
		 		}
				//getSecbranch(second);
			} else {
			}
		}
		x.open("GET", "getbranch.jsp", true);
		x.send();
		
	}
   function getSecbranch(second)
   {
	   var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items = x.responseText;
				items = items.split('####');
				var headItems = items[0].split(",");
				var headIdItems = items[1].split(",");
				var optionsauth = '';
				for (var i = 0; i < headItems.length; i++) {
					optionsauth += '<option value="' + headIdItems[i] + '">'
							+ headItems[i] + '</option>';
				}
				$("select#branchtwo").html(optionsauth);
				if($('#interbr2').val()!="")
				{
		 		//alert("2");
				$('#branchtwo').val($('#interbr2').val());
				}
				//setValues();
			} else {
			}
		}
		x.open("GET", 'secondBranch.jsp?second='+second, true);
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
 	
 	 if(document.getElementById("intertick").value==1)
	  {
	 
	  document.getElementById("interbranch").checked = true;
	  

	  }
 	 else
 		 {
 		document.getElementById("interbranch").checked = false;
 		  
 		 
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
		$("#date_accountmaster").jqxDateTimeInput('val', $('#datehidden').val());
	}

		if($('#msg').val()!=""){
		   $.messager.alert('Message',$('#msg').val());
		  }
		 delvalueChange();
		document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
var second=$('#interbr1').val();
if(second!=""){
	document.getElementById('interbranch').checked=true;
}
	
	 funhidden();
	 getSecbranch(second);
}

function checkreq()
{
	
if(document.getElementById('radiotick').value==1)
	{
	

	if(document.getElementById("mainacconame").value=="")
		{ 
		
		
		 document.getElementById("errormsg").innerText=" *Enter Account Name";
		 return 0;
		
		}
	}
else  if(document.getElementById('radiotick').value==2)
{
     if(document.getElementById("subaccname").value=="")
	{
    	 
    	 document.getElementById("errormsg").innerText=" *Enter SubAccount Name";
    	 return 0;
	}
}
else  if(document.getElementById('radiotick').value==3)
{
    if(document.getElementById("transaccname").value=="")
	{ 
    	
    	document.getElementById("errormsg").innerText=" *Enter TraAccount Name";
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
    var reurl=url.split("accountsmaster");
    top.addTab("ChartOfAccounts",reurl[0]+"accountsmaster/chartOfAccount.jsp");
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
 	   document.getElementById("errormsg").innerText=" Enter Numbers Only";  
       
        return false;
    	}
    document.getElementById("errormsg").innerText="";  
    return true;
}	
function getConfig() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
		var items = x.responseText.trim();
		//alert(items)   
		if(parseInt(items)>0){ 
			       $('#subaccountfield').show();
			}else{
				$('#subaccountfield').hide();
			}
	}
}		
	x.open("GET", "subaccConfig.jsp",true);
	x.send();
}	
</script>


</head>
<body onload="getHead();getMainac();getbranch();setValues();getConfig();">

<div id="mainBG" class="homeContent" data-type="background">
<jsp:include page="../../../../header.jsp"></jsp:include>
<br>

<form id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">

  <!-- TOP: Date and Doc No on same line -->
  <div class="receipt-header">
    <div class="top-grid">
      <div class="form-item">
        <label for="date_accountmaster">Date</label>
        <div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div>
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
      </div>

      <div style="display:flex; align-items:center; gap:20px;">
        <!-- leave middle column for spacing / future controls -->
        <div style="flex:1"></div>
      </div>

      <div class="form-item" style="justify-self:end;">
        <label for="docno" style="margin-right:8px;">Doc No.</label>
        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' />
      </div>
    </div>

    <!-- status / message line -->
    <div style="margin-top:10px;">
      <span id="errormsg" style="color:#d62828;font-weight:600;"></span>
    </div>

    <!-- MAIN / SUB / TRANSACTION blocks -->
    <div style="margin-top:14px; display:grid; grid-template-columns: 1fr 1fr; gap: 14px;">

      <!-- LEFT: Main Account block -->
      <!-- Main Account Block -->
<div class="ui-block">
    <label class="block-title">
        <input type="radio" id="category1" name="category" value="mainaccount"
               onchange="fundisable();"> Main Account
    </label>

    <!-- LABEL ROW -->
    <div class="ui-row-labels">
        <span>Account Group</span>
        <span>Account Code</span>
        <span>Account Name</span>
    </div>

    <!-- INPUT ROW -->
    <div class="ui-row-inputs">
        <select name="mainaccgroup" id="mainaccgroup">
            <option value="-1">--Select--</option>
        </select>

        <input type="text" name="mainacccode" id="mainacccode"
               onblur="maincheck(this.value)" onkeypress="return isNumber(event);" />

        <input type="text" name="mainacconame" id="mainacconame"
               onblur="dismassge()" />
    </div>

    <input type="hidden" name="main_account" id="main_account">
</div>
      

      <!-- RIGHT: Sub Account block (keeps consistent look but remains separate) -->
      <!-- Sub Account Block -->
<div class="ui-block">
    <label class="block-title">
        <input type="radio" id="category2" name="category" value="subaccount"
               onchange="fundisable();"> Sub Account
    </label>

    <!-- LABEL ROW -->
    <div class="ui-row-labels">
        <span>Main Account Group</span>
        <span>Account Code</span>
        <span>Account Name</span>
    </div>

    <!-- INPUT ROW -->
    <div class="ui-row-inputs">
        <div class="inline-field">
            <select name="subaccgroup" id="subaccgroup"
                    onchange="getAcgroup(this.value,1);" onfocus="funclear2();">
                <option value="-1">--Select--</option>
            </select>
            <input type="text" id="subaccgpname" name="subaccgpname">
        </div>

        <input type="text" name="subacccode" id="subacccode"
               onblur="subcheck(this.value)" onkeypress="return isNumber(event);" />

        <input type="text" name="subaccname" id="subaccname"
               onblur="dismassge()" />
    </div>

    <input type="hidden" name="sub_account" id="sub_account">
</div>
      

    <!-- Transaction block spans full width below -->
    <!-- Transaction Block -->
<div class="ui-block">
    <label class="block-title">
        <input type="radio" id="category3" name="category" value="transaction"
               onchange="fundisable();"> Transaction
    </label>

    <!-- ROW 1 LABELS -->
    <div class="ui-row-labels">
        <span>Main Account Group</span>
        <span>Account Name</span>
    </div>

    <!-- ROW 1 INPUTS -->
    <div class="ui-row-inputs">
        <div class="inline-field">
            <select id="tansaccgroup" name="tansaccgroup"
                    onchange="getAcgroup(this.value,2);" onfocus="funclear3();">
                <option value="-1">--Select--</option>
            </select>
            <input type="text" id="transcaccgpname" name="transcaccgpname">
        </div>

        <input type="text" id="transaccname" name="transaccname" onblur="dismassge()">
    </div>

    <!-- ROW 2 LABELS -->
    <div class="ui-row-labels">
        <span>Account Code</span>
        <span>Currency</span>
        <span>Rate</span>
    </div>

    <!-- ROW 2 INPUTS -->
    <div class="ui-row-inputs">
        <input type="text" id="transacccode" name="transacccode"
               onblur="trancheck(this.value)" onkeypress="return isNumber(event);" />

        <input type="text" id="currs" name="currs" onkeydown="getaccountdetails(event);" />

        <input type="text" id="ratess" name="ratess"
               onblur="funRoundRate(this.value,this.id);" style="text-align:right;">
    </div>

    <!-- ROW 3 -->
    <div class="ui-row-labels">
        <span>Inter Branch Account</span>
        <span>Branch</span>
    </div>

    <div class="ui-row-inputs">
        <input type="checkbox" id="interbranch" name="interbranch"
               onchange="funhidden();" value="1">

        <div class="inline-field">
            <select name="branchone" id="branchone">
                <option value="0">--Select--</option>
            </select>
            <select name="branchtwo" id="branchtwo">
                <option value="0">--Select--</option>
            </select>
        </div>
    </div>

    <input type="hidden" name="tran_account" id="tran_account">
</div>
      <!-- Row 3: Inter branch account checkbox and branch selectors -->
      <div style="display:flex; gap:12px; align-items:center; margin-top:14px;">
        <div style="display:flex; align-items:center; gap:8px;">
          <input type="checkbox" id="interbranch" name="interbranch" onchange="funhidden();" value="1"/>
          <label style="margin:0; font-weight:600; color:#253858;">Inter branch Account</label>
        </div>

        <div id="branch" style="display:none; align-items:center; gap:8px;">
          <div class="label" style="min-width:auto; margin-right:8px;">Branch</div>
          <select name="branchone" id="branchone" style="height:38px;" value='<s:property value="branchone"/>' onClick="getSecbranch(this.value)">
            <option value="0">--Select--</option>
          </select>
          <span style="padding:0 6px;"></span>
          <select name="branchtwo" id="branchtwo" style="height:38px;" value='<s:property value="branchtwo"/>'>
            <option value="0">--Select--</option>
          </select>
        </div>
      </div>

    </div> <!-- end transaction block -->

  </div> <!-- end receipt-header -->

  <!-- hidden/meta fields preserved -->
  <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
  <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'>
  <input type="hidden" id="currsid" name="currsid" value='<s:property value="currsid"/>'>
  <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
  <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
  <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
  <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
  <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
  <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
  <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
  <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
  <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
  <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>
  <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>

</form>

<!-- account search window -->
<div id="accountSearchwindow"><div></div></div>

</div> <!-- mainBG -->


</body>
</html>
