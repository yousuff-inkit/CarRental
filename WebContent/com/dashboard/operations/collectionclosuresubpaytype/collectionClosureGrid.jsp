<%@ page import="com.dashboard.operations.collectionclosuresubpaytype.ClsCollectionClosureDAO" %>
<% ClsCollectionClosureDAO cod=new ClsCollectionClosureDAO(); %>


<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
      String payas = request.getParameter("payas")==null?"0":request.getParameter("payas").trim();
       String status = request.getParameter("status")==null?"0":request.getParameter("status").trim();
        String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();%>

<style type="text/css">
	  .cashClass
	  {
	      background-color: #FBEFF5;
	  }
	  .cardClass
	  {
	      background-color: #E0F8F1;
	  }
	   .chequeClass
	  {
	      background-color: #ECE0F8;
	  }
</style>

<script type="text/javascript">
      var data1;
      var temp='<%=branchval%>';
      
	  	if(temp!='NA'){ 
	  		   data1='<%=cod.collectionClosureGridLoading(branchval,fromDate, toDate,payas,status,cldocno)%>';         
		<%-- 	   var dataExcelExport='<%=cod.collectionClosureGridExcelExport(branchval,fromDate, toDate,payas,status,cldocno)%>';
	  	 --%>
	  	}
	  	         
        $(document).ready(function () {
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [ 
                    { name: 'salmn', type: 'String' },
                    { name: 'pdocno', type: 'String' },
                	{ name: 'ptype', type: 'String' },  
					{ name: 'branch', type: 'String' },
					{ name: 'rdocno', type: 'int' },
					{ name : 'date', type: 'date' },
					{ name: 'dtype', type: 'String' },
                    { name: 'srno', type: 'int' },
                    { name: 'refname', type: 'String' },
                    { name: 'payas', type: 'String' },
                    { name: 'rano', type: 'int' },
                    { name: 'cashtotal', type: 'number' },
                    { name: 'cardtotal', type: 'number' },
                    { name: 'chequetotal', type: 'number' },
                    { name : 'agmtopndate', type: 'date' },
                    { name: 'uber', type: 'number' },
                    { name: 'careem', type: 'number' },
                    { name: 'voucher', type: 'number' },

	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#collectionClosure").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                showfilterrow:true,
                columnsresize :true,
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                enabletooltips:true, 
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
								},
						{ text: 'Branch', datafield: 'branch', width: '8%' },
						{ text: 'Doc No', datafield: 'rdocno', width: '7%' },
						{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
						{ text: 'Doc Type', datafield: 'dtype', width: '5%' },
	                    { text: 'RRV No.', datafield: 'srno', width: '7%' },   
	                    { text: 'Client', datafield: 'refname', width: '18%' },
	                    { text: 'Paid As', datafield: 'payas', width: '11%' },                
	                    { text: 'Salesman', datafield: 'salmn', width: '14%' },
	                    { text: 'Posted Docno', datafield: 'pdocno', width: '7%' },       
	                    { text: 'Posted Type', datafield: 'ptype', width: '8%' },
	                    { text: 'Agreement', datafield: 'rano', width: '12%' , aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
	                    { text: 'Agmt.Opn.Date', datafield: 'agmtopndate', cellsformat: 'dd.MM.yyyy' , width: '8%' },
	                    { text: 'Cash Total', datafield: 'cashtotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cashClass'  },
	                    { text: 'Card Total', datafield: 'cardtotal', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'cardClass' },
	                    { text: 'Uber', datafield: 'uber', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass',columngroup:'chequetotal'  },
	                    { text: 'Careem', datafield: 'careem', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass',columngroup:'chequetotal'  },
	                    { text: 'Voucher', datafield: 'voucher', width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right' , aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'chequeClass',columngroup:'chequetotal'  },

					 ], columngroups: 
	                     [
		                       { text: 'Cheque Total', align: 'center', name: 'chequetotal',width: '20%' },
		                      ]

            });
            
            if(temp=='NA'){
                $("#collectionClosure").jqxGrid("addrow", null, {});
            }
            $("#overlay, #PleaseWait").hide();
            
            var cashtotal1="";var cardtotal1="";var chequetotal1="",ubertotal1="",careemtotal1="",vouchertotal1="";var netamount="";
            var cashtotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'cashtotal', ['sum'], true);
            cashtotal1=cashtotal.sum;
            var cardtotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'cardtotal', ['sum'], true);
            cardtotal1=cardtotal.sum;
            var ubertotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'uber', ['sum'], true);
            ubertotal1=ubertotal.sum;
            var careemtotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'careem', ['sum'], true);
            careemtotal1=careemtotal.sum;
            var vouchertotal=$('#collectionClosure').jqxGrid('getcolumnaggregateddata', 'voucher', ['sum'], true);
            vouchertotal1=vouchertotal.sum;
            
            chequetotal1=parseFloat(ubertotal1)+parseFloat(careemtotal1)+parseFloat(vouchertotal1);
            if(!isNaN(cashtotal1 || cardtotal1 || chequetotal1)){
            	netamount= parseFloat(cashtotal1) + parseFloat(cardtotal1) + parseFloat(chequetotal1);
      		    funRoundAmt(netamount,"txtnetamount");
      		  }
      		else{
		    	 $('#txtnetamount').val(0.00);
		    }

        });

</script>
<div id="collectionClosure"></div>
