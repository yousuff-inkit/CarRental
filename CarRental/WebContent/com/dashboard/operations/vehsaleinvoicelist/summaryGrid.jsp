<%@page import="com.dashboard.operations.vehsaleinvoicelist.ClsVehSaleInvoiceListDAO"%>
<%ClsVehSaleInvoiceListDAO DAO= new ClsVehSaleInvoiceListDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
//     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
   %>
     <% String contextPath=request.getContextPath();%>
<script type="text/javascript">
      var data2;
      var summaryexceldata;
      var temp='<%=check%>';
     <%--  var temp1='<%=type%>'; --%>
    //  alert(temp);
	  	if(temp!='0'){ 
	  		   data2='<%=DAO.summary(branchval, fromDate, toDate,check)%>';
	  		 <%-- summaryexceldata='<%=DAO.summaryexcel(branchval, fromDate, toDate)%>'; --%>
	  	}
	  	
  	
        $(document).ready(function () {
        	var rendererstring=function (aggregates){
             	var value=aggregates['sum'];
             	if(value=="" || value==null || value=="undefined" || typeof(value)=="undefined"){
             		value=0.0;
             	}
             	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
        	}
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no' , type: 'int' },
							{name : 'date' , type: 'date' },
							{name : 'client' , type:'string'},
							{name : 'desc' , type:'string'},
							{name : 'type' , type:'string'},
							{name : 'total' , type:'number'},
							{name : 'vat',type:'number'},
							{name : 'taxtotal',type:'number'}
					      ],
                          localdata: data2,
               
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
            $("#summary").jqxGrid(
            {
                width: '98%',
                height: 550,
                source: dataAdapter,
                rowsheight:25,
                showaggregates:true,
                showstatusbar:true,
                showfilterrow:true,
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                //localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no',  width: '6%' },
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '8%' },
							{ text: 'Client',  datafield: 'client' },
							
							{ text: 'Description',  datafield: 'desc',  width: '25%' },
							{ text: 'Type',  datafield: 'type',   width: '8%'  },
							{ text: 'Total', datafield:'total', width:'10%',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'VAT', datafield:'vat', width:'10%',cellsalign:'right',align:'right' ,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Net Total', datafield:'taxtotal', width:'10%',cellsalign:'right',align:'right' ,cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
							
						 ]
            });
            
            if(temp=='NA'){
                $("#summary").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
           

        });

</script>
<div id="summary"></div>
