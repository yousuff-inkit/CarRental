<%@page import="com.dashboard.humanresource.employeeanalysis.*"%>
<%ClsEmployeeAnalysisDAO DAO= new ClsEmployeeAnalysisDAO(); %>
<% 
	String check = request.getParameter("check")==null?"0":request.getParameter("check");
	String isrtaavail = request.getParameter("isrtaavail")==null?"0":request.getParameter("isrtaavail");
%>
 <script type="text/javascript">
 var datas  ='<%=DAO.statusUpdateGridLoad(check,isrtaavail)%>'; 

 $(document).ready(function (){ 
         var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'docno', type: 'String'},
     						{name : 'status' , type : 'String'},
                 			{name : 'desc', type: 'String' },
                 			
                          	],
                          	localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxstatusupdategrid").jqxGrid({ 
            	width: '98%',
                height: 312,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                showfilterrow: true,
     					
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
            
            $("#jqxstatusupdategrid").on('rowdoubleclick', function (event) {
                // Get the clicked row index
                var args = event.args;
                var rowIndex = args.rowindex;

                // Get the row data
                var rowData = $("#jqxstatusupdategrid").jqxGrid('getrowdata', rowIndex);
                if(temp==''){                	
				$('#rtastatus').val(rowData.status);               
				$('#rtastatusdocno').val(rowData.docno);               
				$('#rtastatusdesc').val(rowData.desc);        
				$('#modalstatusupdatesearch').modal('hide');
                } else {
                	if(rowData.docno<=temp){
                		swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Cannot set prevoius status!'  
						});
                	} else if (rowData.docno>parseInt(temp)+1){
                		swal.fire({  
						    icon: 'warning',
							title: 'Warning',
							text: 'Cannot skip to future steps!'  
						});
                	} else {
                		$('#rtastatus').val(rowData.status);               
        				$('#rtastatusdocno').val(rowData.docno);               
        				$('#rtastatusdesc').val(rowData.desc);        
        				$('#modalstatusupdatesearch').modal('hide');
                	}
                }
            });
            
        });
                       
</script>
<div id="jqxstatusupdategrid"></div>