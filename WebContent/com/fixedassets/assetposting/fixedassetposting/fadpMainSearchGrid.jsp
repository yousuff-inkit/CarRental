<%@page import="com.fixedassets.assetposting.fixedassetposting.ClsFixedAssetDepreciationPostingDAO" %>
<%ClsFixedAssetDepreciationPostingDAO fdp=new ClsFixedAssetDepreciationPostingDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String partyname = request.getParameter("partyname")==null?"0":request.getParameter("partyname");
 String docNo = request.getParameter("docNo")==null?"0":request.getParameter("docNo");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 String amount = request.getParameter("amount")==null?"0":request.getParameter("amount");
 String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
%> 
<style>

    /* Main Grid Styling */
    #jqxFixedAssetDepreciationMainSearch {
        border: 1px solid #c6ddf5 !important;
        border-radius: 10px !important;
        background-color: #ffffff !important;
        box-shadow: 0 4px 12px rgba(0, 92, 184, 0.15) !important;
        margin-top: 10px;
        font-family: "Segoe UI", Roboto, sans-serif !important;
    }

    /* Header Styling */
    .jqx-grid-header {
        background: linear-gradient(to right, #0d6efd, #5aa9ff) !important;
        color: white !important;
        font-weight: bold !important;
        font-size: 13px !important;
        text-align: center !important;
    }

    /* Grid Rows */
    .jqx-grid-cell {
        font-size: 12px !important;
        color: #333 !important;
    }

    /* Hover Effect on Rows */
    .jqx-grid-cell-hover {
        background-color: #e7f1ff !important;
    }

    /* Selected Row */
    .jqx-grid-cell-selected {
        background-color: #cfe2ff !important;
        color: #003f91 !important;
    }

    /* Search Button (if any) */
    .search-btn {
        background-color: #0d6efd;
        color: white;
        padding: 8px 16px;
        border-radius: 6px;
        border: none;
        cursor: pointer;
        transition: 0.3s ease;
        font-family: inherit;
        font-size: 14px;
    }

    /* Hover Effect for Search Button */
    .search-btn:hover {
        background-color: #0b5ed7;
        box-shadow: 0 4px 10px rgba(13, 110, 253, 0.3);
        transform: translateY(-2px);
    }

</style>

 <script type="text/javascript">
 
 			var data1='<%=fdp.fadpMainSearch(branch, partyname, docNo, date, amount)%>';
			 $(document).ready(function () { 

        	var source = 
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'int' },
     						{name : 'date', type: 'date'  },
     						{name : 'total', type: 'number' },
     						{name : 'user_name', type: 'String' },
     						{name : 'tr_no', type: 'int' }
                          	],
                          	localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxFixedAssetDepreciationMainSearch").jqxGrid(
            {
                width: '99%',
                height: 300,
                source: dataAdapter,
                selectionmode: 'singlerow',
     			editable: false,
     			columnsresize: true,
     			localization: {thousandsSeparator: ""},
     			
                columns: [
					 { text: 'Doc No', datafield: 'doc_no', width: '20%' },
					 { text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , width: '20%' },
					 { text: 'Total', datafield: 'total', cellsformat: 'd2', width: '20%', cellsalign: 'right', align: 'right' },
					 { text: 'User Name', datafield: 'user_name', width: '40%' },
					 { text: 'Tr No', hidden: true, datafield: 'tr_no', width: '10%' },
					]
            });
            
			  $('#jqxFixedAssetDepreciationMainSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
				funReset();
                $("#jqxFixedAssetDepreciationPostingDate").jqxDateTimeInput('val', $("#jqxFixedAssetDepreciationMainSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                document.getElementById("docno").value= $('#jqxFixedAssetDepreciationMainSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txttrno").value= $('#jqxFixedAssetDepreciationMainSearch').jqxGrid('getcellvalue', rowindex1, "tr_no");
                
                 var indexVal = document.getElementById("txttrno").value;
	   			 if(indexVal>0){
	   	         $("#accountsDetailsDiv").load("accountsDetailsGrid.jsp?trno="+indexVal);
	   			 }
	   	         
	   			 var indexVal1 = document.getElementById("docno").value;
	   	         var indexVal2 = document.getElementById("txttrno").value;
	   	         if(indexVal1>0){
	   	         $("#vehiclesDetailsDiv").load("assetDetailsGrid.jsp?docno="+indexVal1+"&trno="+indexVal2);
   	             } 
   	         
               $('#window').jqxWindow('close');
            });   
				           
}); 
				       
                       
    </script>
    <div id="jqxFixedAssetDepreciationMainSearch"></div>
    