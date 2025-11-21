<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>
<% ClsAdditionandDeductionDAO DAO=new ClsAdditionandDeductionDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<%
 String accountno   = request.getParameter("accountno")==null?"0":request.getParameter("accountno");
 String accountname = request.getParameter("accountname")==null?"0":request.getParameter("accountname");
 String atype       = request.getParameter("atype")==null?"0":request.getParameter("atype");
 String check       = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style>
/* --------- PREMIUM GRID CARD ------------ */
#accountsSearch {
    border-radius: 14px;
}

/* GRID CONTAINER CARD */
.grid-card {
    background: #ffffff;
    border-radius: 14px;
    padding: 14px 18px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 6px 18px rgba(90,120,255,0.18);
    margin-top: 10px;
}

/* HEADER */
.jqx-widget-header,
.jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    font-size: 0.9rem !important;
    border-color: #dce6ff !important;
}

/* ROWS */
.jqx-grid-cell {
    font-size: 0.88rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

/* HOVER */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.12) !important;
}

/* SELECTED */
.jqx-grid-cell-selected {
    background: #5c82ff !important;
    color: #fff !important;
}

/* SMOOTH SCROLLBAR */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: #c7d4ff;
    border-radius: 6px;
}
::-webkit-scrollbar-thumb:hover {
    background: #a8baff;
}
</style>


<script type="text/javascript">

    var accountData = '<%=DAO.accountDetailsSearch(accountno,accountname,atype,check)%>';

    $(document).ready(function () {

        var source = {
            datatype: "json",
            datafields: [
                { name: 'doc_no',      type: 'int' },
                { name: 'account',     type: 'string' },
                { name: 'description', type: 'string' },
                { name: 'grtype',      type: 'int' }
            ],
            localdata: accountData
        };

        var dataAdapter = new $.jqx.dataAdapter(source);

        $("#accountsSearch").jqxGrid({
            width: '100%',
            height: 305,
            source: dataAdapter,
            selectionmode: 'singlerow',
            editable: false,
            columnsresize: true,
            localization: { thousandsSeparator: "" },

            columns: [
                { text: 'Doc No',       datafield: 'doc_no',      hidden: true, width: '5%' },
                { text: 'Account',      datafield: 'account',     width: '35%' },
                { text: 'Account Name', datafield: 'description', width: '65%' },
                { text: 'Group Type',   datafield: 'grtype',      hidden: true, width: '5%' }
            ]
        });

        /* DOUBLE CLICK = SEND DATA BACK */
        $('#accountsSearch').on('rowdoubleclick', function (event) {
            var rowindex1 = $('#rowindex').val();
            var rowindex2 = event.args.rowindex;

            $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "acno", 
                $('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "doc_no"));

            $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "account",
                $('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "account"));

            $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "accountname",
                $('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "description"));

            $('#descdetailsGrid').jqxGrid('setcellvalue', rowindex1, "grtype",
                $('#accountsSearch').jqxGrid('getcellvalue', rowindex2, "grtype"));

            $('#accountDetailsWindow').jqxWindow('close');
        });

    });
</script>

<div class="grid-card">
    <div id="accountsSearch"></div>
</div>
