<%@page import="com.search.ClsAccountSearch" %>
<%ClsAccountSearch cas=new ClsAccountSearch(); %>
<% String rowindex = request.getParameter("rowindex") == null || request.getParameter("rowindex").equals("")?"0":request.getParameter("rowindex");
%>
 <script type="text/javascript">
    var data= '<%= cas.accsearch_ap() %>';
    var rowindex = '<%=rowindex%>';
    $(document).ready(function () { 	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'int' },
     						{name : 'description', type: 'String'  },
     						{name : 'acno',type:'string'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
           
            $("#jqxAccountsAPGrid").jqxGrid(
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
                sortable: true,
                columns: [
					{ text: 'Doc No' ,datafield: 'doc_no', width: '0%',hidden:true  },
					{ text: 'Account', datafield: 'acno', width: '20%' },
					{ text: 'Account Name', datafield: 'description'  },  
					
	              ]
            });

            $('#jqxAccountsAPGrid').on('rowdoubleclick', function (event) { 
		            	var rowindex1=event.args.rowindex;
		                 
		            	$('#jqxInsuranceGrid').jqxGrid('setcellvalue', rowindex, "accountname", $('#jqxAccountsAPGrid').jqxGrid('getcellvalue', rowindex1, "description"));
		            	$('#jqxInsuranceGrid').jqxGrid('setcellvalue', rowindex, "accdoc", $('#jqxAccountsAPGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"));   
		                 
		              $('#accountWindow').jqxWindow('close');  
            }); 
           
        });
    </script>
    <div id="jqxAccountsAPGrid"></div>    