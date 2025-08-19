<%@page import="com.dashboard.importdata.client.ClsIMClientDAO"%>
<% ClsIMClientDAO DAO= new ClsIMClientDAO(); %>
<%String gridrow=request.getParameter("rowBoundIndex")==null || request.getParameter("rowBoundIndex").equals("")?"0":request.getParameter("rowBoundIndex"); %>
<script type="text/javascript">
    var data= '<%=DAO.accemployee()%>';
        $(document).ready(function () { 	
          var gridrow='<%=gridrow%>';  
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'description', type: 'String'  },
     						{name : 'acno',type:'string'}
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
            $("#jqxAccountsGrid").jqxGrid(
            {
                width: '100%',
                height: 313,
                source: dataAdapter,
                columnsresize: true,
               // pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                showfilterrow: true,
                filterable: true,
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Account No',datafield: 'doc_no', width: '0%',hidden:true },
					{ text: 'Account No',columntype: 'textbox', filtertype: 'input', datafield: 'acno', width: '10%' },
					{ text: 'Account',columntype: 'textbox', filtertype: 'input', datafield: 'description', width: '90%' },
	              ]
            });

            $('#jqxAccountsGrid').on('rowdoubleclick', function (event) 
            		{ 
		            	var rowindex1=event.args.rowindex;
		            	$('#jqxSalesmanGrid').jqxGrid('setcellvalue', gridrow, "account", $('#jqxAccountsGrid').jqxGrid('getcellvalue', rowindex1, "description")); 
		            	$('#jqxSalesmanGrid').jqxGrid('setcellvalue', gridrow, "accdoc", $("#jqxAccountsGrid").jqxGrid('getcellvalue', rowindex1, "doc_no"));
		              $('#salesmanaccinfowindow').jqxWindow('close');
            		 }); 
           
        });
    </script>
    <div id="jqxAccountsGrid"></div>
