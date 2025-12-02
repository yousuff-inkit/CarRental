<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="ISO-8859-1">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<link rel="stylesheet" href="<%=contextPath%>/css/global.css" type="text/css">

<script type="text/javascript">
	$(document).ready(function() {

		
		 $("#vehpurorderDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});

		 $("#vehpurorderdelDate").jqxDateTimeInput({ width: '120px', height: '15px', formatString:"dd.MM.yyyy"});
		 $('#brandsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
	     $('#brandsearchwndow').jqxWindow('close'); 

	     $('#modelsearchwndow').jqxWindow({ width: '40%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y:60 }, keyboardCloseKey: 27});
	     $('#modelsearchwndow').jqxWindow('close');
	     $('#colorsearchwndow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Color Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
	     $('#colorsearchwndow').jqxWindow('close');
	     $('#groupwindow').jqxWindow({ width: '25%', height: '55%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 800, y:60 }, keyboardCloseKey: 27});
	     $('#groupwindow').jqxWindow('close');
	     $('#accountSearchwindow').jqxWindow({ width: '50%', height: '62%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 150, y: 60 }, keyboardCloseKey: 27});
		 $('#accountSearchwindow').jqxWindow('close');
		     	
	     $('#refnosearchwindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '75%' ,maxWidth: '50%' , title: ' Search' ,position: { x: 500, y: 60 }, keyboardCloseKey: 27});
		 $('#refnosearchwindow').jqxWindow('close'); 
			   
			   $('#vehrefno').dblclick(function(){
			  	    $('#refnosearchwindow').jqxWindow('open');
			  	    refsearchContent('vehreqRefnoSearch.jsp?'); 
			   }); 
			   
	    $('#accid').dblclick(function(){
	    	   if($('#mode').val()=="A" || $('#mode').val()=="E" )
		          {
		  	    $('#accountSearchwindow').jqxWindow('open');
		  	    accountSearchContent('accountsDetailsSearch.jsp');
		          }
	  }); 
	     
	    $('#vehpurorderDate').on('change', function (event) {
	        var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
	  	 	 if ($("#mode").val() == "A" || $('#mode').val()=="E" ) {   
	     funDateInPeriod(maindate);
	    	 }
	   });
	});
	function getrefDetails(event){
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#refnosearchwindow').jqxWindow('open');
	 	 refsearchContent('vehreqRefnoSearch.jsp?');  }
	 	 else{
	 		 }
	 	 }  
	function refsearchContent(url) {
	          $.get(url).done(function (data) {
	        $('#refnosearchwindow').jqxWindow('setContent', data);
		}); 
	}
	function getaccountdetails(event){
		  if($('#mode').val()=="A" || $('#mode').val()=="E" )
          {
	 	 var x= event.keyCode;
	 	 if(x==114){
	 	  $('#accountSearchwindow').jqxWindow('open');
	 	 accountSearchContent('accountsDetailsSearch.jsp');    }
	 	 else{
	 		 }
          }
	 	 }  
	function accountSearchContent(url) {
	          $.get(url).done(function (data) {
	        $('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
	}
    function brandinfoSearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#brandsearchwndow').jqxWindow('open');
			 $('#brandsearchwndow').jqxWindow('setContent', data);
		}); 
	} 
    function modelinfoSearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#modelsearchwndow').jqxWindow('open');
			 $('#modelsearchwndow').jqxWindow('setContent', data);
		}); 
	} 
    function colorinfoSearchContent(url) {
		 $.get(url).done(function (data) {
			 $('#colorsearchwndow').jqxWindow('open');
			 $('#colorsearchwndow').jqxWindow('setContent', data);
		}); 
	}
	function groupSearchContent(url) {
    	$.get(url).done(function (data) {
        	$('#groupwindow').jqxWindow('open');
           	$('#groupwindow').jqxWindow('setContent', data);
		}); 
    } 
	 function funReadOnly(){
		 funtaxchk();
			$('#frmpurorder input').attr('readonly', true );
			$('#frmpurorder select').attr('disabled', true);
			$('#vehpurorderDate').jqxDateTimeInput({disabled: true});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: true});
			$("#vehoredergrid").jqxGrid({ disabled: true});
			 $('#vehrefno').attr('disabled', true);
			  $('#nettotal').attr('readonly', true);
			  $('#taxamount').attr('readonly', true); 
	 }
	 function funRemoveReadOnly(){
		 funtaxchk();
		  $('#taxamount').attr('readonly', true); 
		 $('#nettotal').attr('readonly', true);
			$('#frmpurorder input').attr('readonly', false );
			$('#frmpurorder select').attr('disabled', false);
			$("#vehoredergrid").jqxGrid({ disabled: false});
			$('#vehpurorderdelDate').jqxDateTimeInput({disabled: false});
			$('#vehpurorderDate').jqxDateTimeInput({disabled: false});
			 $('#vehrefno').attr('disabled', true);
			$('#docno').attr('readonly', true);
			  $('#vehpuraccname').attr('readonly', true);
			  $('#accid').attr('readonly', true);
			  $('#vehrefno').attr('readonly', true);
			if ($("#mode").val() == "A") {
				$('#vehpurorderdelDate').val(new Date());
				$('#vehpurorderDate').val(new Date());
				 $("#vehoredergrid").jqxGrid('clear');
				    $("#vehoredergrid").jqxGrid('addrow', null, {});
			   }
			if ($("#mode").val() == "E") {
			if($('#vehtype').val()=="VPR")
			  {
			  $('#vehrefno').attr('disabled', false);
		     $('#vehrefno').attr('readonly', true);
			  }
			}
	 }
	 function funtaxchk()
	    {
		 	var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
					{
					 $("#taxtable").show();
					}
				else
					{
					 $("#taxtable").hide();
					}
				} else {
				}
			}
			x.open("GET", "chkconfig.jsp?", true);
			x.send();
		}
		function funchkforedit()
	    {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();	
					if(parseInt(items)>0)
						{
						 $("#btnEdit").attr('disabled', true );
						 $("#btnDelete").attr('disabled', true ); 
						}
					else
						{
						 $("#btnEdit").attr('disabled', false);
						 $("#btnDelete").attr('disabled', false);
						}
				} else {
				}
			}
			x.open("GET", "orderlinkchk.jsp?masterdoc_no="+document.getElementById("masterdoc_no").value, true);
			x.send();
		}
	   function funrefdisslno()
	   {
		   if($('#vehtype').val()=="VPR") 
			  {
			   $('#vehrefno').attr('disabled', false);
			  } 
		   else
			   {
			   $('#vehrefno').val("");
			   $('#vehrefno').attr('disabled', true);
			   }
	   }
	 function funSearchLoad(){
		changeContent('vehOrederMastersearch.jsp'); 
	 }
	 function funChkButton() {
	 }
	 function funFocus()
	    {
	    	$('#vehpurorderDate').jqxDateTimeInput('focus'); 	    		
	    }
	  function funNotify(){
		  var maindate = $('#vehpurorderDate').jqxDateTimeInput('getDate');
		   var validdate=funDateInPeriod(maindate);
		   if(validdate==0){
			   return 0; 
		   }
			if( document.getElementById("vehtype").value=="VPR")
			{
	           var refno= document.getElementById('masterrefno').value;
			 if(refno=="")
			 {
				 document.getElementById("errormsg").innerText=" Select Ref NO";	
				 document.getElementById('vehrefno').focus();
				 return 0;
			 }
			 else
				 {
				 document.getElementById("errormsg").innerText="";
				 }
			}
		var purid= document.getElementById("accid").value;
		if(purid=="")
			{
			 document.getElementById("errormsg").innerText=" Select An Account";
			 document.getElementById("accid").focus();
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   } 
		var refval= document.getElementById("nettotal").value;
		  if(refval=="")
			{
			 document.getElementById("errormsg").innerText="Total is Empty";
			 return 0;
			   }
		else
			   {
			   document.getElementById("errormsg").innerText="";
			   }
		  var rows = $("#vehoredergrid").jqxGrid('getrows');
		    $('#vehoredergridlenght').val(rows.length);
		   for(var i=0 ; i < rows.length ; i++){
		    newTextBox = $(document.createElement("input"))
		       .attr("type", "dil")
               .attr("id", "vehodrtest"+i)
		       .attr("name", "vehodrtest"+i)
		       .attr("hidden", "true");   
		   newTextBox.val(rows[i].sr_no+"::"+rows[i].brdid+" :: "+rows[i].modid+" :: " 
				   +rows[i].specification+" :: "+rows[i].clrid+" :: "+rows[i].qty+" :: "+rows[i].price+" :: "+rows[i].total+" :: "+rows[i].saveqty+" :: "+rows[i].rowno+" :: "+rows[i].qutval+" :: "+rows[i].vehgroupid+" :: ");
		   newTextBox.appendTo('form');
		   }   
	    		return 1;
		} 
	 function  changeval()
	 {
		 if($('#vehtypeval').val()!="")
		  {
		  $('#vehtype').val($('#vehtypeval').val());
		  }
		 if($('#vehtypeval').val()=="VPR")
		  {
		  $('#vehrefno').attr('disabled', false);
	      $('#vehrefno').attr('readonly', true);
		  }
	 }
	 function diserror()
	 {
		 document.getElementById("errormsg").innerText=""; 
	 }
	  	  
	  function setValues(){
		  if($('#hidvehpurorderDate').val()){
				 $("#vehpurorderDate").jqxDateTimeInput('val', $('#hidvehpurorderDate').val());
			  }
		  if($('#hidvehpurorderdelDate').val()){
				 $("#vehpurorderdelDate").jqxDateTimeInput('val', $('#hidvehpurorderdelDate').val());
			  }
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			var indexVa5 = document.getElementById("masterdoc_no").value;
	         if(indexVa5>0){
	        	 funchkforedit();
	         $("#vehorder").load("vehorderDetails.jsp?masterdoc="+indexVa5);  
	         } 
	         changeval();
	         document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		}
	  	  
	  $(function(){
	        $('#frmpurorder').validate({
	        	 rules: { 
	        		 vehdesc:{maxlength:200}
	        	 },
		                 messages: {
		                	 vehdesc: {maxlength:"  Max 200 chars"}
	                 }
	        });});
	    function funPrintBtn(){
	   	   if (($("#mode").val() == "view") && $("#masterdoc_no").val()!="") {
	   	   var url=document.URL;
	          var reurl=url.split("savePurchaseorder");
	          $("#docno").prop("disabled", false);                
	  var win= window.open(reurl[0]+"printPurchorder?docno="+document.getElementById("masterdoc_no").value,"_blank","top=250,left=310,Width:800,Height:800,location=no,scrollbars=no,toolbar=yes");
	  win.focus();
	   	   } 
	   	   else {
	  	    	      $.messager.alert('Message','Select a Document....!','warning');
	  	    	      return false;
	  	    	     }
	  	    	
	   	}
