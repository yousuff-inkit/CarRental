<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.openingbalance.ClsIMOpeningBalanceDAO"%>
<% ClsIMOpeningBalanceDAO DAO= new ClsIMOpeningBalanceDAO(); %>
<% 
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 

	var data;
	var dataExcelExport;
 $(document).ready(function () { 	
 	
 		
 		data='<%=DAO.openingbalanceGridLoading()%>';   
 		<%-- dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>'; --%>  
 	 
 	//alert(data);     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
        	 

				{ name: 'id', type: "int" },
				{ name: 'srno', type: "String" },
				{ name: 'accountno', type: "string" },
				{ name: 'accountname', type: "string" },
             { name: 'doc_no', type: "string" },
             {name : 'date', type: "string" },
             {name : 'debit', type: "string" },
             {name : 'credit', type: "string" },
             {name : 'desc', type: "string" },
           	   ],
              		 localdata: data, 
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
                                      
          };
          
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });


$("#openingbalanceGrid").jqxGrid(
{
	width: '100%',
 height: 550,
 source: dataAdapter,
 editable: true,
 selectionmode: 'singlecell',
 localization: {thousandsSeparator: ""}, 
 showaggregates: true,
 rowsheight:25,
 enabletooltips:true,
showfilterrow:true,
enabletooltips:true,
filterable:true,
 columns: [
					{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					
					
					{ text: 'ID', datafield: 'id', editable: false , width: '3%' },
					{ text: 'Serial No', datafield: 'srno', editable: false , width: '6%' },
					{ text: 'Account No',  datafield: 'accountno', editable: false , width: '10%' },
					{ text: 'Account Name', datafield: 'accountname',width: '20%' , editable: false},			
					{ text: 'Date',  datafield: 'date',width: '10%' , editable: false },			
					{ text: 'Doc_no', datafield: 'doc_no',   width: '10%'  },
					{ text: 'Debit', datafield: 'debit',   width: '10%'   },
					{ text: 'Credit', datafield: 'credit',   width: '10%'   },
					{ text: 'Description', datafield: 'desc' },
					
					],

    });
   
    
    

            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="openingbalanceGrid"></div>
