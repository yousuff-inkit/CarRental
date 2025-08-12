<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.driver.ClsIMDriverDAO"%>
<% ClsIMDriverDAO DAO= new ClsIMDriverDAO(); %> 
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
						/* { name: 'account', type: "string" },
						{ name: 'accdoc', type: "string" },
						{ name: 'sal_name', type: "string" }, */
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
					/* { text: 'Salesman',  datafield: 'sal_name'},	
					{ text: 'Account',  datafield: 'account', width: '20%', editable: false},
					{ text: 'accdoc',  datafield: 'accdoc', hidden:true}, */
			 ],    
     });
     $("#overlay, #PleaseWait").hide(); 
     /* $('#jqxNationalityGrid').on('celldoubleclick', function(event) { 
     	var rowBoundIndex = event.args.rowindex;
     	var datafield = event.args.datafield;
	         
	        if((datafield=="account")) { 
	    		getSalemanAcc(rowBoundIndex);
 	    }
	    }); */
 });
</script>
<div id="jqxNationalityGrid"></div>   