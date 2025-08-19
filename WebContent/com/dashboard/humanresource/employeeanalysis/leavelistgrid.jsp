<%@page import="com.dashboard.humanresource.employeeanalysis.ClsEmployeeAnalysisDAO"%>
<% ClsEmployeeAnalysisDAO DAO= new ClsEmployeeAnalysisDAO (); %>
<%
 String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno");
 String id = request.getParameter("id")==null?"0":request.getParameter("id");
 %>
<script type="text/javascript">

   var data2='<%= DAO.loadleavelist(empdocno,id) %>';
       
       $(document).ready(function () { 	
	
	
	
    
	var source =
    {
        datatype: "json",
        datafields: [
        	    {name : 'fromdate', type: 'date' },
				{name : 'todate', type: 'date' },
				{name : 'halfday', type: 'bool' },
				{name : 'halfdaydate', type: 'date' },
				{name : 'leaves', type: 'string' },
				{name : 'description', type: 'string' },
				{name : 'noofdays', type: 'number' }
        ],
		 localdata: data2, 
		 pager: function (pagenum, pagesize, oldpagenum) {
             // callback called when a page or page size is changed.
         }
                                 
     };
	
 
     
     var dataAdapter = new $.jqx.dataAdapter(source,{
         		loadError: function (xhr, status, error) {
                 alert(error);    
                 }
		         });
     $("#leavelistgrid").jqxGrid(
             {
             	width: '99%',
                 height: 200,
                 source: dataAdapter,
                 editable: false,
                 filterable: true,
                 showfilterrow: true,
                 enabletooltips:true,
                 columnsresize: true,
                 sortable :true,
                 selectionmode: 'singlerow',
              
                 columns: [
                	 { text: 'From', datafield: 'fromdate', editable: false, cellsformat: 'dd.MM.yyyy', width: '15%' },
						{ text: 'To', datafield: 'todate', editable: false, cellsformat: 'dd.MM.yyyy', width: '15%' },
						{ text: 'Half Day', datafield: 'halfday', columntype: 'checkbox', editable: false, checked: true, width: '15%' },
						{ text: 'Half Taken', datafield: 'halfdaydate', editable: false, cellsformat: 'dd.MM.yyyy', width: '10%' },
						{ text: 'Leave Type', datafield: 'leaves', editable: false, width: '15%' },
						{ text: 'Description', datafield: 'description', editable: false, width: '15%' },							
						{ text: 'No of Days', datafield: 'noofdays', editable: false, width: '15%', editable: false },
					    ],
     });
 });

     


</script>

 <div id="leavelistgrid"></div>