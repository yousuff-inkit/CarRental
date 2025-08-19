<%@page import="com.dashboard.limousine.limoinvoiceexport.ClsLimousineInvoiceExportDAO"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%
ClsLimousineInvoiceExportDAO dao=new ClsLimousineInvoiceExportDAO();
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");
String fromdate=request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"0":request.getParameter("todate");
%>
<style type="text/css">
    .redClass
    {
       background-color: #F1948A; 
    }
</style>
<script type="text/javascript">

var chk='<%=chk%>'; 
var databrand;
 if(chk>0){
	databrand='<%=dao.getGridData(chk,fromdate,todate)%>';
}else{
	
	databrand; 
	
} 
databrand;
	$(document).ready(function () { 
		
		 var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Net Total" + '</div>';
         }
   		var rendererstring=function (aggregates){
   			var value=aggregates['sum'];
   			return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">'  + value + '</div>';
   		}
   		
		
	       var source =
	       {
	           datatype: "json",
	           datafields: [
	                     	{name : 'doc_no' , type: 'number' },
							{name : 'voc_no', type: 'number'  },
							{name : 'invdocno', type: 'number'  },
							{name : 'brhid', type: 'number'  },
							{name : 'trno', type: 'number'  },
							{name : 'date', type: 'string'  },
							{name : 'ledgernote', type: 'string'  },
							{name : 'invoicenote', type: 'string'  },
							{name : 'jobname', type: 'string'  },
							{name : 'total', type: 'number'  },
							{name : 'discount', type: 'number'  },
							{name : 'nettotal', type: 'number'  },
							{name : 'tarif', type: 'number'  },
							{name : 'nighttarif', type: 'number'  },
							{name : 'exkmchg', type: 'number'  },
							{name : 'exhrchg', type: 'number'  },
							{name : 'exnighthrchg', type: 'number'  },
							{name : 'fuelchg', type: 'number'  },
							{name : 'parkingchg', type: 'number'  },
							{name : 'otherchg', type: 'number'  },
							{name : 'greetchg', type: 'number'  },
							{name : 'boquechg', type: 'number'  },
							{name : 'exkm', type: 'number'  },
							{name : 'exhr', type: 'number'  },
							{name : 'exnighthr', type: 'number'  },
							{name : 'fuel', type: 'number'  },
							{name : 'setvalue', type: 'number'  },
							{name : 'vatvalue', type: 'number'  },
							
	            ],
	          localdata: databrand,
	          pager: function (pagenum, pagesize, oldpagenum) {
	               // callback called when a page or page size is changed.
	           }
	       };
	       
	       var dataAdapter = new $.jqx.dataAdapter(source,
	       		 {
	           		loadError: function (xhr, status, error) {
	                  // alert(error);    
	                   }
		            }		
	       );
	       
	       var cellclassname =  function (row, column, value, data) {

				var posted=$('#jqxlimoinvoiceexportgrid').jqxGrid('getcellvalue', row, "invdocno");
				if(parseInt(posted)>0){
					return "redClass";
				}
			}

	       $("#jqxlimoinvoiceexportgrid").jqxGrid(
	               {
                       width: '99%',	
                       height: 500,
	                   source: dataAdapter,
	                   showfilterrow: true,
	                   showaggregates:true,
	                   showstatusbar:true,
	                   filterable: true,
	                   editable:true,
	                   enabletooltips:true,
	                   columnsresize: true,
	                   selectionmode: 'checkbox',
	                   //Add row method
	                   columns: [
	                	{ text: 'Sr. No', sortable: false,pinned:true,filterable: false, editable: false,
	                           groupable: false, draggable: false, resizable: false,datafield: '',
	                           columntype: 'number', width: '4%',cellclassname: cellclassname,cellsalign: 'center', align: 'center',
	                           cellsrenderer: function (row, column, value) {
	                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                     }},
	   					{ text: 'VOC No', datafield: 'voc_no',pinned:true, width: '6%',editable:false,cellclassname: cellclassname },
	   					{ text: 'TR No.', datafield: 'trno',pinned:true, width: '4%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Date', datafield: 'date',pinned:true, width: '6%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Ledger Note', datafield: 'ledgernote',pinned:true, width: '10%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Invoice Note', datafield: 'invoicenote',pinned:true, width: '10%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Job Name', datafield: 'jobname',pinned:true, width: '6%',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
	   					{ text: 'Total', datafield: 'total',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Discount', datafield: 'discount',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Tariff', datafield: 'tarif',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Night Tariff', datafield: 'nighttarif',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Ex. KM Charge', datafield: 'exkmchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Ex. Hr. Charge', datafield: 'exhrchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Ex. Night Hr. Charge', datafield: 'exnighthrchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Fuel Charge', datafield: 'fuelchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Parking Charge', datafield: 'parkingchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Other Charges', datafield: 'otherchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Greet Charge', datafield: 'greetchg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Baby Seat Charge', datafield: 'boquechg',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Extra KM', datafield: 'exkm',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Extra Hour', datafield: 'exhr',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Extra Night Hour', datafield: 'exnighthr',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Fuel', datafield: 'fuel',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Vat Value', datafield: 'vatvalue',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   	              ]
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       $('.page-loader').hide();
	      
	       
	       $('#jqxlimoinvoiceexportgrid').on('rowselect', function (event) {
	    	    var rowIndex = event.args.rowindex;
	    	    var rowData = $('#jqxlimoinvoiceexportgrid').jqxGrid('getrowdata', rowIndex);

	    	    if (rowData.invdocno>0) {  // or any condition you want
	    	        // Prevent selection
	    	        $('#jqxlimoinvoiceexportgrid').jqxGrid('unselectrow', rowIndex);
	    	    }
	    	});
	       
        });
	
	  
</script>  
<div id="jqxlimoinvoiceexportgrid" ></div> 

	