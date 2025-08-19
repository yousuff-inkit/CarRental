<%@page import="com.humanresource.setup.hrsetup.companysetup.ClsCompanysetupDAO"%>
<%ClsCompanysetupDAO DAO= new ClsCompanysetupDAO(); %>

<script type="text/javascript">
        


        $(document).ready(function () { 
        	 var data1= '<%=DAO.estdet() %>'; 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                           	{name : 'est_code', type: 'string'   },
     						 
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
								 
						]
            });
            
             $('#estsearch').on('rowdoubleclick', function (event) {
            	 
            	 var rowindex1=event.args.rowindex;
                 
            	 document.getElementById("estcode").value= $('#estsearch').jqxGrid('getcellvalue', rowindex1, "est_code"); 
                    
                       
                
              $('#establishedCodeDetailsWindow').jqxWindow('close');  
              
            });  
        });
    </script>
    <div id="estsearch"></div>
 