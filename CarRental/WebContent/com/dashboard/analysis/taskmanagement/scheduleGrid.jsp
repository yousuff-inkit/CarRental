<%@page import="com.dashboard.analysis.taskmanagement.ClsTaskManagementDAO"%>
<%ClsTaskManagementDAO DAO= new ClsTaskManagementDAO(); %>     
<% String id = request.getParameter("id")==null?"":request.getParameter("id").toString();%>           
 <script type="text/javascript">
         var schdate;    
         schdate ='<%=DAO.scheduleGrid(id) %>';                          
         $(document).ready(function () {         
      
         var source = 
            {
                datatype: "json",
                datafields: [
	                 			{name : 'date', type: 'date' },  
	     						{name : 'type', type: 'String'},
	     						{name : 'remarks', type: 'String'},
	     						{name : 'typeid', type: 'String'},  
                          	],
                          	localdata: schdate,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jqxScheduleGrid").jqxGrid({ 
            	width: '100%',
                height: 200,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
                enabletooltips:true,
                columnsresize: true,            		  
                columns: [
                			{ text: 'Type', datafield: 'type', width: '20%' },
							{ text: 'Last Created Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy'},  
							{ text: 'Remarks', datafield: 'remarks'}, 
							{ text: 'Type ID', datafield: 'typeid', width: '0%', hidden:true },
					]
            });
            
            $('#jqxScheduleGrid').on('rowdoubleclick', function (event) {      
	            var rowindex = event.args.rowindex;                        
	            document.getElementById("schrowindex").value = rowindex;  
	        });
        });
</script>
<div id="jqxScheduleGrid"></div>   