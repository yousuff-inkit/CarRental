<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO();

%>
<% String docNo4 = request.getParameter("txtclientdocno4")==null?"0":request.getParameter("txtclientdocno4");


    %>
 <script type="text/javascript">

   
	 var clientData='<%=DAO.refDetailsSearchreload(docNo4)%>';
	      


	$(document).ready(function () { 

 		var source = 
         {
             datatype: "json",
             datafields: [
                      
  						   {name : 'idname', type: 'string'   },
  						   {name : 'seqno', type: 'string'  },
  						   {name : 'numbr', type: 'string'  },
  						   {name : 'validupto', type: 'date'  }
  						   
  				
                       	],
                       	localdata: clientData,
             
             pager: function (pagenum, pagesize, oldpagenum) {
                
             }  
         };
 		
 		
           
         var dataAdapter = new $.jqx.dataAdapter(source,
         		 {
             		loadError: function (xhr, status, error) {
                  alert(error);    
                  }
           }		
         );
         

         $("#refdetsearch").jqxGrid(
         {
             width: '99.5%',
             height: 230,
             source: dataAdapter,
             selectionmode: 'singlerow',
  			 editable: true,
  			 columnsresize: true,
  			 localization: {thousandsSeparator: ""},
  			
             columns: [
						{ text: 'ID Details', datafield: 'idname',editable:false },
						{ text: 'Seq No', datafield: 'seqno', width: '10%',editable:false ,hidden:true},
						{ text: 'Number', datafield: 'numbr', width: '20%' },
				        {
			                text: 'Valid Upto',
			                datafield: 'validupto',
			                width: 150,
			                cellsformat: 'dd.MM.yyyy',
			                columntype: 'datetimeinput',
			                filtertype: 'date',
			                cellsalign: 'right',
			                align: 'right'
			            }, 
			          
						
				       ]
               });
    
}); 
				       
                       
</script>
   
<div id="refdetsearch"></div>
    