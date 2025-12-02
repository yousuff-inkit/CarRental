<%@page import="com.fixedassets.assets.assetssalesinvoice.ClsAssetSalesInvDAO" %>
<%ClsAssetSalesInvDAO asi=new ClsAssetSalesInvDAO(); %>
 <%
 
 String docno = request.getParameter("docno")==null?"0":request.getParameter("docno");
 String date=request.getParameter("date")==null?"":request.getParameter("date");
 String client=request.getParameter("client")==null?"0":request.getParameter("client");
 String cmbtype = request.getParameter("type")==null?"":request.getParameter("type");
 String acno = request.getParameter("acno")==null?"0":request.getParameter("acno");
 String mobile=request.getParameter("mobile")==null?"0":request.getParameter("mobile");
 String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 
<style>
/* ------------------- GRID WRAPPER ------------------- */
#assetSalesSearch {
    margin-top: 10px;
}

/* ------------------- GRID MAIN BOX ------------------- */
.jqx-grid {
    border: 1px solid #c6ddf5 !important;
    border-radius: 10px !important;
    background-color: #ffffff !important;
    box-shadow: 0 4px 10px rgba(0, 92, 184, 0.15) !important;
    font-family: "Segoe UI", Roboto, sans-serif !important;
    font-size: 12px !important;
    color: #003366 !important;
}

/* ------------------- GRID HEADER ------------------- */
.jqx-grid-column-header {
    background: linear-gradient(180deg, #e9f1ff, #d7e5ff) !important;
    color: #003b8e !important;
    font-weight: 700 !important;
    border-bottom: 1px solid #c6d8ff !important;
    text-align: center !important;
}

/* Header text */
.jqx-grid-column-header .jqx-grid-column-header-text {
    padding-left: 5px !important;
    text-align: left !important;
    font-size: 12px !important;
}

/* ------------------- GRID ROWS ------------------- */
.jqx-grid-cell {
    border-color: #e1eaff !important;
    font-size: 12px !important;
    color: #003366 !important;
}

/* Alternating rows */
.jqx-grid-cell-alt {
    background-color: #f7faff !important;
}

/* Hover effect */
.jqx-grid-cell-hover {
    background-color: #e6f0ff !important;
    cursor: pointer !important;
}

/* Row selection */
.jqx-grid-cell-selected {
    background-color: #4a8dff !important;
    color: #ffffff !important;
}

/* ------------------- FILTER ROW ------------------- */
.jqx-grid-filterrow {
    background-color: #f0f4ff !important;
}

.jqx-input, 
.jqx-widget-content {
    border-radius: 6px !important;
    border: 1px solid #c9d9ff !important;
}

/* ------------------- DATE COLUMN ------------------- */
.jqx-date-time-input {
    border: 1px solid #bcd1ff !important;
    border-radius: 6px !important;
}

/* ------------------- SCROLLBAR ------------------- */
.jqx-scrollbar-thumb-state-normal {
    background: #bcd1ff !important;
}

.jqx-scrollbar-thumb-state-hover {
    background: #8fb4ff !important;
}

.jqx-scrollbar-button-state-normal {
    background: #e4ecff !important;
}

/* ------------------- WINDOW POPUP OF SEARCH ------------------- */
.jqx-window-header {
    background: linear-gradient(180deg, #0064c8, #004a99) !important;
    color: #ffffff !important;
    font-size: 13px !important;
}

.jqx-window-content {
    background-color: #f9fbff !important;
    border-radius: 10px !important;
}
</style>

 <script type="text/javascript">
 var temp='<%=request.getParameter("id")==null?"0":request.getParameter("id")%>';
  var subsearchdata;
if(temp=="1"){
	
	subsearchdata='<%=asi.getSearchData(docno,date,client,cmbtype,acno,mobile,branch)%>';	
	//alert(subsearchdata);
}
else{
	
}

        $(document).ready(function () { 	

            //var url="demo.txt"; 
        	var num = 0;
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'String' },
                          	{name : 'voc_no' , type: 'String' },
     						{name : 'date', type: 'date'  },
     						{name : 'acno', type: 'String'  },
     						{name : 'type', type: 'String'  },
     						{name : 'description', type: 'String'  },
     						{name : 'refname', type: 'String'  },
     						{name : 'trno', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						{name :'address',type:'string'},
     						{name :'per_mob',type:'string'},
     						{name :'mail1',type:'string'},
     						{name :'brhid',type:'string'},
     						{name :'typename',type:'string'}
                 ],
                localdata: subsearchdata,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#assetSalesSearch").jqxGrid(
            {
                width: '100%',
                height: 280,
                source: dataAdapter,
                columnsresize: true,
                //pageable: true,
                altRows: true,
               // editable: true,
                selectionmode: 'singlerow',
                //Add row method
                columns: [

							{ text: 'Original Doc No', datafield: 'doc_no', width: '10%',hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '10%' },
							{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Ac No', datafield: 'acno', width: '12%'},
							{ text: 'Type', datafield: 'type', width: '16.66%',hidden:true},
							{ text: 'Description', datafield: 'description', width: '80%',hidden:true},
							{ text: 'Client', datafield: 'refname', width: '32.64%'},
							{ text: 'TrNo', datafield: 'trno', width: '80%',hidden:true},
							{ text: 'Client Id', datafield: 'cldocno', width: '80%',hidden:true},
							{ text: 'Address',datafield:'address',width:'10%',hidden:true},
							{ text: 'Mobile',datafield:'per_mob',width:'16.66%'},
							{ text: 'Mail',datafield:'mail1',width:'10%',hidden:true},
							{ text: 'Branch',datafield:'brhid',width:'10%',hidden:true},
							{ text: 'Type',datafield:'typename', width: '16.66%'},
							]
            });
           
           $('#assetSalesSearch').on('rowdoubleclick', function (event) {
        	   var row2=event.args.rowindex;
        		 $('#date').jqxDateTimeInput({ disabled: false}); 
        			$('#frmAssetSalesInvoice select').attr('disabled', false );
           	document.getElementById("docno").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "doc_no");
           	document.getElementById("vocno").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "voc_no");
           	document.getElementById("trno").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "trno");
            $("#date").jqxDateTimeInput('val',$("#assetSalesSearch").jqxGrid('getcellvalue', row2, "date"));
            $('#cmbtype').val($("#assetSalesSearch").jqxGrid('getcellvalue', row2, "type")) ;
            document.getElementById("clientacno").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "acno");
            var temp="";
            temp=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "refname");
            temp=temp+",Address :"+$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "address");
            temp=temp+",Mobile :"+$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "per_mob");
            temp=temp+",Mail :"+$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "mail1");
            document.getElementById("clientname").value=temp;
            document.getElementById("client").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "cldocno");
            document.getElementById("description").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "description");
            $('#date').jqxDateTimeInput({ disabled: true}); 
			$('#frmAssetSalesInvoice select').attr('disabled', true );
			document.getElementById("hidbranch").value=$('#assetSalesSearch').jqxGrid('getcellvalue', row2, "brhid");
			$('#assetInvoicediv').load('assetInvoiceGrid.jsp?docno='+document.getElementById("docno").value+'&branch='+document.getElementById("brchName").value+'&id=1');
               $('#window').jqxWindow('close');
            }); 
        
        });
    </script>
    <div id="assetSalesSearch"></div>