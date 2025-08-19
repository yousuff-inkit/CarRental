<%@page import="com.dashboard.salik.salikdetails.*" %>
<% ClsSalikdetailsDAO csd=new ClsSalikdetailsDAO(); %>
<%
	String fleetno= request.getParameter("fleetno")==null?"":request.getParameter("fleetno").trim();
 	String flname = request.getParameter("flname")==null?"":request.getParameter("flname");
 	String regno = request.getParameter("regno")==null?"0":request.getParameter("regno");
 	String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
<script type="text/javascript">
	var fleetdata=[];
	var id='<%=id%>';
	if(id=="1"){
		fleetdata='<%=csd.fleetdetails(fleetno,flname,regno,id)%>';
	}
	
 	<%-- ='<%=csd.agreementSearch(branchval,sclname,smob,rno,flno,sregno,rentaltype)%>'; --%>
    
 	$(document).ready(function () { 
    	
 		var source = 
            {
                datatype: "json",
                datafields: [
                	
                	{name : 'flname', type: 'String'},
     				{name : 'fleet_no', type: 'number'},
     				{name : 'reg_no', type: 'number'},
     				{name : 'authority',type:'string'},
     				{name : 'platecode',type:'string'},
     				{name : 'saliktag',type:'string'}
		      	],
        		localdata: fleetdata,
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#fleetSearchGrid").jqxGrid(
            {
                width: '100%',
                height: 277,
                source: dataAdapter,
                columnsresize: true,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
							{ text: 'Fleet No', datafield: 'fleet_no', width: '12%' },
							{ text: 'Fleet Name', datafield: 'flname', width: '60%' }, 
							{ text: 'Reg No', datafield: 'reg_no', width: '12%'},
							{ text: 'Authority', datafield: 'authority', width: '8%'},
							{ text: 'Plate Code', datafield: 'platecode', width: '8%'},
							{ text: 'Salik Tag', datafield: 'saliktag', width: '12%',hidden:true},
				
					]
            });
    
            $('#fleetSearchGrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("fleetno").value = $('#fleetSearchGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
            	$('#fleetwindow').jqxWindow('close'); 
            });
				           
 }); 

</script>
<div id="fleetSearchGrid"></div>
    
