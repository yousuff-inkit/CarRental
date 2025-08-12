<%@page import="com.dashboard.accounts.accountsstatement.ClsAccountsStatementDAO"%>
<%ClsAccountsStatementDAO DAO= new ClsAccountsStatementDAO(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     String  atype= request.getParameter("atype")==null?"0":request.getParameter("atype").trim();%>  
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
      var data;
      var temp='<%=branchval%>';
	  	if(temp!='NA'){   
	  		   data='<%=DAO.accountsStatement(branchval, fromDate, toDate, accdocno,check,atype)%>';
			   <%-- var dataExcelExport='<%=DAO.accountsStatementExcelExport(branchval, fromDate, toDate, accdocno,check)%>'; --%>
	  	}  
  	console.log("data==>"+data)
        $(document).ready(function () {
        	var amtdesc="",curdesc="";
        	  amtdesc = window.parent.amtdec.value;
        	  curdesc = window.parent.curdec.value;
        	//alert(amtdesc);
        	
        	var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	if(typeof(value) == "undefined"){
               		value=0.00;
               	}
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
               }
        	
        	var rendererstring1=function (aggregates){
                var value1=aggregates['sum1'];
                return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
               }
        	
        	var source =
            {
                datatype: "json",
                datafields: [
							{name : 'trdate' , type: 'date' },
							{name : 'transtype' , type:'string'},
							{name : 'transno' , type:'int'},
							{name : 'branchname' , type:'string'},
							{name : 'description' , type:'string'},
							{name : 'currency',type:'string'},
							{name : 'rate' , type:'number'},
							{name : 'dr' , type:'number'},
							{name : 'cr' , type:'number'},
							{name : 'debit' , type:'number'},
							{name : 'credit' , type:'number'},
							{name : 'balance' , type:'number'},
							{name : 'agmttype',type:'string'},
							{name : 'agmtvocno',type:'string'},
							{name : 'regno',type:'string'},
							{name : 'lpono',type:'string'},
							{name : 'agmtconfig',type:'number'},
							{name : 'balancein' , type:'number'},
							{name : 'refname' , type:'String'}
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
           
        	$("#accountsStatement").on("bindingcomplete", function (event) {
        	
        		var formname=$('#lbldetailname').text();
        		var agmtconfig=$('#accountsStatement').jqxGrid('getcellvalue',0,'agmtconfig');
        		if(agmtconfig==0 || formname!="Accounts Statement AR"){
        			$('#accountsStatement').jqxGrid('hidecolumn','agmttype');
        			$('#accountsStatement').jqxGrid('hidecolumn','agmtvocno');
        			$('#accountsStatement').jqxGrid('hidecolumn','regno');
        			$('#accountsStatement').jqxGrid('hidecolumn','lpono');
        		}
        		var balanceinconfig = $('#hidbalanceinconfig').val();
        		if(balanceinconfig=="1"){     
        			$('#accountsStatement').jqxGrid('showcolumn','balancein');
        			$('#accountsStatement').jqxGrid('showcolumn','currency');
        			$('#accountsStatement').jqxGrid('showcolumn','rate');
        		}else{
        			$('#accountsStatement').jqxGrid('hidecolumn','balancein');   
        			$('#accountsStatement').jqxGrid('hidecolumn','currency');
        			$('#accountsStatement').jqxGrid('hidecolumn','rate');   
        		}
        		
        		var hidacStmtgmtDetailsConfig=$('#hidacStmtgmtDetailsConfig').val();
        		if(hidacStmtgmtDetailsConfig=="2" && formname =="Accounts Statement GL"){
        		 $('#accountsStatement').jqxGrid('showcolumn','refname');
        	
        		}
        		else{
        		 $('#accountsStatement').jqxGrid('hidecolumn','refname');
        		 	 $('#accountsStatement').jqxGrid('hidecolumn','agmttype');
        		$('#accountsStatement').jqxGrid('hidecolumn','agmtvocno');
        		$('#accountsStatement').jqxGrid('hidecolumn','lpono');
        		$('#accountsStatement').jqxGrid('hidecolumn','regno');
        		$('#accountsStatement').jqxGrid('hidecolumn','agmtconfig');
        		}
        		 if(hidacStmtgmtDetailsConfig=="1" && formname !="Accounts Statement GL"){
        		
        		$('#accountsStatement').jqxGrid('showcolumn','agmttype');
        		$('#accountsStatement').jqxGrid('showcolumn','agmtvocno');
        		$('#accountsStatement').jqxGrid('showcolumn','lpono');
        		$('#accountsStatement').jqxGrid('showcolumn','regno');
        		
        		}else{
        		$('#accountsStatement').jqxGrid('hidecolumn','agmttype');
        		$('#accountsStatement').jqxGrid('hidecolumn','agmtvocno');
        		$('#accountsStatement').jqxGrid('hidecolumn','lpono');
        		$('#accountsStatement').jqxGrid('hidecolumn','regno');
        		$('#accountsStatement').jqxGrid('hidecolumn','agmtconfig');
        		}
        	
        	});     
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
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#accountsStatement").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
             	showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                editable: false,
                enabletooltips:true,
                //localization: {thousandsSeparator: ","},
                
                columns: [
							{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '6%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
							{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '4%',columngroup:'cashcontrolaccount' },
							{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '9%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Client',  datafield: 'refname',  cellclassname: cellclassname, width: '9%'  ,columngroup:'cashcontrolaccount' },
							{ text: 'Description', datafield:'description', cellclassname: cellclassname,columngroup:'cashcontrolaccount'},
							{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin'},
							{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '4%',cellsformat:'d'+curdesc,columngroup:'transactedin'},
							{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin'},
							{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd'+amtdesc,cellsalign:'right',align:'right',columngroup:'transactedin', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Balance',  datafield: 'balancein',  cellclassname: cellclassname, width: '8%',cellsformat:'d'+ amtdesc,cellsalign:'right',align:'right',columngroup:'transactedin' },
							{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '8%',cellsformat:'d'+ amtdesc,cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '8%',cellsformat:'d'+ amtdesc,cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring },
							{ text: 'Balance',  datafield: 'balance',  cellclassname: cellclassname, width: '8%',cellsformat:'d'+ amtdesc,cellsalign:'right',align:'right'},
							{ text: 'Type', datafield:'agmttype', cellclassname: cellclassname, width:'5%',columngroup:'agmtgroup'},
							{ text: 'Doc No', datafield:'agmtvocno', cellclassname: cellclassname, width:'8%',columngroup:'agmtgroup'},
							{ text: 'LPO No', datafield:'lpono', cellclassname: cellclassname, width:'8%',columngroup:'agmtgroup'},
							{ text: 'Vehicle', datafield:'regno', cellclassname: cellclassname, width:'10%',columngroup:'agmtgroup'},
							{ text: 'Agmt Config',  datafield: 'agmtconfig',  cellclassname: cellclassname, width: '8%',hidden:true },
						 ], columngroups: 
					                     [
					                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
					                       { text: 'Agreement Informations', align: 'center', name: 'agmtgroup',width: '20%' },
					                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
					                       { text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
					                     ]
            });
            
            if(temp=='NA'){
                $("#accountsStatement").jqxGrid("addrow", null, {});
            }
            
			$("#overlay, #PleaseWait").hide();
			
            var debit1="";var credit1="";var netamount="";
            var debit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            debit1=debit.sum;
            var credit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            credit1=credit.sum;
       
            if(credit1!=null && credit1!="" && typeof(credit1)!="undefined" && typeof(credit1)!="NaN"){
            	credit1 = credit1.replace(/,/g, '');  
            }else{
            	credit1 = 0;
            }
            
            if(debit1!=null && debit1!="" && typeof(debit1)!="undefined" && typeof(debit1)!="NaN"){  
            	 debit1 = debit1.replace(/,/g, '');  
            }else{
            	debit1 = 0;
            }
            
            //alert(debit1+"==="+credit1+"==="+!isNaN(debit1 || credit1))
            
            if(!isNaN(debit1 || credit1)){
            	netamount= parseFloat(debit1) - parseFloat(credit1);  
            	netamount = Number(netamount).toLocaleString('en-US', { minimumFractionDigits: amtdesc, maximumFractionDigits:amtdesc });
            //	console.log("NetAmount :- "+netamount);  
      		    //funRoundAmt(netamount,"txtnetamount");
      		    $("#txtnetamount").val(netamount)      
      		  }
      		else{
		    	 $('#txtnetamount').val(0.00);
		    }
        });

</script>
<div id="accountsStatement"></div>
