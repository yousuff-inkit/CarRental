 <%@page import="com.dashboard.invoices.rentalquarterly.*"%>
<%
ClsRentalQuarterlyInvDAO quarterlydao=new ClsRentalQuarterlyInvDAO();
String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String date1=request.getParameter("date1")==null?"":request.getParameter("date1");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String status=request.getParameter("status")==null?"0":request.getParameter("status");
%> 
<script type="text/javascript">
var status='<%=status%>';
var invcountdata=[];
if(status=="1"){
	invcountdata= '<%=quarterlydao.getInvoiceno(date1,branch,client,status)%>'; 
}

$(document).ready(function () {
   

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'desc1', type: 'string'  },
					{name : 'value', type: 'string'  }
					
						
						],
				    localdata: invcountdata,
        
        
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
    
    
    $("#rentalQuarterlyCountGrid").jqxGrid(
    {
        width: '100%',
        height: 170,
        source: dataAdapter,
        rowsheight:20,
       // showaggregates:true,
       // filtermode:'excel',
       // filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       
        columns: [

						{ text: 'Status', datafield: 'desc1', width: '50%' },
						{ text: 'Value', datafield: 'value', width: '50%'}
						
					
					]
    
    });

    $('#rentalQuarterlyCountGrid').on('rowdoubleclick', function (event){ 
		$("#overlay, #PleaseWait").hide();
    	var rowindex1=event.args.rowindex;
    	var dateval=funDateInPeriod($('#periodupto').jqxDateTimeInput('getDate'));
		if(dateval==1){
	    	var desc=$('#rentalQuarterlyCountGrid').jqxGrid("getcellvalue",rowindex1,"desc1");
	    	document.getElementById("desc").value=$('#rentalQuarterlyCountGrid').jqxGrid("getcellvalue",rowindex1,"desc1").replace(/ /g, "%20");
	    	document.getElementById("btninvoicesave").style.display="block";
	    	var date1= $('#periodupto').jqxDateTimeInput('getText');
	    	var branchvalue=document.getElementById("cmbbranch").value;
			var client=document.getElementById("hidclient").value;
			$('#rentalquarterlydiv').load('rentalQuarterlyGrid.jsp?temp='+null+'&desc1='+desc.replace(/ /g, "%20")+'&date1='+date1+'&branch='+branchvalue+'&client='+client+'&mode=2');
		}
    });
});

	
	
</script>
<div id="rentalQuarterlyCountGrid"></div>
<input type="hidden" name="desc" id="desc">