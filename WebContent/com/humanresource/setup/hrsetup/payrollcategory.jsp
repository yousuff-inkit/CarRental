<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
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

/* Split Section Styling */
.modern-ui .section-title {
    font-size: 13px;
    font-weight: bold;
    color: #0056b3;
    margin-bottom: 10px;
    border-bottom: 1px solid #c5d3e0;
    padding-bottom: 3px;
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

<%@page import="com.humanresource.setup.hrsetup.payrollcategory.ClsPayrollcategoryDAO"%>
<% ClsPayrollcategoryDAO showDAO = new ClsPayrollcategoryDAO();%> 

<script type="text/javascript">
	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Payroll Category(PCT)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Payroll Category";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="PCT";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="PCT";
		if(window.parent && window.parent.formName) window.parent.formName.value="Payroll Category";
	   
        /* FIXED DATE WIDTHS & HEIGHTS (Compact 120px) */
		$("#parrolldate").jqxDateTimeInput({ width: '120px', height: '24px' ,formatString : "dd.MM.yyyy" });
		
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

		var catdata='<%=showDAO.searchcategory()%>';
         
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'category', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  },
                        	{name : 'timesheet', type: 'Int'  },
                 ],
                 localdata: catdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#categorygrid").jqxGrid(
                    {
                    	width: "100%",
                        source: dataAdapter,
                        showfilterrow: true,
                        filterable: true,
                        selectionmode: 'singlerow',
                        
                        columns: [
		        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
		        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
		        					{ text: 'Category',columntype: 'textbox', filtertype: 'input', datafield: 'category', width: '38%' },
		        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
		        					{ text: 'timesheet',filtertype: 'number', datafield: 'timesheet', width: '10%',hidden:true },
        	              ]
                    });

            $('#categorygrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
 
                document.getElementById("docno").value= $('#categorygrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("category").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "category");
                $("#parrolldate").jqxDateTimeInput('val', $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#categorygrid").jqxGrid('getcellvalue', rowindex1, "remarks");
                
                $('#timesheet').attr('disabled', false);
                
                var timesheet=$("#categorygrid").jqxGrid('getcellvalue', rowindex1, "timesheet");
	            if(parseInt(timesheet)==1) {
	            	 document.getElementById("timesheet").checked = true;
	       		     document.getElementById("timesheet").value=1;
	            	} else {
	           	     document.getElementById("timesheet").checked = false;
	       		     document.getElementById("timesheet").value=0;
	            	}
	            
	            if ($("#mode").val() == "view") {
	            	$('#timesheet').attr('disabled', true);
	            }
            });  
        });

	function funSearchLoad(){
		 changeContent('payrollcategorysearch.jsp'); 
	 }
 
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmpayrollcategory input[type="text"]').attr('readonly', true);
    		$('#timesheet').attr('disabled', true);
    		$('#parrolldate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmpayrollcategory input[type="text"]').attr('readonly', false);
    		$('#timesheet').attr('disabled', false);
    		$('#parrolldate').jqxDateTimeInput({ disabled: false});
    		$('#docno').attr('readonly', true);
    		
    		if ($("#mode").val() == "A") {
    			 $('#parrolldate').val(new Date());
    		}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
 
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#parrolldate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    		 if($('#msg').length && $('#msg').val()!=""){
    			   $.messager.alert('Message',$('#msg').val());
    			  }
    
    		var hidtimesheet=$('#hidtimesheet').val();
    		if(parseInt(hidtimesheet)==1) {
           	 	document.getElementById("timesheet").checked = true;
       		    document.getElementById("timesheet").value=1;
           	} else if(document.getElementById("timesheet")) {
          	    document.getElementById("timesheet").checked = false;
       		    document.getElementById("timesheet").value=0;
           	}
           	
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
	}
 
	     function funNotify(){
	        	if(document.getElementById("category").value=="") {
        			document.getElementById("errormsg").innerText=" Enter Category";
        			document.getElementById("category").focus();
        			return 0;
        		}
	    		return 1;
		} 

	     function funFocus(){
	    	 $('#parrolldate').jqxDateTimeInput('focus');
	     }
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <div class="section-title">Payroll Category Details</div>
            
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="5%">Date</td>
                    <td width="15%">
                        <div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'></div>
                    </td>
                    <td class="lbl-right" width="10%">Category</td>
                    <td width="30%">
                        <input type="text" name="category" id="category" placeholder="Category" value='<s:property value="category"/>'>
                    </td>
                    <td width="15%">
                        <div style="display: flex; align-items: center; gap: 8px; margin-left: 10px; font-weight: bold; color: #444;">
                            <input type="checkbox" id="timesheet" name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" style="margin:0; width: 14px; height: 14px;">
                            <label for="timesheet" style="cursor: pointer;">Time Sheet</label>
                        </div>
                    </td>
                    <td class="lbl-right" width="10%">Doc No</td>
                    <td width="15%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
                    </td>
                </tr>

                <tr>
                    <td class="lbl-right" style="padding-top: 10px;">Remarks</td>
                    <td colspan="6" style="padding-top: 10px;">
                        <input type="text" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>'>
                    </td>
                </tr>
            </table>
        </div>

        <div class="erp-form-area">
            <div class="section-title">Category List</div>
            <div class="grid-container">
                <div id="categorygrid" style="width: 100%;"></div>
            </div>
        </div>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

    </div>
</form>

</div>
</body>
</html>