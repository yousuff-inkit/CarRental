<%@page import="com.dashboard.operations.splitinvoice.ClsSplitInvoiceDAO" %>
<% ClsSplitInvoiceDAO DAO=new ClsSplitInvoiceDAO();%>


<%String branchval = request.getParameter("branchval")==null || request.getParameter("branchval").trim().equalsIgnoreCase("a")?"":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null || request.getParameter("fromdate").trim().equalsIgnoreCase("")?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null || request.getParameter("todate").trim().equalsIgnoreCase("")?"0":request.getParameter("todate").trim();
 String client = request.getParameter("client")==null || request.getParameter("client").trim().equalsIgnoreCase("")?"0":request.getParameter("client").trim();
 String postacc = request.getParameter("postacc")==null || request.getParameter("postacc").trim().equalsIgnoreCase("")?"0":request.getParameter("postacc").trim();
 String id = request.getParameter("id")==null || request.getParameter("id").trim().equalsIgnoreCase("")?"0":request.getParameter("id").trim();%>
 
 <script type="text/javascript">
 
 var data;
 var temp='<%=branchval%>';
 
	if(temp!='0'){ 
		data='<%=DAO.splitinvoiceGridLoading(branchval,fromDate,toDate,client,postacc,id)%>';
 }
	
 $(document).ready(function () { 	
	
	 
  var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'brhid', type: 'string'  },
                	        {name : 'docno', type: 'string'  },
					    	{name : 'invno', type: 'string'  },
     					  	{name : 'date', type: 'date'    },
     						{name : 'rano',type: 'string'},
     						{name : 'client',type:'string'},
     						{name : 'driversname',type:'string'},
     						{name : 'totalinv', type: 'number'    },
     						{name : 'acno', type: 'number'    },
     						{name : 'refno', type: 'number'    },
     						{name : 'invdocno', type: 'number'    },
         	     						
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxsplitinvoice").jqxGrid(
            {
                width: '99%',
                height: 180,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                
                columns: [   
                	        { text: 'Branch Id', datafield: 'brhid', width: '5%',hidden: true },
                	        { text: 'Doc No', datafield: 'docno', width: '5%',hidden: true },
							{ text: 'Invoice No', datafield: 'invno', width: '8%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '10%' },
							{ text: 'RaNo',datafield:'rano',width:'10%'},
							{ text: 'Client',datafield:'client',width:'26%'},
							{ text: 'Drivers Name', datafield: 'driversname', width: '26%' },
							{ text: 'Total Invoice', datafield: 'totalinv', width: '20%',cellsformat:'d2',cellsalign:'right',align:'right' },
							{ text: 'Ac No', datafield: 'acno', width: '20%' ,hidden:true },
							{ text: 'Ref No', datafield: 'refno', width: '20%',hidden:true  },
							{ text: 'invdoc No', datafield: 'invdocno', width: '20%',hidden:true },
							
							]
            
            
                 
            });
            $("#overlay, #PleaseWait").hide();
             
            $('#jqxsplitinvoice').on('rowdoubleclick', function (event) {
           	 var rowindex1 = event.args.rowindex;
           	 $('#acno').val($('#jqxsplitinvoice').jqxGrid('getcellvalue', rowindex1, "acno"));
           	$('#refno').val($('#jqxsplitinvoice').jqxGrid('getcellvalue', rowindex1, "refno"));
           	$('#invdocno').val($('#jqxsplitinvoice').jqxGrid('getcellvalue', rowindex1, "invdocno"));
           	$('#jqxsplitinvoicejvdetails').jqxGrid('clear');
           	$("#rowindex1").val(rowindex1);
           		var indexVal =  $('#jqxsplitinvoice').jqxGrid('getcellvalue', rowindex1, "docno");
                
	    	 var check = 1;
     			    	            
   		     $("#overlay, #PleaseWait").show();
     			    	
     			    	$("#splitinvoicedetailDiv").load("splitinvoicedetailGrid.jsp?docno="+indexVal+'&check='+check); 
     			      	  });
        });
 </script>
  <div id="jqxsplitinvoice"></div>
  
  <input type="hidden" name="rowindex1" id="rowindex1">
  <input type="hidden" name="acno" id="acno">
   
  
   