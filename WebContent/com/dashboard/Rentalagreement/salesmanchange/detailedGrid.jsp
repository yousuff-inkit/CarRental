<%@ page import="com.dashboard.rentalagreement.salesmanchange.ClssalesmanchangeDAO" %>
 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();

  	
  	String status = request.getParameter("status")==null?"NA":request.getParameter("status").trim();

  	String fleet = request.getParameter("fleet")==null?"NA":request.getParameter("fleet").trim();

  	String salesman = request.getParameter("salesmandoc")==null?"NA":request.getParameter("salesmandoc").trim();
  	
  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	String outchk = request.getParameter("outchk")==null?"NA":request.getParameter("outchk").trim();
  	String inchk = request.getParameter("inchk")==null?"NA":request.getParameter("inchk").trim();
  	
 	String catid = request.getParameter("catid")==null?"NA":request.getParameter("catid").trim(); 

	ClssalesmanchangeDAO crad=new ClssalesmanchangeDAO();
  	
 %> 
 <script type="text/javascript">
 
 
 var datasssss;
 
 
	  datasssss='<%=crad.detailedgrid(barchval,fromdate,todate,cldocno,status,fleet,salesman,type,outchk,inchk,catid)%>';
  
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'ra_no', type: 'String'  },   //this is the agreement
     						{name : 'clientname', type: 'String'},
     						
     						 {name : 'fleet', type: 'String'}, 
     						 {name : 'fleetname', type: 'String'}, 
     						 
     						
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'docno', type: 'String'},
     						
     						{name : 'duedate', type: 'date'  },
     						{name : 'duetime', type: 'String'  },
     						{name : 'rentaltype', type: 'String'  },
     						{name : 'mobno', type: 'String'  },
     						{name : 'contactperson', type: 'String'  },
     						{name : 'brhid', type: 'string'  },
     						
     						{name : 'regno', type: 'string'  },
     						
     						{name : 'driver', type: 'String'  },
     						{name : 'manualra', type: 'String'  },
     						{name : 'rent', type: 'number'  },
     						{name : 'cdw', type: 'number'  },
     						{name : 'refno', type: 'string'  },
     						
     						
     						
     						
     						
     						{name : 'invrent', type: 'number'  },
     						{name : 'invcdw', type: 'number'  },
     						
     						
						{name : 'salesman', type: 'string'  },
     						 
     						{name : 'contractfleet', type: 'string'  },
     						{name : 'contractregno', type: 'string'  },
     						{name : 'openuser', type: 'string'  },
     						{name : 'closeuser', type: 'string'  },
     						
     						
                          	],
                          	localdata: datasssss,
                          	       
          
				
                
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
            $("#detailedGrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 600,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'checkbox',
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

							{ text: 'RA NO', datafield: 'ra_no', width: '6%' },   //voc no
							
							{ text: 'Fleet', datafield: 'fleet', width: '6%' },
							{ text: 'Fleet Name', datafield: 'fleetname', width: '13%' },
							{ text: 'Reg NO', datafield: 'regno', width: '8%' },
							{ text: 'Contract Fleet', datafield: 'contractfleet', width: '8%' },
							{ text: 'Contract Reg No', datafield: 'contractregno', width: '8%' },
							{ text: 'Client Name', datafield: 'clientname', width: '18%' },
							{ text: 'Salesman', datafield: 'salesman', width: '15%'},
							{ text: 'Contact Person', datafield: 'contactperson', width: '12%'},
							{ text: 'Driver', datafield: 'driver', width: '10%'},
							{ text: 'Mob NO', datafield: 'mobno', width: '10%'},
							
							 { text: 'Rental Type', datafield: 'rentaltype', width: '7%' },
							
							
							  
							
							 { text: 'Due Date', datafield: 'duedate', width: '6%',cellsformat:'dd.MM.yyyy'},
								
							 { text: 'DueTime', datafield: 'duetime', width: '5%' },
							 { text: 'Ref No', datafield: 'refno', width: '6%'},
						     { text: 'Manual RA', datafield: 'manualra', width: '6%'},
								
								
								 
							{ text: 'Rent', datafield: 'rent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								{ text: 'CDW', datafield: 'dcw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
								 
									{ text: 'Inv Rent', datafield: 'invrent', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
									{ text: 'Inv CDW', datafield: 'invcdw', width: '5%',cellsformat: 'd2', cellsalign: 'right', align:'right'},
									{ text: 'Open User', datafield: 'openuser', width: '15%'},
									{ text: 'Close User', datafield: 'closeuser', width: '12%'},
									{ text: 'Docno', datafield: 'docno', width: '12%',hidden:true},
									
									
							 { text: 'branchid', datafield: 'brhid', width: '10%',hidden:true },
					
								
								
							// regno contract,fleetno contract
					
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            
          /*   $('#detailedGrid').on('rowdoubleclick', function (event) {
               
                var rowindex2 = event.args.rowindex;
                
                document.getElementById("ra_no").value=$('#detailedGrid').jqxGrid('getcellvalue', rowindex2, "Docno");
                
                
            });  */   
   
        });
       
        
				       
                       
    </script>
    <div id="detailedGrid"></div>