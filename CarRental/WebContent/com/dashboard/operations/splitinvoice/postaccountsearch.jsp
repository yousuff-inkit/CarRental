<%@page import="com.dashboard.operations.splitinvoice.ClsSplitInvoiceDAO" %>
<% ClsSplitInvoiceDAO DAO=new ClsSplitInvoiceDAO();%>

<%String id=request.getParameter("id"); %>
<%String postacc=request.getParameter("postacc"); %>


<script type="text/javascript">
        var postdata;
        postdata='<%=DAO.getpostacc(id,postacc)%>';
   	 
$(document).ready(function () { 	
	
	  var source =
     {
			  
         datatype: "json",
         datafields: [
                	{name : 'docno', type: 'string' ,hidden: true },
         	        {name : 'accountnum', type: 'string'  },
         	        {name : 'description', type: 'string'    },
										
          ],
          localdata: postdata,
         
         
         pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
     
     var dataAdapter = new $.jqx.dataAdapter(source,{
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
	            });
     
     $("#jqxpostaccountsearch").jqxGrid(
     {
         width: '99%',
         height: 330,
         source: dataAdapter,
         filtermode:'excel',
         filterable: true,
         showfilterrow: true,
         sortable: true,
         showaggregates:true,
         selectionmode: 'singlerow',
        
         columns: [
        	        { text: 'Doc No', datafield: 'docno', width: '8%'  },
         	        { text: 'Account No', datafield: 'accountnum', width: '30%'  },
					{ text: 'Description',datafield:'description',width:'70%'},
						]
           
     });
     $('#jqxpostaccountsearch').on('rowdoubleclick', function (event) {
     	var rowindex1=event.args.rowindex;
         document.getElementById("postacc").value= $('#jqxpostaccountsearch').jqxGrid('getcellvalue', rowindex1, "docno");
         document.getElementById("txtpostacc").value= $('#jqxpostaccountsearch').jqxGrid('getcellvalue', rowindex1, "description");
         	  
         $('#postaccwindow').jqxWindow('close');
         
     });  

 });
</script>
<div id="jqxpostaccountsearch"></div>
  
	   
	