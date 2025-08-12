<%@page import="com.dashboard.vehiclepurchase.termloanrestructuring.ClsTermLoanRestructuringDAO"%>   
<%ClsTermLoanRestructuringDAO mortgagedao=new ClsTermLoanRestructuringDAO();
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");  
%>
 <script type="text/javascript">
var purchasedata='<%=mortgagedao.getPurchaseSearchData(branch)%>';   
$(document).ready(function () { 	
        
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [ 
                            {name : 'doc_no',type:'int'},
                            {name : 'voc_no',type:'string'},
     						{name : 'date', type: 'date'  },
     						{name : 'dealno', type: 'string'},
     						{name : 'loanamount',type:'number'}
                 ],               
               localdata:purchasedata,
               
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

            
            
            $("#purchaseSearchGrid").jqxGrid(
            {
                width: '99%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                editable: false,
                altRows: true,
                selectionmode: 'singlerow',
               // pagermode: 'default',
                filterable:true,
                showfilterrow:true,
                //Add row method
                handlekeyboardnavigation: function (event) {
                 
				},
                columns: [
                            { text: 'Sr. No.',datafield: '',columntype:'number', width: '10%', cellsrenderer: function (row, column, value) {
	                               return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                            }   },
                            { text: 'Docno',datafield:'voc_no',width:'15%'},
                            { text: 'Original Docno',datafield:'doc_no',width:'13.5%',hidden:true},
                            { text: 'Date',datafield:'date',width:'20%',cellsformat:'dd.MM.yyyy'},					
							{ text: 'Deal No', datafield: 'dealno' },
							{ text: 'Loan Amount',datafield:'loanamount',width:'15%',hidden:true,cellsformat:'d2'}
	              ]
            });
            
            $('#purchaseSearchGrid').on('rowdoubleclick', function (event) 
            	{ 
          	 		var rowindex=event.args.rowindex;
           		 	document.getElementById("purchasedocno").value=$('#purchaseSearchGrid').jqxGrid('getcellvalue',rowindex,'voc_no');
           		 	document.getElementById("hidpurchasedocno").value=$('#purchaseSearchGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
	           		document.getElementById("dealno").value=$('#purchaseSearchGrid').jqxGrid('getcellvalue',rowindex,'dealno');
	           		funRoundAmt($('#purchaseSearchGrid').jqxGrid('getcellvalue',rowindex,'loanamount'),"total");
	           		$('#purchasewindow').jqxWindow('close');   
              	});	 
            
            
             });
    </script>
    
    <div id="purchaseSearchGrid"></div>