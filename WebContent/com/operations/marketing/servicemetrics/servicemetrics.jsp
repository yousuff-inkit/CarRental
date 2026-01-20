<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* ------------------------------
   GLOBAL STYLES (From Debit Note)
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0;
    min-height: 130vh;
    box-sizing: border-box;
}

#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px;
    max-width: 100%;
    margin: auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   COMMON UI ELEMENTS
------------------------------ */
input[type="text"], select {
    height: 32px !important;
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    background: #fff;
    transition: border-color 0.2s;
    font-size: 14px;
    box-sizing: border-box;
}

input[type="text"]:focus,
select:focus {
    border-color: #007bff;
    outline: none;
}

label {
    font-weight: 600;
    color: #253858;
    white-space: nowrap;
}

/* ------------------------------
   HEADER SECTION
------------------------------ */
.receipt-header {
    background: #f6f8fa;
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 20px;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.section_row {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* ------------------------------
   FORM ROWS LAYOUT
------------------------------ */
.form-group {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px 16px;
    margin-bottom: 12px;
}

.form-group label {
    text-align: right;
    padding-right: 8px;
    font-size: 1rem;
}

.form-group input[type="text"],
.form-group select {
    width: 100%;
}

/* Dual input rows */
.form-group.dual-input {
    grid-template-columns: 120px 1fr 120px 1fr;
}

.form-group.dual-input label:nth-of-type(2) {
    text-align: right;
    padding-right: 8px;
}

/* Full width description row */
.form-row.full-row {
    display: grid;
    grid-template-columns: 120px 1fr;
    align-items: center;
    gap: 12px;
    margin-bottom: 12px;
}

.form-row.full-row label {
    text-align: right;
    padding-right: 8px;
    font-weight: 600;
    color: #253858;
}

/* ------------------------------
   TABLE SECTIONS
------------------------------ */
.table-section {
    margin: 20px 0;
}

/* ------------------------------
   SCROLL AREAS
------------------------------ */
.hidden-scrollbar {
    overflow: auto;
}

.hidden-scrollbar::-webkit-scrollbar {
    width: 10px;
}

/* Validation Styles */
form label.error {
    color:red;
    font-weight:bold;
}
</style>

<script type="text/javascript">
	$(document).ready(function () {  
	    $("#date").jqxDateTimeInput({ width: '100%', height: '32px' ,formatString : "dd.MM.yyyy" });
	    $('#tarifsearchwindow').jqxWindow({ width: '30%', height: '49%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Tarif Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		$('#tarifsearchwindow').jqxWindow('close');
 
		$('#tarifgroup').dblclick(function(){
			if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" ){
				$('#tarifsearchwindow').jqxWindow('open');
				$('#tarifsearchwindow').jqxWindow('focus');
				tarifSearchContent('tarifGroupSearch.jsp');				
			}
		});
	});
	
	function getTarifGroup(event){
    	var x= event.keyCode;
    	if(x==114){
    		if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E" ){
				$('#tarifsearchwindow').jqxWindow('open');
				$('#tarifsearchwindow').jqxWindow('focus');
				tarifSearchContent('tarifGroupSearch.jsp');				
			}
    	}
	}
	
	function tarifSearchContent(url) {
        $.get(url).done(function (data) {
        	$('#tarifsearchwindow').jqxWindow('setContent', data);
    	}); 
    }
	function funSearchLoad(){
		changeContent('mainSearch.jsp', $('#window')); 
	 }
	function funReadOnly() {
		$('#frmServiceMetrics input').attr('readonly', true);
		$('#date').jqxDateTimeInput({
			disabled : true
		});
	}
	function funRemoveReadOnly() {
		$('#frmServiceMetrics input').attr('readonly', false);
		$('#date').jqxDateTimeInput({
			disabled : false
		});
		$('#docno').attr('readonly', true);
		$('#tarifgroup').attr('readonly', true);
		if(document.getElementById("mode").value=="A"){
			$('#serviceMetricsGrid').jqxGrid('clear');
			$("#serviceMetricsGrid").jqxGrid('addrow', null, {});
		}
		if(document.getElementById("mode").value=="E"){
			$("#serviceMetricsGrid").jqxGrid('addrow', null, {});
		}
	}

	function setValues() {
		 if($('#msg').val()!=""){
			   $.messager.alert('Message',$('#msg').val());
			  }
		 if(document.getElementById("docno").value!=""){
			 $('#srvmetricsdiv').load('serviceMetricsGrid.jsp?docno='+document.getElementById('docno').value+'&id=1');
		 }
	}
	 	 $(function(){
	         $('#frmServiceMetrics').validate({
	                 rules: {
	                 tarifgroup: {
	                 	 required:true
	                 }
	                 },
	                 messages: {
	                 	 tarifgroup: {
	                  	  required:" *"
	                  } 
	                 }
	        }); 
	});
	     function funNotify(){
	    
	    	 if(document.getElementById("tarifgroup").value==""){
	    		 document.getElementById("errormsg").innerText="";
	    		 document.getElementById("errormsg").innerText="Tarif Group is Mandatory";
	    		 document.getElementById("tarifgroup").focus();
	    		 return 0;
	    	 }
	    	 else{
	    		 document.getElementById("errormsg").innerText="";
	    	 }
	    	 var rows=$('#serviceMetricsGrid').jqxGrid('getrows');
	    	 var gridlength=0;
	    	 for(var i=0;i<rows.length;i++){
	    		 newTextBox = $(document.createElement("input"))
				    .attr("type", "dil")
				    .attr("id", "test"+i)
				    .attr("name", "test"+i)
				    .attr("hidden", "true");
					gridlength++;
					newTextBox.val(rows[i].srvckm+"::"+rows[i].srvccost+"::"+rows[i].replacecost+"::"+rows[i].tyrecost);		
					newTextBox.appendTo('form');
	    	 }
	    	 document.getElementById("gridlength").value=gridlength;
	    		return 1;
		} 
	     function funFocus(){
	    	 document.getElementById("tarifgroup").focus();
	     }
	  function funExcelBtn(){
		 // $("#jqxBrandSearch1").jqxGrid('exportdata', 'xls', 'Brand');
	  }
</script>  
 
</head>
<body onLoad="setValues();" >
<div id="mainBG" class="hidden-scrollbar homeContent" data-type="background">
    <form id="frmServiceMetrics" action="saveActionServiceMetrics" autocomplete="off">
        <jsp:include page="../../../../header.jsp" />
        
        <div class="receipt-header">
            <div class="section_row">
                
                <div class="form-group dual-input">
                    <label for="date">Date</label>
                    <div id="date" name="date"></div>

                    <label for="docno">Doc No</label>
                    <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' tabindex="-1" readonly>
                </div>

                <div class="form-row full-row">
                    <label for="tarifgroup">Tariff Group</label>
                    <input type="text" name="tarifgroup" id="tarifgroup" value='<s:property value="tarifgroup"/>' placeholder="Press F3 to Search" readonly onkeydown="getTarifGroup(event);">
                </div>

                <div class="form-group dual-input">
                    <label for="insurpercent">Insurance %</label>
                    <input type="text" name="insurpercent" id="insurpercent" value='<s:property value="insurpercent"/>' style="text-align:right;">

                    <label for="insurexcess">Insurance Excess</label>
                    <input type="text" name="insurexcess" id="insurexcess" value='<s:property value="insurexcess"/>' style="text-align:right;">
                </div>

                <div class="form-group dual-input">
                    <label for="tracker">Tracker</label>
                    <input type="text" name="tracker" id="tracker" value='<s:property value="tracker"/>' style="text-align:right;">

                    <label for="regcost">Reg Cost</label>
                    <input type="text" name="regcost" id="regcost" value='<s:property value="regcost"/>' style="text-align:right;">
                </div>

                <div class="form-group">
                    <label for="exkmrate">Ex Km Rate</label>
                    <input type="text" name="exkmrate" id="exkmrate" value='<s:property value="exkmrate"/>' style="text-align:right;">
                </div>

            </div>
        </div>

        <div class="table-section">
            <div id="srvmetricsdiv"><jsp:include page="serviceMetricsGrid.jsp"/></div>
        </div>

        <input type="hidden" name="hidtarifgroup" id="hidtarifgroup" value='<s:property value="hidtarifgroup"/>' >
        <input type="hidden" name="mode" id="mode" value='<s:property value="mode"/>' >
        <input type="hidden" name="msg" id="msg" value='<s:property value="msg"/>' >
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>' >
        <input type="hidden" name="gridlength" id="gridlength" value='<s:property value="gridlength"/>' >
        
        <div id="tarifsearchwindow">
            <div></div>
        </div>
    </form>
</div>
</body>
</html>