<%@page import="com.dashboard.accounts.commercialreceiptposting.ClsCommercialReceiptPostingDAO" %>
<%ClsCommercialReceiptPostingDAO cpd=new ClsCommercialReceiptPostingDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String date = request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String cmatype = request.getParameter("cmatype")==null?"0":request.getParameter("cmatype");

%> 

 <script type="text/javascript">
 
	var cmaccountData='<%=cpd.cmaccountsDetails(session, accountno, accountname,date, check,cmatype)%>'; 
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                         {name : 'cmdoc_no', type: 'int'   },
						 {name : 'cmaccount', type: 'string'   },
						 {name : 'cmdescription', type: 'string'  },
						 {name : 'cmcurrency', type: 'string'  },
						 {name : 'cmcurid', type: 'int'  },
						 {name : 'cmrate', type: 'number'  },
						 {name : 'cmtype', type: 'string'  },
						 {name : 'cmatype', type: 'string'  }
                    ],
            		localdata: cmaccountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxcmAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'cmdoc_no', hidden:true, width: '5%' },
						{ text: 'Account Type',  datafield: 'cmatype', width: '10%' },

						{ text: 'Account', datafield: 'cmaccount', width: '30%' },
						{ text: 'Account Name', datafield: 'cmdescription', width: '40%' },
						{ text: 'Currency', datafield: 'cmcurrency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'cmcurid', width: '5%' },
						{ text: 'Rate', datafield: 'cmrate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
						{ text: 'Currency Type', hidden: true, datafield: 'cmtype', width: '5%' },
					]
        });
        
         $('#jqxcmAccountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = event.args.rowindex;
           
            document.getElementById("txtcmaccid").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmaccount");
        	document.getElementById("txtcmaccname").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmdescription");
        	document.getElementById("txtcmdocno").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmdoc_no");
        	document.getElementById("txtcmcurid").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmcurid");
        	document.getElementById("txtcmrate").value = $('#jqxcmAccountsSearch').jqxGrid('getcelltext', rowindex1, "cmrate");
        	document.getElementById("txtcmcurtype").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmtype");
        	document.getElementById("txtcmatype").value = $('#jqxcmAccountsSearch').jqxGrid('getcellvalue', rowindex1, "cmatype");
        	
            $('#cmaccountDetailsWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxcmAccountsSearch"></div>
    