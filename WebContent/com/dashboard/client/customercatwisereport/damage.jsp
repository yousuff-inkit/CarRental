 <%@page import="com.dashboard.client.customercatwisereport.ClsCustomerCatWiseReportDAO"%>
 <%
 	   ClsCustomerCatWiseReportDAO searchDAO= new ClsCustomerCatWiseReportDAO();
 	    String barchval = request.getParameter("barchval")==null?"":request.getParameter("barchval").trim();
 	    String acno = request.getParameter("cldoc")==null?"":request.getParameter("cldoc").trim();
 	    String check = request.getParameter("check")==null?"":request.getParameter("check").trim();
 	   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 	    System.out.println("Acc no :"+acno);
 %> 
       
 
<script type="text/javascript">
var damagedata;
$(document).ready(function () {
	
	damagedata='<%=searchDAO.damageSearchList(barchval,acno,check,fromDate,toDate) %>';  
	 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
            {name : 'slno', type: 'int'  },

                     {name : 'ddate', type: 'string'  },
                     {name : 'dtime', type: 'int'  },
                     {name : 'pltnum', type: 'string'  },
                     {name : 'amount', type: 'number'  },
                     {name : 'description', type: 'string'  },
                     {name : 'renttype', type: 'string'  },
                     {name : 'lpono', type: 'string'  },
                     {name : 'invno', type: 'string'  },
                     {name : 'cusacno', type: 'string'  },
                     {name : 'cusname', type: 'string'  },
                     {name : 'catgry', type: 'string'  },
             
						 
						
						],
				    localdata: damagedata,
        
        
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
    
    
   
   
    
    $("#damageGrid").jqxGrid(
    {
        width: '99%',
        height: 100,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        //filterable: true,
        sortable:true,
        enabletooltips:true,
        //showfilterrow:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columns: [   
            { text: 'SL#',datafield: 'slno', editable: false,width:'4%',cellsalign:'center',align:'center'},
	
                    { text: 'Date',datafield: 'ddate', editable: false,cellsformat:'dd.MM.yyyy',width:'8%' },
                    { text: 'Time',datafield: 'dtime',hidden:true, width: '4%', editable: false },  
        			 { text: 'Plate_Number', datafield: 'pltnum', width: '7%'},
        			 { text: 'Amount', datafield: 'amount', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right'},
        			 { text: 'Description', datafield: 'description', width: '13%'},
        			 { text: 'Rental Type', datafield: 'renttype', width: '7%'},
        			 { text: 'LPO NO', datafield: 'lpono', width: '10%'},
        			 { text: 'INV NO#', datafield: 'invno', width: '7%'},
        			 { text: 'Cus AcNo', datafield: 'cusacno', width: '7%'},
        			 { text: 'Customer Name', datafield: 'cusname',width:'20%'},
        			 { text: 'Category', datafield: 'catgry', width: '10%'},
        			
        			 
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="damageGrid"></div>