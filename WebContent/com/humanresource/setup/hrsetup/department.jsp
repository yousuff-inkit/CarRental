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

<%@page import="com.humanresource.setup.hrsetup.department.ClsDepartmentDAO"%>
<% ClsDepartmentDAO showDAO = new ClsDepartmentDAO(); %>  

<script type="text/javascript">

	$(document).ready(function () {   
	    if(document.getElementById("formdet")) document.getElementById("formdet").innerText="Department(DEP)";
		if(document.getElementById("formdetail")) document.getElementById("formdetail").value="Department";
		if(document.getElementById("formdetailcode")) document.getElementById("formdetailcode").value="DEP";
		if(window.parent && window.parent.formCode) window.parent.formCode.value="DEP";
		if(window.parent && window.parent.formName) window.parent.formName.value="Department";
		
        /* FIXED DATE WIDTHS & HEIGHTS (Compact 120px) */
		$("#deptdate").jqxDateTimeInput({ width: '120px', height: '24px' ,formatString : "dd.MM.yyyy" });
		
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
    		$('#frmdepartment input[type="text"]').attr('readonly', true);
    		$('#deptdate').jqxDateTimeInput({ disabled: true});
	    } catch(e) { console.error("Error in funReadOnly: ", e); }
	}
	
	/* SAFE REMOVE READONLY FUNCTION */
	function funRemoveReadOnly() {
	    try {
    		$('#frmdepartment input[type="text"]').attr('readonly', false);
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

<div id="mainBG" class="homeContent hidden-scrollbar" data-type="background">
<form id="frmdepartment" action="saveDepartment" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" />

    <div class="modern-ui">

        <div class="erp-form-area">
            <div class="section-title">Department Details</div>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td class="lbl-right" width="8%">Date</td>
                    <td width="20%">
                        <div id="deptdate" name="deptdate" value='<s:property value="deptdate"/>'></div>
                    </td>
                    <td class="lbl-right" width="10%">Department</td>
                    <td width="35%">
                        <input type="text" name="department" id="department" placeholder="Department" value='<s:property value="department"/>'>
                    </td>
                    <td class="lbl-right" width="10%">Doc No</td>
                    <td width="17%">
                        <input type="text" name="docno" id="docno" value='<s:property value="docno"/>' readonly="readonly" tabindex="-1">
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

        <div style="display:none;">
            <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
            <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
            <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
            <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
            
            <input type="hidden" id="formdetail" name="formdetail" value='<s:property value="formdetail"/>'/>
            <input type="hidden" id="formdetailcode" name="formdetailcode" value='<s:property value="formdetailcode"/>'/>
        </div>

        <div class="erp-form-area">
            <div class="section-title">Department List</div>
            <div class="grid-container">
                <div id="departmentgrid" style="width: 100%;"></div>
            </div>
        </div>

    </div>
</form>

</div>
</body>
</html>