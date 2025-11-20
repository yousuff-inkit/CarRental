<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.humanresource.transactions.additionanddeduction.ClsAdditionandDeductionDAO" %>

<%
    ClsAdditionandDeductionDAO DAO = new ClsAdditionandDeductionDAO();
    String date = request.getParameter("date")==null?"0":request.getParameter("date");
    String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
    String year = request.getParameter("year")==null?"0":request.getParameter("year");
    String month = request.getParameter("month")==null?"0":request.getParameter("month");
    String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
    String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
    String description = request.getParameter("description")==null?"0":request.getParameter("description");
%>

<style>

/* ================================
   🌟 PREMIUM BLUE ERP GRID
   ================================ */

#additionAndDeductionMainSearch {
    margin-top: 10px;
    border-radius: 14px !important;
}

/* Grid Outer Frame */
.jqx-widget-content {
    background: #ffffff !important;
    border: 1px solid #d8e4ff !important;
    border-radius: 14px !important;
}

/* Header */
.jqx-grid-column-header,
.jqx-widget-header {
    background: linear-gradient(90deg,#e6eeff,#d6e4ff) !important;
    color: #2a3b7a !important;
    font-size: 14px !important;
    font-weight: 600 !important;
    border-color: #d6e4ff !important;
    height: 38px !important;
    padding-top: 8px !important;
}

/* Rows */
.jqx-grid-cell {
    font-size: 13px !important;
    padding: 8px !important;
    border-color: #edf1ff !important;
    background: #ffffff !important;
    color: #000 !important;
}

/* Hover */
.jqx-grid-cell-hover {
    background: #eef4ff !important;
    color: #002060 !important;
}

/* Selected Row */
.jqx-grid-cell-selected {
    background: #6f9bff !important;
    color: #ffffff !important;
    font-weight: 600 !important;
}

/* Scrollbar */
::-webkit-scrollbar {
    width: 8px;
}
::-webkit-scrollbar-thumb {
    background: #c5d2ff;
    border-radius: 6px;
}
::-webkit-scrollbar-thumb:hover {
    background: #a9bdff;
}

</style>


<script type="text/javascript">

var data3 = '<%=DAO.alwMainSearch(session, date, docNo, year, month, description, employeebranchchk, branch)%>';

$(document).ready(function () {

    var source = {
        datatype: "json",
        datafields: [
            { name : 'doc_no', type: 'String' }, 
            { name : 'date', type: 'date' },
            { name : 'year', type: 'String' }, 
            { name : 'month', type: 'String' }, 
            { name : 'refno', type: 'String' },
            { name : 'description', type: 'String' }
        ],
        localdata: data3
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);
        }
    });

    $("#additionAndDeductionMainSearch").jqxGrid({
        width: '100%',
        height: 310,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable: false,
        columnsresize: true,
        localization: { thousandsSeparator: "" },

        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '10%' },
            { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy', width: '12%' },
            { text: 'Ref No', datafield: 'refno', width: '24%' }, 
            { text: 'Year', datafield: 'year', width: '10%' },
            { text: 'Month', datafield: 'month', width: '12%' }, 
            { text: 'Description', datafield: 'description', width: '32%' }
        ]
    });


    /* DOUBLE CLICK ACTION */
    $('#additionAndDeductionMainSearch').on('rowdoubleclick', function (event) {

        var rowindex1 = event.args.rowindex;

        funReset();
        document.getElementById("docno").value =
            $('#additionAndDeductionMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

        $('#frmalw select').attr('disabled', false);
        $('#masterdate').jqxDateTimeInput({ disabled: false });

        funSetlabel();
        document.getElementById("frmalw").submit();

        $('#frmalw select').attr('disabled', true);
        $('#masterdate').jqxDateTimeInput({ disabled: true });

        $('#window').jqxWindow('close');
    });

}); 
</script>

<div id="additionAndDeductionMainSearch"></div>
