<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO DAO=new ClsAccMasterDAO(); %>
<style>
<style>
/* ================================
   RENTAL-STYLE SEARCH GRID THEME
================================ */

/* Wrapper card around the grid */
.grid-card {
    background: #ffffff;
    border-radius: 10px;
    padding: 10px 12px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 3px 8px rgba(40, 80, 160, 0.12);
}

/* Grid header (like rental page: flat, soft blue) */
.jqx-widget-header,
.jqx-grid-column-header {
    background: #f3f7ff !important;
    color: #29426f !important;
    border-color: #d7e1ff !important;
    font-weight: 600 !important;
    font-size: 13px !important;
}

/* Grid cells */
.jqx-grid-cell {
    font-size: 13px !important;
    border-color: #eef3ff !important;
    padding: 6px 8px !important;
}

/* Hover row */
.jqx-grid-cell-hover {
    background: rgba(63, 108, 255, 0.08) !important;
    cursor: pointer;
}

/* Selected row */
.jqx-grid-cell-selected {
    background: #3f6cff !important;
    color: #ffffff !important;
    font-weight: 600 !important;
}

/* No data text */
.no-data-message {
    text-align: center;
    padding: 20px;
    font-size: 14px;
    font-weight: 500;
    color: #6b7cb9;
}

/* ================================
   POPUP (jqxWindow) HEADER & CLOSE
================================ */

/* Window shell */
#accountSearchwindow,
.jqx-window {
    border-radius: 10px !important;
    border: 1px solid #3f6cff !important;
    background: #ffffff !important;
}

/* Header bar */
.jqx-window-header {
    background: #3f6cff !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    font-size: 14px !important;
    border-radius: 10px 10px 0 0 !important;
    position: relative;
}

/* Remove sprite background and draw our own × */
.jqx-window-close-button {
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
    width: 18px !important;
    height: 18px !important;
    position: absolute !important;
    top: 50% !important;
    right: 8px !important;
    margin-top: -9px !important;
    cursor: pointer !important;
}

/* actual X icon */
.jqx-window-close-button::before {
    content: "✕";
    display: block;
    width: 100%;
    height: 100%;
    font-size: 14px;
    line-height: 18px;
    text-align: center;
    color: #ffffff;
}

/* hover state */
.jqx-window-close-button:hover::before {
    background: rgba(255,255,255,0.18);
    border-radius: 4px;
}
</style>


 
 

 <script type="text/javascript">
 
	var accountData='<%=DAO.getcurr()%>';
 	$(document).ready(function () { 
 		
 		 // prepare the data
        var source =
        {
            datatype: "json",  
            datafields: [
                        {name : 'doc_no', type: 'int'   },
 						{name : 'code', type: 'string'   },
 						{name : 'rate', type: 'number'  },
 					 
                    ],
            		localdata: accountData, 
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
                                    
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source);
        
        $("#accountsSearchGridID").jqxGrid(
        {
        	width: '100%',
            height: 300,
            source: dataAdapter,
            selectionmode: 'singlerow',
 			editable: false,
 			columnsresize: true,
 			localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Doc No',  datafield: 'doc_no', hidden:true, width: '5%' },
			 
						{ text: 'Currency', datafield: 'code', width: '50%' },
						 
						{ text: 'Rate', datafield: 'rate', width: '50%' , cellsformat: 'd3', cellsalign: 'right', align: 'right' },
						 
					]
        });
         
         $('#accountsSearchGridID').on('rowdoubleclick', function (event) {
            
             var rowindex2 = event.args.rowindex; 
             
             document.getElementById("currs").value=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "code")
             document.getElementById("currsid").value=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "doc_no");
             var rates=$('#accountsSearchGridID').jqxGrid('getcellvalue', rowindex2, "rate");
         	funRoundRate(rates,"ratess");
             
         	document.getElementById("errormsg").innerText="";
           
			  $('#accountSearchwindow').jqxWindow('close'); 
       }); 
    });
</script>

<div id="accountsSearchGridID"></div>
    