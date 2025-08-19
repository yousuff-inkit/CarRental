<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var yomdata;
 $(document).ready(function () { 	
	 yomdata='<%=DAO.yomGrid()%>';   
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'yom', type: "string" },
	            	 ],
         localdata: yomdata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxYomGrid").jqxGrid(
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
					{ text: 'YOM',  datafield: 'yom'},	  	
			 ],    
     });
     $("#overlay, #PleaseWait").hide();  
 });
</script>
<div id="jqxYomGrid"></div>      