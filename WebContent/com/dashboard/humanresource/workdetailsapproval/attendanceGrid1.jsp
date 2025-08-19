<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.humanresource.workdetailsapproval.ClsWorkDetailsApprovalDAO"%>
<%ClsWorkDetailsApprovalDAO DAO= new ClsWorkDetailsApprovalDAO(); %> 
<% String totDays = request.getParameter("totdays")==null?"0":request.getParameter("totdays");
   String year = request.getParameter("year")==null?"2016":request.getParameter("year");
   String month = request.getParameter("month")==null?"01":request.getParameter("month");
 //  String empId = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");

   %> 
     
<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #fff;
        }
         .greenClass
        {
           background-color: #BEFF33;
        }
</style>
<script type="text/javascript">
		var temp='<%=year%>';
		var tempDays='<%=totDays%>'; 
		var month='<%=month%>';
		var year='<%=year%>';
		var check='<%=check%>';
		var branch='<%=branch%>';

		var data;
		var dataExcelExport;
        $(document).ready(function () { 	
        	
        	if(temp!='2016')
        	 { 
        		
        		data='<%=DAO.attendanceGridLoading1(session,year,totDays,month,branch)%>';   
        	//	alert(data);
        		<%-- dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>'; --%>  
        	 }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
			    	        {name : 'tr_no', type: 'int' },
			    	        {name : 'srno', type: 'int' },
                	        {name : 'costtype', type: 'string' },
					    	{name : 'code', type: 'int' },
     						{name : 'name', type: 'string' },
     						{name : 'tr_no', type: 'string' },
     						{name : 'totdays', type: 'int' },
     						{name : 'tot_leave1', type: 'number' },
     						{name : 'dbname', type: 'string' },
     						{name : 'date1', type: 'int' },
     						{name : 'date2', type: 'int' },
     						{name : 'date3', type: 'int' },
     						{name : 'date4', type: 'int' },
     						{name : 'date5', type: 'int' },
     						{name : 'date6', type: 'int' },
     						{name : 'date7', type: 'int' },
     						{name : 'date8', type: 'int' },
     						{name : 'date9', type: 'int' },
     						{name : 'date10', type: 'int' },
     						{name : 'date11', type: 'int' },
     						{name : 'date12', type: 'int' },
     						{name : 'date13', type: 'int' },
     						{name : 'date14', type: 'int' },
     						{name : 'date15', type: 'int' },
     						{name : 'date16', type: 'int' },
     						{name : 'date17', type: 'int' },
     						{name : 'date18', type: 'int' },
     						{name : 'date19', type: 'int' },
     						{name : 'date20', type: 'int' },
     						{name : 'date21', type: 'int' },
     						{name : 'date22', type: 'int' },
     						{name : 'date23', type: 'int' },
     						{name : 'date24', type: 'int' },
     						{name : 'date25', type: 'int' },
     						{name : 'date26', type: 'int' },
     						{name : 'date27', type: 'int' },
     						{name : 'date28', type: 'int' },
     						{name : 'date29', type: 'int' },
     						{name : 'date30', type: 'int' },
     						{name : 'date31', type: 'int' },
     						{name : 'confirmed', type: 'string' },
     						{name : 'empname', type: 'string' },
     						{name : 'emp', type: 'string' },
     						{name : 'brhid', type: 'string' },
     						{name : 'clientaprvdhrs', type: 'string' },
     						{name : 'pholiday', type: 'string' },
     						{name : 'comments', type: 'string' },

     						   ],
                		 localdata: data, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
        
            
            
      
            
            $("#attendanceGrid1ID").on("bindingcomplete", function (event) {
					 if(tempDays=='28'){
						    $('#attendanceGrid1ID').jqxGrid('hidecolumn', 'date29');
							$("#attendanceGrid1ID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGrid1ID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='29'){
							$("#attendanceGrid1ID").jqxGrid('hidecolumn', 'date30');
			    			$("#attendanceGrid1ID").jqxGrid('hidecolumn', 'date31');
					 }else if(tempDays=='30'){
			    			$("#attendanceGrid1ID").jqxGrid('hidecolumn', 'date31');
					 }else{
						    $("#attendanceGrid1ID").jqxGrid('showcolumn', 'date29');
						    $("#attendanceGrid1ID").jqxGrid('showcolumn', 'date30');
						    $("#attendanceGrid1ID").jqxGrid('showcolumn', 'date31');
					 }
					 
					  
            });
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#attendanceGrid1ID").jqxGrid(
            {
            	width: '100%',
                height: 180,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                showaggregates: true,
                filterable:true,
                showfilterrow:true,
                rowsheight:25,
                enabletooltips:true,

                columns: [
							{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '2%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
						//	{ text: 'C Type', datafield: 'costtype', editable: false, cellclassname: 'whiteClass', width: '3%' },
						//	{ text: 'Code',  datafield: 'code', editable: false, cellclassname: 'whiteClass', width: '3%' },
							{ text: 'Employee', datafield: 'empname', editable: false},			
						//	{ text: 'Client',  datafield: 'name', editable: false,  cellclassname: 'whiteClass' },			
							{ text: '1', datafield: 'date1',   width: '2%',aggregates: ['sum']  },
							{ text: '2', datafield: 'date2',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum'] },
							{ text: '3', datafield: 'date3',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '4', datafield: 'date4',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '5', datafield: 'date5',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '6', datafield: 'date6',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '7', datafield: 'date7',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '8', datafield: 'date8',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '9', datafield: 'date9',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '10', datafield: 'date10',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '11', datafield: 'date11',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '12', datafield: 'date12',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '13', datafield: 'date13',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '14', datafield: 'date14',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '15', datafield: 'date15',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '16', datafield: 'date16',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '17', datafield: 'date17',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '18', datafield: 'date18',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '19', datafield: 'date19',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '20', datafield: 'date20',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '21', datafield: 'date21',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '22', datafield: 'date22',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '23', datafield: 'date23',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '24', datafield: 'date24',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '25', datafield: 'date25',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '26', datafield: 'date26',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '27', datafield: 'date27',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '28', datafield: 'date28',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '29', datafield: 'date29',   width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '30', datafield: 'date30',  width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: '31', datafield: 'date31',  width: '2%',    cellsalign: 'center', align: 'center' ,aggregates: ['sum']},
							{ text: 'Total', datafield: 'totdays',  editable: false, cellsalign: 'center', align: 'center',width: '3%'},
							{ text: 'Client Approved Hrs', datafield: 'clientaprvdhrs',  cellsalign: 'center', align: 'center',width: '3%'},

							{ text: 'dbname', datafield: 'dbname', editable: false, hidden: true ,  width: '17%' },			
							{ text: 'Leave', datafield: 'tot_leave1',hidden:true, editable: false, width: '3%', cellsalign: 'center', align: 'center' },
							{ text: 'tr_no', datafield: 'tr_no', editable: false, width: '7%', hidden: true },
							{ text: 'srno', datafield: 'srno', editable: false, width: '7%',hidden:true},
							{ text: 'empid', datafield: 'emp', editable: false, width: '7%',hidden:true},
							{ text: 'confirmed', datafield: 'confirmed', editable: false, hidden: true,aggregates: ['sum']  ,  width: '17%' },			
							{ text: 'brhid', datafield: 'brhid', editable: false, hidden: true ,  width: '17%' },			
							{ text: 'pholiday', datafield: 'pholiday', editable: false, hidden: true ,  width: '17%' },			
							{ text: 'comments', datafield: 'comments', editable: false, hidden: true ,  width: '17%' },			

							],

            });
           
            
            
	    	$("#overlay, #PleaseWait").hide();

	    	$("#attendanceGrid1ID").on('rowdoubleclick', function (event) {
	           	 var datafield = event.args.datafield;
		   			   var rowIndex = event.args.rowindex;
		   			   var columnIndex = event.args.columnindex;
		   			   var emp=$("#attendanceGrid1ID").jqxGrid('getcellvalue', rowIndex, "emp");
		   			   var dbname=$("#attendanceGrid1ID").jqxGrid('getcellvalue', rowIndex, "dbname");

		   			$("#attendanceDiv").load("attendanceGrid.jsp?totdays="+tempDays+"&year="+year+"&month="+month+"&check="+check+"&branch="+branch+"&emp="+emp+"&dbname="+dbname);

		   			
		   			//alert("attendanceGrid.jsp?totdays="+tempDays+"&year="+year+"&month="+month+"&check="+check+"&branch="+branch+"");
		   			   
		   			   
	    	 });

        });
	    
	
    </script>
    <div id="attendanceGrid1ID"></div>
 