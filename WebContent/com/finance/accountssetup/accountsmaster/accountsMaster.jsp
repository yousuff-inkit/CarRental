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
form label.error {
color:red;
  font-weight:bold;
}


.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

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
    /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
}

.receipt-header {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 16px;
    border-radius: 12px;
    padding: 0px 24px;
    font-size: 2vh;
}
.receipt-header label {
    font-weight: 500;
    color: #333;
    margin-right: 8px;
}
.receipt-header input[type="text"] {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 1rem;
    width: 120px;
    background: #fff;
    transition: border-color 0.2s;
}
.receipt-header input[type="text"]:focus {
    border-color: #007bff;
    outline: none;
}
.receipt-header button {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 16px;
    font-weight: 500;
    cursor: pointer;
    transition: background 0.2s;
}
.receipt-header button:hover {
    background: #0056b3;
}
#txtStatus {
    font-size: 1rem;
    font-weight: 600;
    color: #e67e22;
    margin-left: 12px;
}

.section-row {
    display: flex;
    gap: 26px;
    margin-bottom: 24px;
}
.section-block {
    flex: 1;
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
}

.section-block h2 {
    font-size: 1.09em;
    font-weight: 500;
    margin: 0 0 16px 0;
    color: #253858;
}

.section-block .form-group {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 12px;
}

.section-block label {
    min-width: 110px;
    text-align: right;
    font-weight: 500;
    color: #253858;
}

.section-block input[type="text"],
.section-block select {
    flex: 1;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
}

.section-block input[type="text"]:focus,
.section-block select:focus {
    border-color: #007bff;
    outline: none;
}


.table-section {
    margin-bottom: 18px;
}
.table-section h3 {
    color: #253858;
    font-size: 1.04em;
    font-weight: 600;
}
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}
.cr-table th, .cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 1em;
}
.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}
.cr-table tr:last-child td {
    border-bottom: none;
}



/* =============== PREMIUM BLUE SECTION STYLE =============== */

/* Outer section box (the big white one inside your page) */
.section-block, 
.cr-table, 
#main, #sub, #trans, #main1, #sub1, #trans1 {
    background: #ffffff !important;
    border-radius: 14px !important;
    padding: 20px 22px !important;
    box-shadow: 0 4px 14px rgba(120,160,255,0.15) !important;
    border: 1px solid #dfe6ff !important;
}

/* Section headings (Main Account / Sub Account / Transaction) */
.section-block h2,
#main1 label, #sub1 label, #trans1 label {
    background: linear-gradient(90deg,#6faaff,#4b8cff) !important;
    padding: 12px 18px !important;
    border-radius: 10px !important;
    color: #fff !important;
    font-size: 1.05rem !important;
    font-weight: 600 !important;
    margin-bottom: 18px !important;
    box-shadow: 0 3px 10px rgba(90,130,255,0.25) !important;
}

/* Labels */
.section-block label,
#main label, #sub label, #trans label {
    font-size: .90rem !important;
    font-weight: 600 !important;
    color: #2b3f72 !important;
}

/* Input Fields */
.section-block input[type="text"],
.section-block select,
#main input, #sub input, #trans input,
#main select, #sub select, #trans select {
    height: 34px !important;
    border-radius: 10px !important;
    background: #ffffff !important;
    border: 1px solid #c9d7ff !important;
    padding: 6px 12px !important;
    font-size: .88rem !important;
    font-family: 'Poppins', sans-serif !important;
    box-shadow: 0 2px 6px rgba(160,180,255,0.18) !important;
    transition: 0.2s ease-in-out !important;
}

/* Input Focus Effect – Black border + glow */
.section-block input[type="text"]:focus,
.section-block select:focus,
#main input:focus, #sub input:focus, #trans input:focus,
#main select:focus, #sub select:focus, #trans select:focus {
    border-color: #000 !important;
    box-shadow: 0 0 0 2px rgba(0,0,0,0.20) !important;
    outline: none !important;
}

/* The tiny radio button label background fix */
#main1, #sub1, #trans1 {
    background: transparent !important;
    border: none !important;
    padding: 0 !important;
    box-shadow: none !important;
}

/* Radio label alignment */
#main1 td label,
#sub1 td label,
#trans1 td label {
    background: none !important;
    color: #2b3f72 !important;
    padding-left: 4px !important;
}

/* Fix tables inside sections */
.cr-table th {
    background: #eff4ff !important;
    font-weight: 600 !important;
    color: #2b3f72 !important;
}

/* ---------------- SECTION LAYOUT FIX ---------------- */

.section-block {
    background: #ffffff !important;
    border-radius: 16px !important;
    padding: 28px 28px !important;
    margin-bottom: 28px !important;
    box-shadow: 0 4px 22px rgba(95,135,255,0.10) !important;
    border: 1px solid #e7ecff !important;
    transition: transform .25s ease, box-shadow .25s ease !important;
}

