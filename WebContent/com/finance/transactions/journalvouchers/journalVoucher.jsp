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
SCOPED UI: Modern Layout (Matches Client Master)
========================================================= */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 24px 0;
    box-sizing: border-box;
    overflow-y: auto !important;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 5px 15px;
    box-sizing: border-box;
    width: 100%;
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select,
.modern-ui input[type="file"] { 
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

/* File input specific fix for 24px height */
.modern-ui input[type="file"] {
    padding: 0px 2px;
    line-height: 22px;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled,
.modern-ui select:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

/* Layout Utilities */
.modern-ui .field-row { 
    display: flex;
    align-items: center; 
    gap: 8px;
    margin-bottom: 10px; 
    flex-wrap: wrap;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Middle Section Panels - No Clipped Headings */
.modern-ui .middle-panel {
    border: 1px solid #c5d3e0; 
    padding: 20px 10px 10px 10px; 
    background: #ffffff; 
    position: relative; 
    border-radius: 4px; 
    margin-bottom: 15px;
    margin-top: 12px; 
}

.modern-ui .middle-panel-title { 
    position: absolute; 
    top: -12px; 
    left: 10px; 
    background: #ffffff; 
    padding: 0 8px; 
    color: #0056b3;
    font-weight: bold; 
    font-size: 14px; 
    border-left: 3px solid #0056b3;
    z-index: 2; 
    line-height: normal; 
}

/* Custom UI Buttons matching 24px height */
.modern-ui .myButton {
    height: 24px !important;
    line-height: 22px !important;
    padding: 0 16px;
    font-family: Arial, sans-serif;
    font-size: 11px;
    font-weight: bold;
    border-radius: 3px;
    cursor: pointer;
    text-shadow: none;
    transition: all 0.2s;
    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
    border: none;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    white-space: nowrap;
}
.modern-ui .myButton:hover { background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%); }

/* Grid Wrapper */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    background: #fff;
    overflow: hidden;
}

/* Scrollbar Logic */
.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 150px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		
         /* COMPACT DATE SIZING */
		 $("#jqxJournalVouchersDate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		 $("#maindate").jqxDateTimeInput({ width: '120px', height: 24, formatString:"dd.MM.yyyy", theme: 'energyblue'});
		
         /* Force internal alignment AFTER render */
         setTimeout(function () {
             $(".jqx-datetimeinput").find("input").css({
                 "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                 "font-family": "Arial, sans-serif", "padding": "0 6px", "box-sizing":"border-box"
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
	
	 function funReadOnly(){
			$('#frmJournalVoucher input').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#jqxJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	 }

	 function funRemoveReadOnly(){
		getConfigs();
			$('#frmJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxJournalVoucher").jqxGrid({ disabled: false}); 
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	   $("#btnclone").hide();
         	   $('#frmJournalVoucher input').attr('readonly', true );
			    $("#jqxJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxJournalVoucher").jqxGrid('addrow', null, {});
   			 	$('#fileexcelimport').attr('disabled', true );
 				$('#btnsearch').attr('disabled', true );
			  }
			 else{
				$("#btnvaluechange").hide();
				$("#btnclone").hide();
				}
			
			if ($("#mode").val() == "A") {
				$('#jqxJournalVouchersDate').val(new Date());
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#jqxJournalVoucher").jqxGrid('clear');
				$("#jqxJournalVoucher").jqxGrid('addrow', null, {});
				$("#btnclone").hide();
				}
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
		
	 function funChkButton() { }
	
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
					console.log(rows[i].docno+"::"+rows[i].description+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+amount+"::"+baseamount+"::"+rows[i].sr_no+"::"+id+":: "+rows[i].costtype+":: "+rows[i].costcode);
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
	  
	  
	  function setValues(){
		
		  if($('#hidjqxJournalVouchersDate').val()){
			 $("#jqxJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxJournalVouchersDate').val());
		  }
		  
		  if($('#hidmaindate').val()){
				 $("#maindate").jqxDateTimeInput('val', $('#hidmaindate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		  if(document.getElementById("lblformposted").innerText.trim()!=""){
			    $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );
		  } else {
			    $('#btnEdit').attr('disabled', false );$('#btnDelete').attr('disabled', false );
		  }
		  
			 var indexVal = document.getElementById("docno").value;
			 if(indexVal>0){
				 var check=1;
	         	 $("#jqxJournalVoucherGrid").load("journalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
			
			if(parseFloat($("#hidstatus").val())<3){
					$("#txtStatus").html("DRAFT");
			}else if(parseFloat($("#hidstatus").val())==4){
					$("#txtStatus").html("REJECTED");
			}else{
					$("#txtStatus").html("");
			}
			getBankReconciled($("#docno").val(), "JVT");   
			
			funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
		    funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
		    getConfigs(); 
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
						
						if((extn=='xls') || (extn=='csv') || (extn=='xlsx')){ 
					        	ajaxFileUpload(items);	
					     }else{
					        	 $.messager.show({title:'Message',msg: 'Only Excel Formats are Supported.',showType:'show',
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
	              });  
	          return false;  
	      }
	
</script>

</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">

<form id="frmJournalVoucher" action="saveJournalVoucher" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp"></jsp:include>

    <div class="modern-ui hidden-scrollbar">

        <div class="middle-panel">
            <span class="middle-panel-title">General Info</span>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Date</label>
                <div style="width: 125px;">
                    <div id="jqxJournalVouchersDate" name="jqxJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxJournalVouchersDate"/>'></div>
                    <input type="hidden" id="hidjqxJournalVouchersDate" name="hidjqxJournalVouchersDate" value='<s:property value="hidjqxJournalVouchersDate"/>'/>
                </div>
                
                <label class="lbl-right" style="width:80px;">Ref. No.</label>
                <input type="text" id="txtrefno" name="txtrefno" style="width:120px;" value='<s:property value="txtrefno"/>'/>
                
                <label class="lbl-right" style="width:80px; margin-left:auto;">Doc No.</label>
                <input type="text" id="docno" name="txtjournalvouchersdocno" style="width:120px;" value='<s:property value="txtjournalvouchersdocno"/>' tabindex="-1" readonly/>
                <span id="txtStatus" style="font-weight:bold; color:#e67e22; margin-left:10px;"></span>
            </div>
            
            <div class="field-row">
                <label class="lbl-right" style="width:80px;">Description</label>
                <input type="text" id="txtdescription" name="txtdescription" style="flex:1;" value='<s:property value="txtdescription"/>'/>
                <label id="lblformposted" name="lblformposted" style="font-size: 13px; font-weight: bold; color: #6000FC; margin-left: 15px;"><s:property value="lblformposted"/></label>
            </div>

           
        </div>

        <div class="middle-panel">
            <span class="middle-panel-title">Voucher Details</span>
            <div class="grid-container" id="jqxJournalVoucherGrid">
                <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
            </div>
            
            <div class="field-row" style="margin-top: 15px; justify-content: flex-end; margin-bottom: 0;">
                <label class="lbl-right">Dr. Total</label>
                <input type="text" id="txtdrtotal" name="txtdrtotal" style="width:120px; text-align:right" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly />
                
                <label class="lbl-right" style="margin-left:15px;">Cr. Total</label>
                <input type="text" id="txtcrtotal" name="txtcrtotal" style="width:120px; text-align:right" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly />
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode"/>
            <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
            <input type="hidden" id="txtexceltypevalidation" name="txtexceltypevalidation" value='<s:property value="txtexceltypevalidation"/>'/>
            <input type="hidden" id="txtexcelaccvalidation" name="txtexcelaccvalidation" value='<s:property value="txtexcelaccvalidation"/>'/>
            <input type="hidden" id="txtexcelgrtypevalidation" name="txtexcelgrtypevalidation" value='<s:property value="txtexcelgrtypevalidation"/>'/>
            <input type="hidden" id="txtexcelcostvalidation" name="txtexcelcostvalidation" value='<s:property value="txtexcelcostvalidation"/>'/>
            <input type="hidden" id="gridlength" name="gridlength"/>
            <div id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
            <input type="hidden" id="hidmaindate" name="hidmaindate" value='<s:property value="hidmaindate"/>'/>
            <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
            <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
            <input type="hidden" id="hidstatus" name="hidstatus" value='<s:property value="status"/>'/>
            <input type="hidden" id="currstatus" name="currstatus" value='<s:property value="currstatus"/>'/>
        </div>

    </div>
</form>

<div id="journalVoucherGridWindow"><div></div><div></div></div>
<div id="costTypeSearchGridWindow"><div></div><div></div></div> 
<div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>
</html>