<%@ page import=" com.dashboard.vehicle.vehmgmt.ClsVehMgmtDAO" %>
<%ClsVehMgmtDAO cvd=new ClsVehMgmtDAO(); %>


 <%
          String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval").trim();
          String groupval = request.getParameter("groupval")==null?"0":request.getParameter("groupval").trim();
          
          	  %> 
<script type="text/javascript">
	 var taridatas;
		taridatas= '<%=cvd.searchmasterTariff(barchval,groupval)%>';
		

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'doc_no', type: 'string'  },
						{name : 'tariftype', type: 'string'  },
						
						],
				    localdata: taridatas,
        
        
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
    
    
    $("#maintariffGrid").jqxGrid(
    {
        width: '90%',
        height: 260,
        source: dataAdapter,
        rowsheight:20,
    
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [
              	          { text: 'Doc NO', datafield: 'doc_no', width: '30%'},
						{ text: 'Tariff Type', datafield: 'tariftype', width: '70%' },
					
					
					
					]
    
    });
  /*   if(bb==1)
	{
	 $("#maintariffGrid").jqxGrid('addrow', null, {});
	} */
    $('#maintariffGrid').on('rowdoubleclick', function (event) 
    		{ 
    		
    		    var boundIndex = event.args.rowindex;
    		    var descval = $('#maintariffGrid').jqxGrid('getcelltext',boundIndex, "doc_no");
    		    
    		    var branchid='<%=barchval%>';
    		    var group='<%=groupval%>';
                var id=1;
    		    
    		    $("#tariffshowdiv").load("tariffShowgrid.jsp?docval="+descval+"&groupval="+group+"&branchval="+branchid+"&id=1");
    		});
});

	
	
</script>
<div id="maintariffGrid"></div>