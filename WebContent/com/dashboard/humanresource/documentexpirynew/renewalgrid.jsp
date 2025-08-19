<% 
	String check = request.getParameter("check")==null?"0":request.getParameter("check");
	String doct = request.getParameter("doct")==null?"0":request.getParameter("doct");
%>
 <script type="text/javascript">
 var renewaldataurl = 'loadrenewaldatagrid.jsp?doct=<%=doct%>&check=<%=check%>'; 

 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'docno', type: 'String'},
     						{name : 'status' , type : 'String'},
                 			{name : 'desc', type: 'String' },
                 			
                          	],
                          	url: renewaldataurl,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxrenewalupdategrid").jqxGrid({ 
            	width: '98%',
                height: 312,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
                			{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                        	  groupable: false, draggable: false, resizable: false,datafield: '',
                        	  columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                        	  cellsrenderer: function (row, column, value) {
                              		return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        		}    
							},
							{ text: 'status', datafield: 'status', width: '20%' },
							{ text: 'Description', datafield: 'desc', width: '75%'},	
					]
            });
         
            $("#overlay, #PleaseWait").hide();
            
            $("#jqxrenewalupdategrid").on('rowdoubleclick', function (event) {
                // Get the clicked row index
                var args = event.args;
                var rowIndex = args.rowindex;

                // Get the row data
                var rowData = $("#jqxrenewalupdategrid").jqxGrid('getrowdata', rowIndex);
				$('#renewalstatus').val(rowData.status);               
				$('#renewalstatusdocno').val(rowData.docno);               
				$('#renewalstatusdesc').val(rowData.desc);        
				$('#modalrenewalprocessgrid').modal('hide');
            });
            
        });
                       
</script>
<div id="jqxrenewalupdategrid"></div>