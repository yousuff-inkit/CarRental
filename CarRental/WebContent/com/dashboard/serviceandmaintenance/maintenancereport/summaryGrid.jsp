<%@page import="com.dashboard.serviceandmaintenance.maintenancereport.*"%>
<%ClsMaintenanceReportDAO DAO= new ClsMaintenanceReportDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno").trim();
     String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
     %>
<script type="text/javascript">
      var summarydata;
      var summaryexceldata;
      var temp='<%=branchval%>';
      var temp1='<%=type%>';
      var id='<%=id%>';
      if(id=="1"){
    	  if(temp!='NA'){ 
	  		   summarydata='<%=DAO.getSummaryData(branchval,fromDate, toDate, fleetno,id)%>';
	  	}  
      }
	  	
	  	
  	
        $(document).ready(function () {
        	
        	/*if(temp1=='2'){
	        	$("#btnExcel").click(function() {
	    			$("#serviceHistory").jqxGrid('exportdata', 'xls', 'ServiceHistory');
	    		});
        	}*/
        	
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(value=="" || value=="undefined" || value==null || typeof(value)=="undefined"){
               		value="0.0";
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + "" + '' + value + '</div>';
               }
        	 
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'fleet_no' , type: 'number' },
					{name : 'reg_no' , type: 'number' },
					{name : 'flname' , type: 'string' },
				    {name : 'authname' , type: 'string' },
				    {name : 'gname', type: 'string'  },
				    {name : 'code_name', type: 'string'  },
				    {name : 'yom' , type: 'string' },
				    {name : 'color',type:'string'},
					{name : 'labourcost', type: 'number'  },
					{name : 'partscost', type: 'number'  },
					{name : 'nettotal', type: 'number'  }
	            ],
                localdata: summarydata,
               
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
            $("#summaryGrid").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                statusbarheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Fleet No', datafield: 'fleet_no', width: '7%' },
						{ text: 'Reg No.', datafield: 'reg_no', width: '7%' },
						{ text: 'Fleet Name', datafield: 'flname',width: '20%' },
						{ text: 'Authority', datafield: 'authname', width: '10%' },
						{ text: 'Group', datafield: 'gname', width: '9%' },
						{ text: 'Plate Code', datafield: 'code_name', width: '10%' },
						{ text: 'Color', datafield: 'color', width: '10%' },
						{ text: 'Yom', datafield: 'yom', width: '6%' },
						{ text: 'Labour Cost', datafield: 'labourcost',width: '7%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Parts Cost', datafield: 'partscost',width: '7%',cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Total', datafield: 'nettotal',width:"7%",cellsformat: 'd2',cellsalign: 'right', align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					 ]
            });
            
            if(temp=='NA'){
                $("#summaryGrid").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
        });

</script>
<div id="summaryGrid"></div>
