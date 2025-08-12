<%@page import="customerlogin.*"%>
<%ClsCustomerLoginDAO DAO= new ClsCustomerLoginDAO(); %>
<% String contextPath=request.getContextPath();%>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
     String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
     String hidaccmonth = request.getParameter("hidaccmonth")==null?"0":request.getParameter("hidaccmonth").trim();
     String hidaccyr = request.getParameter("hidaccyr")==null?"0":request.getParameter("hidaccyr").trim();
     String chkaccmonthyear = request.getParameter("chkaccmonthyear")==null?"0":request.getParameter("chkaccmonthyear").trim();
     String chkbtwdtacc = request.getParameter("chkbtwdtacc")==null?"0":request.getParameter("chkbtwdtacc").trim();
   
     %> 
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
	  		   data='<%=DAO.accountsStatementv2(branchval, fromDate, toDate, accdocno,check,hidaccmonth,hidaccyr,chkaccmonthyear,chkbtwdtacc)%>';			   
	  	}
	  var achtml='';
	  var drsum=0.0;
	  var crsum=0.0;
	  var netamount=0.0;
	  var testdr=0.0;
	  var testcr=0.0;
	  $.each(JSON.parse(data),function(index,value){
		achtml+='<tr  data-transtype='+value.transtype+' data-transno='+value.transno+'  data-brhid='+value.brhid+'>';
		achtml+='<td >'+value.trdate+'</td>';
		achtml+='<td >'+value.transtype+'</td>';
		achtml+='<td >'+value.transno+'</td>';
		achtml+='<td >'+value.branchname+'</td>';
		achtml+='<td >'+value.brhid+'</td>';
		achtml+='<td>'+value.description+'</td>';
		achtml+='<td align="right">'+value.dr+'</td>';
		achtml+='<td align="right">'+value.cr+'</td>';
		achtml+='</tr>';
		
		testdr=value.dr;
		testdr=parseFloat(testdr.replace(/,/g,''));
		
		
		testcr=value.cr;
		testcr=parseFloat(testcr.replace(/,/g,''));
		
	
		 if(value.dr=="" || value.dr==null){
			 drsum+=0.0; 
			
			 
		 }else{
			 drsum+=parseFloat(testdr);
			
			
		 }
		 if(value.cr=="" || value.cr==null){
			 crsum+=0.0; 
			 
		 }else{
			 crsum+=parseFloat(testcr);
		 }
		
		
			 netamount=((parseFloat(drsum))-(parseFloat(crsum)));
		 
		   
	  });
		 drsum= (Math.round(drsum * 100) / 100).toFixed(2);
		 drsum= drsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		 crsum= (Math.round(crsum * 100) / 100).toFixed(2);
		 crsum= crsum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		 netamount= (Math.round(netamount * 100) / 100).toFixed(2);
		 netamount= netamount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		 
	    achtml+='<tr>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td><strong>Total</strong></td>';
		achtml+='<td align="right"><strong>'+drsum+'</strong></td>';
		achtml+='<td align="right"><strong>'+crsum+'</strong></td>';
		achtml+='</tr>';
		
		
		achtml+='<tr data-netamount='+netamount+'>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td></td>';
		achtml+='<td align="right"><strong>Net Amount</strong></td>';
		achtml+='<td align="right"><strong>'+netamount+'</strong></td>';
		achtml+='</tr>';
		
		
  	$('.tbl-acstmt tbody').html($.parseHTML(achtml));
  	document.querySelectorAll('.tbl-acstmt tbody td')   
	.forEach(e =>  e.addEventListener("click", clickExEnqHandler));         
  	$(document).ready(function () {
    	var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
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
						{name : 'brhid',type:'number'},
						
                      ],
                      localdata: data,
           
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
        
      var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            });
        
     /*   $("#accountsStatement").jqxGrid(
        {
            width: '98%',
            height: 400,
            source: dataAdapter,
            filtermode:'excel',
            filterable: true,
            sortable: true,
            columnsresize: true,
            selectionmode: 'singlecell',
         	showaggregates: true,
         	showstatusbar:true,
         	rowsheight:25,
         	statusbarheight:25,
            editable: false,
            //localization: {thousandsSeparator: ""},
            
            columns: [
						{ text: 'Date', datafield: 'trdate', cellclassname: cellclassname, width: '6%', cellsformat: 'dd.MM.yyyy' ,columngroup:'cashcontrolaccount'},
						{ text: 'Type',  datafield: 'transtype',  cellclassname: cellclassname, width: '4%',columngroup:'cashcontrolaccount' },
						{ text: 'Doc No',  datafield: 'transno',  cellclassname: cellclassname, width: '6%'  ,columngroup:'cashcontrolaccount' },
						{ text: 'Doc No',  datafield: 'docno',  cellclassname: cellclassname,hidden:true, width: '6%'  ,columngroup:'cashcontrolaccount' },
						{ text: 'Branch',  datafield: 'branchname',  cellclassname: cellclassname, width: '9%'  ,columngroup:'cashcontrolaccount' },
						{ text: 'Description', datafield:'description', cellclassname: cellclassname,columngroup:'cashcontrolaccount'},
						{ text: 'Currency',  datafield: 'currency',  cellclassname: cellclassname, width: '5%'  ,columngroup:'transactedin',hidden:true},
						{ text: 'Rate',  datafield: 'rate',  cellclassname: cellclassname, width: '4%',cellsformat: 'd2',columngroup:'transactedin',hidden:true},
						{ text: 'Dr',  datafield: 'dr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin',aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Cr',  datafield: 'cr',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'transactedin', aggregates: ['sum'],aggregatesrenderer:rendererstring},
						{ text: 'Debit',  datafield: 'debit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring ,hidden:true},
						{ text: 'Credit',  datafield: 'credit',  cellclassname: cellclassname, width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'valueinbasecurrency',aggregates: ['sum'],aggregatesrenderer:rendererstring ,hidden:true},
						{ text: 'Balance',  datafield: 'balance',  cellclassname: cellclassname,hidden:true,width: '8%',cellsformat: 'd2',cellsalign:'right',align:'right' },
					 	{ text: 'Attach',datafield:'btnattach',cellclassname: cellclassname, width: '8%',align:'center',columntype:'button', hidden:true,cellsrenderer: function () {
                 				return "Attach";
              				}
              			},
					 ], columngroups: 
				                     [
				                       { text: 'Account Informations', align: 'center', name: 'cashcontrolaccount',width: '20%' },
				                       { text: 'Transacted In', align: 'center', name: 'transactedin',width: '10%' },
				                       { text: 'Value In Base Currency', align: 'center', name: 'valueinbasecurrency',width: '10%' }
				                     ]
        });
     */
        
        if(temp=='NA'){
            //$("#accountsStatement").jqxGrid("addrow", null, {});
        }
       <%--  $("#accountsStatement").on("cellclick", function (event) 
		{
		    // event arguments.
		    var args = event.args;
		    // row's bound index.
		    var rowBoundIndex = event.args.rowindex;
		    // row's visible index.
		    var rowVisibleIndex = event.args.visibleindex;
		    // right click.
		    var rightclick = event.args.rightclick; 
		    // original event.
		    var ev = event.args.originalEvent;
		    // column index.
		    var columnindex = event.args.columnindex;
		    // column data field.
		    var dataField = event.args.datafield;
		    // cell value
		    var value = event.args.value;
		    $('#stmtrowindex').val(rowBoundIndex);
		    if(dataField=="btnattach"){
		    	var brhid=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'brhid');  
					var docno=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'docno');
	    			if(docno!="" && docno!="0"){             
						var frmdet=$('#accountsStatement').jqxGrid('getcellvalue',rowBoundIndex,'transtype');
						var fname="";
						var x = new XMLHttpRequest();
  						x.onreadystatechange = function() {
  							if (x.readyState == 4 && x.status == 200) {
  								var items = x.responseText.trim();
  								fname=items;
  								//alert(brhid+"::"+docno+"::"+frmdet+"::"+fname);
		   							var myWindow= window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				  					myWindow.focus();
	  							}
	  						}
	  						x.open("GET", "getFormname.jsp?formtype="+frmdet, true);
	  						x.send();
	  					var frmdet="CRM";
	  					var fname="Client"; 
	  					var myWindow= window.open("<%=contextPath%>/com/dashboard/management/Attachmaster.jsp?formCode="+frmdet+"&docno="+docno+"&brchid="+brhid+"&frmname="+fname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
				  		myWindow.focus(); 
   						
   					}
   					else{  
   						Swal.fire({
  							type: 'error',
  							title: 'Empty Document',
  							text: 'Please select a document'
						});
						return false;
		    		}               
	   			}
			});      
			$(".page-loader").hide();
			var check='<%=check%>';
			if(check=="1"){
				var debit1="";var credit1="";var netamount="";
            	var debit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'debit', ['sum'], true);
            	debit1=debit.sum;
            	var credit=$('#accountsStatement').jqxGrid('getcolumnaggregateddata', 'credit', ['sum'], true);
            	credit1=credit.sum;
            	if(!isNaN(debit1 || credit1)){
            		netamount= parseFloat(debit1) - parseFloat(credit1);
      		    	funRoundAmt(netamount,"txtnetamount");
      		  	}
      			else{
		    		$('#txtnetamount').val(0.00);
		    	}
			}
            /**/
            $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    		// create context menu
       		var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 50, autoOpenPopup: false, mode: 'popup'});
       		$("#accountsStatement").on('contextmenu', function () {
           		return false;
       		});
       		
       		$("#Menu").on('itemclick', function (event) {
    	   		var args = event.args;
           		var rowindex = $("#accountsStatement").jqxGrid('getselectedrowindex');
           		
           		if ($.trim($(args).text()) == "Print") {
           			var dtype=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transtype");
               		var docno=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transno");
               		var brhid=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"brhid");
               		if(dtype=="TINV"){
               			var win= window.open("<%=contextPath%>/com/operations/commtransactions/travelinvoice/printtravelinvoice?docno="+docno+"&branch="+brhid,"_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        			win.focus();
	        			win.print();
               		}
               		else if(dtype=="CRV"){
               			var win= window.open("<%=contextPath%>/com/finance/transactions/cashreceipt/printCashReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        			win.focus();
	        			win.print();	
               		}
               		else if(dtype=="BRV"){
               			var win= window.open("<%=contextPath%>/com/finance/transactions/bankreceipt/printBankReceipt?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        			win.focus();
	        			win.print();	
               		}
               		else if(dtype=="CNO"){
               			var win= window.open("<%=contextPath%>/com/finance/transactions/creditnote/printCreditNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        			win.focus();
	        			win.print();	
               		}
               		else if(dtype=="DNO"){
               			var win= window.open("<%=contextPath%>/com/finance/transactions/debitnote/printDebitNote?docno="+docno+"&branch="+brhid+"&header=1","_blank","top=150,left=250,Width=1020,Height=500,location=no,scrollbars=no,toolbar=yes");
	        			win.focus();
	        			win.print();	
               		}
           		}
           		else if($.trim($(args).text()) == "View Attachments") {
           			var frmname=funGetFormname(dtype);
           			var dtype=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transtype");
               		var docno=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"transno");
               		var brhid=$("#accountsStatement").jqxGrid("getcellvalue",rowindex,"brhid");
           			var myWindow=window.open("<%=contextPath%>/com/common/AttachMasterClient.jsp?formCode="+dtype+"&docno="+docno+"&brchid="+brhid+"&frmname="+frmname,"_blank","top=180,left=310,Width=800,Height=430,location=no,scrollbars=no,toolbar=no,resizable=no,meanubar=no,titlebar=no");
					myWindow.focus();
           		}
       		});
       		$("#accountsStatement").on('rowclick', function (event) {
           		if (event.args.rightclick) {
		       		/*$("#accountsStatement").jqxGrid('selectrow', event.args.rowindex);
               		var scrollTop = $(window).scrollTop();
               		var scrollLeft = $(window).scrollLeft();
               		contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               		*/
               		return false;
		   		}
       		}); --%>
        });
	function funGetFormname(formtype){
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				return items;
	  			}
	  		}
	  		x.open("GET", "getFormname.jsp?formtype="+formtype, true);
	  		x.send();
		}
</script>
<!-- <div id='jqxWidget'>
    <div id="accountsStatement"></div>
    <div id="popupWindow">
		<div id='Menu'>
        	<ul>
            	<li>Print</li>
            	<li>View Attachments</li>
        	</ul>
       	</div>
   	</div>
</div> -->
<input type="hidden" id="stmtrowindex" name="stmtrowindex"/>

