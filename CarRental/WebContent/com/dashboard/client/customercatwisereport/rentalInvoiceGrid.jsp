 <%@page import="com.dashboard.client.customercatwisereport.ClsCustomerCatWiseReportDAO"%>
 <%
 	   ClsCustomerCatWiseReportDAO searchDAO= new ClsCustomerCatWiseReportDAO();
 	    String barchval = request.getParameter("barchval")==null?"":request.getParameter("barchval").trim();
 	    String acno = request.getParameter("cldoc")==null?"":request.getParameter("cldoc").trim();
 	    String check = request.getParameter("check")==null?"":request.getParameter("check").trim();
 	   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 	     System.out.println("From dates :"+fromDate+"TODATEs :"+toDate);
 %> 
       
 
<script type="text/javascript">
var datas;
$(document).ready(function () {
	
	 datas= '<%=searchDAO.rentalSearchList(barchval,acno,check,fromDate,toDate) %>'; 
	 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                     {name : 'invdate', type: 'string'  },
                     {name : 'slno', type: 'int'  },
                     {name : 'invtype', type: 'int'  },
                     {name : 'agmntnum', type: 'int'  },
                     {name : 'renttype', type: 'string'  },
                     {name : 'invno', type: 'string'  },
                     {name : 'lpono', type: 'string'  },
                     {name : 'flname', type: 'string'  },
                     {name : 'cusaccno', type: 'string'  },
                     {name : 'cusname', type: 'string'  },
                     {name : 'catgry', type: 'string'  },
                     {name : 'vplate', type: 'string'  },
                     {name : 'invperd', type: 'string'  },
                     {name : 'invamt', type: 'number'  },
                     {name : 'vehoutdate', type: 'date'  },
						],
				    localdata: datas,
        
        
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
    
    
   
   
    
    $("#deprtmtlist").jqxGrid(
    {
        width: '99%',
        height: 140,
        source: dataAdapter,
        //showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
       // filterable: true,
        sortable:true,
        enabletooltips:true,
        //showfilterrow:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columns: [   
                  	
                    { text: 'SL#',datafield: 'slno', editable: false,width:'4%',cellsalign:'center',align:'center'},
                    { text: 'INV DATE',datafield: 'invdate', editable: false,width:'7%' },
                    { text: 'INVOICE TYPE',datafield: 'invtype',hidden:true, width: '4%', editable: false },  
        			 { text: 'AGMNT NO', datafield: 'agmntnum', width: '8%'},
        			 { text: 'Rental Type', datafield: 'renttype', width: '5%'},
        			 { text: 'INV NO#', datafield: 'invno', width: '8%'},
        			 { text: 'LPO NO', datafield: 'lpono', width: '6%'},
        			 { text: 'FLEET NAME', datafield: 'flname', width: '15%'},
        			 { text: 'CUS AcNo', datafield: 'cusaccno', width: '7%'},
        			 { text: 'CUS NAME', datafield: 'cusname',width:'15%'},
        			 { text: 'Category', datafield: 'catgry', width: '10%'},
        			 { text: 'VEH PLATE', datafield: 'vplate', width: '7%'},
        			 { text: 'INV PERIOD', datafield: 'invperd', width: '15%'},
        			 { text: 'INV Amount', datafield: 'invamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right'},
        			 { text: 'VEH OUT DATE', datafield: 'vehoutdate', width: '8%',cellsformat:'dd.MM.yyyy'},
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="deprtmtlist"></div>