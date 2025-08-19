<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();                
%> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
	String docno=request.getParameter("docno")==null?"0":request.getParameter("docno").toString();   
	String job=request.getParameter("job")==null?"0":request.getParameter("job").toString();   
 %>           
 <script type="text/javascript">
 var jobdata;    
 jobdata ='<%=dao.loadJobExpenseGrid(docno, job)%>';                  
         $(document).ready(function () {         
      
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'date', type: 'date' },  
     						{name : 'amount', type: 'number'},
     						{name : 'description', type: 'String'},
     						{name : 'cardtype', type: 'String'},
     						{name : 'mode', type: 'String'},
     						{name : 'chqno', type: 'String'},
     						{name : 'chqdate', type: 'date'},
                          	],
                          	localdata: jobdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
         
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#jobexpensegrid").jqxGrid({ 
            	width: '99%',
                height: 120,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					  
                columns: [
							{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pay Type', datafield: 'mode', width: '12%' },
							{ text: 'Card Type', datafield: 'cardtype', width: '18%' },
							{ text: 'Cheque No', datafield: 'chqno', width: '18%' },
							{ text: 'Cheque Date', datafield: 'chqdate', width: '8%',cellsformat:'dd.MM.yyyy'}, 
							{ text: 'Description', datafield: 'description', width: '24%'},
							{ text: 'Amount', datafield: 'amount', width: '12%', cellsformat: 'd2'},
					]
            });
         
           
        });
                       
</script>
<div id="jobexpensegrid"></div>