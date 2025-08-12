<%@page import="com.dashboard.operations.agmtpaymentupdate.*"%>
<%ClsAgmtPaymentupdateDAO DAO=new ClsAgmtPaymentupdateDAO();%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String dtype = request.getParameter("dtype")==null?"0":request.getParameter("dtype");
 String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
 String searchtype = request.getParameter("searchtype")==null?"0":request.getParameter("searchtype");
 String date = request.getParameter("dates")==null?"0":request.getParameter("dates").trim();
 String date1 = request.getParameter("date1")==null?"0":request.getParameter("date1").trim();
 String check = request.getParameter("id")==null?"0":request.getParameter("id");   
 System.out.println("check=="+check);
%> 

 <script type="text/javascript">

	 var accountData='<%=DAO.accountsDetails(session, dtype,accountno, accountname, currency, date,date1,check)%>'; 
 	$(document).ready(function () { 
 		var searchtype='<%=searchtype%>';
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'account', type: 'string'   },
 						{name : 'description', type: 'string'  },
 						{name : 'currency', type: 'string'  },
 						{name : 'curid', type: 'int'  },
 						{name : 'rate', type: 'number'  },
 						{name : 'type', type: 'string'  },
 						{name : 'bankacc',type:'number'}
     					
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxAccountsSearch").jqxGrid(
        {
        	width: '100%',
            height: 303,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
						{ text: 'Account', datafield: 'account', width: '30%' },
						{ text: 'Account Name', datafield: 'description', width: '50%' },
						{ text: 'Currency', datafield: 'currency', width: '10%' },
						{ text: 'Currency Id', hidden: true, datafield: 'curid', width: '5%' },
						{ text: 'Rate', datafield: 'rate', cellsformat: 'd2', cellsalign: 'right', align: 'right', width: '10%' },
						{ text: 'Currency Type', hidden: true, datafield: 'type', width: '5%' },
						{ text: 'bankacc', datafield: 'bankacc', width: '10%',hidden:false,editable:false},
						
					]
        });
        
         $('#jqxAccountsSearch').on('rowdoubleclick', function (event) {
        	 var args = event.args;
     		
     		var boundIndex = event.args.rowindex;
     		$('#txtfromaccid').val($('#jqxAccountsSearch').jqxGrid('getcellvalue',boundIndex,'account'));
    		$('#txtfromaccname').val($('#jqxAccountsSearch').jqxGrid('getcellvalue',boundIndex,'description'));
    		$('#txtfromdocno').val($('#jqxAccountsSearch').jqxGrid('getcellvalue', boundIndex, "doc_no"));
             
    		$('#accountDetailsFromWindow').jqxWindow('close');
    	
     		
     		
/*  if(searchtype=="2"){
	            document.getElementById("txtdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("txtaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("txtaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
	        	document.getElementById("cmbcurrency").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"txtrate");
            }else if(searchtype=="3"){
	            document.getElementById("txtdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	            document.getElementById("txtaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("txtaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
            }else{
            	document.getElementById("txtfromdocno").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
	           document.getElementById("txtfromaccid").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "account");
	        	document.getElementById("txtfromaccname").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "description");
	        	document.getElementById("txtaccountcurrency").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "curid");
	        	document.getElementById("hidfromcurrencytype").value = $('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "type");
	        	
	        	 funRoundRate($('#jqxAccountsSearch').jqxGrid('getcellvalue', rowindex1, "rate"),"txtfromrate");
            }
        	 */
          $('#accountDetailsFromWindow').jqxWindow('close');  
        });  
    });
</script>

<div id="jqxAccountsSearch"></div>
    