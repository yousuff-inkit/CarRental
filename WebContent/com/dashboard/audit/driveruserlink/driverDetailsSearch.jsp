<%@page import="com.dashboard.audit.driveruserlink.ClsDriverUserLink" %>
<% ClsDriverUserLink DAO=new ClsDriverUserLink(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");%>
<script type="text/javascript">
        
       var data1= '<%=DAO.userDetails(chk)%>';    
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'dr_id', type: 'int'   },
     						{name : 'name', type: 'string'   },
     						{name : 'docno', type: 'string'   },

                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 303,
                source: dataAdapter,
                showfilterrow:true,
                filterable: true,
                selectionmode: 'singlerow',
                
                columns: [
							{ text: 'Doc No',  datafield: 'docno', hidden: true, width: '5%' },
							{ text: 'Name', datafield: 'name' },
						]
            });
            
             $('#driverSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                
                document.getElementById("txtdrid").value = $('#driverSearchGrid').jqxGrid('getcellvalue', rowindex1, "docno");  
                document.getElementById("txtdriver").value = $('#driverSearchGrid').jqxGrid('getcellvalue', rowindex1, "name");
    	       	
            	$('#driverDetailsWindow').jqxWindow('close'); 
            });  
        });
    </script>
    <div id="driverSearchGrid"></div>
 