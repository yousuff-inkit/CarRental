<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%>

<%
String trfficdoc = request.getParameter("trafficdocno")==null?"0":request.getParameter("trafficdocno").trim();
%>

<style>

#traficgrid-wrapper {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* Header */
.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

/* Cells */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

/* Hover */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* Selected */
.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: #ffffff !important;
}

/* Ensure width */
#traficgrid {
    width: 100% !important;
    height: 300px !important;
}
</style>

<script type="text/javascript">

var traficdata;
var temp1='<%=trfficdoc%>';

if(temp1>0){
    traficdata = '<%=cstd.reloadtraffic(trfficdoc)%>';
}

$(document).ready(function () {

var source = {
    datatype: "json",
    datafields: [
        {name : 'source', type: 'string'},
        {name : 'pltid', type: 'string'},
        {name : 'regno', type: 'string'},
        {name : 'fleetno', type: 'string'},
        {name : 'finesource', type: 'string'},
        {name : 'fineno', type: 'number'},
        {name : 'date', type: 'date'},
        {name : 'time', type: 'string'},
        {name : 'amount', type: 'number'},
        {name : 'description', type:'string'},
        {name : 'location', type: 'string'},
        {name : 'hiddate', type: 'string'},
        {name : 'hidtime', type: 'string'},
        {name : 'tcno', type: 'string'}
    ],
    localdata: traficdata
};

var dataAdapter = new $.jqx.dataAdapter(source,{});

$("#traficgrid").jqxGrid({
    width: '100%',
    height: 300,
    source: dataAdapter,
    disabled:true,
    selectionmode: 'singlecell',
    editable:true,

    columns: [
        { text: 'SL#', datafield: 'sl', columntype: 'number',
          width: '3%', editable:false,
          cellsrenderer: function (row, col, value) {
            return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
          }
        },
        { text: 'Fleet', datafield: 'fleetno', width: '8%', editable:false },
        { text: 'Reg No', datafield: 'regno', width: '8%', editable:false },
        { text: 'Plate Source', datafield: 'source', width: '7%', editable:false },
        { text: 'Plate Code', datafield: 'pltid', width: '5%', editable:false },
        { text: 'Fine Source', datafield: 'finesource', width: '8%' },
        { text: 'Fine No', datafield: 'fineno', width: '8%' },
        { text: 'Date', datafield: 'date', width: '8%',
          columntype: 'datetimeinput', cellsformat:'dd.MM.yyyy' },
        { text: 'Time', datafield: 'time', width: '5%', 
          cellsformat:'HH:mm', columntype:"datetimeinput" },
        { text: 'Amount', datafield: 'amount', width: '9%',
          cellsformat: 'd2', cellsalign: 'right', align:'right' },
        { text: 'Description', datafield: 'description', width: '16%' },
        { text: 'Location', datafield: 'location', width: '15%' },
        { text: 'hiddate', datafield: 'hiddate', width: '8%', hidden:true },
        { text: 'hidtime', datafield: 'hidtime', width: '8%', hidden:true },
        { text: 'tc_no', datafield: 'tcno', width: '8%', hidden:true }
    ]
});

$("#traficgrid").jqxGrid('addrow', null, {});

});
</script>

<div id="traficgrid-wrapper">
    <div id="traficgrid"></div>
</div>

<input type="hidden" id="rowindex"/>
