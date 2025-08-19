<%@page import="com.humanresource.setup.hrsetup.companysetup.ClsCompanysetupDAO"%>
<%ClsCompanysetupDAO DAO= new ClsCompanysetupDAO(); %>

<script type="text/javascript">
        


        $(document).ready(function () {
        	
        	 var data2= '<%=DAO.companydet() %>';  
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                           	{name : 'co_name', type: 'string'   },
     						 
                        ],
                		localdata: data2, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#compsearch").jqxGrid(
            {
                width: '100%',
                height: 320,
                source: dataAdapter,
                selectionmode: 'singlerow',
                localization: {thousandsSeparator: ""},
                filterable:true,
                showfilterrow:true,
           
                columns: [
                            { text: 'Company Name', datafield: 'co_name' },
								 
						]
            });
            
             $('#compsearch').on('rowdoubleclick', function (event) {
            	 var rowindex1=event.args.rowindex;
                     
            	    document.getElementById("company").value= $('#compsearch').jqxGrid('getcellvalue', rowindex1, "co_name"); 
                    
              $('#compWindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="compsearch"></div>
 