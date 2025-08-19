<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.audit.changesalesman.ClsChangeSalesmanDAO" %>
<%
        ClsChangeSalesmanDAO DAO= new ClsChangeSalesmanDAO();           
		int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString()); 
		String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();  
		String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();  
		String salid = request.getParameter("salid")==null || request.getParameter("salid").equals("")?"0":request.getParameter("salid").trim();  
 %>   
<script type="text/javascript">
  
var quotedata;
var id='<%=id%>';
$(document).ready(function () {   	
             var num = 1; 
        		 quotedata='<%=DAO.contractGridLoad(id, fromdate, todate, salid)%>';                     
            // prepare the data
             var rendererstring=function (aggregates){
                	var value=aggregates['sum'];
                	if(typeof(value) == "undefined"){
                		value=0.00;
                	}
                	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
                }
         	
           var rendererstring1=function (aggregates){
                 var value1=aggregates['sum1'];
                 return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
                }
            var source =
            {
                datatype: "json",
                datafields: [
						{ name: 'category', type: 'string' },
						{ name: 'cldocno', type: 'number' },
						{ name: 'refname', type: 'string' },
						{ name: 'per_mob', type: 'string' },
						{ name: 'sal_name', type: 'string' },
						{ name: 'address', type: 'string' },
						{ name: 'mail1', type: 'string' },
						{ name: 'invc_method', type: 'string' },
						{ name: 'del_charges', type: 'string' },
						{ name: 'trnnumber', type: 'string' },
						
						{ name: 'account', type: 'number' },
						{ name: 'acc_group', type: 'string' },
						{ name: 'credit', type: 'number' },
						{ name: 'period', type: 'number' },
						{ name: 'period2', type: 'number' },
						{ name: 'taxcat', type: 'string' },
						{ name: 'salcharge', type: 'string' },
						{ name: 'trafcharge', type: 'string' }
                 
                 ],
                 localdata: quotedata,  
                
                
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

            
            $("#jqxContractGrid").jqxGrid(  
            {
                width: '100%',
                height: 440,
                source: dataAdapter,
                editable: false,
                altRows: true,
                selectionmode: 'checkbox', 
                pagermode: 'default',
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
            	//showaggregates: true,
             	//showstatusbar:true,
             	//statusbarheight:25,
       
                columns: [
							 { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,  
                              datafield: 'sl', columntype: 'number', width: '4%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                            },	
                            { text: 'Client Code', groupable: true, datafield: 'cldocno', width: '10%' },
        					{ text: 'Account No', groupable: false, datafield: 'account', width: '10%' },
        					{ text: 'Account Group', groupable: true, datafield: 'acc_group', width: '10%' },
        					{ text: 'Name', groupable: true, datafield: 'refname', width: '20%' },
        					{ text: 'Category', groupable: true, datafield: 'category', width: '13%' },
        					{ text: 'Tax Category', groupable: true, datafield: 'taxcat', width: '13%' },
        					{ text: 'TRN No', groupable: false, datafield: 'trnnumber', width: '6%' },
        					{ text: 'Address', groupable: false, datafield: 'address', width: '23%' },
        					{ text: 'Mobile', groupable: true, datafield: 'per_mob', width: '10%' },
        					{ text: 'Salesman', groupable: false, datafield: 'sal_name', width: '10%' },
        					{ text: 'Email Id', groupable: false, datafield: 'mail1', width: '13%' },
        					{ text: 'INV Method', groupable: false, datafield: 'invc_method', width: '6%' },
        					{ text: 'Del. Charges', groupable: false, datafield: 'del_charges', width: '5%' },
        					{ text: 'Salik. Charges', groupable: false, datafield: 'salcharge', width: '5%' },
        					{ text: 'Traffic. Charges', groupable: false, datafield: 'trafcharge', width: '5%' },
        					{ text: 'Credit Limit', groupable: false, datafield: 'credit', width: '13%'},
        					{ text: 'Credit Period', groupable: false, datafield: 'period', width: '6%' },
        					{ text: 'Max Days', groupable: false, datafield: 'period2', width: '5%' },
			     ]
            });
            $("#overlay, #PleaseWait").hide(); 
            $('#jqxContractGrid').on('rowdoubleclick', function (event) {       
             	  var rowindex1=event.args.rowindex; 
             	  document.getElementById("hidbrhid").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "brhid");
             	  document.getElementById("hidcontrno").value=$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             	  $('.textpanel p').text($('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "refname")+' - '+$('#jqxContractGrid').jqxGrid('getcellvalue', rowindex1, "site"));
             	  $('.comments-container').html('');  
            });
        });
    </script>
    <div id="jqxContractGrid"></div> 
    <input type="hidden" name="hidrowindex" id="hidrowindex">