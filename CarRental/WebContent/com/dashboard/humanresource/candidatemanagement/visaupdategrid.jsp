<%@page import="com.dashboard.humanresource.candidatemanagement.ClsCandidateManagementDAO"%>
<%ClsCandidateManagementDAO DAO= new ClsCandidateManagementDAO(); %>
<% 
	String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>
 <script type="text/javascript">
 var datas  ='<%=DAO.visaUpdateGridLoad(check)%>'; 

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
         
            $("#jqxvisaupdategrid").jqxGrid({ 
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
            
            $("#jqxvisaupdategrid").on('rowdoubleclick', function (event) {
                // Get the clicked row index
                var args = event.args;
                var rowIndex = args.rowindex;

                // Get the row data
                var rowData = $("#jqxvisaupdategrid").jqxGrid('getrowdata', rowIndex);
                if(temp==''){     
				$('#visastatus').val(rowData.status);               
				$('#visastatusdocno').val(rowData.docno);               
				$('#visastatusdesc').val(rowData.desc);        
				$('#modalvisaupdatesearch').modal('hide');
                }else {
                	console.log("temp value - "+temp+"  "+(parseInt(temp)+1));
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
                		$('#visastatus').val(rowData.status);               
        				$('#visastatusdocno').val(rowData.docno);               
        				$('#visastatusdesc').val(rowData.desc);        
        				$('#modalvisaupdatesearch').modal('hide');
                	}
                }
            });
            
        });
</script>
<div id="jqxvisaupdategrid"></div>