 <%@ page import="com.dashboard.operations.driverchange.ClsDriverchangeDAO" %>
<%ClsDriverchangeDAO clad=new ClsDriverchangeDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
var loaddata2='<%=clad.getdriverdetails()%>';
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                 		
     						{name : 'doc_no', type: 'number'},
     						{name : 'sal_name', type: 'String'},
     						
                          	],
                          	localdata: loaddata2,
                          	       
          
				
                
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
            $("#jqxmainsearch1").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
               
                //Add row method
     					
     					
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
							{ text: 'Driver Name', datafield: 'sal_name', width: '90%' }
							
			
					
					
					]
            });
    
          	            
				          $('#jqxmainsearch1').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				               document.getElementById("dlvdrv").value=$('#jqxmainsearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("dlvdrvs").value=$('#jqxmainsearch1').jqxGrid('getcellvalue', rowindex1, "sal_name");
				               document.getElementById("deldrvid").value=$('#jqxmainsearch1').jqxGrid('getcellvalue', rowindex1, "doc_no");
						             $('#deldridwindow').jqxWindow('close');
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch1"></div>
    
