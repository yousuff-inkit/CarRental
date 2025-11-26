<%@ page import="com.operations.commtransactions.rentalrefund.ClsRentalRefundDAO" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    ClsRentalRefundDAO rrd = new ClsRentalRefundDAO();
    String accountName = request.getParameter("accountName") == null ? "0" : request.getParameter("accountName");
    String srNo = request.getParameter("srNo") == null ? "0" : request.getParameter("srNo");
    String date = request.getParameter("date") == null ? "0" : request.getParameter("date");
    String total = request.getParameter("total") == null ? "0" : request.getParameter("total");
    String refNo = request.getParameter("refNo") == null ? "0" : request.getParameter("refNo");
%>

<style>
#jqxrentalrefundsearch-wrapper {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
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

#jqxrentalrefundsearch {
    width: 100% !important;
    height: 300px;
    box-sizing: border-box;
}
</style>

<script type="text/javascript">
var data1 = '<%=rrd.rrpMainSearch(session, accountName, srNo, date, total, refNo)%>';

$(document).ready(function () { 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'srno', type: 'int'},
            {name : 'rdocno', type: 'int'},
            {name : 'date', type: 'date'},
            {name : 'description', type: 'String'},
            {name : 'netamt', type: 'number'},
            {name : 'refno', type: 'String'}
        ],
        localdata: data1,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });

    $("#jqxrentalrefundsearch").jqxGrid({
        width: '99%',
        height: 300,
        source: dataAdapter,
        selectionmode: 'singlerow',
        columnsresize: true,
        columns: [
            { text: 'RR No', datafield: 'srno', width: '10%' },
            { text: 'Doc No', datafield: 'rdocno', width: '10%' },
            { text: 'Date', datafield: 'date', width: '10%', cellsformat: 'dd.MM.yyyy' },
            { text: 'Account Name', datafield: 'description', width: '40%' },
            { text: 'Total', datafield: 'netamt', width: '15%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
            { 
                text: 'Cheque/Card No.',
                datafield: 'refno',
                width: '20%',
                cellsrenderer: function (row, column, value) {
                    return '<span title="'+value+'" style="white-space:normal;">'+value+'</span>';
                }
            }
        ]
    });

    $('#jqxrentalrefundsearch').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        funReset();
        document.getElementById("txtclientname").value = $('#jqxrentalrefundsearch').jqxGrid('getcellvalue', rowindex1, "description");
        document.getElementById("docno").value = $('#jqxrentalrefundsearch').jqxGrid('getcellvalue', rowindex1, "rdocno");
        document.getElementById("txtsrno").value = $('#jqxrentalrefundsearch').jqxGrid('getcellvalue', rowindex1, "srno");

        $('#frmRentalRefund select').attr('disabled', false);
        $('#jqxRentalRefundDate').jqxDateTimeInput({disabled: false});
        $('#jqxReferenceDate').jqxDateTimeInput({disabled: false});
        $('#chckib').attr('disabled', false);
        funSetlabel();
        document.getElementById("frmRentalRefund").submit();
        $('#chckib').attr('disabled', true);
        $('#frmRentalRefund select').attr('disabled', true);
        $('#jqxReferenceDate').jqxDateTimeInput({disabled: true});
        $('#jqxRentalRefundDate').jqxDateTimeInput({disabled: true});
        $('#window').jqxWindow('close');
    });
});
</script>

<div id="jqxrentalrefundsearch-wrapper">
    <div id="jqxrentalrefundsearch"></div>
</div>
