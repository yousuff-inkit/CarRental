<%@page import="com.common.ClsExeFolio" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>

<% 
    ClsExeFolio cef = new ClsExeFolio(); 
    int flag = request.getParameter("flag") == null ? 0 : Integer.parseInt(request.getParameter("flag").trim()); 
%>

<style>
    /* NOTE: html/body styles removed here because they exist in main.jsp */

    .filter-container {
        height: 30px; 
        padding: 0 10px;
        background-color: #f1f3f4;
        border-bottom: 1px solid #ccc;
        display: flex;
        align-items: center; 
        gap: 10px;
        flex-wrap: nowrap; 
        overflow: hidden;
        box-sizing: border-box;
    }
    
    .filter-group {
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .filter-label {
        font-weight: bold;
        color: #444;
        font-size: 11px;
        margin-top: 1px; 
    }
    
    .custom-select {
        height: 22px; 
        padding: 1px;
        border: 1px solid #aaa;
        border-radius: 3px;
        font-size: 11px;
        min-width: 100px;
    }
    
    .btn-filter {
        background-color: #007bff;
        color: white;
        border: 1px solid #0069d9;
        padding: 2px 10px; 
        border-radius: 3px;
        cursor: pointer;
        font-size: 10px;
        font-weight: bold;
        height: 22px;
        line-height: 16px; 
    }
    .btn-filter:hover { background-color: #0056b3; }
    
    .btn-clear {
        background-color: #fff;
        color: #333;
        border: 1px solid #ccc;
        padding: 2px 10px;
        border-radius: 3px;
        cursor: pointer;
        font-size: 10px;
        height: 22px;
        line-height: 16px;
    }
    .btn-clear:hover { background-color: #e2e6ea; }
</style>

<script type="text/javascript">
    var ependata1;
    $(document).ready(function () {      
        ependata1='<%=cef.exefolioDataGridload(flag,session)%>';
        
        $("#txtFromDate").jqxDateTimeInput({ width: '100px', height: '22px', formatString: 'dd/MM/yyyy', value: null });
        $("#txtToDate").jqxDateTimeInput({ width: '100px', height: '22px', formatString: 'dd/MM/yyyy', value: null });
        
        var source = {
            datatype: "json",
            datafields: [
                {name : 'branch', type: 'string' },
                {name : 'subdatetime', type: 'date', format: 'd/M/yyyy HH:mm:ss' }, 
                {name : 'doctype', type: 'string' },
                {name : 'doc_no', type: 'string' },
                {name : 'submitedby', type: 'string' },
                {name : 'approved', type: 'number' },
                {name : 'path', type: 'String' },
                {name : 'name', type: 'String' },
                {name : 'refname', type: 'String' },
                {name : 'desc1', type: 'String' },
                {name : 'doc_type', type: 'String' },
            ],
            localdata: ependata1
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#jqxapprovalDataGrid").jqxGrid({
            width: '100%',   
            height: '100%', /* Fills the container div exactly */
            source: dataAdapter,
            editable: false,    
            selectionmode: 'singlerow',   
            filterable: true,
            showfilterrow: true,  
            columnsresize: true,
            sortable: true, 
            enabletooltips: true, 
            columns: [
                { text: 'Sr.', columntype: 'number', width: '5%', cellsalign: 'center', align: 'center',
                  cellsrenderer: function (row, column, value) {
                      return "<div style='margin-top:5px;'>" + (value + 1) + "</div>";
                  }  
                },                            
                { text: 'Br', datafield: 'branch', width: '5%' },
                { 
                    text: 'Status', datafield: 'approved', width: '10%',
                    cellsrenderer: function (row, column, value) {
                        if (value == 1) return '<span style="color:orange; font-weight:bold;">Pending</span>';
                        else if (value == 3) return '<span style="color:green; font-weight:bold;">Approved</span>';
                        else return '<span style="color:red; font-weight:bold;">Rejected</span>';
                    }
                },
                { text: 'Date', datafield: 'subdatetime', width: '12%', cellsformat: 'dd/MM/yyyy', filtertype: 'date' },
                { text: 'Type', datafield: 'doctype', width: '8%' },
                { text: 'Doc No', datafield: 'doc_no', width: '8%' },    
                { text: 'User', datafield: 'submitedby', width: '15%' },
                { text: 'Description', datafield: 'desc1', width: '37%'}, 
                { text: 'Client', hidden:true, datafield: 'refname' },
                { text: 'Path', hidden:true, datafield: 'path' },
                { text: 'name', hidden:true, datafield: 'name' },
                { text: 'dtype', hidden:true, datafield: 'dtype' }
            ]  
        });
        
        $("#overlay, #PleaseWait").hide();        
        
        window.applyCustomFilter = function() {
            $("#jqxapprovalDataGrid").jqxGrid('clearfilters');
            var statusVal = $("#cmbStatus").val();
            var dateFrom = $("#txtFromDate").jqxDateTimeInput('getDate');
            var dateTo = $("#txtToDate").jqxDateTimeInput('getDate');
            var filtergroupStatus = new $.jqx.filter();
            var filtergroupDate = new $.jqx.filter();
            
            if (statusVal != "All") {
                if(statusVal == "Rejected") {
                    var f1 = filtergroupStatus.createfilter('numericfilter', 1, 'not_equal');
                    var f2 = filtergroupStatus.createfilter('numericfilter', 3, 'not_equal');
                    filtergroupStatus.addfilter(0, f1); 
                    filtergroupStatus.addfilter(0, f2); 
                } else {
                    var filter = filtergroupStatus.createfilter('numericfilter', parseInt(statusVal), 'equal');
                    filtergroupStatus.addfilter(1, filter);
                }
                $("#jqxapprovalDataGrid").jqxGrid('addfilter', 'approved', filtergroupStatus);
            }
            if(dateFrom || dateTo) {
                if(dateFrom) {
                    dateFrom.setHours(0,0,0,0);
                    var fFrom = filtergroupDate.createfilter('datefilter', dateFrom, 'GREATER_THAN_OR_EQUAL');
                    filtergroupDate.addfilter(0, fFrom);
                }
                if(dateTo) {
                    dateTo.setHours(23,59,59,999);
                    var fTo = filtergroupDate.createfilter('datefilter', dateTo, 'LESS_THAN_OR_EQUAL');
                    filtergroupDate.addfilter(0, fTo);
                }
                $("#jqxapprovalDataGrid").jqxGrid('addfilter', 'subdatetime', filtergroupDate);
            }
            $("#jqxapprovalDataGrid").jqxGrid('applyfilters');
        }

        window.clearCustomFilter = function() {
            $("#cmbStatus").val("All");
            $("#txtFromDate").jqxDateTimeInput('val', null);
            $("#txtToDate").jqxDateTimeInput('val', null);
            $("#jqxapprovalDataGrid").jqxGrid('clearfilters');
        }

        $("#jqxapprovalDataGrid").on('rowdoubleclick', function (event) {
            var rowindextemp = event.args.rowindex;
            var doc_no=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doc_no");
            var path1=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "path");
            var brch=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "branch");
            var doctype=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doctype");
            var name=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "name");
            
            document.getElementById('formName').value = name;
            document.getElementById('formCode').value = doctype;        
            document.getElementById('branchid').value = brch;
            document.getElementById('mode').value = "view";        
            
            var url=document.URL;                                
            var reurl=url.split("com");            
            
            window.parent.formName.value=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "name");
            window.parent.formCode.value=$("#jqxapprovalDataGrid").jqxGrid('getcellvalue', rowindextemp, "doctype");
            
            var path= path1+"?mode=view&docno="+doc_no+"&exefolio=1&brch="+brch+"&doctype="+doctype+"&name="+name;
            $("#folio").attr("src",reurl[0]+""+path);        
        });    
    });  
</script>

<div class="filter-container">
    <div class="filter-group">
        <span class="filter-label">Status:</span>
        <select id="cmbStatus" class="custom-select" onchange="applyCustomFilter()">
            <option value="All">Show All</option>
            <option value="1">Pending</option>
            <option value="3">Approved</option>
            <option value="Rejected">Rejected</option>
        </select>
    </div>

    <div class="filter-group" style="margin-left:15px;">
        <span class="filter-label">From:</span>
        <div id="txtFromDate"></div>
    </div>

    <div class="filter-group">
        <span class="filter-label">To:</span>
        <div id="txtToDate"></div>
    </div>

    <div class="filter-group" style="margin-left:10px;">
        <button type="button" class="btn-filter" onclick="applyCustomFilter()">Search</button>
        <button type="button" class="btn-clear" onclick="clearCustomFilter()">Clear</button>
    </div>
</div>

<div id="jqxapprovalDataGrid" style="width:100%; height: calc(100% - 30px); overflow: hidden; box-sizing: border-box;"></div>
<input type="hidden" id="rowindex"/>