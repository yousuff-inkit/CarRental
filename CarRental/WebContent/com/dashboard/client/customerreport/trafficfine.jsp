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
var trafficdata=[];
$(document).ready(function () {
	
	trafficdata= '<%=searchDAO.trafficfineList(barchval,acno,check,fromDate,toDate) %>';   
	 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
            {name : 'slno', type: 'int'  },

                     {name : 'tfnum', type: 'string'  },
                     {name : 'tdate', type: 'date'  },
                     {name : 'time', type: 'string'  },
                     {name : 'pltnum', type: 'string'  },
                     {name : 'description', type: 'string'  },
                     {name : 'agreemnt', type: 'int'  },
                     {name : 'rentltype', type: 'string'  },
                     {name : 'lpono', type: 'string'  },
                     {name : 'invno', type: 'string'  },
                     {name : 'amount', type: 'number'  },
                     {name : 'cusacno', type: 'string'  },
                     {name : 'cusname', type: 'string'  },
                     {name : 'catgry', type: 'string'  },
						],
				    localdata: trafficdata,
        
        
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
    
    
   
   
    
    $("#trafficfineGrid").jqxGrid(
    {
        width: '99%',
        height: 100,
        source: dataAdapter,
        //showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        //filterable: true,
        sortable:true,
        enabletooltips:true,
       // showfilterrow:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:false,
        columns: [   
            { text: 'SL#',datafield: 'slno', editable: false,width:'4%',cellsalign:'center',align:'center'},
                    { text: 'TF_Number',datafield: 'tfnum', editable: false,width:'8%' },
                    { text: 'Date',datafield: 'tdate', width: '8%', editable: false,cellsformat:'dd.MM.yyyy' },  
        			 { text: 'Time', datafield: 'time', width: '5%'},
        			 { text: 'Plate_Number', datafield: 'pltnum', width: '6%'},
        			 { text: 'Description', datafield: 'description', width: '10%'},
        			 { text: 'Agreement', datafield: 'agreemnt', width: '8%'},
        			 { text: 'Rental Type', datafield: 'rentltype', width: '5%'},
        			 { text: 'LPO no', datafield: 'lpono', width: '8%'},
        			 { text: 'INV No#', datafield: 'invno', width: '8%'},
        			 { text: 'Amount', datafield: 'amount', width: '6%',cellsformat:'d2',cellsalign:'right',align:'right'},
        			 { text: 'Cus AcNO.', datafield: 'cusacno',width:'6%'},
        			 { text: 'Customer Name', datafield: 'cusname',width:'15%'},
        			 { text: 'Category', datafield: 'catgry', width: '10%'},
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="trafficfineGrid"></div>