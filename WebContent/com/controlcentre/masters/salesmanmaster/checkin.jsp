<%@page import="com.controlcentre.masters.salesmanmaster.checkin.ClsCheckinDAO" %>
<%ClsCheckinDAO ccd=new ClsCheckinDAO(); %>


<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
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
		var data= '<%=ccd.searchDetails()%>';
		  $('#accountWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		  $('#accountWindow').jqxWindow('close');
		  
		  $("#checkindate").jqxDateTimeInput({width : '125px',height : '15px',formatString : "dd.MM.yyyy"});
		  
		  var source =
          {
              datatype: "json",
              datafields: [
                        	{name : 'doc_no' , type: 'int' },
   							{name : 'name', type: 'String'  },
                        	{name : 'mail', type: 'String'  },
                        	{name : 'acno',type:'string'},
                        	{name : 'description',type:'String'},
                        	{name : 'mobile',type:'string'},
                        	{name : 'code',type:'string'},
                        	{name :'date',type:'date'},
                        	{name : 'acdoc',type:'String'}
               ],
               localdata: data,
              
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
          };
          
          var dataAdapter = new $.jqx.dataAdapter(source,
          		 {
              		loadError: function (xhr, status, error) {
	                   // alert(error);    
	                    }
		            }		
          ); 
          $("#jqxCheckinSearch1").jqxGrid(
                  {
                  	width: '100%',
                  	height:310,
                      source: dataAdapter,
                      showfilterrow: true,
                      filterable: true,
                      selectionmode: 'singlerow',
                      sortable: true,
                      altrows:true,
                      //Add row method
                      columns: [
      					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
      					{ text: 'Code',datafield: 'code', width: '10%',hidden:true },
      					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
      					{ text: 'Name', datafield: 'name', width: '20%' },
      					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '30%' },
      					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '50%' ,hidden:true},
      					{ text: 'Email',columntype: 'textbox', filtertype: 'input', datafield: 'mail', width: '15%' },
      					{ text: 'Mobile',columntype: 'textbox', filtertype: 'input', datafield: 'mobile', width: '15%' },
      					{ text: 'Ac Doc',columntype: 'textbox', filtertype: 'input', datafield: 'acdoc', width: '15%',hidden:true }

      	              ]
                  });

          $('#jqxCheckinSearch1').on('rowdoubleclick', function (event) 
          		{ 
		            	var rowindex1=event.args.rowindex;
		                document.getElementById("docno").value= $('#jqxCheckinSearch1').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
		                document.getElementById("code").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "code");
		                document.getElementById("name").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "name");
		                document.getElementById("mail").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "mail");
		                document.getElementById("mobile").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "mobile");
		                $("#checkindate").jqxDateTimeInput('val', $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "date")); 
		                document.getElementById("txtaccno").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "acno");
		                document.getElementById("txtaccname").value = $("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "description");
		                document.getElementById("hidacno").value=$("#jqxCheckinSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");
          		 }); 
		  
		  
		$('#txtaccno').dblclick(function(){
	  	$('#accountWindow').jqxWindow('open');
	     var url=document.URL;
		 var reurl=url.split("com/");
	  	 accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
			 }); 
		
		document.getElementById("formdet").innerText="Check In(CHK)";
		document.getElementById("formdetail").value="Check In";
		document.getElementById("formdetailcode").value="CHK";
		window.parent.formCode.value="CHK";
		window.parent.formName.value="Check In";
	});
	
	function getAcc(event){
		 var x= event.keyCode;
		 if(x==114){
		  $('#accountWindow').jqxWindow('open');
	     var url=document.URL;
		     var reurl=url.split("com/");
		     accountSearchContent(reurl[0]+'com/search/accountsearch/accountsEmployee.jsp?dtype='+document.getElementById("formdetailcode").value);
		 }
		 else{
			 
		 }
		 }
	
	function accountSearchContent(url) {
			 $.get(url).done(function (data) {
			$('#accountWindow').jqxWindow('setContent', data);
		}); 
		}
	
	function funReadOnly(){
		$('#frmCheckin input').attr('readonly', true );
		$('#checkindate').jqxDateTimeInput({ disabled: true}); 
	}
	
	function funRemoveReadOnly(){
		$('#frmCheckin input').attr('readonly', false );
		$('#checkindate').jqxDateTimeInput({ disabled: false});
		$('#docno').attr('readonly', true);
		$('#txtaccno').attr('readonly', true);
		$('#txtaccname').attr('readonly', true);
	}
	
	$(function(){
	    $('#frmCheckin').validate({
	             rules: {
	             code: {required:true,maxlength:10},
				 name:{required:true,maxlength:40},
				 txtaccname:{required:true},
	             mobile:{required:true,digits:true,minlength:12,maxlength:12},
	             mail:{email:true}
	             },
	             messages: {
	            	 code:{required:" *",maxlength:"Max 10 Chars."},
	                 name:{required:" *",maxlength:"Max 40 Chars."},
	                 txtaccname:{required:" *"},
	                 mobile:{required:" *",digits:"Digits only.",minlength:"Min 12 Chars.",maxlength:'Max 12 Chars.'},
	                 mail:{email:"Not a valid Email."}
	             }
	    });});
	    
	function funNotify(){
		if(document.getElementById("txtaccno").value==''){
			document.getElementById("errormsg").innerText="Account is Mandatory.";
			return false;
		}
		document.getElementById("errormsg").innerText="";
		
		  $('#checkindate').jqxDateTimeInput({ disabled: false});
		  return 1;
	}
	
	function funChkButton() {
		   /* funReset(); */
		  }
		  
	function setValues() {
		
			if($('#hidcheckindate').val()){
				$("#checkindate").jqxDateTimeInput('val', $('#hidcheckindate').val());
			}
			
			if($('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			
	}
	
	function funFocus(){
		document.getElementById("code").focus();
	}
	
	function funSearchLoad(){
		changeContent('checkinSearch.jsp'); 
	}
	function funExcelBtn(){
   	 $("#jqxCheckinSearch1").jqxGrid('exportdata', 'xls', 'Checkin');
   }
</script>
</head>
<body onLoad="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmCheckin" action="saveActionCheckin" autocomplete="off" >
<jsp:include page="../../../../header.jsp" /><br/>
<div class="hidden-scrollbar receipt-header">

    <div class="section-block full-width-block">
        <h3>Check In Details</h3>

        <div class="form-group dual-input">
            <label>Date</label>
            <div>
                <div id="checkindate" name="checkindate" value='<s:property value="checkindate"/>'></div>
            </div>

            <label>Doc No.</label>
            <input type="text" id="docno" name="docno" value='<s:property value="docno"/>' readonly tabindex="-1">
        </div>

        <div class="form-group dual-input">
            <label>Code</label>
            <input type="text" id="code" name="code" placeholder="Code" value='<s:property value="code"/>' >

            <label>Name</label>
            <input type="text" name="name" id="name" placeholder="Code Name" value='<s:property value="name"/>'>
        </div>

        <div class="form-group dual-input">
            <label>Email</label>
            <input type="email" name="mail" id="mail" placeholder="someone@example.com" value='<s:property value="mail"/>'>

            <label>Mobile</label>
            <input type="text" name="mobile" id="mobile" value='<s:property value="mobile"/>'>
        </div>

        <div class="form-group single-label-dual-input">
            <label>Account</label>
            <input type="text" name="txtaccno" id="txtaccno" value='<s:property value="txtaccno"/>' onKeyDown="getAcc(event);" readonly placeholder="Press F3 to Search">
            <input type="text" name="txtaccname" id="txtaccname" value='<s:property value="txtaccname"/>' readonly>
        </div>
    </div>

<input type="hidden" name="hidcheckindate" id="hidcheckindate" value='<s:property value="hidcheckindate"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
<input type="hidden" name="hidacno" id="hidacno" value='<s:property value="hidacno"/>'/>
    <div id="accountWindow">
        <div >
        </div>
    </div>
    <div id="jqxCheckinSearch1"></div>
</div>

</form>

</div>

</body>
</html>