<%@page import="com.controlcentre.masters.maintenancemaster.complaint.ClsComplaintDAO" %>
<%ClsComplaintDAO ccd=new ClsComplaintDAO(); %>
<style>
/* Full white clean theme */
#compmastersearchgrid {
    background-color: #ffffff !important; 
    border: 1px solid #D8E6F7 !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.10) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 13px !important;
}

/* Header white with blue text */
#compmastersearchgrid .jqx-grid-column-header {
    background-color: #ffffff !important;
    color: #2F75C5 !important;
    font-weight: 600 !important;
    border-bottom: 2px solid #C7DBF3 !important;
    text-align: center !important;
}

/* Normal rows – pure white */
#compmastersearchgrid .jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #E6EEF9 !important;
    color: #00315C !important;
}

/* Alternate rows – very light blue tint */
#compmastersearchgrid .jqx-grid-cell-alt {
    background-color: #F8FBFF !important; 
}

/* Row hover */
#compmastersearchgrid .jqx-grid-cell:hover {
    background-color: #F0F6FF !important;
}

/* Selected row – subtle blue */
#compmastersearchgrid .jqx-grid-row-selected {
    background-color: #DDEAFF !important;
    color: #002B55 !important;
    font-weight: 600 !important;
}

/* Minimal scrollbar */
#compmastersearchgrid::-webkit-scrollbar {
    width: 7px;
}
#compmastersearchgrid::-webkit-scrollbar-thumb {
    background: #C7DBF3;
    border-radius: 10px;
}
#compmastersearchgrid::-webkit-scrollbar-track {
    background: #F3F8FF;
}
</style>



   <script type="text/javascript">
    var commasterdata= '<%=ccd.mainserch() %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [  
                         	{name : 'doc_no' , type: 'number' },
     						{name : 'compname', type: 'String'  },
                        	{name : 'date', type: 'date'  }
           
                  ],
                 localdata: commasterdata,
                
                
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
            $("#compmastersearchgrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                altRows: true,
                selectionmode: 'singlerow',
                columnsresize: true,
              
                 columns: [
                       	{ text: 'Doc No', datafield: 'doc_no', width: '20%' },
    					{ text: ' Name', datafield: 'compname', width: '80%' },
                    	{ text: ' Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy',hidden:true }
				
					]
            });
       
  $('#compmastersearchgrid').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("compliant").value=$('#compmastersearchgrid').jqxGrid('getcellvalue', rowindex1, "compname");
                $("#compdate").jqxDateTimeInput('val',$("#compmastersearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
                $('#window').jqxWindow('close');
            }); 
          
        });
    </script>
    <div id="compmastersearchgrid"></div>
