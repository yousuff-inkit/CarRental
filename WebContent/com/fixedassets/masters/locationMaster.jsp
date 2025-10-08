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

        .container {
            height: 100%;
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

    <div class="hidden-scrollbar receipt-header">
<h3>Location Details</h3>
<table class="cr-table" width="100%">
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


        <div class="cr-table" id="locgrid"><jsp:include page="locationGrid.jsp"></jsp:include></div>

<input type="hidden" name="hidflmdate" id="hidflmdate" value='<s:property value="hidflmdate"/>'/>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'/>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
    </div>
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