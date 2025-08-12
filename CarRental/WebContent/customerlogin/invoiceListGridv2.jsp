<%@page import="customerlogin.ClsCustomerLoginDAO"%>
<% String contextPath=request.getContextPath();%>
<%
String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();  
String hidinvmonth = request.getParameter("hidinvmonth")==null?"0":request.getParameter("hidinvmonth").trim();
String hidinvyr = request.getParameter("hidinvyr")==null?"0":request.getParameter("hidinvyr").trim();
String chkbetweendates = request.getParameter("chkbetweendates")==null?"0":request.getParameter("chkbetweendates").trim();
String chkinvmonthyear = request.getParameter("chkinvmonthyear")==null?"0":request.getParameter("chkinvmonthyear").trim();

ClsCustomerLoginDAO cild=new ClsCustomerLoginDAO();
%>
 
<style type="text/css">
	.yellowClass{
    	background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
    }
</style>
<script type="text/javascript">
var id='<%=id%>';
var invoicedatav2;  
if(id=="1"){
	invoicedatav2='<%=cild.invoicelistv2(fromDate,toDate,acno,id,hidinvmonth,hidinvyr,chkinvmonthyear,chkbetweendates)%>'; 
}

var invhtml='';
var tot=0.0;
var testamt=0.0;

$.each(JSON.parse(invoicedatav2),function(index,value){
	
	
	formamount= (Math.round(value.amount * 100) / 100).toFixed(2);
	formamount= formamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	
	
	invhtml+='<tr>';
	invhtml+='<td data-docno='+value.docno+'>'+value.docno+'</td>';
	invhtml+='<td>'+value.branch+'</td>';
	invhtml+='<td >'+value.vocno+'</td>';
	invhtml+='<td>'+value.date+'</td>';
	invhtml+='<td>'+value.types+'</td>';
	invhtml+='<td>'+value.remarks+'</td>';
	invhtml+='<td align="right">'+formamount+'</td>';
	invhtml+='<td align="center" width="10%" >';
	invhtml+='<div class="btn-group">';
	invhtml+='<button type="button" class="btn btn-default dropdown-toggle btn-table-dropdown" data-toggle="dropdown">';
	invhtml+='<span class="caret"></span>';
	invhtml+='</button>';
	var det=value.det;
	$.each(det,function(index,jsonObject){
		invhtml+='<ul class="dropdown-menu dropdown-menu-right" role="menu" style="width:300px;" id="invdetid" data-docno='+value.docno+'>';
		
		$.each(jsonObject,function(key,value){
	invhtml+='<li><a href="#"> '+key+' <span class="pull-right"><strong>'+value+'</strong></span></a></li>';
	
		});
		invhtml+='</ul>';
	});
	invhtml+='</div>';
	invhtml+='</td>';

	invhtml+='</tr>';
	
   /*  testamt=value.amount;
	testamt=parseFloat(testamt.replace(/,/g,''));
 */
	if(value.amount=="" || value.amount==null){
		tot+=0.0; 
		 
		 
	 }else{
		// tot+=parseFloat(testamt);
		 tot+=parseFloat(value.amount);
		 
		
	 }
});

tot= (Math.round(tot * 100) / 100).toFixed(2);
tot= tot.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");


invhtml+='<tr>';
invhtml+='<td></td>';
invhtml+='<td></td>';
invhtml+='<td></td>';
invhtml+='<td></td>';
invhtml+='<td></td>';
invhtml+='<td><strong>Total Amount</strong></td>';
invhtml+='<td align="right"><strong>'+tot+'</strong></td>';
invhtml+='</tr>';

$('.tbl-ivlist tbody').html($.parseHTML(invhtml));

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    {name : 'docno' , type: 'number' },
                  	{name : 'branch', type: 'String'    },
                  	{name : 'brhid',type:'number'},
                  	{name : 'vocno' , type: 'number' },
					{name : 'date', type: 'date'  },
					{name : 'types', type: 'String'  },
					{name : 'remarks', type: 'string'  },
			        {name : 'amount', type: 'number'  }
						
						
						],
				    localdata: invoicedatav2,
        
        
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
    
    
   /* $("#invoiceListGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       	sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, 
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                        { text: 'Doc No', datafield: 'docno', width: '10%',hidden:true},
                        { text: 'Branch', datafield: 'branch', width: '15%'},  			
						{ text: 'Branch Id', datafield: 'brhid', width: '10%',hidden:true},  						
      					{ text: 'Doc No', datafield: 'vocno', width: '7%' },
      					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
 						{ text: 'Type', datafield: 'types', width: '8%'},
						{ text: 'Remarks', datafield: 'remarks', width: '47%'},
						{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
					]

    });*/

    $("#overlay, #PleaseWait").hide();
    
<%--     $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
	// create context menu
 	var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 50, autoOpenPopup: false, mode: 'popup'});
	$("#invoiceListGrid").on('contextmenu', function () {
   		return false;
	});
	
 	$("#Menu2").on('itemclick', function (event) {
  		var args = event.args;
     	var rowindex = $("#invoiceListGrid").jqxGrid('getselectedrowindex');
     	if ($.trim($(args).text()) == "Print") {
         	var vocno=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"vocno");
         	var brhid=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"brhid");
         	var win= window.open("<%=contextPath%>/com/operations/commtransactions/invoice/printManualInvoice?tono="+vocno+"&fromno="+vocno+"&branch="+brhid+"&printdocno=&hidheader=1&chkdeletedinvprint=0&bankdocno=","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes")
			win.focus();
			win.print();
   		}
   		else if($.trim($(args).text()) == "View Attachments"){
   			var dtype="INV";
   			var frmname=funGetFormname(dtype);
            var docno=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"vocno");
            var brhid=$("#invoiceListGrid").jqxGrid("getcellvalue",rowindex,"brhid");
           	var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+dtype+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
			myWindow.focus();
        }
	});
	$("#invoiceListGrid").on('rowclick', function (event) {
    	if (event.args.rightclick) {
  			$("#invoiceListGrid").jqxGrid('selectrow', event.args.rowindex);
        	var scrollTop = $(window).scrollTop();
        	var scrollLeft = $(window).scrollLeft();
        	contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
        	return false;
		}
	}); --%>
});

	
	
</script>
<!-- <div id='jqxWidget2'>
    <div id="invoiceListGrid"></div>
    <div id="popupWindow2">
		<div id='Menu2'>
        	<ul>
            	<li>Print</li>
            	<li>View Attachments</li>
        	</ul>
       	</div>
   	</div>
</div>
 -->

