<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function () {    
		$('#btnEdit').attr('disabled', true );$('#btnPrint').attr('disabled', true );$('#btnExcel').attr('disabled', true );
		$('#btnDelete').attr('disabled', true );$('#btnAttach').attr('disabled', true );
		 
	    $("#yearEndDate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" ,value:new Date()});
	    $("#accountingYearFrom").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null });
	    $("#accountingYearTo").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null});
	    $("#ycloseDateFrom").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null });
	    $("#ycloseDateTo").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy",value:null });
	    
		$('#ycloseDateTo').focusout(function(){
	    
	    if($('#ycloseDateTo').jqxDateTimeInput('getDate')<=$('#ycloseDateFrom').jqxDateTimeInput('getDate')){
    		document.getElementById("errormsg").innerText="";
    		document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date";
    		return 0;
    	} else {
	    	document.getElementById("errormsg").innerText="";
	    	}
	    
		  });
		
		$('#accountingYearTo').focusout(function(){
			 var accountingtodate = $('#accountingYearTo').val();
			 getNextAccountingPeriods(accountingtodate);
			 $("#yearEndCloseGridID").jqxGrid('clear');
			 $("#yearEndCloseGridID").jqxGrid('addrow', null, {});
			 $("#yearEndCloseGroupGridID").jqxGrid('clear');
		 });
	    
	    
        });
	
	function getNextAccountingPeriods(accountingtodate){
		
		var x = new XMLHttpRequest();
		 x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items= x.responseText.trim();
		        items=items.split('####');
		        
				if(items!=null){
					$('#ycloseDateFrom').jqxDateTimeInput('val',new Date(items[0]));
					$('#ycloseDateTo').jqxDateTimeInput('val',new Date(items[1]));
				} else {
					$('#ycloseDateFrom').jqxDateTimeInput('val',null);
					$('#ycloseDateTo').jqxDateTimeInput('val',null);
				}
				
				
			} else {}
		}
		x.open("GET", "getNextAccountingPeriods.jsp?accountingtodate="+accountingtodate, true);
		x.send();  
	}
	
	function getAccountingPeriods(){
		
 		 var x = new XMLHttpRequest();
		 x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var items= x.responseText.trim();
		        items=items.split('####');
		        
				if(items!=null){
					$('#accountingYearFrom').jqxDateTimeInput('val',new Date(items[0])); 
					$('#accountingYearTo').jqxDateTimeInput('val',new Date(items[1]));
					$('#ycloseDateFrom').jqxDateTimeInput('val',new Date(items[2]));
					$('#ycloseDateTo').jqxDateTimeInput('val',new Date(items[3]));
				} else {
					$('#accountingYearFrom').jqxDateTimeInput('val',null); 
					$('#accountingYearTo').jqxDateTimeInput('val',null);
					$('#ycloseDateFrom').jqxDateTimeInput('val',null);
					$('#ycloseDateTo').jqxDateTimeInput('val',null);
				}
				
				
			} else {}
		}
		x.open("GET", "getAccountingPeriods.jsp", true);
		x.send();  
		
	}
	
	function funSearchLoad(){
		changeContent('yrcMainSearch.jsp');  
	 }

	function funReadOnly() {
		$('#frmYearEndClose input').attr('readonly', true);
		$('#yearEndDate').jqxDateTimeInput({disabled:true});
		$('#accountingYearFrom').jqxDateTimeInput({disabled:true});
		$('#accountingYearTo').jqxDateTimeInput({disabled:true});
		$('#ycloseDateFrom').jqxDateTimeInput({disabled:true});
		$('#ycloseDateTo').jqxDateTimeInput({disabled:true});
		$("#yearEndCloseGridID").jqxGrid({ disabled: true});
		$("#btnview").hide();
		
	}
	
	function funRemoveReadOnly() {
		$('#frmYearEndClose input').attr('readonly', false);
		$('#yearEndDate').jqxDateTimeInput({disabled:false});
		$('#accountingYearTo').jqxDateTimeInput({disabled:false});
		$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
		$("#yearEndCloseGridID").jqxGrid({ disabled: false});
		$('#docno').attr('readonly', true);
		$("#btnview").show();
		
		if(document.getElementById("mode").value=="A"){
			$('#yearEndDate').jqxDateTimeInput('setDate',new Date());
			$('#ycloseDateTo').jqxDateTimeInput('setDate',null);
			$("#yearEndCloseGridID").jqxGrid('clear');
			$("#yearEndCloseGridID").jqxGrid('addrow', null, {});
			$("#yearEndCloseGroupGridID").jqxGrid('clear');
			getAccountingPeriods();
		}
		
		if(document.getElementById("mode").value=="D"){
			$('#yearEndDate').jqxDateTimeInput({disabled:false});
			$('#ycloseDateFrom').jqxDateTimeInput({disabled:false});
			$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
		}
	}

	function setValues() {

		if($('#hidyearEndDate').val()){
			 $("#yearEndDate").jqxDateTimeInput('val', $('#hidyearEndDate').val());
		  }
		
		if($('#hidycloseDateFrom').val()){
			 $("#ycloseDateFrom").jqxDateTimeInput('val', $('#hidycloseDateFrom').val());
		  }
		
		if($('#hidycloseDateTo').val()){
			 $("#ycloseDateTo").jqxDateTimeInput('val', $('#hidycloseDateTo').val());
		  }
		
		if($('#hidaccountingYearFrom').val()){
			 $("#accountingYearFrom").jqxDateTimeInput('val', $('#hidaccountingYearFrom').val());
		  }
		
		if($('#hidaccountingYearTo').val()){
			 $("#accountingYearTo").jqxDateTimeInput('val', $('#hidaccountingYearTo').val());
		  }
		
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		
		 document.getElementById("formdet").innerText=$('#formdetail').val()+" ("+$('#formdetailcode').val().trim()+")";
		 funSetlabel();
			
		 var indexVal = document.getElementById("docno").value;
		 var indexVal1 = document.getElementById("txttrno").value;
		 if(indexVal>0){
         	$("#yearEndCloseDiv").load("yearEndCloseGrid.jsp?docno="+indexVal+"&trno="+indexVal1); 
         	$("#yearEndCloseGroupDiv").load("yearEndCloseGroupGrid.jsp?docno="+indexVal+"&trno="+indexVal1);
		 }
         
	}
	
	/*  $(function(){
	        $('#frmBrand').validate({
	                 rules: {
	                 brand: {
	                	 required:true,
	                	 maxlength:40
	                 }
	                 },
	                 messages: {
	                  brand: {
	                	  required:" *",
	                	  maxlength:"max 40 only"
	                  } 
	                 }
	        });}); */
	        
	     function funNotify(){
	    
	        	if($('#accountingYearTo').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Accounting Year To Close Date is Mandatory.";
	        		return 0;
	        	}
	        	
	        	if($('#ycloseDateTo').jqxDateTimeInput('getDate')==null){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Next Accounting Year Close Date is Mandatory.";
	        		return 0;
	        	}

	        	if($('#accountingYearTo').jqxDateTimeInput('getDate')<=$('#accountingYearFrom').jqxDateTimeInput('getDate')){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Acounting Year To Close Date Cannot be less than From Date.";
	        		return 0;
	        	}
	        	
	        	if($('#ycloseDateTo').jqxDateTimeInput('getDate')<=$('#ycloseDateFrom').jqxDateTimeInput('getDate')){
	        		document.getElementById("errormsg").innerText="";
	        		document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date.";
	        		return 0;
	        	}
	        	
	        	/* Year End Close Grid  Saving*/
				 var rows = $("#yearEndCloseGridID").jqxGrid('getrows');
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
							
							var amount,baseamount,id;
							
						    amount=parseFloat(rows[i].amount)*parseFloat(-1);
						    baseamount=parseFloat(rows[i].amount)*parseFloat(rows[i].rate)*parseFloat(-1);
						    
						    if(amount<0){
						    	id=-1;
						    }else {
						    	id=1;
						    }
							
					// alert(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+id+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::"+rows[i].brhid);
				    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+id+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::"+rows[i].brhid);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#gridlength').val(length);
	 		   /* Year End Close Grid  Saving Ends*/
	 		   
		 		/* Year End Close Group Grid  Saving*/
				 var rows = $("#yearEndCloseGroupGridID").jqxGrid('getrows');
				 var grouplength=0;
					 for(var i=0 ; i < rows.length ; i++){
						var chk=rows[i].docno;
						if(typeof(chk) != "undefined" && typeof(chk) != "NaN" && chk != ""){
							newTextBox = $(document.createElement("input"))
						    .attr("type", "dil")
						    .attr("id", "txttest"+grouplength)
						    .attr("name", "txttest"+grouplength)
							.attr("hidden", "false");
							grouplength=grouplength+1;
							
							var amount,baseamount,id;
							
						    amount=rows[i].amount;
						    baseamount=parseFloat(rows[i].amount)*parseFloat(rows[i].rate);
						    
						    if(amount<0){
						    	id=-1;
						    }else {
						    	id=1;
						    }
							
				    newTextBox.val(rows[i].docno+"::"+rows[i].currencyid+"::"+rows[i].rate+"::"+id+"::"+amount+"::"+rows[i].description+"::"+baseamount+"::"+rows[i].brhid);
					newTextBox.appendTo('form');
					 }
					}
		 		 $('#yearendclosegroupgridlength').val(grouplength);
	 		   /* Year End Close Group Grid  Saving Ends*/

	 		    $('#yearEndDate').jqxDateTimeInput({disabled:false});
	        	$('#ycloseDateFrom').jqxDateTimeInput({disabled:false});
	        	$('#ycloseDateTo').jqxDateTimeInput({disabled:false});
	    		$('#accountingYearFrom').jqxDateTimeInput({disabled:false});
	    		$('#accountingYearTo').jqxDateTimeInput({disabled:false});
	    		
	    		return 1;
		} 
	        
	   function funFocus(){
	    	 $('#yearEndDate').jqxDateTimeInput('focus');
	   }
	  
	  function funloadgrid(){
		  
		  if($('#accountingYearTo').jqxDateTimeInput('getDate')==null){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Accounting Year To Close Date is Mandatory.";
      		return 0;
      	  }
      	
      	 if($('#ycloseDateTo').jqxDateTimeInput('getDate')==null){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Next Accounting Year Close Date is Mandatory.";
      		return 0;
      	 }

      	 if($('#accountingYearTo').jqxDateTimeInput('getDate')<=$('#accountingYearFrom').jqxDateTimeInput('getDate')){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Acounting Year To Close Date Cannot be less than From Date.";
      		return 0;
      	 }
      	
      	 if($('#ycloseDateTo').jqxDateTimeInput('getDate')<=$('#ycloseDateFrom').jqxDateTimeInput('getDate')){
      		document.getElementById("errormsg").innerText="";
      		document.getElementById("errormsg").innerText="Next Accounting Year Close Date Cannot be less than From Date.";
      		return 0;
      	  } 
      	
	     var accountingYearFrom = document.getElementById("accountingYearFrom").value;
		 var ycloseDateFrom = document.getElementById("ycloseDateFrom").value;
		 var yearEndDate = document.getElementById("yearEndDate").value;
         if(accountingYearFrom!=null && ycloseDateFrom!=null){
         	$("#yearEndCloseDiv").load("yearEndCloseGrid.jsp?accountingYearFrom="+accountingYearFrom+"&ycloseDateFrom="+ycloseDateFrom+"&yearEndDate="+yearEndDate); 
         	$("#yearEndCloseGroupDiv").load("yearEndCloseGroupGrid.jsp?accountingYearFrom="+accountingYearFrom+"&ycloseDateFrom="+ycloseDateFrom+"&yearEndDate="+yearEndDate);
         }
	         
	  }
	  
