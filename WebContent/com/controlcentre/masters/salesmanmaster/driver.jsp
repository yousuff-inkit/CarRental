<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includeso.jsp"></jsp:include>

<script type="text/javascript">

	  $(document).ready(function () {     
			 
		 $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountWindow').jqxWindow('close');
		 
		 $('#nationalityWindow').jqxWindow({width: '25%', height: '61%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true});
		 $('#nationalityWindow').jqxWindow('close');
		 
		 $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#stateWindow').jqxWindow('close');
		 
		 $("#driverdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		
	      		   $('#txtaccno').dblclick(function(){
			  	   $('#accountWindow').jqxWindow('open');
			  	   var url=document.URL;
				   var reurl=url.split("com/");
			  	       accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
	      		 }); 
	      		   
	      		document.getElementById("formdet").innerText="Driver(DRV)";
	     		document.getElementById("formdetail").value="Driver";
	     		document.getElementById("formdetailcode").value="DRV";
	     		window.parent.formCode.value="DRV";
	     		window.parent.formName.value="Driver";


			var ch=document.getElementById("chkext").value;
	     		if(ch==1)
            	{
            	document.getElementById("external").checked = true;

            	}
            else{
            	document.getElementById("external").checked = false;

            }


	   });
	
	 function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
		  var url=document.URL;
		  var reurl=url.split("com/");
		     accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{}
		 }
	
	 function accountSearchContent(url) {
			 $.get(url).done(function (data) {
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
	  }
	
	 function nationalitySearchContent(url) {
		    $('#nationalityWindow').jqxWindow('open');
		   $.get(url).done(function (data) {
		   $('#nationalityWindow').jqxWindow('setContent', data);
		   $('#nationalityWindow').jqxWindow('bringToFront');
		  }); 
	  }
	 
	 function stateSearchContent(url) {
		 	$('#stateWindow').jqxWindow('open');
			$.get(url).done(function (data) {
			$('#stateWindow').jqxWindow('setContent', data);
			$('#stateWindow').jqxWindow('bringToFront');
		}); 
		}
	
	function funSearchLoad(){
		changeContent('driverSearch.jsp'); 
	 }
	 
	function funReadOnly(){
		$('#frmDriver input').attr('readonly', true );
		$('#driverdate').jqxDateTimeInput({ disabled: true}); 
		$("#jqxDriver").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmDriver input').attr('readonly', false );
		$('#driverdate').jqxDateTimeInput({ disabled: false}); 
		$('#docno').attr('readonly', true);
		$("#jqxDriver").jqxGrid({ disabled: false});
		
		if ($("#mode").val() == "A") {
	        $("#jqxDriver").jqxGrid('clear');
	        $("#jqxDriver").jqxGrid('addrow', null, {});
	     }
		
		if ($("#mode").val() == "E") {
			$("#jqxDriver").jqxGrid('addrow', null, {});
		}
		
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	function setValues() {
		if($('#hiddriverdate').val()){
			$("#driverdate").jqxDateTimeInput('val', $('#hiddriverdate').val());
		}
		
		if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
			
		if(document.getElementById("docno").value!=''){
			 var code=$('#formdetailcode').val().trim();
		     var doc=document.getElementById("docno").value;
	     	 $('#driverdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
		}
		
	}
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return 0;
		}
		
		var rows = $("#jqxDriver").jqxGrid('getrows');
		var length=0;
		for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].dob;
			if(typeof(chk) != "undefined"){
				length=length+1;
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
		     
				newTextBox.val(rows[i].hiddob+"::"+rows[i].nation1+"::"+rows[i].mobno+"::"+rows[i].passport_no+"::"+rows[i].hidpassexp+"::"+rows[i].dlno+"::"+rows[i].hidissdate+"::"+rows[i].issfrm+"::"+rows[i].hidled+"::"+rows[i].ltype+"::"+rows[i].visano+"::"+rows[i].hidvisaexp+"::"+rows[i].dr_id);
		    	newTextBox.appendTo('form');
			   }
		    }
 		$('#gridlength').val(length);
			
			document.getElementById("errormsg").innerText="";
			return 1;
	}
	
	$(function(){
	    $('#frmDriver').validate({
	             rules: {
	             code: {required:true,maxlength:10},
	             name:{required:true,maxlength:40},
	             txtaccname:{required:true},
	             mail:{email:true}
	             },
	             messages: {
	             code:{required:" *",maxlength:"Max 10 Chars."},
	             name:{required:" *",maxlength:"Max 40 Chars."},
	             txtaccname:{required:" *"},
	             mail:{email:"Not a valid Email."}
	             }
	  });});
	function funExcelBtn(){
	   	if(document.getElementById("docno").value!=""){
	   		
	   		$("#jqxDriver").jqxGrid('exportdata', 'xls', 'Driver '+document.getElementById("name").value);	
	   	} 
	   	else{
	   	 $.messager.alert('Warning','Select a valid Document');
	   	 return false;
	   	}
		
	   }
</script>
<style>
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
        padding-inline: 1.04em;
        padding-block: 1.04em;
        border-radius: 8px;
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
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmDriver" action="saveActionDriver" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>

<div class="hidden-scrollbar receipt-header">
<div class="table-section" style="width: 100%;">
<h3 style="font-size:18px;font-weight:600;color:#1B4F9A;margin-bottom:12px;">
    Driver Details
</h3>

<table class="cr-table" width="100%" style="background:#ffffff;border-radius:12px;">

    <!-- ⭐ Row 1 -->
    <tr>
        <td width="10%" align="right" style="font-weight:600;color:#1A3E7A;">Date</td>
        <td width="20%">
            <div id="driverdate"></div>
        </td>

        <td width="10%" align="right" style="font-weight:600;color:#1A3E7A;">Doc No.</td>
        <td width="20%">
            <input type="text" id="docno" name="docno"
                value='<s:property value="docno"/>'
                readonly tabindex="-1"
                style="width:90%;padding:8px;border:1px solid #cfe0ff;border-radius:8px;background:#f9fbff;">
        </td>

        <td width="10%"></td>
        <td width="30%"></td>
    </tr>

    <!-- ⭐ Row 2 -->
    <tr>
        <td align="right" style="font-weight:600;color:#1A3E7A;">Code</td>
        <td>
            <input type="text" id="code" name="code"
                value='<s:property value="code"/>'
                style="width:90%;padding:8px;border-radius:8px;border:1px solid #cfe0ff;background:#f9fbff;">
        </td>

        <td align="right" style="font-weight:600;color:#1A3E7A;">Name</td>
        <td>
            <input type="text" id="name" name="name"
                value='<s:property value="name"/>'
                style="width:90%;padding:8px;border-radius:8px;border:1px solid #cfe0ff;background:#f9fbff;">
        </td>

        <td align="right" style="font-weight:600;color:#1A3E7A;">Email</td>
        <td>
            <input type="email" id="mail" name="mail"
                value='<s:property value="mail"/>'
                style="width:90%;padding:8px;border-radius:8px;border:1px solid #cfe0ff;background:#f9fbff;">
        </td>
    </tr>

    <!-- ⭐ Row 3 -->
    <tr>
        <td align="right" style="font-weight:600;color:#1A3E7A;">Account</td>
        <td>
            <input type="text" id="txtaccno" name="txtaccno"
                readonly placeholder="Press F3 to Search"
                value='<s:property value="txtaccno"/>'
                onkeydown="getAcc(event);"
                style="width:90%;padding:8px;border-radius:8px;border:1px solid #cfe0ff;background:#f0f5ff;">
        </td>

        <td align="right" style="font-weight:600;color:#1A3E7A;">A/c Name</td>
        <td>
            <input type="text" id="txtaccname" name="txtaccname"
                readonly value='<s:property value="txtaccname"/>'
                style="width:90%;padding:8px;border-radius:8px;border:1px solid #cfe0ff;background:#f9fbff;">
        </td>

        <td align="right" style="font-weight:600;color:#1A3E7A;">External</td>
        <td>
            <input type="checkbox" id="external" name="external"
                onclick="$(this).attr('value', this.checked ? 1 : 0)" 
                style="transform:scale(1.3);cursor:pointer;">
            <input type="hidden" id="chkext" name="chkext"
                value='<s:property value="external"/>' />
        </td>
    </tr>

</table>
</div>

<br/>

<div id="driverdiv"><jsp:include page="driver2.jsp"></jsp:include></div>

<input type="hidden" id="hiddriverdate" name="hiddriverdate" value='<s:property value="hiddriverdate"/>'>
<input type="hidden" id="hidlicenseexpiry" name="hidlicenseexpiry" value='<s:property value="hidlicenseexpiry"/>'>
<input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>'>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="gridlength" name="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="hidacno" name="hidacno" value='<s:property value="hidacno"/>' />

<div id="accountWindow"><div></div></div>
<div id="nationalityWindow"><div></div></div>
<div id="stateWindow"><div></div></div>

</div>
</form>
</div>
</body>

</html>

