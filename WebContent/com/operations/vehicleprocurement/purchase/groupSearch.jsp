<%@page import="com.operations.vehicleprocurement.purchase.ClsvehpurchaseDAO" %>
<%
ClsvehpurchaseDAO cvpo=new ClsvehpurchaseDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>

       <script type="text/javascript">
  
			 var groupdata=[];
			 var id='<%=id%>';
			 if(id=="1"){
				groupdata='<%=cvpo.searchGroup(id) %>';
			 }
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'vehgroup', type: 'string'  },
                            {name : 'vehgroupid', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupGridSearch").jqxGrid(
            {
                width: '99%',
                height: 310,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'Doc No', datafield: 'vehgroupid', width: '20%',hidden:true},
                              { text: 'Group', datafield: 'vehgroup', width: '100%' },
                           
						
						
	             
						]
            });
            $('#groupGridSearch').on('rowclick', function (event) 
            		{
            	var rowindex1 =$('#rowindex').val();
            	  $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "vehgroup" ,"");
            		   
            	                                                                                  
            		});
          $('#groupGridSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "vehgroup" ,$('#groupGridSearch').jqxGrid('getcellvalue', rowindex2, "vehgroup"));
                $('#vehoredergrid').jqxGrid('setcellvalue', rowindex1, "vehgroupid" ,$('#groupGridSearch').jqxGrid('getcellvalue', rowindex2, "vehgroupid"));
                
                
              $('#groupwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="groupGridSearch"></div>