</script>

<style>
/* general scroll + page styles (kept consistent with rentalrefund) */
html, body { height: 100%; overflow-y: auto; }
body::-webkit-scrollbar { width: 10px; }
body::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 8px; }
body::-webkit-scrollbar-thumb { background: #4da3ff; border-radius: 8px; border: 2px solid #eaf3ff; }
body::-webkit-scrollbar-thumb:hover { background: #1a73e8; }
.hidden-scrollbar { max-height: 80vh; overflow-y: auto; padding-right: 10px; scrollbar-width: thin; scrollbar-color: #4da3ff #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar { width: 8px; }
.hidden-scrollbar::-webkit-scrollbar-track { background: #eaf3ff; border-radius: 4px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background-color: #4da3ff; border-radius: 4px; border: 2px solid #eaf3ff; }
.hidden-scrollbar::-webkit-scrollbar-thumb:hover { background-color: #1a73e8; }

body { background: linear-gradient(135deg, #e8f1ff 0%, #d1e4ff 100%); font-family: "Poppins", "Segoe UI", sans-serif; color: #1f2f46; margin: 0; padding: 40px 0; min-height: 100vh; animation: fadeIn 0.6s ease-in-out; box-sizing: border-box; }
#mainBG { background: #f4f8ff; border-radius: 16px; box-shadow: 0 4px 25px rgba(50, 110, 255, 0.15); padding: 25px 30px; max-width: 1250px; margin: 0 auto; transition: 0.3s ease; }
.receipt-header { background: #edf4ff; border: 1px solid #c9dafc; border-radius: 14px; padding: 20px; margin-bottom: 26px; box-shadow: 0 2px 10px rgba(132, 168, 255, 0.2); }

/* form grid / inputs */
.clean-grid-form { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px 32px; width: 100%; box-sizing: border-box; align-items: start; }
.clean-grid-item { display: flex; flex-direction: column; }
.clean-grid-item.full { grid-column: span 3; }
.clean-input, .clean-grid-item input[type="text"], .clean-grid-item select, .receipt-header input[type="text"], .receipt-header select { width: 100%; height: 44px; padding: 8px 12px; border: 1px solid #b9ccf2; border-radius: 8px; background: #ffffff; font-size: 0.95rem; color:#1f2f46; box-sizing: border-box; transition: 0.18s ease; }
.clean-input:focus, .receipt-header input[type="text"]:focus, .receipt-header select:focus { border-color: #4da3ff; box-shadow: 0 0 6px rgba(77,163,255,0.35); outline: none; }

.receipt-header { background: #fdfefe; border: 1px solid #e1e9ff; border-radius: 18px; padding: 18px 26px; margin-bottom: 22px; box-shadow: 0 4px 18px rgba(90,125,255,0.18); }
.receipt-header .cr-table { width: 100%; border-collapse: separate; border-spacing: 0; background: transparent; box-shadow: none; border-radius: 0; }
.receipt-header td[align="right"] { font-weight: 600; color: #253858; font-size: 14px; padding: 10px 8px; white-space: nowrap; }
.receipt-header td { padding: 10px 8px; vertical-align: middle; }
.receipt-header input[type="text"], .receipt-header select { border: 1px solid #b9ccf2; border-radius: 8px; padding: 8px 11px; font-size: 0.95rem; background: #ffffff; color: #1f2f46; transition: 0.25s ease; box-sizing: border-box; }

/* remove previous pill-round appearance: make vendor/type rectangular like docno/desc */
#accid, #vehrefno, #vehpuraccname, #docno { border-radius: 8px; }

/* dateboxes sizing */
#vehpurorderDate, #vehpurorderdelDate { width: 140px !important; height: 40px !important; }
#vehpurorderDate input, #vehpurorderdelDate input { height: 38px !important; padding-left: 10px !important; border-radius: 8px !important; background-color: #ffffff !important; box-shadow: none !important; font-size: 0.95rem; }

/* table styles */
.cr-table { width: 100%; border-collapse: collapse; background: #ffffff; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(100,140,255,0.15); }
.cr-table th, .cr-table td { padding: 10px 11px; border-bottom: 1px solid #d6e1ff; text-align: left; font-size: 0.95rem; color: #1f2f46; }
.cr-table th { background-color: #dcebff; color: #1b3f73; font-weight: 600; }
.cr-table tr:hover td { background-color: #eef5ff; transition: 0.25s; }

/* TAX / NETTOTAL row adjustments:
   - move Tax box a bit right
   - enlarge tax input and Net Total input
   - make the final cells wider so the Net Total input extends
*/
#taxtable td { vertical-align: middle; padding: 6px 10px; }
#taxtable td:nth-child(2) { text-align: right; padding-right: 20px; }
#taxtable td:nth-child(3) input { width: 170px; text-align: right; }
#taxtable td:nth-child(5) input#nettotal { width: 260px; text-align: right; }

/* helper responsive */
@media (max-width: 900px) {
  .receipt-header .cr-table, .receipt-header .cr-table tr, .receipt-header .cr-table td { display: block; width: 100%; }
  .receipt-header td[align="right"] { text-align: left; margin-top: 4px; }
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >

    <form id="frmpurorder" action="savePurchaseorder" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include>
<div  class='hidden-scrollbar receipt-header'>

<div class="table-section" style="width: 100%;">
<table class="cr-table" width="100%"><tr><td>
<table width="100%">
  <tr>
    <td width="4.2%"  align="right">Date</td> 
    <td width="5%"><div id="vehpurorderDate" name="vehpurorderDate" value='<s:property value="vehpurorderDate"/>'></div>
    <input type="hidden" id="hidvehpurorderDate" name="hidvehpurorderDate" value='<s:property value="hidvehpurorderDate"/>'/></td>
    
    <td width="10%" align="right">Doc No</td>
    <td width="25%"><input type="text" id="docno" name="docno" class="clean-input" style="width:100%;" value='<s:property value="docno"/>' tabindex="-1"/></td>
  </tr>
</table>
</td>
</tr>
<tr><td>                   
<table width="100%">
  <tr>
    <td width="2%" align="right">Vendor</td>
  <td width="29%">
    <input type="text" id="accid" name="accid" style="width:20%;" placeholder="Press F3 to Search" value='<s:property value="accid"/>'  onkeydown="getaccountdetails(event)" onblur="diserror()"/>
    <input type="text" id="vehpuraccname" name="vehpuraccname" style="width:70%;" value='<s:property value="vehpuraccname"/>'/>
    <input type="hidden" id="headdoc" name="headdoc" value='<s:property value="headdoc"/>'/>
  </td>

    <td align="right"  width="7%">Type</td>
    <td width="6%">
      <select id="vehtype" name="vehtype" style="width:92%;" value='<s:property value="vehtype"/>' onchange="funrefdisslno()">
        <option value="DIR">DIR</option>
        <option value="VPR">VPR</option>
      </select>
    </td>
    
    <td width="8%"><input type="text" id="vehrefno" name="vehrefno" style="width:96%;" placeholder="Press F3 to Search" value='<s:property value="vehrefno"/>'  onkeydown="getrefDetails(event)"/></td>
     <td width="34%"></td>
  </tr>
  </table>
  </td></tr>
  <tr><td>
<table>
  <tr>
    <td align="right"  width="2%">Exp.Delivery</td>
    <td width="5%"><div id="vehpurorderdelDate" name="vehpurorderdelDate" value='<s:property value="vehpurorderdelDate"/>'></div>
     <input type="hidden" id="hidvehpurorderdelDate" name="hidvehpurorderdelDate" value='<s:property value="hidvehpurorderdelDate"/>'/></td>
    <td >Description<input type="text" id="vehdesc" name="vehdesc" class="clean-input" style="width:70%;" value='<s:property value="vehdesc"/>'/></td>
  </tr>
</table>
</td></tr></table>
</div>
<br>
<div class="table-section" style="width: 100%;">

<div class="cr-table" id="vehorder"><jsp:include page="vehorderDetails.jsp"></jsp:include></div>
</div>
<table width="100%"   id="taxtable" >
<tr>
<td align="right" width="55%">&nbsp;</td>
<td align="right" width="20%">Tax Amount</td>
   	<td align="left" width="20%"><input type="text" id="taxamount" name="taxamount"  style="text-align: right;"  value='<s:property value="taxamount"/>' ></td>
<td align="right" width="20%">Net Total</td>
<td><input type="text" id="nettotal" name="nettotal" value='<s:property value="nettotal"/>' /></td>
</tr>
</table>

<input type="hidden" id="masterrefno" name="masterrefno" value='<s:property value="masterrefno"/>'/>
<input type="hidden" id="masterdoc_no" name="masterdoc_no" value='<s:property value="masterdoc_no"/>'/>
<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
<input type="hidden" id="brandval" name="brandval" value='<s:property value="brandval"/>'/>
<input type="hidden" id="headacccode" name="headacccode" value='<s:property value="headacccode"/>'/>
<input type="hidden" id="vehoredergridlenght" name="vehoredergridlenght" value='<s:property value="vehoredergridlenght"/>'/>
<input type="hidden" id="vehtypeval" name="vehtypeval" value='<s:property value="vehtypeval"/>'/>
<input type="hidden" id="txtnontaxableentity" name="txtnontaxableentity" value='<s:property value="txtnontaxableentity"/>'/>
<input type="hidden" id="txttaxpercentage" name="txttaxpercentage" value='<s:property value="txttaxpercentage"/>'/>

<div id="colorsearchwndow"><div ></div></div>
<div id="groupwindow"><div ></div></div>
<div id="modelsearchwndow"><div ></div></div>
<div id="brandsearchwndow"><div ></div></div>
<div id="accountSearchwindow"><div ></div></div>
<div id="refnosearchwindow"><div ></div></div>

</div>
    </form>
</div>

</body>
</html>
