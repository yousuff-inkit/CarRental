<% String contextPath=request.getContextPath();%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../includes.jsp"></jsp:include>
 
 <style>
 
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

$(document).ready(function () {     
	 $("#flmdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
	
	 document.getElementById("formdet").innerText="Location Master(FLM)";
		document.getElementById("formdetail").value="Location Master";
		document.getElementById("formdetailcode").value="FLM";
		window.parent.formCode.value="FLM";
		window.parent.formName.value="Location Master";
});
	 
	
	function funFocus(){
		document.getElementById("flmcode").focus();
	}
	
	function funReadOnly() {
		$('#frmloc input').attr('readonly', true);
		$('#flmdate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly() {
		$('#frmloc input').attr('readonly', false);
		$('#flmdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		
	}
	
	function setValues() {
		if($('#hidflmdate').val()){
			$("#flmdate").jqxDateTimeInput('val', $('#hidflmdate').val());
		}
		
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	$(function(){
	    $('#frmloc').validate({
	             rules: {
	             salesmanid: {required:true,maxlength:4},
	             salesmanname: {required:true,maxlength:40},
	             txtaccname:{required:true},
	             telephone:{required:true,digits:true,minlength:12,maxlength:12},
	             salesmanmail:{email:true}
	             },
	             messages: {
	              salesmanid:{required:" *",maxlength:"Max 4 Chars."},
	              salesmanname:{required:" *",maxlength:"Max 40 Chars."},
	              txtaccname:{required:" *"},
	              telephone:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	              salesmanmail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		
		if(document.getElementById("flmname").value==''){
			document.getElementById("errormsg").innerText="Location Name is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function funSearchLoad(){
		changeContent('salesmanSearch.jsp'); 
	 }
 
</script>
</head>
<!-- onload="setValues();" -->
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmloc" action="saveActionloc" method="post" autocomplete="off" >
	<jsp:include page="../../../header.jsp" />
	<br/> 
<fieldset><legend>Location Details</legend>
<table width="100%">
  <tr>
    <td width="5%" align="right">Date</td>
    <td width="16%"><div id="flmdate" name="flmdate" value='<s:property value="flmdate"/>'></div></td>
    <td colspan="3" align="right">Doc No.</td>
    <td width="30%"><input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1"></td>
  </tr>
  <tr>
    <td align="right">Code</td>
    <td><input type="text" name="flmcode" id="flmcode" placeholder="Location Code" value='<s:property value="flmcode"/>' ></td>
   <%--  <td width="11%" align="right">Name</td>
    <td width="33%"><input type="text" name="salesmanname" id="salesmanname" placeholder="Code Name" value='<s:property value="salesmanname"/>' style="width:59%;"></td> --%>
    <td width="5%" align="right">Name</td>
    <td><input type="text" name="flmname" id="flmname" style="width:80%;" placeholder="Location Name" value='<s:property value="flmname"/>' ></td>
  </tr>
</table>
</fieldset>

<table width="100%">
  <tr>
   <td>
   
   <div id="locgrid"><jsp:include page="locationGrid.jsp"></jsp:include></div>
   </td>
  </tr>
</table>

<input type="hidden" name="hidflmdate" id="hidflmdate" value='<s:property value="hidflmdate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
</form>
</div>
<br/>
	<div id="jqxSalesmanSearch1"></div>
		
	<div id="accountWindow">
	<div >
	
	</div>
	<div>
	</div>
	 </div>  
	
</body>
</html>