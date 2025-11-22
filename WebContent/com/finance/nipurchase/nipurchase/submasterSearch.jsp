<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%@page import="com.finance.nipurchase.nipurchase.ClsnipurchaseDAO" %>



	
<%

ClsnipurchaseDAO viewDAO=new ClsnipurchaseDAO();
String description = request.getParameter("description")==null?"NA":request.getParameter("description");
String docnoss = request.getParameter("docnoss")==null?"NA":request.getParameter("docnoss");
String accountss = request.getParameter("accountss")==null?"NA":request.getParameter("accountss");
 String accnamess = request.getParameter("accnamess")==null?"NA":request.getParameter("accnamess");

 String datess = request.getParameter("datess")==null?"0":request.getParameter("datess");
 
 String reftypess = request.getParameter("reftypess")==null?"NA":request.getParameter("reftypess"); 
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
 %>
 
 <style>
/* GRID WRAPPER CARD */
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* GRID HEADER */
.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

/* GRID CELLS */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

/* HOVER EFFECT */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* SELECTED ROW */
.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: #ffffff !important;
}

/* ZERO DATA MESSAGE */
.no-data-message {
    text-align: center;
    padding: 20px;
    font-size: 0.9rem;
    font-weight: 600;
    color: #6b7cb9;
}
/* Better grid borders */
.jqx-grid-cell,
.jqx-grid-column-header,
.jqx-widget-content {
    border-color: #c2d1ff !important;
}
</style>

<script type="text/javascript">


var nipurmain= '<%=viewDAO.mainsearch(session,docnoss,accountss,accnamess,datess,reftypess,aa,description) %>'; 


        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int'   },
                            {name : 'date', type: 'date'   },
     						{name : 'netamount', type: 'number'   },
     						{name : 'type', type: 'string'   },
     						{name : 'account', type: 'string'   },
     						{name : 'description', type: 'string'   },
     						{name : 'refno', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'delterm', type: 'string'   },
     						{name : 'payterm', type: 'string'   },
                        	{name : 'deldate', type: 'date'   },
     						{name : 'desc1', type: 'string'   },
     						{name : 'acno', type: 'string'   },
     						{name : 'curid', type: 'string'   },
     						{name : 'reftype', type: 'string'   },
     						{name : 'tr_no', type: 'int'   },
     						{name : 'voc_no', type: 'int'   },
     						{name : 'refvocno', type: 'int'   },
     						
     						 {name : 'invdate', type: 'date'   },
      						{name : 'invno', type: 'String'   },
     						
     						
                        ],
                		localdata: nipurmain, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mainsearshgrid").jqxGrid(
            {
                width: '100%',
                height: 280,
                rowsheight: 36,
                source: dataAdapter,
       /*          showfilterrow: true, 
                filterable: true,  */
                selectionmode: 'singlerow',
                
                columns: [
                          
                          

	
                            { text: 'Doc No', datafield: 'voc_no', width: '6%' },
							{ text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Account', datafield: 'account', width: '8%' },
								{ text: 'Account Name', datafield: 'description', width: '25%' },
								 { text: 'Ref Type', datafield: 'reftype', width: '7%'},
								{ text: 'Amount', datafield: 'netamount', width: '14%' ,cellsformat: 'd2'},
								 { text: 'type', datafield: 'type', width: '5%',hidden:true },
								 { text: 'refno', datafield: 'refno', width: '5%',hidden:true },
									{ text: 'rate', datafield: 'rate', width: '2%' ,hidden:true},
									{ text: 'delterm', datafield: 'delterm', width: '8%',hidden:true },
									 { text: 'payterm',  datafield: 'payterm', width: '5%' ,hidden:true},
										{ text: 'deldate', datafield: 'deldate', width: '5%' ,cellsformat:'dd.MM.yyyy',hidden:true},
										{ text: 'Description', datafield: 'desc1', width: '30%' },
										 { text: 'acno', datafield: 'acno', width: '2%' ,hidden:true},
										 { text: 'curid', datafield: 'curid', width: '2%',hidden:true },
										 
										 { text: 'invdate', datafield: 'invdate', width: '10%',cellsformat:'dd.MM.yyyy' ,hidden:true}, 
										 { text: 'invno', datafield: 'invno', width: '2%',hidden:true},
										 { text: 'tr_no', datafield: 'tr_no', width: '2%',hidden:true},
										 { text: 'voc_no', datafield: 'doc_no', width: '2%',hidden:true},
										 { text: 'refvocno', datafield: 'refvocno', width: '2%',hidden:true},
										 
						]
            });
             $('#mainsearshgrid').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
           	 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
        	 $('#deliverydate').jqxDateTimeInput({ disabled: false});
        	 
        	 $('#invDate').jqxDateTimeInput({ disabled: false});
        	 
        	 
        	  $('#cmbcurr').attr('disabled', false);
        	$('#acctype').attr('disabled', false);
        	 document.getElementById("docno").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "voc_no");
                document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");
               // document.getElementById("masterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue',rowindex1, "doc_no");

                
      /*           
                $('#nipurchasedate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "date")) ;
                $('#deliverydate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "deldate")) ;
                
                
                $('#invDate').val($("#mainsearshgrid").jqxGrid('getcellvalue', rowindex1, "invdate")) ;
                
                document.getElementById("invno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "invno");
                document.getElementById("refno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refvocno");
                document.getElementById("ordermasterdoc_no").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "refno");
                
                $('#acctypeval').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "type"));
                
                $('#cmbcurrval').val($('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "curid"));
          
                
                document.getElementById("reftypeval").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "reftype");
            	  document.getElementById("currate").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "rate");
                  
                  document.getElementById("delterms").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "delterm");
              	document.getElementById("payterms").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "payterm");
                document.getElementById("purdesc").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "desc1");
                
                document.getElementById("nipuraccid").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "account");
            	document.getElementById("puraccname").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "description");
                
               document.getElementById("nettotal").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "netamount");
               
                document.getElementById("accdocno").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "acno");
                
                
                document.getElementById("tarannumber").value = $('#mainsearshgrid').jqxGrid('getcellvalue', rowindex1, "tr_no");
             */

              $('#window').jqxWindow('close');  
       	   $('#refno').attr('disabled', false);
		   $('#refslno').attr('disabled', false);
		 	 $('#nipurchasedate').jqxDateTimeInput({ disabled: false});
        	 $('#deliverydate').jqxDateTimeInput({ disabled: false});
        	 $('#invDate').jqxDateTimeInput({ disabled: false});

        	 // $('#cmbcurr').attr('disabled', false);
        	// $('#acctype').attr('disabled', false);
        	 funSetlabel();
            document.getElementById("frmNipurchase").submit();
            }); 
             
        });
    </script>
    <div id="mainsearshgrid"></div>