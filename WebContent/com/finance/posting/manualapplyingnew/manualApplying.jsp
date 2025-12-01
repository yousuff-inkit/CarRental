<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript" src="<%=contextPath%>/js/ajaxfileupload.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/globalcss.css">

<script type="text/javascript">
	$(document).ready(function() {
		 $('#fileexcelimport').attr('hidden', true );
		 $('#btnsearch').attr('hidden', true );
		 $('#btnClose').attr('disabled', true );$('#btnCreate').attr('disabled', true );$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );
		 $('#btnExcel').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnSearch').attr('disabled', true );$('#btnAttach').attr('disabled', true );

		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
		 $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
		 $("#jqxAppliedInvoicing").jqxGrid({ disabled: true});
		 
		 $('#accountDetailsToWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#accountDetailsToWindow').jqxWindow('close');  
		 
		 $('#cashPaymentGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#cashPaymentGridWindow').jqxWindow('close');
		 
		 $('#txtaccid').dblclick(function(){
			  var date = $('#maindate').jqxDateTimeInput('getDate');
			  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3); 
		     });
		 
	});
	
	function accountSearchContent(url){
	   $('#accountDetailsToWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#accountDetailsToWindow').jqxWindow('setContent', data);
		$('#accountDetailsToWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getAcc(event){
	    var x= event.keyCode;
	    if(x==114){
	    	  var date = $('#maindate').jqxDateTimeInput('getDate');
	    	  accountSearchContent(<%=contextPath+"/"%>+"com/finance/clientAccountDetailsSearch.jsp?atype="+$('#cmbacctype').val()+"&date="+date);
			  $('#txtforsearch').val(3);
	       }
	    }
	    
	function funReadOnly(){
	} 
	
	function funRemoveReadOnly(){}
	
	function funSearchLoad(){}
	
	function funChkButton(){
		/* funReset(); */
	}
	
	function funFocus(){
		document.getElementById("cmbacctype").focus(); 	    		
	}
	
	function funNotify(){	
		$("#jqxApplyInvoicing").jqxGrid('clearfilters');
	  /* Validation */
		 valid=document.getElementById("txtvalidation").value;
		 if(valid==1){
			 document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
			 return 0;
		 }
		 
		    var rows1 = $("#jqxApplyInvoicing").jqxGrid('getrows');
		    var appliedamount=0.00;
		    var applyinvoiceamt=0.00;
		    for(var i=0 ; i < rows1.length ; i++){
				if(rows1[i].balance<0){
					document.getElementById("errormsg").innerText="Invalid Outstanding Amount !!!";
					return 0;
				}
				
            if(typeof(rows1[i].applying) != "undefined" && typeof(rows1[i].applying) != "NaN" && rows1[i].applying != ""){
				appliedamount=parseFloat(appliedamount)+parseFloat(rows1[i].applying);
              }
		    } 
		    applyinvoiceamt=document.getElementById("txtapplyinvoiceamt").value;
		    // alert(applyinvoiceamt+"=="+appliedamount)
		  //  alert(parseFloat(document.getElementById("txtapplyinvoiceamt").value)+"==="+parseFloat(appliedamount));
		// if(parseFloat(appliedamount).toFixed(2)<parseFloat(applyinvoiceamt).toFixed(2)){
//			if(parseFloat(document.getElementById("txtapplyinvoiceamt").value).toFixed(2)<parseFloat(appliedamount).toFixed(2)){
          if(parseFloat(parseFloat(document.getElementById("txtapplyinvoiceamt").value).toFixed(2))<parseFloat(parseFloat(appliedamount).toFixed(2))){
		    	document.getElementById("errormsg").innerText="Limit Already Reached,Invalid Outstanding Amount !!!";
				return 0;
		    }
		    
		    if(parseFloat(document.getElementById("txtapplyinvoicebalance").value)<0){
		    	document.getElementById("errormsg").innerText="Limit Already Reached,Invalid Outstanding Amount !!!";
				return 0;
		    }
		    
		    document.getElementById("errormsg").innerText="";
			
	   /* Validation Ends*/
			
		 /* Applying Invoice Grid Saving */
			var rows = $("#jqxApplyInvoicing").jqxGrid('getrows');
			var lengthapply=0;
			for(var i=0 ; i < rows.length ; i++){
				    var chks=rows[i].applying;
	  				if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
				 	newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+lengthapply)
				    .attr("name", "test"+lengthapply)
				    .attr("hidden", "true");
				 	lengthapply=lengthapply+1;
				 	
				newTextBox.val(rows[i].applying+"::"+parseFloat(rows[i].out_amount+rows[i].applying)+"::"+rows[i].currency+"::"+rows[i].tranid+"::"+rows[i].acno+"::"+rows[i].transno+"::"+rows[i].transtype);
				newTextBox.appendTo('form');
				}
			}
			$('#gridlength').val(lengthapply);
			 /* Applying Invoice Grid Saving Ends*/
			 
			return 1;
	} 
	
	
	function setValues(){
	  
	  document.getElementById("cmbacctype").value=document.getElementById("hidcmbacctype").value;
	  
	  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
	  funSetlabel();
	
	  if($('#msg').val()!=""){
           $.messager.alert('Message',$('#msg').val());
		  }
	 if($('#chkstatus').val()=='3'){
		 funCloseBtn();
	 }
      var accId = document.getElementById("txtdocno").value;
      if(accId!=0){
    	  funloadappliedgrid();
      }
      
	}
	
	function funloadappliedgrid(){
		  $('#mode').val("A");
		  $('#txtgriddocno').val('');$('#txtdoctype').val('');$('#txtapplyinvoiceamt').val('');$('#txtapplyinvoiceapply').val('');$('#txtapplyinvoicebalance').val('');
		  
		  $("#jqxApplyInvoicing").jqxGrid('clear');
		  $("#jqxApplyInvoicing").jqxGrid('addrow', null, {});
		  
		  $("#jqxApplyInvoicing").jqxGrid({ disabled: true});
	      $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
			 
		  $("#jqxAppliedInvoicing").jqxGrid({ disabled: false});
		  var accId = document.getElementById("txtdocno").value;
		  var accType = document.getElementById("cmbacctype").value;
		  var check = 1;
		  
		  $("#overlay, #PleaseWait").show();
		  
	      $("#jqxManualAppliedGrid").load('appliedInvoicingGrid.jsp?accountno='+accId+'&accType='+accType+'&check='+check);
	}
	
	function funUpdateChanges(){
		$('#btnSave').mousedown();
	}
	
	function clearAccountInfo(){  
		$('#txtdocno').val('');$('#txtaccid').val('');$('#txtaccname').val('');	
		if (document.getElementById("txtaccid").value == "") {
	        $('#txtaccid').attr('placeholder', 'Press F3 to Search'); 
	    }
		$("#jqxApplyInvoicing").jqxGrid('clear');              
		$("#jqxAppliedInvoicing").jqxGrid('clear');   
		$('#txtgriddocno').val('');
		$('#txtdoctype').val('');
		$('#txtapplyinvoiceamt').val('');
		$('#txtapplyinvoiceapply').val('');
		$('#txtapplyinvoicebalance').val('');   
		$('#fileexcelimport').attr('hidden', true );
		$('#btnsearch').attr('hidden', true ); 
		$('#exceldocno').val('');   
	}

	function getAttachDocumentNo(){
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				if(items>0){
					
					var path=document.getElementById("fileexcelimport").value;
					var fsize = $('#fileexcelimport')[0].files[0].size;
					var extn = path.substring(path.lastIndexOf(".") + 1, path.length);
					
					if((extn=='xls') || (extn=='csv')){ 
				        	ajaxFileUpload(items);	
				     }else{
				        	 $.messager.show({title:'Message',msg: 'File of xlsx Format is not Supported.',showType:'show',
		                         style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}  
		                     }); 
					            return;
				     } 
				}
				
		  }
		}
			
	x.open("GET","getAttachDocumentNo.jsp",true);
	x.send();
	}
	
	function upload(){
		 
		$('#txtexcelvalidation').val(1);
		getAttachDocumentNo();
		 
	 }
	
	function ajaxFileUpload(docNo) {  
		
		var d = new Date();
		    var jvtdate = d.getDate() + "-" + (d.getMonth()+1) + "-" + d.getFullYear();
		  
		    if (window.File && window.FileReader && window.FileList && window.Blob)
		    {
		        var fsize = $('#fileexcelimport')[0].files[0].size;
		        
		        if(fsize>1048576) {
		            $.messager.show({title:'Message',msg: fsize +' bytes too big ! Maximum Size 1 MB.',showType:'show',
                      style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                  }); 
		            return;
		        }
		    }else{
		    	 $.messager.show({title:'Message',msg:'Please upgrade your browser, because your current browser lacks some new features we need!',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
		        return;
		    }
		
          $.ajaxFileUpload  
          (  
              {  
                  url:'fileAttachAction.action?formCode=MAPPE&doc_no='+docNo+'&descpt=Excel Import' ,
                  secureuri:false,  
                  fileElementId:'fileexcelimport',    
                  dataType: 'json', 
                  success: function (data, status)   
                  {  
                     
                     if(status=='success'){
                         saveExcelDataData(docNo);
                         $.messager.show({title:'Message',msg:'Successfully Uploaded',showType:'show',
                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
                        }); 
                      }
                     
                      if(typeof(data.error) != 'undefined')  
                      {  
                          if(data.error != '')  
                          {  
                              $.messager.show({title:'Message',msg: data.error,showType:'show',
  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
  	                        }); 
                          }else  
                          {  
                              $.messager.show({title:'Message',msg: data.message,showType:'show',
	  	                            style:{left:'',right:27,top:document.body.scrollTop+document.documentElement.scrollTop,bottom:''}
	  	              	          }); 
                          }  
                      }  
                  },  
                  error: function (data, status, e){  
                      $.messager.alert('Message',e);
                  }  
              });  
          return false;  
      }
	function saveExcelDataData(docNo){   
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
				var items=x.responseText.trim();
				
				if(items==1){
					$("#overlay, #PleaseWait").show(); 
					$("#exceldocno").val(docNo);    
					$("#jqxManualApplingGrid").load("applyInvoicingGrid.jsp?docno="+docNo+"&accNo="+$('#txtacno').val()+'&accType='+$('#cmbacctype').val()+'&check='+1);
					$.messager.alert('Message', ' Successfully Imported.', function(r){});
				}   
				
		  }
		}
			
	x.open("GET","saveData.jsp?docNo="+docNo,true);
	x.send();
	}
