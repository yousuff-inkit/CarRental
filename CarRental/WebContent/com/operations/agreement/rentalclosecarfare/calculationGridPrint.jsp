 <%@page import="com.operations.agreement.rentalclosecarfare.ClsRentalCloseCarFareDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% 
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").toString();
ClsRentalCloseCarFareDAO closedao=new ClsRentalCloseCarFareDAO();
String temp=request.getParameter("temp")==null?"0":request.getParameter("temp").toString();

%>

<script type="text/javascript">
var  calcprint=[];
var temp1='<%=temp%>';
if(temp1=="2"){
	calcprint='<%=closedao.getCalcData_view(agmtno)%>';
}
        $(document).ready(function () { 	
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
               }
        	 
        	
                
        	var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'description' , type: 'string' },
                	{name : 'qty' , type:'String'},
                	{name : 'total' , type:'number'},
                	{name : 'invoice' , type:'number'},
                	{name : 'invoiced',type:'number'},
                	{name : 'creditnote' , type:'number'},

                 ],
                localdata: calcprint,
                //url: url,
          
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	
        	/*   $('#calculationgrid').on('bindingcomplete', function (event) { 
          	    var summaryData= $("#calculationgrid").jqxGrid('getcolumnaggregateddata', 'total', ['sum'],true);
         
          	 
          	 if(typeof(summaryData.sum)=="undefined")
          		 {
          	 
                  document.getElementById("totalpaid").innerText="";
          		 }
          	 else
          		 {
          		document.getElementById("totalpaid").innerText=summaryData.sum;
          		 }
          	    }); */
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
          
            $("#calculationgrid").jqxGrid(
            {
                width: '100%',
                height: 259,
                source: dataAdapter,
                rowsheight:18,
                localization: {thousandsSeparator: ""},
                statusbarheight:15,
               // columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
             	showaggregates:true,
                showstatusbar:true,
                //Add row method
                columns: [

                	{ text: 'Rate Description', datafield: 'description', width: '25%',editable:false},
                	{ text: 'Qty',  datafield: 'qty',  width: '20%',editable:true },
                	{ text: 'Total',  datafield: 'total',  width: '14%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
                	{ text: 'Invoiced', datafield:'invoiced', width:'14%',editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'] ,aggregatesrenderer:rendererstring},
                	{ text: 'Invoice',  datafield: 'invoice',  width: '14%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
                	{ text: 'Credit Note',  datafield: 'creditnote',  width: '13%',editable:true,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},

], /* columngroups: 
	                     [
	                       { text: 'Balance', align: 'center', name: 'Balance',width:10 }
	                    
	                     ] */
            });

      
            
       var rows=$("#calculationgrid").jqxGrid("getrows");
       var rowlength=rows.length;
       if(rowlength==0){
            $("#calculationgrid").jqxGrid("addrow", null, {});
       }
        });
            </script>
            <div id="calculationgrid"></div>