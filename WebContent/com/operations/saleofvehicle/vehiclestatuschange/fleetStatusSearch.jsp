<%@page import="com.operations.saleofvehicle.vehiclestatuschange.*" %>
<% ClsFleetStatusChangeDAO fleetdao=new ClsFleetStatusChangeDAO(); %>

<style>
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Outer Search / Grid Container */
    #fleetSearch {
        margin: 15px auto;
        padding: 10px;
        background: #ffffff;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.18);
        border: 1px solid #c6ddf5;
    }

    /* jqxGrid styling */
    .jqx-grid, .jqx-grid-cell, .jqx-grid-column-header, .jqx-grid-filter-row {
        font-family: "Segoe UI", Roboto, sans-serif;
        font-size: 13px;
        color: #000000; /* Black text */
    }

    .jqx-grid-column-header {
        background: #0d6efd;
        color: #ffffff;
        font-weight: 600;
    }

    .jqx-grid-cell-alt {
        background: #f4f9ff;
    }

    .jqx-grid-cell {
        padding: 4px 8px;
        border-bottom: 1px solid #cfdaf0;
    }

    .jqx-grid-filter-row input {
        border: 1px solid #b7d1ee;
        border-radius: 4px;
        padding: 2px 6px;
        color: #000000;
    }

    /* jqxDateTimeInput styling */
    .jqx-widget-content {
        font-size: 13px;
        color: #000000;
        border-radius: 6px;
        border: 1px solid #b7d1ee;
    }

    /* Buttons */
    .myButton {
        background: #0d6efd;
        color: white;
        padding: 8px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 600;
        transition: 0.3s;
    }

    .myButton:hover {
        background: #0b5ed7;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        transform: translateY(-2px);
    }

    /* General Inputs */
    input[type="text"], select {
        width: 95%;
        padding: 6px 8px;
        border: 1px solid #b7d1ee;
        border-radius: 6px;
        outline: none;
        font-size: 13px;
        background: #ffffff;
        color: #000000;
        transition: 0.3s;
    }

    input[type="text"]:focus, select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 4px rgba(13, 110, 253, 0.4);
    }

    /* Window / Modal container */
    #window {
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        padding: 15px;
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
