 <%@ page import="com.dashboard.operations.driverchange.ClsDriverchangeDAO" %>
<%ClsDriverchangeDAO clad=new ClsDriverchangeDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
var loaddata1='<%=clad.getdriverdetails()%>';
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                             
                             
                         	
                 		
     						{name : 'doc_no', type: 'number'},
     						{name : 'sal_name', type: 'String'},
     						
                          	],
                          	localdata: loaddata1,
                          	       
          
				
                
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
            $("#jqxmainsearch").jqxGrid(
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
    
          	            
				          $('#jqxmainsearch').on('rowdoubleclick', function (event) 
				            		{ 
				        	  var rowindex1=event.args.rowindex;
				            	
				               document.getElementById("drids").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
				               document.getElementById("drnames").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "sal_name");
				               document.getElementById("drvid").value=$('#jqxmainsearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
						             $('#dridwindow').jqxWindow('close');
				            
				            		 });	 
				           
        
                  }); 
				       
                       
    </script>
    <div id="jqxmainsearch"></div>
    
