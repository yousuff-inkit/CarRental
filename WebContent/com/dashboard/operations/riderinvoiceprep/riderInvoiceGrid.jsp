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
	databrand='<%=dao.getGridDataExcel(docNo,brchid,chk,year,month)%>';
}else{
	
	databrand; 
	
} 
databrand;
	$(document).ready(function () { 
		
	       var source =
	       {
	           datatype: "json",
	           datafields: [
	                     	{name : 'rider_id' , type: 'number' },
							{name : 'rider_name', type: 'String'  },
							{name : 'pickupcnt', type: 'number'  },
	                     	{name : 'dropoffcnt', type: 'number'  },
	                     	{name : 'pickupcancl', type: 'number'  },
	                     	{name : 'dropoffcancl', type: 'number'  },
	                     	{name : 'evalutedhrs', type: 'number'  },
	                     	{name : 'distancepay', type: 'number'  },
	                     	{name : 'questpaid', type: 'number'  },
	                     	{name : 'ridertipspay', type: 'number'  },
	                     	{name : 'adminfeecom', type: 'number'  },
	                     	{name : 'operatorfeerider', type: 'number'  },
	                     	{name : 'total', type: 'number'  },
	                     	{name : 'total', type: 'number'  },
	                     	{name : 'vehicletype', type: 'number'  },
	                     	{name : 'eligiblemingrantee', type: 'number'  },
	                     	{name : 'telematics', type: 'number'  },
	                     	{name : 'extramobiledata', type: 'number'  },
	                     	{name : 'unpaiddispay', type: 'number'  },
	                     	{name : 'unpaidquest', type: 'number'  },
	                     	{name : 'unpaidincentive', type: 'number'  },
	                     	{name : 'unpaidtelematics', type: 'number'  },
	                     	{name : 'ev', type: 'number'  },
	                     	{name : 'inventorydeduction', type: 'number'  },
	                     	{name : 'custexpincentives', type: 'number'  },
	                     	{name : 'adjstfrmpastmonth', type: 'number'  },
	                     	{name : 'tphersincentive', type: 'number'  },
	                     	{name : 'dubspltincentive', type: 'number'  },
	                     	{name : 'coddeductions', type: 'number'  },
	                     	{name : 'orderissuedeductions', type: 'number'  },
	                     	{name : 'extrasimused', type: 'number'  },
	                     	{name : 'insurance', type: 'number'  },
	                     	{name : 'advance', type: 'number'  },
	                     	{name : 'rtaclass', type: 'number'  },
	                     	{name : 'labourcard', type: 'number'  },
	                     	{name : 'llogns', type: 'number'  },
	                     	{name : 'fineperformance', type: 'number'  },
	                     	{name : 'daysofwork', type: 'number'  },
	                     	{name : 'issrs', type: 'string'  }
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

	       $("#jqxtinting").jqxGrid(
	               {
                       width: '99%',	
                       height: 555,
	                   source: dataAdapter,
	                   showfilterrow: true,
	                   filterable: true,
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
	   					{ text: 'Rider Id', datafield: 'rider_id', width: '6%',editable:false },
	   					{ text: 'Name',datafield: 'rider_name',editable:false, width: '15%'},
	   					{ text: 'Days of Work', datafield: 'daysofwork',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Pickup Count', datafield: 'pickupcnt',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'DropOff Count', datafield: 'dropoffcnt',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Pickup Cancel', datafield: 'pickupcancl',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'DropOff Cancel', datafield: 'dropoffcancl',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Evaluted Hrs', datafield: 'evalutedhrs',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Distance Pay', datafield: 'distancepay',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Quest Paid', datafield: 'questpaid',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Rider Tips Paid', datafield: 'ridertipspay',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Admin Fee', datafield: 'adminfeecom',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Operator Fee Rider', datafield: 'operatorfeerider',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Total', datafield: 'total',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Vehicle Type', datafield: 'vehicletype',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Eligible Min Guarantee', datafield: 'eligiblemingrantee',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Telematics', datafield: 'telematics',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Extra Mobile Data', datafield: 'extramobiledata',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Unpaid Dis Pay', datafield: 'unpaiddispay',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Unpaid Incentive', datafield: 'unpaidincentive',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Unpaid Telematics', datafield: 'unpaidtelematics',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'EV', datafield: 'ev',cellsalign:'left',align:'right', width: '5%',editable:false },
	   					{ text: 'Inventory Deduction', datafield: 'inventorydeduction',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Customer experience incentives', datafield: 'custexpincentives',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Adjustments Past Month', datafield: 'adjstfrmpastmonth',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Top Heroes Incentive', datafield: 'tphersincentive',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Dubai Split incentive', datafield: 'dubspltincentive',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'COD Deductions', datafield: 'coddeductions',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Order Issue Dedctions', datafield: 'orderissuedeductions',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false },
	   					{ text: 'Extra Sim Used', datafield: 'extrasimused',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false ,columngroup:'deductions'},
	   					{ text: 'Insurance', datafield: 'insurance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions' },
	   					{ text: 'Advance', datafield: 'advance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions' },
	   					{ text: 'RTA Class', datafield: 'rtaclass',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions' },
	   					{ text: 'Labour Card', datafield: 'labourcard',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions' },
	   					{ text: 'Others', datafield: 'llogns',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions' },
	   					{ text: 'Fine Performance', datafield: 'fineperformance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,columngroup:'deductions'},
	   	              ], columngroups: 
		                     [
			                       { text: 'Deductions', align: 'center', name: 'deductions',width: '20%' },
			                     ] 
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       
        });
	
	  
</script>  
 
        <div id="jqxtinting" ></div> 

	