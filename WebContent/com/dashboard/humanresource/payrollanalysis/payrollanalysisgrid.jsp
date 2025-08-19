<%@page import="com.dashboard.humanresource.payrollanalysis.ClsPayrollAnalysisDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<% ClsPayrollAnalysisDAO pas = new ClsPayrollAnalysisDAO(); 
String id = request.getParameter("id")==null || request.getParameter("id").equals("")?"0":request.getParameter("id").toString();
String year = request.getParameter("year")==null || request.getParameter("year").equals("")?"0":request.getParameter("year").toString();
String month = request.getParameter("month")==null || request.getParameter("month").equals("")?"0":request.getParameter("month").toString();
String employee = request.getParameter("employee")==null || request.getParameter("employee").equals("")?"0":request.getParameter("employee").toString();
%>   
<script type="text/javascript">;  
var data='<%=pas.loadGrid(id, month, year,employee) %>';
//alert(data);
   $(document).ready(function () { 
	   var rendererstring=function (aggregates){
          	var value=aggregates['sum'];
          	if(typeof(value) == "undefined" || typeof(value) == "NAN"){
          		value=0.00;
          	}
          	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
          }
   	
   	var rendererstring1=function (aggregates){
           var value1=aggregates['sum1'];
           return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
          }
   	
        var num = 0; 
       var source =
            {
                datatype: "json",
                datafields: [
							{ name : 'employeeid', type: 'string' },
							{ name : 'employeename', type: 'string' },
							{ name : 'dates', type: 'string' },
							{ name : 'daystopay', type: 'number' },
							{ name : 'posted', type: 'number' },
      						{ name : 'paid', type: 'number' }, 
							{ name : 'basicsalary', type: 'number' },
							{ name : 'totalsalary', type: 'number' },
							{ name : 'overtime', type: 'number' },
							{ name : 'grosssalary', type: 'number' },
							{ name : 'additions', type: 'number' },
							{ name : 'deductions', type: 'number' },
							{ name : 'loan', type: 'number' },
							{ name : 'netsalary', type: 'number' },
							{ name : 'remarks', type: 'string' },
							{ name : 'employeedocno', type: 'int' },
							{ name : 'empcatid', type: 'int' },
							{ name : 'rdocno', type: 'int' },
      						
     						
	            			],
	            			
                			localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            var cellclassname = function (row, column, value, data) {
        		if (data.rdocno != '0') {
        				return "whiteClass";
                } else{
                	return "whiteClass";
                };
            };
            
            $("#jqxpasGrid").jqxGrid(
            {
            	width: '100%',
    	        height: 500,
    	        source: dataAdapter,
    	        showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
                //localization: {thousandsSeparator: ""},
    	        filtermode:'excel',
    	        filterable: true,
    	        showfilterrow:true,
    	        selectionmode: 'singlerow',
    	        pagermode: 'default',
    	        sortable:false,
                columnsresize:true,
                enabletooltips:true,
                columns: 
                	[
						{ text: 'Emp. ID', pinned: true, datafield: 'employeeid', editable: false, cellclassname: cellclassname, width: '5%' },
						{ text: 'Emp. Name', pinned: true, datafield: 'employeename', editable: false, cellclassname: cellclassname, width: '15%' },
						{ text: 'Date', pinned: true, datafield: 'dates', editable: false, cellclassname: cellclassname, width: '5%' },
						{ text: 'Days To Pay', pinned: true, datafield: 'daystopay', cellsformat: 'd2', width: '6%', editable: false, cellclassname: cellclassname, cellsalign: 'center', align: 'center', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
						{ text: 'Posted', datafield: 'posted', editable: false, width: '4%'},
						{ text: 'Paid', datafield: 'paid', editable: false, width: '4%',},
					    { text: 'Earned Basic', datafield: 'basicsalary', cellsformat: 'd2', width: '5%', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Earned Allowances', datafield: 'totalsalary', cellsformat: 'd2', editable: false, width: '5%', cellsalign: 'right', align: 'right', cellclassname: 'redClass', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Overtime', datafield: 'overtime', editable: false, cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right', cellclassname: 'redClass', aggregates: ['sum'],aggregatesrenderer:rendererstring },
						{ text: 'Gross Salary', datafield: 'grosssalary', editable: false, cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right', cellclassname: 'blueClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Additions', datafield: 'additions', editable: false, cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right', cellclassname: 'yellowClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Deductions', datafield: 'deductions', editable: false, cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Loan', datafield: 'loan', editable: false, cellsformat: 'd2', width: '6%', cellsalign: 'right', align: 'right', cellclassname: 'greenClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Netsalary', datafield: 'netsalary', editable: false, cellsformat: 'd2', width: '5%', cellsalign: 'right', align: 'right', cellclassname: 'darkRedClass', aggregates: ['sum'], aggregatesrenderer:rendererstring },
						{ text: 'Remarks', datafield: 'remarks', editable: false, width: '18%'},
						{ text: 'Emp. ID', datafield: 'employeedocno', editable: false, width: '7%', hidden: true },
						{ text: 'Emp. CategoryID', datafield: 'empcatid', editable: false, width: '7%', hidden: true },
						{ text: 'Payroll Doc No', datafield: 'rdocno', editable: false, width: '7%', hidden: true },
						
						 ]
            });
            $("#overlay, #PleaseWait").hide();
   });
  </script>
   <div id="jqxpasGrid"></div>