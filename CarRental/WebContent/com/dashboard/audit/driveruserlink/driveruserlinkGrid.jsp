<%@page import="com.dashboard.audit.driveruserlink.ClsDriverUserLink" %>
<%
ClsDriverUserLink DAO=new ClsDriverUserLink();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
	  		  data='<%=DAO.driverLinkGridLoading(check)%>';      
        $(document).ready(function () {
         	
        	var source =
            {
                datatype: "json",
                datafields: [
			                    { name: 'docno', type: 'int' },
			                    { name: 'username', type: 'string' },
			                    {name : 'driver', type: 'string'  }
				            ],
			                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#driverlinkingGrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                showfilterrow:true,
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                enabletooltips:true,
                columnsresize:true,
                columns: [
	                    { text: 'User Name', datafield: 'username', width: '50%' },  
	                    { text: 'Doc No', hidden: true, datafield: 'docno', width: '10%' },  
	                    { text: 'Driver', datafield: 'driver', width: '50%' },
					 ]
            });
            $("#overlay, #PleaseWait").hide();
            
            $('#driverlinkingGrid').on('rowdoubleclick', function (event) {
                 var rowindex1 = event.args.rowindex;
                 document.getElementById("hiddocno").value = $('#driverlinkingGrid').jqxGrid('getcellvalue', rowindex1, "docno");
                 $('#btnlinking').attr("disabled",false); 
            });  

        });

</script>
<div id="driverlinkingGrid"></div>
