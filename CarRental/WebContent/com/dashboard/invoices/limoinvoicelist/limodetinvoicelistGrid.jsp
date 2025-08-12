 <%@page import="com.dashboard.invoices.limoinvoicelist.ClsLimoInvoiceListDAO"%>
 <%ClsLimoInvoiceListDAO dao=new ClsLimoInvoiceListDAO();%>                 
<% 
	String acno = request.getParameter("Accno")==null?"0":request.getParameter("Accno").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String fromdocno = request.getParameter("fromdocno")==null || request.getParameter("fromdocno")==""?"0":request.getParameter("fromdocno").trim();
	String todocno = request.getParameter("todocno")==null || request.getParameter("todocno")==""?"0":request.getParameter("todocno").trim();
	String branch = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 %> 
       
 
<script type="text/javascript">

var datas;

	datas='<%=dao.loadGrid(acno,fromdate,todate,fromdocno,todocno,branch)%>';
	<%-- datass='<%=dao.loadGridExcel(acno,fromdate,todate,fromdocno,todocno,branch)%>'; --%>
	      



$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
        if(typeof(value)=="undefined"){
     		value=0.00;
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }    

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                     {name : 'voc_no' , type: 'string' },
                      {name : 'doc_no' , type: 'string' },
                  		{name : 'date' , type: 'date' },
						{name : 'refname', type: 'String'  },
						{name : 'invoicenote', type: 'String'    },
						{name : 'mastervat', type: 'number'  },
						{name : 'mastertotal', type: 'number'  },
						{name : 'masternettotal', type: 'number'  },
						
						],
				    localdata: datas,
        
        
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
   
    
    
    $("#invlistdet").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow', 
        columnsresize: true,
        enabletooltips: true,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                        { text: 'Doc No', datafield: 'voc_no', width: '5%' },
                        { text: 'Doc No', datafield: 'doc_no', width: '5%',hidden:true },
						{ text: 'Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy'  },
						{ text: 'Client Name', datafield: 'refname', width: '30%'  },
						{ text: 'Description', datafield: 'invoicenote', width: '22%' },
						{ text: 'Total', datafield: 'mastertotal',width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Vat Total', datafield: 'mastervat',width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Net Total', datafield: 'masternettotal',  width: '10%' ,cellsformat:'d2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						
					]

    });
    $("#overlay, #PleaseWait").hide();

});

	
	
</script>
<div id="invlistdet"></div>