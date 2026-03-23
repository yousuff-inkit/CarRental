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
   MASTER UI – SCROLL AREA
------------------------------ */
.hidden-scrollbar {
    overflow-y: auto;
    height: 550px; /* master standard */
    padding: 10px;
}

/* ------------------------------
   MASTER UI – BACKGROUND
------------------------------ */
body {
    background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
    font-family: 'Segoe UI','Roboto','Arial',sans-serif;
    color: #222;
    margin: 0;
    padding: 32px 0; /* master spacing */
    min-height: 100vh;
    box-sizing: border-box;
    font-size: 14px;
}

/* ------------------------------
   MASTER UI – MAIN CARD
------------------------------ */
#mainBG {
    background: #fff;
    border-radius: 16px;
    padding: 20px; /* master padding */
    max-width: 100%;
    margin: 0 auto;
    box-shadow: 0 4px 24px rgba(0,0,0,0.06);
}

/* ------------------------------
   MASTER UI – SECTION BLOCK
------------------------------ */
.table-section {
    margin-bottom: 20px;
    padding: 20px;
    border-radius: 12px;
    background: #f6f8fa;
    box-shadow: 0 1px 8px rgba(160,177,217,0.1);
}

.table-section h3 {
    margin: 0 0 16px;
    padding-left: 10px;
    border-left: 4px solid #007bff;
    color: #253858;
    font-size: 17.4px;
    font-weight: 600;
}

/* ------------------------------
   MASTER UI – TABLE GRID
------------------------------ */
.cr-table {
    width: 100%;
    border-collapse: collapse;
    background: #f9fafb;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 0 0 1px #eef0f6;
    table-layout: fixed;
}

.cr-table th,
.cr-table td {
    padding: 10px;
    border-bottom: 1px solid #e4e7ec;
    text-align: left;
    font-size: 16px;
    vertical-align: middle;
    font-weight: 500;
    
}

.cr-table th {
    background: #eef0f6;
    color: #354B6A;
    font-weight: 600;
}

.cr-table tr:last-child td {
    border-bottom: none;
}

/* ------------------------------
   MASTER UI – INPUTS
------------------------------ */
.cr-table input[type="text"],
.cr-table select {
    width: 100%;
    height: 32px; /* master input height */
    border: 1px solid #d1d5db;
    border-radius: 6px;
    padding: 6px 10px;
    font-size: 14px;
    background: #fff;
    box-sizing: border-box;
    transition: border-color 0.2s;
}

.cr-table input[type="text"]:focus,
.cr-table select:focus {
    border-color: #007bff;
    outline: none;
}

.myButton {
    font-family: Tahoma, Geneva, sans-serif;
    font-weight: 700;
    font-size: 13px;
    width: 130px;
    height: 38px;
    padding: 8px 12px;
    background: linear-gradient(135deg, #0b45a2 0%, #2563eb 100%);
    color: #ffffff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 2px 4px rgba(59, 130, 246, 0.2);
    text-transform: uppercase;
    letter-spacing: 0.3px;
    white-space: nowrap;
    text-align: center;
}

.myButton:hover {
    background: linear-gradient(135deg, #2563eb 0%, #0b45a2 100%);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    transform: translateY(-1px);
}
</style>

<%@page import="com.humanresource.setup.hrsetup.department.ClsDepartmentDAO"%>
<% ClsDepartmentDAO showDAO = new ClsDepartmentDAO(); %>  

<script type="text/javascript">

	$(document).ready(function () {    
	    document.getElementById("formdet").innerText="Department(DEP)";
		document.getElementById("formdetail").value="Department";
		document.getElementById("formdetailcode").value="DEP";
		window.parent.formCode.value="DEP";
		window.parent.formName.value="Department";
		
	    $("#deptdate").jqxDateTimeInput({ width: '125px', height: '15px' ,formatString : "dd.MM.yyyy" });
           
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
 
	function funReadOnly() {
		$('#frmdepartment input').attr('readonly', true);
		$('#deptdate').jqxDateTimeInput({ disabled: true});
	}
	
	function funRemoveReadOnly() {
		$('#frmdepartment input').attr('readonly', false);
		$('#docno').attr('readonly', true);
		$('#deptdate').jqxDateTimeInput({ disabled: false});

		if ($("#mode").val() == "A") {
			 $('#deptdate').val(new Date());
		}
	}
	
	function setValues() {
	
		if($('#datehidden').val()){
			$("#deptdate").jqxDateTimeInput('val', $('#datehidden').val());
		}
		
		if($('#msg').val()!=""){
			  $.messager.alert('Message',$('#msg').val());
		}
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
<div id="mainBG" class="homeContent">

<form id="frmdepartment" action="saveDepartment" method="post" autocomplete="off">
    <jsp:include page="../../../../header.jsp" /><br/>

    <!-- master UI section card -->
    <div class="table-section">
        <h3>Department Details</h3>

        <table class="cr-table" width="100%">
            <tr>
                <td width="10%" align="right">Date</td>
                <td width="15%" align="left">
                    <div id="deptdate" name="deptdate" value='<s:property value="deptdate"/>'></div>
                </td>

                <td width="12%" align="right">Department</td>
                <td width="34%">
                    <input type="text" name="department" id="department"
                           style="width:100%;" placeholder="Department"
                           value='<s:property value="department"/>'>
                </td>

                <td width="10%" align="right">Doc No</td>
                <td width="10%">
                    <input type="text" name="docno" id="docno"
                           value='<s:property value="docno"/>'
                           readonly="readonly" tabindex="-1">
                </td>
                <td width="9%">&nbsp;</td>
            </tr>

            <tr>
                <td align="right">Remarks</td>
                <td colspan="4">
                    <input type="text" name="remarks" id="remarks"
                           style="width:100%;" placeholder="Remarks"
                           value='<s:property value="remarks"/>'>
                </td>
                <td colspan="2">&nbsp;</td>
            </tr>
        </table>

        <!-- hidden fields -->
        <input type="hidden" id="mode" name="mode" value='<s:property value="mode"/>' />
        <input type="hidden" id="msg" name="msg"  value='<s:property value="msg"/>'/> 
        <input type="hidden" name="deleted" id="deleted" value='<s:property value="deleted"/>'/> 
        <input type="hidden" id="datehidden" name="datehidden" value='<s:property value="datehidden"/>'/> 
    </div>
</form>

<!-- grid below in its own master card if you want -->
<div class="table-section">
    <h3>Department List</h3>
    <div id="departmentgrid"></div>
</div>

</div><!-- /#mainBG -->
</body>

</html>