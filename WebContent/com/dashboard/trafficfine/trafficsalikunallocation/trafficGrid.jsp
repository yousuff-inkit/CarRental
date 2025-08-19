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
 		data1='<%=showDAO.trafficgrid(load,fromdate,todate,chkdatails)%>';
  
 	$(document).ready(function () { 
 		var rendererstring=function (aggregates){
 	     	var value=aggregates['sum'];
 	     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
 		}

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                       
                                        	
                   						{name : 'regno', type: 'string'  },
                   						{name : 'fleetno', type: 'string'    },
                   						{name : 'source', type: 'string'    },
                   						{name : 'ticket_no', type: 'string'    },
                   						{name : 'traffic_date', type: 'date'    },
										{name : 'postdate', type: 'date'    },
                   						{name : 'receiptno', type: 'string'    },
                   						{name : 'receiptdate', type: 'date'    },
								
										{name : 'time', type: 'string'    },
                   						{name : 'location', type: 'string'    },
                   						{name : 'amount', type: 'string'    },
                   						{name : 'invno', type: 'string'    },
                   						{name : 'invtype', type: 'string'    },
                   						{name : 'rano', type: 'string'    },
                   						{name : 'dtypedesc', type: 'string'    },
										{name : 'code_name',type:'string'},
										{name : 'tcno',type:'string'},
										{name : 'ch_no',type:'string'},
										{name : 'refname', type: 'string'    },
										{name : 'trafficsrvc',type:'number'},
                   						{name : 'postdocno', type: 'string'    },
                   						{name : 'out_amount', type: 'number'    },
                   						{name : 'fine_source', type: 'string'    },
                   						{name : 'cldocno',type:'number'},
                   						{name : 'description', type: 'string'    },
                   						{name : 'outstanding',type:'number'},
                   						{name : 'trafficdesc',type:'string'},
                   						{name : 'srno', type: 'number'    },
                   						{name : 'docno', type: 'number'    },
                   						
                   				//	 t.postdocno
                   						
                   					// rano dtypedesc
                   						
                   						
     						
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
            
            $("#jqxtrafficGrid").jqxGrid(
            {
                width: '98%',
                height: 530,
                source: dataAdapter,
                
                showaggregates:true,
                showstatusbar:true,
                statusbarheight: 25,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
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
								
								{ text: 'Post DocNo', datafield: 'postdocno', width: '8%',hidden:true },  
								{ text: 'Post Date', datafield: 'postdate', width: '8%',cellsformat:'dd.MM.yyyy',hidden:true }, 
								{ text: 'Inv No', datafield: 'invno', width: '8%' ,hidden:true},
								{ text: 'Inv Type', datafield: 'invtype', width: '6%',hidden:true },
								{ text: 'RA No', datafield: 'rano', width: '8%' },
								{ text: 'Type', datafield: 'dtypedesc', width: '12%' },
								{ text: 'Client/Emp #', datafield: 'cldocno', width: '8%' },
								{ text: 'Client/Employee', datafield: 'refname', width: '12%' },
							    { text: 'Reg No', datafield: 'regno', width: '7%' },
								{ text: 'Ticket No.', datafield: 'ticket_no', width: '14%' },
								{ text: 'TC No',datafield:'tcno',width:'10%'},
								{ text: 'Fleet No', datafield: 'fleetno', width: '8%' },
								{ text: 'Plate Code',datafield:'code_name',width:'7%'},
								{ text: 'Chassis No',datafield:'ch_no',width:'12%'},
						  		{ text: 'Traffic Date', datafield: 'traffic_date', width: '7%',cellsformat:'dd.MM.yyyy' },
								{ text: 'Traffic Time', datafield: 'time', width: '7%' },
								{ text: 'Traffic Description', datafield: 'trafficdesc', width: '15%' },
								{ text: 'Inv.Description', datafield: 'description', width: '15%' },
								{ text: 'Location', datafield: 'location', width: '12%' },
								{ text: 'Source', datafield: 'source', width: '16%' },
								{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' , aggregates: ['sum'],aggregatesrenderer:rendererstring },
								{ text: 'Service Charge', datafield: 'trafficsrvc', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring  },
								{ text: 'Reciept Number', datafield: 'receiptno', width: '18%',cellsformat: 'd2',cellsalign: 'right', align:'right'  },
								{ text: 'Receipt Date', datafield: 'receiptdate', width: '12%',cellsformat:'dd.MM.yyyy' },
								{ text: 'Received Amount', datafield: 'out_amount',hidden:true ,width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
								{ text: 'Outstanding Amount', datafield: 'outstanding', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring },
								{ text: 'Fine Source', datafield: 'fine_source', width: '15%' },
								
							
	              ]
            });
            $("#overlay, #PleaseWait").hide();
			
        });
    </script>
    <div id="jqxtrafficGrid"></div>


