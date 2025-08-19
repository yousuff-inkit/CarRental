<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var mdldata;
 $(document).ready(function () { 	
	 mdldata='<%=DAO.modelGrid()%>';   
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'model', type: "string" },
						{ name: 'brdid', type: "string" },
						{ name: 'brand', type: "string" },
	            	 ],
         localdata: mdldata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxModelGrid").jqxGrid(  
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
					{ text: 'Model',  datafield: 'model'},	
					{ text: 'Brand ID',  datafield: 'brdid', hidden:true},
					{ text: 'Brand',  datafield: 'brand', editable:false},
			 ],    
     });
     $("#overlay, #PleaseWait").hide();  
 });
</script>
<div id="jqxModelGrid"></div>     