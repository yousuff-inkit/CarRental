<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include><style>
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
        grid-template-columns: 120px 1fr 1fr;
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

    .section-block h2, .section-block h3 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
        display: block;
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

    label {
    font: Tahoma;
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 16px;
    }

    /* ------------------------------
       TABLES & UTILS (From Master)
    ------------------------------ */
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; }

</style><script type="text/javascript">
	$(document).ready(function () {     
		  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	      $('#accountWindow').jqxWindow('close');
		  
	      $('#nationalityWindow').jqxWindow({width: '25%', height: '61%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Nation Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true});
		  $('#nationalityWindow').jqxWindow('close');
		  
		  $('#stateWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'State Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 	  $('#stateWindow').jqxWindow('close');
	 		 
		  $("#staffdate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		  
		  $('#txtaccno').dblclick(function(){
	  	    $('#accountWindow').jqxWindow('open');
	        var url=document.URL;
		    var reurl=url.split("/com/");
	  	  		accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
			 }); 
		  
		  document.getElementById("formdet").innerText="Staff(STF)";
   		  document.getElementById("formdetail").value="Staff";
   		  document.getElementById("formdetailcode").value="STF";
   		  window.parent.formCode.value="STF";
   		  window.parent.formName.value="Staff";
		});
	
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
	 
	function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
	      var url=document.URL;
		  var reurl=url.split("/com/");
	   		accountSearchContent(reurl[0]+'/com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{}
		 }
	
	function accountSearchContent(url) {
			 $.get(url).done(function (data) {
			 $('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funReadOnly(){
		$('#frmStaff input').attr('readonly', true );
		$('#staffdate').jqxDateTimeInput({ disabled: true}); 
		$("#jqxDriver").jqxGrid({ disabled: true});
	}
	
	function funRemoveReadOnly(){
		$('#frmStaff input').attr('readonly', false );
		$('#staffdate').jqxDateTimeInput({ disabled: false}); 
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
	
	
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return 0;
		}
	
		if(document.getElementById("chkvalid").value==1){
			document.getElementById("errormsg").innerText="Please Enter Necessary Details";
			return 0;
		}
	
		var rows = $("#jqxDriver").jqxGrid('getrows');
		var length=0;
		for(var i=0 ; i < rows.length ; i++){
			var chk=rows[i].dob;
			if(typeof(chk) != "undefined" && typeof(chk) !== "undefined" && chk != "" &&  chk != null && typeof(chk) != "NaN"){
				
				newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+i)
			    .attr("name", "test"+i)
			    .attr("hidden", "true");
		     
				newTextBox.val(rows[i].hiddob+"::"+rows[i].nation1+"::"+rows[i].mobno+"::"+rows[i].passport_no+"::"+rows[i].hidpassexp+"::"+rows[i].dlno+"::"+rows[i].hidissdate+"::"+rows[i].issfrm+"::"+rows[i].hidled+"::"+rows[i].ltype+"::"+rows[i].visano+"::"+rows[i].hidvisaexp+"::"+rows[i].dr_id);
		    	newTextBox.appendTo('form');
		    	length=length+1;
			   }
		    }
 		$('#gridlength').val(length);
		
		document.getElementById("errormsg").innerText="";
		return 1;		
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			if($('#hidstaffdate').val()){
				$("#staffdate").jqxDateTimeInput('val', $('#staffdate').val());
			  }
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
		   if(document.getElementById("docno").value>0){
			   var code=$('#formdetailcode').val().trim();
	           var doc=document.getElementById("docno").value;
	           $('#staffdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
	}
		   
	}
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	
	function funSearchLoad(){
		changeContent('staffSearch.jsp'); 
	 }
	 
	 $(function(){
		    $('#frmStaff').validate({
	            rules: {
	            code: {required:true,maxlength:10},
	            name:{required:true,maxlength:40},
	            txtaccname:{required:true},
	            mail:{email:true}
	            },
	            messages: {
	             code:{required:" *",maxlength:"Max 10 Chars"},
	             name:{required:" *",maxlength:"Max 40 Chars"},
	             txtaccname:{required:" *"},
	             mail:{email:"Not a valid Email."}
	             }
	   });});
	 
	 function funExcelBtn(){
		   	if(document.getElementById("docno").value!=""){
		   		
		   		$("#jqxDriver").jqxGrid('exportdata', 'xls', 'Staff '+document.getElementById("name").value);	
		   	} 
		   	else{
		   	 $.messager.alert('Warning','Select a valid Document');
		   	 return false;
		   	}
			
		   }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmStaff" action="saveActionStaff" autocomplete="off">
<jsp:include page="../../../../header.jsp" /><br/>
<div class="hidden-scrollbar receipt-header">

    <div class="section-block full-width-block">
        <h3>Staff Details</h3>

        <div class="form-group dual-input">
            <label>Date</label>
            <div>
                <div id="staffdate" name="staffdate" value='<s:property value="staffdate"/>'></div>
            </div>

            <label>Doc No.</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>

        <div class="form-group dual-input">
            <label>Code</label>
            <input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>'/>

            <label>Name</label>
            <input type="text" name="name" id="name" placeholder="Name" value='<s:property value="name"/>'>
        </div>

        <div class="form-group dual-input">
            <label>Email</label>
            <input type="email" name="mail" id="mail" placeholder="someone@example.com" value='<s:property value="mail"/>'>

            <label></label>
            <div></div>
        </div>

        <div class="form-group single-label-dual-input">
            <label>Account</label>
            <input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search">
            <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' readonly>
        </div>
    </div>
    
    <div class="full-width-block" id="staffdiv" style="padding: 0; background: transparent; box-shadow: none;">
        <jsp:include page="driver2.jsp"></jsp:include>
    </div>

<input type="hidden" name="hidstaffdate" id="hidstaffdate" value='<s:property value="hidstaffdate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'>

    <div id="accountWindow">
        <div ></div>
    </div>

    <div id="nationalityWindow">
        <div ></div>
    </div>

    <div id="stateWindow">
        <div ></div>
    </div>
</div>
</form>
</div>
</body>
</html>