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
        .hidden-scrollbar {
            overflow: auto;
            height: 530px;
        }
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
            /*box-shadow: 0 4px 24px rgba(0,0,0,0.08);*/
            padding: 10px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .receipt-header {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            margin-bottom: 16px;
            border-radius: 12px;
            padding: 0px 24px;
            font-size: 2vh;
        }
        .receipt-header label {
            font-weight: 500;
            color: #333;
            margin-right: 8px;
        }
        .receipt-header input[type="text"] {
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 6px 10px;
            font-size: 1rem;
            width: 120px;
            background: #fff;
            transition: border-color 0.2s;
        }
        .receipt-header input[type="text"]:focus {
            border-color: #007bff;
            outline: none;
        }
        .receipt-header button {
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 6px 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
        }
        .receipt-header button:hover {
            background: #0056b3;
        }
        #txtStatus {
            font-size: 1rem;
            font-weight: 600;
            color: #e67e22;
            margin-left: 12px;
        }

        .section-row {
            display: flex;
            gap: 26px;
            margin-bottom: 24px;
        }
        .section-block {
            flex: 1;
            background: #f6f8fa;
            border-radius: 10px;
            padding: 20px 18px;
            box-shadow: 0 1px 8px rgba(160,177,217,0.05);
        }

        .section-block h2 {
            font-size: 1.09em;
            font-weight: 500;
            margin: 0 0 16px 0;
            color: #253858;
        }

        .section-block .form-group {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 12px;
        }

        .section-block label {
            min-width: 110px;
            text-align: right;
            font-weight: 500;
            color: #253858;
        }

        .section-block input[type="text"],
        .section-block select {
            flex: 1;
            border: 1px solid #d1d5db;
            border-radius: 6px;
            padding: 6px 10px;
            background: #fff;
            transition: border-color 0.2s;
        }

        .section-block input[type="text"]:focus,
        .section-block select:focus {
            border-color: #007bff;
            outline: none;
        }


        .table-section {
            margin-bottom: 18px;
            padding-inline: 1.04em;
            padding-block: 1.04em;
            border-radius: 8px;
        }
        .table-section h3 {
            color: #253858;
            font-size: 1.04em;
            font-weight: 600;
        }
        .cr-table {
            width: 100%;
            border-collapse: collapse;
            background: #f9fafb;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 0 1px #eef0f6;
        }
        .cr-table th, .cr-table td {
            padding: 9px 10px;
            border-bottom: 1px solid #e4e7ec;
            text-align: left;
            font-size: 1em;
        }
        .cr-table th {
            background: #eef0f6;
            color: #354B6A;
            font-weight: 600;
        }
        .cr-table tr:last-child td {
            border-bottom: none;
        }
    </style>
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmYearEndClose" action="saveYearEndClose"  autocomplete="off" method="post">
<jsp:include page="../../../../header.jsp" /><br/>
	<div class="hidden-scrollbar receipt-header">
<div class="table-section" style="width: 100%;"><h3>Year Close Details</h3>
<table class="cr-table" width="99%">
  <tr>
    <td align="right">Date</td>
    <td colspan="2"><div id="yearEndDate" name="yearEndDate" value='<s:property value="yearEndDate"/>'></div>
    <input type="hidden" name="hidyearEndDate" id="hidyearEndDate" value='<s:property value="hidyearEndDate"/>'></td>
    <td align="right">Doc No</td>
    <td><input type="text" id="docno" name="txtyearendclosedocno" value='<s:property value="txtyearendclosedocno"/>' tabindex="-1"></td>
  </tr>
  <tr>
    <td width="8%" align="right">Year To Close</td>
    <td width="15%"><div id="accountingYearFrom" name="accountingYearFrom" value='<s:property value="accountingYearFrom"/>'></div>
    <input type="hidden" name="hidaccountingYearFrom" id="hidaccountingYearFrom" value='<s:property value="hidaccountingYearFrom"/>'></td>
    <td width="3%" align="right">To</td>
    <td width="20%"><div id="accountingYearTo" name="accountingYearTo" value='<s:property value="accountingYearTo"/>'></div>
    <input type="hidden" name="hidaccountingYearTo" id="hidaccountingYearTo" value='<s:property value="hidaccountingYearTo"/>'></td>
    <td width="54%" rowspan="2" align="left"><button class="myButton" type="button" id="btnview" name="btnview" onclick="funloadgrid();">Submit</button></td>
  </tr>
  <tr>
    <td align="right">Next Accounting Year</td>
    <td><div id="ycloseDateFrom" name="ycloseDateFrom" value='<s:property value="ycloseDateFrom"/>'></div>
    <input type="hidden" name="hidycloseDateFrom" id="hidycloseDateFrom" value='<s:property value="hidycloseDateFrom"/>'></td>
    <td align="right">To</td>
    <td><div id="ycloseDateTo" name="ycloseDateTo" value='<s:property value="ycloseDateTo"/>'></div>
    <input type="hidden" name="hidycloseDateTo" id="hidycloseDateTo" value='<s:property value="hidycloseDateTo"/>'></td>
  </tr>
</table>
</div><br/>

<div class="cr-table" id="yearEndCloseDiv"><jsp:include page="yearEndCloseGrid.jsp"></jsp:include></div><br/>
<div id="yearEndCloseGroupDiv" hidden="true"><jsp:include page="yearEndCloseGroupGrid.jsp"></jsp:include></div>

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

