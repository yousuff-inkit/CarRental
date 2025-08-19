<%@page import="com.dashboard.consolidated.stocklist.ClsStocklistDAO"%>
 <% ClsStocklistDAO searchDAO = new ClsStocklistDAO(); 
    String barchval = request.getParameter("barchval")==null?"NA":request.getParameter("barchval").trim();
  	String psrno = request.getParameter("psrno")==null?"NA":request.getParameter("psrno").trim();
  	String statusselect = request.getParameter("statusselect")==null?"0":request.getParameter("statusselect").trim();
  	String load = request.getParameter("load")==null?"0":request.getParameter("load").trim();
  	String locid = request.getParameter("locid")==null?"0":request.getParameter("locid").trim();
  	String hidbrand = request.getParameter("hidbrand")==null?"0":request.getParameter("hidbrand").trim();
	String hidtype = request.getParameter("hidtype")==null?"0":request.getParameter("hidtype").trim();
	String hidproduct = request.getParameter("hidproduct")==null?"0":request.getParameter("hidproduct").trim();
	String hidcat = request.getParameter("hidcat")==null?"0":request.getParameter("hidcat").trim();
	String hidsubcat = request.getParameter("hidsubcat")==null?"0":request.getParameter("hidsubcat").trim();
	String hidept = request.getParameter("hidept")==null?"0":request.getParameter("hidept").trim();
	String zeroqty = request.getParameter("zeroqty")==null?"0":request.getParameter("zeroqty").trim();
	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	String expupto = request.getParameter("expupto")==null?"0":request.getParameter("expupto").trim();
	String hidcompid = request.getParameter("hidcompid")==null?"0":request.getParameter("hidcompid").trim();   
	System.out.println("===hidcompid===="+hidcompid);
 %> 
<script type="text/javascript">
 var temp4='<%=barchval%>';
 var dataurl;
 
 var barchval = '<%=barchval%>';
 var psrno = '<%=psrno%>';
 var statusselect = '<%=statusselect%>';
 var load = '<%=load%>';
 var locid = '<%=locid%>';
 var hidbrand = '<%=hidbrand%>';
 var hidtype = '<%=hidtype%>';
 var hidproduct = '<%=hidproduct%>';
 var hidcat = '<%=hidcat%>';
 var hidsubcat = '<%=hidsubcat%>';
 var hidept = '<%=hidept%>';
 var zeroqty = '<%=zeroqty%>';
 var todate = '<%=todate%>';
 var expupto = '<%=expupto%>';
 var hidcompid = '<%=hidcompid%>';   
 
 if(temp4!='NA') { 
	 dataurl = 'getStockSummaryData.jsp?barchval='+barchval+'&load='+load+'&locid='+locid+'&hidbrand='+hidbrand+'&hidtype='+hidtype+'&hidproduct='+hidproduct+
	 '&hidcat='+hidcat+'&hidsubcat='+hidsubcat+'&hidept='+hidept+'&zeroqty='+zeroqty+'&todate='+todate+'&expupto='+expupto+'&hidcompid='+hidcompid;  
	 <%-- datas='<%=searchDAO.stocklist(barchval,load,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,hidept,zeroqty,todate,expupto)%>';  --%>
	 <%-- datass='<%=searchDAO.stockExcellistqty(barchval,load,locid,hidbrand,hidtype,hidproduct,hidcat,hidsubcat,hidept,zeroqty,todate,expupto)%>'; --%>    
 } else { 
	dataurl;
 }  

$(document).ready(function () {
	  /* var rendererstring1=function (aggregates){
         	var value=aggregates['sum1'];
         	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total" + '</div>';
         }  */   
      
   var rendererstring=function (aggregates){   
   	var value=aggregates['sum'];
	if(value==""||typeof(value)=="undefined"|| typeof(value)=="NaN")
	   {
		value=0.0;
	   }
   	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;"> ' + value + '</div>';
   }
      
    var source =
    {
        datatype: "json",
        datafields: [   
        	            {name : 'reservedqty', type: 'number'  },    
						{name : 'qty', type: 'number'  },
						{name : 'productid', type: 'String'  },
						{name : 'productname', type: 'String'  },
						{name : 'amount', type: 'number'  },
						{name : 'brandname', type: 'String'  },
						{name : 'expry', type: 'String'  },
						{name : 'price', type: 'String'  },
						{name : 'foc1', type: 'String'  },
						{name : 'foc2', type: 'String'  },
						{name : 'foc3', type: 'String'  },
						{name : 'department', type: 'String'  },
						{name : 'scancode', type: 'String'  },
						{name : 'batch_no', type: 'String'  },   
						{name : 'dbname', type: 'String'  }, 
						{name : 'compname', type: 'String'  },  
						{name : 'branch', type: 'String'  },
						{name : 'location', type: 'String'  },
						{name : 'sal_name', type: 'String'  }, 
						{name : 'psrno', type: 'String'  },     
						
						],
				    //localdata: datas,
				    	url : dataurl,    
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                //alert(error);    
                }
	            }		
    );
    
    $("#stocklistgrid").jqxGrid(
    {
        width: '99%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        columnsresize: true,
        selectionmode: 'singlerow',
        showfilterrow: true,
        pagermode: 'default',
        editable:false,
        showaggregates: true,
        showstatusbar:true,
        rowsheight:25,
        statusbarheight:25,
        enabletooltips:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '5%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
           	         { text: 'Product Id', datafield: 'productid',  width: '6%' }, 
           	         { text: 'Product Name', datafield: 'productname', width: '15%'   },
           	         { text: 'Company', datafield: 'compname', width: '15%'}, 
           	         { text: 'Branch', datafield: 'branch', width: '12%'},
           	         { text: 'Location', datafield: 'location', width: '8%' },
           	   	     { text: 'Brand Name', datafield: 'brandname', width: '10%' },
           	         { text: 'Qty', datafield: 'qty',  width: '7%' ,cellsformat:'d2',cellsalign:'right',align:'right', aggregates: ['sum'],aggregatesrenderer:rendererstring },
           	         { text: 'Reserved Qty', datafield: 'reservedqty',  width: '7%' ,cellsformat:'d2',cellsalign:'right',align:'right' },    
           	         { text: 'Expiry', datafield: 'expry', width: '10%'},
           	         { text: 'Scancode', datafield: 'scancode', width: '10%'},
           	         { text: 'Batch No', datafield: 'batch_no', width: '10%'},
           	         { text: 'Price', datafield: 'price', width: '10%',cellsalign:'right',align:'right', },
           	         { text: 'FOC1', datafield: 'foc1', width: '10%',cellsalign:'center',align:'center',hidden:true},
		           	 { text: 'FOC2', datafield: 'foc2', width: '10%',cellsalign:'center',align:'center',hidden:true},
		        	 { text: 'FOC3', datafield: 'foc3', width: '10%',cellsalign:'center',align:'center',hidden:true},
		        	 { text: 'Department', datafield: 'department', width: '10%' },
		        	 { text: 'dbname', datafield: 'dbname', width: '0%',hidden:true},
		        	 { text: 'Salesman', datafield: 'sal_name', width: '0%',hidden:true},
		        	 { text: 'Psrno', datafield: 'psrno', width: '0%',hidden:true},         
					]
    });
      
    $("#stocklistgrid").on('rowdoubleclick', function (event) {
    	 var rowindex=event.args.rowindex;      
    	  var psrno=$('#stocklistgrid').jqxGrid('getcellvalue', rowindex, "psrno"); 
    	  showSalesmanDetails(psrno);
    });
     
    $("#overlay, #PleaseWait").hide();   
});
</script>
<div id="stocklistgrid"></div>