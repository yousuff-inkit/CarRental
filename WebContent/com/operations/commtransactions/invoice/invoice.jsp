<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<% String contextPath=request.getContextPath();%>
<link rel="stylesheet" type="text/css" href="../../../../css/body.css">
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>

<style>
    /* ------------------------------
       GLOBAL STYLES & LAYOUT
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
        max-width: 100%;
        margin: auto;
        box-shadow: 0 4px 24px rgba(0,0,0,0.06);
        /* FORCE HEADER LEFT ALIGNMENT */
        text-align: left !important; 
    }

    /* ------------------------------
       HEADER FIXES (Title & Buttons)
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
       GRID SYSTEM (FORM LAYOUT)
    ------------------------------ */
    .receipt-header {
        display: grid;
        grid-template-columns: auto 1fr auto 1fr;
        gap: 15px;
        align-items: center;
        margin-bottom: 20px;
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
    }

    .section-block {
        flex: 1;
        background: #f6f8fa;
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    }

    .section-block h2 {
        font-size: 1.1rem;
        font-weight: 600;
        margin: 0 0 20px;
        padding-left: 10px;
        border-left: 4px solid #007bff;
        color: #333;
    }

    /* ------------------------------
       INPUTS & CONTROLS
    ------------------------------ */
    input[type="text"], select, textarea {
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
    
    textarea {
        height: auto !important;
        min-height: 32px;
        resize: vertical;
    }

    input[type="text"]:focus, select:focus, textarea:focus {
        border-color: #007bff;
        outline: none;
    }
    
    input[readonly], textarea[readonly] {
        background-color: #f3f4f6;
        color: #6b7280;
    }

    label {
        font-weight: 600;
        color: #253858;
        white-space: nowrap;
        text-align: right;
        padding-right: 10px;
        font-size: 14px;
    }

    /* ------------------------------
       TABLES & UTILS
    ------------------------------ */
    .table-section { margin: 20px 0; }
    .table-section h3 {
        color: #253858; font-size: 1.05rem; font-weight: 600; margin-bottom: 12px;
    }
    
    .myButton {
        background: #007bff; border: none; padding: 6px 16px; color: #fff;
        border-radius: 6px; cursor: pointer; font-weight: 600;
    }
    .myButton:hover { background: #0056b3; }

    .doc-group { display: flex; gap: 5px; }
    
    /* SCROLLBAR FIX */
    .hidden-scrollbar { overflow: auto; height: 530px; }
    .hidden-scrollbar::-webkit-scrollbar { width: 0px; } 
</style>

<script type="text/javascript">
      $(document).ready(function () { 

    	//$('#btnEdit').attr('disabled',true);
    	$('#btnEdit').click(function(){
    		$("#jqxManualInvoice").jqxGrid("addrow", null, {}); 
    	});
    	
 	    $("#date").jqxDateTimeInput({ width: '100%', height: '30px',formatString:"dd.MM.yyyy"}); 
    
		$("#fromdate").jqxDateTimeInput({ width: '100%', height: '30px',formatString:"dd.MM.yyyy"});
        $("#todate").jqxDateTimeInput({ width: '100%', height: '30px',formatString:"dd.MM.yyyy"});
        $('#accountwindow').jqxWindow({ width: '60%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Account Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	   $('#accountwindow').jqxWindow('close');
    	   $('#agmtnowindow').jqxWindow({ width: '60%', height: '57%',  maxHeight: '57%' ,maxWidth: '60%' , title: 'Agreement Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
    	   $('#agmtnowindow').jqxWindow('close');
    	   $('#date').on('change', function (event) 
   				{  
   					var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
   					if(docdateval==0){
   						$('#date').jqxDateTimeInput('focus');
   						return false;
   					}
   				});
    	 	 $('#agmtvoucherno').dblclick(function(){
    	 		 if(document.getElementById("mode").value!="A"){
    	 			 return false;
    	 		 }
    	 		 if(document.getElementById("cmbagmttype").value==''){
    	 			 document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
    	 			 return false;
    	 		 }
    			 document.getElementById("errormsg").innerText="";

    			    $('#agmtnowindow').jqxWindow('open');
    			$('#agmtnowindow').jqxWindow('focus');
    			 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
    			});
    	 	<%--  document.getElementById("dtype").value='<%session.getAttribute("Code").toString();%>'; --%>
      });
      function getAgmtno(event){
    	 if(document.getElementById("mode").value!="A"){
 			 return false;
 		 }
    	 if(document.getElementById("cmbagmttype").value==''){
 			 document.getElementById("errormsg").innerText="Agreement Type is Mandatory";
 			 return false;
 		 }
			 document.getElementById("errormsg").innerText="";

    	  var x= event.keyCode;
          if(x==114){
        	  $('#agmtnowindow').jqxWindow('open');
 			$('#agmtnowindow').jqxWindow('focus');
 			 agmtnoSearchContent('agmtnoSearch.jsp?', $('#agmtnowindow'));
          }
          else{
           }
      }
      function accountSearchContent(url) {
    	      $.get(url).done(function (data) {
    	    $('#accountwindow').jqxWindow('setContent', data);
    	}); 
    	}
      function agmtnoSearchContent(url) {
	      $.get(url).done(function (data) {
	    $('#agmtnowindow').jqxWindow('setContent', data);
	}); 
	}
    function funReset(){
    	
    	/* $("#invoiceDiv").load("invoiceGrid.jsp"); */
	}
	function funReadOnly(){
		$('#frmManualInvoice input').attr('readonly', true );
		$('#frmManualInvoice select').attr('disabled', true);
		$('#frmManualInvoice textarea').attr('readonly', true );
	    $('#date').jqxDateTimeInput({ disabled: true});
	    $("#fromdate").jqxDateTimeInput({ disabled: true});
        $("#todate").jqxDateTimeInput({ disabled: true});
       
	}
	
	function funRemoveReadOnly(){
		 $('#Sendmail').hide();
		$('#frmManualInvoice input').attr('readonly', false );
		$('#frmManualInvoice select').attr('disabled', false);
		$('#frmManualInvoice textarea').attr('readonly', false );
		$('#date').jqxDateTimeInput({ disabled: false});
		$("#fromdate").jqxDateTimeInput({ disabled: false});
        $("#todate").jqxDateTimeInput({ disabled: false});
        
		$('#docno').attr('readonly', true);
		$('#agmtno').prop('readonly', true);
		$('#client').prop('readonly', true);
		$('#clientdetails').prop('readonly', true);
		$('#driver').prop('readonly', true);
		$('#driverdetails').prop('readonly', true);
		$('#contractvehicle').prop('readonly', true);
		$('#vehicledetails').prop('readonly', true);
		//alert(document.getElementById("mode").value);
		if(document.getElementById("mode").value=='A'){
			//alert(document.getElementById("mode").value);
			$("#invoiceDiv").load("invoiceGrid.jsp");
 			$('#fromdate').jqxDateTimeInput('setDate',new Date());
			$('#todate').jqxDateTimeInput('setDate',new Date());
			$('#date').jqxDateTimeInput('setDate',new Date());
			
 		}
		if(document.getElementById("mode").value=="E"){
			$('#cmbagmttype').prop('disabled',true);
		}
		if($('#mode').val()=='A' || $('#mode').val()=='E'){
			var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
				if(docdateval==0){
					$('#date').jqxDateTimeInput('focus');
					return false;
				}
		}
	}

	
	function funNotify(){
	//Month Close Validation
		var docdateval=funDateInPeriod($('#date').jqxDateTimeInput('getDate'));
		if(docdateval==0){
			$('#date').jqxDateTimeInput('focus');
			return 0;
		}
	/*	var fromdateval=funDateInPeriod($('#fromdate').jqxDateTimeInput('getDate'));
		if(fromdateval==0){
			$('#fromdate').jqxDateTimeInput('focus');
			return 0;
		}
		var todateval=funDateInPeriod($('#todate').jqxDateTimeInput('getDate'));
		if(todateval==0){
			$('#todate').jqxDateTimeInput('focus');
			return 0;
		}
	*/	
		//From Date and todate validation
		if($('#fromdate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Invoice From Date is Mandatory";
			return 0;
		}
		if($('#todate').jqxDateTimeInput('getDate')==null){
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Invoice To Date is Mandatory";
			return 0;
		}
	
		var rows = $("#jqxManualInvoice").jqxGrid('getrows');
		var gridlength=0;
		if(rows[0].idno=="undefined" || rows[0].idno==null || rows[0].idno==""){
		
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		if(rows[0].total=="undefined" || rows[0].total==null || rows[0].total==""){
			
			document.getElementById("errormsg").innerText="";
			document.getElementById("errormsg").innerText="Cannot Generate Empty Invoice";
			return 0;
		}
		
		if(!((rows[0].idno=="undefined") && (rows[0].idno==null) && (rows[0].idno==""))){
			
			
    	
    		var j=0;
    		for(var i=0 ; i < rows.length ; i++){
			
				if(rows[i].idno!="undefined" && rows[i].idno!=null && rows[i].idno!=""){	
					
					if(rows[i].total!="undefined" && rows[i].total!=null && rows[i].total!=""){
			newTextBox = $(document.createElement("input"))
			    .attr("type", "dil")
			    .attr("id", "test"+j)
			    .attr("name", "test"+j)
			    .attr("hidden", "true");
					
					gridlength++;j++;
					newTextBox.val(rows[i].idno+"::"+rows[i].account+"::"+rows[i].description+"::"+rows[i].qty+"::"+rows[i].rate+"::"+rows[i].total);		
					newTextBox.appendTo('form');
					}
				}
			
			}
			$('#gridlength').val(gridlength);
    	}
    		$('#cmbagmttype').prop('disabled',false);
		return 1;
     } 
	function setValues(){
	if($('#deleted').val()!=''){
		document.getElementById("errormsg").innerText="";
		document.getElementById("errormsg").innerText="Deleted Invoice";
	}
/* if($('#hiddate').val()){
			$("#date").jqxDateTimeInput('val', $('#hiddate').val());
		} 
		if($('#hidfromdate').val()){
			$("#fromdate").jqxDateTimeInput('val', $('#hidfromdate').val());
		}
		if($('#hidtodate').val()){
			$("#todate").jqxDateTimeInput('val', $('#hidtodate').val());
		}
		 */
		
		if ($('#hidcmbagmttype').val() != null) {
			$('#cmbagmttype').val($('#hidcmbagmttype').val());
		}
		if(document.getElementById("docno").value>0){
			var docno1=document.getElementById("docno").value;
			document.getElementById("brchName").disabled=false;
			$("#invoiceDiv").load("invoiceGrid.jsp?docno="+docno1+"&branch="+document.getElementById("brchName").value);
			document.getElementById("brchName").disabled=true;
 		}
		 if($('#msg').val()!=""){
    		   $.messager.alert('Message',$('#msg').val());
    		  }
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";

	}
	 function funChkButton() {
			/* funReset(); */
		}
	
	function funSearchLoad(){
			changeContent('invMainSearch.jsp', $('#window'));
	}
			
    function funFocus(){
		   document.getElementById("cmbagmttype").focus(); 	    		
	 }
    function funPrintBtn() {
    	 var url=document.URL;
			document.getElementById("brchName").disabled=false;
    	if(document.getElementById("docno").value==""){
    	
    		if(document.getElementById("mode").value=="view"){
    			var reurl=url.split("invoice.jsp");
        		
    	        	 var win= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");		
    		}
    		else{
    			var reurl=url.split("saveManualInvoice");
        		
   	        	 var win= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");		
    		}
    		
    	}
    	else{
    		
    		var reurl=url.split("saveManualInvoice");
    		//alert(reurl[0]);
           	 var win_voucher= window.open(reurl[0]+"printVoucherWindow.jsp?branch="+document.getElementById("brchName").value+"&voc="+document.getElementById("voucherno").value,"_blank","top=250,left=310,Width=700,Height=400,location=no,scrollbars=no,toolbar=yes");
           	win_voucher.focus(); 
    	} 
    	
    	
    	//Multiprint ends
    	
    	//    	var win= window.open(reurl[0]+"printManualInvoice?docno="+document.getElementById("docno").value,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
    	
    	 }
     
     
    function funSendmail()
 	{
 			
 		 if (($("#mode").val() == "view") && $("#docno").val()!="") {
 		  
 		if(document.getElementById("email").value=="")
 			{
 			document.getElementById("errormsg").innerText="Email Id Is Not Available.";  
 			return 0;
 			}
 		
 		
 		$("#overlay, #PleaseWait").show();

 		sample();
 		
 		 var recipient1=document.getElementById("email").value; 
      	var recipient=recipient1.replace(/ /g, "%20");
        	
      <%-- window.open("<%=contextPath%>/com/email/Email.jsp?formcode="+document.getElementById("formdetailcode").value+'&recipient='+recipient+'&code='+document.getElementById("docno").value,"E-Mail","menubar=0,resizable=1,width=900,height=525 "); --%>  
 		

      	//getMailservDets();
 		//sendmails();
 		
 		
 		
 		 }
 		else {
    	      $.messager.alert('Message','Select a Document....!','warning');
    	      return false;
    	     }
 		
 	}
 
 	function sample()
 	{  
 		var formcode=document.getElementById("formdetailcode").value;
 		var recep=document.getElementById("email").value.trim();
 		var branch=<%=session.getAttribute("BRANCHID").toString()%>;
 		
 		
 		$.ajaxFileUpload
    	  (  
    	      {  
    	    	
    	    	  url: 'invjspToPdf.action?vocno='+document.getElementById("voucherno").value+'&docno='+document.getElementById("docno").value+"&formcode="+formcode+"&recep="+recep+"&branch="+branch,  
    	          secureuri:false,//false  
    	          fileElementId:'file', //id  <input type="file" id="file" name="file" />  
    	          dataType: 'string',// json  
    	          success: function (data, status)  //  
    	          {  
    	              // alert(status);
    	             if(status=='success'){
    	            	
    	            	   
						$("#overlay, #PleaseWait").hide();
    	            	  
    	            	 $.messager.show({title:'Message',msg:'E-Mail Send Successfully',showType:'show',
    	                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
    	                    });
    	                 
    	              }
    	             if(status=='error'){
    	            	 // $.messager.alert('Message',"E-Mail Sending failed");
    	            	 $.messager.show({title:'Message',msg:' E-Mail Sending failed',showType:'show',
    	                     style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
    	                    });
    	                   
    	             }
    	             
    	              $("#testImg").attr("src",data.message);
    	              if(typeof(data.error) != 'undefined')  
    	              {  
    	                  if(data.error != '')  
    	                  {  
    	                      alert(data.error);  
    	                  }else  
    	                  {  
    	                      alert(data.message);  
    	                  }  
    	              }  
    	          },  
    	           error: function (data, status, e)
    	          {  
    	              alert(e);  
    	          }  
    	      }  
    	  ) 
    	  return false;
      }

     
      
</script>  
</head>
<body onload="funReadOnly();setValues();">
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
<form id="frmManualInvoice" action="saveManualInvoice" autocomplete="off">
	<script>
			window.parent.formName.value="Invoice";
			window.parent.formCode.value="INV";
	</script>
	<jsp:include page="../../../../header.jsp" />
	
    <div class='receipt-header'>
        <label>Date</label>
        <div>
            <div id="date" name="date" value='<s:property value="date"/>'></div>
            <input type="hidden" name="hiddate" id="hiddate" value='<s:property value="hiddate"/>'>
        </div>

        <label style="margin-left:auto;">Doc No.</label>
        <input type="text" name="voucherno" id="voucherno" value='<s:property value="voucherno"/>'>
    </div>

    <div class="section-row">
        <div class="section-block">
            <h2>Document Details</h2>
            
            <div class="form-group dual-input">
                <label>Agreement</label>
                <select name="cmbagmttype" id="cmbagmttype" value='<s:property value="cmbagmttype"/>'>
                    <option value="">--Select--</option>
                    <option value="RAG">Rental</option>
                    <option value="LAG">Lease</option>
                </select>
                <input type="hidden" name="hidcmbagmttype" id="hidcmbagmttype" value='<s:property value="hidcmbagmttype"/>'>

                <label>Agmt No</label>
                <input type="text" name="agmtvoucherno" id="agmtvoucherno" value='<s:property value="agmtvoucherno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">
            </div>

            <div class="form-group single-label-dual-input">
                <label>Client</label>
                <input type="text" name="client" id="client" value='<s:property value="client"/>'>
                <input type="text" name="clientdetails" id="clientdetails" value='<s:property value="clientdetails"/>'>
            </div>
            
            <div class="form-group">
                <label>Email</label>
                <input type="text" title="E-mail" name="email" id="email" value='<s:property value="email"/>'>
            </div>

            <div class="form-group single-label-dual-input">
                <label>Driver</label>
                <input type="text" name="driver" id="driver" value='<s:property value="driver"/>'>
                <input type="text" name="driverdetails" id="driverdetails" value='<s:property value="driverdetails"/>'>
            </div>

            <div class="form-group">
                <label>Contract Veh</label>
                <input type="text" name="contractvehicle" id="contractvehicle" value='<s:property value="contractvehicle"/>'>
            </div>

            <div class="form-group">
                <label>Veh Details</label>
                <textarea rows="3" name="vehicledetails" id="vehicledetails"><s:property value="vehicledetails"/></textarea>
            </div>
        </div>

        <div class="section-block">
            <h2>Invoice Period & Notes</h2>
            
            <div class="form-group dual-input">
                <label>Period From</label>
                <div>
                    <div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div>
                    <input type="hidden" name="hidfromdate" id="hidfromdate" value='<s:property value="hidfromdate"/>'>
                </div>

                <label>Period To</label>
                <div>
                    <div id="todate" name="todate" value='<s:property value="todate"/>'></div>
                    <input type="hidden" name="hidtodate" id="hidtodate" value='<s:property value="hidtodate"/>'>
                </div>
            </div>

            <div class="form-group">
                <label>Ledger Note</label>
                <input type="text" name="ledgernote" id="ledgernote" value='<s:property value="ledgernote"/>'>
            </div>

            <div class="form-group">
                <label>Invoice Note</label>
                <input type="text" name="invoicenote" id="invoicenote" value='<s:property value="invoicenote"/>'>
            </div>
        </div>
    </div>

    <div class="table-section">
        <h3>Invoice Details Grid</h3>
        <input type="hidden" name="acno" id="acno" value='<s:property value="acno"/>'>
        <input type="hidden" name="hidclient" id="hidclient" value='<s:property value="hidclient"/>'>
        <div id="invoiceDiv">
            <jsp:include page="invoiceGrid.jsp"></jsp:include>
        </div>
    </div>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="curntvehgrn" name="curntvehgrn" value='<s:property value="curntvehgrn"/>'>
<input type="hidden" id="cntrctvehgrn" name="cntrctvehgrn" value='<s:property value="cntrctvehgrn"/>'>
<input type="text" name="deleted" id="deleted" value='<s:property value="deleted"/>' hidden="true"/>
<input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>'>
<input type="hidden" name="dtype" id="dtype" value='<s:property value="dtype"/>'>
<input type="hidden" name="agmtno" id="agmtno" value='<s:property value="agmtno"/>' onkeydown="getAgmtno(event);" placeholder="Press F3 to Search">
<input type="hidden" name="docno" id="docno" value='<s:property value="docno"/>'>
<input type="hidden" name="hidchkdeletedinv" id="hidchkdeletedinv" value='<s:property value="hidchkdeletedinv"/>' >
<div id="accountwindow">
   <div ></div>
</div>
<div id="agmtnowindow">
   <div ></div>
</div>

</form>

</div>
</body>
</html>