<%@page import="com.dashboard.humanresource.candidatemanagement.ClsCandidateManagementDAO"%>
<%ClsCandidateManagementDAO DAO= new ClsCandidateManagementDAO(); %>
<% 
	String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>
 <script type="text/javascript">
 var datas  ='<%=DAO.candidateManagementGridLoad(check)%>'; 
 var temp ='';
 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'docno', type: 'String'},
     						{name : 'name' , type : 'String'},
     						{name : 'gender', type: 'String'},
     						{name : 'brhid', type: 'String'},
                 			{name : 'dob', type: 'date' },
                 			{name : 'nation', type: 'String' },
                 			{name : 'ndocno', type: 'String' },
                 			{name : 'qualification', type: 'String' },
                 			{name : 'qdocno', type: 'String' },
                 			{name : 'designation', type: 'String' },
                 			{name : 'desdocno', type: 'String' },
                 			{name : 'exp', type: 'String' },
                 			{name : 'post', type: 'String' },
                 			{name : 'remarks', type: 'String' },
                 			{name : 'rtastatus', type: 'String' },
                 			{name : 'rtastatusid', type: 'String' },
                 			{name : 'process', type: 'String' },
                 			{name : 'processid', type: 'String' },
                 			{name : 'processremarks', type: 'String' },
                 			{name : 'visastatus', type: 'String' },
                 			{name : 'visadocno', type: 'String' },
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
         
            $("#jqxCandidateManagementGrid").jqxGrid({ 
            	width: '98%',
                height: 512,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                enabletooltips: true,
                showfilterrow: true,
     					
                columns: [
                			{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                        	  groupable: false, draggable: false, resizable: false,datafield: '',
                        	  columntype: 'number', width: '2%',cellsalign: 'center', align: 'center',
                        	  cellsrenderer: function (row, column, value) {
                              		return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                        		}    
							},
							{ text: 'Name', datafield: 'name', width: '11%' },
							{ text: 'DOB', datafield: 'dob', width: '9%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Gender', datafield: 'gender', width: '3%' },
							{ text: 'Nationality', datafield: 'nation', width: '6%' },
							{ text: 'Qualification', datafield: 'qualification', width: '9%' },
							{ text: 'Designation', datafield: 'designation', width: '8%' },
							{ text: 'Experience', datafield: 'exp', width: '5%'},	
							{ text: 'Post', datafield: 'post', width: '9%'},	
							{ text: 'RTA Status', datafield: 'rtastatus', width: '9%'},	
							{ text: 'Visa Status', datafield: 'visastatus', width: '9%'},	
							{ text: 'Process', datafield: 'process', width: '9%'},	
							{ text: 'Remarks', datafield: 'remarks', width: '11%' }
					]
            });
         
            $("#overlay, #PleaseWait").hide();
            
            $("#jqxCandidateManagementGrid").on('rowdoubleclick', function (event) {
                // Get the clicked row index
                var args = event.args;
                var rowIndex = args.rowindex;

                // Get the row data
                var rowData = $("#jqxCandidateManagementGrid").jqxGrid('getrowdata', rowIndex);
                $('#empdocno').val(rowData.docno)
                // Log the row data
				$('#rowid').val(rowIndex)
				$('#branchid').val(rowData.brhid);
				$("#processgroup").val(rowData.processid).trigger('change');
				$("#rtaprocessremarks").val(rowData.processremarks);
				temp = rowData.visadocno;
                // Store the row data in a variable
                var storedRowData = rowData;
                document.getElementById('lblselectedrowlabel').innerHTML=$('#jqxCandidateManagementGrid').jqxGrid('getcellvalue', rowIndex, "name")+' - '+$('#jqxCandidateManagementGrid').jqxGrid('getcellvalue', rowIndex, "post");
            });
        });
                       
</script>
<div id="jqxCandidateManagementGrid"></div>