<%@page import="com.dashboard.humanresource.candidatemanagement.ClsCandidateManagementDAO"%>
<%ClsCandidateManagementDAO DAO= new ClsCandidateManagementDAO(); %>
<% 
	String check = request.getParameter("check")==null?"0":request.getParameter("check");
	String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
%>
 <script type="text/javascript">
 var datas  ='<%=DAO.logSheetGridLoad(check,docno)%>'; 

 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
     						{name : 'doc_no', type: 'String'},
     						{name : 'date', type: 'date'},
     						{name : 'user' , type : 'String'},
                 			{name : 'description', type: 'String' },
                 			
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
         
            $("#jqxlogsheetgrid").jqxGrid({ 
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
							{ text: 'User', datafield: 'user', width: '20%' },
							{ text: 'Date', datafield: 'date',cellsformat:'dd.MM.yyyy' , width: '20%' },
							{ text: 'Description', datafield: 'description', width: '55%'},	
					]
            });
         
            $("#overlay, #PleaseWait").hide();
            
        });
                       
</script>
<div id="jqxlogsheetgrid"></div>