/* Lift on hover */
.section-block:hover {
    transform: translateY(-4px) !important;
    box-shadow: 0 10px 28px rgba(95,135,255,0.15) !important;
}

/* Section title */
.section-block h2 {
    margin-bottom: 22px !important;
    color: #27408a !important;
    font-weight: 600 !important;
}

/* Group rows */
.section-block .form-group {
    display: flex !important;
    align-items: center !important;
    gap: 22px !important;
    margin-bottom: 20px !important;
}

/* Label fix */
.section-block label {
    min-width: 150px !important;
    text-align: right !important;
    font-weight: 600 !important;
    color: #263b75 !important;
}

/* Input spacing fix */
.section-block input[type="text"],
.section-block select {
    width: 100% !important;
    border-radius: 12px !important;
    padding: 10px 14px !important;
    border: 1px solid #ccd9ff !important;
    background: #ffffff !important;
    box-shadow: 0 2px 7px rgba(90,120,255,0.18) !important;
    transition: border-color .2s ease, box-shadow .2s ease !important;
}

/* Focus border highlight */
.section-block input[type="text"]:focus,
.section-block select:focus {
    border: 2px solid #3e78ff !important;
    box-shadow: 0 0 0 3px rgba(62,120,255,0.20) !important;
    outline: none !important;
}

/* Fix the specific issue: RATE & ACCOUNT NAME collision */
#transaccname, #ratess, #currs {
    margin-right: 12px !important;
}

/* For rate field so it never touches right edge */
#ratess {
    margin-left: 12px !important;
}

/* Add breathing room for inline inputs */
.inline-field-group {
    display: flex !important;
    align-items: center !important;
    gap: 16px !important;
}




.gl-input {
    height: 34px;
    border-radius: 10px;
    border: 1px solid #c4d3ff;
    padding: 6px 12px;
    background: #ffffff;
    font-size: 0.95rem;
    box-shadow: 0 3px 8px rgba(180,200,255,0.25);
    transition: 0.2s ease;
}

.gl-input:focus {
    border-color: #478dff;
    box-shadow: 0 0 0 2px rgba(71,141,255,0.25);
    outline: none;
    transform: translateY(-1px);
}



/*--------------------------------------
  FIX FOR MERGED FIELDS & ALIGNMENT
---------------------------------------*/

/* Convert table rows to flex rows */
#main tr,
#sub tr,
#trans tr {
    display: flex !important;
    align-items: center !important;
    gap: 20px !important;
    margin-bottom: 18px !important;
}

/* Make each cell behave like a block */
#main td,
#sub td,
#trans td {
    display: block !important;
    width: auto !important;
}

/* Labels aligned right */
#main label,
#sub label,
#trans label {
    min-width: 140px !important;
    font-weight: 600;
    color: #253858;
}

/* Inputs fixed clean width */
#main input[type="text"],
#sub input[type="text"],
#trans input[type="text"],
#main select,
#sub select,
#trans select {
    width: 220px !important;
    height: 38px !important;
    border-radius: 10px !important;
    background: #ffffff !important;
    border: 1px solid #c4d3ff !important;
    padding: 6px 12px !important;
    box-shadow: 0 2px 6px rgba(150,175,255,0.15) !important;
    transition: 0.2s;
}

/* Focus highlight */
#main input:focus,
#sub input:focus,
#trans input:focus,
#main select:focus,
#sub select:focus,
#trans select:focus {
    border-color: #1a73e8 !important;
    box-shadow: 0 0 0 3px rgba(26,115,232,0.25) !important;
    outline: none !important;
}

/* Section box styling */
.section-block {
    padding: 25px !important;
    background: #fbfcff !important;
    border-radius: 16px !important;
    box-shadow: 0 6px 20px rgba(100,120,255,0.08) !important;
    border: 1px solid #e4ecff !important;
}

/* Lift effect (just like the search button) */
.section-block:hover {
    transform: translateY(-3px);
    transition: 0.2s ease;
    box-shadow: 0 10px 26px rgba(100,120,255,0.12) !important;
}



/* FIX ALIGNMENT FOR ALL ACCOUNT SECTION FIELDS */
#mainBG table,
#mainBG td {
    border-collapse: collapse !important;
}

/* Row container */
.account-row {
    display: flex;
    align-items: center;
    gap: 24px;
    margin-bottom: 18px;
    width: 100%;
}

/* Label styling */
.account-row label {
    min-width: 140px;
    font-size: 0.9rem;
    font-weight: 600;
    color: #2a2a55;
}

