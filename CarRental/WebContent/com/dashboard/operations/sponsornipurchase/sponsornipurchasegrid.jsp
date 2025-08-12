<%@page import="com.dashboard.operations.sponsornipurchase.ClsSponsorNIPurchaseDAO"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%
ClsSponsorNIPurchaseDAO dao=new ClsSponsorNIPurchaseDAO();
String date=request.getParameter("date")==null?"0":request.getParameter("date");
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");
%>
<style type="text/css">
    .redClass
    {
       background-color: #F1948A; 
    }
</style>
<script type="text/javascript">

var date='<%=date%>'; 
var chk='<%=chk%>'; 
var databrand;
 if(chk>0){
	databrand='<%=dao.getNIData(date,chk)%>';
}else{
	
	databrand; 
	
} 
databrand;
	$(document).ready(function () { 
	       var source =
	       {
	           datatype: "json",
	           datafields: [
	           				{name : 'riderid' , type: 'number' },
	                     	{name : 'doc_no' , type: 'number' },
							{name : 'empname', type: 'String'  },
							{name : 'empdocno', type: 'number'  },
							{name : 'saldocno', type: 'number'  },
							{name : 'empmobile', type: 'String'  },
	                     	{name : 'empdesig', type: 'String'  },
	                     	{name : 'empid', type: 'number'  },
	                     	{name : 'vendorid', type: 'number'  },
	                     	{name : 'vendor', type: 'String'  },
	                     	{name : 'cartotal', type: 'number'  },
	                     	{name : 'putot', type: 'number'  },
	                     	{name : 'dotot', type: 'number'  },
	                     	{name : 'puctot', type: 'number'  },
	                     	{name : 'doctot', type: 'number'  },
	                     	{name : 'pickupcount', type: 'number'  },
							{name : 'dropoffcount', type: 'number'  },
							{name : 'daysofwork', type: 'number'  },
							{name : 'pickupcancel', type: 'number'  },
							{name : 'dropoffcancel', type: 'number'  },
							{name : 'carrate', type: 'number'  },
							{name : 'pickupratebike', type: 'number'  },
							{name : 'droppoffratebike', type: 'number'  },
							{name : 'isposted', type: 'number'  },
							{name : 'taxper', type: 'string'  },
	 						{name : 'curid', type: 'string'  },
	 						{name : 'rate', type: 'string'  },
	 						{name : 'acno', type: 'string'  },
	 						{name : 'acc_no', type: 'string'  },
	 						{name : 'vehicletype', type: 'string'  },
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
	    	   var posted=$('#jqxsponsornipgrid').jqxGrid('getcellvalue', row, "isposted");
				if(parseInt(posted)>0){
					return "redClass";
				}
			}

	       $("#jqxsponsornipgrid").jqxGrid(
	               {
                       width: '99%',	
                       height: 500,
	                   source: dataAdapter,
	                   showfilterrow: true,
	                   filterable: true,
	                   editable:true,
	                   enabletooltips:true,
	                   columnsresize: true,
	                   selectionmode: 'checkbox',
	                   //Add row method
	                   columns: [
	                	{ text: 'Sr. No', sortable: false,pinned:true,filterable: false, editable: false,
	                           groupable: false, draggable: false, resizable: false,datafield: '',
	                           columntype: 'number', width: '3%',cellclassname: cellclassname,cellsalign: 'center', align: 'center',
	                           cellsrenderer: function (row, column, value) {
	                            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
	                     }},
	   					{ text: 'Rider Id', datafield: 'riderid', width: '4%',editable:false,pinned:true,cellclassname: cellclassname},
	   					{ text: 'Employee ID', datafield: 'empid', width: '4%',editable:false,pinned:true,cellclassname: cellclassname},
	   					{ text: 'Employee Name', datafield: 'empname', width: '15%',editable:false,pinned:true,cellclassname: cellclassname},
	   					{ text: 'Vehicle Type', datafield: 'vehicletype', width: '5%',editable:false,pinned:true,cellclassname: cellclassname},
	   					{ text: 'Vendor', datafield: 'vendor', width: '10%',editable:false,pinned:true,cellclassname: cellclassname},
	   					{ text: 'Pickup Count', datafield: 'pickupcount', width: '4%',editable:false,cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Dropoff Count', datafield: 'dropoffcount', width: '4%',editable:false,cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Pickup Cancel', datafield: 'pickupcancel', width: '4%',editable:false,cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Drop off Cancel', datafield: 'dropoffcancel', width: '5%',editable:false,cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Days Of Work', datafield: 'daysofwork', width: '4%',editable:false,cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Monthly Rate(Car)', datafield: 'carrate', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Pickup Rate(Bike)', datafield: 'pickupratebike', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Drop off Rate(Bike)', datafield: 'droppoffratebike', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Total(Car)', datafield: 'cartotal', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Total (Bike-Pickup)', datafield: 'putot', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Total (Bike-Dropoff)', datafield: 'dotot', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Total (Bike-Pickup Cancel)', datafield: 'puctot', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   					{ text: 'Total (Bike-Dropoff Cancel)', datafield: 'doctot', width: '5%',editable:false,cellsformat:'d2',cellsalign:'right',align:'right',cellclassname: cellclassname},
	   	              ]
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       $('.page-loader').hide();
	       
	       $("#jqxsponsornipgrid").on('rowselect rowunselect', function (event) {

	    	// Get actual row ID using visual index
	    	    var rowId = $('#jqxsponsornipgrid').jqxGrid('getrowid', event.args.rowindex);
	    	    
	    	    // Safely get row data by ID
	    	    var confrowData = $('#jqxsponsornipgrid').jqxGrid('getrowdatabyid', rowId);
	    	    if (confrowData.isposted=='1') {
	    	        $('#jqxsponsornipgrid').jqxGrid('unselectrow', event.args.rowindex);
	    	    }
	    	    
	    	   const selectedRowIndexes = $("#jqxsponsornipgrid").jqxGrid('getselectedrowindexes');
	    	    if (selectedRowIndexes.length === 0) return;
	    	    
	    	   
	    	    const columnName = 'vendorid'; // replace with your column datafield
	    	    const firstValue = $("#jqxsponsornipgrid").jqxGrid('getrowdata', selectedRowIndexes[0])[columnName];

	    	    const allSame = selectedRowIndexes.every(index => {
	    	        const rowData = $("#jqxsponsornipgrid").jqxGrid('getrowdata', index);
	    	        return rowData[columnName] === firstValue;
	    	    });

	    	    if (!allSame) {
	    	    	 Swal.fire({
	    	    		icon:'warning',
  	   					type: 'fail',
  	   				  	title: 'Warning',  
  	   				  	text: 'Different Vendors are Not Allowed '
  	   				});
	    	        // Deselect the newly selected row to revert selection
	    	        const currentRowIndex = event.args.rowindex;
	    	        $("#jqxsponsornipgrid").jqxGrid('unselectrow', currentRowIndex);
	    	    }
	    	});
	       
	     	       
        });
	
	  
</script>  
<div id="jqxsponsornipgrid" ></div> 

	