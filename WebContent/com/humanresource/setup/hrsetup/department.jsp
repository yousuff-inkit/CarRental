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
#department-form-container {
    padding-top: 15px;
    width: 100%;
}

/* Scoped Fieldsets (Replaces the .middle-panel logic cleanly) */
#department-form-container .master-fieldset {
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 20px 15px 15px 15px;
    margin-bottom: 25px;
    background-color: transparent; 
}

/* The Blue Left-Border Title */
#department-form-container .master-legend {
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
#department-form-container .master-row {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
    gap: 15px;
}

/* Right aligned labels */
#department-form-container .master-label {
    font-size: 13px;
    font-weight: 600;
    color: #1e293b;
    text-align: right;
    min-width: 80px;
    white-space: nowrap;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
}

/* Strict custom class for inputs so it NEVER affects the header */
#department-form-container .master-input {
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

#department-form-container .master-input:focus {
    border-color: #3b82f6;
    outline: none;
    box-shadow: 0 0 0 1px #3b82f6;
}

#department-form-container .master-input[readonly],
#department-form-container .master-input:disabled {
    background-color: #f8f9fa;
    color: #6b7280;
}
</style>

<%@page import="com.humanresource.setup.hrsetup.department.ClsDepartmentDAO"%>
<% ClsDepartmentDAO showDAO = new ClsDepartmentDAO(); %>  

<script type="text/javascript">

	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Department(DEP)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Department";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="DEP";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="DEP";
		if(window.parent && window.parent.formName) window.parent.formName.value="Department";
		
        /* FIXED DATE WIDTHS & HEIGHTS (26px) */
		$("#deptdate").jqxDateTimeInput({ width: '140px', height: '26px' ,formatString : "dd.MM.yyyy", theme: 'energyblue' });
		
        /* Force internal alignment AFTER render */
        setTimeout(function () {
            $("#deptdate").find("input").css({
                "margin-top": "0px", 
                "line-height": "26px", 
                "font-size": "13px", 
                "font-family": "Arial, sans-serif",
                "padding": "0 8px", 
                "box-sizing":"border-box"
            });
            $("#deptdate").find(".jqx-action-button").css({"top": "0px", "height": "26px"});
        }, 0);
           
	    var deptdata='<%=showDAO.searchDepartment()%>';
    
	    var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'department', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'remarks', type: 'String'  }
                 ],
               	 localdata: deptdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#departmentgrid").jqxGrid(
                  {
                  	width: "100%",
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                        
                    columns: [
	        					{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date',columntype: 'textbox', filtertype: 'input', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'Department',columntype: 'textbox', filtertype: 'input', datafield: 'department', width: '38%' },
	        					{ text: 'Remarks',columntype: 'textbox', filtertype: 'input', datafield: 'remarks', width: '40%' },
        	              ]
                    });
            
             $('#departmentgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                
                document.getElementById("docno").value= $('#departmentgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                document.getElementById("department").value = $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "department");
                $("#deptdate").jqxDateTimeInput('val', $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("remarks").value = $("#departmentgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            });   
        });

	function funSearchLoad(){
		 changeContent('departmentsearch.jsp'); 
	 }
 
    /* SAFE READONLY FUNCTION */
	function funReadOnly() {
	    try {
    		$('#frmdepartment .master-input').attr('readonly', true);
    		$('#deptdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmdepartment .master-input').attr('readonly', false);
    		$('#docno').attr('readonly', true);
    		$('#deptdate').jqxDateTimeInput({ disabled: false});
    
    		if ($("#mode").val() == "A") {
    			 $('#deptdate').val(new Date());
    		}
	    } catch(e) { console.error("Error in funRemoveReadOnly: ", e); }
	}
	
    /* SAFE SET VALUES FUNCTION */
	function setValues() {
	    try {
    		if($('#datehidden').length && $('#datehidden').val()){
    			$("#deptdate").jqxDateTimeInput('val', $('#datehidden').val());
    		}
    		
    		if($('#msg').length && $('#msg').val()!=""){
    			  $.messager.alert('Message',$('#msg').val());
    		}
    		
            if (document.getElementById("formdet") && $('#formdetail').length && $('#formdetailcode').length) {
                 var detailVal = $('#formdetail').val() || "";
                 var codeVal = $('#formdetailcode').val() || "";
                 document.getElementById("formdet").innerText = detailVal + " (" + codeVal.trim() + ")";
            }
	    } catch(e) { console.error("Error in setValues: ", e); }
	}
 
	function funNotify(){
        	if(document.getElementById("department").value=="") {
        		
        		document.getElementById("errormsg").innerText=" Enter Department";
        		document.getElementById("department").focus();
        		return 0;
        	}
    		return 1;
	}
	     
	function funFocus(){
	   	 $('#deptdate').jqxDateTimeInput('focus');
	}
	  
</script>   
 
</head>
<body onload="setValues();">

<div id="mainBG" class="homeContent" data-type="background">
<form id="frmdepartment" action="saveDepartment" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div id="department-form-container">

        <fieldset class="master-fieldset" style="max-width: 1000px;">
            <legend class="master-legend">Department Details</legend>
            
            <div class="master-row">
                <label class="master-label" style="width: 60px;">Date</label>
                <div style="width: 140px; flex: none;">
                    <div id="deptdate" name="deptdate" value='<s:property value="deptdate"/>'></div>
                </div>
                
                <label class="master-label" style="width: 100px; margin-left: 20px;">Department</label>
                <input type="text" class="master-input" name="department" id="department" placeholder="Department" value='<s:property value="department"/>' style="flex: 1; max-width: 350px;">
                
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
            <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <fieldset class="master-fieldset" style="padding-bottom: 0; overflow: hidden;">
            <legend class="master-legend">Department List</legend>
            <div style="width: 100%; margin-top: 10px;">
                <div id="departmentgrid" style="width: 100%;"></div>
            </div>
        </fieldset>

    </div>
</form>

</div>
</body>
</html>