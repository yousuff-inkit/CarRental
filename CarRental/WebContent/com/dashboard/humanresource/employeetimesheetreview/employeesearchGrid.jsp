<%@page import="com.dashboard.humanresource.employeetimesheetreview.ClsEmployeetimesheetreviewDAO"%>
<% ClsEmployeetimesheetreviewDAO DAO= new ClsEmployeetimesheetreviewDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<script type="text/javascript">
        
       var data1= '<%=DAO.employeeDetailsSearch()%>';   
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'codeno', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'docno', type: 'int'   }
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
                filterable:true,
                showfilterrow:true,
                
                
                columns: [
							{ text: 'Employee Id', datafield: 'codeno', width: '20%' },
							{ text: 'Employee Name', datafield: 'name', width: '80%' },
							{ text: 'Doc No',  datafield: 'docno', hidden:true, width: '5%' },
						]
            });
            
              $('#employeeDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("cmbemp").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("hidcmbemp").value = $('#employeeDetailsSearch').jqxGrid('getcellvalue', rowindex1, "docno");
            	 	
            	$('#employeeDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="employeeDetailsSearch"></div>
 