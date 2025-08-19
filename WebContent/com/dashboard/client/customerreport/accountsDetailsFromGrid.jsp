<%--  <%@page import="com.dashboard.client.clientalias.ClsClientAliasDAO"%>
<%@page import="com.dashboard.sales.ClsSalesReportsDAO"%> --%>
<%@page import="com.dashboard.client.customerreport.ClsCustomerReportDAO"%>
 <%
 ClsCustomerReportDAO clientSearchDAO= new ClsCustomerReportDAO();
 
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
                            {name : 'cldocno', type: 'int'   },
     						{name : 'refname', type: 'string'   },
     		
     						
     						
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxAccountsSearch").jqxGrid(
            {
                width: '100%',
                height: 325,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                
                columns: [
                	{ text: 'SL#', sortable: false, filterable: false, editable: false,
                        groupable: false, draggable: false, resizable: false,
                        datafield: 'sl', columntype: 'number', width: '4%',
                        cellsrenderer: function (row, column, value) {
                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        }  
                      },
                            { text: 'Doc No', hidden : true, datafield: 'cldocno', width: '5%' },
							
							{ text: 'Client Name', datafield: 'refname' },
							
						]
            });
            
             $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
             
                document.getElementById("acno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
            
             	document.getElementById("account").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "refname");
              $('#accountSearchwindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="jqxAccountsSearch"></div>
 