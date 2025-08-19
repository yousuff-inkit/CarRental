<%@page import="com.dashboard.consolidated.employeeanalysis.ClsEmployeeAnalysisDAO"%>
<% ClsEmployeeAnalysisDAO DAO= new ClsEmployeeAnalysisDAO (); %>

<%    String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno");
      String branch = request.getParameter("branch")==null?"NA":request.getParameter("branch").trim();
      String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
      String dbname = request.getParameter("dbname")==null?"":request.getParameter("dbname").trim();%>

<style>     
 		.redClass { background-color: #FFEBEB; }       
 		   
        .yellowClass { background-color: #FFFFD1; }
        
        .orangeClass { background-color: #FFEBC2; }
        
        .lightGreenClass { background-color: #F1F8E0; }
	    
	   .lightBlueClass { background-color: #CEECF5; }
        
        .creamClass { background-color: #FFFAFA; }
        
        .violetClass { background-color: #F8E0F7; }
        
        .lightBrownClass { background-color: #F7F2E0; }
        
        .whiteClass { background-color: #fff; }
        
        .folllowUpClass { background-color: #E0F8F1; }
</style>


<script type="text/javascript">

     var data1='<%= DAO.loaddoclist(empdocno, branch, check, dbname) %>';  

      $(document).ready(function () {
    	  
    	  
        	
        	var source =
            {
                datatype: "json",
                datafields: [
					{name : 'empid', type: 'String'  },
					{name : 'empname', type: 'String'  },
					{ name: 'designation', type: 'string' },
	                { name: 'department', type: 'string' },
				    {name : 'pmmob' , type: 'String' },
				    {name : 'document' , type: 'String' },
				    {name : 'expirydate', type: 'date'  },
				    {name : 'followupdate', type: 'date'  },
				    {name : 'empdocno', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'docid', type: 'int'  },
				    {name : 'empinfo', type: 'string'  },
				    {name : 'view', type: 'string'  },
				    {name : 'attach', type: 'string'  }
	            ],
                localdata: data1,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	var cellclassname = function (row, column, value, data) {
        		if (data.docid == 1) {
                    return "redClass";
                } else if (data.docid == 2) {
                    return "yellowClass";
                } else if (data.docid == 3) {
                    return "lightGreenClass";
                } else if (data.docid == 4) {
                    return "lightBlueClass";
                } else if (data.docid == 5) {
                    return "creamClass";
                } else if (data.docid == 6) {
                    return "violetClass";
                } else if (data.docid == 7) {
                    return "lightBrownClass";
                }  else if (data.docid == 8) {
                   return "orangeClass";
                } else{
                	return "whiteClass";
                };
            };
        
        	var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
        	  $("#expirydetailsgrid").jqxGrid(
        	            {
        	                width: '98%',
        	                height: 200,
        	                source: dataAdapter,
        	                filterable: true,
        	                showfilterrow: true,
        	                enabletooltips:true,
        	                columnsresize: true,
        	                sortable: true,
        	                rowsheight:25,
        	                selectionmode: 'singlerow',
        	                editable: false,
        	                
        	                columns: [
        							{ text: 'Emp. ID', datafield: 'empid', width: '8%' },
        							{ text: 'Employee', datafield: 'empname', width: '25%' },
        							{ text: 'Designation', datafield: 'designation', width: '12%' },
        							{ text: 'Department', datafield: 'department', width: '10%' },
        							{ text: 'Mobile No.', datafield: 'pmmob', width: '10%' },
        							{ text: 'Document', datafield: 'document', cellclassname: cellclassname,  width: '15%' },
        							{ text: 'Expiry Date', datafield: 'expirydate', cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy' , width: '10%' },
        							{ text: 'Follow-Up Date', datafield: 'followupdate', cellclassname: 'folllowUpClass',  cellsformat: 'dd.MM.yyyy' , width: '10%' },
        							//{ text: 'View', datafield: 'view', width: '6%',columntype:'button' },
        							//{ text: 'Attach', datafield: 'attach', width: '6%',columntype:'button' },
        							{ text: 'Emp. DocNo', datafield: 'empdocno', hidden: true, width: '10%' },
        							{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
        							{ text: 'Document Id', datafield: 'docid', hidden: true, width: '10%' },
        							{ text: 'Employee Info', datafield: 'empinfo', hidden: true, width: '10%' },
        						 ]
        	            });
        	  
        	 /*  $('#expirydetailsgrid').on('rowdoubleclick', function (event) { 
               	  var rowindex1=event.args.rowindex;
        	 
               	  document.getElementById("empdocno").value=$('#expirydetailsgrid').jqxGrid('getcellvalue', rowindex1, "empdocno"); 
               	  document.getElementById("empid").value=$('#expirydetailsgrid').jqxGrid('getcellvalue', rowindex1, "empid");
               	  
                 });   */
        	            
        	  $("#overlay, #PleaseWait").hide();
              
      });
  </script>
  <div id="expirydetailsgrid"></div>
        	          
         