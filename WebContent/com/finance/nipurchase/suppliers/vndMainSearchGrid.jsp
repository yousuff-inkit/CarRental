<%@page import="com.finance.nipurchase.suppliers.ClsVendorDetailsDAO" %>
<%  ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
<%
 String vndname = request.getParameter("vndname")==null?"0":request.getParameter("vndname");
 String vndaccno = request.getParameter("vndaccno")==null?"0":request.getParameter("vndaccno");
 String vndmob = request.getParameter("vndmob")==null?"0":request.getParameter("vndmob");
 String vndtel = request.getParameter("vndtel")==null?"0":request.getParameter("vndtel");
%>

<style>
/* GRID WRAPPER CARD */
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
    margin-top: 8px;
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

/* ensure jqxGrid container expands inside wrapper */
#jqxVendorSearch {
    width: 100% !important;
    height: 300px !important;
}
</style>

<script type="text/javascript">
var data1= '<%= DAO.vndMainSearch(vndname,vndaccno,vndmob,vndtel) %>';

$(document).ready(function (){

    var source =
    {
        datatype: "json",
        datafields: [
            {name : 'refname' , type: 'String' },
            {name : 'acno', type: 'String'  },
            {name : 'per_mob', type: 'String'  },
            {name : 'per_tel', type: 'String'  },
            {name : 'doc_no', type: 'int'  }
        ],
        localdata: data1
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) { alert(error); }
    });

    $("#jqxVendorSearch").jqxGrid({
        width: '100%',
        height: 300,
        rowsheight: 36,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable: false,
        columnsresize: true,
        columns: [
            { text: 'Name', datafield: 'refname', width: '30%' },
            { text: 'Account No.', datafield: 'acno', width: '20%' },
            { text: 'Mobile No.', datafield: 'per_mob', width: '25%' },
            { text: 'Telephone No.', datafield: 'per_tel', width: '25%' },
            { text: 'Doc No', hidden: true, datafield: 'doc_no', width: '5%' }
        ]
    });

    $('#jqxVendorSearch').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        funReset();
        document.getElementById("txtvendorname").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "refname");
        document.getElementById("txtaccount").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "acno");
        document.getElementById("txttel").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
        document.getElementById("txtmob").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "per_mob");
        document.getElementById("docno").value= $('#jqxVendorSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");

        $('#frmVendorDetails select').attr('disabled', false);
        $('#jqxVendorDate').jqxDateTimeInput({disabled: false});
        funSetlabel();
        document.getElementById("frmVendorDetails").submit();
        $('#frmVendorDetails select').attr('disabled', true);
        $('#jqxVendorDate').jqxDateTimeInput({disabled: true});
        $('#window').jqxWindow('close');
    });
});
</script>

<div class="grid-card">
    <div id="jqxVendorSearch"></div>
</div>