</script>

<style>
.hidden-scrollbar {
  overflow-y: auto;
  max-height: none;   /* allow full natural height */
  height: auto;       /* remove forced 530px */
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
  padding: 10px;
  max-width: 1200px;
  margin: 0 auto;
}


/* ===============================
   TABLE SECTION STYLE
==================================*/

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

.cr-table th, 
.cr-table td {
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


/* ===============================
   MODERN TOP SECTION (NEW UI)
==================================*/

.modern-top-section {
  background: #f5f8ff;
  border: 1px solid #dce6ff;
  padding: 14px 18px;
  border-radius: 12px;
  margin-bottom: 12px;        /* FIXED: no gap */
  box-shadow: 0 2px 8px rgba(44, 95, 255, 0.06);
}

/* EXPERTLY TUNED GRID (perfect alignment) */
.form-grid-apply {
  display: grid;
  grid-template-columns: 160px 220px 360px 70px 120px;
  gap: 18px;
  align-items: end;
}

/* Labels */
.form-item label {
  font-size: 13px;
  font-weight: 600;
  color: #274b8f;
  margin-bottom: 6px;
  display: block;
}

/* Input / Select */
.form-item input[type="text"],
.form-item select {
  width: 100%;
  height: 34px;
  padding: 0 10px;
  font-size: 16px !important;   /* Your global rule: 16px input text */
  border: 1px solid #ccd4e0;
  border-radius: 8px;
  background: white;
  box-sizing: border-box;
}

/* Blue Modern Focus */
.form-item input:focus,
.form-item select:focus {
  border-color: #3b82f6 !important;
  box-shadow: 0 0 0 2px rgba(59,130,246,0.18) !important;
  outline: none;
}

/* Import icon column */
.import-col {
  display: flex;
  justify-content: center;
  align-items: center;
}

.import-wrap { width: 56px; }

.icon-btn {
  width: 56px;
  height: 36px;
  border-radius: 8px;
  background: #fff;
  border: 1px solid #ccd4e0;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
}

.icon-btn img {
  max-width: 22px;
  max-height: 22px;
}

/* Submit button full width */
.submit-col .submit-btn {
  width: 100%;
  height: 36px;
  border-radius: 8px;
  font-weight: 700;
}

/* RESPONSIVE FALLBACK */
@media (max-width: 980px) {
  .form-grid-apply {
    grid-template-columns: 1fr 1fr;
    grid-auto-rows: auto;
  }
}

/* Autofill Fix (master UI rule) */
input:-webkit-autofill {
  -webkit-box-shadow: 0 0 0 1000px white inset !important;
  -webkit-text-fill-color: #000 !important;
}
/* === Modern Summary Row === */
.apply-summary-row {
    display: grid;
    grid-template-columns: 140px 140px 160px 160px 160px 140px;
    gap: 20px;
    margin: 20px 0;
    align-items: end;
}

/* Labels */
.apply-item label {
    font-size: 13px;
    font-weight: 600;
    color: #274b8f;
    margin-bottom: 6px;
    display: block;
}

/* Inputs */
.apply-item input {
    width: 100%;
    height: 34px;
    border: 1px solid #d1d5db;
    border-radius: 8px;
    padding: 0 10px;
    background: #fff;
    font-size: 14px;
    box-sizing: border-box;
}

/* Focus effect */
.apply-item input:focus {
    border-color: #3b82f6 !important;
    box-shadow: 0 0 0 2px rgba(59,130,246,0.18) !important;
    outline: none;
}

/* Update button styling */
.update-btn {
    width: 100%;
    height: 34px !important;
    border-radius: 8px !important;
    font-weight: 700;
}

/* Button alignment */
.btn-col {
    text-align: center;
}

</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualApplyingnew" action="saveManualApplyingNew" method="post" autocomplete="off">

<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class="hidden-scrollbar receipt-header">

    <!-- ===========================
         MODERN TOP FORM SECTION
    ============================ -->
    <div class="modern-top-section">
        <div class="form-grid-apply">

            <!-- Account -->
            <div class="form-item">
                <label>Account</label>
                <select id="cmbacctype" name="cmbacctype" onchange="clearAccountInfo();">
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                </select>
                <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'>
            </div>

            <!-- Account ID -->
            <div class="form-item">
                <label>Account ID</label>
                <input type="text" id="txtaccid" name="txtaccid"
                       placeholder="Press F3 to Search"
                       readonly onkeydown="getAcc(event);"
                       value='<s:property value="txtaccid"/>'>
            </div>

            <!-- Account Name -->
            <div class="form-item">
                <label>Account Name</label>
                <input type="text" id="txtaccname" name="txtaccname"
                       readonly value='<s:property value="txtaccname"/>'>
                <input type="hidden" id="txtdocno" name="txtdocno" 
                       value='<s:property value="txtdocno"/>'>
            </div>

            <!-- Excel Import Button -->
            <div class="form-item import-col">
                <label style="visibility:hidden;">Import Excel</label>
                <div class="import-wrap">
                    <input type="file" id="fileexcelimport" name="file" style="display:none;">
                    <button type="button" class="icon-btn" id="btnsearch"
                            onclick="$('#fileexcelimport').click(); return false;">
                        <img src="<%=contextPath%>/icons/import_excel.png" alt="Import Excel">
                    </button>
                </div>
            </div>

            <!-- Submit -->
            <div class="form-item submit-col">
                <label>&nbsp;</label>
                <button class="myButton submit-btn" id="btnSubmit"
                        onclick="funloadappliedgrid();">Submit</button>
            </div>

        </div>
    </div>
</div>

<!-- ===========================
     UNAPPLIED / OUTSTANDING TABLES
=========================== -->

<h3>Unapplied</h3>
<div class="cr-table" id="jqxManualAppliedGrid">
    <jsp:include page="appliedInvoicingGrid.jsp"></jsp:include>
</div>

<h3>Outstanding</h3>
<div class="cr-table" id="jqxManualApplingGrid">
    <jsp:include page="applyInvoicingGrid.jsp"></jsp:include>
</div><br>

<!-- ===========================
     FOOTER ROW VALUES
=========================== -->
<div class="apply-summary-row">
    <div class="apply-item">
        <label>Doc No</label>
        <input type="text" id="txtgriddocno" name="txtgriddocno" readonly />
    </div>

    <div class="apply-item">
        <label>Doc Type</label>
        <input type="text" id="txtdoctype" name="txtdoctype" readonly />
    </div>

    <div class="apply-item">
        <label>Amount</label>
        <input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" readonly style="text-align:right;" />
    </div>

    <div class="apply-item">
        <label>Applying</label>
        <input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" readonly style="text-align:right;" />
    </div>

    <div class="apply-item">
        <label>Balance</label>
        <input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" readonly style="text-align:right;" />
    </div>

    <div class="apply-item btn-col">
        <label>&nbsp;</label>
        <button class="myButton update-btn" type="button" id="btnUpdate" onclick="funUpdateChanges();">
            Update
        </button>
    </div>
</div>


<!-- Hidden Fields -->
<input type="hidden" id="mode" name="mode">
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'>
<input type="hidden" id="txtforsearch" name="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'>
<input type="hidden" id="chkstatus" name="chkstatus" value='<s:property value="chkstatus"/>'>
<input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'>
<input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'>
<input type="hidden" id="gridlength" name="gridlength">
<input type="hidden" id="exceldocno" name="exceldocno">
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>

</form>

<!-- Windows -->
<div id="cashPaymentGridWindow"><div></div><div></div></div>
<div id="accountDetailsToWindow"><div></div><div></div></div>

</div>
</body>

</html>