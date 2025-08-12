<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO" %>
<%ClsEmployeeMasterDAO DAO=new ClsEmployeeMasterDAO(); %>
<script type="text/javascript">
        


        $(document).ready(function () {
        	
        	 var data2= '<%=DAO.branchdet() %>';  
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                           	{name : 'brchname', type: 'string'   },
     						 
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#brchsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                filterable:true,
                showfilterrow:true,
           
                columns: [
                            { text: 'Branch Name', datafield: 'brchname' },
								 
						]
            });
            
             $('#brchsearch').on('rowdoubleclick', function (event) {
            	 var rowindex1=event.args.rowindex;
                     
            	    document.getElementById("txtbankbranchname").value= $('#brchsearch').jqxGrid('getcellvalue', rowindex1, "brchname"); 
                    
              $('#brchWindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="brchsearch"></div>
 