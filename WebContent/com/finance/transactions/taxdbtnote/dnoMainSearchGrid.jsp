<%@page import="com.finance.transactions.taxdbtnote.ClsTaxDebitNoteDAO"%>
<% ClsTaxDebitNoteDAO DAO = new ClsTaxDebitNoteDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null || request.getParameter("date").equals("undefined")?"0":request.getParameter("date");
 String accId = request.getParameter("accId")==null?"0":request.getParameter("accId");
 String accName = request.getParameter("accName")==null?"0":request.getParameter("accName");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String description = request.getParameter("description")==null?"0":request.getParameter("description");
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style>
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

.jqx-widget-header,
.jqx-grid-column-header {
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
var data1 = '<%=DAO.dnoMainSearch(session,docNo,date,accId,accName,amount,description,check)%>';

$(document).ready(function () {

    var source = {
        datatype: "json",
        datafields: [
            {name: "doc_no", type: "int"},
            {name: "date", type: "date"},
            {name: "accountno", type: "int"},
            {name: "accountname", type: "String"},
            {name: "amounts", type: "number"},
            {name: "description", type: "String"}
        ],
        localdata: data1
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) { alert(error); }
    });

    $("#jqxDebitNoteMainSearch").jqxGrid({
        width: "100%",
        height: 300,
        source: dataAdapter,
        selectionmode: "singlerow",
        editable: false,
        columnsresize: true,
        localization: {thousandsSeparator: ""},
        columns: [
            { text: "Doc No", datafield: "doc_no", width: "10%" },
            { text: "Date", datafield: "date", cellsformat: "dd.MM.yyyy", width: "10%" },
            { text: "Account No", datafield: "accountno", width: "10%" },
            { text: "Account Name", datafield: "accountname", width: "20%" },
            { text: "Amount", datafield: "amounts", width: "10%", cellsformat: "d2", cellsalign: "right", align: "right" },
            { text: "Description", datafield: "description", width: "40%" }
        ]
    });

    $("#jqxDebitNoteMainSearch").on("rowdoubleclick", function (event) {

        var rowindex1 = event.args.rowindex;

        funReset();
        document.getElementById("txtaccname").value =
            $("#jqxDebitNoteMainSearch").jqxGrid("getcellvalue", rowindex1, "accountname");

        document.getElementById("docno").value =
            $("#jqxDebitNoteMainSearch").jqxGrid("getcellvalue", rowindex1, "doc_no");

        $("#frmTaxDebitNote select").attr("disabled", false);
        $("#jqxDebitNoteDate").jqxDateTimeInput({disabled: false});

        funSetlabel();
        document.getElementById("frmTaxDebitNote").submit();

        $("#frmTaxDebitNote select").attr("disabled", true);
        $("#jqxDebitNoteDate").jqxDateTimeInput({disabled: true});

        $("#window").jqxWindow("close");
    });

});
</script>

<div class="grid-card">
    <div id="jqxDebitNoteMainSearch"></div>
</div>
