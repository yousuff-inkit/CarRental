<%@page import="com.finance.posting.bankreconciliation.ClsBankReconciliationDAO"%>
<% ClsBankReconciliationDAO DAO = new ClsBankReconciliationDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
    String account = request.getParameter("account")==null?"0":request.getParameter("account");
    String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
    String currency = request.getParameter("currency")==null?"0":request.getParameter("currency");
    String description = request.getParameter("description")==null?"0":request.getParameter("description");
    String reconcileDt = request.getParameter("reconcileDt")==null?"0":request.getParameter("reconcileDt");
    String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style>
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
    margin-top: 8px;
}

.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: #ffffff !important;
}

.no-data-message {
    text-align: center;
    padding: 20px;
    font-size: 0.9rem;
    font-weight: 600;
    color: #6b7cb9;
}
</style>

<script type="text/javascript">
var data1 = '<%=DAO.brcnMainSearch(account, docNo, currency, description, reconcileDt, check)%>';

$(document).ready(function () {

    var source = {
        datatype: "json",
        datafields: [
            { name: 'doc_no', type: 'int' },
            { name: 'account', type: 'String' },
            { name: 'code', type: 'String' },
            { name: 'description', type: 'String' },
            { name: 'date', type: 'date' }
        ],
        localdata: data1
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) { alert(error); }
    });

    $("#jqxbankreconcilesearch").jqxGrid({
        width: '99%',
        height: 300,
        source: dataAdapter,
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
            { text: 'Account Name', datafield: 'account', width: '28%' },
            { text: 'Currency', datafield: 'code', width: '10%' },
            { text: 'Description', datafield: 'description', width: '30%' },
            { text: 'Reconcile Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '22%' }
        ]
    });

    $('#jqxbankreconcilesearch').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        funReset();
        document.getElementById("txtaccname").value =
            $('#jqxbankreconcilesearch').jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("docno").value =
            $('#jqxbankreconcilesearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

        $('#frmBankReconciliation select').attr('disabled', false);
        $('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: false});
        funSetlabel();
        document.getElementById("frmBankReconciliation").submit();
        $('#frmBankReconciliation select').attr('disabled', true);
        $('#jqxBankReconciliationDate').jqxDateTimeInput({disabled: true});
        $('#window').jqxWindow('close');
    });

});
</script>

<div class="grid-card">
    <div id="jqxbankreconcilesearch"></div>
</div>
