
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

<%@page import="com.humanresource.setup.hrsetup.allowances.ClsAllowancesDAO"%>
<% ClsAllowancesDAO showDAO = new ClsAllowancesDAO(); %>  

<script type="text/javascript">
	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Allowance(ALC)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Allowance";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="ALC";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="ALC";
		if(window.parent && window.parent.formName) window.parent.formName.value="Allowance";
		
        /* FIXED DATE WIDTHS & HEIGHTS */
	    $("#allowancedate").jqxDateTimeInput({ width: '100%', height: '24px' ,formatString : "dd.MM.yyyy" });
	    
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
			  	 accountSearchContent('accountsDetailsSearch.jsp');
		    }
		});   
		   
            var alcdata='<%=showDAO.searchAllowance()%>';
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
                          	{name : 'code', type: 'String'  },
     						{name : 'allowance', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'acno', type: 'String'  },
                         	{name : 'accname', type: 'String'  },
                          	{name : 'remarks', type: 'String'  },
                         	{name : 'accdocno', type: 'String'  },
                 ],
               		localdata: alcdata,

               	 pager: function (pagenum, pagesize, oldpagenum) {
                     // callback called when a page or page size is changed.
                 }
             };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            	$("#allowancegrid").jqxGrid(
                    {
                    	width: '100%',
                        height: 375,
                        source: dataAdapter,
                        selectionmode: 'singlerow',
             			editable: false,
             			columnsresize: true,
             			showfilterrow: true,
                        filterable: true,
                        
                        columns: [
									{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '7%' },
									{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' },
									{ text: 'Allowance Code',columntype: 'textbox', filtertype: 'input', datafield: 'code', width: '8%' },
									{ text: 'Allowance Name',columntype: 'textbox', filtertype: 'input', datafield: 'allowance', width: '15%' },
									{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
									{ text: 'Account Name',columntype: 'textbox', filtertype: 'input', datafield: 'accname', width: '25%' },
									{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '28%' },
									{ text: 'Account Doc No',columntype: 'textbox', filtertype: 'input', datafield: 'accdocno', width: '10%' ,hidden: true},
            					]
                    });
            	
         $('#allowancegrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#allowancegrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("allowancecode").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("allowance").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "allowance");
                $("#allowancedate").jqxDateTimeInput('val', $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("acno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "acno");
                document.getElementById("accname").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accname");
                document.getElementById("accdocno").value = $("#allowancegrid").jqxGrid('getcellvalue', rowindex1, "accdocno");
                
            });   
        });

	function funSearchLoad(){
		 changeContent('allowancessearch.jsp'); 
	 }
 
     function accountSearchContent(url) {
          $.get(url).done(function (data) {
          	$('#accountSearchwindow').jqxWindow('setContent', data);
  	      }); 
      	}
  	  
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmallowance input').attr('readonly', true);
    		$('#allowancedate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly:", e); }
	}
	
    /* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmallowance input').attr('readonly', false);
    		$('#docno').attr('readonly', true);
    		$('#acno').attr('readonly', true);
    		$('#accname').attr('readonly', true);
    		$('#allowancedate').jqxDateTimeInput({ disabled: false});
    		
    		if ($("#mode").val() == "A") {
    			 $('#allowancedate').val(new Date());
    		}
	    } catch(e) { console.error("Error in funRemoveReadOnly:", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#allowancedate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    		
    		if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    		}
    		
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                var detailVal = $('#formdetail').val() || "";
                var codeVal = $('#formdetailcode').val() || "";
                document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues:", e); }
	}
	
	function getaccountdetails(event){
	 	 var x= event.keyCode;
	   	
	     if($('#mode').val()!="view") {
	 	    if(x==114){
	 	  	   $('#accountSearchwindow').jqxWindow('open');
	 	 	   accountSearchContent('accountsDetailsSearch.jsp');   
	 	    }
	 	 }
	}
 
	     function funNotify(){
	        	if(document.getElementById("allowance").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Enter Allowance";
        		document.getElementById("allowance").focus();
        		return 0;
        		}
	        	
	        	if(document.getElementById("acno").value=="")
        		{
        		document.getElementById("errormsg").innerText=" Search Account";
        		document.getElementById("acno").focus();
        		return 0;
        		}
	    		return 1;
		} 
	     
	     function funFocus(){
	    		$('#allowancedate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmallowance" action="saveAllowance" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Date</td>
                    <td width="15%">
                        <div id="allowancedate" name="allowancedate" value='<s:property value="allowancedate"/>'></div>
                    </td>
                    <td class="lbl-right" width="10%">Allowance Code</td>
                    <td width="17%">
                        <input type="text" name="allowancecode" id="allowancecode" placeholder="Allowance Code" value='<s:property value="allowancecode"/>'>
                    </td>
                    <td class="lbl-right" width="10%">Name</td>
                    <td width="25%">
                        <input type="text" name="allowance" id="allowance" placeholder="Allowance Name" value='<s:property value="allowance"/>'>
                    </td>
                    <td class="lbl-right" width="5%">Doc No</td>
                    <td width="10%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right">Account</td>
                    <td colspan="7">
                        <div style="display: flex; gap: 8px; align-items: center;">
                            <input type="text" name="acno" id="acno" placeholder="Press F3 To Search" readonly="readonly" onkeydown="getaccountdetails(event);" value='<s:property value="acno"/>' style="width: 150px;">
                            <input type="text" name="accname" id="accname" readonly="readonly" value='<s:property value="accname"/>' style="flex: 1; max-width: 400px;">
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right" style="padding-top: 10px;">Remarks</td>
                    <td colspan="7" style="padding-top: 10px;">
                        <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="grid-container">
            <div id="allowancegrid"></div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" name="accdocno" id="accdocno" value='<s:property value="accdocno"/>' >
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

<div id="accountSearchwindow"><div></div></div>

</div>
</body>
</html>
```