<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO DAO=new ClsAccMasterDAO(); %>
<style>
/* ================================
   PREMIUM BLUE GRID THEME
================================ */

/* Grid Outer Glow + Rounded Look */
#accountsSearchGridID {
    border-radius: 14px !important;
    overflow: hidden !important;
    box-shadow: 0 6px 20px rgba(70,110,255,0.18) !important;
    border: 1px solid #dce6ff !important;
}

/* Column Header Styling */
#accountsSearchGridID .jqx-grid-column-header {
    background: linear-gradient(90deg,#5fa4ff,#88b6ff) !important;
    color: #ffffff !important;
    font-weight: 600 !important;
    border: none !important;
    font-size: 0.9rem !important;
    text-align: center !important;
}

/* Header separator removal */
#accountsSearchGridID .jqx-widget-header {
    border-bottom: none !important;
}

/* Grid Row Normal State */
#accountsSearchGridID .jqx-grid-cell {
    background: #ffffff !important;
    font-size: 0.88rem !important;
    color: #33406b !important;
    border-color: #e6edff !important;
}

/* Hover highlight */
#accountsSearchGridID .jqx-grid-cell-hover {
    background: rgba(80,120,255,0.10) !important;
    transition: 0.2s ease !important;
}

/* Selected Row */
#accountsSearchGridID .jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: white !important;
    font-weight: 600 !important;
}

/* Right Align "Rate" Column Content */
#accountsSearchGridID .jqx-grid-column {
    text-align: center !important;
}

/* Improve scrollbar appearance */
#accountsSearchGridID ::-webkit-scrollbar {
    width: 7px;
}

#accountsSearchGridID ::-webkit-scrollbar-thumb {
    background: #8fb4ff;
    border-radius: 8px;
}

#accountsSearchGridID ::-webkit-scrollbar-track {
    background: #eef4ff;
}

/* Row Hover Animation */
#accountsSearchGridID .jqx-grid-cell {
    transition: background 0.18s ease, color 0.18s ease;
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
    