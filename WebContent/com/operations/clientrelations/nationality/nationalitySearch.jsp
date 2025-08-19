<%@page import="com.operations.clientrelations.nationality.ClsNationalityAction" %>
<%ClsNationalityAction coa=new ClsNationalityAction(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
    var data= '<%=coa.searchDetails(check) %>';
        $(document).ready(function () { 	
            
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
     						{name : 'name', type: 'String'  }
                          	
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
		            }		
            );
            $("#jqxColorSearch").jqxGrid(
            {
                width: '100%',
                height: 358,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                //pagermode: 'default',
                sortable: true,
                //Add row method
                columns: [
					{ text: 'Doc No',filtertype:'number', datafield: 'DOC_NO', width: '40%' },
					{ text: 'Name', datafield: 'name',columntype: 'textbox', filtertype: 'input', width: '60%' }
	              ]
            });
          
            $('#jqxColorSearch').on('rowdoubleclick', function (event) 
            		{ 
            			var rowindex1=event.args.rowindex;
              		 	 document.getElementById("docno").value= $('#jqxColorSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
               			 document.getElementById("txtname").value = $("#jqxColorSearch").jqxGrid('getcellvalue', rowindex1, "name");                
            	 		 $('#window').jqxWindow('hide');
            		 }); 
          
        });
    </script>
    <div id="jqxColorSearch"></div>
