<%@page import="com.operations.vehicleprocurement.purchaserequest.ClsvehpurchasereqDAO" %>
<%
ClsvehpurchasereqDAO vpd=new ClsvehpurchasereqDAO();
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script type="text/javascript">
	var groupdata=[];
	var id='<%=id%>';
	if(id=="1"){
		groupdata='<%=vpd.getGroupData(id)%>';
	}
	
		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'vehgroup', type: 'string'  },
                            {name : 'vehgroupid', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#groupSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',                   
                columns: [
				          
                              { text: 'Doc No', datafield: 'vehgroupid', width: '20%',hidden:true},
                              { text: 'Group', datafield: 'vehgroup', width: '100%' },
                
						]
            });
            
          $('#groupSearchGrid').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex1').val();
            	// alert(rowindex1);
                var rowindex2 = event.args.rowindex;
                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "vehgroup" ,$('#groupSearchGrid').jqxGrid('getcellvalue', rowindex2, "vehgroup"));
                $('#purchasedetails').jqxGrid('setcellvalue', rowindex1, "vehgroupid" ,$('#groupSearchGrid').jqxGrid('getcellvalue', rowindex2, "vehgroupid"));
              	$('#groupwindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="groupSearchGrid"></div>