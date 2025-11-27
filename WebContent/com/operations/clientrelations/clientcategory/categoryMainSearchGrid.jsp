<%@page import="com.operations.clientrelations.clientcategory.ClsClientCategoryAction"%>
<% ClsClientCategoryAction ACTION= new ClsClientCategoryAction(); %>  
<% String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<!-- ===== CATEGORY GRID CSS (CNO-THEMED) ===== -->
<style>
/* Outer wrapper */
#jqxCategorySearch-wrapper {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
    box-sizing: border-box;
}

/* Grid headers */
.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
    text-align: center !important;
}

/* Grid cells */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
    color: #263b75;
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

/* Ensure full width */
#jqxCategorySearch {
    width: 100% !important;
    height: 350px;
    box-sizing: border-box;
}

/* Responsive tweaks */
@media(max-width:720px) {
    #jqxCategorySearch {
        width: 100% !important;
    }
    .jqx-grid-cell, .jqx-grid-column-header {
        font-size: 0.8rem !important;
    }
}
</style>

<script type="text/javascript">
    var data1= '<%=ACTION.searchDetails(check) %>';
    $(document).ready(function () {
        var source =
        {
            datatype: "json",
            datafields: [
                {name : 'doc_no', type: 'int'},
                {name : 'category', type: 'String'},
                {name : 'cat_name', type: 'String'},
                {name : 'dtypes', type: 'String'},
                {name : 'dtype', type: 'String'},
                {name: 'approval', type: 'int'},
                {name : 'acc_group', type: 'String'}
            ],
            localdata: data1,
            pager: function (pagenum, pagesize, oldpagenum) {}
        };

        var dataAdapter = new $.jqx.dataAdapter(source, {
            loadError: function (xhr, status, error) {
                alert(error);    
            }
        });

        $("#jqxCategorySearch").jqxGrid({
            width: '100%',
            height: 350,
            source: dataAdapter,
            showfilterrow: true, 
            filterable: true, 
            selectionmode: 'singlerow',
            columnsresize: true,
            columns: [
                { text: 'Doc No', hidden : true, datafield: 'doc_no', width: '10%' },
                { text: 'Type', datafield: 'dtypes', width: '10%' },
                { text: 'Category', datafield: 'category', width: '40%' },
                { text: 'Category Name', datafield: 'cat_name', width: '50%' },
                { text: 'Type', datafield: 'dtype', hidden: true, width: '10%' },
                { text: 'Approval', datafield: 'approval', hidden: true, filterable: false, width: '10%' },
                { text: 'Account Group', filterable: false, datafield: 'acc_group', hidden: true, width: '10%' }
            ]
        });

        $('#jqxCategorySearch').on('rowdoubleclick', function (event) {
            var rowindex1=event.args.rowindex;
            funReset();
            getAccountGroup($("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "dtype"));
            document.getElementById("docno").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
            document.getElementById("txtcategory").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "category");
            document.getElementById("txtcategoryname").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "cat_name");
            document.getElementById("cmbtype").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "dtype");
            document.getElementById("cmbaccountgroup").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "acc_group");
            document.getElementById("hidcmbaccountgroup").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "acc_group");
            document.getElementById("hidchckapproval").value = $("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "approval");

            if($("#jqxCategorySearch").jqxGrid('getcellvalue', rowindex1, "approval")==1){
                document.getElementById("chckapproval").checked = true;
            } else {
                document.getElementById("chckapproval").checked = false;
            }
            $('#window').jqxWindow('close');
        }); 
    });
</script>

<div id="jqxCategorySearch-wrapper">
    <div id="jqxCategorySearch"></div>
</div>
