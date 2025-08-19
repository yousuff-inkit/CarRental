<%@page import="com.dashboard.trafficfine.satdaily.ClsSatDailyReport" %>
<%ClsSatDailyReport DAO=new ClsSatDailyReport(); %>
<% String satcategory =request.getParameter("satcategory")==null?"0":request.getParameter("satcategory").toString();%>
<% String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();%>
<% String saliksource =request.getParameter("saliksource")==null?"":request.getParameter("saliksource").toString();%>
<script type="text/javascript">
	
	var userdata;
	var satcategory='<%=satcategory%>';
	var id='<%=id%>';
	if(id!='0'){
		userdata= '<%=DAO.getSATUsername(satcategory,id,saliksource)%>';    
	}
	

$(document).ready(function () {
	

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                    
                 	{name : 'username', type: 'string'  },
						
					],
				    localdata: userdata,
        
        
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
    
    
    $("#usernameSearchGrid").jqxGrid(
    {
        width: '100%',
        height: 400,
        source: dataAdapter,
        selectionmode: 'singlerow',
        filterable:true,
        showfilterrow:true,
       
        columns: [

						{ text: 'Username', datafield: 'username', width: '100%'},
						
					]
    
    });
    
    $('#usernameSearchGrid').on('rowdoubleclick', function (event) { 
    	
  		    var boundIndex = event.args.rowindex;
  		    $('#username').val($('#usernameSearchGrid').jqxGrid('getcellvalue',boundIndex,'username'));
			$('#userwindow').jqxWindow('close');    		    
			
    });
});
	
</script>
<div id="usernameSearchGrid"></div>