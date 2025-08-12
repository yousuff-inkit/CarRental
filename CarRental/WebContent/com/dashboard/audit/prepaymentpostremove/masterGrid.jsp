<%@page import="com.dashboard.audit.prepaymentpostremove.ClsPrepaymentPostRemoveDAO"%>
<%ClsPrepaymentPostRemoveDAO dao=new ClsPrepaymentPostRemoveDAO();%>

<%
	String id=request.getParameter("id")==null?"":request.getParameter("id");
	String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
	String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
	String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var quotedata=[];
var id='<%=id%>';
if(id=="1"){

	quotedata='<%=dao.getJvData(id,brhid,fromdate,todate)%>'
}	
	$(document).ready(function () {
		var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "Total : " + '' + value + '</div>';
        }
		
    	var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'doc_no', type: 'int'   },
					{name : 'date', type: 'date'   },
					{name : 'accountname', type: 'string'  },
					{name : 'description', type: 'string'  },
					{name : 'reference', type: 'string'  },
					{name : 'amount', type: 'number' },
					{name : 'currency', type: 'string'   },
					{name : 'localamount', type: 'number' },
					{name : 'brhid', type: 'int' },
					{name : 'tr_no', type: 'int' },
			],
			localdata: quotedata,
            pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
            }
		};
            
        var dataAdapter = new $.jqx.dataAdapter(source,
        {
        	loadError: function (xhr, status, error) {
	        	alert(error);    
	        }
		});
		
		$("#masterGrid").jqxGrid(
        {
        	width: '100%',
            height: 300,
            source: dataAdapter,
            columnsresize: true,
            editable: false,
            enabletooltips:true,
            filterable:true,
            showfilterrow:true,
            selectionmode: 'checkbox',
            //pagermode: 'default',
                
                
            columns: [
				{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   
                },
            	{ text: 'Doc No',  datafield: 'doc_no', width: '4%' },
				{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '6%' },
				{ text: 'Account', datafield: 'accountname', width: '15%' },
				{ text: 'Remarks', datafield: 'description', width: '28%' },
				{ text: 'Reference', datafield: 'reference', width: '20%' },
				{ text: 'Amount', datafield: 'amount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
				{ text: 'Currency', datafield: 'currency',  width: '5%' },
				{ text: 'Local Amount', datafield: 'localamount', cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right', aggregates: ['sum'], aggregatesrenderer:rendererstring },
				{ text: 'brhid', datafield: 'brhid', hidden:true },
				{ text: 'tr_no', datafield: 'tr_no', hidden:true },
				
			]
        });
        
        $("#masterGrid").on("rowdoubleclick", function (event)
		{
		    var args = event.args;
		    // row's bound index.
		    var boundIndex = args.rowindex;
		    // row's visible index.
		    var visibleIndex = args.visibleindex;
		    // right click.
		    var rightclick = args.rightclick; 
		    // original event.
		    var ev = args.originalEvent;
		    
		    var docno=$('#masterGrid').jqxGrid('getcellvalue',boundIndex,'doc_no');
		    var brhid=$('#masterGrid').jqxGrid('getcellvalue',boundIndex,'brhid');
		    $('#detaildiv').load('detailGrid.jsp?docno='+docno+'&brhid='+brhid+'&id=1');
		});
	});
	
</script>
<div id="masterGrid"></div>
