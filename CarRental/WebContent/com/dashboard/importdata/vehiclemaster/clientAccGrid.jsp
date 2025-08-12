<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%>
<% ClsIMVehicleDAO DAO= new ClsIMVehicleDAO(); %>
<%String gridrow=request.getParameter("rowBoundIndex")==null || request.getParameter("rowBoundIndex").equals("")?"0":request.getParameter("rowBoundIndex"); %>
<script type="text/javascript">
    var data= '<%=DAO.accclient()%>';   
        $(document).ready(function () { 	
          var gridrow='<%=gridrow%>';  
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'cldocno', type: 'number' },
     						{name : 'refname', type: 'String'  }
     						
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
		            }		
            );
            $("#jqxClientGrid").jqxGrid(
            {
            	width: '100%',
                height: 313,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                sortable: true,
                columns: [
					{ text: 'Cldocno',datafield: 'cldocno', width: '0%',hidden:true },
					{ text: 'Client Name', datafield: 'refname', width: '100%' }
	              ]
            });

            $('#jqxClientGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;   
		            	$('#jqxProjectGrid').jqxGrid('setcellvalue', gridrow, "client", $('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "refname")); 
		            	$('#jqxProjectGrid').jqxGrid('setcellvalue', gridrow, "cldocno", $('#jqxClientGrid').jqxGrid('getcellvalue', rowindex1, "cldocno"));
		            	 
		                $('#clientaccinfowindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxClientGrid"></div>
