<%@page import="com.dashboard.operations.riderpayroll.ClsRiderPayrollDAO"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<%
String contextPath=request.getContextPath();
%>
<%
ClsRiderPayrollDAO dao=new ClsRiderPayrollDAO();
String docNo=request.getParameter("docNo")==null?"0":request.getParameter("docNo");
String brchid=request.getParameter("brchid")==null?"0":request.getParameter("brchid");
String chk=request.getParameter("chk")==null?"0":request.getParameter("chk");
String year=request.getParameter("year")==null?"0":request.getParameter("year");
String month=request.getParameter("month")==null?"0":request.getParameter("month");
System.out.println("on jsp");
%>
<style type="text/css">
    .redClass
    {
       background-color: #F1948A; 
    }
</style>
<script type="text/javascript">

var docNo='<%=docNo%>'; 
var brchid='<%=brchid%>'; 
var chk='<%=chk%>'; 
var databrand;
 if(parseInt(docNo)>=0){
	databrand='<%=dao.getGridData(docNo,brchid,chk,year,month)%>';
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
	                     	{name : 'rider_id' , type: 'number' },
	                     	{name : 'doc_no' , type: 'number' },
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
	                     	{name : 'vehicletype', type: 'string'  },
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
	                     	{name : 'netsalary', type: 'number'  },
	                     	{name : 'fine', type: 'number'  },
	                     	{name : 'ofine', type: 'number'  },
	                     	{name : 'salik', type: 'number'  },
	                     	{name : 'osalik', type: 'number'  },
	                     	{name : 'totdeductions', type: 'number'  },
	                     	{name : 'salaries', type: 'number'  },
	                     	{name : 'nsalary', type: 'number'  },
	                     	{name : 'issrs', type: 'string'  },
	                     	{name : 'year', type: 'string'  },
	                     	{name : 'month', type: 'string'  },
	                     	{name : 'adjustments', type: 'number'  },
	                     	{name : 'prevadjustment', type: 'number'  },
	                     	{name : 'remarks', type: 'string'  },
	                     	{name : 'reason', type: 'string'  },
	                     	{name : 'acno', type: 'string'  },
	                     	{name : 'acid', type: 'string'  },
	                     	{name : 'curid', type: 'string'  },
	                     	{name : 'rate', type: 'string'  },
	                     	{name : 'brhid', type: 'string'  },
	                     	{name : 'ispayroll', type: 'number'  },
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

				var posted=$('#jqxriderpayroll').jqxGrid('getcellvalue', row, "ispayroll");
				if(parseInt(posted)>0){
					return "redClass";
				}
			}

	       $("#jqxriderpayroll").jqxGrid(
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
	   					{ text: 'Rider Id', datafield: 'rider_id',pinned:true, width: '6%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Employee A/C', datafield: 'acid',pinned:true, width: '6%',editable:false,cellclassname: cellclassname },
	   					{ text: 'Name',datafield: 'rider_name',editable:false, pinned:true,width: '15%',aggregates: ['sum1'],aggregatesrenderer:rendererstring1,cellclassname: cellclassname},
	   					{ text: 'Vehicle Type', datafield: 'vehicletype',cellsalign:'left',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
	   					{ text: 'Pickup Count', datafield: 'pickupcnt',cellsalign:'left',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'DropOff Count', datafield: 'dropoffcnt',cellsalign:'left',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
	   					{ text: 'Pickup Cancel', datafield: 'pickupcancl',cellsalign:'left',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname },
	   					{ text: 'DropOff Cancel', datafield: 'dropoffcancl',cellsalign:'left',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Total', datafield: 'total',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'COD Deductions', datafield: 'coddeductions',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Order Issue Dedctions', datafield: 'orderissuedeductions',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: cellclassname},
	   					{ text: 'Salaries - COD & OID', datafield: 'salaries',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Actual Fine', datafield: 'ofine',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Actual Salik', datafield: 'osalik',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Fine', datafield: 'fine',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Salik', datafield: 'salik',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Extra Sim Used', datafield: 'extrasimused',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Insurance', datafield: 'insurance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Advance', datafield: 'advance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Negative Salary', datafield: 'nsalary',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'RTA Class', datafield: 'rtaclass',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Labour Card', datafield: 'labourcard',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Others', datafield: 'llogns',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Fine Performance', datafield: 'fineperformance',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Total Deduction', datafield: 'totdeductions',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Prev. Adjustments', datafield: 'prevadjustment',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Adjustments', datafield: 'adjustments',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:true,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Net Salary', datafield: 'netsalary',cellsformat:'d2',cellsalign:'right',align:'right', width: '5%',editable:false,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellclassname: cellclassname},
	   					{ text: 'Remarks', datafield: 'remarks', width: '5%',editable:true,cellclassname: cellclassname},
	   					{ text: 'Reason', datafield: 'reason', width: '5%',editable:true,cellclassname: cellclassname},
	   					{ text: " ", datafield: "action", width: '5%', editable:false, cellsrenderer: function (row, column, value) {
	   			              return `<button style="height:83%; width:95%; margin:3% 3%">Update</button>`;
	   			            }
	   			        }
	   	              ]
	               });
	      
	       $("#overlay, #PleaseWait").hide();
	       
	       $('#jqxriderpayroll').on('cellvaluechanged', function (event){ 
	    	    var args = event.args;
			    var boundIndex = event.args.rowindex;
			    var dataField = args.datafield;
			    var rowData = $('#jqxriderpayroll').jqxGrid('getrowdata', boundIndex);
			    
			    if(dataField==='llogns' || dataField === 'fine' || dataField === 'salik'|| dataField === 'extrasimused'||dataField === 'insurance'||dataField === 'advance'||dataField === 'nsalary'||dataField === 'rtaclass'||dataField === 'labourcard'||dataField === 'fineperformance')
			    { 
			    	let rcoddeductions=rowData.coddeductions;
				    let rorderissuedeductions=rowData.orderissuedeductions;
				    let rfine=rowData.fine;
				    let rsalik=rowData.salik;
				    let rextrasimused=rowData.extrasimused;
				    let rinsurance=rowData.insurance;
				    let radvance=rowData.advance;
				    let rnsalary=rowData.nsalary;
				    let rrtaclass=rowData.rtaclass;
				    let rfineperformance=rowData.fineperformance;
				    let rlabourcard=rowData.labourcard;
				    let rllogns=rowData.llogns;
				    let rprevadjustment=rowData.prevadjustment;
				    let radjustments=rowData.adjustments;
				    let total=rowData.total;
				    
				   // console.log(rcoddeductions+rorderissuedeductions+rfine+rsalik+rextrasimused+rinsurance+radvance+rnsalary);
				    
				  //  console.log((rcoddeductions+rorderissuedeductions+rfine+rsalik+rextrasimused+rinsurance+radvance+rnsalary+rrtaclass+rfineperformance+rlabourcard));
				    $("#jqxriderpayroll").jqxGrid('setcellvalue', boundIndex, 'totdeductions', (rfine+rsalik+rextrasimused+rinsurance+radvance+rnsalary+rrtaclass+rfineperformance+rlabourcard+rllogns) );
				    $("#jqxriderpayroll").jqxGrid('setcellvalue', boundIndex, 'netsalary', total-(rcoddeductions+rorderissuedeductions+rfine+rsalik+rextrasimused+rinsurance+radvance+rnsalary+rrtaclass+rfineperformance+rlabourcard+rllogns+rprevadjustment-radjustments) );
			    }	
			    
		   });
	      
	       $('#jqxriderpayroll').on('celldoubleclick', function (event){ 
	    	    var args = event.args;
			    var boundIndex = event.args.rowindex;
			    var dataField = args.datafield;
			    var rowData = $('#jqxriderpayroll').jqxGrid('getrowdata', boundIndex);
			    let acno=rowData.acno;
			    let name=rowData.rider_name;
	    	    funsetpanel(acno,name)
					
		   });
	       
	       
	       $('#jqxriderpayroll').on('cellclick', function (event) 
					{ 
					    var args = event.args;
					    var boundIndex = event.args.rowindex;
					    var dataField = args.datafield;
					    var rowData = $('#jqxriderpayroll').jqxGrid('getrowdata', boundIndex);
					    
					    if (dataField === 'action') {
					    	if(rowData.ispayroll>0){
						    	Swal.fire({
									  title: "Warning",
									  text: "Payroll has alredy been posted!",
									  icon: "error"
									});
						    	return false;
						    } else {
						    	Swal.fire({
						    		  title: "Are you sure?",
						    		  text: "Update the data",
						    		  icon: "warning",
						    		  showCancelButton: true,
						    		  confirmButtonColor: "#3085d6",
						    		  cancelButtonColor: "#d33",
						    		  confirmButtonText: "Update"
						    		}).then((result) => {
						    		  if (result.isConfirmed) {
						    			 // alert(rowData.reason);
									      funupdateremarks(rowData.month,rowData.year,rowData.remarks,rowData.adjustments,rowData.doc_no,rowData.fine,rowData.salik,rowData.extrasimused,rowData.insurance,rowData.advance,rowData.nsalary,rowData.rtaclass,rowData.fineperformance,rowData.labourcard,rowData.llogns,rowData.reason);
						    		  }
						    		});
						    }
					    	
					    }
				       
					});
	       
        });
	
	  
</script>  
<div id="jqxriderpayroll" ></div> 

	