<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.client.ClsIMClientDAO"%>
<% ClsIMClientDAO DAO= new ClsIMClientDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var areadata;
 $(document).ready(function () { 	
	areadata='<%=DAO.areaGrid()%>';           
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'area', type: "string" },
						{ name: 'area_id', type: "string" },
						{ name: 'zone', type: "string" },
						{ name: 'region', type: "string" },
						{ name: 'po_box', type: "string" },
	            	 ],
         localdata: areadata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxAreaGrid").jqxGrid(
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
					{ text: 'Area',  datafield: 'area'},	 
					{ text: 'Zone',  datafield: 'zone', width: '20%'},
					{ text: 'Region',  datafield: 'region', width: '20%'},
					{ text: 'PO Box',  datafield: 'po_box', width: '20%'},
			 ],    
     });
     $("#overlay, #PleaseWait").hide();  
 });
</script>
<div id="jqxAreaGrid"></div>   