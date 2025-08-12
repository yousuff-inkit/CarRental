<%@page import="com.dashboard.humanresource.leavepayrollposting.ClsLeavePayrollPostingDAO"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% ClsLeavePayrollPostingDAO DAO= new ClsLeavePayrollPostingDAO(); %>
<% String contextPath=request.getContextPath();%>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String employees = request.getParameter("employees")==null?"0":request.getParameter("employees").trim();
     String postDate = request.getParameter("postdate")==null?"0":request.getParameter("postdate").trim();
     String checked = request.getParameter("checked")==null?"0":request.getParameter("checked").trim();%>

<style type="text/css">
        .redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .greyClass
        {
           background-color: #D8D8D8;
        }
</style>
<script type="text/javascript">
		var data2;  
		var temp='<%=branchval%>';
		if(temp1!='NA'){ 
			data2= '<%=DAO.leavePayrollPostingJVGridLoading(branchval,upToDate,category,employees,postDate,checked)%>';
		}
        $(document).ready(function () { 
            
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'docno', type: 'int' },
     						{name : 'type', type: 'string' }, 
     						{name : 'account', type: 'string'   },
     						{name : 'accountname', type: 'string'  },
     						{name : 'debit', type: 'number'   },
     						{name : 'credit', type: 'number'   },
     						{name : 'baseamount', type: 'number' },
     						{name : 'description', type: 'string' },
     						{name : 'currencyid', type: 'int'   },
     						{name : 'currencytype', type: 'string'   },
     						{name : 'rate', type: 'string'   },
     						{name : 'id', type: 'int'  },
     						{name : 'costtype', type: 'string'   },
     						{name : 'costcode', type: 'string'   }
                        ],
                         localdata: data2,  
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var cellclassname = function (row, column, value, data) {
        		if (data.debit != '') {
                    return "redClass";
                } else if (data.credit != '') {
                    return "yellowClass";
                }
                else{
                	return "greyClass";
                };
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leavepayrollpostingjvgridid").jqxGrid(
            {
                width: '98%',
                height: 244,
                source: dataAdapter,
                selectionmode: 'singlecell',
                filtermode:'excel',
                filterable: true,
                sortable: true,
                editable: false,
                showaggregates: true,
                localization: {thousandsSeparator: ","},
                
                columns: [
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center', 
                              cellclassname: cellclassname, cellsrenderer: function (row, column, value) {
                            	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
							},
							{ text: 'Doc No',  hidden: true, datafield: 'docno',  width: '5%' },
                            { text: 'Type', datafield: 'type', cellclassname: cellclassname, editable: false, width: '7%' },
							{ text: 'Account', datafield: 'account', cellclassname: cellclassname, editable: false, width: '7%' },	
							{ text: 'Account Name', datafield: 'accountname', cellclassname: cellclassname, editable: false, width: '25%' },	
							{ text: 'Debit', datafield: 'debit', cellclassname: cellclassname, width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#leavepayrollpostingjvgridid').jqxGrid('getcellvalue', row, "credit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Credit', datafield: 'credit', cellclassname: cellclassname, width: '8%', cellsformat: 'd2', cellsalign: 'right', align: 'right', aggregates: ['sum'],
								cellbeginedit: function (row) {
							        if ($('#leavepayrollpostingjvgridid').jqxGrid('getcellvalue', row, "debit")>0)
							         {
							              return false;
							         }}
							},
							{ text: 'Base Amount', datafield: 'baseamount', cellclassname: cellclassname, editable: false, cellsformat: 'd2', width: '8%', cellsalign: 'right', align: 'right' },
							{ text: 'Description', datafield: 'description', cellclassname: cellclassname, editable: false, width: '32%' },
							{ text: 'Currency Id', hidden: true, datafield: 'currencyid', editable: false, width: '10%' },
							{ text: 'Curr Type', hidden: true, datafield: 'currencytype', editable: false, width: '4%' },
							{ text: 'Rate',  hidden: true, datafield: 'rate', editable: false, width: '10%' },
							{ text: 'Id',  hidden: true, datafield: 'id', editable: false, width: '10%' },
							{ text: 'Costtype',  hidden: true, datafield: 'costtype', editable: false, width: '10%' },
							{ text: 'Costcode',  hidden: true, datafield: 'costcode', editable: false, width: '10%' },
							
						]
            });
            
            $("#overlay, #PleaseWait").hide();
            
         	  var debit1="",debit2="",credit1="",credit2="";
         	  $("#leavepayrollpostingjvgridid").on('cellvaluechanged', function (event){
           		 var datafield = event.args.datafield;

           		  var rows = $('#leavepayrollpostingjvgridid').jqxGrid('getrows');
          	      var rowlength= rows.length;
          	    
          	    if(datafield=="debit" || datafield=="credit"){

         			 for(i=0;i<=rowlength-1;i++) {
         				 
              		  var debits = $('#leavepayrollpostingjvgridid').jqxGrid('getcellvalue', i, "debit");
                      var rate= $("#leavepayrollpostingjvgridid").jqxGrid('getcellvalue', i, "rate");
                      var type= $("#leavepayrollpostingjvgridid").jqxGrid('getcellvalue', i, "currencytype");
                      
                      if(debits>0){
                    	  
                      var baseamount = "";
          			 
          			    	if(type=="M"){
          			    		baseamount = parseFloat(debits) * parseFloat(rate);
          				    }else{
          				    	baseamount = parseFloat(debits) / parseFloat(rate);
          				    }
    	                 
    	                	 $('#leavepayrollpostingjvgridid').jqxGrid('setcellvalue', i, "baseamount" ,baseamount);
              		    }
         			 }
         			 
		         	  var debit=$('#leavepayrollpostingjvgridid').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
		         	  debit2=debit.sum;
		         	  debit1=debit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1"); 
		         	 if(!(isNaN(debit1))){
		        		  funRoundAmt(debit1,"txtdrtotal");
		        	  }else if(isNaN(credit1)){
		        		  funRoundAmt(0.00,"txtdrtotal");
		        	  }
         		 
         		for(j=0;j<=rowlength-1;j++) {
    				 
            		var credits = $('#leavepayrollpostingjvgridid').jqxGrid('getcellvalue', j, "credit");
                    var rate= $("#leavepayrollpostingjvgridid").jqxGrid('getcellvalue', j, "rate");
                    var type= $("#leavepayrollpostingjvgridid").jqxGrid('getcellvalue', j, "currencytype");
                    
                    if(credits>0){
                    	
                    var baseamount = "";
        			    	if(type=="M"){
        			    		baseamount = parseFloat(credits) * parseFloat(rate);
        				    }else{
        				    	baseamount = parseFloat(credits) / parseFloat(rate);
        				    }
               	   
  	                	 $('#leavepayrollpostingjvgridid').jqxGrid('setcellvalue', j, "baseamount" ,baseamount);
            		 }
         		  }
         		
         	      var credit=$('#leavepayrollpostingjvgridid').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
         	      credit2=credit.sum;
         	      credit1=credit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	  if(!(isNaN(credit1))){
	              	funRoundAmt(credit1,"txtcrtotal");
	         	  }else if(isNaN(credit1)){
	             	 funRoundAmt(0.00,"txtcrtotal");
	         	  }
	             }
          	    
           	  }); 
         	  
         	 if(temp!='NA') { 
                  var debit1="",debit2="",credit1="",credit2="";
    	 	  
	         	  var debit=$('#leavepayrollpostingjvgridid').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
	         	  debit2=debit.sum;
	         	  debit1=debit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
	         	  if(!(isNaN(debit1))){
	        		  funRoundAmt(debit1,"txtdrtotal");
	        	  }else if(isNaN(credit1)){
	        		  funRoundAmt(0.00,"txtdrtotal");
	        	  }
    		
    	          var credit=$('#leavepayrollpostingjvgridid').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
    	          credit2=credit.sum;
    	          credit1=credit2.replace(/(\d+),(?=\d{3}(\D|$))/g, "$1");
         	      if(!(isNaN(credit1))){
              	      funRoundAmt(credit1,"txtcrtotal");
         	      }else if(isNaN(credit1)){
             	      funRoundAmt(0.00,"txtcrtotal");
         	      }
        	  
    	    }
        	
        });

</script>

<div id="leavepayrollpostingjvgridid"></div>
