<%@page import="com.fixedassets.assets.assetmaster.ClsAssetmasterDAO" %>
<%ClsAssetmasterDAO amd=new ClsAssetmasterDAO(); %>

 <%
 //assetname,assetid,sdocno,assetgroup,chk
String assetname = request.getParameter("assetname")==null?"0":request.getParameter("assetname");
 String assetid = request.getParameter("assetid")==null?"0":request.getParameter("assetid");
 String sdocno = request.getParameter("sdocno")==null?"0":request.getParameter("sdocno");
 String assetgroup = request.getParameter("assetgroup")==null?"0":request.getParameter("assetgroup");
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 
%> 
<style>
/* ------------------- GRID WRAPPER ------------------- */
#mastersearch {
    margin-top: 10px;
}

/* ------------------- MAIN GRID BOX ------------------- */
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

.jqx-grid-column-header .jqx-grid-column-header-text {
    padding-left: 5px !important;
    font-size: 12px !important;
}

/* ------------------- ROW STYLING ------------------- */
.jqx-grid-cell {
    border-color: #e1eaff !important;
    font-size: 12px !important;
    color: #003366 !important;
    background-color: #ffffff !important;
}

/* Alternating row */
.jqx-grid-cell-alt {
    background-color: #f7faff !important;
}

/* Hover effect */
.jqx-grid-cell-hover {
    background-color: #e6f0ff !important;
    cursor: pointer !important;
}

/* Selected row */
.jqx-grid-cell-selected {
    background-color: #4a8dff !important;
    color: #ffffff !important;
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

/* ------------------- WINDOW POPUP (if used) ------------------- */
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


        	 var barnddata1='<%=amd.masterSearch(session,assetname,assetid,sdocno,assetgroup,chk)%>';
        	 
        
    		  
			 
		$(document).ready(function () { 	
    
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'doc_no', type: 'string'  },
                            {name : 'assetid', type: 'string'  },
                            {name : 'assetname', type: 'string'  },
                            {name : 'date', type: 'date'  },
                            {name : 'gpname', type: 'string'  },
                            {name : 'sr_no', type: 'string'  },
                            
                            
     						
                        ],
                		
                		//  url: url1,
                 localdata: barnddata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#mastersearch").jqxGrid(
            {
            	   width: '99.9%',
            	   height: 285,
                   source: dataAdapter,
               
                 
                   selectionmode: 'singlerow',
                   pagermode: 'default',
            
                
            
                       
                columns: [
						
                          


                     
                            
                              { text: 'Doc NO', datafield: 'doc_no', width: '10%' },
                              { text: 'Date', datafield: 'date', width: '10%',cellsformat:'dd.MM.yyyy' },
                              { text: 'Asset Group', datafield: 'gpname', width: '30%' },
                              { text: 'Asset Id', datafield: 'assetid', width: '15%' },
                              { text: 'Asset Name', datafield: 'assetname', width: '35%' },
                              { text: 'srno', datafield: 'sr_no', width: '50%' ,hidden:true},
                              
                       
                            
                        
                         
	             
						]
            });
            $('#mastersearch').on('rowdoubleclick', function (event) 
            		{ 
        	  var rowindex1=event.args.rowindex;
        	
        			document.getElementById("docno").value=$("#mastersearch").jqxGrid('getcellvalue', rowindex1, "doc_no");
        			document.getElementById("srno").value=$("#mastersearch").jqxGrid('getcellvalue', rowindex1, "sr_no");
        			//document.getElementById("masterrefno").value=$("#jqxmainsearch").jqxGrid('getcellvalue', rowindex1, "vocno");
	   			
	              $('#window').jqxWindow('close');
	              funSetlabel();
	              fundeleterestriction()
	              document.getElementById("frmassetmastrer").submit();

            		 });	
          
        });
    </script>
    <div id="mastersearch"></div>