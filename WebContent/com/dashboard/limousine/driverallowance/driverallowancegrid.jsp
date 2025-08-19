<%@page import="com.dashboard.limousine.driverallowance.ClsDriverAllowanceDAO"%>
<%@page import="com.dashboard.limousine.assignlist.*" %>
<%ClsDriverAllowanceDAO assigndao=new ClsDriverAllowanceDAO();
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String type=request.getParameter("type")==null?"":request.getParameter("type");
String driver=request.getParameter("driver")==null?"":request.getParameter("driver");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var id='<%=id%>';
var assigndata;
if(id=="1"){
	assigndata='<%=assigndao.getAssignListData(fromdate, todate, type, driver, branch, id)%>';
}
$(document).ready(function () { 
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'bookdocno',type:'string'},
                       	{name : 'docname',type:'string'},
                       	{name : 'refname' , type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'type',type:'string'},
                       	{name : 'blockhrs',type:'number'},
                       	{name : 'pickupdate',type:'date'},
                       	{name : 'pickuptime',type:'date'},
                       	{name : 'pickuplocation',type:'string'},
                       	{name : 'pickupaddress',type:'string'},
                       	{name : 'dropofflocation',type:'string'},
                       	{name : 'dropoffaddress',type:'string'},
                       	{name : 'fleet',type:'string'},
                       	{name : 'reg_no',type:'number'},
                       	{name : 'driver',type:'string'},
                       	{name : 'allowance', type:'number'}
     				   ],
					localdata:assigndata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };

       
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#driverallowancegrid").jqxGrid(
            {
               width: '99%',
               height: 520,
               source: dataAdapter,
               columnsresize: true,
               editable:true,
               selectionmode: 'checkbox',
               
                //Add row method
                 handlekeyboardnavigation: function (event) {
            // var rows = $('#jqxgridtarif').jqxGrid('getrows');
       /*      alert("here");
                  var rowlength= event.args.rowindex;
                  alert(rowlength);
                    var cell = $('#jqxgridtarif').jqxGrid('getselectedcell');
				if (cell != undefined && cell.datafield == 'disclevel3') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {
                            $('#jqxgridtarif').jqxGrid('selectcell',rowlength+1, 'rentaltype');
                   					$('#jqxgridtarif').jqxGrid('focus',rowlength+1, 'rentaltype');
                                       
                        }
				} */
                 },
            
               
                columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Job Name',datafield:'docname',width:'4.5%',
								cellsrenderer: function (row, columnfield, value, defaulthtml, columnproperties) {
									var bookdocno=$('#driverallowancegrid').jqxGrid('getcellvalue',row,'bookdocno');
						        	return "<div style='overflow:hidden;text-overflow:ellipsis;padding-bottom:2px;text-align:left;margin-right:2px;margin-left:4px;margin-top:4px;'>" + (bookdocno+" - "+value) + "</div>";
						    	},editable:false
							},
							{ text: 'Driver',datafield:'driver',width:'10%',editable:false},
							{ text: 'Fleet',datafield:'fleet',width:'16%',editable:false},
							{ text: 'Reg No',datafield:'reg_no',width:'6%',editable:false},
							{ text: 'Book Docno',datafield: 'bookdocno',width:'5%',hidden:true,editable:false},
							{ text: 'Client',  datafield: 'refname',width:'12%',editable:false},
							{ text: 'Guest',datafield:'guest',width:'10%',editable:false},
							{ text: 'Type',datafield:'type',width:'5%',editable:false},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'4.5%',editable:false},
							{ text: 'Pickup date',datafield:'pickupdate',width:'6%',cellsformat:'dd.MM.yyyy',editable:false},
							{ text: 'Pickup time',datafield:'pickuptime',width:'5.5%',cellsformat:'HH:mm',editable:false},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%',editable:false},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%',editable:false},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%',editable:false},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%',editable:false},
							{ text: 'Allowance',datafield:'allowance',width:'10%',cellsalign:"right",cellsformat:"d2",editable:true},

							
         	              ]
           
            });
            
            $("#driverallowancegrid").on("celldoubleclick", function (event)
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		    // row's visible index.
            		    var rowVisibleIndex = event.args.visibleindex;
            		    // right click.
            		    var rightClick = event.args.rightclick; 
            		    // original event.
            		    var ev = event.args.originalEvent;
            		    // column index.
            		    var columnIndex = event.args.columnindex;
            		    // column data field.
            		    var dataField = event.args.datafield;
            		    // cell value
            		    var value = event.args.value;
            		});
            });

function funExportBtn(){
	var assignexceldata;
	if(parseInt(window.parent.chkexportdata.value)=="1")
 	{
		<%-- assignexceldata='<%=assigndao.getAssignListExcelData(fromdate, todate, type, driver, branch, "1")%>'; --%>
 		/* JSONToCSVCon(assignexceldata, 'Assignment List', true); */
 	}
	else
 	{
		$("#driverallowancegrid").jqxGrid('exportdata', 'xls', 'Assignment List');
 	}
}
</script>
<div id="driverallowancegrid"></div>
