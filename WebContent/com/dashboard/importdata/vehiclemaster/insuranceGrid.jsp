<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.vehiclemaster.ClsIMVehicleDAO"%> 
<%
	ClsIMVehicleDAO DAO= new ClsIMVehicleDAO();  
%>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 var insdata;
 $(document).ready(function () { 	
	 insdata='<%=DAO.insuranceGrid()%>';        
     var source =      
     {
         datatype: "json",
         datafields: [
						{ name: 'ins_type', type: "string" },
						{ name: 'accountname', type: "string" },
						{ name: 'accdoc', type: "string" },
	            	 ],
         localdata: insdata, 
              
         pager: function (pagenum, pagesize, oldpagenum) {
         }
       };
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });

	$("#jqxInsuranceGrid").jqxGrid(
	{
		width: '100%',
	    height: 300,
	    source: dataAdapter,
	    selectionmode: 'checkbox',  
	    enabletooltips:true,
	    showfilterrow:true,
	    enabletooltips:true,
	    filterable:true,
	    editable:true,
	    columns: [
					{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false, 
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					{ text: 'Account Name',  datafield: 'accountname', width:'25%', editable: false},
					{ text: 'Insurance',  datafield: 'ins_type'},
					{ text: 'accdoc',  datafield: 'accdoc', width:'0%', hidden:true},  
			 ],    
     });
     $("#overlay, #PleaseWait").hide();  
     $('#jqxInsuranceGrid').on('celldoubleclick', function(event) {
        	var rowBoundIndex = event.args.rowindex;
        	var datafield = event.args.datafield;
        	
        	if((datafield == "accountname")) {
		    	getAccountAP(rowBoundIndex);    
    	    } 
    });
 });
 
 function getAccountAP(rowindex){
	    $('#accountWindow').jqxWindow('open');
	    accountSearchContent('accountsSearchAP.jsp?rowindex='+rowindex);     
	}
       	 
   function accountSearchContent(url) {   
	    $.get(url).done(function (data) {
	    	$('#accountWindow').jqxWindow('setContent', data);   
        });    
   }  
</script>
<div id="jqxInsuranceGrid"></div>       