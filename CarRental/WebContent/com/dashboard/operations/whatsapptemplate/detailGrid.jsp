<%@ page import="com.dashboard.operations.whatsapptemplate.ClsWhatsappTemplateDAO" %>
<%  ClsWhatsappTemplateDAO cod=new ClsWhatsappTemplateDAO(); %>
<%  
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%>   

<style type="text/css">
	  .cashClass
	  {
	      background-color: #FBEFF5;  
	  }
	  .cardClass
	  {
	      background-color: #E0F8F1;
	  }
	   .chequeClass
	  {
	      background-color: #ECE0F8;
	  }
</style>

<script type="text/javascript">
        $(document).ready(function () {
        	 var  data1='<%=cod.detailGridLoad(id)%>';         
        	
        	var source =
            {
                datatype: "json",
                datafields: [ 
                    { name: 'templatename', type: 'String' },
                    { name: 'category', type: 'String' },
                    { name: 'language', type: 'String' },
                	{ name: 'status', type: 'String' },  
					{ name: 'createduser', type: 'String' },
                    { name: 'createddate', type: 'String' },
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
            $("#jqxDetailGrid").jqxGrid(
            {
                width: '99%',
                height: 500,
                source: dataAdapter,
                showfilterrow:true,
                columnsresize :true,
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',  
                enabletooltips:true, 
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'SrNo', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
								},
							{ text: 'Name', datafield: 'templatename', width: '37%' }, 
							{ text: 'Date', datafield: 'createddate', width: '10%' },
		                    { text: 'Created User', datafield: 'createduser', width: '15%' }, 
					        { text: 'Category', datafield: 'category', width: '12%' },
					        { text: 'Language', datafield: 'language', width: '6%' },
		                    { text: 'Status', datafield: 'status', width: '15%' },  
					 ]    
            });
            $('.load-wrapp').hide();  
            $('#jqxDetailGrid').on('rowdoubleclick', function (event){ 
          	  	var rowindex1=event.args.rowindex;
              	$("#templatename").val($("#jqxDetailGrid").jqxGrid('getcellvalue', rowindex1, 'templatename'))	
            });	 
        });
</script>
<div id="jqxDetailGrid"></div>