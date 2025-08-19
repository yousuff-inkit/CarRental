<%@page import="com.dashboard.audit.applieddetails.ClsAppliedDetailsDAO"%>
<%
	ClsAppliedDetailsDAO DAO= new ClsAppliedDetailsDAO();
%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%   String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();
	 String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();
	 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String atype = request.getParameter("atype")==null?"0":request.getParameter("atype").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     String accountno = request.getParameter("accountno")==null?"0":request.getParameter("accountno").trim();%> 

<style type="text/css">
  .appliedClass
  {
     color: #0101DF;
  }
  .balanceClass
  {
	color: #FF0000;      
  }
  
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
       
	  		     data='<%=DAO.appliedGridLoading(fromdate,todate,branchval, atype, accountno,check)%>'; 
	   
  	
        $(document).ready(function () {
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'transno', type: 'int' },
     						{name : 'transtype', type: 'string'   },
     						{name : 'date', type: 'date' },
     						{name : 'description', type: 'string'   },
     						{name : 'tramt', type: 'number' },
     		     		    {name : 'applied', type: 'number'   },
     						{name : 'balance', type: 'number'   },
     						{name : 'out_amount', type: 'number'   },
     						{name : 'tranid', type: 'int'   },
     						{name : 'acno', type: 'int'   },
     						{name : 'currency', type: 'string'   },
     						{name : 'tr_no', type: 'int'   },
     						{name : 'brhid', type: 'int'   },
     						{name : 'applyinfo', type: 'string'  },
     						{name : 'ttransno', type: 'int' },
	     					{name : 'ttranstype', type: 'string'   },
	     					{name : 'tdate', type: 'date' },
	     					{name : 'tdescription', type: 'string'   },
	     					{name : 'ttramt', type: 'number' },
	     		     		{name : 'tapplying', type: 'number'   },
	     				    {name : 'tbalance', type: 'number'   }
	                      ],
                          localdata: data,
               
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
            $("#appliedDelete").jqxGrid(
            {
                width: '98%',
                height: 505,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                selectionmode: 'singlerow',
                editable: false,
                columnsresize: true,
                groupable: true,
                groups: ['transno','transtype'],
                localization: {thousandsSeparator: ""},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							 }    
							},
							{ text: 'Doc No.', datafield: 'transno',  width: '7%' },			
							{ text: 'Doc Type', datafield: 'transtype',  width: '7%' },	
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' ,  width: '7%' },	
							{ text: 'Remarks', datafield: 'description',  width: '20%' },  	
							{ text: 'Amount', datafield: 'tramt', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right' },
							{ text: 'Applied', datafield: 'applied', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
							{ text: 'Balance', datafield: 'balance', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'balanceClass' },
							{ text: 'Out Amount',hidden: true, datafield: 'out_amount',  cellsformat: 'd2', width: '5%' },
							{ text: 'Tran Id' ,hidden: true, datafield: 'tranid',  width: '5%' },
							{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currency',  width: '5%' },
							{ text: 'Tran No' , hidden: true, datafield: 'tr_no',  width: '5%' },
							{ text: 'Branch' , hidden: true, datafield: 'brhid',  width: '5%' },
							{ text: 'Apply Info', datafield: 'applyinfo', hidden: true, width: '10%' },
							{ text: 'Det. Doc No.', datafield: 'ttransno', editable: false, width: '7%' },			
							{ text: 'Det. Doc Type', datafield: 'ttranstype', editable: false, width: '7%' },	
							{ text: 'Det. Date', datafield: 'tdate', cellsformat: 'dd.MM.yyyy' , editable: false, width: '7%' },	
							{ text: 'Det. Remarks', datafield: 'tdescription', editable: false, width: '44%' },	
							{ text: 'Det. Amount', datafield: 'ttramt', width: '10%', cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right' },
							{ text: 'Det. Applied', datafield: 'tapplying', width: '10%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'appliedClass' },
							{ text: 'Det. Balance', datafield: 'tbalance', width: '10%',cellsformat: 'd2', editable: false, cellsalign: 'right', align: 'right', aggregates: ['sum'], cellclassname: 'balanceClass' },
					
						 ],
						 groupsrenderer: function (defaultText, group, state, params) {   
								return false;
						 } 
            });
            
            $("#overlay, #PleaseWait").hide();
            
            $('#appliedDelete').on('rowdoubleclick', function (event) { 
          	     var rowindex1=event.args.rowindex;
                 document.getElementById("txttrno").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "tr_no");
                 document.getElementById("txtdtype").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "transtype");
                 document.getElementById("txtoutamount").value= $('#appliedDelete').jqxGrid('getcelltext',rowindex1, "out_amount");
                 document.getElementById("txtbranchid").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "brhid");
                 document.getElementById("txttranid").value= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "tranid");
                 var values= $('#appliedDelete').jqxGrid('getcellvalue',rowindex1, "applyinfo");
                 var sum2 = values.toString().replace(/\*/g, '\n');
                 document.getElementById("applyinfo").value=sum2;
                 
                var indexVal =  $('#appliedDelete').jqxGrid('getcellvalue', rowindex1, "tranid");
                var accountno = document.getElementById("txtdocno").value;
             }); 

        });

</script>
<div id="appliedDelete"></div>
