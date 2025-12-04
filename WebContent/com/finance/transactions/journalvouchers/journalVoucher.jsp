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

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
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
		 //getConfigs();
		   // $("#btnclone").show();
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
						//alert($("#btnclone").show());
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
							// alert("modes 2==="+ $("#mode").val()+"==value==="+indexVal);  
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
		 	  // $("#jqxJournalVoucher").jqxGrid('exportdata', 'xls', 'JournalVoucher');
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
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
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
				 //alert("modes 3==="+ $("#mode").val()+"==value==="+indexVal); 
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

/*  var win= window.open(reurl[0]+"JournalVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();  */
					 }
					else{

						var win= window.open(reurl[0]+"printJournalVoucher?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
					    win.focus();
/* 
var win= window.open(reurl[0]+"JournalVoucherPrint?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus(); */ 
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
//	 		 funRemoveReadOnly();
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
				// $("#jqxJournalVoucher").jqxGrid('clear');
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
						 //alert("modes 1==="+ $("#mode").val()+"==value==="+indexVal); 
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
	              });  
	          return false;  
	      }
	 
</script>

<style>
/* ---------- SCROLL AREA ---------- */
.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

/* Validation labels (if used) */
#validrate,
#validrate1 {
    color: red;
}

/* ---------- BACKGROUND & MAIN CARD ---------- */
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
    background: #ffffff;
    border-radius: 16px;
    padding: 10px;
    max-width: 1200px;
    margin: 0 auto;
    box-shadow: 0 6px 28px rgba(58, 97, 171, 0.18);
}
#mainBG:hover {
  box-shadow: 0 10px 30px rgba(30, 64, 175, 0.30);
}


/* ---------- HEADER WRAPPER (FOR THIS FORM ONLY) ---------- */
#frmJournalVoucher .receipt-header {
    display: block;          /* override global flex so table works normally */
    padding: 0 24px;
        box-shadow: 0 6px 28px rgba(58, 97, 171, 0.18);
    
}

/* Status text */
#txtStatus {
    font-size: 13px;
    font-weight: 600;
    color: #e67e22;
}

/* ---------- TABLE STYLING ---------- */
.table-section {
    margin-bottom: 18px;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table th,
.cr-table td {
    padding: 9px 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 0.95rem;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

.cr-table td {
    vertical-align: middle;  /* center all header fields nicely */
}

/* ---------- HEADER INPUTS & BUTTONS ---------- */
.header-input {
    height: 38px !important;
    padding: 6px 12px !important;
    border-radius: 10px !important;
    font-size: 14px !important;
    box-sizing: border-box;
}

/* Grouping inside header rows */
.form-group-header {
    display: contents; /* let table layout handle widths but keep class hook */
}

/* ---------- BLUE ACTION BUTTONS (REUSE GLOBAL LOOK) ---------- */
.myButton {
    background-color: #3a78e0;
    color: #fff;
    border: none;
    border-radius: 16px;
    padding: 8px 18px;
    font-size: 14px;
    cursor: pointer;
    transition: 0.25s;
}

.myButton:hover {
    background-color: #1f6feb;
}
.hidden-scrollbar {
	max-height: 75vh;
	overflow-y: auto;
	width: 100%;
	padding-right: 6px;
}

.hidden-scrollbar::-webkit-scrollbar {
	width: 8px;
}

.hidden-scrollbar::-webkit-scrollbar-track {
	background: #d5e1f7;
	border-radius: 6px;
}

.hidden-scrollbar::-webkit-scrollbar-thumb {
	background-color: #3a78e0;
	border-radius: 6px;
}

.hidden-scrollbar::-webkit-scrollbar-thumb:hover {
	background-color: #1f6feb;
} 
/* ===============================
   JOURNAL VOUCHER MODERN UI
   =============================== */

/* Table container background */
.table-section .cr-table {
    background: #eef3ff; /* soft blue */
    border-radius: 14px;
    border: none;
     box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);
}

/* Table cells */
.cr-table td {
    padding: 12px 14px !important;
    font-size: 15px;
    color: #1d2a4d;
}

/* Labels inside tables */
.cr-table label {
    font-size: 15px;
    font-weight: 600;
    color: #1d2a4d;
}

/* ===============================
   MODERN INPUT STYLING
   =============================== */

.header-input,
.section-block input[type="text"],
.section-block select,
.cr-table input[type="text"],
.cr-table select {
    height: 40px !important;
    border-radius: 10px !important;
    padding: 8px 12px !important;
    font-size: 15px !important;
    border: 1px solid #c9d6f0 !important;
    background: #ffffff;
    width: 100%;
    box-sizing: border-box;

    /* ⭐ NEUMORPHIC SHADOW */
     box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);

    transition: 0.25s ease;
}

