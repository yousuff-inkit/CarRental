<%@page import="com.finance.transactions.cashreceipt.ClsCashReceiptDAO"%>
<% ClsCashReceiptDAO DAO= new ClsCashReceiptDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String check = request.getParameter("check")==null?"0":request.getParameter("check"); 
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* GRID HEADER */
.jqx-widget-header,
.jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #000000 !important;
    font-weight: 700 !important;
    border-color: #dce6ff !important;
    font-size: 1rem !important;
}

/* GRID CELLS */
.jqx-grid-cell {
    font-size: 1rem !important;
    padding: 7px !important;
    color: #000000 !important;
    border-color: #eef3ff !important;
}

/* HOVER EFFECT */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* SELECTED ROW */
.jqx-grid-cell-selected {
    background: #3b82f6 !important;
    color: #ffffff !important;
}
</style>

<script type="text/javascript">

var data1='<%=DAO.crvMainSearch(session, partyname, docNo, date, amount, check)%>';

$(document).ready(function () {

    var source =
    {
        datatype: "json",
        datafields: [
            {name : 'description', type: 'String' }, 
            {name : 'doc_no', type: 'int' },
            {name : 'date', type: 'date'  },
            {name : 'amount', type: 'number' }
        ],
        localdata: data1
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);
        }
    });

    $("#jqxCashReceiptMainSearch").jqxGrid({
        width: '100%',
        height: 320,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable: false,
        columnsresize: true,
        localization: {thousandsSeparator: ""},

        columns: [
            { text: 'Party Name', datafield: 'description', width: '40%' },
            { text: 'Doc No', datafield: 'doc_no', width: '20%' },
            { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '20%' },
            { text: 'Amount', datafield: 'amount', width: '20%',
              cellsformat: 'd2', cellsalign: 'right', align: 'right' }
        ]
    });

    $('#jqxCashReceiptMainSearch').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;

        funReset();
        document.getElementById("txttoaccname").value =
            $('#jqxCashReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "description");

        document.getElementById("docno").value =
            $('#jqxCashReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

        $('#frmCashReceipt select').attr('disabled', false);
        $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
        funSetlabel();

        document.getElementById("frmCashReceipt").submit();

        $('#frmCashReceipt select').attr('disabled', true);
        $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});

        $('#window').jqxWindow('close');
    });

});
</script>

<div class="grid-card">
%> 

 <script type="text/javascript">
 
 			var data1='<%=DAO.crvMainSearch(session, partyname, docNo, date, amount, check)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'description', type: 'String' }, 
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'amount', type: 'number' }
                          	],
                          	localdata: data1,
                
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
            $("#jqxCashReceiptMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
                     { text: 'Party Name', datafield: 'description', width: '40%' },
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '20%' },
					 { text: 'Amount', datafield: 'amount', width: '20%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
					]
            });
            
			  $('#jqxCashReceiptMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                document.getElementById("txttoaccname").value= $('#jqxCashReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "description");
                document.getElementById("docno").value= $('#jqxCashReceiptMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                
                $('#frmCashReceipt select').attr('disabled', false);
                $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: false});
                funSetlabel();
                document.getElementById("frmCashReceipt").submit();
                $('#frmCashReceipt select').attr('disabled', true);
                $('#jqxCashReceiptDate').jqxDateTimeInput({disabled: true});


                  changeContent('cashReceipt.jsp?docno=' + encodeURIComponent(docNo));
                  console.log('Loading cashReceipt.jsp for docno:', docNo);
                  var checker = setInterval(function () {
                      if ($('#approval-table').length) {
                          clearInterval(checker);
                          // ensure docno input is set (if cashReceipt expects it)
                          if ($('#docno').length) {
                              $('#docno').val(docno);
                          }
                          // fetch and insert approvals
                          fetchApprovalsAndInsert(docno);
                      }
                  }, 200);
               $('#window').jqxWindow('close');
            });

                     // helper to fetch approvals and render into approval table
                     function fetchApprovalsAndInsert(docno) {

                         var dtype = ($('#formdetailcode').length ? $('#formdetailcode').val() : '');
                         var brch = ($('#brchName').length ? $('#brchName').val() : '');
                         var url = '<%=request.getContextPath()%>/com/common/ApprovalForm.jsp';
console.log('Fetching approvals from URL:', url, 'with docno:', docno, 'dtype:', dtype, 'brch:', brch);
                         $.get(url, { docno: docno, dtype: dtype, brch: brch, userid: userid, }, function (data) {
                             var items = (data || '').trim();
                             var rows = items === '' ? [] : items.split('\n');
                             var $tbody = $('#approval-table tbody');

                             if ($tbody.length === 0) {
                                 // nothing to insert into
                                 return;
                             }

                             $tbody.empty();

                             if (rows.length > 0 && rows[0] !== '') {
                                 rows.forEach(function (row) {
                                     var cols = row.split(',');
                                     var $tr = $('<tr></tr>');
                                     $tr.append($('<td></td>').text(cols[0] || ''));
                                     $tr.append($('<td></td>').text(cols[1] || ''));
                                     $tr.append($('<td></td>').text(cols[2] || ''));
                                     $tbody.append($tr);
                                 });
                             } else {
                                 $tbody.append('<tr><td colspan="3" style="text-align:center;color:#888;">No approvals found</td></tr>');
                             }
                         }).fail(function () {
                             var $tbody = $('#approval-table tbody');
                             if ($tbody.length) {
                                 $tbody.empty().append('<tr><td colspan="3" style="text-align:center;color:#c00;">Error loading approvals</td></tr>');
                             }
                         });
                     }
				           
}); 
				       
                       
    </script>
    <div id="jqxCashReceiptMainSearch"></div>
</div>
