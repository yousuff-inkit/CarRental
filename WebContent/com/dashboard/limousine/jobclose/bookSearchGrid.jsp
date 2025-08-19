<%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.dashboard.limousine.jobclose.*" %>
<%
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String searchdate=request.getParameter("searchdate")==null?"":request.getParameter("searchdate");
String searchdocno=request.getParameter("searchdocno")==null?"":request.getParameter("searchdocno");
String searchclient=request.getParameter("searchclient")==null?"":request.getParameter("searchclient");
String searchguest=request.getParameter("searchguest")==null?"":request.getParameter("searchguest");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
 <script type="text/javascript"> 
 var id='<%=id%>';
        $(document).ready(function () { 
 			var urlbooking = 'getbookingurl.jsp?branch=<%=branch%>&searchdate=<%=searchdate%>&searchdocno=<%=searchdocno%>&searchclient=<%=searchclient%>&searchguest=<%=searchguest%>&id=<%=id%>';
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'bookdocno', type: 'int'  },
     						{name : 'date', type: 'date'  },
     						{name : 'client', type: 'String'  }, 
     						{name : 'guest', type: 'String'  }
     						
                          	],
                          	 url: urlbooking,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            $("#limoInvoiceGrid").on("bindingcomplete", function (event) {
            	$("#bookSearchGrid").jqxGrid('clear');
            	alert("Entered");
            
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#bookSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'checkbox',
            
            
     					
                columns: [
					{ text: 'Doc No', datafield: 'bookdocno', width: '10%' },
					{ text: 'Date', datafield: 'date', width: '10%' ,cellsformat:'dd.MM.yyyy'},
					{ text: 'Client', datafield: 'client', width: '43%' },
					{ text: 'Guest', datafield: 'guest', width: '32.5%'}
					
					]
            });

                  }); 
				       
                       
    </script>
    <div id="bookSearchGrid"></div>