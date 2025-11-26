<%@page import="com.finance.transactions.bankpayment.ClsBankPaymentDAO"%>
<% ClsBankPaymentDAO DAO= new ClsBankPaymentDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo     = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date      = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount    = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String chequeNo  = request.getParameter("chequeNo")==null?"0":request.getParameter("chequeNo");
 String chequeDt  = request.getParameter("chequeDt")==null?"0":request.getParameter("chequeDt");
 String check     = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style>
/* ===============================
      PREMIUM GRID CARD UI
=============================== */
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

/* HOVER */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.10) !important;
}

/* SELECTED ROW */
.jqx-grid-cell-selected {
    background: #3b82f6 !important;
    color: #ffffff !important;
}
</style>

<script type="text/javascript">

var data1 = '<%=DAO.bpvMainSearch(session, partyname, docNo, date, amount, chequeNo, chequeDt, check)%>';

$(document).ready(function () {

    var source = {
        datatype: "json",
        datafields: [
            {name : 'description', type: 'String' },
            {name : 'doc_no',      type: 'int'    },
            {name : 'date',        type: 'date'   },
            {name : 'amount',      type: 'number' },
            {name : 'chqno',       type: 'String' },
            {name : 'chqdt',       type: 'date'   }
        ],
        localdata: data1
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);
        }
    });

    $("#jqxBankPaymentMainSearch").jqxGrid({
        width: '100%',
        height: 320,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable: false,
        columnsresize: true,
        localization: { thousandsSeparator: "" },

        columns: [
            { text: 'Party Name',  datafield: 'description', width: '25%' },
            { text: 'Doc No',      datafield: 'doc_no',      width: '13%' },
            { text: 'Date',        datafield: 'date',        cellsformat: 'dd.MM.yyyy', width: '13%' },
            { text: 'Amount',      datafield: 'amount',      cellsformat: 'd2', width: '14%', cellsalign: 'right', align: 'right' },
            { text: 'Cheque No',   datafield: 'chqno',       width: '15%' },
            { text: 'Cheque Date', datafield: 'chqdt',       cellsformat: 'dd.MM.yyyy', width: '15%' }
        ]
    });

    $('#jqxBankPaymentMainSearch').on('rowdoubleclick', function (event) {

        var rowindex1 = event.args.rowindex;

        funReset();
        document.getElementById("txttoaccname").value =
            $('#jqxBankPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "description");

        document.getElementById("docno").value =
            $('#jqxBankPaymentMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

        $('#frmBankPayment select').attr('disabled', false);
        $('#jqxChequeDate').jqxDateTimeInput({disabled: false});
        $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: false});
        $('#chckpdc').attr('disabled', false);

        funSetlabel();
        document.getElementById("frmBankPayment").submit();

        $('#chckpdc').attr('disabled', true);
        $('#frmBankPayment select').attr('disabled', true);
        $('#jqxChequeDate').jqxDateTimeInput({disabled: true});
        $('#jqxBankPaymentDate').jqxDateTimeInput({disabled: true});

        $('#window').jqxWindow('close');
    });

});
</script>

<div class="grid-card">
    <div id="jqxBankPaymentMainSearch"></div>
</div>
