<%@ page import="com.dashboard.operations.invoiceauditing.*"  %>
<%
	String invdocno = request.getParameter("invdocno")==null?"":request.getParameter("invdocno").trim();
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
	var invdetdata=[];
	if(id=="1"){
		 invdetdata='<%=dao.getInvoiceDetailData(invdocno,id)%>';
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
     				{name : 'units', type: 'string'  },
     				{name : 'amount', type: 'number'  },
     				{name : 'auditamt', type: 'number'  },
     				{name : 'acno',type:'number'},
     				{name : 'idno',type:'number'}
     			],
                localdata: invdetdata,
                          	       
          
				
                
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
            $("#invoiceDetailGrid").jqxGrid(
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
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                
     					
			         columns: [
			        	 	{ text: 'SL#', datafield: 'slno', width: '6%'  ,editable:false},
							{ text: 'Inv #', datafield: 'invdocno', width: '6%' ,hidden:true ,editable:false},
							{ text: 'Acno', datafield: 'acno', width: '6%' ,hidden:true ,editable:false},
							{ text: 'Ac.ID No', datafield: 'idno', width: '6%' ,hidden:true ,editable:false},
							{ text: 'Inv #', datafield: 'invvocno', width: '8%' ,editable:false},
							{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'From Date', datafield: 'fromdate', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'To Date', datafield: 'todate', width: '7%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'Description', datafield: 'description', width: '39%',editable:false},
							{ text: 'Units', datafield: 'units', width: '10%',editable:false},
							{ text: 'Amount', datafield: 'amount', width: '8%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',aggregates:['sum']},
							{ text: 'Audit Amount', datafield: 'auditamt', width: '8%' ,editable:true,cellsformat:'d2',cellsalign:'right',align:'right',aggregates:['sum']},
							
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
        });
        
        
				       
                       
    </script>
    <div id="invoiceDetailGrid"></div>