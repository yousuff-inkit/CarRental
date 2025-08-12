<%@ page import="com.dashboard.invoices.invoicelistv2.ClsinvoicelistDAO" %>
<% 
String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentaltype = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 String cmbtariftype = request.getParameter("cmbtariftype")==null?"":request.getParameter("cmbtariftype").trim();
  String clstatuss = request.getParameter("clstatuss")==null?"0":request.getParameter("clstatuss").trim();
  String invstatuss = request.getParameter("invstatuss")==null?"0":request.getParameter("invstatuss").trim();
  
	ClsinvoicelistDAO cild=new ClsinvoicelistDAO();
  
  %>
 
  <style type="text/css">

  .yellowClass
        {
        
       
       background-color: #ffc0cb; 
        /*   background-color: #eedd82;  */
        }
</style>


<script type="text/javascript">
 var temp4='<%=branchval%>';
 var invoicedata;
 if(temp4!='NA'){ 
	  invoicedata='<%=cild.invoicelist(branchval,fromDate,toDate,cldocno,rentaltype,agmtNo,clstatuss,cmbtariftype,invstatuss)%>';
 } else {
	 invoicedata = '[{"columns":[{"text":"Doc No","datafield":"doc_no","cellclassname":"cellclassname","width":"7%"},{"text":"Branch","datafield":"branch","cellclassname":"cellclassname","width":"9%"},{"text":"Date","datafield":"date","cellclassname":"cellclassname","width":"6%","cellsformat":"dd.MM.yyyy"},{"text":"RA No","datafield":"rano","cellclassname":"cellclassname","width":"5%"},{"text":"RA Type","datafield":"ratype","cellclassname":"cellclassname","width":"6%"},{"text":"Tarif Type","datafield":"tariftype","cellclassname":"cellclassname","width":"6%"},{"text":"Veh No","datafield":"vehno","cellclassname":"cellclassname","width":"6%"},{"text":"MRA NO","datafield":"mrano","cellclassname":"cellclassname","width":"8%"},{"text":"Fleet No","datafield":"perfleet","cellclassname":"cellclassname","width":"9%"},{"text":"From Date","datafield":"fromdate","cellclassname":"cellclassname","width":"6%"},{"text":"To Date","datafield":"todate","cellclassname":"cellclassname","width":"6%"},{"text":"Account","datafield":"acno","cellclassname":"cellclassname","width":"6%"},{"text":"Account Name","datafield":"acname","cellclassname":"cellclassname","width":"14%"},{"text":"Amount","datafield":"amount","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Del Amount","datafield":"delamount","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Cldocno","datafield":"cldocno","cellclassname":"cellclassname","width":"4%","hidden":"true"},{"text":"Rental Sum","datafield":"rent","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Acc Sum","datafield":"accchg","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Salik Amt","datafield":"salik","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Traffic Amt","datafield":"traffic","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Insurance Charges","datafield":"inschg","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"VAT","datafield":"vat","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Other Charges","datafield":"other","cellclassname":"cellclassname","width":"7%","cellsformat":"d2","cellsalign":"right","align":"right"},{"text":"Show Fleet","datafield":"showfleet","cellclassname":"cellclassname","width":"4%","hidden":"true"},{"text":"Salesman","datafield":"sal_name","cellclassname":"cellclassname","width":"15%"}]},{"rows":[{"doc_no":"","branch":"","date":"","rano":"","ratype":"","tariftype":"","vehno":"","mrano":"","perfleet":"","fromdate":"","todate":"","acno":"","acname":"","amount":"","delamount":"","cldocno":"","rent":"","accchg":"","salik":"","traffic":"","inschg":"","vat":"","other":"","showfleet":"","sal_name":""}]}]';
 }        
 
 $(document).ready(function () { 
	 
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	var rendererstring1=function (aggregates){
     	var value1=aggregates['sum1'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "Total" + '</div>';
     }
     	  var obj = $.parseJSON(invoicedata);
          var columns = obj[0].columns;
          //console.log(columns);
          var rows = obj[1].rows; 
          
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                        {name : 'doc_no' , type: 'string' },
                  		{name : 'rano' , type: 'int' },
						{name : 'ratype', type: 'String'  },
						{name : 'branch', type: 'String'    },
						{name : 'mrano', type: 'String'  },
						
						{name : 'date', type: 'date'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'acno', type: 'String'  },
						{name : 'acname', type: 'string'  },
						{name : 'amount', type: 'number'  },
						{name : 'delamount', type: 'number'  },
						{name : 'cldocno',type:'String'},
						{name : 'rent',type:'number'},
						{name : 'accchg',type:'number'},
						{name : 'salik',type:'number'},
						{name : 'traffic',type:'number'},
						{name : 'other',type:'number'},
						{name : 'tariftype',type:'string'},
						{name : 'sal_name', type: 'string'  },

						{name : 'vat',type:'number'},
						{name : 'inschg',type:'number'},
						{name : 'chk',type:'string'},
						{name : 'status',type:'string'},
						{name : 'showfleet',type:'number'},
						{name : 'perfleet',type:'number'},
						{name : 'vehno' , type: 'string' },   
						],
				    localdata: rows,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    var dynamicdatafields=getDataFields(columns,source);
    /* $.each(dynamicdatafields,function(subindex,subvalue){
    	source.datafields.push(subvalue);
    });
     */
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.status)==7){
        	return "yellowClass"; 
        }
        else{
        	
        };
          }; 
          
          
          
          $('#rentalInvoiceGrid').on('bindingcomplete', function (event) {
	          var chk= $('#rentalInvoiceGrid').jqxGrid('getcellvalue', 0,"chk") ;
	          if(parseInt(chk)==1) {
	        	 $('#rentalInvoiceGrid').jqxGrid('hidecolumn', 'vat');
	          }
          });  
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#rentalInvoiceGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        sortable:true,
        enabletooltips:true,
        columnsresize: true,
        columns: columns  
    });

    $("#overlay, #PleaseWait").hide(); 
    var rows=$("#rentalInvoiceGrid").jqxGrid("getrows");
    var rowcount=rows.length;
    if(rowcount==0){
    	$("#rentalInvoiceGrid").jqxGrid("addrow", null, {});	
    }
	var showfleet=$('#rentalInvoiceGrid').jqxGrid('getcellvalue',0,'showfleet');
   	if(showfleet=="1"){
   		$('#rentalInvoiceGrid').jqxGrid('setcolumnproperty', 'perfleet', 'hidden', false);
   	}
   	else{
   		$('#rentalInvoiceGrid').jqxGrid('setcolumnproperty', 'perfleet', 'hidden', true);
   	}
});

function getDataFields(columns,source){
	$.each(columns,function(index,value){
		if(value.datafield.includes('amount_')){
			source.datafields.push({'name':value.datafield,'type':'number'});
		}
	});
}
	
</script>
<div id="rentalInvoiceGrid"></div>