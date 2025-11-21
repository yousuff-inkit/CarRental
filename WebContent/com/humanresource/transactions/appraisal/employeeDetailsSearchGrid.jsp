<%@page import="com.humanresource.transactions.appraisal.ClsAppraisalDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsAppraisalDAO DAO=new ClsAppraisalDAO();
   String employeename = request.getParameter("employeename")==null?"0":request.getParameter("employeename");
   String empid = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String contactno = request.getParameter("contactno")==null?"0":request.getParameter("contactno");
   String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
   String branch = request.getParameter("branchid")==null?"0":request.getParameter("branchid");%>
   
   <style>

/* Wrapper around the grid */
#employeeDetailsSearch {
    border-radius: 12px !important;
    overflow: hidden !important;
    box-shadow: 0 6px 20px rgba(80,120,255,0.18);
    background: #ffffff;
    border: 1px solid #d9e4ff !important;
    font-family: 'Poppins', sans-serif;
}

/* Grid header */
.jqx-grid-column-header {
    background: linear-gradient(90deg,#e8f0ff,#d8e4ff) !important;
    border-bottom: 1px solid #c9d7f5 !important;
    color: #233e90 !important;
    font-weight: 600 !important;
    font-size: 0.9rem !important;
    height: 36px !important;
    padding-left: 8px !important;
}

/* Header text alignment */
.jqx-grid-column-header > div {
    margin-top: 8px !important;
}

/* Regular grid rows */
.jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #eef2ff !important;
    font-size: 0.88rem !important;
    color: #2a2f4c !important;
    padding-left: 10px !important;
}

/* Row Hover */
.jqx-grid-cell:hover {
    background: #f0f6ff !important;
    cursor: pointer !important;
}

/* Alternate Row Color */
.jqx-grid-cell-alt {
    background-color: #f9fbff !important;
}

/* Selected Row */
.jqx-fill-state-pressed,
.jqx-fill-state-hover,
.jqx-grid-cell-selected {
    background: #d9e8ff !important;
    border-color: #b2c7ff !important;
    color: #1a3fa8 !important;
}

/* Grid bottom border / pager area */
.jqx-grid-pager {
    background: #f4f7ff !important;
    border-top: 1px solid #dbe4ff !important;
}

/* Removes ugly black focus outline */
.jqx-grid-content,
.jqx-widget-content {
    outline: none !important;
}

</style>
   
<script type="text/javascript"> 
 
        var data1= '<%=DAO.employeeDetailsSearch(empid, employeename, contactno, employeebranchchk, branch)%>';     
        
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dtjoin', type: 'date'   },
     						{name : 'name', type: 'string'   },
     						{name : 'desc_id', type: 'string'  }, 
     						{name : 'desig', type: 'string'  },
     						{name : 'pay_catid', type: 'string'  },
     						{name : 'category', type: 'string'  },
     						{name : 'dept_id', type: 'string'  },
     						{name : 'dept', type: 'string'  },
     						{name : 'doc_no', type: 'int'   },
     						{name : 'codeno', type: 'string'   },
     						{name : 'pmmob', type: 'string'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow', 
                
                columns: [
							{ text: 'Employee Id', datafield: 'codeno', width: '20%' },
							{ text: 'Employee Name', datafield: 'name', width: '60%' },
							{ text: 'Contact', datafield: 'pmmob', width: '20%' },
							{ text: 'desc_id', datafield: 'desc_id', width: '20%', hidden:true },
							{ text: 'desig', datafield: 'desig', width: '20%', hidden:true },
							{ text: 'pay_catid', datafield: 'pay_catid', width: '20%', hidden:true },
							{ text: 'category', datafield: 'category', width: '20%', hidden:true },
							{ text: 'dept_id', datafield: 'dept_id', width: '20%' , hidden:true},
							{ text: 'dept', datafield: 'dept', width: '20%', hidden:true },
							{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						]
            });  
            
             $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("empdocno").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("empid").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "codeno");
            	document.getElementById("empname").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
            	$("#joindate").jqxDateTimeInput('val', $("#employeeDetailsSearch").jqxGrid('getcellvalue', rowindex1, "dtjoin"));
                document.getElementById("category").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "category");
                document.getElementById("designation").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "desig");
            	document.getElementById("deprtment").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "dept");
                document.getElementById("hidcategory").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "pay_catid");
                document.getElementById("hiddesignation").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "desc_id");   
            	document.getElementById("hiddeprtment").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "dept_id");    
            	
            	$("#comdiv").load("compensationGrid.jsp?empdocno="+$('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no")+"&check="+1);
            	 
            	$('#empsearchwndow').jqxWindow('close'); 
            });  
        });

</script>
<div id="employeeDetailsSearch"></div>
 