<%@page import="com.controlcentre.masters.vehiclemaster.vehicle.*" %>
<%ClsVehicleDAO dao=new ClsVehicleDAO();
	String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
    var tcnodata=[];
    var id='<%=id%>';
    if(id=="1"){
    	tcnodata='<%=dao.getTcnoSearchData(id)%>';
    }
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'tcno' , type: 'string' }
                 ],
                 localdata: tcnodata,
                
                
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
            $("#tcnoSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 336,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'TC No',datafield: 'tcno', width: '100%' },
	              ]
            });

            $('#tcnoSearchGrid').on('rowdoubleclick', function (event){ 
				var rowindex1=event.args.rowindex;
		        document.getElementById("tcno").value= $('#tcnoSearchGrid').jqxGrid('getcellvalue', rowindex1, "tcno"); 
		        $('#tcnowindow').jqxWindow('close');
            }); 
           
        });
    </script>
    <div id="tcnoSearchGrid"></div>
