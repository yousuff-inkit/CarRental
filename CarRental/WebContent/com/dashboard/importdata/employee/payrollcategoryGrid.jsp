<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.employee.ClsEmployeeDAO"%>
<% ClsEmployeeDAO DAO= new ClsEmployeeDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var payrolldata;
 $(document).ready(function () { 	
	 payrolldata='<%=DAO.payrollGrid()%>';                
     var source =
     {
         datatype: "json",
         datafields: [    
			        	    
							{name : 'paycat', type: 'string'   }
							
			
	            	 ],
         localdata: payrolldata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxPayrollGrid").jqxGrid(  
	{
		width: '100%',
	    height: 300,
	    source: dataAdapter,
	    selectionmode: 'checkbox',  
	    enabletooltips:true,
	    showfilterrow:true,
	    enabletooltips:true,
	    filterable:true,
	    editable:true,
	    columns: [
					{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false, 
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					{ text: 'Payroll Category', datafield: 'paycat' },
						  	
			 ],    
     });
     $("#overlay, #PleaseWait").hide(); 
 });
</script>
<div id="jqxPayrollGrid"></div>   