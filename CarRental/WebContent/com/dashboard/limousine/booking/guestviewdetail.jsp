<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO"%>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
ClsLimoBookingDAO dao=new ClsLimoBookingDAO();
%> 
<%                 
%> 

 <script type="text/javascript">
	 var guestdata='<%=dao.getGuestGridData(docno)%>'; 
	 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'guest', type: 'String'  },
     						{name : 'guestcontactno', type: 'String'  }      						
      					
                          	],
                          	localdata: guestdata,
                          //	 url: url1,
          
				
                
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
            $("#guestgrid").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                filterable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
            
                columns: [
                	 { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                  	}},
					{ text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true },
					{ text: 'Guest', datafield: 'guest', width: '50%' },
					{ text: 'Contact No', datafield: 'guestcontactno', width: '44%'}
					]
            });
    
			$('#guestgrid').on('rowdoubleclick', function (event) 
				{ 
				
        
            }); 
				       
        });               
    </script>
    <div id="guestgrid"></div>
    