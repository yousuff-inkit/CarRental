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
/* Grid container */
#fleetSearch {
    margin-top: 10px;
    border-radius: 8px !important;
    overflow: hidden;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
}

/* Main grid look */
.jqx-grid, 
.jqx-widget-content {
    background: #ffffff !important;
    border: 1px solid #d4e3f7 !important;
    font-family: "Segoe UI", Arial, sans-serif !important;
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

/* Header hover effect */
.jqx-grid-column-header:hover {
    background: #1E5CB8 !important;
}

/* Cell styling */
.jqx-grid-cell {
    font-size: 13px !important;
    padding-left: 8px !important;
    border-color: #e4eef9 !important;
}

/* Alternate row */
.jqx-grid-cell-alt {
    background: #f4f8ff !important;
}

/* Hover row */
.jqx-grid-cell-hover {
    background-color: #E8F1FF !important;
}

/* Selected row */
.jqx-grid-cell-selected {
    background-color: #c9daf7 !important;
    color: #000 !important;
}

/* Scrollbar modern look */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: #b6c9e9;
    border-radius: 10px;
}
::-webkit-scrollbar-thumb:hover {
    background: #94b2e4;
}

/* Filter row styling (if enabled later) */
.jqx-grid-cell-filter-row {
    background: #eef4fc !important;
    border-bottom: 1px solid #c9dbf2 !important;
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
