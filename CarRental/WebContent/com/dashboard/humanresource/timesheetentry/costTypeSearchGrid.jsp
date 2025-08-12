<%@page import="com.common.ClsCompCostCenter"%>
<%

  
ClsCompCostCenter DAO= new ClsCompCostCenter();
%>
<script type="text/javascript">
  
     var costtype= '<%=DAO.costTypeSearch() %>';
		$(document).ready(function () { 	
           
			var source =
            {
                datatype: "json",  
                datafields: [
                              {name : 'costtype', type: 'string'  },
                              {name : 'costgroup', type: 'string'  },
                             // {name : 'costtypedb', type: 'string'  },

                            ],
                       localdata: costtype,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#costtypeSearch").jqxGrid(
            {
                width: '100%',
                height: 375,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlecell',
                       
                columns: [
                              { text: 'Cost Type', datafield: 'costtype', hidden:true, width: '15%'},
                              { text: 'Cost Group', datafield: 'costgroup', width: '100%' },
                      //        { text: 'Database', datafield: 'costtypedb',  width: '20%'},

						]
            });
            
             
          $('#costtypeSearch').on('celldoubleclick', function (event) {
                var rowindex2 = event.args.rowindex;

                if($('#txtorgridclick').val()=='1') {
 	                 document.getElementById("txtprojecttypeid").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype");
 	            	 document.getElementById("txtprojecttype").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup");
                } else if($('#txtorgridclick').val()=='2') {
                	var rowindex1 =$('#rowindex').val();
                	$('#timeSheetFillSearchGridId').jqxGrid('setcellvalue', rowindex1, "costtype" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype"));
                	$('#timeSheetFillSearchGridId').jqxGrid('setcellvalue', rowindex1, "costgroup" ,$('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup"));
                } else if($('#txtorgridclick').val()=='3') {
 	                 document.getElementById("txtselectedcosttypeid").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costtype");
 	            	 document.getElementById("txtselectedcosttypename").value = $('#costtypeSearch').jqxGrid('getcellvalue', rowindex2, "costgroup");
                } 
                
                $('#costTypeSearchGridWindow').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="costtypeSearch"></div> 