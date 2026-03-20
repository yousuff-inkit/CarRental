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
/* ------------------------------
    GLOBAL STYLES (MASTER CRV UI)
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
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

.section-block {
    background: #f6f8fa;
    border-radius: 10px;
    padding: 20px 18px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.05);
    margin-bottom: 24px;
}

.section-block h2 {
    font-size: 17.6px;
    font-weight: 600;
    margin: 0 0 16px 0;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    display: flex;
    align-items: center;
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

.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #fff;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
}

.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e4e7ec;
    font-size: 16px;
    color: #333;
}

.cr-table td[align="right"] {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
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
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%) !important;
    color: #ffffff !important;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
  background: linear-gradient(135deg, #083a8a 0%, #1d4ed8 100%) !important;
  box-shadow: 0 4px 6px rgba(59, 130, 246, 0.3);
  transform: translateY(-1px);
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmManualApplyingnew" action="saveManualApplyingNew" method="post" autocomplete="off">  
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div class='hidden-scrollbar'>
    
    <div class="section-block">
        <h2>Manual Applying Search</h2>
        <table class="cr-table" width="100%">
          <tr>
            <td width="5%" align="right">Account</td>
            <td width="10%">
                <select id="cmbacctype" name="cmbacctype" onchange="clearAccountInfo();" value='<s:property value="cmbacctype"/>'>
                    <option value="AP">AP</option>
                    <option value="AR">AR</option>
                </select>
            </td>
            <td width="15%">
                <input type="text" id="txtaccid" name="txtaccid" placeholder="Press F3 to Search" readonly value='<s:property value="txtaccid"/>' onkeydown="getAcc(event);"/>
            </td>
            <td width="25%">
                <input type="text" id="txtaccname" name="txtaccname" readonly value='<s:property value="txtaccname"/>'/>
            </td>
            <td width="20%" align="right">
                <input type="file" id="fileexcelimport" name="file" style="font-size: 11px;"/>
            </td>
            <td width="5%" align="center">
                <button class="icon" id="btnsearch" name="btnsearch" title="Import Excel" type="button" onclick="return upload();">
                    <img alt="Import Excel" src="<%=contextPath%>/icons/import_excel.png" height="24">  
                </button>
            </td>
            <td width="10%" align="center">
                <button class="myButton" type="button" id="btnSubmit" name="btnSubmit" onclick="funloadappliedgrid();">Submit</button>
            </td>
          </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Unapplied Transactions</h2>
        <div id="jqxManualAppliedGrid" style="width: 100%;">
            <jsp:include page="appliedInvoicingGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="section-block">
        <h2>Outstanding Invoices</h2>
        <div id="jqxManualApplingGrid" style="width: 100%;">
            <jsp:include page="applyInvoicingGrid.jsp"></jsp:include>
        </div>
    </div>

    <div class="section-block">
        <h2>Applying Summary</h2>
        <table class="cr-table" width="100%">
          <tr>
            <td width="5%" align="right">Doc No</td>
            <td width="10%"><input type="text" id="txtgriddocno" name="txtgriddocno" readonly value='<s:property value="txtgriddocno"/>' tabindex="-1"/></td>
            
            <td width="5%" align="right">Type</td>
            <td width="10%"><input type="text" id="txtdoctype" name="txtdoctype" readonly value='<s:property value="txtdoctype"/>' tabindex="-1"/></td>
            
            <td width="5%" align="right">Amount</td>
            <td width="10%"><input type="text" id="txtapplyinvoiceamt" name="txtapplyinvoiceamt" style="text-align: right;" readonly value='<s:property value="txtapplyinvoiceamt"/>' tabindex="-1"/></td>
            
            <td width="5%" align="right">Applying</td>
            <td width="10%"><input type="text" id="txtapplyinvoiceapply" name="txtapplyinvoiceapply" style="text-align: right;" readonly value='<s:property value="txtapplyinvoiceapply"/>' tabindex="-1"/></td>
            
            <td width="5%" align="right">Balance</td>
            <td width="10%"><input type="text" id="txtapplyinvoicebalance" name="txtapplyinvoicebalance" style="text-align: right;" readonly value='<s:property value="txtapplyinvoicebalance"/>' tabindex="-1"/></td>
            
            <td width="10%" align="center">
                <button class="myButton" type="button" id="btnUpdate" name="btnUpdate" onkeydown="funUpdateChanges();" onclick="funUpdateChanges();">Update</button>
            </td>
          </tr>
        </table>
    </div>

    <input type="hidden" id="hidcmbacctype" name="hidcmbacctype" value='<s:property value="hidcmbacctype"/>'/>
    <input type="hidden" id="txtdocno" name="txtdocno" value='<s:property value="txtdocno"/>'/>
    <input type="hidden" id="txtvalidation" name="txtvalidation" value='<s:property value="txtvalidation"/>'/>
    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
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
    
<div id="cashPaymentGridWindow"><div></div><div></div></div>              
<div id="accountDetailsToWindow"><div></div><div></div></div>  
    
</div>
</body>
</html>