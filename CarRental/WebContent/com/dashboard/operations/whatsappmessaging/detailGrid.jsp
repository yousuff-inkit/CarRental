<%@ page import="com.dashboard.operations.whatsappmessaging.ClsWhatsappMessagingDAO" %>
<%  ClsWhatsappMessagingDAO cod=new ClsWhatsappMessagingDAO(); %>
<%  
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
	String group = request.getParameter("group")==null?"":request.getParameter("group").trim();
%>   

<style type="text/css">    
	  .colorClass1
	  {
	      background-color: #FEA28F;      
	  }
</style>

<script type="text/javascript">
        $(document).ready(function () {
        	 var  data1='<%=cod.detailGridLoad(id, group)%>';         
        	
        	var source =
            {
                datatype: "json",
                datafields: [ 
                    { name: 'acno', type: 'String' },
                    { name: 'cldocno', type: 'String' },
                	{ name: 'category', type: 'String' },  
					{ name: 'groups', type: 'String' },
                    { name: 'refname', type: 'String' },
                    { name: 'mobno', type: 'String' },
                    { name: 'status', type: 'String' },
	            ],
                localdata: data1,
               
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
            
            var cellclassname =  function (row, column, value, data) {
               var status= $('#jqxDetailGrid').jqxGrid('getcellvalue', row, "status");
         	   if(parseInt(status)==1) {
         		    return "colorClass1";  
         	   } 
             }  
            
            $("#jqxDetailGrid").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                showfilterrow:true,
                columnsresize :true,
                filterable: true,
                sortable: true,
                selectionmode: 'checkbox',
                enabletooltips:true, 
                editable: false,
                
                columns: [
							{ text: 'SrNo', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',cellclassname:cellclassname,
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
								},
							{ text: 'Client#', datafield: 'cldocno', width: '8%',cellclassname:cellclassname }, 
					        { text: 'Ac No', datafield: 'acno', width: '8%',cellclassname:cellclassname },
		                    { text: 'Client', datafield: 'refname', width: '40%',cellclassname:cellclassname },
		                    { text: 'Mob No', datafield: 'mobno', width: '12%',cellclassname:cellclassname },
		                    { text: 'Category', datafield: 'category', width: '12%',cellclassname:cellclassname },
		                    { text: 'Group', datafield: 'groups', width: '12%',cellclassname:cellclassname }, 
		                    { text: 'Status', datafield: 'status', width: '0%',hidden:true  },          
					 ]    
            });
            
            $("#overlay, #PleaseWait").hide();
            $('#jqxDetailGrid').on('rowdoubleclick', function (event){ 
        	  	var rowindex = event.args.rowindex;
        	  	document.getElementById("status").value = $('#jqxDetailGrid').jqxGrid('getcellvalue', rowindex, "status");
            });
        });
</script>
<div id="jqxDetailGrid"></div>