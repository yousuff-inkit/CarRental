<%@ taglib prefix="s" uri="/struts-tags"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@page import="com.connection.*" %>
<%@page import="javax.servlet.http.HttpServletRequest.*" %>
<%@page import="javax.servlet.http.HttpSession.*" %>
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
SCOPED UI: Form Layout (Does NOT affect header.jsp)
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

/* Action Buttons specific to Journal Voucher */
.modern-ui .erp-btn {
    height: 24px;
    padding: 0 15px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #fff;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 11px;
    font-weight: bold;
    box-shadow: 0 1px 2px rgba(59, 130, 246, 0.3);
}

.modern-ui .erp-btn-warning {
    background: linear-gradient(135deg, #d97706 0%, #f59e0b 100%);
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		
		$('#btnCreate').attr('disabled', true );
		$('#btnEdit').attr('disabled', true );
		$('#btnDelete').attr('disabled', true );
		
		 $("#btnvaluechange").hide();
		 
         /* FIXED DATE WIDTHS & HEIGHTS */ 
		 $("#jqxJournalVouchersDate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '130px', height: '24px', formatString:"dd.MM.yyyy"});
         
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
		 
		 $('#journalVoucherGridWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Account Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#journalVoucherGridWindow').jqxWindow('close');
		 
		 $('#costTypeSearchGridWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Type Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
 		 $('#costTypeSearchGridWindow').jqxWindow('close');
 		 
 		 $('#costCodeSearchWindow').jqxWindow({width: '25%', height: '58%',  maxHeight: '70%' ,maxWidth: '25%' , title: 'Cost Code Search',position: { x: 420, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#costCodeSearchWindow').jqxWindow('close');
		 getConfigs(); 
	      	
		 
		 $('#jqxJournalVouchersDate').on('change', function (event) {
		    if ($("#mode").val() != "view") {
		    	$("#btnclone").hide();
		    		var journaldate = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(journaldate);
				if(parseInt(validdate)==0){
					document.getElementById("errormsg").innerText="Transaction prior or after Account Period is not valid.";
					return 0;	
				}
			}
		 });
		 
		 $('#txtdescription').keydown(function (evt) {
			  if (evt.keyCode==9) {
			          event.preventDefault();
			          $('#jqxJournalVoucher').jqxGrid('selectcell',0, '');
			          $('#jqxJournalVoucher').jqxGrid('focus',0, '');
			  }
		 });
		 
	});
	
	function AccountSearchContent(url) {
		$('#journalVoucherGridWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#journalVoucherGridWindow').jqxWindow('setContent', data);
		$('#journalVoucherGridWindow').jqxWindow('bringToFront');
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
					 $("#jqxJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	/* SAFE READONLY FUNCTION - Prevents header freezing */
	function funReadOnly(){
	    try {
			$('#frmJournalVoucher input').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: true});
			if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}

	/* SAFE REMOVE READONLY FUNCTION - Critical for Create/Edit buttons */
	function funRemoveReadOnly(){
	    try {
		    getConfigs();
			$('#frmJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			
			if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: false}); 
			
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	   $("#btnvaluechange").show();
         	   $("#btnclone").hide();
         	   $('#frmJournalVoucher input').attr('readonly', true );
			   if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid({ disabled: true});
   			   $('#txtrefno').attr('readonly', false );
   			   $('#txtdescription').attr('readonly', false );
   			   if($("#jqxJournalVoucher").length) $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
   			   $('#fileexcelimport').attr('disabled', true );
 			   $('#btnsearch').attr('disabled', true );
			} else {
				$("#btnvaluechange").hide();
				$("#btnclone").hide();
			}
			
			if ($("#mode").val() == "A") {
				$('#jqxJournalVouchersDate').val(new Date());
				if(document.getElementById("lblformposted")) document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				
				if($("#jqxJournalVoucher").length) {
				    $("#jqxJournalVoucher").jqxGrid('clear');
				    $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
				}
				$("#btnclone").hide();
			}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	 
	 function getConfigs(){
		 var x=new XMLHttpRequest();
			x.onreadystatechange=function(){
			if (x.readyState==4 && x.status==200)
				{
					var items=x.responseText.split("####");
					
					if(parseInt(items[0].trim())==1){
						$("#btnclone").show();
						}
					else {
						$("#btnclone").hide();
					}
					if(parseInt(items[1].trim())==1){
						
						$("#currstatus").val(1);
						$('#jqxJournalVoucher').jqxGrid('showcolumn','curr');
	            		$('#jqxJournalVoucher').jqxGrid('showcolumn','rate');
						 var indexVal = document.getElementById("docno").value;
							 var check=1;
							if(indexVal!=""){
				         	 $("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check);
							}
						 						
					}else{
						$("#currstatus").val(0);
						$('#jqxJournalVoucher').jqxGrid('hidecolumn','curr');
	            		$('#jqxJournalVoucher').jqxGrid('hidecolumn','rate');
					}
					
			  }
			}
				
		x.open("GET","getConfig.jsp",false);
		x.send();
		}
	
	 function funSearchLoad(){
		   changeContent('jvtMainSearch.jsp');  
	 }
	 
	 function funExcelBtn(){
		 if (($("#mode").val() == "view") && $("#docno").val()!="") {
		 	     $("#jqxJournalVoucher").excelexportjs({  
       		containerid: "jqxJournalVoucher", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "jqxJournalVoucher", 
       		columns: getColumns("jqxJournalVoucher") , 
       		worksheetName:"Detail JournalVoucher List"
       		}); 
		 }else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	 }
		
	 function funChkButton() {}
	 
	 function funFocus(){
	    	$('#jqxJournalVouchersDate').jqxDateTimeInput('focus'); 	    		
	    }
	 
	 
	   $(function(){
	        $('#frmJournalVoucher').validate({
	                rules: {
	                   txtdescription:{maxlength:500}
	                 },
	                 messages: {
	                   txtdescription: {maxlength:"    Max 500 chars"}
	                 }
	        });}); 
	   
	  function funNotify(){	
			  /* Validation */
			     
		        var journaldate = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
			    var validdate=funDateInPeriod(journaldate);
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
		    	
		    	/* Journal Voucher Grid Saving */
		    	 var rows = $("#jqxJournalVoucher").jqxGrid('getrows');
		    	 var length=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chk=rows[i].docno;
					if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
						newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "test"+length)
					    .attr("name", "test"+length)
					    .attr("hidden", "true");
						length=length+1;
						
					var amount=0,baseamount=0,id;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 amount=rows[i].credit*-1;
						 baseamount=rows[i].baseamount*-1;
						 id=-1;
					}
					
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 amount=rows[i].debit;
						 baseamount=rows[i].baseamount;
						 id=1;
					}
					
					newTextBox.val(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
					newTextBox.appendTo('form'); 
					}
				 }
				 $('#gridlength').val(length);
		 		/* Journal Voucher Grid Saving Ends */
		    	
		 		if ($("#mode").val() == "E") {
			         $('#frmJournalVoucher select').attr('disabled', false); 
			    }
		 		
	    		return 1;
		} 
	  
	  /* SAFE SET VALUES FUNCTION - Prevents hidden field missing errors */
	  function setValues(){
	      try {
    		  if($('#hidjqxJournalVouchersDate').val()){
    			 $("#jqxJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxJournalVouchersDate').val());
    		  }
    		  
    		  if($('#hidmaindate').val()){
    				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
    		  }
    		  
    		  if($('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		  }
    		  
    		  if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                  var detailVal = $('#formdetail').val() || "";
                  var codeVal = $('#formdetailcode').val() || "";
                  document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
              }
    		  
    		  if (typeof funSetlabel === "function") {
                  funSetlabel();
              }
    			
    		  var lblPosted = document.getElementById("lblformposted");
    		  if(lblPosted && lblPosted.innerText.trim()!=""){
    			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
    		  } else {
    			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
    		  }
    		  
    		  var indexVal = document.getElementById("docno").value;
    		  if(indexVal>0){
    				 var check=1;
    				 if($("#jqxJournalVoucherGrid").length) {
    	         	    $("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
    				 }
    		  }
    			
    		  if(parseFloat($("#hidstatus").val())<3){
    					$("#txtStatus").html("DRAFT");
    		  }else if(parseFloat($("#hidstatus").val())==4){
    					$("#txtStatus").html("REJECTED");
    		  }else{
    					$("#txtStatus").html("");
    		  }
    			
    		  if (typeof getBankReconciled === "function") {
                  getBankReconciled($("#docno").val(), "JVT");   
              }
    			
    		  if (typeof funRoundAmt === "function") {
    			funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
    		    funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
    		  }
    		  
    		  getConfigs(); 
	      } catch (e) {
	          console.error("Error in setValues:", e);
	      }
	  }
	  
	  function funPrintBtn() {
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
		        var reurl="";
				var url=document.URL;
				if( url.indexOf('saveJournalVoucher') >= 0){
					reurl=url.split("saveJournalVoucher");
				}else {
					reurl=url.split("journalVoucher.jsp");
				}
		        $("#docno").prop("disabled", false);  
		     
		        $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
					if (r){
	                    var win= window.open(reurl[0]+"printJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					     win.focus();
					 }
					else{
						var win= window.open(reurl[0]+"printJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
					}
				   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
	  function funClone(){
			 $('#docno').val("");
			 $("#mode").val("A");
			 $("#msg").val("");
			 $("#btnSendmail").hide();
			 $("#status").val(1);	 $("#btnSave").show();		 $("#btnCancel").show();
			 $("#btnApproval").hide();	 $("#btnCreate").hide();	funFocus();
			 $("#btnEdit").hide();	 $("#btnPrint").hide();	 $("#btnExcel").hide();		 $("#btnDelete").hide();
			 $("#btnSearch").hide(); $("#btnAttach").hide();  $("#btnCosting").hide(); $("#btnTerms").hide(); $("#btnGuideLine").hide();
			 $("#brchName").hide();  $("#brchNames").show(); $('#brchNames').attr('readonly', true ); $("#brchNames").val($("#brchName option:selected").text());
			 $("#currency").hide();  $("#currencys").show(); $('#currencys').attr('readonly', true ); $("#currencys").val($("#currency option:selected").text());
			 $('#frmJournalVoucher input').attr('readonly', false );
				$('#txtdrtotal').attr('readonly', true );
				$('#txtcrtotal').attr('readonly', true );
				$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: false});
				$('#docno').attr('readonly', true);
				$("#jqxJournalVoucher").jqxGrid({ disabled: false}); 
				$('#fileexcelimport').attr('hidden', false );
				$('#btnsearch').attr('hidden', false );
				$('#jqxJournalVouchersDate').val(new Date());
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#jqxJournalVoucher").jqxGrid('addrow', null, {});
		 }
		
	  
	  function datechange(){
		  var date = $('#jqxJournalVouchersDate').jqxDateTimeInput('getDate');
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
					
					if(items==1){
						$("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?docNo="+docNo+'&date='+$('#maindate').val());
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
			
			  var jvtdate = $("#jqxJournalVouchersDate").val();
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
	                  url:'fileAttachAction.action?formCode=JVTE&doc_no='+docNo+'&descpt=Excel Import' ,
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

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmJournalVoucher" action="saveJournalVoucher" method="post" autocomplete="off" enctype="multipart/form-data">
<jsp:include page="../../../../header.jsp"></jsp:include>

<div class="modern-ui">
    
    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="6%">Date</td>
                <td width="12%">
                    <div id="jqxJournalVouchersDate" name="jqxJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxJournalVouchersDate"/>'></div>
                    <input type="hidden" id="hidjqxJournalVouchersDate" name="hidjqxJournalVouchersDate" value='<s:property value="hidjqxJournalVouchersDate"/>'/>
                </td>
                <td class="lbl-right" width="8%">Ref. No.</td>
                <td width="15%">
                    <input type="text" id="txtrefno" name="txtrefno" value='<s:property value="txtrefno"/>'/>
                </td>
                <td class="lbl-right" width="8%">Doc No</td>
                <td width="15%">
                    <input type="text" id="docno" name="txtjournalvouchersdocno" value='<s:property value="txtjournalvouchersdocno"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td align="right" width="36%">
                    <span id="txtStatus" style="font-weight: bold; color: #d9534f; margin-right: 20px;"></span>
                </td>
            </tr>
            
            <tr>
                <td class="lbl-right" style="padding-top: 10px;">Description</td>
                <td colspan="5" style="padding-top: 10px;">
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>
                </td>
                <td></td>
            </tr>
            
         
        </table>
    </div>

    <div class="grid-container">
        <div id="jqxJournalVoucherGrid"><jsp:include page="journalVoucherGrid.jsp"></jsp:include></div>
    </div>

    <div class="erp-form-area">
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
            <tr>
                <td class="lbl-right" width="10%">Dr. Total</td>
                <td width="15%">
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right;" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td class="lbl-right" width="10%">Cr. Total</td>
                <td width="15%">
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right;" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly="readonly"/>
                </td>
                <td width="50%" align="right">
                    <i><b><label id="lblformposted" name="lblformposted" style="font-size: 13px; font-family: Tahoma; color:#6000FC;"><s:property value="lblformposted"/></label></b></i>
                </td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <input type="hidden" id="mode" name="mode"/>
        <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>
        <input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
        <input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
        <input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
        <input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
        <input type="hidden" id="gridlength" name="gridlength"/>
        <div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
        <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
        <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
        <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
        <input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
        <input type="hidden" id="currstatus" name="currstatus"  value='<s:property value="currstatus"/>'/>
        
        <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
        <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
    </div>

</div>
</form>

<div id="journalVoucherGridWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>