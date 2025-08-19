<%@page import="com.dashboard.invoices.invoicetodispatch.ClsInvoiceDispatchDAO" %>
<%ClsInvoiceDispatchDAO cid=new ClsInvoiceDispatchDAO(); %>
       <script type="text/javascript">
  
	    var dataurl='getClientData.jsp';
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'refname', type: 'string'  },
                            {name : 'cldocno', type: 'string'  }
     						
                        ],
                		
                		  url: dataurl,
                 //localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#clientsearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                showfilterrow: true, 
                filterable: true, 
                autoshowloadelement:true,
                selectionmode: 'checkbox',
                       
                columns: [
                              { text: 'DOC NO', datafield: 'cldocno', width: '20%',hidden:true},
                              { text: 'Name', datafield: 'refname', width: '100%' },
						]
            });
            
          $('#clientsearch').on('rowdoubleclick', function (event) {
           
                var rowindex2 = event.args.rowindex;
                document.getElementById("txtclientname").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "refname");
                document.getElementById("txtcldocno").value=$('#clientsearch').jqxGrid('getcellvalue', rowindex2, "cldocno");
                
               $('#clientDetailsWindow').jqxWindow('close'); 
            }); 
          
          $('#btnchooseclient').click(function(){
        	 var selectedrows=$('#clientsearch').jqxGrid('getselectedrowindexes');
        	 if(selectedrows.length==0){
        		 $.messager.alert('Warning','Please select valid clients');
        		 return false;
        	 }
        	 else{
        		 var htmldata='';
        		 var cldocnotext='';
        		 for(var i=0;i<selectedrows.length;i++){
        			 var refname=$('#clientsearch').jqxGrid('getcellvalue', selectedrows[i], "refname");
        			 var cldocno=$('#clientsearch').jqxGrid('getcellvalue', selectedrows[i], "cldocno");
        			 htmldata+=refname+'\n';
        			 if(cldocnotext==''){
        				 cldocnotext+=cldocno;
        			 }
        			 else{
        				 cldocnotext+=','+cldocno;
        			 }
        		 }
        		 $('#txtcldocno').val(cldocnotext);
        		 $('#clienthtml').text(htmldata);
        		 $('#clientDetailsWindow').jqxWindow('close'); 
        	 }
          });
        });
    </script>
    <div style="text-align:center;"><button type="button" id="btnchooseclient" class="myButton">Choose Selected</button></div>
    <div id="clientsearch"></div>