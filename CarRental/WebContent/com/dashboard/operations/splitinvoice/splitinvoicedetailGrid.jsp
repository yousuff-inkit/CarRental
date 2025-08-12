<%@page import="com.dashboard.operations.splitinvoice.ClsSplitInvoiceDAO" %>
<% ClsSplitInvoiceDAO DAO=new ClsSplitInvoiceDAO();%>
 
 <%String check = request.getParameter("check")==null || request.getParameter("check").trim().equalsIgnoreCase("")?"0":request.getParameter("check").trim();
 String docno = request.getParameter("docno")==null || request.getParameter("docno").trim().equalsIgnoreCase("")?"0":request.getParameter("docno").trim();%>
 
 
 <script type="text/javascript">
 $(document).ready(function () { 	
	 var data;
	   
			data='<%=DAO.splitinvoicedetailGridData(check,docno)%>';
	 
	 
  var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'docno', type: 'string'  },
                	        {name : 'account', type: 'string'    },
     						{name : 'description',type: 'string'},
     						{name : 'total',type:'number'},
     						{name : 'chargetodrive',type:'number'},
     						{name : 'acno',type:'number'},
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
            
            $("#jqxsplitinvoicedetail").jqxGrid(
            {
                width: '99%',
                height: 180,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'checkbox',
                editable: true,
                
                columns: [
					{ text: 'Sr.No', sortable: false, filterable: false,editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '4%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                	        { text: 'Doc No', datafield: 'docno', width: '5%',editable:false ,hidden: true },
							{ text: 'Account', datafield: 'account', width: '19%',editable:false },
							{ text: 'Description',datafield:'description' ,editable:false },
							{ text: 'Total',datafield:'total',width:'17%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right' },
							{ text: 'Charge to drive', datafield: 'chargetodrive', width: '18.5%',cellsformat:'d2',cellsalign:'right',align:'right' },
							{ text: 'Ac no',datafield:'acno',width:'39%',editable:false,hidden:true  },
							{ text: 'Ref No', datafield: 'refno', width: '20%',hidden:true  },
							{ text: 'invdoc No', datafield: 'invdocno', width: '20%',hidden:true  },
							
							]
                  
            });
              $("#overlay, #PleaseWait").hide();
              $("#jqxsplitinvoicedetail").on('rowselect', function () {
            	     var rowindexes = $('#jqxsplitinvoicedetail').jqxGrid('getselectedrowindexes');
            	     // alert(rowindexes)
            	      for (i = 0; i < rowindexes.length; i++) {
            	    	  var total= $('#jqxsplitinvoicedetail').jqxGrid('getcellvalue',rowindexes[i], "total");
            	    	  $('#jqxsplitinvoicedetail').jqxGrid('setcellvalue',rowindexes[i], "chargetodrive",parseFloat(total)/2);
            	      }
            	 });          
           
           
        });
 </script>
  <div id="jqxsplitinvoicedetail"></div>
  <input type="hidden" name="rowindex2" id="rowindex2">
  <input type="hidden" name="acno" id="acno">
  
  
     
  
   