<%@page import="com.controlcentre.masters.maintenancemaster.garage.ClsGarageDAO" %>
<%ClsGarageDAO cgd=new ClsGarageDAO(); %>
<style>
/* Full white clean theme */
#jqxGarageSearch {
    background-color: #ffffff !important; 
    border: 1px solid #D8E6F7 !important;
    border-radius: 8px !important;
    box-shadow: 0 2px 6px rgba(0, 80, 160, 0.10) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 13px !important;
}

/* Header white with blue text */
#jqxGarageSearch .jqx-grid-column-header {
    background-color: #ffffff !important;
    color: #2F75C5 !important;
    font-weight: 600 !important;
    border-bottom: 2px solid #C7DBF3 !important;
    text-align: center !important;
}

/* Normal rows – pure white */
#jqxGarageSearch .jqx-grid-cell {
    background-color: #ffffff !important;
    border-color: #E6EEF9 !important;
    color: #00315C !important;
}

/* Alternate rows – very light blue tint */
#jqxGarageSearch .jqx-grid-cell-alt {
    background-color: #F8FBFF !important; 
}

/* Row hover */
#jqxGarageSearch .jqx-grid-cell:hover {
    background-color: #F0F6FF !important;
}

/* Selected row – clean blue highlight */
#jqxGarageSearch .jqx-grid-row-selected {
    background-color: #DDEAFF !important;
    color: #002B55 !important;
    font-weight: 600 !important;
}

/* Minimal scrollbar */
#jqxGarageSearch::-webkit-scrollbar {
    width: 7px;
}
#jqxGarageSearch::-webkit-scrollbar-thumb {
    background: #C7DBF3;
    border-radius: 10px;
}
#jqxGarageSearch::-webkit-scrollbar-track {
    background: #F3F8FF;
}
</style>

    <script type="text/javascript">
    var data= '<%=cgd.getGarage()%>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number'},
     						{name : 'code', type: 'String'},
                          	{name : 'name', type: 'String'},
                          	{name : 'date',type:'date'},
                          	{name : 'type', type:'String'},
                          	{name : 'branch', type:'String'},
                          	{name : 'location', type:'String'},
                          	{name : 'acc_no', type:'String'},
                          	{name : 'description', type:'String'}
                 ],
                 localdata: data,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                  //  alert(error);    
	                    }
		            }		
            );
            $("#jqxGarageSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%',filtertype:'number' },
					{ text: 'Code', datafield: 'code', width: '50%' },
					{text: 'Name',datafield:'name',width:'50%',filtertype: 'input',columntype: 'textbox'},
					{ text: 'Branch', datafield: 'branch', width: '20%' },
					{ text: 'Location', datafield: 'location', width: '20%' },
					{ text: 'Date', datafield: 'date', width: '20%' ,filtertype: 'input',columntype: 'textbox',cellsformat:'dd.MM.yyyy'},
					{ text: 'Acc No', datafield: 'acc_no', width: '20%' },
					{ text: 'Type', datafield: 'type', width: '20%',filtertype: 'input',columntype: 'textbox'},
					{ text: 'Description', datafield: 'description',width:'20%',filtertype: 'input',columntype: 'textbox'}
					]
            });
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'code');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'branch');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'location');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'acc_no');
           $("#jqxGarageSearch").jqxGrid('hidecolumn', 'type');
            

            $('#jqxGarageSearch').on('rowdoubleclick', function (event) {
                
            	var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("garagecode").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "code");
                document.getElementById("garagename").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "name");
                $('#location').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "location")) ;
                $('#type').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "type")) ;
                document.getElementById("txtaccname").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("txtaccno").value=$('#jqxGarageSearch').jqxGrid('getcellvalue', rowindex1, "acc_no");

               // $('#accno').val($("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "acc_no")) ;
                $("#garagedate").jqxDateTimeInput('val',$("#jqxGarageSearch").jqxGrid('getcellvalue', rowindex1, "date"));
            	$('#window').jqxWindow('close');

            }); 
           
          
        });
    </script>
    <div id="jqxGarageSearch"></div>
