<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var prodata;
 $(document).ready(function () { 	
	 prodata='<%=DAO.projectGrid()%>';        
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'project', type: "string" },
						{ name: 'client', type: "string" },
						{ name: 'cldocno', type: "string" }
	            	 ],
         localdata: prodata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxProjectGrid").jqxGrid(
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
					{ text: 'Project',  datafield: 'project'},
					{ text: 'Client',  datafield: 'client', width: '30%', editable: false},
					{ text: 'cldocno',  datafield: 'cldocno', width: '0%', hidden:true},
			 ],    
     });
     $("#overlay, #PleaseWait").hide(); 
     $('#jqxProjectGrid').on('celldoubleclick', function(event) { 
      	var rowBoundIndex = event.args.rowindex;
      	var datafield = event.args.datafield;
 	         
 	        if((datafield=="client")) { 
 	    		getClientAcc(rowBoundIndex);
  	    }
 	    });
 });
</script>
<div id="jqxProjectGrid"></div>       