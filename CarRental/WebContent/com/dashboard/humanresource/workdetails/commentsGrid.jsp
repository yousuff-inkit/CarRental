<%@page import="com.dashboard.humanresource.workdetails.ClsWorkDetailsDAO"%>
<%ClsWorkDetailsDAO DAO= new ClsWorkDetailsDAO(); %>
<% String empdocno = request.getParameter("empid")==null?"0":request.getParameter("empid");
   String year = request.getParameter("year")==null?"0":request.getParameter("year");
   String month = request.getParameter("month")==null?"0":request.getParameter("month");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   // System.out.println("processes = "+process);
   %>
 <script type="text/javascript">
 var datas  ='<%=DAO.commentsGrid(year,month,empdocno)%>';  

 $(document).ready(function (){ 
        
         var source = 
            {
                datatype: "json",
                datafields: [
                 			{name : 'doc_no', type: 'string' },
     						{name : 'costcode', type: 'String'},
     						{name : 'costtype' , type : 'string'},
     						{name : 'empid', type: 'String'},
     						{name : 'emp', type: 'String'}, 
     						{name : 'dbname' , type : 'string'},
     						{name : 'date' , type : 'date'},
     						{name : 'comments' , type : 'string'},
     						{name : 'day' , type : 'string'},


     						
                          	],
                          	localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
            
         var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
         
            $("#commentsGrid").jqxGrid({ 
            	width: '100%',
                height: 150,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable:false,
     					
                columns: [
							{ text: 'Doc_no', datafield: 'doc_no', width: '5%' },
							{ text: 'Costcode', datafield: 'costcode', width: '10%' },
							{ text: 'Costtype', datafield: 'costtype', width: '10%' },
							{ text: 'Employee Name', datafield: 'emp', width: '15%' },
							{ text: 'empid', datafield: 'empid',hidden:true, width: '10%' },
							{ text: 'Database', datafield: 'dbname',hidden:true, width: '10%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Comments', datafield: 'comments' },
							{ text: 'Day', datafield: 'day', width: '10%',hidden:true},


					]
            });
         
            $("#commentsGrid").jqxGrid("addrow", null, {}); 
            
            $('#commentsGrid').on('rowdoubleclick', function (event) {
	   			   var rowIndex = event.args.rowindex;
	   			  var rows = $('#commentsGrid').jqxGrid('getrows');
          	      var rowlength= rows.length;
          	    for(i=0;i<=rowlength-1;i++) {
	          		
	   			 $('#hidcostcode').val($("#commentsGrid").jqxGrid('getcellvalue', i, "code"));
	   			   $('#hidcosttype').val($("#commentsGrid").jqxGrid('getcellvalue', i, "costtype"));
	   			   $('#hiddbname').val($("#commentsGrid").jqxGrid('getcellvalue', i, "dbname"));
	   			   $('#hiddoc_no').val($("#commentsGrid").jqxGrid('getcellvalue', i, "doc_no"));
	   			   $('#hidday').val($("#commentsGrid").jqxGrid('getcellvalue', i, "day"));
	   			   //alert($("#commentsGrid").jqxGrid('getcellvalue', i, "doc_no"));
          	    }

       	     
            });
        });
                       
</script>
<div id="commentsGrid"></div>