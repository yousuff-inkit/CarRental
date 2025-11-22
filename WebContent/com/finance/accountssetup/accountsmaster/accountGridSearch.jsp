<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.accountssetup.accountsMaster.ClsAccMasterDAO" %>
<%ClsAccMasterDAO DAO=new ClsAccMasterDAO(); %>
<style>
/* GRID WRAPPER CARD */
.grid-card {
    background: #ffffff;
    border-radius: 12px;
    padding: 14px;
    border: 1px solid #dbe4ff;
    box-shadow: 0 4px 16px rgba(90,120,255,0.18);
}

/* GRID HEADER */
.jqx-widget-header, .jqx-grid-column-header {
    background: linear-gradient(90deg,#eff4ff,#dfe9ff) !important;
    color: #2a3f85 !important;
    font-weight: 600 !important;
    border-color: #dce6ff !important;
    font-size: 0.85rem !important;
}

/* GRID CELLS */
.jqx-grid-cell {
    font-size: 0.85rem !important;
    padding: 6px !important;
    border-color: #eef3ff !important;
}

/* HOVER EFFECT */
.jqx-grid-cell-hover {
    background: rgba(70,120,255,0.08) !important;
}

/* SELECTED ROW */
.jqx-grid-cell-selected {
    background: #6e96ff !important;
    color: #ffffff !important;
}

/* ZERO DATA MESSAGE */
.no-data-message {
    text-align: center;
    padding: 20px;
    font-size: 0.9rem;
    font-weight: 600;
    color: #6b7cb9;
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
    