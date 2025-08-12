<%@page import="com.dashboard.humanresource.linemanagerassign. ClsLinemanagerassignDAO" %>
<%
ClsLinemanagerassignDAO DAO=new  ClsLinemanagerassignDAO();
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check").trim(); %>
<script type="text/javascript">
      var data;
      var temp='<%=check%>';
      
	  	if(temp=='1'){ 
	  		  data='<%=DAO.empUserLinkGridLoading(check)%>';  
	  	}
  	
        $(document).ready(function () {
         	
        	var source =
            {
                datatype: "json",
                datafields: [
								{ name: 'code', type: 'string' },
								{ name: 'name', type: 'string' },
								{ name: 'account', type: 'string' },
			                    { name: 'email', type: 'string' },
			                    { name: 'mobile', type: 'string' },
			                    { name: 'docno', type: 'string' },
			                    {name : 'linemgr', type: 'string'  },
			                    {name : 'linedocno', type: 'string'  },
				            ],
			                localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	$("#empUserLinkGridID").on("bindingcomplete", function (event) {
        		
        	});
        	
        	var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#empUserLinkGridID").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                showfilterrow: true,
                 sortable: true,
                selectionmode: 'checkbox',
                editable: false,
                
                columns: [
						{ text: 'Code', datafield: 'code', width: '13%' },
	                    { text: 'Employee Name', datafield: 'name' },
	                    { text: 'Account', datafield: 'account', width: '15%' },
	                    { text: 'Email', datafield: 'email', width: '20%' },
	                    { text: 'Mobile', datafield: 'mobile', width: '15%' },
	                    { text: 'Doc No', datafield: 'docno',hidden:true, width: '10%' },
	                    { text: 'Line Doc No', datafield: 'linedocno',hidden:true, width: '10%' },
		                { text: 'Line Manager', datafield: 'linemgr',width: '15%' },
					 ]
            });
            
            if(temp=='NA'){
                $("#empUserLinkGridID").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
      
        });

</script>
<div id="empUserLinkGridID"></div>
