<%@page import="com.dashboard.accounts.applyingcorrection.ClsApplyingcorrectionDAO" %>
<% ClsApplyingcorrectionDAO casd=new ClsApplyingcorrectionDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>  
<%
String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval");
String atype = request.getParameter("atype")==null?"0":request.getParameter("atype");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
String acno = request.getParameter("acno")==null?"0":request.getParameter("acno");%> 
 <style type="text/css">
  
  .diffClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
 
       var data= '<%=casd.griddetails(check,branchval,atype,acno)%>';  
        
       $(document).ready(function () { 
    	   
    	   
    	   var rendererstring=function (aggregates){
              	var value=aggregates['sum'];
              	if(typeof(value) == "undefined"){
              		value=0.00;
              	}
              	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
              }
        	
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'number'   },
							{name : 'account', type: 'number'   },
     						{name : 'acname', type: 'string'   },
     						{name : 'type', type: 'string'  },
     						{name : 'amount', type: 'number'   },
     						{name : 'outamount', type: 'number'   },
     						{name : 'damount', type: 'number'   },
                        ],
                		 localdata: data,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxapctgrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                selectionmode: 'singlerow',
                filterable:true,
                showfilterrow:true,
                columns: [
                	
                	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },
					
                	        { text: 'Doc No',  datafield: 'doc_no', width: '8%' },
							{ text: 'Account',  datafield: 'account', width: '10%' },
							{ text: 'Account Name', datafield: 'acname', width: '32%' },
							{ text: 'Type', datafield: 'type', width: '7%' },
							{ text: 'Amount', datafield: 'amount', width: '13%' ,cellsformat:'d4',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Out_Amount', datafield: 'outamount', width: '13%' ,cellsformat:'d4',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Diff Amount', datafield: 'damount', width: '13%',cellsformat:'d4',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring ,cellclassname: 'diffClass'},
						]
            });
            

            $("#overlay, #PleaseWait").hide();
            
             $('#jqxapctgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                document.getElementById("doc_no").value = $('#jqxapctgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("atype").value = $('#jqxapctgrid').jqxGrid('getcellvalue', rowindex1, "type");
    	       	
            });   
        });
    </script>
    <div id="jqxapctgrid"></div>
 