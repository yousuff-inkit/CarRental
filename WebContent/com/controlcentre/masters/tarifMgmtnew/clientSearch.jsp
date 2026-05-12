<%@page import="com.controlcentre.masters.tarifmgmtnew.ClsTarifDAO" %>
<%
    ClsTarifDAO ctd = new ClsTarifDAO(); 
    String tariftype = request.getParameter("tariftype"); 
    
    Object rawClientData = ctd.getClient(tariftype);
    String clientData = "[]"; 
    
    if (rawClientData != null && !rawClientData.toString().trim().isEmpty()) {
        clientData = rawClientData.toString();
    }
%>

<div id="clientSearch"></div>

<script type="text/javascript">
(function () {   
    var dataclient = <%= clientData %>;

    var source = {
        datatype: "json", 
        datafields: [
            { name: 'doc_no', type: 'int' },
            { name: 'refname', type: 'string' }
        ],
        localdata: dataclient
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
        loadError: function (xhr, status, error) {
            console.error("Grid Load Error: ", error);
        }       
    });

    $("#clientSearch").jqxGrid({
        width: '100%',
        height: 330,
        source: dataAdapter,
        columnsresize: true,
        altRows: true,
        selectionmode: 'singlerow',
        columns: [
            { text: 'Doc No', datafield: 'doc_no', width: '20%' },
            { text: 'Client Name', datafield: 'refname', width: '80%' }
        ]
    });
   
    $('#clientSearch').on('rowdoubleclick', function (event) {
        var rowindex1 = event.args.rowindex;
        
        // Use jQuery to set the parent inputs safely
        var docNo = $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
        var refName = $('#clientSearch').jqxGrid('getcellvalue', rowindex1, "refname");
        
        $("#hidtxtclient").val(docNo);
        $("#txtclient").val(refName);
        
        $('#clienttarifwindow').jqxWindow('close');
    });  
})();
</script>
    <div id="clientSearch"></div>
