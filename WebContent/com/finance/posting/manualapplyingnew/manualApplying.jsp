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
		 $('#fileexcelimport').attr('hidden', true );
		 $('#btnsearch').attr('hidden', true );
		 
         // Disable all standard header buttons except Create/Add/Save
         $('#btnClose, #btnEdit, #btnPrint, #btnExcel, #btnDelete, #btnSearch, #btnAttach, #btnApprove, #btnApproval, #btnAttachment').prop('disabled', true)
            .css({'pointer-events': 'none', 'opacity': '0.5'})
            .attr('tabindex', '-1');

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
  overflow: auto;
  height: 530px;
}
</style>
<style>
/* =========================================================
   MODERN ERP LAYOUT - EXACT ALIGNMENT & FULL WIDTH GRID 
   (Fuses tight horizontal alignment with modern clean UI)
========================================================= */
body {
    background: #f4f6f9;
    font-family: Arial, sans-serif;
    color: #333;
    font-size: 12px;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 4px;
    padding: 15px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 1px 4px rgba(0,0,0,0.1);
    box-sizing: border-box;
}

/* Master Input Heights - Set to 24px as requested */
input[type="text"], select {
    height: 24px !important;
    border: 1px solid #ccc;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box;
    width: 100%;
    background-color: #fff;
    color: #333;
}

input[type="text"]:focus, select:focus {
    border-color: #007bff;
    outline: none;
}

/* Clean Panels mapping to fieldsets */
fieldset {
    border: 1px solid #e1e4e8;
    background-color: #fff;
    margin-bottom: 10px;
    padding: 12px 10px 10px 10px;
    border-radius: 4px;
}

legend {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    padding: 0 0 0 6px;
    border-left: 3px solid #0056b3;
    margin-bottom: 5px;
}

/* Strict Full-Width CSS Grid for Top Section */
.top-grid {
    display: grid;
    /* 5 strict columns + inputs. Stretches perfectly across. */
    grid-template-columns: 80px minmax(100px, 1fr) 70px minmax(100px, 1fr) 50px minmax(150px, 2fr) 110px minmax(100px, 1fr) 90px minmax(100px, 1fr);
    column-gap: 8px;
    row-gap: 8px;
    align-items: center;
    width: 100%;
    margin-bottom: 15px;
}

.top-grid > label {
    text-align: right;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.flex-row {
    display: flex;
    align-items: center;
    gap: 5px;
    width: 100%;
}

.chk-container {
    display: flex;
    align-items: center;
    gap: 4px;
    cursor: pointer;
    color: #444;
    font-size: 12px;
    font-weight: bold;
    white-space: nowrap;
}

.chk-container input {
    margin: 0;
    padding: 0;
}

/* Middle Section Split */
.middle-section {
    display: flex;
    gap: 10px;
    margin-bottom: 10px;
}

.middle-panel {
    border: 1px solid #e1e4e8;
    padding: 15px 10px 10px 10px;
    background: #fff;
    position: relative;
    border-radius: 4px;
}

.middle-panel-title {
    position: absolute;
    top: -10px;
    left: 10px;
    background: #fff;
    padding: 0 5px 0 6px;
    color: #0056b3;
    font-weight: bold;
    font-size: 13px;
    border-left: 3px solid #0056b3;
}

/* Clean Tables mapping requested colors */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border: 1px solid #ddd;
}
.cr-table th, .cr-table td {
    padding: 4px 6px;
    border: 1px solid #ddd;
    font-size: 12px;
}
.cr-table th {
    background: #f0f3f5;
    font-weight: bold;
    color: #333;
    text-align: left;
}
.lbl-right {
    text-align: right;
    color: #444;
    font-weight: bold;
    font-size: 12px;
    padding-right: 5px;
}

/* Tabs Override */
#tabs { margin-top: 5px; margin-bottom: 0px; }
#content { padding-top: 10px; }

</style>
</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmManualApplyingnew" action="saveManualApplyingNew" method="post" autocomplete="off">  
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div  class='hidden-scrollbar'>
<table width="100%">
  <tr>
    <td width="5%" align="right">Account</td>
    <td width="6%"><select id="cmbacctype" name="cmbacctype" style="width:70%;" onchange="clearAccountInfo();" value='<s:property value="cmbacctype"/>'>
    <option value="AP">AP</option><option value="AR">AR</option></select>
    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/></td>
    <td width="14%"><input type="text" id="txtaccid" name="txtaccid" style="width:80%;" placeholder="Press F3 to Search" readonly value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/></td>
    <td width="30%"><input type="text" id="txtaccname" name="txtaccname" style="width:90%;" readonly value='<s:property value="txtaccname"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/></td>
    <td width="28%" align="right"><input type="file" id="fileexcelimport" name="file"/></td>
    <td width="11%" align="center"> <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
			<img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png">  
	</button></td>
    <td width="45%" align="center"><button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="funloadappliedgrid();">Submit</button></td>
  </tr>
</table>
<fieldset><legend>Unapplied</legend>
<div id="jqxManualAppliedGrid"><jsp:include page="appliedInvoicingGrid.jsp"></jsp:include></div></fieldset>  
<fieldset><legend>Outstanding</legend>
<div id="jqxManualApplingGrid"><jsp:include page="applyInvoicingGrid.jsp"></jsp:include></div></fieldset><br/>
 <table width="100%">
  <tr>
    <td width="3%" align="right">Doc No</td>
    <td width="6%"><input type="text" id="txtgriddocno" name="txtgriddocno" style="width:70%;" readonly value='<s:property value="txtgriddocno"/>' tabindex="-1"/></td>
    <td width="3%" align="right">Doc Type</td>
    <td width="6%"><input type="text" id="txtdoctype" name="txtdoctype" style="width:60%;" readonly value='<s:property value="txtdoctype"/>' tabindex="-1"/></td>
    <td width="5%" align="right">Amount</td>
    <td width="6%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="width:70%;text-align: right;" readonly value='<s:property value="txtapplyinvoiceamt"/>' tabindex="-1"/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/></td>
    <td width="5%" align="right">Applying</td>
    <td width="6%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="width:70%;text-align: right;" readonly value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>
    <td width="3%" align="right">Balance</td>
    <td width="6%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="width:70%;text-align: right;" readonly value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>
    <td width="7%" align="center"><button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onkeydown="funUpdateChanges();" onclick="funUpdateChanges();">Update</button></td>
  </tr>
</table>

<input type="hidden" id="mode" name="mode"/>
<input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
<input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/>

<input type="hidden" name="txtforsearch" id="txtforsearch" value='<s:property value="txtforsearch"/>'>
<input type="hidden" id="txttranid" name="txttranid" value='<s:property value="txttranid"/>'/>
<input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
<input type="hidden" id="chkstatus" name="chkstatus" value='<s:property value="chkstatus"/>'/>
<input type="hidden" id="txtoutamount" name="txtoutamount" value='<s:property value="txtoutamount"/>'/>
<input type="hidden" id="txtacno" name="txtacno" value='<s:property value="txtacno"/>'/>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="exceldocno" name="exceldocno"/>  
<div hidden="true" id="maindate" name="maindate" value='<s:property value="maindate"/>'></div>
</div>
</form>
	
<div id="cashPaymentGridWindow">
	<div></div><div></div>
</div>  
				
<div id="accountDetailsToWindow">
	<div></div><div></div>
</div>  
	
</div>
</body>
</html>