/* Input hover */
.header-input:hover,
.cr-table input[type="text"]:hover,
.cr-table select:hover {
    border-color: #2d6cdf !important;
    box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);

/* Input focus */
.header-input:focus,
.cr-table input[type="text"]:focus,
.cr-table select:focus {
    border-color: #2d6cdf !important;
    outline: none;
     box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);
}

/* Disabled inputs (tabindex -1) */
input[tabindex="-1"] {
    background: #f3f6ff !important;
    color: #6b7a99 !important;
}

/* ===============================
   BUTTONS — Modern Blue Style
   =============================== */

.myButton {
    background: linear-gradient(135deg, #3a78e0, #1f5fd6);
    color: #fff;
    border: none;
    border-radius: 14px;
    padding: 10px 20px;
    font-size: 15px;
    cursor: pointer;
    transition: 0.25s ease;
    box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);
}

.myButton:hover {
    background: linear-gradient(135deg, #1f6feb, #1553be);
    box-shadow:
        0 4px 10px rgba(46, 104, 255, 0.35);
}

/* Icon button */
button.icon {
    background: #ffffff;
    border-radius: 12px;
    padding: 8px 12px;
    border: 1px solid #cdd8f4;
    cursor: pointer;
    transition: 0.25s;
    box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);
}

button.icon:hover {
     box-shadow:
        0 0 6px rgba(88,130,255,0.25),   /* outer soft blue glow */
        inset 1px 1px 3px rgba(0,0,0,0.12), 
        inset -2px -2px 4px rgba(255,255,255,0.9);
}
#frmJournalVoucher input[type="file"] {
    display: inline-block !important;
    opacity: 1 !important;
    width: auto !important;
    height: 38px !important;
    padding: 6px 12px !important;
    color: #333 !important;
    background: #ffffff !important;
    border: 1px solid #b9c9e8 !important;
    border-radius: 10px !important;
    box-shadow: 0 0 10px rgba(47,109,222,0.2);
}
#fileexcelimport {
    min-width: 140px !important;
    flex-shrink: 0 !important;
}

</style>
</head>

<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">

