<%@page import="com.dashboard.ClsDashBoardDAO"%>
<%ClsDashBoardDAO DAO= new ClsDashBoardDAO();
String mode=request.getParameter("mode")==null?"":request.getParameter("mode");
%>
<style>
	.redClass{
		color: red;
	}
	.blueClass{
		color: blue;
	}
</style>
<script type="text/javascript">
	var mode='<%=mode%>';
	var counturl='getPendingCountData.jsp?mode='+mode;
	
	$(document).ready(function () { 
		var source =
	    {
	       	datatype: "json",
	        datafield: [
				{name : 'description', type: 'string' },
				{name : 'srno', type: 'number' },
	   			{name : 'itemcount', type: 'number' }
			],
	        url: counturl,  
	        pager: function (pagenum, pagesize, oldpagenum) {
	        	// callback called when a page or page size is changed.
	        }
		};
	          
		var cellclassname = function (row, column, value, data) {
	        /*if (data.priority == 'HIGH') {
	        	return "redClass";
	        }else if (data.priority == 'LOW') {
	        	return "blueClass";
	        };*/
		}; 
	                  
	    var dataAdapter = new $.jqx.dataAdapter(source);
	            
	    $("#pendingCountGrid").jqxGrid(
	    {
	    	width: '100%',
	        height: 300,
	        source: dataAdapter,
	        editable: false,
	        selectionmode: 'singlerow',  
	        columns: [
				{ text: 'Sr.No', datafield: 'srno', width: '10%' },
				{ text: 'Description', datafield: 'description',width: '70%' },
				{ text: 'Count', datafield: 'itemcount',width: '20%' },
			]
		});
	});
</script>
<div id="pendingCountGrid"></div>
