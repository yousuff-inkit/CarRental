<%@page import="com.dashboard.client.clientiddetails.ClsClientidDetailsDAO" %>
<% ClsClientidDetailsDAO DAO=new ClsClientidDetailsDAO(); %> 
       
<script type="text/javascript">
               
		var clientdata='<%=DAO.clentdetails()%>';
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
                        ],
                 	localdata: clientdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientsearch").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                       
                columns: [
                              { text: 'Doc No', datafield: 'cldocno', width: '20%'},
                              { text: 'Name', datafield: 'refname', width: '100%' },
						]
            });
            
          $('#clientsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtclientname").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("txtclientaccountdocno").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "cldocno"); 
               
                
                $('#accountDetailsWindow').jqxWindow('close');
            }); 
        });
    </script>
    <div id="clientsearch"></div>