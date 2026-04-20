<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath(); %>
<head>
<title>GatewayERP(i)</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<jsp:include page="../../../../includes.jsp"></jsp:include>

<style>
/* =========================================================
   1. 100% SCOPED CSS - GUARANTEED NOT TO BREAK HEADER
========================================================= */

/* Validation Errors */
form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* Wrapper to isolate our form layout from the header */
#statudeduction-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#statudeduction-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#statudeduction-form-container .master-legend {
    font-size: 15px;
    font-weight: 600;
    color: #0056b3;
    padding: 0 10px;
    border-left: 4px solid #0056b3;
    width: auto;
    margin-bottom: 0;
    border-bottom: none;
    line-height: 1.2;
}

/* Flexbox rows */
#statudeduction-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#statudeduction-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#statudeduction-form-container .master-input {
    height: 26px !important;
    border: 1px solid #cbd5e0;
    border-radius: 4px;
    padding: 2px 8px;
    font-size: 13px;
    box-sizing: border-box;
    color: #333;
    background-color: #fff;
    width: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

#statudeduction-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#statudeduction-form-container .master-input[readonly],
#statudeduction-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Search Icon Wrapper */
#statudeduction-form-container .search-wrapper {
    position: relative;
    display: flex;
    flex: 1;
}
#statudeduction-form-container .search-wrapper input {
    padding-right: 28px !important;
}
#statudeduction-form-container .search-wrapper svg {
    position: absolute;
    right: 6px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
}
#statudeduction-form-container .search-wrapper svg:hover { color: #007bff; }

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.statutorydeductions.ClsStatutorydeductionsDAO"%>
<% ClsStatutorydeductionsDAO showDAO = new ClsStatutorydeductionsDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Statutory Deductions(STD)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Statutory Deductions";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="STD";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="STD";
		if(window.parent && window.parent.formName) window.parent.formName.value="Statutory Deductions";
	   
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
		$("#statudate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
	   
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#statudate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#statudate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
        }, 0);

	    $('#accountSearchwindow').jqxWindow({ width: '60%', height: '62%',  maxHeight: '75%' ,maxWidth: '60%' , title: 'Account Search' ,position: { x: 150, y: 60 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		$('#accountSearchwindow').jqxWindow('close');
		   
		$('#acno').dblclick(function(){
		    if($('#mode').val()!= "view") {
			 	 $('#accountSearchwindow').jqxWindow('open');
			 	 accountSearchContent('accountsDetailsSearch.jsp?');
		    }
		});   
		   
        var alcdata='<%=showDAO.searchstatu()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'date', type: 'date'  },
                          	{name : 'satudeduction', type: 'String'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                        	{name : 'chktype', type: 'String'  },
                 ],
                  localdata: alcdata,
                 
                pager: function (pagenum, pagesize, oldpagenum) {
                    
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#deductiongrid").jqxGrid(
                    {
                    	width: "100%",
                    	height: 375,
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
        					{ text: 'Statutory Deductions',columntype: 'textbox', filtertype: 'input', datafield: 'satudeduction', width: '20%' },
        					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
        					{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '26%' },
        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '30%' },
        					{ text: 'accdocno',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
        					{ text: 'chktype',columntype: 'textbox', filtertype: 'input', datafield: 'chktype', width: '10%' ,hidden: true},
        	              ]
                    });

            $('#deductiongrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#deductiongrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("satudeduction").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "satudeduction");
                $("#statudate").jqxDateTimeInput('val', $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
            	$('#frmstatudeduction .master-input').attr('disabled', false);
                document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
                
                if ($("#mode").val() == "view") {
	            	$('#frmstatudeduction select.master-input').attr('disabled', true);
                }
            });   
        });
	
	function funSearchLoad(){
		 changeContent('statutorydeductionsearch.jsp'); 
	 }
	
     function accountSearchContent(url) {
            $.get(url).done(function (data) {
            $('#accountSearchwindow').jqxWindow('setContent', data);
		}); 
     }
  	  
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmstatudeduction .master-input').attr('readonly', true);
    		$('#frmstatudeduction select.master-input').attr('disabled', true);
    		$('#statudate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmstatudeduction .master-input').attr('readonly', false);
    		$('#frmstatudeduction select.master-input').attr('disabled', false);
    		$('#docno').attr('readonly', true);
    		$('#acno').attr('readonly', true);
    		$('#accname').attr('readonly', true);
    		$('#statudate').jqxDateTimeInput({ disabled: false});
    
    		if ($("#mode").val() == "A") {
    			 $('#statudate').val(new Date());
    		   }
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#statudate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    		
    		if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		}
    		 
    		 if(document.getElementById("hidtype") && $('#hidtype').val()=="1") {
    			 $('#type').val("1");
    		 } else if(document.getElementById("type")) {
    			 $('#type').val("0");
    		 }
    		 
             if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
             }
	    } catch(e) { console.error("Error in setValues: ", e); }
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	 	 if($('#mode').val()!="view") {
	 	 if(x==114){
	 	  	$('#accountSearchwindow').jqxWindow('open');
	 	    accountSearchContent('accountsDetailsSearch.jsp?');    }
	 	 else{}
	 		}
	 	 }
	     
	     function funNotify(){
	         	if(document.getElementById("satudeduction").value=="") {
		        		document.getElementById("errormsg").innerText=" Enter Statutory Deductions ";
		        		document.getElementById("satudeduction").focus();
		        		return 0;
        		}
	         	
	         	if(document.getElementById("acno").value=="") {
	         		document.getElementById("errormsg").innerText=" Search Account";
	         		document.getElementById("acno").focus();
	         		return 0;
        		}
	    		return 1;
		} 
	     
	    function funFocus(){
	    	 $('#statudate').jqxDateTimeInput('focus');
	    }
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmstatudeduction" action="savestatuDeduction" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div id="statudeduction-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px; margin-top: 15px;">
            <legend class="master-legend">Deductions Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 50px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="statudate" name="statudate" value='<s:property value="statudate"/>'></div>
                </div>
                
                <label class="master-label" style="width: 140px; margin-left: 20px;">Statutory Deductions</label>
                <input type="text" class="master-input" name="satudeduction" id="satudeduction" placeholder="Statutory Deductions" value='<s:property value="satudeduction"/>' style="flex: 1; max-width: 350px;">
                
                <label class="master-label" style="width: 60px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 100px; flex: none;">
            </div>

            <div class="master-row">
                <label class="master-label" style="width: 50px;">Account</label>
                
                <div class="search-wrapper" style="max-width: 180px;">
                    <input type="text" class="master-input" name="acno" id="acno" readonly="readonly" placeholder="Press F3 To Search" onkeydown="getaccountdetails(event);" value='<s:property value="acno"/>'>
                    <svg onclick="$('#accountSearchwindow').jqxWindow('open'); accountSearchContent('accountsDetailsSearch.jsp?');" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                </div>
                
                <input type="text" class="master-input" name="accname" id="accname" readonly="readonly" value='<s:property value="accname"/>' style="flex: 1; max-width: 400px; margin-left: 10px;">
                
                <label class="master-label" style="width: 60px; margin-left: 20px;">Type</label>
                <select name="type" id="type" class="master-input" style="width: 120px;" value='<s:property value="type"/>'>
                    <option value="0">Amount</option>
                    <option value="1">Percentage</option>
                </select>
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 50px;">Remarks</label>
                <input type="text" class="master-input" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' style="flex: 1;">
            </div>
        </fieldset>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Deductions List</legend>
            <div class="grid-container">
                <div id="deductiongrid"></div>
            </div>
        </fieldset>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
            <input type="hidden" name="hidtype" id="hidtype" value='<s:property value="hidtype"/>' >
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="accountSearchwindow"><div></div></div>

</div>
</body>
</html>