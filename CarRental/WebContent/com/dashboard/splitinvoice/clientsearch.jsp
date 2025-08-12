<%@page import="com.dashboard.operations.splitinvoice.ClsSplitInvoiceDAO" %>
<% ClsSplitInvoiceDAO DAO=new ClsSplitInvoiceDAO();%>

<%String id=request.getParameter("id"); %>
<script type="text/javascript">
      
      var dataclient= '<%=DAO.getClient(id)%>';
  
        $(document).ready(function () { 	
            

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'cldocno' , type: 'int' },
     						{name : 'refname', type: 'String'  },
     					
                 ],
                localdata: dataclient,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#clientSearch").jqxGrid(
            {
                width: '100%',
                height: 357,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                filterable: true,
                showfilterrow: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'cldocno', width: '20%',hidden: true},
							{ text: 'Client Name', datafield: 'refname', width: '100%' },
						
	              ]
            });
           -
            $('#clientSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
                document.getElementById("client").value= $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                document.getElementById("txtclientname").value= $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
                 $('#clientwindow').jqxWindow('close');
                
            });  
        });
    </script>
    <div id="clientSearch"></div>
