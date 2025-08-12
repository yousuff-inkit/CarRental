<%@page import="com.dashboard.trafficfine.trafficsalikunallocation.ClsTrafficsalikunallocationDAO"%> 
 <%
        
 ClsTrafficsalikunallocationDAO showDAO = new  ClsTrafficsalikunallocationDAO();
String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String load = request.getParameter("load")==null?"":request.getParameter("load").trim();
String regno = request.getParameter("regno")==null?"":request.getParameter("regno").trim();
String chkdatails = request.getParameter("chkdatails")==null?"":request.getParameter("chkdatails").trim();
%>
 <script type="text/javascript">
 
 var data1;
 	data1='<%=showDAO.salikgrid(load,fromdate,todate,chkdatails)%>';
     
 	$(document).ready(function () { 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },

						{name : 'salik_date', type: 'date'    },
       						
       						{name : 'salik_time', type: 'string'    },

     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'amount', type: 'string'    },
     						
     						
    						{name : 'invno', type: 'string'    },
       						{name : 'invtype', type: 'string'    },
       						{name : 'rano', type: 'string'    },
       						{name : 'dtypedesc', type: 'string'    },
				
						{name : 'refname', type: 'string'    },
       					  
       						{name : 'out_amount', type: 'number'    },
						{name : 'trans', type: 'string'    },
						{name : 'srno', type: 'number'    },
						{name : 'docno', type: 'number'    },
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxsalikGrid").jqxGrid(
            {
                width: '98%',
                height: 520,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'checkbox',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							  
							  { text: 'SR No', datafield: 'srno', width: '8%' ,hidden:true},
							  { text: 'Doc No', datafield: 'docno', width: '8%',hidden:true },
								
							  { text: 'Inv No', datafield: 'invno', width: '8%' ,hidden:true},
								{ text: 'Inv Type', datafield: 'invtype', width: '6%',hidden:true },
								  { text: 'RA No', datafield: 'rano', width: '8%' },
									{ text: 'Type', datafield: 'dtypedesc', width: '12%' },
							  
									{ text: 'Client/Employee', datafield: 'refname', width: '12%' },

							{ text: 'Reg No.', datafield: 'regno', width: '10%' },
							{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
							{ text: 'Transaction No.', datafield: 'trans', width: '11%' },

							{ text: 'Salik Date', datafield: 'salik_date', width: '12%',cellsformat:'dd.MM.yyyy' },
							
							{ text: 'Salik Time', datafield: 'salik_time', width: '10%' },

							{ text: 'Location', datafield: 'location', width: '15%' },
							{ text: 'Direction', datafield: 'direction', width: '15%' },
							{ text: 'Source', datafield: 'source', width: '20%' },
							{ text: 'Tag No.', datafield: 'tagno', width: '14%' },
							{ text: 'Amount', datafield: 'amount', width: '13%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
							{ text: 'Received Amount', datafield: 'out_amount', width: '13%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,hidden:true},							
	              ]
            });
            $("#overlay, #PleaseWait").hide();

        });
    </script>
    <div id="jqxsalikGrid"></div>


