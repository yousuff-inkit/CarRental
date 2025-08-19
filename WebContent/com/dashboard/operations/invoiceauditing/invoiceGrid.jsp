<%@ page import="com.dashboard.operations.invoiceauditing.*"  %>
<%
	String agmtdocno = request.getParameter("agmtdocno")==null?"":request.getParameter("agmtdocno").trim();
String agmttype = request.getParameter("agmttype")==null?"":request.getParameter("agmttype").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
ClsInvoiceAuditingDAO dao=new ClsInvoiceAuditingDAO();
%> 
 
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
       
    .whiteClass
    {
        background-color: #FFF;
    }
    
</style>
 
 
<script type="text/javascript">
	var id='<%=id%>';
	var invdata=[];
	if(id=="1"){
		 invdata='<%=dao.getInvoiceData(agmtdocno,agmttype,id)%>';
	}
	$(document).ready(function () { 
    	var source = 
            {
                datatype: "json",
                datafields: [
                	{name : 'slno',type:'number'},
					{name : 'invdocno', type: 'number'},
     				{name : 'invvocno', type: 'String'},
     				{name : 'date', type: 'date'}, 
     				{name : 'fromdate',type:'date'},
     				{name : 'todate', type: 'date'}, 
     				{name : 'description', type: 'String'  },
     				{name : 'amount', type: 'number'  },
     				{name : 'tr_no',type:'number'}
     			],
                localdata: invdata,
                          	       
          
				
                
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
            $("#invoiceGrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 250,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                editable:true,
                showstatusbar:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			        	 	{ text: 'SL#', datafield: 'slno', width: '6%'  ,editable:false},
							{ text: 'Inv #', datafield: 'invdocno', width: '6%' ,hidden:true ,editable:false},
							{ text: 'TR_NO', datafield: 'tr_no', width: '6%' ,hidden:true ,editable:false},
							{ text: 'Inv #', datafield: 'invvocno', width: '8%' ,editable:false},
							{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'Description', datafield: 'description', width: '57%',editable:false},
							{ text: 'Amount', datafield: 'amount', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates:['sum']},
							
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            

            $('#invoiceGrid').on('rowdoubleclick', function (event) 
            		{ 
            		    var args = event.args;
            		    // row's bound index.
            		    var boundIndex = args.rowindex;
            		    // row's visible index.
            		    var visibleIndex = args.visibleindex;
            		    // right click.
            		    var rightclick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    
            		    var invdocno=$('#invoiceGrid').jqxGrid('getcellvalue',boundIndex,'invdocno');
            		    $('#invvocno').val($('#invoiceGrid').jqxGrid('getcellvalue',boundIndex,'invvocno'));
            		    $('#oldinvtrno').val($('#invoiceGrid').jqxGrid('getcellvalue',boundIndex,'tr_no'));
            		    $("#overlay, #PleaseWait").show(); 
            		    $('#invoicedetaillist').load('invoiceDetailGrid.jsp?invdocno='+invdocno+'&id=1');
            		    
            		});
        });
        
        
				       
                       
    </script>
    <div id="invoiceGrid"></div>
    <input type="hidden" id="invvocno" name="invvocno">
    <input type="hidden" id="oldinvtrno" name="oldinvtrno">