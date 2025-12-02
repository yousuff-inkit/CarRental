<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.operations.vehicletransactions.maintenanceupdate.ClsmaintenanceDAO" %>
 
 
 <%
 
 ClsmaintenanceDAO viewDAO=new ClsmaintenanceDAO(); %>
<style>
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Container for the grid */
    #garragesearch {
        margin: 10px auto;
        padding: 10px;
        background: #ffffff;
        border-radius: 10px;
        border: 1px solid #cfdaf0;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        width: 99%;
        height: 380px;
        color: #000000; /* Black text inside grid */
    }

    /* jqxGrid header styling */
    .jqx-grid-column-header {
        font-size: 14px;
        font-weight: 600;
        color: #000000;
        background-color: #f5f5f5;
        border-bottom: 1px solid #c6ddf5;
    }

    /* jqxGrid rows styling */
    .jqx-grid-cell {
        font-size: 13px;
        color: #000000;
        background-color: #ffffff;
        border-bottom: 1px solid #e0ecf8;
    }

    /* Alternate rows */
    .jqx-grid-alt-row {
        background-color: #f8faff;
    }

    /* Hover effect on rows */
    .jqx-grid-cell:hover {
        background-color: #e0ecf8;
        cursor: pointer;
    }

    /* Filter row styling */
    .jqx-grid-filter-row input {
        border: 1px solid #b7d1ee;
        border-radius: 5px;
        padding: 4px;
        font-size: 13px;
        color: #000000;
    }

</style>

 
 <script type="text/javascript">

   var mtufleet='<%=viewDAO.searchgarrage()%>';
  
        $(document).ready(function () { 	
            
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'name', type: 'String'  }
     						
     						
     				                        	
                          	],
             
                          	localdata: mtufleet,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#garragesearch").jqxGrid(
            {
                width: '99.9%',
                height: 382,
                source: dataAdapter,
            
                
                
                
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
       
                //Add row method
	
                columns: [
					{ text: 'DOC NO', datafield: 'doc_no', width: '10%',hidden:true},
					
					{ text: 'NAME', datafield: 'name', width: '100%'  },
			
					
					]
            });
            
            $('#garragesearch').on('rowdoubleclick', function (event) 
            		{ 
            
            	  var rowBoundIndex = event.args.rowindex;
            
            	document.getElementById("garrageid").value= $('#garragesearch').jqxGrid('getcelltext', rowBoundIndex, "doc_no");
            	document.getElementById("garagemaster").value= $('#garragesearch').jqxGrid('getcelltext', rowBoundIndex, "name");
               
                $('#garragesearchwindow').jqxWindow('close');
              
            	
            		 }); 
      
        });
    </script>
    <div id="garragesearch"></div>