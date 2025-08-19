<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>
<% String rowindex = request.getParameter("rowindex") == null || request.getParameter("rowindex").equals("")?"0":request.getParameter("rowindex");
%>
<script type="text/javascript">
    var data= '<%= cas.accsearch_gl() %>';
    var rowindex='<%=rowindex%>';
        $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  },
     						{name : 'acc',type:'string'}
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
          
            $("#jqxAccountsGLGrid").jqxGrid(
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
		                	{ text: 'Doc No' ,datafield: 'doc_no', width: '0%',hidden:true  },
							{ text: 'Account', datafield: 'acc', width: '20%' },
							{ text: 'Account Name', datafield: 'description'  }, 
	              ]
            });

            $('#jqxAccountsGLGrid').on('rowdoubleclick', function (event) { 
            	var rowindex1=event.args.rowindex;
                 
            	$('#jqxFinanceGrid').jqxGrid('setcellvalue', rowindex, "accountname", $('#jqxAccountsGLGrid').jqxGrid('getcellvalue', rowindex1, "description"));
            	$('#jqxFinanceGrid').jqxGrid('setcellvalue', rowindex, "accdoc", $('#jqxAccountsGLGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));   
                 
                $('#accountWindow').jqxWindow('close');    
             }); 
           
        });
    </script>
    <div id="jqxAccountsGLGrid"></div>
