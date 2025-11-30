<%@page import="com.operations.saleofvehicle.vehiclestatuschange.*" %>
<% ClsFleetStatusChangeDAO fleetdao=new ClsFleetStatusChangeDAO(); %>
<style>
/* Grid container */
#fleetSearch {
    margin-top: 10px;
    border-radius: 8px !important;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
}

/* Grid background */
.jqx-grid, 
.jqx-widget-content {
    background: #ffffff !important;
    border: 1px solid #d2e3f5 !important;
}

/* Header styling */
.jqx-grid-column-header {
    background: #2F75C5 !important;
    color: #ffffff !important;
    font-weight: bold !important;
    font-size: 13px !important;
    text-align: center !important;
    border-color: #2F75C5 !important;
    padding: 6px 0 !important;
}

/* Header hover */
.jqx-grid-column-header:hover {
    background: #1E5CB8 !important;
}

/* Row styling */
.jqx-grid-cell {
    font-size: 13px !important;
    padding-left: 8px !important;
    border-color: #e4eef9 !important;
}

/* Alternate row color */
.jqx-grid-cell-alt {
    background-color: #f7faff !important;
}

/* Filter row styling */
.jqx-grid-cell-filter-row {
    background: #eef4fc !important;
    border-bottom: 1px solid #c9dbf2 !important;
}

/* Row hover */
.jqx-grid-cell-hover {
    background: #E6F0FF !important;
}

/* Selected row */
.jqx-grid-cell-selected {
    background: #c9dbf9 !important;
    color: #000 !important;
}

/* Scrollbar - modern look */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: #b6c9e9;
    border-radius: 8px;
}
::-webkit-scrollbar-thumb:hover {
    background: #94b2e4;
}
</style>

<script type="text/javascript">
      var datafleet=[];
      <%-- '<%=fleetdao.fleetStatusSearch(session)%>'; --%>  
 		
        $(document).ready(function () { 	
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [

                          	{name : 'doc_no' , type: 'String' },
     						{name : 'date', type: 'String'  },
     						{name : 'time',type:'String'},
     						{name : 'fleetno',type:'String'},
     						{name : 'st_desc',type:'String'},
     						{name : 'currst',type:'String'},
     						{name : 'changest',type:'String'},
     						{name : 'flname',type:'String'},
     						{name : 'reg_no',type:'String'},
     						{name : 'gid',type:'String'},
     						{name : 'color',type:'String'},
     						{name : 'reason',type:'String'}
     					
                 ],
                localdata: datafleet,
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
            $("#fleetSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                columnsresize: true,
                filterable:true,
                showfilterrow:true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
 							{ text: 'Doc No', datafield: 'doc_no', width: '20%',columntype: 'textbox', filtertype: 'input'},
 							{ text: 'Date', datafield: 'date', width: '20%' , columntype: 'textbox', filtertype: 'input'},
 							{ text: 'Time', datafield: 'time', width: '20%',hidden:true, columntype: 'textbox', filtertype: 'input' },
 							{ text: 'Status', datafield: 'st_desc', width: '20%',hidden:true, columntype: 'textbox', filtertype: 'input' },
 							{ text: 'Fleet',datafield:'fleetno',width:'20%', columntype: 'textbox', filtertype: 'input'},
 							{ text: 'Current St', datafield: 'currst', width: '20%',hidden:true , columntype: 'textbox', filtertype: 'input'},
 							{ text: 'Change St', datafield: 'changest', width: '20%',hidden:true, columntype: 'textbox', filtertype: 'input' },
 							{ text: 'flname', datafield: 'flname', width: '40%' , columntype: 'textbox', filtertype: 'input'},
							{ text: 'Reg No', datafield: 'reg_no', width: '40%',hidden:true, columntype: 'textbox', filtertype: 'input'},
							{ text: 'Color', datafield: 'color', width: '80%',hidden:true , columntype: 'textbox', filtertype: 'input'},
							{ text: 'Group', datafield: 'gid', width: '80%',hidden:true , columntype: 'textbox', filtertype: 'input'},
							{ text: 'Reason', datafield: 'reason', width: '80%',hidden:true, columntype: 'textbox', filtertype: 'input' }
							
							]
            });
           
           $('#fleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	var temp="";
            	document.getElementById("fleetno").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleetno");
               temp=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "flname");
               temp=temp+"Reg No:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
               temp=temp+"Color:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "color");
               temp=temp+"Group:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "gid");
               document.getElementById("fleetname").value=temp;
               document.getElementById("currentstatus").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "st_desc");
               document.getElementById("hidcurrentstatus").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "currst");
               document.getElementById("docno").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
               document.getElementById("reason").innerText=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "reason");
               $('#fleetstatusdate').jqxDateTimeInput({ disabled: false}); 
          	 $('#fleetstatustime').jqxDateTimeInput({ disabled: false}); 
               $("#fleetstatusdate").jqxDateTimeInput('val',$("#fleetSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               $("#fleetstatustime").jqxDateTimeInput('val',$("#fleetSearch").jqxGrid('getcellvalue', rowindex1, "time"));
               $('#cmbchangestatus').attr('disabled', false );
               $('#fleetstatusdate').jqxDateTimeInput({ disabled: true}); 
          	 $('#fleetstatustime').jqxDateTimeInput({ disabled: true}); 
               $('#cmbchangestatus').val($("#fleetSearch").jqxGrid('getcellvalue', rowindex1, "changest")) ;
               $('#cmbchangestatus').attr('disabled', true );
               $('#window').jqxWindow('close');
                
            }); 
        });
    </script>
    <div id="fleetSearch"></div>
