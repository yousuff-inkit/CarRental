<%@page import="com.dashboard.humanresource.workdetailsapproval.ClsWorkDetailsApprovalDAO"%>
<%ClsWorkDetailsApprovalDAO DAO= new ClsWorkDetailsApprovalDAO(); %>
<% String empdocno = request.getParameter("empdocno")==null?"0":request.getParameter("empdocno");
   String year = request.getParameter("year")==null?"0":request.getParameter("year");
   String month = request.getParameter("month")==null?"0":request.getParameter("month");
   String check = request.getParameter("check")==null?"0":request.getParameter("check");
   // System.out.println("processes = "+process);
   %>
   
   <style type="text/css">
        .editClass
        {
            
        }
        .saveClass
        {
            background-color: #F1F1F1;
            color: #000;
            font-weight: bold;
        }
       </style>
       
 <script type="text/javascript">
 var datas  ='<%=DAO.commentsGrid(year,month)%>';  

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
     						{name : 'Clear' , type : 'string'},


     						
                          	],
                          	localdata: datas,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                }
            };
     //   var cellclassname = function (row, column, value, data) {
     	//	if (data.clearbtn == 'CLEAR') {
        //     		return "clearClass";
        //     	}
       //  };
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
							{ text: '', datafield: 'Clear', width: '6%', columntype:'button',cellsrenderer: function () {
			                     return "Clear"; }},


					]
            });
         
          //  $("#commentsGrid").jqxGrid("addrow", null, {}); 

            
            $("#commentsGrid").on('cellclick', function (event) {
          		 
            	  var datafield = event.args.datafield;
            	  var rowIndex = event.args.rowindex;
     			 $('#commentsGrid').jqxGrid('setcellvalue',rowIndex, "Clear","Clear");

            
            if(datafield=="Clear"){
 					 $.messager.confirm('Message', 'Do you want to Clear?', function(r){
 				        
 				     	if(r)
 				     	 {
 				     		//alert("hio");
 				     		 var docno = $('#commentsGrid').jqxGrid('getcelltext', rowIndex, "doc_no");
 				     		// $("#overlay, #PleaseWait").show();
 				     		 
 				     		 funclearupdate(docno);	
 				     		 
 				     	}
 				 	});
 				  }
 				  
            });
        });
                       
</script>
<div id="commentsGrid"></div>