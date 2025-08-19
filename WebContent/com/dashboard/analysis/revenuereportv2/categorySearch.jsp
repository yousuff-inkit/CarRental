
<%@ page import="com.dashboard.analysis.revenuereportv2.ClsRevenueReportDAO" %>
<%ClsRevenueReportDAO cgd=new ClsRevenueReportDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

 <script type="text/javascript">
 

  

 var data21='<%=cgd.categorySearch()%>';
         
        $(document).ready(function () { 
         
            var source = 
            {
                datatype: "json",
                datafields: [
                 		
     						{name : 'doc_no', type: 'String'  },
     						{name : 'category', type: 'String'  },
      					
                          	],
                          	localdata: data21,
                
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
            $("#jqxcategorySearch").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
               
                columns: [  
							{ text: 'Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Category', datafield: 'category', width: '100%' },
							
				
					]
            });
    

      
				            
            $('#jqxcategorySearch').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("txtcategory").value = $('#jqxcategorySearch').jqxGrid('getcellvalue', rowindex1, "category");
                document.getElementById("hidtxtcategory").value = $('#jqxcategorySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	$('#categoryWindow').jqxWindow('close'); 
            });  
				           
 }); 

</script>
<div id="jqxcategorySearch"></div>
    
