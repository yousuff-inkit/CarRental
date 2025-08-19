<%@page import="com.dashboard.humanresource.employeeutilization.ClsEmployeeUtilizationDAO"%>
<%ClsEmployeeUtilizationDAO DAO= new ClsEmployeeUtilizationDAO(); %>
<% String contextPath=request.getContextPath();%>
<%   String year = request.getParameter("year")==null?"0":request.getParameter("year").trim();
     String month = request.getParameter("month")==null?"0":request.getParameter("month").trim();
      String employee = request.getParameter("employee")==null?"0":request.getParameter("employee").trim();
     String check = request.getParameter("check")==null?"1":request.getParameter("check");%> 
<style type="text/css">
        .editClass
        {
            
        }
        .saveClass
        {
            background-color: #F1F1F1;
            color: #000;
            font-weight: bold;
        }
        .deleteClass
        {
           color: #ECECEC; 
        }
        .addClass
        {
            background-color: #FFEBEB;
            font-weight: bold;
        }
        .leaveClass
        {
            background-color: #F1C0C0;
            font-weight: bold;
        }
        .holidayClass
        {
            background-color: #E4D9E6;
            font-weight: bold;
        }
        .whiteClass
        {
           
        }
</style>
<script type="text/javascript">
       var temp1='<%=check%>';
        
        if(temp1=='1'){

        	data='<%=DAO.GridLoading(year,month,employee,check)%>';
        	<%--tsexceldata='<%=DAO.timeSheetReviewExcelData(year,month,date,category,employee,projecttype,projectid,orderbydate,orderbyemployee,orderbycosttype,orderbycostid,rptType,check)%>';
       --%>
        }
        
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{name : 'mnthlytargethrs', type: 'number'    },
					{name : 'tot', type: 'number'  },
				    {name : 'nonbillhrs', type: 'number'  }, 
				    {name : 'per', type: 'number'  }, 
	            ],
                localdata: data,
        	
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        
        	
        	
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#emputilGridID").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                columnsresize: true,
                showaggregates: true,
                showfilterrow: true, 
                selectionmode: 'singlecell',
                enabletooltips:true,
               				
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							   cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
						
							
							{ text: 'Emp. ID', datafield: 'empid',  width: '7%', editable: false,hidden:true },
							{ text: 'Employee', datafield: 'empname',  editable: false },
							{ text: 'Monthly Target Hrs', datafield: 'mnthlytargethrs',  width: '15%', editable: false },
							{ text: 'Billable Hrs', datafield: 'tot',  width: '15%'},
							{ text: 'Non Billable Hrs', datafield: 'nonbillhrs', width: '15%' },
							{ text: 'Utilization Percentage', datafield: 'per', width: '15%',editable: false },
					 		]
            });
            
            if(temp1=='NA'){
                $("#emputilGridID").jqxGrid("addrow", null, {});
            }
        
            $("#overlay, #PleaseWait").hide();
            
           
          
   		
  });
                       
</script>

<div id="emputilGridID"></div>
