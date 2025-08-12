<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.employeetimesheetreview.ClsEmployeetimesheetreviewDAO"%>
<% ClsEmployeetimesheetreviewDAO DAO= new ClsEmployeetimesheetreviewDAO(); %>


 <%String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String year = request.getParameter("year")==null?"0":request.getParameter("year").trim();
 String month = request.getParameter("month")==null?"0":request.getParameter("month").trim();
 String hidcmbemp = request.getParameter("hidcmbemp")==null?"0":request.getParameter("hidcmbemp").trim();
 String hidcmbmanager = request.getParameter("hidcmbmanager")==null?"0":request.getParameter("hidcmbmanager").trim();
 String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();
  %> 


<style type="text/css">
        .redClass
        {
            background-color: #fae0e4;
        }
</style>
<script type="text/javascript">
        var data;
        var month='<%=month%>';
		var year='<%=year%>';
	
        $(document).ready(function () {   
        	 data = '<%=DAO.gridloading(check,year,month,hidcmbemp,hidcmbmanager,status)%>'; 
        	  
         	
           // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'docno', type: "number" },
                	{ name: 'empid', type: "string" },
                    { name: 'name', type: "string" },
                    { name: 'designation', type: "string" },
                    { name: 'dtjoin', type: "date" },
                    { name: 'proname', type: "string" },
                    { name: 'promanager', type: "string" },
                    { name: 'tsfilled', type: "string" },
                    { name: 'tsapproved', type: "string" },
                    { name: 'totbillhrs', type: "string" },
                    { name: 'leaveapplied', type: "string" },
                    { name: 'tdate', type: "string" },
                   ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
           
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            var cellclassname = function (row, column, value, data) {
            	if (data.tdate!== '') {
                    return "redClass";
            	};
            }; 
            
            
            
            
            $("#employeetymsheetrevGridId").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                
                columns: [
                	/* { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   }, */
                	        { text: 'Doc No', datafield: 'docno', width: '5%',hidden:true,cellclassname: cellclassname  },
							{ text: 'Employee ID', datafield: 'empid', width: '6%' ,cellclassname: cellclassname },
							{ text: 'Employee Name', datafield: 'name', width: '21%' ,cellclassname: cellclassname },
							{ text: 'Designation', datafield: 'designation', width: '20%' ,cellclassname: cellclassname },
							{ text: 'DateofJoin', datafield: 'dtjoin', width: '8%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname  },
							{ text: 'Project Name', datafield: 'proname', width: '15%',hidden:true ,cellclassname: cellclassname },
							{ text: 'Project Manager', datafield: 'promanager', width: '17%',cellclassname: cellclassname  },
							{ text: 'Ts Filled', datafield: 'tsfilled', width: '6%' ,cellclassname: cellclassname },
							{ text: 'Ts Approved', datafield: 'tsapproved', width: '6%',cellclassname: cellclassname  },
							{text: 'Terminated Date', datafield: 'tdate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname  },
							{ text: 'Total Billed Hrs', datafield: 'totbillhrs', width: '5%',cellclassname: cellclassname  },
							{ text: 'Leaves Applied', datafield: 'leaveapplied', width: '5%',cellclassname: cellclassname  },
								]
            });
            $("#overlay, #PleaseWait").hide();

	    	$("#employeetymsheetrevGridId").on('rowdoubleclick', function (event) {
	           	 var datafield = event.args.datafield;
		   			   var rowIndex = event.args.rowindex;
		   			   var columnIndex = event.args.columnindex;
		   			   var emp=$("#employeetymsheetrevGridId").jqxGrid('getcellvalue', rowIndex, "docno");
		   			   var dbname=$("#employeetymsheetrevGridId").jqxGrid('getcellvalue', rowIndex, "dbname");

		   			   //	$("#attendanceDiv").load("attendanceGrid.jsp?totdays="+tempDays+"&year="+year+"&month="+month+"&check="+check+"&branch="+branch+"&emp="+emp+"&dbname="+dbname);

		   			$("#attendanceDiv").load("attendanceGrid.jsp?emp="+emp+"&dbname="+dbname+"&year="+year+"&month="+month);
	
		   			   
		   			   
	    	 });

        });
   </script>
    
    
    <div id="employeetymsheetrevGridId"></div>
