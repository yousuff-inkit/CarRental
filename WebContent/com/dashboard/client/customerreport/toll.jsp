 <%@page import="com.dashboard.client.customerreport.ClsCustomerReportDAO"%>
 <%
 	   ClsCustomerReportDAO searchDAO= new ClsCustomerReportDAO();
 	    String barchval = request.getParameter("barchval")==null?"":request.getParameter("barchval").trim();
 	    String acno = request.getParameter("cldoc")==null?"":request.getParameter("cldoc").trim();
 	    String check = request.getParameter("check")==null?"":request.getParameter("check").trim();
 	   String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 	     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 	    System.out.println("Acc no :"+acno);
 %> 
       
 
<script type="text/javascript">
var tolldata=[];
$(document).ready(function () {
	tolldata='<%=searchDAO.tollSearchList(barchval,acno,check,fromDate,toDate) %>';   
	 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
            {name : 'slno', type: 'int'  },

                     {name : 'tollgate', type: 'string'  },
                     {name : 'tripdate', type: 'date'  },
                     {name : 'triptime', type: 'string'  },
                     {name : 'pltnum', type: 'string'  },
                     {name : 'direction', type: 'string'  },
                     {name : 'agmnt', type: 'string'  },
                     {name : 'renttype', type: 'string'  },
                     {name : 'lpono', type: 'string'  },
                     {name : 'invno', type: 'string'  },
                     {name : 'amt', type: 'number'  },
                     {name : 'cusacno', type: 'string'  },
                     {name : 'cusname', type: 'string'  },
                     {name : 'catgry', type: 'string'  },
           
						 
						
						],
				    localdata: tolldata,
        
        
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
    
    
   
   
    
    $("#tollGrid").jqxGrid(
    {
        width: '99%',
        height: 130,
        source: dataAdapter,
       // showaggregates:true,
        //enableAnimations: true,
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
	
                    { text: 'Toll_Gate',datafield: 'tollgate', editable: false,width:'10%' },
                    { text: 'Trip_Date',datafield: 'tripdate',width: '8%', editable: false,cellsformat:'dd.MM.yyyy' },  
        			 { text: 'Trip_Time', datafield: 'triptime', width: '7%'},
        			 { text: 'Plate_Number', datafield: 'pltnum', width: '8%'},
        			 { text: 'Direction', datafield: 'direction', width: '8%'},
        			 { text: 'Agreement', datafield: 'agmnt', width: '8%'},
        			 { text: 'Rental Type', datafield: 'renttype', width: '6%'},
        			 { text: 'LPO NO', datafield: 'lpono', width: '10%'},
        			 { text: 'INV No#', datafield: 'invno', width: '7%'},
        			 { text: 'Amount', datafield: 'amt', width: '5%',cellsformat:'d2',cellsalign:'right',align:'right'},
        			 { text: 'Cus AcNo', datafield: 'cusacno', width: '6%'},
        			 { text: 'Cus Name', datafield: 'cusname', width: '15%'},
        			 { text: 'Category', datafield: 'catgry', width: '10%'},
        			
        			 
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="tollGrid"></div>