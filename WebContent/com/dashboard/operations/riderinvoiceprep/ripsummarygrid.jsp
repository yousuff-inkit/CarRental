<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%@page import="com.dashboard.operations.riderinvoiceprep.ClsRiderInvoiceImportDAO"%>
<%
ClsRiderInvoiceImportDAO dao=new ClsRiderInvoiceImportDAO();
String docNo=request.getParameter("docNo")==null?"0":request.getParameter("docNo");
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid");
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");
String year=request.getParameter("year")==null?"0":request.getParameter("year");
String month=request.getParameter("month")==null?"0":request.getParameter("month");
System.out.println("on jsp");
%>


<script type="text/javascript">

var docNo='<%=docNo%>'; 
var brchid='<%=brchid%>'; 
var chk='<%=chk%>'; 
var databrand;
 if(parseInt(docNo)>=0){
	databrand='<%=dao.getSummaryData(brchid,chk,year,month)%>';
}else{
	
	databrand; 
	
} 
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
	                     	{name : 'description' , type: 'String' },
							{name : 'grossamount', type: 'number'  },
							{name : 'vat', type: 'number'  },
							{name : 'isvat', type: 'number'  },
							{name : 'vatper', type: 'number'  },
							{name : 'netamount', type: 'number'  },
							{name : 'id', type: 'number'  },
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

	       $("#jqxripsummary").jqxGrid(
	               {
                       width: '98%',	
                       height: 380,
	                   source: dataAdapter,
	                   showaggregates:true,
	                   showstatusbar:true,
	                   showfilterrow: false,
	                   filterable: false,
	                   editable:true,
	                   enabletooltips:true,
	                   columnsresize: true,
	                   selectionmode: 'singlerow',
	                   //Add row method
	                   columns: [
	                	{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
	                           groupable: false, draggable: false, resizable: false,datafield: '',
	                           columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
	                           cellsrenderer: function (row, column, value) {
	                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                     }},
	   					{ text: 'Item & Description', datafield: 'description', width: '40%',editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1},
	   					{ text: 'Gross Amount',datafield: 'grossamount', cellsformat:'d2',editable:true,cellsalign:'right',align:'right', width: '18%',aggregates: ['sum'],aggregatesrenderer:rendererstring},
	   					{ text: 'VAT', datafield: 'vat',cellsformat:'d2',cellsalign:'right' ,align:'right' ,width: '18%', editable:false ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
	   					{ text: 'Net Amount', datafield: 'netamount',cellsformat:'d2',cellsalign:'right' ,align:'right' ,width: '20%', editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring},
	   	              ]
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       
	       $("#jqxripsummary").on('cellvaluechanged', function (event) {
	    	   
	    	// event arguments.
               var args = event.args;
               // column data field.
               var dataField = event.args.datafield;
               // row's bound index.
               var rowBoundIndex = event.args.rowindex;
               
               var ga = $('#jqxripsummary').jqxGrid('getcellvalue',rowBoundIndex,'grossamount');
               var vat = $('#jqxripsummary').jqxGrid('getcellvalue',rowBoundIndex,'vat');
               var total =  $('#jqxripsummary').jqxGrid('getcellvalue',rowBoundIndex,'netamount');
               var isvat = $('#jqxripsummary').jqxGrid('getcellvalue',rowBoundIndex,'isvat');
               var vatper = $('#jqxripsummary').jqxGrid('getcellvalue',rowBoundIndex,'vatper');
               if(dataField=="grossamount"){
            	  if(isvat==1){
	            	 vat = ga*(vatper/100);
            	  } else {
            		 vat = 0; 
            	  }
            	 total = ga+vat
            	 $("#jqxripsummary").jqxGrid('setcellvalue', rowBoundIndex, 'vat', vat);
            	 $("#jqxripsummary").jqxGrid('setcellvalue', rowBoundIndex, 'netamount', total);
               }
               
               if(dataField=="netamount"){
            	 if(isvat==1){
            		 ga = total/(1+(vatper/100));
            		 vat = ga*(vatper/100);
            	 }  else {
            		 ga = total;
            		 vat=0;
            	 }
              	 $("#jqxripsummary").jqxGrid('setcellvalue', rowBoundIndex, 'grossamount', ga);
              	 $("#jqxripsummary").jqxGrid('setcellvalue', rowBoundIndex, 'vat', vat);
                 }
              
               
	       });
	       
        });	  
</script>  
<div id="jqxripsummary" ></div> 

	