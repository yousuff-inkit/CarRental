<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<style>

#jqxclientsearch-wrapper {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* JQX Grid header and column header styling */
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

/* Hover effect */
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

/* Ensure the grid takes full width of wrapper */
#jqxclientsearch {
    width: 100% !important;
    height: 300px;
    box-sizing: border-box;
}
</style>

<script type="text/javascript">
$(document).ready(function () { 
    var urlclient='getUrlClient.jsp?clname=<%=clname%>&mob=<%=mob%>&lcno=<%=lcno%>&clientid=<%=clientid%>&driverid=<%=driverid%>&nation=<%=nation%>&dob=<%=dob%>&clientaccount=<%=clientaccount%>&check=<%=check%>';
    var source = {
        datatype: "json",
        datafields: [
            {name : 'clientid', type: 'int'},
            {name : 'refname', type: 'String'},
            {name : 'account', type: 'String'},
            {name : 'dob', type: 'date'},
            {name : 'dates', type: 'date'},
            {name : 'per_tel', type: 'String'}, 
            {name : 'per_mob', type: 'String'},
            {name : 'visano', type: 'String'},
            {name : 'dlno', type: 'String'}, 
            {name : 'nation', type: 'String'}
        ],
        url: urlclient,
        pager: function (pagenum, pagesize, oldpagenum) {}
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            alert(error);    
        }
    });

    $("#jqxclientsearch").jqxGrid({
        width: '99%',
        height: 300,
        source: dataAdapter,
        selectionmode: 'singlerow',
        editable: false,
        columnsresize: true,
        columns: [
            { text: 'Client#', datafield: 'clientid', width: '6%' },
            { text: 'Name', datafield: 'refname', width: '28%' },
            { text: 'Date', datafield: 'dates', width: '9%', cellsformat: 'dd.MM.yyyy' },
            { text: 'Account', datafield: 'account', width: '7%' },
            { text: 'DOB', datafield: 'dob', width: '9%', cellsformat: 'dd.MM.yyyy' },
            { text: 'Tel', datafield: 'per_tel', width: '10%' }, 
            { text: 'Mob', datafield: 'per_mob', width: '12%' },
            { text: 'ID#', datafield: 'visano', width: '9%' },
            { text: 'Licence#', datafield: 'dlno', width: '9%' },
            { text: 'Nation', datafield: 'nation', width: '10%' },
        ]
    });

    $('#jqxclientsearch').on('rowdoubleclick', function (event) {
        var rowindex1=event.args.rowindex;
        var rowindex2 =$('#rowindex').val();
        document.getElementById("txtclient_name").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "refname");
        document.getElementById("docno").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientid");
        document.getElementById("txtpersonal_tel1").value= $('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "per_tel");
        $('#jqxDriver').jqxGrid('setcellvalue', rowindex2, "doc_no" ,$('#jqxclientsearch').jqxGrid('getcellvalue', rowindex1, "clientid"));
        
        $('#frmClientMaster select').attr('disabled', false);
        $('#jqxClientDate').jqxDateTimeInput({disabled: false});
        document.getElementById("frmClientMaster").submit();
        $('#frmClientMaster select').attr('disabled', true);
        $('#jqxClientDate').jqxDateTimeInput({disabled: true});
        
        $('#window').jqxWindow('close');
    });  
}); 
</script>

<div id="jqxclientsearch-wrapper">
    <div id="jqxclientsearch"></div>
</div>
