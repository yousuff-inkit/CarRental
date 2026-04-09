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
SCOPED UI: Bulletproof Table Layout (Does NOT affect header.jsp)
========================================================= */

.modern-ui {
    font-family: Arial, sans-serif; 
    color: #333;
    font-size: 12px; 
    padding: 10px 20px;
    box-sizing: border-box;
}

.modern-ui .erp-form-area {
    background-color: #f4f7fb;
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    padding: 15px 10px;
    margin-bottom: 10px;
    min-width: 1050px; 
}

/* Master Input Heights - Forced to 24px */
.modern-ui input[type="text"],
.modern-ui select { 
    height: 24px !important; 
    border: 1px solid #b8c6d8; 
    border-radius: 3px; 
    padding: 2px 6px;
    font-size: 12px;
    box-sizing: border-box; 
    background-color: #fff; 
    color: #333;
    width: 100%;
}

.modern-ui input[type="text"]:focus,
.modern-ui select:focus { 
    border-color: #007bff; 
    outline: none;
}

.modern-ui input[readonly],
.modern-ui input:disabled { 
    background-color: #f8f9fa; 
    color: #6b7280;
}

.modern-ui td {
    padding: 4px 5px;
    vertical-align: middle;
}

.modern-ui .lbl-right { 
    text-align: right; 
    color: #444;
    font-size: 12px; 
    font-weight: bold;
    white-space: nowrap; 
    padding-right: 5px;
}

/* Data Grid Container */
.modern-ui .grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-bottom: 10px;
}

form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

.hidden-scrollbar { 
    overflow: auto; 
    height: calc(100vh - 100px);
}
.hidden-scrollbar::-webkit-scrollbar { width: 0px; }
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
	   
        /* FIXED DATE WIDTHS & HEIGHTS */
		$("#statudate").jqxDateTimeInput({ width: '100%', height: '24px' ,formatString : "dd.MM.yyyy" });
	   
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $(".jqx-datetimeinput").find("input").css({
                "margin-top": "0px", 
                "line-height": "24px", 
                "font-size": "12px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 6px", 
                "box-sizing":"border-box"
            });
            $(".jqx-datetimeinput").find(".jqx-action-button").css({"top": "0px", "height": "24px"});
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
            	$('#frmstatudeduction select').attr('disabled', false);
                document.getElementById("type").value = $("#deductiongrid").jqxGrid('getcellvalue', rowindex1, "chktype");
                
                if ($("#mode").val() == "view") {
	            	$('#frmstatudeduction select').attr('disabled', true);
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
    		$('#frmstatudeduction input').attr('readonly', true);
    		$('#frmstatudeduction select').attr('disabled', true);
    		$('#statudate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmstatudeduction input').attr('readonly', false);
    		$('#frmstatudeduction select').attr('disabled', false);
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
		        		document.getElementById("errormsg").innerText=" Enter Statutory Deductions	";
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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmstatudeduction" action="savestatuDeduction" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Date</td> 
                    <td width="15%">
                        <div id="statudate" name="statudate" value='<s:property value="statudate"/>'></div>
                    </td>
                    <td class="lbl-right" width="15%">Statutory Deductions</td>
                    <td width="35%">
                        <input type="text" name="satudeduction" id="satudeduction" placeholder="Statutory Deductions" value='<s:property value="satudeduction"/>'>
                    </td>
                    <td class="lbl-right" width="8%">Doc No</td>
                    <td width="15%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right">Account</td>
                    <td colspan="5">
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <input type="text" name="acno" id="acno" readonly="readonly" placeholder="Press F3 To Search" onkeydown="getaccountdetails(event);" value='<s:property value="acno"/>' style="width: 150px;">
                            <input type="text" name="accname" id="accname" readonly="readonly" value='<s:property value="accname"/>' style="flex: 1; max-width: 400px;">
                            
                            <label style="font-weight: bold; color: #444; margin-left: 10px;">Type</label>
                            <select name="type" id="type" style="width: 120px;" value='<s:property value="type"/>'>
                                <option value="0">Amount</option>
                                <option value="1">Percentage</option>
                            </select>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right" style="padding-top: 10px;">Remarks</td>
                    <td colspan="5" style="padding-top: 10px;">
                        <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="grid-container">
            <div id="deductiongrid"></div>
        </div>

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