<%--  <%@page import="com.dashboard.client.clientalias.ClsClientAliasDAO"%>
<%@page import="com.dashboard.sales.ClsSalesReportsDAO"%> --%>
<%@page import="com.dashboard.client.customercatwisereport.ClsCustomerCatWiseReportDAO"%>
 <%
 ClsCustomerCatWiseReportDAO clientSearchDAO= new ClsCustomerCatWiseReportDAO();
 
 String accountname = request.getParameter("accountname")==null?"":request.getParameter("accountname");
String account=request.getParameter("account")==null?"":request.getParameter("account");
String mob=request.getParameter("mob")==null?"":request.getParameter("mob");
 
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%> 

<script type="text/javascript">
        
        

   var data2= '<%=clientSearchDAO.clientDetailsFrom(accountname,check,account,mob) %>'; 

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
     						{name : 'cat_name', type: 'string'   },
     		
     						
     						
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '99.7%',
                height: 257,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                filterable: true,
                showfilterrow: true,
                
                columns: [
                	{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '10%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
                      },
                            { text: 'Doc No', hidden : true, datafield: 'doc_no' },
							
							{ text: 'Category Name', datafield: 'cat_name',width:'90%' },
							
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
             
                document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
             	document.getElementById("account").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cat_name");
              $('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 