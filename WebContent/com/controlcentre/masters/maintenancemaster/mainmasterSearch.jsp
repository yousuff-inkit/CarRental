<%@page import="com.controlcentre.masters.maintenancemaster.maintenance.ClsMaintenanceDAO"%>
<% ClsMaintenanceDAO cmd=new ClsMaintenanceDAO();%>
<style>
/* Main clean white container */
#mastersearchgrid {
    background-color: #ffffff !important; 
    border: 1px solid #D8E6F7 !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.10) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 13px !important;
}

/* Header section white with blue font */
#mastersearchgrid .jqx-grid-column-header {
    background-color: #ffffff !important;
    color: #2F75C5 !important;
    font-weight: 600 !important;
    border-bottom: 2px solid #C7DBF3 !important;
    text-align: center !important;
}

/* Normal row background */
#mastersearchgrid .jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #E6EEF9 !important;
    color: #00315C !important;
}

/* Alternate row */
#mastersearchgrid .jqx-grid-cell-alt {
    background-color: #F8FBFF !important; 
}

/* Hover */
#mastersearchgrid .jqx-grid-cell:hover {
    background-color: #F0F6FF !important;
}

/* Selected row */
#mastersearchgrid .jqx-grid-row-selected {
    background-color: #DDEAFF !important;
    color: #002B55 !important;
    font-weight: 600 !important;
}

/* Scrollbar */
#mastersearchgrid::-webkit-scrollbar {
    width: 7px;
}
#mastersearchgrid::-webkit-scrollbar-thumb {
    background: #C7DBF3;
    border-radius: 10px;
}
#mastersearchgrid::-webkit-scrollbar-track {
    background: #F3F8FF;
}
</style>

    <script type="text/javascript">
    var datasss= '<%=cmd.mainserch()%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                           	{name : 'docno' , type: 'number' },
      						{name : 'mtype', type: 'String'  },
                           	{name : 'name', type: 'String'  },
                           	{name : 'date',type:'date'}
           
                  ],
                 localdata: datasss,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  ///  alert(error);    
	                    }
		            }		
            );
            $("#mastersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
             //  filterable:true,
               // showfilterrow:true,
                altRows: true,
               // sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
               // sortable: true,
                //Add row method

                 columns: [
					{ text: 'Doc No', datafield: 'docno', width: '15%' },
					{ text: ' Maintenance Type', datafield: 'mtype', width: '35%' },
					{text: 'Description',datafield:'name',width:'50%'},
					{ text: 'Date', datafield: 'date', width: '20%',cellsformat:'dd.MM.yyyy',hidden:true },
				
					]
            });
       
  $('#mastersearchgrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "docno");
                document.getElementById("maintenancetype").value=$('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "mtype");
                document.getElementById("desc").value=$('#mastersearchgrid').jqxGrid('getcellvalue', rowindex1, "name");
                $("#miandate").jqxDateTimeInput('val',$("#mastersearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="mastersearchgrid"></div>