<form id="frmJournalVoucher" action="saveJournalVoucher" method="post" autocomplete="off">

    <jsp:include page="../../../../header.jsp"></jsp:include><br/>

    <!-- ==============================
           JOURNAL VOUCHER HEADER
       =============================== -->
    <div class="receipt-header">
        <div class="table-section">
            <table class="cr-table" width="100%">
                <!-- ROW 1: Date | File | Import | Clone | Value Change | Doc No -->
                <tr class="form-group-header">
                    <!-- Date -->
                    <td width="6%" align="right"><label>Date</label></td>
                    <td width="15%">
                        <div id="jqxJournalVouchersDate"
                             name="jqxJournalVouchersDate"
                             onchange="datechange();" onblur="datechange();"
                             value='<s:property value="jqxJournalVouchersDate"/>'>
                        </div>
                        <input type="hidden" id="hidjqxJournalVouchersDate"
                               name="hidjqxJournalVouchersDate"
                               value='<s:property value="hidjqxJournalVouchersDate"/>'/>
                    </td>

                    <!-- File upload -->
                    <td width="28%" align="right">
                        <input type="file" id="fileexcelimport" name="file" class="header-input">
                    </td>

                    <!-- Import Excel icon button -->
                    <td width="11%" align="center">
                        <button class="icon"
                                id="btnsearch" name="btnsearch"
                                title="Import Excel"
                                type="button"
                                onclick="return upload();">
                            <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">
                        </button>
                    </td>

                    <!-- Clone -->
                    <td width="10%" align="center">
                        <button class="myButton"
                                type="button"
                                id="btnclone" name="btnclone"
                                onclick="funClone();">
                            Clone
                        </button>
                    </td>

                    <!-- Value Change -->
                    <td width="13%" align="center">
                        <button class="myButton"
                                type="button"
                                id="btnvaluechange" name="btnvaluechange"
                                onclick="funwarningopen();">
                            Value Change
                        </button>
                    </td>

                    <!-- Doc No -->
                    <td width="6%" align="right"><label>Doc No</label></td>
                    <td width="21%">
                        <input type="text" id="docno" name="txtjournalvouchersdocno"
                               class="header-input"
                               style="width:50%; text-align:right;"
                               value='<s:property value="txtjournalvouchersdocno"/>' tabindex="-1">
                    </td>
                </tr>

                <!-- ROW 2: Status -->
                <tr>
                    <td colspan="8">
                        <span id="txtStatus"></span>
                    </td>
                </tr>

                <!-- ROW 3: Ref No, Description, Posted label -->
                <tr class="form-group-header">
                    <td align="right"><label>Ref. No.</label></td>
                    <td>
                        <input type="text" id="txtrefno" name="txtrefno"
                               class="header-input"
                               style="width:70%;"
                               value='<s:property value="txtrefno"/>'>
                    </td>

                    <td align="right"><label>Description</label></td>
                    <td colspan="3">
                        <input type="text" id="txtdescription" name="txtdescription"
                               class="header-input"
                               style="width:90%;"
                               value='<s:property value="txtdescription"/>'>
                    </td>

                    <td colspan="2" align="left">
                        <i><b>
                            <label id="lblformposted" name="lblformposted"
                                   style="font-size:13px;font-family:Tahoma;color:#6000FC;">
                                <s:property value="lblformposted"/>
                            </label>
                        </b></i>
                    </td>
                </tr>

                <!-- ROW 4: JQX GRID -->
                <tr>
                    <td colspan="8">
                        <div id="jqxJournalVoucherGrid">
                            <jsp:include page="journalVoucherGrid.jsp"></jsp:include>
                        </div>
                    </td>
                </tr>

                <!-- ROW 5: Totals -->
                <tr class="form-group-header">
                    <td align="right"><label>Dr. Total</label></td>
                    <td>
                        <input type="text" id="txtdrtotal" name="txtdrtotal"
                               class="header-input"
                               style="width:65%;text-align:right;"
                               value='<s:property value="txtdrtotal"/>' tabindex="-1">
                    </td>

                    <td colspan="5" align="right"><label>Cr. Total</label></td>
                    <td width="11%">
                        <input type="text" id="txtcrtotal" name="txtcrtotal"
                               class="header-input"
                               style="width:60%;text-align:right;"
                               value='<s:property value="txtcrtotal"/>' tabindex="-1">
                    </td>
                </tr>

            </table>
        </div>

        <!-- ========= HIDDEN FIELDS ========= -->
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

    </div> <!-- /receipt-header -->

</form>

<!-- ========= POPUP WINDOWS ========= -->
<div id="journalVoucherGridWindow">
    <div></div><div></div>
</div>

<div id="costTypeSearchGridWindow">
    <div></div><div></div>
</div>

<div id="costCodeSearchWindow">
    <div></div><div></div>
</div>

</div> <!-- /mainBG -->

</body>
</html>