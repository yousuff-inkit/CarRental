<%@ page import=" com.dashboard.vehicle.vehmgmt.ClsVehMgmtDAO" %>
<%ClsVehMgmtDAO cvd=new ClsVehMgmtDAO(); %>

<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>   --%>

 <%
    String fleetno = request.getParameter("fleetno")==null?"NA":request.getParameter("fleetno").trim();
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  	String ready = request.getParameter("ready")==null?"0":request.getParameter("ready").trim();
  	
 %> 
         	  
 
<script type="text/javascript">

 var temp4='<%=fleetno%>';
var datamov=[];

 if(temp4!='NA')
{ 
	
	 datamov='<%=cvd.vehmovementSearch(fleetno,fromdate,todate,ready)%>'; 
	
} 

//alert(datamov);
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
   
                  
                     
                        {name : 'rdtype', type: 'String'  },
						{name : 'rdocno', type: 'string'  },
						{name : 'flname', type: 'String'  },
						{name : 'status', type: 'String'  },
						{name : 'trancode', type: 'String'  },
						{name : 'obrhid', type: 'String'  },
						{name : 'dout', type: 'date'},
						{name : 'tout', type: 'String'},
						{name : 'kmout', type: 'String'  },
					
						{name : 'fout', type: 'string'  },
						{name : 'ibrhid', type: 'string'  },
						{name : 'hidrdocno',type:'number'},
	
						{name : 'din', type: 'date'},
						{name : 'tin', type: 'String'},
						{name : 'kmin', type: 'String'},
						{name : 'fin', type: 'String'  },
						{name : 'fleet_no', type: 'String'},
						{name : 'reg_no', type: 'String'  },
						{name : 'empname', type: 'String'  },
						{name : 'outbranch',type:'string'},
						{name : 'inbranch',type:'string'},
						{name : 'outlocation',type:'string'},
						{name : 'inlocation',type:'string'}
						
						
					
						
						],
				    localdata: datamov,
        
        
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
    
    
    
  


   
   
    
    $("#vehmovement").jqxGrid(
    {
        width: '100%',
        height: 350,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        columnsresize:true,
        editable:false,
        columns: [   
                  
        	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
			    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
			}   },
					
              	 { text: 'Fleet', datafield: 'fleet_no',  width: '6%' }, 
              	 { text: 'Reg No', datafield: 'reg_no',  width: '6%' }, 
           	         { text: 'Type', datafield: 'rdtype',  width: '6%' }, 
					 { text: 'Ref No', datafield: 'rdocno', width: '6%'},
					 { text: 'Name', datafield: 'flname', width: '15%'},
				     { text: 'Status',datafield: 'status', width: '5%' },
				     { text: 'Trancode',datafield: 'trancode', width: '10%' },
				     { text: 'User',datafield: 'empname', width: '15%' },
					 { text: 'Branch Out', datafield: 'obrhid', width: '6%',hidden:true },
					 { text: 'Branch Out', datafield: 'outbranch', width: '6%' },
					 { text: 'Location Out', datafield: 'outlocation', width: '8%' },
					 { text: 'Date Out', datafield: 'dout', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time Out', datafield: 'tout', width: '7%'},
					 { text: 'KM Out', datafield: 'kmout', width: '7%'},
					 { text: 'Fuel Out', datafield: 'fout', width: '7%'},
					 { text: 'Branch In', datafield: 'ibrhid', width: '7%',hidden:true},
					 { text: 'Branch In', datafield: 'inbranch', width: '7%'},
					 { text: 'Location In', datafield: 'inlocation', width: '10%'},
					 { text: 'Date In', datafield: 'din', width: '7%',cellsformat:'dd.MM.yyyy'},
					 { text: 'Time In', datafield: 'tin', width: '7%'},
					 { text: 'KM In', datafield: 'kmin', width: '7%'},
					 { text: 'Fuel In', datafield: 'fin', width: '7%'},
					 { text: 'Hid Rdocno', datafield: 'hidrdocno', width: '10%',hidden:true},
					]
   
    });
    
    
    $("#overlay, #PleaseWait").hide();
    
});


</script>
<div id="vehmovement"></div>