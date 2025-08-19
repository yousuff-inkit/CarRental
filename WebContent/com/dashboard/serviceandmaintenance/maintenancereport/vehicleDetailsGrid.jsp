<%@page import="com.dashboard.serviceandmaintenance.maintenancereport.*"%>
<%ClsMaintenanceReportDAO csm=new ClsMaintenanceReportDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
var data=[];
var id='<%=id%>';
if(id=="1"){
	data= '<%=csm.vehicleDetailsSearch(id)%>'; 
}        
        $(document).ready(function () { 
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'fleet_no', type: 'int'   },
     						{name : 'flname', type: 'string'   },
     						{name : 'reg_no', type: 'int'  },
     						{name: 'vehinfo',type: 'string'},
     						{name : 'authname',type:'string'},
     						{name : 'code_name',type:'string'},
     						{name : 'gname',type:'string'}
                        ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxVehicleSearch").jqxGrid(
            {
                width: '98%',
                height: 350,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Fleet No',  datafield: 'fleet_no', width: '10%' },
							{ text: 'Name', datafield: 'flname', width: '35%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '10%' },
							{ text: 'Authority',datafield:'authname',width:'15%'},
							{ text: 'Plate Code',datafield:'code_name',width:'15%'},
							{ text: 'Group',datafield:'gname',width:'15%'},
							{ text: 'vehinfo', datafield: 'vehinfo', width: '25%', hidden:true},
						]
            });
            
             $('#jqxVehicleSearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtfleetno").value = $('#jqxVehicleSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
                document.getElementById("txtvehicle").value = $('#jqxVehicleSearch').jqxGrid('getcellvalue', rowindex1, "flname");
                
                var values= $('#jqxVehicleSearch').jqxGrid('getcellvalue',rowindex1, "vehinfo");
    		    var sum2 = values.toString().replace(/\*/g, ' \n');    
    		    document.getElementById("vehinfo").value=sum2;
    	       	
            	$('#vehicleDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="jqxVehicleSearch"></div>
 