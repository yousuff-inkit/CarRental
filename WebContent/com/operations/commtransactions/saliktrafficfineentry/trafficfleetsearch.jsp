<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%> 

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<style>



#trafficflsearch-wrapper {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* Grid header */
.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

/* Grid cells */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

/* Hover */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* Selected row */
.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: #ffffff !important;
}

/* No data message */
.no-data-message {
    text-align: center;
    padding: 20px;
    font-size: 0.9rem;
    font-weight: 600;
    color: #6b7cb9;
}

/* Ensure grid fills wrapper */
#trafficflsearch {
    width: 100% !important;
    height: 330px !important;
}
</style>

<script type="text/javascript">

   var mtufleet='<%=cstd.trafficsearchfleet(session)%>';
  
$(document).ready(function () {

    var num = 0; 
    var source = {
        datatype: "json",
        datafields: [
            {name : 'reg_no', type: 'String'},
            {name : 'fleet_no', type: 'String'},
            {name : 'pltid', type: 'String'},
            {name : 'flname', type: 'String'},
            {name : 'authid', type: 'String'},
            {name : 'tcno', type: 'String'}
        ],
        localdata: mtufleet
    };
            
    var dataAdapter = new $.jqx.dataAdapter(source,
    {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });

    $("#trafficflsearch").jqxGrid({
        width: '99.9%',
        height: 330,
        source: dataAdapter,
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',

        columns: [
            { text: 'FLEET', datafield: 'fleet_no', width: '17%' },
            { text: 'NAME', datafield: 'flname', width: '65%' },
            { text: 'Reg NO', datafield: 'reg_no', width: '18%' },
            { text: 'TCNO', datafield: 'tcno', width: '15%', hidden:true }
        ]
    });
            
    $('#trafficflsearch').on('rowdoubleclick', function (event) { 
        var rowBoundIndex = event.args.rowindex;
        var rowindex3 =$('#rowindex').val();

        $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "fleetno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "fleet_no"));
        $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "regno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "reg_no"));
        $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "source" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "authid"));
        $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "pltid" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "pltid"));
        $('#traficgrid').jqxGrid('setcellvalue', rowindex3, "tcno" ,$('#trafficflsearch').jqxGrid('getcellvalue', rowBoundIndex, "tcno"));

        var rows = $('#traficgrid').jqxGrid('getrows');
        var rowlength = rows.length;

        if(rowindex3==rowlength-1){
            $("#traficgrid").jqxGrid('addrow', null, {}); 
        }  

        $('#tafficfleetsearchwindow').jqxWindow('close');
    });
});
</script>

<div id="trafficflsearch-wrapper">
    <div id="trafficflsearch"></div>
</div>
