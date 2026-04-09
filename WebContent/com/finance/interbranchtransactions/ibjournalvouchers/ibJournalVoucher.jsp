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

<style>
/* =========================================================
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Action Buttons */
.modern-ui .erp-btn-warning {
    height: 24px;
    padding: 0 15px;
    background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(245, 158, 11, 0.3);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
         /* FIXED DATE WIDTHS & HEIGHTS */ 
		 $("#jqxIbJournalVouchersDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
         
         /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 0);
		 
		 $('#ibJournalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Accounts Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#ibJournalVoucherGridWindow').jqxWindow('close');
		 
		 $('#branchSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Branch Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#branchSearchWindow').jqxWindow('close');
 		 
 		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costTypeSearchGridWindow').jqxWindow('close');
		 
		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
 		 
 		$('#jqxIbJournalVouchersDate').on('change', function (event) {
			 var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
			 var validdate=funDateInPeriod(ibjournaldate);
			 if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		     }
		 });
 		
 		$('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxIbJournalVoucher').jqxGrid('selectcell',0, 'branch');
			          $('#jqxIbJournalVoucher').jqxGrid('focus',0, 'branch');
			  }
		 });
		 
	});
	
	function BranchSearchContent(url) {
		$('#branchSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#branchSearchWindow').jqxWindow('setContent', data);
		$('#branchSearchWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function AccountSearchContent(url) {
		$('#ibJournalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#ibJournalVoucherGridWindow').jqxWindow('setContent', data);
		$('#ibJournalVoucherGridWindow').jqxWindow('bringToFront');
	}); 
	} 
	
	function costTypeSearchContent(url) {
	    $('#costTypeSearchGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costTypeSearchGridWindow').jqxWindow('setContent', data);
		$('#costTypeSearchGridWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function costCodeSearchContent(url) {
	    $('#costCodeSearchWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#costCodeSearchWindow').jqxWindow('setContent', data);
		$('#costCodeSearchWindow').jqxWindow('bringToFront');
	}); 
	}
	
	 function funwarningopen(){
		 $.messager.confirm('Confirm', 'Transaction will affect Links to the applied Bank Reconcilations & Prepayments.', function(r){
			    if (r){
			    	$("#mode").val("EDIT");
					 $('#txtrefno').attr('readonly', false );$('#txtdescription').attr('readonly', false );
					 $('#txtdrtotal').attr('readonly', true );$('#txtcrtotal').attr('readonly', true );
					 if($("#jqxIbJournalVoucher").length) $("#jqxIbJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 /* SAFE READONLY FUNCTION */
	 function funReadOnly(){
	     try {
		    $("#btnvaluechange").hide();
			$('#frmIbJournalVoucher input').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
			if($("#jqxIbJournalVoucher").length) $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	     } catch(e) { console.error("Error in funReadOnly: ", e); }
	 }
	 
	 /* SAFE REMOVE READONLY FUNCTION */
	 function funRemoveReadOnly(){
	     try {
			$('#frmIbJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			if($("#jqxIbJournalVoucher").length) $("#jqxIbJournalVoucher").jqxGrid({ disabled: false}); 
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbJournalVoucher input').attr('readonly', true );
			    if($("#jqxIbJournalVoucher").length) $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    if($("#jqxIbJournalVoucher").length) $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
   			    $('#fileexcelimport').attr('disabled', true );
				$('#btnsearch').attr('disabled', true );
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
			    if(document.getElementById("lblformposted")) document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				if($("#jqxIbJournalVoucher").length) {
				    $("#jqxIbJournalVoucher").jqxGrid('clear');
				    $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
				}
			}
	     } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	 }
	 
	 function funSearchLoad(){
		   changeContent('ijvMainSearch.jsp');  
	 }
		
	 function funChkButton() { }
	 
	 function funFocus() {
	    	$('#jqxIbJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	 }
	 
	   $(function(){
	        $('#frmIbJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			  
		  var brname=$('#brchName').val();
		  var id=0;
		  var list1=new Array();
		  if($("#jqxIbJournalVoucher").length) {
    		  var rows = $('#jqxIbJournalVoucher').jqxGrid('getrows');
    		  for(var i=0 ; i < rows.length ; i++){
    			    var chk=rows[i].docno;
    			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
    			    	list1.push(rows[i].brhid);
    				}
    		  }
		  }
		  
		  var x = new XMLHttpRequest();
	 		x.onreadystatechange = function() {
	 			if (x.readyState == 4 && x.status == 200) {
	 				var items = x.responseText;

					var itemval = items.trim();
					if(itemval>0){
		 				id=1;
					}
	 			} 
	 		}
	 		x.open("GET",<%=contextPath+"/"%>+"com/finance/interbranchtransactions/checkInterBranch.jsp?br1="+brname+'&list1='+encodeURIComponent(list1), false);
	 		x.send();
	 		
	 		if(id==1){
	 			 var ibjournaldate = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
					var validdate=funDateInPeriod(ibjournaldate);
					if(parseInt(validdate)==0){
						document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
						return 0;	
					}
					
					exceltypevalid=document.getElementById("txtexceltypevalidation").value;
					 if(exceltypevalid!=0){
						 document.getElementById("errormsg").innerText="Invalid Account-Type !!!";
						 return 0;
					 }
					 
					 excelaccvalid=document.getElementById("txtexcelaccvalidation").value;
					 if(excelaccvalid!=0){
						 document.getElementById("errormsg").innerText="Invalid Account !!!";
						 return 0;
					 }
					 
					 excelgrtypevalid=document.getElementById("txtexcelgrtypevalidation").value;
					 if(excelgrtypevalid!=0){
						 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
						 return 0;
					 }
					 
					 excelcostvalid=document.getElementById("txtexcelcostvalidation").value;
					 if(excelcostvalid!=0){
						 document.getElementById("errormsg").innerText="Invalid Cost-Type and Cost-Code !!!";
						 return 0;
					 }
					 
					 excelbranchvalid=document.getElementById("txtexcelbranchvalidation").value;
					 if(excelbranchvalid!=0){
						 document.getElementById("errormsg").innerText="Invalid Branch !!!";
						 return 0;
					 }
					
					 valid=document.getElementById("txtvalidation").value;
					 if(valid==1){
						 document.getElementById("errormsg").innerText="Invalid Transaction !!!";
						 return 0;
					 }
				  
				    var drtot = document.getElementById("txtdrtotal").value;
			 		var crtot = document.getElementById("txtcrtotal").value;
			 		if(drtot>crtot || drtot<crtot){
			 			 document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should be Equal.";
		            return 0;
			 		}
			 		
			 		if(drtot=="" || crtot=="" || drtot=="NaN" || crtot=="NaN" || drtot==0 || crtot==0 || drtot==0.0 || crtot==0.0 || drtot==0.00 || crtot==0.00){
			 			  document.getElementById("errormsg").innerText="Invalid Transaction !!! Credit and Debit should not be Zero.";
			              return 0;
				 		}
			    	document.getElementById("errormsg").innerText="";
			    	/* Validation  Ends*/
			    	
			    	/* Ib Journal Voucher Grid Saving */
			    	if($("#jqxIbJournalVoucher").length) {
    			    	 var rows = $("#jqxIbJournalVoucher").jqxGrid('getrows');
    			    	 var length=0;
    					 for(var i=0 ; i < rows.length ; i++){
    						var chk=rows[i].docno;
    						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
    							newTextBox = $(document.createElement("input"))
    						    .attr("type", "dil")
    						    .attr("id", "test"+i)
    						    .attr("name", "test"+i)
    						    .attr("hidden", "true");
    							length=length+1;
    							
    						var amount,baseamount,id;
    						if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
    							 amount=rows[i].debit;
    							 baseamount=rows[i].baseamount;
    							 id=1;
    						}
    						if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
    							 amount=rows[i].credit*-1;
    							 baseamount=rows[i].baseamount*-1;
    							 id=-1;
    						}
    
    						newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode+"::"+rows[i].brhid);
    						newTextBox.appendTo('form');
    						}
    					 }
    					 $('#gridlength').val(length);
			    	}
			 		/* Ib Journal Voucher Grid Saving Ends */
			    	
		    		return 1;
	 		}else{
	 			document.getElementById("errormsg").innerText="Inter Brach is not created";
				 return 0;
	 		}
		} 
	  
	  /* SAFE SET VALUES FUNCTION */
	  function setValues(){
	      try {
			  if($('#hidjqxIbJournalVouchersDate').length && $('#hidjqxIbJournalVouchersDate').val()){
				 $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxIbJournalVouchersDate').val());
			  }
			  
			  if($('#hidmaindate').length && $('#hidmaindate').val()){
					 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
				  }
			  
			  if($('#msg').length && $('#msg').val()!=""){
				   $.messager.alert('Message',$('#msg').val());
				  }
			 
			  if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                  var detailVal = $('#formdetail').val() || "";
                  var codeVal = $('#formdetailcode').val() || "";
                  document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
              }
              
			  if(typeof funSetlabel === 'function') funSetlabel();
			  
			  var lblPosted = document.getElementById("lblformposted");
			  if(lblPosted && lblPosted.innerText.trim()!=""){
				    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
			  } else {
				    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
			  }
			  
			 var indexVal = document.getElementById("docno") ? document.getElementById("docno").value : 0;
			 if(indexVal>0 && $("#jqxJournalVoucherGrid").length){
				 var check = 1;
				 $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
			 if(typeof funRoundAmt === 'function') {
			     funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
		         funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
			 }
	      } catch(e) { console.error("Error in setValues: ", e); }
		}
	  
	  function funPrintBtn() {
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				var url="";
		        var reurl="";
		        if ($("#msg").val().trim() == "") {
		        	url=document.URL;
		        	if( url.indexOf('saveIbJournalVoucher') >= 0){
		        		reurl=url.split("saveIbJournalVoucher");
		        	}else {
		        		reurl=url.split("ibJournalVoucher.jsp");
		        	}
		        }else if ($("#msg").val().trim() != "") {
		        	url=document.URL;
		        	reurl=url.split("saveIbJournalVoucher");
		        }
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
						 var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printIbJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function datechange(){
		  var date = $('#jqxIbJournalVouchersDate').jqxDateTimeInput('getDate');
		  var validdate=funDateInPeriod(date);
		  if(parseInt(validdate)==0){
				document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
				return 0;	
		  }
		  $("#maindate").jqxDateTimeInput('val', date);
	  }
	  
	  function saveExcelDataData(docNo){
			var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.trim();
					
					if(items==1 && $("#jqxJournalVoucherGrid").length){
						$("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?docNo="+docNo+'&date='+$('#maindate').val());
						$.messager.alert('Message', ' Successfully Imported.', function(r){
					});
					}
			  }
			}
				
		x.open("GET","saveData.jsp?docNo="+docNo,true);
		x.send();
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
			
			  var jvtdate = $("#jqxIbJournalVouchersDate").val();
   		      var newDate = jvtdate.split('.');
   		      jvtdate = newDate[0] + "-" + newDate[1] + "-" + newDate[2];
   		  
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
	                  url:'fileAttachAction.action?formCode=IJVE&doc_no='+docNo+'&descpt=Excel Import' ,
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
	              }  
	          );  
	          return false;  
	      }
</script>
</head>

<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmIbJournalVoucher" action="saveIbJournalVoucher" method="post" autocomplete="off" enctype="multipart/form-data">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">

    <div class="erp-form-area">
        
        <table width="100%" border="0" cellspacing="0" cellpadding="2" style="margin-bottom: 8px;">
            <tr>
                <td class="lbl-right" width="6%">Date</td>
                <td width="12%">
                    <div id="jqxIbJournalVouchersDate" name="jqxIbJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIbJournalVouchersDate"/>'></div>
                </td>
                <td class="lbl-right" width="6%">Doc No</td>
                <td width="12%">
                    <input type="text" id="docno" name="txtibjournalvouchersdocno" value='<s:property value="txtibjournalvouchersdocno"/>' tabindex="-1" readonly="readonly"/>
                </td>
               
                <td align="right" width="34%">
                    <button class="erp-btn-warning" type="button" id="btnvaluechange" onclick="funwarningopen();">Value Change</button>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="6%">Ref. No.</td>
                <td width="12%">
                    <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>' onblur="fungridfocus();"/>
                </td>
                <td class="lbl-right" width="6%">Desc</td>
                <td width="50%">
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                </td>
                <td align="right" width="26%">
                    <span id="lblformposted" name="lblformposted" style="font-size:13px; font-weight:bold; color:#6000FC;"><s:property value="lblformposted"/></span>
                </td>
            </tr>
        </table>

    </div>

    <div class="grid-container" id="jqxJournalVoucherGrid">
        <jsp:include page="ibJournalVoucherGrid.jsp"></jsp:include>
    </div>

    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Dr. Total</td>
                <td width="15%">
                    <input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>' tabindex="-1" style="text-align:right; font-weight:bold;" readonly="readonly"/>
                </td>
                <td class="lbl-right" width="10%">Cr. Total</td>
                <td width="15%">
                    <input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1" style="text-align:right; font-weight:bold;" readonly="readonly"/>
                </td>
                <td width="50%" align="right">
                    <span id="formdet" style="font-size: 13px; font-weight: bold; color:#2c3e50;"></span>
                </td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <input type="hidden" id="hidjqxIbJournalVouchersDate" name="hidjqxIbJournalVouchersDate" value='<s:property value="hidjqxIbJournalVouchersDate"/>'/>
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>

        <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>

        <input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
        <input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
        <input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
        <input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
        <input type="hidden" id="txtexcelbranchvalidation" name="txtexcelbranchvalidation" value='<s:property value="txtexcelbranchvalidation"/>'/>

        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>

<div id="ibJournalVoucherGridWindow"><div></div><div></div></div>
<div id="branchSearchWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div>
<div id="costCodeSearchWindow"><div></div><div></div></div>

</div>
</body>
</html>