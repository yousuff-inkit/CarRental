<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO" %>
<%ClsEmployeeMasterDAO DAO=new ClsEmployeeMasterDAO(); %>

<script type="text/javascript">
        


        $(document).ready(function () { 
        	 var data1= '<%=DAO.estdet() %>'; 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                           	{name : 'est_code', type: 'string'   },
                           	{name : 'comp_name', type: 'string'   },
     						 
                        ],
                		localdata: data1, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#estsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                filterable:true,
                showfilterrow:true,
           
              
                columns: [
                            { text: 'EST Code', datafield: 'est_code' },
                            { text: 'Company Name', datafield: 'comp_name' },
								 
						]
            });
            
             $('#estsearch').on('rowdoubleclick', function (event) {
            	 
            	 var rowindex1=event.args.rowindex;
                 
            	 document.getElementById("txtest_code").value= $('#estsearch').jqxGrid('getcellvalue', rowindex1, "est_code"); 
            	 document.getElementById("txtco_name").value= $('#estsearch').jqxGrid('getcellvalue', rowindex1, "comp_name"); 
                   
                       
                
              $('#establishedCodeDetailsWindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="estsearch"></div>
 