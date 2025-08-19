<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% 
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 

	var data;
	var dataExcelExport;
 $(document).ready(function () { 	
 	
 		
 		data='<%=DAO.vehicleListGridLoading()%>';   
 		<%-- dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>'; --%>  
 	 
 	//alert(data);     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'id', type: "int" },
						{ name: 'fleetname', type: "String" },
						{ name: 'authority', type: "string" },
						{ name: 'platecode', type: "string" },
	                    { name: 'reg_no', type: "string" },
	                    {name : 'veh_status', type: "string" },
	                    {name : 'group_name', type: "string" },
	                    {name : 'brand_name', type: "string" },
	                    {name : 'model', type: "string" },
	                    {name : 'yom', type: "string" },
	                    {name : 'tcno', type: "string" },
 	                    {name : 'salik_tagno', type: "string" },
	                    { name: 'reg_date', type: "date" },
	                    { name: 'reg_expiry', type: "date" },
	                    { name: 'ins_expiry', type: "date" },
	                    { name: 'purchase_cost', type: "string" },
	                    { name: 'dep_per', type: "string" },
	                    { name: 'dealer', type: "string" },
	                    { name: 'lpono', type: "string" },
 	                    { name: 'purchase_date', type: "date" },
	                    { name: 'financier', type: "string" },
	                    { name: 'ins_type', type: "string" },
	                    { name: 'ins_comp', type: "string" },
	                    { name: 'policy_no', type: "string" },
	                    { name: 'branch', type: "string" },
	                    { name: 'location', type: "string" },
	                    { name: 'color', type: "string" },
	                    { name: 'engine_no', type: "string" },
	                    { name: 'chasis_no', type: "string" },
	                    { name: 'fuel_type', type: "string" },
	                    { name: 'fuel_capacity', type: "string" },
	                    { name: 'status', type: "string" },
	                    { name: 'currentkm', type: "string" },
	                    { name: 'fstatus', type: "string" },
	                    { name: 'currentfuel', type: "string" },
	                    { name: 'srvduration_km', type: "string" },
	                    { name: 'lastsrv_date', type: "date" },
	                    { name: 'doc_no', type: "string" },
	                    { name: 'date', type: "date" },
	                    { name: 'fleetno', type: "string" },
	                    { name: 'spec', type: "string" },
	                    { name: 'project', type: "string" },

	            		   ],
              		 localdata: data, 
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
                                      
          };
          
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });


$("#vehicleGrid").jqxGrid(
{
	 width: '100%',
	 height: 500,
	 source: dataAdapter,
	 editable: true,
	 selectionmode: 'singlecell',
	 localization: {thousandsSeparator: ""}, 
	 showaggregates: true,
	 rowsheight:25,
	 enabletooltips:true,
	 showfilterrow:true,
	 enabletooltips:true,
	 filterable:true,
	 columnsresize: true,
	 columns: [
					{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
	
					{ text: 'ID', datafield: 'id', editable: false , width: '3%' },
					{ text: 'Doc No', datafield: 'doc_no', editable: false , width: '4%' },
					{ text: 'Date', datafield: 'date', editable: false , width: '5%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Fleet No',  datafield: 'fleetno', editable: false , width: '6%' },
					{ text: 'Fleet Name', datafield: 'fleetname',width: '10%' , editable: false},			
					{ text: 'Authority',  datafield: 'authority',width: '10%' , editable: false },			
					{ text: 'Plate Code', datafield: 'platecode',   width: '5%'  },
					{ text: 'Reg No', datafield: 'reg_no',   width: '6%'   },
					{ text: 'Vehicle Status', datafield: 'veh_status',   width: '4%'   },
					{ text: 'Group Name', datafield: 'group_name',   width: '10%'  },
					{ text: 'Brand Name', datafield: 'brand_name',   width: '10%'  },
					{ text: 'Model', datafield: 'model',   width: '4%'   },
					{ text: 'YOM', datafield: 'yom',   width: '3%'  },
					{ text: 'Salik Tag No', datafield: 'salik_tagno',   width: '7%'    },
					{ text: 'Tc No', datafield: 'tcno',   width: '4%'    },
					{ text: 'Reg Date', datafield: 'reg_date',   width: '6%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Reg Expiry', datafield: 'reg_expiry',   width: '6%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Ins Expiry', datafield: 'ins_expiry',   width: '6%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Purchase Cost', datafield: 'purchase_cost',   width: '4%'    },
					{ text: 'dep_per', datafield: 'dep_per',   width: '5%'    },
					{ text: 'Dealer', datafield: 'dealer',   width: '10%'  },
					{ text: 'Lp No', datafield: 'lpono',   width: '5%'    },
			    	{ text: 'Purchase Date', datafield: 'purchase_date',   width: '6%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Financier', datafield: 'financier',   width: '7%'    },
					{ text: 'Insurance Type', datafield: 'ins_type',   width: '5%'    },
					{ text: 'Insurance Company', datafield: 'ins_comp',   width: '10%'    },
					{ text: 'Policy No', datafield: 'policy_no',   width: '5%'    },
					{ text: 'Branch', datafield: 'branch',   width: '5%'    },
					{ text: 'Location', datafield: 'location',   width: '5%'    },
					{ text: 'Colour', datafield: 'color',   width: '5%'    },
					{ text: 'Engine No', datafield: 'engine_no',   width: '5%'    },
					{ text: 'Chasis No', datafield: 'chasis_no',   width: '5%'    },
					{ text: 'Fuel Type', datafield: 'fuel_type',   width: '6%'    },
					{ text: 'Fuel Capacity', datafield: 'fuel_capacity',   width: '5%'    },
					{ text: 'Status', datafield: 'status',   width: '5%'    },
					{ text: 'Current Km', datafield: 'currentkm',   width: '5%'    },
					{ text: 'F Status', datafield: 'fstatus',   width: '5%'    },
					{ text: 'Current Fuel', datafield: 'currentfuel',   width: '5%'    },
					{ text: 'Service Duration Km', datafield: 'srvduration_km',   width: '5%'    },
					{ text: 'Last Service Date', datafield: 'lastsrv_date',   width: '6%', cellsformat: 'dd.MM.yyyy' },
					{ text: 'Specification', datafield: 'spec',   width: '5%'    },
					{ text: 'Project', datafield: 'project',   width: '5%'    },
					],

    });
			$("#overlay, #PleaseWait").hide();
        });
 		
</script>
<div id="vehicleGrid"></div>