<%@page import="com.dashboard.operations.raladriverupdate.ClsralaDriverUpdateDAO" %>
 <%

 ClsralaDriverUpdateDAO RemoveDAO=new ClsralaDriverUpdateDAO();
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 String rad = request.getParameter("rad")==null?"1":request.getParameter("rad").trim();
 
 
 %> 
 
 
 <script type="text/javascript">
 
 var temp4='<%=branchval%>';
  
 var dataildata;
 var aa;
  if(temp4!='NA')
 { 

	  var dataildata='<%= RemoveDAO.driverlist(branchval,fromDate,toDate,cldocno,agmtNo,rad)%>';; 
 }
  
 
  else
	  {
	  var dataildata;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
//doc_no voc_no fleet_no flname cldocno srno refname drname
                             
                 			{name : 'doc_no', type: 'String'  },   //this is the agreement
     						{name : 'voc_no', type: 'String'},
     						
     						
     						 
     						
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     					 
     					 
     						{name : 'cldocno', type: 'String'  },
      
     						{name : 'srno', type: 'string'  },
     						
     						 {name : 'refname', type: 'String'}, 
     						 {name : 'drname', type: 'String'}, 
     						 
     						 
     						{name : 'type', type: 'string'  },
     						
     						 {name : 'brhid', type: 'String'}, 
     						 {name : 'outdate', type: 'date'}, 

                          	],
                          	localdata: dataildata,
                          	       
          
				
                
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
            $("#detailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 380,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
        	 
					
					
					 
					
 
     					
			         columns: [
			                   { text: 'SL#', sortable: false, filterable: false, editable: false,   
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'RA/LA NO', datafield: 'voc_no', width: '10%' },   //voc no
							
							{ text: 'Date', datafield: 'outdate', width: '10%' ,cellsformat:'dd.MM.yyyy'},

							{ text: 'Client Name', datafield: 'refname' },
							{ text: 'cldocno', datafield: 'cldocno' ,hidden:true},

							{ text: 'Driver', datafield: 'drname', width: '22%',hidden:true},
						 
							
							{ text: 'Fleet', datafield: 'fleet_no', width: '10%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '20%' },
							 
 
							 { text: 'type ', datafield: 'type', width: '10%',editable:false, filterable: false,hidden:true },
					
							 { text: 'srno', datafield: 'srno', width: '13%',hidden:true },	 
							 
							 { text: 'brhid', datafield: 'brhid', width: '13%',hidden:true },	 
							  
							 
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            
            
            
            
            
            
            $("#detailsgrid").on('rowdoubleclick', function (event) 
            		{
            		 
            		    var datafield = event.args.datafield;
            		    var rowBoundIndex=event.args.rowindex;
            	 
             			  	var cldocno=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno');  
             			  	var docno=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');  
             			  	var type=$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'type');  
             		        document.getElementById("hidcldocno").value = cldocno;
             		        document.getElementById("hiddoc").value = docno;
             		        document.getElementById("type").value = type;
             		       document.getElementById("hidbrhid").value =$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'brhid');  
             		       document.getElementById("hidclient").value =$('#detailsgrid').jqxGrid('getcellvalue',rowBoundIndex,'refname');  

             		       $("#jqxDriver").jqxGrid('clear');
             			  	$('#DriverDiv').load('driver.jsp?cldocno='+cldocno+'&docno='+docno+'&type='+type);	

          
            });
   		          
            
           
              
            
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>