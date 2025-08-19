<%@ page import="com.dashboard.operations.whatsappmessaging.ClsWhatsappMessagingDAO" %>
<%  ClsWhatsappMessagingDAO cod=new ClsWhatsappMessagingDAO(); %>     
<script type="text/javascript">
		$(document).ready(function () { 	
			var clientdata='<%=cod.groupdetails()%>';  
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'groups', type: 'string'  },
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupsearch").jqxGrid(
            {
                width: '100%',
                height: 250,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Group', datafield: 'groups', width: '100%' },
						]
            });
            
          $('#groupsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("group").value=$('#groupsearch').jqxGrid('getcellvalue', rowindex2, "groups");
                
                $('#groupwindow').jqxWindow('close');  
            }); 
        });
    </script>
    <div id="groupsearch"></div>