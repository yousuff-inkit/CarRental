<%@page import="com.controlcentre.masters.maintenancemaster.damage.ClsDamageDAO" %>
<%ClsDamageDAO cdd=new ClsDamageDAO(); %>

<style>
/* Full white clean theme */
#jqxDamageSearch {
    background-color: #ffffff !important; 
    border: 1px solid #D8E6F7 !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.10) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 13px !important;
}

/* Header white with blue text */
#jqxDamageSearch .jqx-grid-column-header {
    background-color: #ffffff !important;
    color: #2F75C5 !important;
    font-weight: 600 !important;
    border-bottom: 2px solid #C7DBF3 !important;
    text-align: center !important;
}

/* Normal rows – pure white */
#jqxDamageSearch .jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #E6EEF9 !important;
    color: #00315C !important;
}

/* Alternate rows – very light blue tint */
#jqxDamageSearch .jqx-grid-cell-alt {
    background-color: #F8FBFF !important; 
}

/* Row hover */
#jqxDamageSearch .jqx-grid-cell:hover {
    background-color: #F0F6FF !important;
}

/* Selected row – clean blue highlight */
#jqxDamageSearch .jqx-grid-row-selected {
    background-color: #DDEAFF !important;
    color: #002B55 !important;
    font-weight: 600 !important;
}

/* Minimal scrollbar */
#jqxDamageSearch::-webkit-scrollbar {
    width: 7px;
}
#jqxDamageSearch::-webkit-scrollbar-thumb {
    background: #C7DBF3;
    border-radius: 10px;
}
#jqxDamageSearch::-webkit-scrollbar-track {
    background: #F3F8FF;
}
</style>


    <script type="text/javascript">
    var datass= '<%=cdd.getDamage() %>';
  
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'type', type: 'String'  },
                          	{name : 'name', type: 'String'  },
                          	{name : 'date',type:'String'},
                          	{name : 'dmg_chg', type:'number'}
                 ],
                 localdata: datass,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  // alert(error);    
	                    }
		            }		
            );
            $("#jqxDamageSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                filterable:true,
                showfilterrow:true,
                altRows: true,
               // sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
              //  sortable: true,
                //Add row method

                columns: [
                          
                          
              			{ text: 'DOC NO', datafield: 'doc_no', width: '20%' },
              			{ text: 'Type', datafield: 'type', width: '40%' },
    					{ text: 'Name', datafield: 'name', width: '40%' },      
				
    					
					{ text: 'Date', datafield: 'date', width: '20%' ,hidden:true}
					
					]
            });
         
            

            $('#jqxDamageSearch').on('rowselect', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                $('#cmbtype').val($('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("name1").value=$('#jqxDamageSearch').jqxGrid('getcellvalue', rowindex1, "name");

                $("#damagedate").jqxDateTimeInput('val',$("#jqxDamageSearch").jqxGrid('getcellvalue', rowindex1, "date"));
            	$('#window').jqxWindow('close');

            }); 
         
        });
    </script>
    <div id="jqxDamageSearch"></div>
