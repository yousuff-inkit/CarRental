<%@ page import="com.dashboard.accounts.distributionmapping.ClsDistributionmappingDAO"%> 
	
 <%
 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 String type = request.getParameter("type")==null?"0":request.getParameter("type");
 
 ClsDistributionmappingDAO DAO=new ClsDistributionmappingDAO(); 
 %>
 <script type="text/javascript">
 

 var details;
 
   var details='<%=DAO.gridDetails(chk,type)%>'; 
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                	        {name : 'docno', type: 'number'  },
                 			{name : 'account', type: 'number'  },
                 			{name : 'description' , type : 'String'},
     						{name : 'br1', type: 'String'},
     						{name : 'br2', type: 'String'},
     						{name : 'br3', type: 'String'},
     						{name : 'br4', type: 'String'},
     						{name : 'br5', type: 'String'},
     						{name : 'br6', type: 'String'},
     						{name : 'rowchng', type: 'number'  }
                          	],
                          	
                          	localdata: details,
                          	       
          
				
                
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
            $("#jqxdistmapgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 550,
                source: dataAdapter,
                selectionmode: 'checkbox',
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
                editable:true,
                
     					
                columns: [
                	
                	 { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },
                	
                	         { text: 'Doc No', datafield: 'docno', width: '15%',hidden:true ,editable:false},
							 { text: 'Account', datafield: 'account', width: '10%' ,editable:false},
							 { text: 'Description', datafield: 'description', width: '24.5%',editable:false},	
							 { text: 'Rent A Car', datafield: 'br1', width: '10%', cellsalign:'right',cellsformat:'d2',align:'right'},
							 { text: 'Bus Rental', datafield: 'br2', width: '10%', cellsalign:'right',cellsformat:'d2',align:'right' },
							 { text: 'General Trucks Rental', datafield: 'br3', width: '10%' ,cellsalign:'right',cellsformat:'d2',align:'right' },
							 { text: 'Passenger Transport', datafield: 'br4', width: '10%', cellsalign:'right',cellsformat:'d2',align:'right' },
							 { text: 'Abu Dhabi', datafield: 'br5', width: '10%',cellsalign:'right',cellsformat:'d2',align:'right'},
							 { text: 'Bus & General Trucks Rental', datafield: 'br6', width: '10%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
							 { text: 'Rowchng', datafield: 'rowchng', width: '10%' ,editable:false,hidden:true},
								
					
					]
            });
            
        	$("#jqxdistmapgrid").on('cellvaluechanged', function (event){
         	 	var datafield = event.args.datafield;
         	    var rowBoundIndex = event.args.rowindex;
         		    
         	    if(datafield=="br1" || datafield=="br2" || datafield=="br3" || datafield=="br4" || datafield=="br5" || datafield=="br6") 
         	    {
         	    	valchange(rowBoundIndex);
         	    }
          	});
         	
         	function valchange(rowBoundIndex)
         	{
         	   var br1=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br1'));
         	   var br2=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br2'));
         	   var br3=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br3'));
         	   var br4=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br4'));
         	   var br5=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br5'));
         	   var br6=parseFloat($('#jqxdistmapgrid').jqxGrid('getcellvalue',rowBoundIndex,'br6'));
    		    
         		
         	
         		$('#jqxdistmapgrid').jqxGrid('setcellvalue',rowBoundIndex,'rowchng',1)
         	}
        
            $('.load-wrapp').hide();
            
       
        });
        
        
				       
                       
    </script>
    <div id="jqxdistmapgrid"></div>