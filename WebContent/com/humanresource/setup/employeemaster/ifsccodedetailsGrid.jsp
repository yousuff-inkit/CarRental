<%@page import="com.humanresource.setup.employeemaster.ClsEmployeeMasterDAO" %>
<%ClsEmployeeMasterDAO DAO=new ClsEmployeeMasterDAO(); %>

<script type="text/javascript">
        


        $(document).ready(function () {
        	
        	 var data2= '<%=DAO.ifsccodedet() %>';  
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                           	{name : 'ifsccode', type: 'string'   },
     						 
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#ifsccodesearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                filterable:true,
                showfilterrow:true,
           
                columns: [
                            { text: 'IFSC Code', datafield: 'ifsccode' },
								 
						]
            });
            
             $('#ifsccodesearch').on('rowdoubleclick', function (event) {
            	 var rowindex1=event.args.rowindex;
                     
            	    document.getElementById("txtbankifsccode").value= $('#ifsccodesearch').jqxGrid('getcellvalue', rowindex1, "ifsccode"); 
                    
              $('#ifsccodeWindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="ifsccodesearch"></div>
 