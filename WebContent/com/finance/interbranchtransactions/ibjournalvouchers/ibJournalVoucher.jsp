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

<script type="text/javascript">
	$(document).ready(function() {
		 $("#btnvaluechange").hide();
		 
		 $("#jqxIbJournalVouchersDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 $("#maindate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
		 
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
					 $("#jqxIbJournalVoucher").jqxGrid({ disabled: false});
					 $('#docno').attr('readonly', true);  
			    }
			   });
	  }
	
	 function funReadOnly(){
		    $("#btnvaluechange").hide();
			$('#frmIbJournalVoucher input').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: true});
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
			$('#fileexcelimport').attr('hidden', true );
			$('#btnsearch').attr('hidden', true );
	 }
	 function funRemoveReadOnly(){
			$('#frmIbJournalVoucher input').attr('readonly', false );
			$('#txtdrtotal').attr('readonly', true );
			$('#txtcrtotal').attr('readonly', true );
			$('#jqxIbJournalVouchersDate').jqxDateTimeInput({disabled: false});
			$('#docno').attr('readonly', true);
			$("#jqxIbJournalVoucher").jqxGrid({ disabled: false}); 
			$('#fileexcelimport').attr('hidden', false );
			$('#btnsearch').attr('hidden', false );
			
			if ($("#mode").val() == "E") {
         	    $("#btnvaluechange").show();
         	    $('#frmIbJournalVoucher input').attr('readonly', true );
			    $("#jqxIbJournalVoucher").jqxGrid({ disabled: true});
   			    $('#txtrefno').attr('readonly', false );
   			    $('#txtdescription').attr('readonly', false );
   			    $("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
   			    $('#fileexcelimport').attr('disabled', true );
				$('#btnsearch').attr('disabled', true );
			  }
			 else{
				$("#btnvaluechange").hide();
			}
			
			if ($("#mode").val() == "A") {
				document.getElementById("lblformposted").innerText="";
				$('#btnEdit').attr('disabled', false );
				$("#jqxIbJournalVoucher").jqxGrid('clear');
				$("#jqxIbJournalVoucher").jqxGrid('addrow', null, {});
			}
			
	 }
	 
	 function funSearchLoad(){
		   changeContent('ijvMainSearch.jsp');  
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus()
	    {
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
		  //var cmbtobranch=$('#cmbtobranch').val();
		  var id=0;
		  var rows = $('#jqxIbJournalVoucher').jqxGrid('getrows');
		  var list1=new Array();
		  for(var i=0 ; i < rows.length ; i++){
			    var chk=rows[i].docno;
			    if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
			    	list1.push(rows[i].brhid);
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
	  			} else {
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
			 		/* Ib Journal Voucher Grid Saving Ends */
			    	
		    		return 1;
	  		}else{
	  			document.getElementById("errormsg").innerText="Inter Brach is not created";
				 return 0;
	  		}
	  		
			  
			   
		} 
	  
	  function setValues(){
		 
			  if($('#hidjqxIbJournalVouchersDate').val()){
				 $("#jqxIbJournalVouchersDate").jqxDateTimeInput('val', $('#hidjqxIbJournalVouchersDate').val());
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
				 var check = 1;
				 $("#jqxJournalVoucherGrid").load("ibJournalVoucherGrid.jsp?txtjournalvouchersdocno2="+indexVal+"&check="+check); 
			 }
			 funRoundAmt($('#txtdrtotal').val(),"txtdrtotal");
		     funRoundAmt($('#txtcrtotal').val(),"txtcrtotal");
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
					
					if(items==1){
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
	              });  
	          return false;  
	      }

	  
</script>

<style>
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 1450px;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

input[type="text"], select {
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

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font: 14px 'Segoe UI';
    font-weight: 500;
    color: #253858;
    white-space: nowrap;
    line-height: 32px;
}

.section-block {
    flex: 1;
    min-width: 0;
    background: #f6f8fa;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 20px;
}

.section-block h2 {
    font-size: 1.1rem;
    font-weight: 600;
    margin: 0 0 20px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    display: flex;
    align-items: center;
    gap: 10px;
}

.trans-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 1.5fr auto 1fr auto 1fr;
    gap: 12px 15px;
    align-items: center;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: auto 1fr auto 3fr auto 1fr;
    gap: 12px 20px;
    align-items: center;
}

.hidden-scrollbar {
    overflow: auto;
    height: 530px;
}

.icon {
    background: none;
    border: none;
    cursor: pointer;
    padding: 0;
}

.myButton {
    padding: 5px 15px;
    cursor: pointer;
}
</style>
</head>

<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
    <jsp:include page="../../../../header.jsp"></jsp:include>
    <br>

    <form id="frmIbJournalVoucher" action="saveIbJournalVoucher" method="post" autocomplete="off">
        <div class="hidden-scrollbar">
            
            <div class="section-block">
                <h2>Voucher Information</h2>
                <div class="trans-info-grid">
                    <label>Date</label>
                    <div id="jqxIbJournalVouchersDate" name="jqxIbJournalVouchersDate" onchange="datechange();" onblur="datechange();" value='<s:property value="jqxIbJournalVouchersDate"/>'></div>
                    
                    <label>Import Data</label>
                    <div style="display: flex; gap: 8px; align-items: center;">
                        <input type="file" id="fileexcelimport" name="file" style="font-size: 11px;"/>
                        <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
                            <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png" height="24">
                        </button>
                    </div>

                    <label>Actions</label>
                    <button class="myButton" type="button" id="btnvaluechange" name="btnvaluechange" onclick="funwarningopen();">Value Change</button>

                    <label>Doc No</label>
                    <input type="text" id="docno" name="txtibjournalvouchersdocno" value='<s:property value="txtibjournalvouchersdocno"/>' tabindex="-1"/>
                </div>

                <div class="agmt-info-grid" style="margin-top: 15px;">
                    <label>Ref. No.</label>
                    <input type="text" id="txtrefno" name="txtrefno" onblur="fungridfocus();" value='<s:property value="txtrefno"/>'/>

                    <label>Description</label>
                    <input type="text" id="txtdescription" name="txtdescription" value='<s:property value="txtdescription"/>'/>

                    <label id="lblformposted" name="lblformposted" style="font-size: 13px; font-weight: bold; color:#6000FC; font-style: italic;">
                        <s:property value="lblformposted"/>
                    </label>
                </div>
            </div>

            <div class="section-block">
                <h2>Voucher Details</h2>
                <div id="jqxJournalVoucherGrid" style="width: 100%;">
                    <jsp:include page="ibJournalVoucherGrid.jsp"></jsp:include>
                </div>
            </div>

            <div class="section-block">
                <h2>Summary</h2>
                <div class="trans-info-grid">
                    <label>Dr. Total</label>
                    <input type="text" id="txtdrtotal" name="txtdrtotal" style="text-align: right; font-weight: bold;" value='<s:property value="txtdrtotal"/>' tabindex="-1"/>
                    
                    <span></span><span></span> <label>Cr. Total</label>
                    <input type="text" id="txtcrtotal" name="txtcrtotal" style="text-align: right; font-weight: bold;" value='<s:property value="txtcrtotal"/>' tabindex="-1"/>
                </div>
            </div>

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
        </div>
    </form>

    <div id="ibJournalVoucherGridWindow"><div></div><div></div></div>
    <div id="branchSearchWindow"><div></div><div></div></div>
    <div id="costTypeSearchGridWindow"><div></div><div></div></div> 
    <div id="costCodeSearchWindow"><div></div><div></div></div> 

</div>
</body>