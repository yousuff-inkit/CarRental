<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.employee.ClsEmployeeDAO"%>
<% ClsEmployeeDAO DAO= new ClsEmployeeDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var nationdata;
 $(document).ready(function () { 	
	 nationdata='<%=DAO.nationGrid()%>';               
     var source =
     {
         datatype: "json",
         datafields: [
						
						{ name: 'nationality', type: "string" },
	            	 ],  
         localdata: nationdata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxNationalityGrid").jqxGrid(
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
                      columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					{ text: 'Nationality',  datafield: 'nationality'},
			 ],    
     });
     $("#overlay, #PleaseWait").hide(); 
     
 });
</script>
<div id="jqxNationalityGrid"></div>   