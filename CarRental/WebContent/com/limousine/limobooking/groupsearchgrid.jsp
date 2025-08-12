<%@page import="com.limousine.limobooking.*" %>
<%ClsLimoBookingDAO limodao=new ClsLimoBookingDAO(); %>
 <script type="text/javascript">
var data='<%=request.getParameter("datafield")==null?"":request.getParameter("datafield")%>';
var gridname='<%=request.getParameter("gridname")==null?"":request.getParameter("gridname")%>';
var gridrowindex='<%=request.getParameter("gridrowindex")==null?"":request.getParameter("gridrowindex")%>';
var groupdatawindowsearch= '<%=limodao.getGroupData()%>';

        $(document).ready(function () { 	

        	
        	// prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'gid', type: 'string'},
     						{name : 'docno', type: 'string'}
     											
                 ],               
               localdata:groupdatawindowsearch,
                
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

            
            
            $("#groupSearch").jqxGrid(
            {
                width: '100%',
                height: 350,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
               // editable: true,
                altRows: true,
                showfilterrow: true,
                filterable: true, 
                sortable: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                  /*   var cell = $('#invAcSearch').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'description' && cell.rowindex == num - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 13) {                                                        
                            var commit = $("#invAcSearch").jqxGrid('addrow', null, {});
                            num++;                           
                        }
                    } */
                },
                
  
                
                columns: [
                           	{ text:'Doc No',datafield:'docno',width:'20%'},	
							{ text: 'Group', datafield: 'gid', width: '80%' }
												
	              		]
            });
       $('#groupSearch').on('rowdoubleclick', function (event) {
            	var rowindex=event.args.rowindex;
            	
            	//alert("DoubleClicked - "+gridname+" - "+gridrowindex+" - "+rowindex);
                	$("#transferGrid").jqxGrid('setcellvalue', gridrowindex, "groupid", $('#groupSearch').jqxGrid('getcellvalue', rowindex, "gid"));
                	$("#transferGrid").jqxGrid('setcellvalue', gridrowindex, "gid", $('#groupSearch').jqxGrid('getcellvalue', rowindex, "docno"));	
            	
                $('#groupwindow').jqxWindow('close');
                });
            
        });
    </script>
    <div id="groupSearch"></div>
 
