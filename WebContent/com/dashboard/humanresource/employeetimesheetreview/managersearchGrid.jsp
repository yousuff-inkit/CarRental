<%@page import="com.dashboard.humanresource.employeetimesheetreview.ClsEmployeetimesheetreviewDAO"%>
<% ClsEmployeetimesheetreviewDAO DAO= new ClsEmployeetimesheetreviewDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
<script type="text/javascript">
        
       var data1= '<%=DAO.managerDetailsSearch()%>';   
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'name', type: 'string'   },
     						{name : 'empid', type: 'int'   }
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#managerDetailsSearch").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                
                columns: [
							{ text: 'Name', datafield: 'name', width: '100%' },
							{ text: 'ID',  datafield: 'empid', hidden:true, width: '5%' },
						]
            });
            
              $('#managerDetailsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("cmbmanager").value = $('#managerDetailsSearch').jqxGrid('getcellvalue', rowindex1, "name");
                document.getElementById("hidcmbmanager").value = $('#managerDetailsSearch').jqxGrid('getcellvalue', rowindex1, "empid");
            	 	
            	$('#managerDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="managerDetailsSearch"></div>
 