</script>  

<style>
/* 1. Reset and fill screen to remove grey space at bottom */
* {
    box-sizing: border-box;
}

body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #333;
    margin: 0;
    padding: 0;
    height: 100vh;
    width: 100%;
    overflow-x: hidden;
    display: flex;
    flex-direction: column;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 15px 25px;
    width: 100%;
    max-width: 100%;
    margin: 0;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
    flex: 1;
    display: flex;
    flex-direction: column;
}

#formdet {
    font-size: 20px;
    font-weight: 700;
    color: #1a2b3c;
    margin-bottom: 12px;
}

/* 2. Header Strip: Date LHS, Doc No RHS */
.receipt-header {
    margin-bottom: 15px;
}

.receipt-header table {
    width: 100%;
    table-layout: fixed;
}

/* Standardized 130px widths for date/doc components */
.jqx-datetimeinput, 
.jqx-datetimeinput input,
#docno, 
.header-docno {
    width: 130px !important;
}

/* 3. Section Styling with Blue Accent Bar */
.section-block {
    background: #f8fafc;
    border-radius: 12px;
    padding: 18px;
    margin-bottom: 15px;
    border: 1px solid #edf2f7;
}

.section-title {
    font-size: 15px;
    font-weight: 600;
    margin: 0 0 15px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #2d3748;
}

