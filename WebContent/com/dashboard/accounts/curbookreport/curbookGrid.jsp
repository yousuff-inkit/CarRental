<%@ page import="com.dashboard.accounts.curbookreport.ClsCurbookReportDAO"%>
	
 <%
 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
 String currid = request.getParameter("currid")==null?"0":request.getParameter("currid");

	ClsCurbookReportDAO DAO=new ClsCurbookReportDAO();
 %>
 <script type="text/javascript">
 

 var details;
 
  var details='<%=DAO.curDetails(chk,fromdate,todate,currid)%>'; 
         
        $(document).ready(function () { 
         
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                	        {name : 'docno', type: 'number'  },
                 			{name : 'frmdate', type: 'date'  },
                 			{name : 'todate' , type : 'date'},
     						{name : 'curr', type: 'String'},
     						{name : 'currname', type: 'String'},
     						{name : 'currid', type: 'String'},
     						{name : 'rate', type: 'String'}     						
                          	],
                          	
                          	localdata: details,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#curdetailsgrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 500,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable: true,
                editable:false,
                
     					
                columns: [
                	
                	 { text: 'SL#', sortable: false, filterable: false,            
					      groupable: false, draggable: false, resizable: false,
					      datafield: 'sl', columntype: 'number', width: '4%',
					      cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					      }  
					     },
                	
                	         { text: 'Doc No', datafield: 'docno', width: '15%',hidden:true },
							
							 { text: 'From Date', datafield: 'frmdate', width: '15%',cellsformat:'dd.MM.yyyy' },
				
							 { text: 'To Date', datafield: 'todate', width: '15%',cellsformat:'dd.MM.yyyy'},	
							 
							 { text: 'Currency', datafield: 'curr', width: '20%' },
							 
							 { text: 'Name', datafield: 'currname', width: '20%' },
							 
							 { text: 'Currency ID', datafield: 'currid', width: '15%' ,hidden:true},
							 
							 { text: 'Rate', datafield: 'rate',cellsalign:'right',align:'right' },
							
					
					]
            });
         
        
            $("#overlay, #PleaseWait").hide();
        });
        
        
				       
                       
    </script>
    <div id="curdetailsgrid"></div>