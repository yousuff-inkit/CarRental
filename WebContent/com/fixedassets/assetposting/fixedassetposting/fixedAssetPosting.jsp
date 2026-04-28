<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   USER ORIGINAL LAYOUT (UNTOUCHED TO PROTECT HEADER)
========================================================= */
.icon {
    width: 2.5em;
    height: 2em;
    border: none;
    background-color: #E0ECF8;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', Arial, sans-serif;
    color: #222;
    margin: 0;
    padding: 10px;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 12px;
    padding: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.08);
}

.hidden-scrollbar {
    overflow-y: auto;
    height: calc(100vh - 40px);
    padding-right: 5px;
}
.hidden-scrollbar::-webkit-scrollbar { width: 6px; }
.hidden-scrollbar::-webkit-scrollbar-thumb { background: #c5d3e0; border-radius: 3px; }

/* =========================================================
   SCOPED UI: Strict Pixel Grid Alignment (Header Safe)
========================================================= */
/* The core wrapper class - placed BELOW the header */
.modern-ui {
    font-size: 12px;
    color: #333;
    width: 100%;
}

/* Master Input Heights */
.modern-ui input[type="text"],
.modern-ui select {
    height: 24px !important;
    border: 1px solid #b8c6d8;
    border-radius: 3px;
    padding: 2px 6px;
    font-size: 12px;
    font-weight: normal !important; 
    box-sizing: border-box;
    background-color: #fff;
    color: #333;
    width: 100%;
    transition: all 0.2s;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus {
    border-color: #007bff;
    outline: none;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
}

.modern-ui input[readonly],
.modern-ui input[disabled] {
    background-color: #f8f9fa;
    color: #666;
}

/* Form Legends & Fieldsets */
.modern-ui fieldset {
    border: 1px solid #c5d3e0;
    border-radius: 6px;
    padding: 10px;
    background: #fdfdfd;
    margin-bottom: 12px;
}

.modern-ui legend {
    font-size: 13px;
    font-weight: bold;
    padding: 0 8px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    border-left: 3px solid #0b45a2;
    line-height: 1.2;
    margin-bottom: 5px;
}

/* Table Alignment - STRICT PERCENTAGE GRID */
.modern-ui table {
    border-collapse: separate;
    border-spacing: 5px 8px; 
    width: 100%;
    table-layout: fixed;
}

.modern-ui td {
    vertical-align: middle;
    padding: 0;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: 600;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Icon Buttons Setup */
.modern-ui .action-btn {
    background: transparent;
    border: 1px solid #e1e4e8;
    border-radius: 4px;
    cursor: pointer;
    padding: 3px 8px;
    transition: background 0.2s;
    height: 26px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
}

.modern-ui .action-btn:hover { 
    background: #f0f3f5; 
}

.modern-ui .action-btn img { 
    width: 16px; 
    height: 16px; 
}

/* Custom Total Wrappers to keep grid aligned */
.modern-ui .total-wrapper {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 8px;
}

.modern-ui .total-wrapper input {
    max-width: 150px;
    text-align: right;
}

.modern-ui #errormsg, 
.modern-ui #validrate {
    color: #d93025;
    font-size: 11px;
    font-weight: bold;
    display: block;
    padding-top: 2px;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
		 $('#btnEdit').attr('disabled', true );
         $('#btnDelete').attr('disabled', true );
         $('#btnAttach').attr('disabled', true );
		 
         /* COMPACT DATE/TIME SIZING */
		 $("#jqxFixedAssetDepreciationPostingDate").jqxDateTimeInput({ width: '120px', height: '24px', formatString:"dd.MM.yyyy"});
         
         /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").css({"margin-top": "0px", "border-color": "#b8c6d8", "border-radius": "3px"});
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", "line-height": "24px", "font-size": "12px", 
                "font-weight": "normal", 
                "padding": "0 6px", "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
        }, 100);
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
</head>

<body onload="setValues();">
<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
    <form id="frmFixedAssetDepreciationPosting" action="fixedassetdepreciationposting" method="post" autocomplete="off">
        <jsp:include page="../../../../header.jsp"></jsp:include><br/>

        <div class="modern-ui">
            <fieldset>
                <legend>Gen. Info</legend>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <colgroup>
                        <col width="8%" />  <col width="15%" /> <col width="45%" /> <col width="12%" /> <col width="20%" /> </colgroup>
                    
                    <tr>
                        <td class="lbl-right">Date</td>
                        <td>
                            <div id="jqxFixedAssetDepreciationPostingDate" name="jqxFixedAssetDepreciationPostingDate" onchange="datechange();" value='<s:property value="jqxFixedAssetDepreciationPostingDate"/>'></div>
                            <input type="hidden" id="hidjqxFixedAssetDepreciationPostingDate" name="hidjqxFixedAssetDepreciationPostingDate" value='<s:property value="hidjqxFixedAssetDepreciationPostingDate"/>'/>
                        </td>
                        
                        <td>
                            <div style="display: flex; gap: 8px; align-items: center; padding-left: 20px;">
                                <button type="button" class="action-btn" id="btnExcelExporter" title="Export current Document to Excel" onclick="funExcelExporter();">
                                     <img alt="Excel" src="<%=contextPath%>/icons/excel_new.png">
                                </button>
                                <button type="button" class="action-btn" id="btnProcessing" title="Process" onclick="funProcessBtn();">
                                     <img alt="Process" src="<%=contextPath%>/icons/process2.png">
                                </button>
                                <button type="button" class="action-btn" id="btnCalculate" title="Calculate" onclick="funCalculateBtn();">
                                    <img alt="Calculate" src="<%=contextPath%>/icons/calculate_new.png">
                                </button>
                            </div>
                        </td>

                        <td class="lbl-right">Doc No.</td>
                        <td>
                            <input type="text" id="docno" name="txtjvno" value='<s:property value="txtjvno"/>' tabindex="-1" readonly/>
                        </td>
                    </tr>
                </table>
            </fieldset>

            <fieldset>
                <legend>Details</legend>
                <div id="vehiclesDetailsDiv"><jsp:include page="assetDetailsGrid.jsp"></jsp:include></div>
                
                <div class="total-wrapper" style="margin-top: 10px;">
                    <span class="lbl-right">Depr. Total</span>
                    <input type="text" id="txtdeprtotal" name="txtdeprtotal" value='<s:property value="txtdeprtotal"/>' tabindex="-1" readonly/>
                </div>
            </fieldset>

            <fieldset>
                <legend>Accounts</legend>
                <div id="accountsDetailsDiv"><jsp:include page="accountsDetailsGrid.jsp"></jsp:include></div>
                
                <div class="total-wrapper" style="margin-top: 10px; justify-content: space-between;">
                    <div style="flex-grow: 1;"></div>
                    
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <span class="lbl-right">Dr. Total</span>
                        <input type="text" id="txtdrtotal" name="txtdrtotal" value='<s:property value="txtdrtotal"/>' tabindex="-1" readonly/>
                    </div>
                    
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <span class="lbl-right">Cr. Total</span>
                        <input type="text" id="txtcrtotal" name="txtcrtotal" value='<s:property value="txtcrtotal"/>' tabindex="-1" readonly/>
                    </div>
                </div>
            </fieldset>

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