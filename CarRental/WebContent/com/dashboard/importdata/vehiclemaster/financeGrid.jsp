<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var findata;
 $(document).ready(function () { 	
	 findata='<%=DAO.financeGrid()%>';          
     var source =      
     {
         datatype: "json",
         datafields: [
						{ name: 'financier', type: "string" },
						{ name: 'code', type: "string" },
						{ name: 'accountname', type: "string" },
						{ name: 'accdoc', type: "string" },
	            	 ],
         localdata: findata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxFinanceGrid").jqxGrid(
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
					{ text: 'Account Name',  datafield: 'accountname', width:'25%', editable: false},
					{ text: 'Code',  datafield: 'code', width:'10%'},
					{ text: 'Finance',  datafield: 'financier'},	
					{ text: 'accdoc',  datafield: 'accdoc', width:'0%', hidden:true}, 
			 ],    
     });
     $("#overlay, #PleaseWait").hide();  
     $('#jqxFinanceGrid').on('celldoubleclick', function(event) {
     	var rowBoundIndex = event.args.rowindex;
     	var datafield = event.args.datafield;
     	
     	if((datafield == "accountname")) {
		    	getAccountGL(rowBoundIndex);      
 	    } 
     });
 });
 
 function getAccountGL(rowindex){
	    $('#accountWindow').jqxWindow('open');
	    accountSearchContent('accountsSearchGL.jsp?rowindex='+rowindex);     
	}
</script>
<div id="jqxFinanceGrid"></div>       