/* 4. Labels & Inputs (Master UI Style) */
label {
    font-family: Tahoma, 'Segoe UI', sans-serif;
    font-weight: 500; /* Regular weight as per Master UI */
    color: #4a5568;
    text-align: right;
    font-size: 14px;
    display: block;
    line-height: 32px;
    padding-right: 10px;
}

.myButton {
    background: #007bff;
    color: #fff;
    border: none;
    border-radius: 6px;
    padding: 6px 18px;
    font-weight: 500;
    cursor: pointer;
    font-size: 13px;
    height: 32px;
}

.myButton:hover {
    background: #0056b3;
}

.cr-table {
    width: 100%;
    border-collapse: collapse;
}

.cr-table td {
    padding: 5px;
    vertical-align: middle;
}

input[type="text"] {
    height: 32px;
    border: 1px solid #cbd5e0;
    border-radius: 6px;
    padding: 0 10px;
    font-size: 13px;
    width: 100%;
    background: #fff;
}

input[readonly] {
    background-color: #f1f5f9;
    color: #718096;
}

#formdet {
    text-align: left !important;
    display: block;
}

</style>
    
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmYearEndClose" action="saveYearEndClose"  autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/>
<div id="mainBG">
    

    <div class="receipt-header">
        <table width="100%">
            <tr>
                <td width="50px" align="left"><label>Date</label></td>
                <td width="140px">
                    <div id="yearEndDate" name="yearEndDate" value='<s:property value="yearEndDate"/>'></div>
                    <input type="hidden" name="hidyearEndDate" id="hidyearEndDate" value='<s:property value="hidyearEndDate"/>'>
                </td>
                <td></td>
                <td width="60px" align="right"><label>Doc No</label></td>
                <td width="140px" align="right">
                    <input type="text" id="docno" name="txtyearendclosedocno" class="header-docno" value='<s:property value="txtyearendclosedocno"/>' readonly tabindex="-1">
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <div class="section-title">Year Close Details</div>
        <table class="cr-table" width="100%">
            <tr>
                <td width="15%" align="right"><label>Year To Close</label></td>
                <td width="15%">
                    <div id="accountingYearFrom" name="accountingYearFrom" value='<s:property value="accountingYearFrom"/>'></div>
                </td>
                <td width="5%" align="right"><label>To</label></td>
                <td width="15%">
                    <div id="accountingYearTo" name="accountingYearTo" value='<s:property value="accountingYearTo"/>'></div>
                </td>
                <td rowspan="2" align="left" style="padding-left: 20px;">
                    <button class="myButton" type="button" id="btnview" onclick="funloadgrid();">Submit</button>
                </td>
            </tr>
            <tr>
                <td align="right"><label>Next Year</label></td>
                <td>
                    <div id="ycloseDateFrom" name="ycloseDateFrom" value='<s:property value="ycloseDateFrom"/>'></div>
                </td>
                <td align="right"><label>To</label></td>
                <td>
                    <div id="ycloseDateTo" name="ycloseDateTo" value='<s:property value="ycloseDateTo"/>'></div>
                </td>
            </tr>
        </table>
    </div>

    <div class="section-block">
        <div class="section-title">Closing Records</div>
        <div id="yearEndCloseDiv">
            <jsp:include page="yearEndCloseGrid.jsp"></jsp:include>
        </div>
        <div id="yearEndCloseGroupDiv" hidden="true">
            <jsp:include page="yearEndCloseGroupGrid.jsp"></jsp:include>
        </div>
    </div>



<input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>'>
<input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>'>
<input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'>
<input type="hidden" name="txttrno" id="txttrno" value='<s:property value="txttrno"/>'>
<input type="hidden" name="txtnettotal" id="txtnettotal" value='<s:property value="txtnettotal"/>'>
<input type="hidden" id="gridlength" name="gridlength"/>
<input type="hidden" id="yearendclosegroupgridlength" name="yearendclosegroupgridlength"/>
    </div>
</form>
</div>
</body>
</html>