<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.client.ClsIMClientDAO"%>
<% ClsIMClientDAO DAO= new ClsIMClientDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var categorydata;
 $(document).ready(function () { 	
	 categorydata='<%=DAO.categoryGrid()%>';              
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'category', type: "string" },
						{ name: 'cat_name', type: "string" },
						{ name: 'account', type: "string" },
						{ name: 'accdoc', type: "string" },
	            	 ],
         localdata: categorydata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxCategoryGrid").jqxGrid(  
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
					{ text: 'Category',  datafield: 'category', width: '20%'},
					{ text: 'Account Group',  datafield: 'account', width: '20%', editable: false},
					{ text: 'accdoc',  datafield: 'accdoc', hidden:true},
					{ text: 'Category Name',  datafield: 'cat_name'},	  	
			 ],    
     });
     $("#overlay, #PleaseWait").hide(); 
     $('#jqxCategoryGrid').on('celldoubleclick', function(event) { 
      	var rowBoundIndex = event.args.rowindex;
      	var datafield = event.args.datafield;
 	         
 	        if((datafield=="account")) { 
 	        	getCategoryAcc(rowBoundIndex);
  	    }
 	    });
 });
</script>
<div id="jqxCategoryGrid"></div>   