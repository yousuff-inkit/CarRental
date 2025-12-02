<%@page import="com.operations.saleofvehicle.vehiclestatuschange.ClsFleetStatusChangeDAO"%>
<% 
 String searchdate = request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
 String fleetno = request.getParameter("fleetno")==null?"0":request.getParameter("fleetno");
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
String regno=request.getParameter("regno")==null?"0":request.getParameter("regno");
String color=request.getParameter("color")==null?"0":request.getParameter("color");
String group=request.getParameter("group")==null?"0":request.getParameter("group");
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
ClsFleetStatusChangeDAO fleetdao=new ClsFleetStatusChangeDAO();
%>
<style>
    /* Body styling */
    body {
        background-color: #E0ECF8;
        font-family: "Segoe UI", Roboto, sans-serif;
        margin: 0;
        padding: 0;
        color: #000000; /* Black text */
    }

    /* Outer Fleet Search Container */
    #fleetSearch {
        margin: 15px auto;
        padding: 12px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.15);
        border: 1px solid #c6ddf5;
    }

    /* jqxGrid styling */
    .jqx-grid, 
    .jqx-grid-cell, 
    .jqx-grid-column-header, 
    .jqx-grid-filter-row {
        font-family: "Segoe UI", Roboto, sans-serif;
        font-size: 13px;
        color: #000000; /* Black text */
    }

    .jqx-grid-column-header {
        background-color: #0d6efd; /* ERP Blue */
        color: #ffffff;
        font-weight: 600;
        border-bottom: 1px solid #b7d1ee;
    }

    .jqx-grid-cell-alt {
        background-color: #f4f9ff; /* alternate row color */
    }

    .jqx-grid-cell {
        padding: 4px 6px;
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
        background-color: #ffffff;
    }

    /* Buttons */
    .myButton {
        background-color: #0d6efd;
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
        background-color: #0b5ed7;
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
        background-color: #ffffff;
        color: #000000;
        transition: 0.3s;
    }

    input[type="text"]:focus, select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 4px rgba(13, 110, 253, 0.4);
    }

    /* jqxWindow / Modal container */
    #fleetwindow {
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 3px 8px rgba(0, 92, 184, 0.12);
        padding: 15px;
    }
</style>


<script type="text/javascript">
      var datafleet= '<%=fleetdao.fleetSearch(branch,searchdate,fleetno,docno,regno,color,group) %>';
        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'fleet_no' , type: 'String' },
     						{name : 'flname', type: 'String'  },
     						{name : 'reg_no',type:'String'},
     						{name : 'color',type:'String'},
     						{name : 'gid',type:'String'},
     						{name : 'tran_code',type:'String'},
     						{name : 'st_desc',type:'String'},
     						{name : 'din',type:'date'},
     						{name : 'tin',type:'date'},
     						{name :'date',type:'date'},
     						{name :'doc_no',type:'int'}
     					
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
                height: 290,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                //sortable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [
							{ text: 'Doc No', datafield: 'doc_no', width: '16.66%' },
							{ text: 'Date', datafield: 'date', width: '16.66%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Fleet No', datafield: 'fleet_no', width: '16.66%' },
							{ text: 'Reg No', datafield: 'reg_no', width: '16.66%'},
							{ text: 'Fleet Name', datafield: 'flname', width: '40%',hidden:true},
							{ text: 'Color', datafield: 'color', width: '16.66%'},
							{ text: 'Group', datafield: 'gid', width: '16.66%'},
							{ text: 'Trancode', datafield: 'tran_code', width: '80%',hidden:true },
							{ text: 'Status', datafield: 'st_desc', width: '80%',hidden:true },
							{ text: 'Date In', datafield: 'din', width: '80%',hidden:true,cellsformat:'dd.MM.yyyy' },
							{ text: 'Time In',datafield: 'tin',width: '80%',hidden:true,cellsformat:'HH:mm' }
							]
            });
           
           $('#fleetSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	var temp="";
            	 document.getElementById("docno").focus();
            	document.getElementById("fleetno").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            	var fleetno=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "fleet_no");
               temp=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "flname");
               temp=temp+"Reg No:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "reg_no");
               temp=temp+"Color:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "color");
               temp=temp+"Group:"+$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "gid");
               document.getElementById("fleetname").value=temp;
               document.getElementById("hidcurrentstatus").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "tran_code");
               document.getElementById("currentstatus").value=$('#fleetSearch').jqxGrid('getcellvalue', rowindex1, "st_desc");
               getMovData(fleetno);
               //$("#hiddate").jqxDateTimeInput('val',$("#fleetSearch").jqxGrid('getcellvalue', rowindex1, "din"));
				//$("#hidtime").jqxDateTimeInput('val',$("#fleetSearch").jqxGrid('getcellvalue', rowindex1, "tin"));
               
                
            }); 
           $('#fleetwindow').on('close', function(event) {
        	   document.getElementById("fleetname").focus();
        	});
        });
        
        function getMovData(fleetno) {
			var x = new XMLHttpRequest();
			x.onreadystatechange = function() {
				if (x.readyState == 4 && x.status == 200) {
					var items = x.responseText.trim();
					$("#hiddate").jqxDateTimeInput('val',items.split("::")[0]);
					$("#hidtime").jqxDateTimeInput('val',items.split("::")[1]);
					$('#fleetwindow').jqxWindow('close');
				} else {
				}
			}
			x.open("GET", "getMovData.jsp?fleetno="+fleetno, true);
			x.send();
		}
    </script>
    <div id="fleetSearch"></div>
