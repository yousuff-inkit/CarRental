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
   1. 100% SCOPED CSS - GUARANTEED NOT TO BREAK HEADER
========================================================= */

/* Validation Errors */
form label.error {
    color: red;
    font-weight: bold;
    font-size: 11px;
}

/* Wrapper to isolate our form layout from the header */
#payrollcat-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#payrollcat-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#payrollcat-form-container .master-legend {
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
#payrollcat-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#payrollcat-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#payrollcat-form-container .master-input {
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

#payrollcat-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#payrollcat-form-container .master-input[readonly],
#payrollcat-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}

/* Grid Container */
.grid-container {
    border: 1px solid #c5d3e0;
    border-radius: 4px;
    overflow: hidden;
    background: #fff;
    margin-top: 10px;
}

/* Checkbox specific wrapper */
.checkbox-wrapper {
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: 600;
    color: #444;
    font-size: 13px;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

.checkbox-wrapper input[type="checkbox"] {
    margin: 0;
    width: 14px;
    height: 14px;
    cursor: pointer;
}

.checkbox-wrapper label {
    cursor: pointer;
}
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
	   
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
		$("#parrolldate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#parrolldate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#parrolldate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
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
    		$('#frmpayrollcategory .master-input').attr('readonly', true);
    		$('#timesheet').attr('disabled', true);
    		$('#parrolldate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmpayrollcategory .master-input').attr('readonly', false);
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

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmpayrollcategory" action="savePayrollcategory" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div id="payrollcat-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px;">
            <legend class="master-legend">Payroll Category Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 60px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="parrolldate" name="parrolldate" value='<s:property value="parrolldate"/>'></div>
                </div>
                
                <label class="master-label" style="width: 100px; margin-left: 20px;">Category</label>
                <input type="text" class="master-input" name="category" id="category" placeholder="Category" value='<s:property value="category"/>' style="flex: 1; max-width: 350px;">
                
                <div class="checkbox-wrapper" style="margin-left: 20px;">
                    <input type="checkbox" id="timesheet" name="timesheet" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                    <label for="timesheet">Time Sheet</label>
                </div>
                
                <label class="master-label" style="width: 80px; margin-left: auto;">Doc No</label>
                <input type="text" class="master-input" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1" style="width: 120px; flex: none;">
            </div>

            <div class="master-row" style="margin-bottom: 0;">
                <label class="master-label" style="width: 60px;">Remarks</label>
                <input type="text" class="master-input" name="remarks" id="remarks" placeholder="Remarks" value='<s:property value="remarks"/>' style="flex: 1;">
            </div>
        </fieldset>

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg" value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            <input type="hidden" id="hidtimesheet" name="hidtimesheet" value='<s:property value="hidtimesheet"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Category List</legend>
            <div class="grid-container">
                <div id="categorygrid" style="width: 100%;"></div>
            </div>
        </fieldset>

    </div>
</form>

</div>
</body>
</html>