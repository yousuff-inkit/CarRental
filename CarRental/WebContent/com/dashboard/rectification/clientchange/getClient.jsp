<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>
 --%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.rectification.clientchange.ClsClientchangeDAO" %>
 <%
 ClsClientchangeDAO dao=new ClsClientchangeDAO();

%> 
<script type="text/javascript">
var datafleet; 

      
		$(document).ready(function () { 	 
			datafleet= '<%=dao.clientSearch() %>';
            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'cldocno' , type: 'String' },
     						{name : 'refname',type:'String'}
     						
     					
                 ],
                localdata: datafleet,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#clientSearch").jqxGrid(
            {
            	 width: '100%',
                 height: 290,
                 source: dataAdapter,
                 altRows: true,
                 sortable: true,
                 selectionmode: 'singlerow',
                 filterable: true, 
                 filtermode: 'excel',
                 enabletooltips:true,
                 columnsresize: true,
                 showfilterrow:true,
                //Add row method
                columns: [
                         	{ text: 'Client ID#', datafield: 'cldocno', width: '10%'},
							{ text: 'Client', datafield: 'refname', width: '90%' }
							]
            });
           
           $('#clientSearch').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex;
            	document.getElementById("client").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
            	document.getElementById("hidclient").value=$('#clientSearch').jqxGrid('getcellvalue', rowindex1, "cldocno");
                
               $('#clientwindow').jqxWindow('close');
               
            }); 
        });
    </script>
    <div id="clientSearch"></div>
