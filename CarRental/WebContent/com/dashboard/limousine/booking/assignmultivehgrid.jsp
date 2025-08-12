<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();                
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
	String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();   
	String job=request.getParameter("job")==null?"0":request.getParameter("job").toString();   
 %>           
 <script type="text/javascript">
 var jobdata;    
 jobdata ='<%=dao.loadmultivehassignment(docno, job)%>';                  
         $(document).ready(function () {         
      
         var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'addition', type: 'string'},
     						{name : 'drvid', type: 'number'},
     						{name : 'driver', type: 'String'},
     						{name : 'bookingno', type: 'String'},
     						{name : 'jobname', type: 'String'},
     						{name : 'fleetno', type: 'string'},
     						{name : 'vehname', type: 'string'},
     						{name : 'regno', type: 'string'},
     						{name : 'status', type: 'string'},
                          	],
                          	localdata: jobdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#multivehassigngrid").jqxGrid({ 
            	width: '99%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					  
                columns: [	{ text: 'SL#',sortable: false, filterable: false, editable: false,
						    	groupable: false, draggable: false, resizable: false,
						    	datafield: 'sl', columntype: 'number', width: '3%',
						    	cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						    	}  
							},
							{ text: 'Assignment No.', datafield: 'addition', width: '15%', hidden:true},
							{ text: 'Driver', datafield: 'driver', width: '32%' },
							{ text: 'vehicle', datafield: 'vehname', width: '35%' },
							{ text: 'Fleet No', datafield: 'fleetno', width: '15%' },
							{ text: 'Status', datafield: 'status', width: '15%' },
					]
            });
         
           
        });
                       
</script>
<div id="multivehassigngrid"></div>