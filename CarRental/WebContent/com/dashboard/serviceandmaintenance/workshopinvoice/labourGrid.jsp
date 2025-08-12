<%@page import="com.dashboard.serviceandmaintenance.workshopinvoice.ClsWorkshopInvoice"%>
<%ClsWorkshopInvoice gatedao=new ClsWorkshopInvoice();
String linvno=request.getParameter("invno")==null?"":request.getParameter("invno");
String ljobcardno=request.getParameter("jobcardno")==null?"":request.getParameter("jobcardno");
String lid=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var labourcostdata;
var id='<%=lid%>';
if(id=="1"){
	labourcostdata='<%=gatedao.getLabourcostData(ljobcardno,linvno,lid)%>';
}
$(document).ready(function () { 
	
	var rendererstring1=function (aggregates){
 		 
   	 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> Total </div>';
	}
	
	
	var rendererstringold=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	if(value=="undefined" || typeof(value)=="undefined"){
     		value="0.00";
     	}
     	
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + value + '</div>';
     }
     var source =
     {
         datatype: "json",
         datafields: [
        	 	{name : 'desc1', type: 'string'   },
				{name : 'rate', type: 'number'   },
				{name : 'qty', type: 'number'   },
				{name : 'type', type: 'string'   },
				{name : 'amount',type:'number'},
				{name : 'discount',type:'number'},
				{name : 'vatpercent', type: 'number'   },
				{name : 'vatamount',type:'number'},
				{name : 'netamount',type:'number'},
          ],
          localdata: labourcostdata,
         
         
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

            
            
            $("#labourcostGrid").jqxGrid(
            {
                width: '100%',
                height: 180,
                source: dataAdapter,
                columnsresize: true,
                disabled:false,
                altRows: true,
                sortable: true,
                selectionmode: 'singlecell',
                pagermode: 'default',
                editable:true,
                showaggregates:true,
                theme: 'energyblue',
                showstatusbar:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                    /* var cell = $('#jqxSpecification').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'DESCRIPTION' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#jqxSpecification").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                    
                },
                
                       
                columns: [
					{ text: 'Sr. No.',datafield: '',columntype:'number',editable:false, width: '4%', cellsrenderer: function (row, column, value) {
                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                 }   },	
					{ text: 'Description', datafield: 'desc1', editable:false,aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },	   	
					{ text: 'Qty', datafield: 'qty', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
					{ text: 'Rate', datafield: 'rate', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
					{ text: 'Disc.', datafield: 'discount', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
					{ text: 'Amount', datafield: 'amount', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',
						aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'VAT%', datafield: 'vatpercent', width: '8%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
					{ text: 'VAT', datafield: 'vatamount', width: '16%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},		
					{ text: 'Net Amount',datafield: 'netamount', width: '6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2',
						aggregates: ['sum'],aggregatesrenderer:rendererstring},
					
	              ]
            });
           
        });
    </script>
    <div id="labourcostGrid"></div>