/* Input + Select uniform design */
.account-row input[type="text"],
.account-row select {
    height: 38px;
    padding: 6px 12px;
    border: 1px solid #c4d3ff;
    border-radius: 10px;
    background: #ffffff;
    font-size: 0.9rem;
    width: 230px !important;
    transition: all .15s ease-in-out;
}

/* Focus effect */
.account-row input[type="text"]:focus,
.account-row select:focus {
    border-color: #478dff;
    box-shadow: 0 0 0 3px rgba(71,141,255,0.18);
    outline: none;
}

/* Small inputs (Currency, Rate) */
.small-input {
    width: 160px !important;
}

/* Card spacing fix */
.section-block {
    padding: 28px 28px !important;
}


.gl-row {
    display: flex;
    align-items: center;
    gap: 22px;
    margin-bottom: 20px;
    width: 95%;
}

.gl-row label {
    min-width: 170px;
    font-weight: 600;
    color: #1d2d60;
}

.gl-input,
.gl-row select {
    height: 38px;
    padding: 6px 12px;
    border: 1px solid #c8d6ff;
    border-radius: 10px;
    background: white;
    width: 260px;
}

.gl-small {
    width: 150px;
    height: 38px;
    padding: 6px 12px;
    border: 1px solid #c8d6ff;
    border-radius: 10px;
}

.gl-input:focus,
.gl-row select:focus,
.gl-small:focus {
    border-color: black !important;
    box-shadow: 0 0 4px rgba(0,0,0,0.2);
}




/* ===========================
   TRANSACTION SECTION FIX
   =========================== */

#trans {
    width: 100%;
}

#trans td {
    padding: 12px 10px;
    vertical-align: middle;
}

/* Bigger input boxes */
#trans input[type="text"],
#trans select {
    width: 230px !important;
    height: 38px !important;
    font-size: 0.95rem !important;
    border-radius: 12px !important;
    padding: 6px 12px !important;
}

/* Account Name + Currency + Rate layout */
.trans-row {
    display: flex;
    align-items: flex-end;
    gap: 22px;
    width: 100%;
}

/* The two small fields */
.trans-small {
    display: flex;
    flex-direction: column;
}

