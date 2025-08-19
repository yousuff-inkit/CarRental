<%@page import="com.operations.agreement.rentalagreement.ClsRentalAgreementDAO" %>
<%
ClsRentalAgreementDAO agmtdao= new ClsRentalAgreementDAO();
String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>
<script type="text/javascript">
var kmdata=[];
var id='<%=id%>';
if(id=="1"){
	kmdata='<%=agmtdao.getFuelDetails(docno,id)%>';
}
        $(document).ready(function () {
        	
       
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;text-align:right;">' + " " + '' + value + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no' , type: 'string' },
							{name : 'reg_no' , type:'string'},
							{name : 'flname' , type:'string'},
							{name : 'dout',type:'date'},
							{name : 'tout',type:'date'},
							{name : 'kmout' , type:'number'},
							{name : 'kmin',type:'number'},
							{name : 'din',type:'date'},
							{name : 'tin',type:'tin'},
							{name : 'kmdiff' , type:'number'},
							{name : 'fin',type:'number'},
							{name : 'fout',type:'number'},
							{name : 'fueldiff',type:'number'},
							{name : 'fuelamount',type:'number'},
							{name : 'tcap',type:'number'},

	                      ],
                          localdata: kmdata,
               
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
            
            $("#fuelDetailsGrid").jqxGrid(
            {
                width: '99%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
              	rowsheight:25,
             	statusbarheight:25, 
                editable: false,
              
                //Add row method
                columns: [   
							{ text: 'Fleet No', datafield: 'fleet_no', width: '6%' },
							{ text: 'Reg No',  datafield: 'reg_no', width: '6%' },
							{ text: 'Fleet Name',  datafield: 'flname'},
							{ text: 'Date Out',datafield:'dout',width:'8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Time Out',datafield:'tout',width:'6%',cellsformat:'HH:mm'},
							{ text: 'Fuel Out',  datafield: 'fout', width: '6%',cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Date In',datafield:'din',width:'8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Time In',datafield:'tin',width:'6%	',cellsformat:'HH:mm'},
							{ text: 'Fuel In',  datafield: 'fin', width: '6%' ,cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Fuel Used',  datafield: 'fueldiff', width: '6%' ,aggregates: ['sum'],aggregatesrenderer:rendererstring,cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Fueltank Capacity',  datafield: 'tcap', width: '9%' ,cellsformat:'d2',align:'right',cellsalign:'right'},
							{ text: 'Amount Charged', datafield:'fuelamount',  width:'8%',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring,align:'right',cellsalign:'right'},
											 ]
            });
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            // create context menu
               var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#fuelDetailsGrid").on('contextmenu', function () {
                   return false;
               });
               
               $("#Menu").on('itemclick', function (event) {
            	   var args = event.args;
                   var rowindex = $("#fuelDetailsGrid").jqxGrid('getselectedrowindex');
                   if ($.trim($(args).text()) == "Edit Selected Row") {
                       
                   }
                   else {
                	  
                   }
               });
               $("#fuelDetailsGrid").on('rowclick', function (event) {
                   if (event.args.rightclick) {
                       $("#fuelDetailsGrid").jqxGrid('selectrow', event.args.rowindex);
                       var rowindex=event.args.rowindex;
                       var scrollTop = $(window).scrollTop();
                       var scrollLeft = $(window).scrollLeft();
                       contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                       return false;
                   }
               });

       		$('#btnfuelprint').click(function(){
       			var url=document.URL;
       			var reurl=url.split("saveRentalAgreement");
       			var docno='<%=docno%>';
       			var win= window.open(reurl[0]+"printFuelDetails?docno="+docno,"_blank","top=85,left=150,Width=1020,Height=600,location=no,scrollbars=no,toolbar=yes");
			 	win.focus();
       		});
        });

</script>
<div style="text-align:right;margin-right:10px;margin-bottom:5px;"><button type="button" name="btnfuelprint" id="btnfuelprint" class="myButton" >Print</button></div>
<div id='jqxWidget'>
	<div id="fuelDetailsGrid"></div>
    <div id="popupWindow">
		<div id='Menu'>
        	<ul>
            	<li>Print</li>
        	</ul>
       </div>
   </div>
</div>