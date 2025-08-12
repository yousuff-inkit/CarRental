 <%@page import="com.dashboard.operations.splitinvoice.ClsSplitInvoiceDAO" %>
<% ClsSplitInvoiceDAO DAO=new ClsSplitInvoiceDAO();%>
 
 <%String check = request.getParameter("check")==null || request.getParameter("check").trim().equalsIgnoreCase("")?"0":request.getParameter("check").trim();
 String docno = request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("")?"0":request.getParameter("docno").trim();%>
 
 
 
 <script type="text/javascript">
 $(document).ready(function () { 	
	 var jvdata;
     var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'docno', type: 'string'  },
							{name : 'account', type: 'string'  },
     						{name : 'description',type: 'string'},
     						{name : 'credit',type:'string'},
     						{name : 'debit',type:'string'},
     						{name : 'acno',type:'string'},
     						{name : 'refno',type:'string'},
     						{name : 'invdocno',type:'string'},
     										
                 ],
                 localdata: jvdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxsplitinvoicejvdetails").jqxGrid(
            {
                width: '99%',
                height: 180,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                
                columns: [
                	        { text: 'Docno', datafield: 'docno', width: '30%' , hidden: true},
					        { text: 'Account', datafield: 'account', width: '30%' },
							{ text: 'Description',datafield:'description',width:'32%'},
							{ text: 'Credit',datafield:'credit',width:'19%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Debit', datafield: 'debit', width: '19%',cellsformat:'d2',cellsalign:'right',align:'right' },
							{ text: 'Ac No', datafield: 'acno', width: '30%',hidden:true },
							{ text: 'Ref No', datafield: 'refno', width: '30%',hidden:true},
							{ text: 'invdoc No', datafield: 'invdocno', width: '20%',hidden:true  },
							
							]
                  
            });
          	
            $("#overlay, #PleaseWait").hide();
            
                 	
        });
 </script>
  <div id="jqxsplitinvoicejvdetails"></div>
  
  
   