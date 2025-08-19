<%@page import="com.dashboard.accounts.individualageing.ClsIndividualAgeing"%>
<%ClsIndividualAgeing DAO=new ClsIndividualAgeing(); %>
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
     String upToDate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
     String atype = request.getParameter("atype"); 
     String accdocno = request.getParameter("accdocno")==null?"0":request.getParameter("accdocno").trim();
     String salesperson = request.getParameter("salesperson")==null?"0":request.getParameter("salesperson").trim();
     String category = request.getParameter("category")==null?"0":request.getParameter("category").trim();
     String check = request.getParameter("check")==null?"0":request.getParameter("check");
     String chkolddate = request.getParameter("chkolddate")==null?"0":request.getParameter("chkolddate");
%> 
     
<style type="text/css">
  .advanceClass
  {
      background-color: #FBEFF5;
  }
  .balanceClass
  {
      background-color: #E0F8F1;
  }
  .unappliedClass
  {
     color: #FF0000;
  }
</style>
<script type="text/javascript">
      var data;
      var temp='<%=branchval%>';
      var chkolddate='<%=chkolddate%>';
	  	if(temp!='NA'){
	  		if(chkolddate=="1"){	  			
	  			data='<%=DAO.individualAgeingOldDate(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
	  		}
	  		else{
	  			data='<%=DAO.individualAgeing(branchval, upToDate, atype, accdocno, salesperson, category, check)%>';
	  		}
	  	}
  		
	  	var furtherhidden=true;
	  	if(chkolddate=="1"){
	  		furtherhidden=false;
	  	}
        $(document).ready(function () {
        	
        	/*$("#btnExcel").click(function() {
    			$("#individualAgeing").jqxGrid('exportdata', 'xls', 'IndividualAgeing');
    		});*/
        	
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
							{name : 'date', type: 'date' },
							{name : 'transno', type: 'number' },
							{name : 'transtype', type: 'string'   },
							{name : 'name' , type: 'String' },
							{name : 'contact' , type:'String'},
							{name : 'pmob' , type:'String'},
							{name : 'description', type: 'string' },
							{name : 'salname', type: 'string' },
							{name : 'advance' , type:'number'},
							{name : 'balance' , type:'number'},
							{name : 'unapplied',type:'number'},
							{name : 'runbal',type:'number'},
							{name : 'age' , type:'number'},
							{name : 'acno' , type:'int'},
							{name : 'brhid' , type:'int'},
							{name : 'agmttype',type:'string'},
							{name : 'agmtvocno',type:'string'},
							{name : 'regno',type:'string'},
							{name : 'lpono',type:'string'},
							{name : 'agmtconfig',type:'number'},
							{name : 'code',type:'string'},
							{name : 'famount',type:'number'},
							{name : 'fcount',type:'number'},
							{name : 'fdate',type:'string'},
							{name : 'fbalance',type:'number'},
							
							
	                      ],
                          localdata: data,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	

        	$("#individualAgeing").on("bindingcomplete", function (event) {
        		var agmtconfig=$('#individualAgeing').jqxGrid('getcellvalue',0,'agmtconfig');
        		if(agmtconfig==0 || $('#cmbtype').val()!="AR"){
        			$('#individualAgeing').jqxGrid('hidecolumn','agmttype');
        			$('#individualAgeing').jqxGrid('hidecolumn','agmtvocno');
        			$('#individualAgeing').jqxGrid('hidecolumn','regno');
        			$('#individualAgeing').jqxGrid('hidecolumn','lpono');
        		}
        		var Acurrconfig = $('#hidAcurrconfig').val();
        		//alert("hi"+Acurrconfig);
        		if(Acurrconfig==1){     
        			$('#individualAgeing').jqxGrid('showcolumn','code');
        			/* $('#individualAgeingSummary').jqxGrid('showcolumn','code'); */
        			}else{
        				//alert("TEST");
        			$('#individualAgeing').jqxGrid('hidecolumn','code');
        			/* $('#individualAgeingSummary').jqxGrid('hidecolumn','code'); */
        			}
        		
        			
        	});   
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#individualAgeing").jqxGrid(
            {
                width: '98%',
                height: 490,
                source: dataAdapter,
                rowsheight:25,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
                editable: false,
                showaggregates: true,
                showstatusbar:true,
             	statusbarheight:25,
             	enabletooltips:true,
                
                columns: [
						   { text: 'Sr. No', sortable: false, filterable: false, editable: false,
						       groupable: false, draggable: false, resizable: false,datafield: '',
						       columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
						       cellsrenderer: function (row, column, value) {
						        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						     }    
							},
							{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy' , editable: false, width: '6%' },
							{ text: 'Type', datafield: 'transtype', editable: false, width: '3%' },	
							{ text: 'Doc No.', datafield: 'transno', editable: false, width: '5%' },
							{ text: 'Account Name', datafield: 'name', width: '15%' },
							{ text: 'Acurr', datafield:'code', width:'6%'},
							{ text: 'Contact Person',  datafield: 'contact',  width: '10%' },
							{ text: 'Sales Person',  datafield: 'salname',  width: '8%' },
							{ text: 'Mobile No',  datafield: 'pmob',  width: '7%' },
							{ text: 'Description',  datafield: 'description',  width: '17%', aggregates: ['sum1'],aggregatesrenderer:rendererstring1 },
							{ text: 'Advance', datafield:'advance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'advanceClass' },
							{ text: 'Balance', datafield:'balance', width:'7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'balanceClass' },
							{ text: 'Unapplied',  datafield: 'unapplied',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Age',  datafield: 'age',  width: '4%', cellsalign: 'center', align: 'center' },
							{ text: 'Running Bal',  datafield: 'runbal',  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring, cellclassname: 'unappliedClass' },
							{ text: 'Fur.Amount',  datafield: 'famount',hidden:furtherhidden,  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: 'Fur.Count',  datafield: 'fcount', hidden: furtherhidden, width: '6%'  },
							{ text: 'Fur.Date',  datafield: 'fdate', hidden: furtherhidden, width: '8%'  },
							{ text: 'Fur.Balance',  datafield: 'fbalance',hidden: furtherhidden,  width: '7%', cellsformat: 'd2',cellsalign:'right',align:'right', aggregates: ['sum'], aggregatesrenderer:rendererstring},
							{ text: 'Account No',  datafield: 'acno', hidden: true, width: '8%'  },
							{ text: 'Branch Id',  datafield: 'brhid', hidden: true, width: '8%'  },
							{ text: 'Type', datafield:'agmttype', width:'5%'},
							{ text: 'Doc No', datafield:'agmtvocno', width:'8%'},
							{ text: 'LPO No', datafield:'lpono', width:'8%'},
							{ text: 'Vehicle', datafield:'regno', width:'10%'},
							{ text: 'Agmt Config',  datafield: 'agmtconfig', width: '8%',hidden:true }
							
						 ]
            });
            
            if(temp=='NA'){
                $("#individualAgeing").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#individualAgeing').on('rowdoubleclick', function (event) { 
            	  var rowindex1=event.args.rowindex;
            	  document.getElementById("txtacountno").value=$('#individualAgeing').jqxGrid('getcellvalue', rowindex1, "acno");
            	  document.getElementById("txtbranch").value=$('#individualAgeing').jqxGrid('getcellvalue', rowindex1, "brhid");
               }); 

        });

</script>
<div id="individualAgeing"></div>
