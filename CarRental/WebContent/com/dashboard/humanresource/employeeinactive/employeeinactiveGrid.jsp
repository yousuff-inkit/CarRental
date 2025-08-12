<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.employeeinactive.ClsEmployeeInactiveDAO"%>
<% ClsEmployeeInactiveDAO DAO= new ClsEmployeeInactiveDAO(); %>


 <%String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
        var data;
        $(document).ready(function () { 
        	
            data = '<%=DAO.employeeListGridLoading(check)%>';  
 		   	
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'docno', type: "number" },
                	{ name: 'empid', type: "string" },
                    { name: 'name', type: "string" },
                    { name: 'designation', type: "string" },
                    { name: 'department', type: "string" },
                    { name: 'category', type: "string" },
                    { name: 'dtjoin', type: "date" },
                    { name: 'address', type: "string" },
                    { name: 'mobile', type: "string" },
                    { name: 'email', type: "string" },
                    { name: 'dob', type: "date" },
                    { name: 'gender', type: "string" },
                    { name: 'status', type: "string" },
                    { name: 'terdt', type: "date" },
                    
   ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#employeeinactiveGridId").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                
                columns: [
                	        { text: 'Doc No', datafield: 'docno', width: '5%' },
							{ text: 'Employee ID', datafield: 'empid', width: '7%' },
							{ text: 'Employee Name', datafield: 'name', width: '15%' },
							{ text: 'Designation', datafield: 'designation', width: '10%' },
							{ text: 'Department', datafield: 'department', width: '10%' },
							{ text: 'Category', datafield: 'category', width: '6%' },
							{ text: 'DateofJoin', datafield: 'dtjoin', width: '7%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Address', datafield: 'address', width: '15%' },
							{ text: 'Status', datafield: 'status', width: '6%' },
							{ text: 'Terminated Date', datafield: 'terdt', width: '8%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Mobile No', datafield: 'mobile', width: '8%' },
							{ text: 'Email ID', datafield: 'email', width: '15%' },
							{ text: 'DOB', datafield: 'dob', width: '7%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Gender', datafield: 'gender', width: '5%' },
								]
            });
        	$("#overlay, #PleaseWait").hide();
        	
        	$('#employeeinactiveGridId').on('rowdoubleclick', function (event){
            	var rowindex=event.args.rowindex;
            	  document.getElementById("hiddocno").value=$('#employeeinactiveGridId').jqxGrid('getcellvalue', rowindex, "docno"); 
             	    });
        });
   </script>
    
    
    <div id="employeeinactiveGridId"></div>
 