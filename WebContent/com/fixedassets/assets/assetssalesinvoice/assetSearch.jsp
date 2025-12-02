<%@page import="com.fixedassets.assets.assetssalesinvoice.ClsAssetSalesInvDAO" %>
<%ClsAssetSalesInvDAO asi=new ClsAssetSalesInvDAO(); %>
<%String branch=request.getParameter("branch")==null?"0":request.getParameter("branch"); %>
<style>
/* ------------------- GRID WRAPPER ------------------- */
#assetSearch {
    margin-top: 10px;
}

/* ------------------- GRID MAIN BOX ------------------- */
.jqx-grid {
    border: 1px solid #c6ddf5 !important;
    border-radius: 10px !important;
    background-color: #ffffff !important;
    box-shadow: 0 4px 10px rgba(0, 92, 184, 0.15) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 12px !important;
    color: #003366 !important;
}

/* ------------------- GRID HEADER ------------------- */
.jqx-grid-column-header {
    background: linear-gradient(180deg, #e9f1ff, #d7e5ff) !important;
    color: #003b8e !important;
    font-weight: 700 !important;
    border-bottom: 1px solid #c6d8ff !important;
    text-align: center !important;
}

/* ------------------- HEADER TEXT ------------------- */
.jqx-grid-column-header .jqx-grid-column-header-text {
    padding-left: 5px !important;
    text-align: left !important;
    font-size: 12px !important;
}

/* ------------------- GRID ROWS ------------------- */
.jqx-grid-cell {
    border-color: #e1eaff !important;
    font-size: 12px !important;
    color: #003366 !important;
}

/* Alternating row colors */
.jqx-grid-cell-alt {
    background-color: #f7faff !important;
}

/* Row hover effect */
.jqx-grid-cell-hover {
    background-color: #e6f0ff !important;
    cursor: pointer !important;
}

/* Selected row highlight */
.jqx-grid-cell-selected {
    background-color: #4a8dff !important;
    color: #ffffff !important;
}

/* ------------------- FILTER ROW ------------------- */
.jqx-grid-filterrow {
    background-color: #f0f4ff !important;
}

.jqx-input, .jqx-widget-content {
    border-radius: 6px !important;
    border: 1px solid #c9d9ff !important;
}

/* Filter row cells */
.jqx-grid-filterrow-cell {
    padding: 3px !important;
}

/* ------------------- SCROLLBAR ------------------- */
.jqx-scrollbar-thumb-state-normal {
    background: #bcd1ff !important;
}

.jqx-scrollbar-thumb-state-hover {
    background: #8fb4ff !important;
}

.jqx-scrollbar-button-state-normal {
    background: #e4ecff !important;
}
</style>

<script type="text/javascript">
      var dataassets= '<%=asi.assetSearch(branch)%>';
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'assetid' , type: 'String' },
     						{name : 'assetname', type: 'String'  },
     						{name : 'assetno',type:'int'}
     						
     						
     					
                 ],
                localdata: dataassets,
                //url: url,
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
            $("#assetSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
                selectionmode: 'singlerow',
				filterable: true,
				showfilterrow: true,
				selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Asset ID', datafield: 'assetid', width: '20%' },
							
							{ text: 'Asset Name', datafield: 'assetname', width: '80%'},
							{ text: 'Asset No', datafield: 'assetno', width: '80%',hidden:true}
						
							]
            });
           
           $('#assetSearch').on('rowdoubleclick', function (event) {
        	   var row2=event.args.rowindex;
           	var row5=document.getElementById("assetrow").value;
           	var assetid=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetid");
           	var assetname=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetname");
           	var assetno=$('#assetSearch').jqxGrid('getcellvalue', row2, "assetno");
           	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'salesprice',0.0);
           	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'dep_posted',null);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'pur_value',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'acc_dep',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'cur_dep',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'netbook',0.0);
	    	$('#assetInvoiceGrid').jqxGrid('setcellvalue',row5,'net_pl',0.0);
	    	
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetid", assetid);
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetname", assetname);
               $("#assetInvoiceGrid").jqxGrid('setcellvalue', row5, "assetno", assetno);
               $("#assetInvoiceGrid").jqxGrid('addrow', null, {});
               $('#assetwindow').jqxWindow('close');
            }); 
        
        });
    </script>
    <div id="assetSearch"></div>