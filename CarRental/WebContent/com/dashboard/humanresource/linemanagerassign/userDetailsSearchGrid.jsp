<%@page import="com.dashboard.humanresource.linemanagerassign. ClsLinemanagerassignDAO" %>
<%
ClsLinemanagerassignDAO DAO=new  ClsLinemanagerassignDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<script type="text/javascript">
        
       var data1= '<%=DAO.userDetails()%>';  
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
							{name : 'groupcode', type: 'String'   },
     				    ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#userDetailsSearchGridID").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
							{ text: 'Doc No',  datafield: 'doc_no',hidden:true, width: '10%' },
							{ text: 'Group code',  datafield: 'groupcode', width: '100%' },
			 		]
            });
            
             $('#userDetailsSearchGridID').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtuserdocno").value = $('#userDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtusername").value = $('#userDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "groupcode");
                document.getElementById("salesman_txt").value = $('#userDetailsSearchGridID').jqxGrid('getcellvalue', rowindex1, "doc_no");
                 
            	$('#userDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="userDetailsSearchGridID"></div>
 