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

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
		 $("#jqxFixedAssetDepreciationPostingDate").jqxDateTimeInput({ width: '125px', height: '15px', formatString:"dd.MM.yyyy"});
	    
	});
	
	function getLastMonthDepreciation(date){
	  		var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText;
	  				 items = items.split('***');
	  			     $('#txtchkgridload').val(items[0]);
	  			     $('#txtchkdate').val(items[1]);
	  			     
	  			     document.getElementById("errormsg").innerText="Depreciation done till "+items[2]+".";
	  			     
	  			   if(parseInt($('#txtchkdate').val())==0){
	  				  if(parseInt($('#txtchkgridload').val())==1){
	  					  $("#overlay, #PleaseWait").show();
	  					  $("#vehiclesDetailsDiv").load("assetDetailsGrid.jsp?check=1&deprdate="+date+"&branch="+document.getElementById("brchName").value);
	  					  $('#txtchkgridload').val('');
	  					  $('#txtgridload').val(1);
	  					  $('#btnExcelExporter').show();
	  				  }else if(parseInt($('#txtchkgridload').val())==0) {
	  						$.messager.alert('Message','Depreciation Pending for Last-Month.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}else if(parseInt($('#txtchkgridload').val())==2) {
  							$.messager.alert('Message','Depreciation Already Done.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
  							return;
  					}
	  			  }else {
	  						$.messager.alert('Message','Depreciation date should be Month-End.','warning');
							$("#jqxvehicleDetails").jqxGrid('clear'); 
				            $("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				            $("#jqxVehicleAccounts").jqxGrid('clear');
				            $("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
							$('#txtdeprtotal').val('');
							$('#txtdrtotal').val('');
							$('#txtcrtotal').val('');
	  						return;
	  					}
	  		}
  		}
  		x.open("GET", "getLastMonthDepreciation.jsp?date="+date+"&branch="+document.getElementById("brchName").value, true);
  		x.send();
    }
	
	 function funReadOnly(){
			$('#frmFixedAssetDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: true});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: true});
			$('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput({disabled: true});
			$('#btnProcessing').hide();$('#btnCalculate').hide();$('#btnExcelExporter').hide();
	 }
	 function funRemoveReadOnly(){
		 	$('#btnProcessing').show();$('#btnCalculate').show();
		 	$('#frmFixedAssetDepreciationPosting input').attr('readonly', true );
			$("#jqxvehicleDetails").jqxGrid({ disabled: false});
			$("#jqxVehicleAccounts").jqxGrid({ disabled: false});
			$('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput({disabled: false});
			
			if ($("#mode").val() == "A") {
				$('#jqxFixedAssetDepreciationPostingDate').val(new Date());
				
				var curfromdate= $('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('getDate');
		        var lastdaydate = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
	            var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
	            $('#jqxFixedAssetDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
		 
				$("#jqxvehicleDetails").jqxGrid('clear'); 
				$("#jqxvehicleDetails").jqxGrid('addrow', null, {});
				$("#jqxVehicleAccounts").jqxGrid('clear');
				$("#jqxVehicleAccounts").jqxGrid('addrow', null, {});
			}
	 }
	 
	 function funSearchLoad(){
		 changeContent('fadpMainSearch.jsp'); 
	 }
		
	 function funChkButton() {
			/* funReset(); */
		}
	 
	 function funFocus(){
	    	$('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('focus'); 	    		
	    }
	   
	  function funNotify(){	
	        	/* Validation */
	        	
			    var paydate = $('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('getDate');
				var validdate=funDateInPeriod(paydate);
				if(validdate==0){
				return 0;	
				}
			
	        	var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
	        	if(parseInt(rows[0].acno)>0){
	        		document.getElementById("errormsg").innerText="";
	        	}else {
	        		document.getElementById("errormsg").innerText="Process,Calculate & Save.";
	        	    return 0;	
	        	}
	    		
	    	    /* Validation Ends*/
	        	
	        	/* Vehicle Details Grid  Saving*/
				 var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
				 var length=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].asset_no;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "test"+length)
						    .attr("name", "test"+length)
							.attr("hidden", "true");
							length=length+1;
							
				    newTextBox.val(rows[i].asset_no+"::"+rows[i].depr_amt+"::"+rows[i].frmdate+"::"+rows[i].depr+"::"+rows[i].bookvalue+"::"+rows[i].depacno+"::"+rows[i].accdepacno);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Vehicle Details Grid  Saving Ends*/	
	 		   
		 		/* Account Details Grid Saving */
		    	 var rows = $("#jqxVehicleAccounts").jqxGrid('getrows');
		    	 var journallength=0;
		    	 var amount=0,id=0;
				 for(var i=0 ; i < rows.length ; i++){
					var chks = rows[i].acno;
					console.log(chks+"=="+i+"=="+rows[i].credit+"=="+rows[i].debit)
					if(typeof(chks) != "undefined" && typeof(chks) != "NaN" && chks != ""){
						
					amount=0,id=0;
					if((rows[i].credit!=null) && (rows[i].credit!='undefined') &&  (rows[i].credit!='NaN') && (rows[i].credit!="") && (rows[i].credit!=0)){
						 newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						 amount=rows[i].credit*-1;
						 id=-1;
						 newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
						 newTextBox.appendTo('form');
						 journallength=journallength+1;
					}
					amount=0,id=0;        
					if((rows[i].debit!=null) && (rows[i].debit!='undefined') && (rows[i].debit!='NaN') && (rows[i].debit!="") && (rows[i].debit!=0)){
						 newTextBox = $(document.createElement("input"))
					    .attr("type", "dil")
					    .attr("id", "journal"+journallength)
					    .attr("name", "journal"+journallength)
					    .attr("hidden", "true");
						 amount=rows[i].debit;
						 id=1;
						 newTextBox.val(rows[i].acno+"::"+amount+"::"+id);
						 newTextBox.appendTo('form');
						 journallength=journallength+1;
					}
					}
				 }
				 $('#journalgridlength').val(journallength);
		 		/* Account Details Grid Saving Ends */
	 		   
	    		return 1;
		} 
	  
	  
	  function setValues(){
		  
		  if($('#hidjqxFixedAssetDepreciationPostingDate').val()){
				 $("#jqxFixedAssetDepreciationPostingDate").jqxDateTimeInput('val', $('#hidjqxFixedAssetDepreciationPostingDate').val());
			  }
		  
		  if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		  
		  document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		  funSetlabel();
			
		     var indexVal = document.getElementById("txttrno").value;
			 if(indexVal>0){
	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
			 }
	         
			 var indexVal1 = document.getElementById("docno").value;
	         var indexVal2 = document.getElementById("txttrno").value;
	         if(indexVal1>0){
	         $("#vehiclesDetailsDiv").load("assetDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
	         } 
		}	
	  
	  function funProcessBtn(){
		    var paydate = $('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('getDate');
			var validdate=funDateInPeriod(paydate);
			if(validdate==0){
			return 0;	
			} 
		  var date = $('#jqxFixedAssetDepreciationPostingDate').val();
		  getLastMonthDepreciation(date);
	  }
	  
	  function funCalculateBtn(){
		  $('#btnExcelExporter').show();
		  if($('#txtgridload').val()=='1'){
			  var length = 0;
			  var date=$('#jqxFixedAssetDepreciationPostingDate').val();
			  var curfromdate= $('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('getDate');
			  var lastday = new Date(curfromdate.getFullYear(), curfromdate.getMonth() + 1, 0);
			  var lastdaydate = lastday.getDate();
			  
			  $("#overlay, #PleaseWait").show();
			  
			  $("#vehiclesDetailsDiv").load("assetDetailsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  
			  var rows = $("#jqxvehicleDetails").jqxGrid('getrows');
			  length = rows.length;
			  if(!(length=='0')){
			     $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?check=2&day="+lastdaydate+"&deprdate="+date+"&branch="+document.getElementById("brchName").value);
			  } 
		  }else {
				$.messager.alert('Message','Process & Then Calculate.','warning');
				return;
			}
	  }
	  
	  function funExcelExporter(){
			 //$("#jqxvehicleDetails").jqxGrid('exportdata', 'xls', 'FixedAssetDepreciationPosting');
			 JSONToCSVCon(dataExcelExport, 'FixedAssetDepreciationPosting', true);
		}
		
	  function funExcelBtn() {
		  JSONToCSVCon(dataExcelExport, 'FixedAssetDepreciationPosting', true);
	  }
	  
	  function datechange(){
		    var date = $('#jqxFixedAssetDepreciationPostingDate').jqxDateTimeInput('getDate');
			var lastdaydate = new Date(date.getFullYear(), date.getMonth() + 1, 0);
		    var lastdaymonthdate=new Date(new Date(lastdaydate).setDate(lastdaydate.getDate()));
		    $('#jqxFixedAssetDepreciationPostingDate ').jqxDateTimeInput('setDate', new Date(lastdaymonthdate));
	  }
	  
	   function funPrintBtn() {
			
			if (($("#mode").val() == "view") && $("#docno").val()!="") {
				
				 var url=document.URL;
				 reurl=url.split("assetposting");
			     $("#docno").prop("disabled", false);
			     
					   $.messager.confirm('Confirm', 'Do you want to have header?', function(r){
						if (r){
							 var win= window.open(reurl[0]+"assetposting/fixedassetposting/printFixedAssetPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						     win.focus();
						 }
						else{
							var win= window.open(reurl[0]+"assetposting/fixedassetposting/printFixedAssetPosting?docno="+document.getElementById("docno").value+"&branch="+document.getElementById("brchName").value+"&header=0","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
						    win.focus();
						}
					   });
		     }
		    else {
				$.messager.alert('Message','Select a Document....!','warning');
				return;
			}
	    }
	  
</script>
<style>
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 10px 0;
    box-sizing: border-box;
    overflow-x: hidden;
    min-height: auto;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px;
    width: 98vw;
    max-width: 100vw;
    margin: 0;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    display: block;
    box-sizing: border-box;
    position: relative;
}

#formdet {
    text-align: left !important;
    display: block;
    font-size: 22px;
    font-weight: 700;
    color: #1f2937;
    margin-bottom: 8px;
    padding-left: 5px;
}

input[type="text"], select {
    height: 30px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 4px 10px;
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
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
    text-align: right;
    padding-right: 8px;
}

.receipt-header {
    display: block;
    margin-bottom: 8px;
    padding: 0 5px;
}

.receipt-header table {
    width: 100%;
    table-layout: fixed;
}

.receipt-header td {
    padding: 2px 4px;
    vertical-align: middle;
}

.section-block {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 15px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
    margin-bottom: 8px;
    width: 100%;
    box-sizing: border-box;
}

.section-block h2 {
    font-size: 1rem;
    font-weight: 600;
    margin: 0 0 12px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #333;
}

.agmt-info-grid {
    display: grid;
    grid-template-columns: 100px 150px 1fr 100px 150px;
    align-items: center;
    gap: 8px 12px;
}

.action-btn-group {
    display: flex;
    gap: 10px;
    align-items: center;
}

.icon-btn {
    width: 35px !important;
    height: 35px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    background-color: #fff;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.2s;
    padding: 0;
}

.icon-btn img {
    width: 20px;
    height: 20px;
    object-fit: contain;
}

.icon-btn:hover {
    background-color: #f0f0f0;
    border-color: #007bff;
}

.jqx-datetimeinput {
    height: 30px !important;
    box-sizing: border-box;
    width: 130px !important;
}

#docno, .header-docno {
    width: 150px !important;
}

.grid-container {
    margin-top: 10px;
    background: #fff;
    border-radius: 8px;
    border: 1px solid #e4e7ec;
    overflow: hidden;
}

.total-row {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 15px;
    margin-top: 10px;
}

input[readonly] {
    background-color: #f3f4f6;
    color: #6b7280;
}
</style>

</head>
<body onload="setValues();">
<div id="mainBG" class="homeContent" data-type="background" >
<form id="frmFixedAssetDepreciationPosting" action="fixedassetdepreciationposting" method="post" autocomplete="off">
<jsp:include page="../../../../header.jsp"></jsp:include><br/>

<div id="mainBG">
    

    <div class="receipt-header">
        <table width="90%">
            <tr>
                <td width="60px" align="right"><label>Date</label></td>
                <td width="130px">
                    <div id="jqxFixedAssetDepreciationPostingDate" name="jqxFixedAssetDepreciationPostingDate" onchange="datechange();" value='<s:property value="jqxFixedAssetDepreciationPostingDate"/>'></div>
                    <input type="hidden" id="hidjqxFixedAssetDepreciationPostingDate" name="hidjqxFixedAssetDepreciationPostingDate" value='<s:property value="hidjqxFixedAssetDepreciationPostingDate"/>'/>
                </td>
                <td></td>
                <td width="80px" align="right"><label>Doc No.</label></td>
                <td width="150px" align="right">
                    <input type="text" id="docno" name="txtjvno" class="header-docno" value='<s:property value="txtjvno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <h2>Posting Control</h2>
        <div class="agmt-info-grid" style="grid-template-columns: 100px auto;">
            <label>Actions</label>
            <div class="action-btn-group">
                <button type="button" class="icon-btn" id="btnExcelExporter" title="Export to Excel" onclick="funExcelExporter();">
                    <img src="<%=contextPath%>/icons/excel_new.png" alt="Excel">
                </button>
                <button type="button" class="icon-btn" id="btnProcessing" title="Process" onclick="funProcessBtn();">
                    <img src="<%=contextPath%>/icons/process2.png" alt="Process">
                </button>
                <button type="button" class="icon-btn" id="btnCalculate" title="Calculate" onclick="funCalculateBtn();">
                    <img src="<%=contextPath%>/icons/calculate_new.png" alt="Calculate">
                </button>
            </div>
        </div>
    </div>

    <div class="section-block">
        <h2>Details</h2>
        <div class="grid-container">
            <div id="vehiclesDetailsDiv">
                <jsp:include page="assetDetailsGrid.jsp"></jsp:include>
            </div>
        </div>
        <div class="total-row">
            <label>Depr. Total</label>
            <input type="text" id="txtdeprtotal" name="txtdeprtotal" style="width: 200px; text-align: right; font-weight: bold; color: #007bff;" value='<s:property value="txtdeprtotal"/>' readonly tabindex="-1">
        </div>
    </div>

    <div class="section-block">
        <h2>Accounts</h2>
        <div class="grid-container">
            <div id="accountsDetailsDiv">
                <jsp:include page="accountsDetailsGrid.jsp"></jsp:include>
            </div>
        </div>
        <div class="total-row">
            <label>Dr. Total</label>
            <input type="text" id="txtdrtotal" name="txtdrtotal" style="width: 150px; text-align: right;" value='<s:property value="txtdrtotal"/>' readonly tabindex="-1">
            <label>Cr. Total</label>
            <input type="text" id="txtcrtotal" name="txtcrtotal" style="width: 150px; text-align: right;" value='<s:property value="txtcrtotal"/>' readonly tabindex="-1">
        </div>
    </div>

    <input type="hidden" id="mode" name="mode"/>
    <input type="hidden" id="deleted" name="deleted" value='<s:property value="deleted"/>'/>
    <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/>
    <input type="hidden" id="gridlength" name="gridlength"/>
    <input type="hidden" id="journalgridlength" name="journalgridlength"/>
    <input type="hidden" id="txttrno" name="txttrno" value='<s:property value="txttrno"/>'/>
    <input type="hidden" id="txtgridload" name="txtgridload" value='<s:property value="txtgridload"/>'/>
    <input type="hidden" id="txtchkgridload" name="txtchkgridload" value='<s:property value="txtchkgridload"/>'/>
    <input type="hidden" id="txtchkdate" name="txtchkdate" value='<s:property value="txtchkdate"/>'/>
</div>
</form>
	
</div>
</body>
</html>