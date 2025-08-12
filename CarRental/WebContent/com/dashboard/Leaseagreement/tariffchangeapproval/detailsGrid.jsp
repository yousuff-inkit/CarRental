<%@page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>

 <%

   String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval");
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String cldocno = request.getParameter("cldocno")==null?"NA":request.getParameter("cldocno").trim();
  	String rano = request.getParameter("rano")==null?"NA":request.getParameter("rano").trim();
  	String rdocno = request.getParameter("rdocno")==null?"NA":request.getParameter("rdocno").trim();
    
  	String type = request.getParameter("type")==null?"NA":request.getParameter("type").trim();
  	ClsleaseagreementDAO dao= new ClsleaseagreementDAO(); %>
 
 
 <script type="text/javascript">
 
 var temp4='<%=barchval%>';
 var tariffapprove;
 var aa;
  if(temp4!='NA')
 { 
 
	  tariffapprove='<%=dao.tariffapprovedetailsgrid(barchval,fromdate,todate,cldocno,type,rano,rdocno)%>'; 
 aa=0;
 }
  
  
  else
	  {
	  tariffapprove;
	  aa=1;
	  }
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'rano', type: 'String'  },
                 			{name : 'rvocno', type: 'String'  },
     						{name : 'refname', type: 'String'},
     						
     						{name : 'branch', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						
     						{name : 'oadvchk', type: 'String'  },
     						{name : 'nadvchk', type: 'String'  },
     						{name : 'brchid', type: 'string'  },
     						
     						{name : 'oinvtype', type: 'string'  },
     						{name : 'ninvtype', type: 'string'  },
     						{name : 'blexid', type: 'string'  },
     						
    						{name : 'invdate', type: 'date'  },
							{name : 'clientadvc', type: 'string'    },
     						
    						{name : 'clientinvtype', type: 'string'    },
     						
    						{name : 'method', type: 'string'    },
     				 
     						
                          	],
                          	localdata: tariffapprove,
                          	       
          
				
                
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
            	
            	
            	width: '99%',
                height: 340,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                rowsheight:20,
                filterable: true,
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
							{ text: 'RA NO', datafield: 'rano', width: '4%',hidden:true},
							{ text: 'LA NO', datafield: 'rvocno', width: '6%'},
							{ text: 'Branch', datafield: 'branch', width: '14%' },
							{ text: 'Client Name', datafield: 'refname', width: '25%' },
							{ text: 'New Advance', datafield: 'nadvchk', width: '10%'},
							 { text: 'Old Advance', datafield: 'oadvchk', width: '10%' },
							
							 { text: 'New Invoice', datafield: 'ninvtype', width: '10%' },
							 { text: 'Old Invoice', datafield: 'oinvtype', width: '10%' },
							
							 { text: 'Invoice Date', datafield: 'invdate', width: '12%' ,cellsformat:'dd.MM.yyyy'},
							 
							
							 { text: 'branchid', datafield: 'brchid', width: '10%',hidden:true },
							 { text: 'cldocno', datafield: 'cldocno', width: '10%',hidden:true },					
							 { text: 'id_brex', datafield: 'blexid', width: '10%',hidden:true },
							 { text: 'clientadvc', datafield: 'clientadvc' , width: '10%' ,cellsformat:'d2',hidden:true},       
								{ text: 'clientinvtype', datafield: 'clientinvtype', width: '10%' ,cellsformat:'d2',hidden:true },  
								
								{ text: 'method', datafield: 'method', width: '10%' ,cellsformat:'d2',hidden:true },
							 
					]
            });
     
     	   $("#overlay, #PleaseWait").hide();
            
       
		   $("#detailsgrid").on("celldoubleclick", function (event)
				   {
				  var rentalrow = event.args.rowindex;
			 /*   var calcu=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "caludays");
			   if(parseInt(calcu)>0 || parseInt(calcu)<0 )
				   {
				   $.messager.alert('Message','RA Is Invoiced  ','warning');   
				   return 0;
				   
				   } */
			   
			   
            	// $('#searchuser').attr("disabled",false);
       		
         	 $('#approve').attr("disabled",false);
          	 $('#cancel').attr("disabled",false);
        //	 $('#advance_chk').attr("disabled",false);
     		
       // 	 $('#cmbinvoicing_method').attr("disabled",false);
          	 
          	 
          	if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "nadvchk")=='YES')
            {
           	document.getElementById('advance_chk').checked=true;
           	
           	document.getElementById('advance_chk').value=1;
            }
            else
            	{
            	document.getElementById('advance_chk').checked=false;
            	document.getElementById('advance_chk').value=0;
            	
            	}
          	
          	//alert($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype"))
        	if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype")=='Month End')
            {
           	
           	document.getElementById("cmbinvoicing_method").value=1;
            }
            else if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype")=='Period')
                
            	{
            	document.getElementById("cmbinvoicing_method").value=2;
            	
            	}
            else if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype")=='Quarterly')
                
        	{
        	document.getElementById("cmbinvoicing_method").value=4;
        	
        	}
            else if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype")=='Half Yearly')
                
        	{
        	document.getElementById("cmbinvoicing_method").value=5;
        	
        	}
            else if($('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "ninvtype")=='Yearly'){
        	document.getElementById("cmbinvoicing_method").value=6;
        	
        	}else{}
       
          	
          	 
       	 document.getElementById("advchkval").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "clientadvc");
          	 
          	 document.getElementById("invval").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "clientinvtype");
          	 
          	 
        	 document.getElementById("configmethod").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "method");
          	 
        	  
              document.getElementById("branchid").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "brchid");	  
			  
			  document.getElementById("docnos").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "rano");
			  document.getElementById("blexid").value=$('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "blexid");
			  
			  document.getElementById("invdate").value=$('#detailsgrid').jqxGrid('getcelltext', rentalrow, "invdate");
			  
			  
			var masterdoc= $('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "rano");
			var blexid= $('#detailsgrid').jqxGrid('getcellvalue', rentalrow, "blexid");
			 
			  
			  $("#rtariffchange").load("ltariffdetails.jsp?rdocno="+masterdoc+"&blexid="+blexid);  
			  
            
				   });
            
        });
        
        
				       
                       
    </script>
    <div id="detailsgrid"></div>