.trans-small input {
    width: 150px !important;
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
<form  id="frmAccountmaster" action="saveAccountmaster" method="post" autocomplete="off">

    <div class="hidden-scrollbar receipt-header">

<table class="cr-table" width="100%" >


<tr>
<td>
 <table class="cr-table" width="100%" >
 <tr><td width="6%" align="right">Date</td>
 <td width="31%"  align="left"><div id="date_accountmaster" name="date_accountmaster" value='<s:property value="date_accountmaster"/>'></div></td> 
	<td width="46%" align="right">Doc No.</td><td width="17%"><input type="text" name="docno" id="docno" value='<s:property value="docno"/>' >
			</td></tr></table>
 <table class="cr-table" width="100%">
<tr>
<td width="40%">

<table class="cr-table" id="main1"><tr><td><input type="radio" id="category1" name="category" value="mainaccount" onchange="fundisable();"><label>Main Account</label></td>
</tr></table>

<table class="cr-table" width="100%" id="main" >
  <tr>
    <td width="50%" align="right"><div><label>Account Group</label></div></td>
    <td width="%"><select name="mainaccgroup" id="mainaccgroup"  style="width:92%;"  value='<s:property value="mainaccgroup"/>' onchange="funclear1();" >
      <option value="-1">--Select--</option>
    </select><%-- <input type="text" id="maindata" name="maindata" value='<s:property value="maindata"/>'> --%></td> 
    </tr>
  <tr>
     <td align="right"><div><label>Account Code</label></div></td>
    <td><input type="text" name="mainacccode" id="mainacccode" style="width:90%;" value='<s:property value="mainacccode"/>' onblur="maincheck(this.value)" onkeypress="javascript:return isNumber (event);"></td>
  </tr>
  <tr>
     <td align="right"><div><label>Account Name</label></div></td>
    <td><input type="text" name="mainacconame" id="mainacconame" style="width:90%;"  value='<s:property value="mainacconame"/>' onblur="dismassge()">
    <input type="hidden" name="main_account" id="main_account"  value='<s:property value="main_account"/>' />
        </td>
  </tr>
  </table>

  
    </td>
  <td>
  
  <fieldset id="subaccountfield">
  <table class="cr-table" id="sub1"> <tr ><td><input type="radio" id="category2" name="category" value="subaccount" onchange="fundisable();"><label>Sub Account</label></td>
</tr></table>
 
 <table class="cr-table" width="100%"  id="sub">
    <tr>
    <td width="20%" align="right"><div>Main account Group</div></td>
   <td width="62%"><select name="subaccgroup" id="subaccgroup"  style="width:40.5%;"  onChange="getAcgroup(this.value,1);" onfocus="funclear2();" value='<s:property value="subaccgroup"/>' > 
        <option value="-1">--Select--</option>
        </select>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="subaccgpname" name=subaccgpname style="width:40%;" value='<s:property value="subaccgpname"/>'  />
        
        
        </td>
    </tr>
  <tr>
     <td align="right" ><div>Account Code</div></td>
    <td ><input type="text" name="subacccode" id="subacccode" style="width:40%;" value='<s:property value="subacccode"/>' onblur="subcheck(this.value)" onkeypress="javascript:return isNumber (event);"></td>
  </tr>
  <tr>
     <td align="right"><div>Account Name</div></td>
    <td ><input type="text" name="subaccname" id="subaccname" style="width:40%;" value='<s:property value="subaccname"/>' onblur="dismassge()" />
    <input type="hidden" name="sub_account" id="sub_account"  value='<s:property value="sub_account"/>' />
    </td>
  </tr>
  </table>
  </fieldset>
  
    </td> </tr>    </table>
  
 <table class="cr-table" width="100%">
 <tr >
 <td width="60" >
 
     <fieldset>
     <table id="trans1"> <tr align="center"><td><input type="radio" id="category3" name="category" value="transaction" onchange="fundisable();"><label>Transaction</label></td></tr></table>






 <table width="100%"  id="trans"   >
    <div class="gl-row">
    <label>Main Account Group</label>

    <select id="tansaccgroup" name="tansaccgroup"
            onChange="getAcgroup(this.value,2);" onfocus="funclear3();">
        <option value="-1">--Select--</option>
    </select>

    <input type="text" name="transcaccgpname" id="transcaccgpname" class="gl-small">
</div>

<div class="gl-row">
    <label>Account Code</label>
    <input type="text" name="transacccode" id="transacccode"
           onblur="trancheck(this.value)" onkeypress="javascript:return isNumber(event);">
</div>

<div class="gl-row">
    <label>Account Name</label>

    <input type="text" name="transaccname" id="transaccname" class="gl-input">

    <input type="text" name="currs" id="currs" class="gl-small" placeholder="Currency"
           onkeydown="getaccountdetails(event);">

    <input type="text" name="ratess" id="ratess" class="gl-small" placeholder="Rate"
           onblur="funRoundRate(this.value,this.id);" onkeypress="javascript:return isNumber(event);" >
</div>

<div class="gl-row">
    <label></label>
    <input type="checkbox" id="interbranch" name="interbranch" onchange="funhidden();" value="1">
    <span>Inter branch Account</span>
</div>

<div class="gl-row" id="branch" hidden="true">
    <label>Branch</label>

    <select name="branchone" id="branchone" required="required"
            onClick="getSecbranch(this.value)">
        <option value="0">--Select--</option>
    </select>

    <select name="branchtwo" id="branchtwo" required="required">
        <option value="0">--Select--</option>
    </select>
</div>
    
    
    
    
    
    </table>
  </fieldset>
  
  
  </td>
  <td width=30%>
  <div  hidden="true">
    <input type="radio" name="data" value="debit" checked>Debit<br>
    <input type="radio" name="data" value="Credit">Credit
  
  </div>
  
  </td></tr></table>
  </td></tr>
  <tr><td><input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'></td>
  	<td><input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/>
  	<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
  <input type="hidden" id="radiotick" name="radiotick" value='<s:property value="radiotick"/>'> 
   <input type="hidden" id="currsid" name="currsid" value='<s:property value="currsid"/>'>
  
  <input type="hidden" id="checksetval" name="checksetval" value='<s:property value="checksetval"/>'>
  <input type="hidden" id="subchecksetval" name="subchecksetval" value='<s:property value="subchecksetval"/>'>
  <input type="hidden" id="tranchecksetval" name="tranchecksetval" value='<s:property value="tranchecksetval"/>'>
  </td>         
  <td>
  
  <input type="hidden" id="intertick" name="intertick" value='<s:property value="intertick"/>'>
  
  <input type="hidden" id="interbr1" name="interbr1" value='<s:property value="interbr1"/>'>
  <input type="hidden" id="interbr2" name="interbr2" value='<s:property value="interbr2"/>'>
  
    <input type="hidden" id="otherdis" name="otherdis" value='<s:property value="otherdis"/>'>
  
  
   <input type="hidden" id="radiosaveval" name="radiosaveval" value='<s:property value="radiosaveval"/>'>
  <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
  

 
  <input type="hidden" id="maindel" name="maindel" value='<s:property value="maindel"/>'>  <!--  for delete condition chk -->
 
   <input type="hidden" id="codeval" name="codeval" value='<s:property value="codeval"/>'>  <!-- foe code VAL -->
 

  
  </td>
  </tr>          
  </table>

<br>

    </div>
  </form>
  </div>
  
    <div id="accountSearchwindow">
	   <div></div>
	</div>
  </body>
  </html>
  