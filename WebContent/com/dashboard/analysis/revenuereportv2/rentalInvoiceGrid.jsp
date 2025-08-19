<%@ page import="com.dashboard.analysis.revenuereportv2.*" %>
<% 
 String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
/*  String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
  */
  String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentaltype = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 String cmbtariftype = request.getParameter("cmbtariftype")==null?"":request.getParameter("cmbtariftype").trim();
 String clstatuss = request.getParameter("clstatuss")==null?"0":request.getParameter("clstatuss").trim();
 String invstatuss = request.getParameter("invstatuss")==null?"0":request.getParameter("invstatuss").trim();
 String hidtxtcategory = request.getParameter("hidtxtcategory")==null?"0":request.getParameter("hidtxtcategory").trim();
 String check = request.getParameter("check")==null?"0":request.getParameter("check").trim();
 String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate").trim();
  
	ClsRevenueReportDAO dao=new ClsRevenueReportDAO();
  
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
var invoicedata=[];
if(temp4!='NA') 
{  
	   invoicedata='<%=dao.getRevenuev2(branchval,cldocno,rentaltype,agmtNo,clstatuss,cmbtariftype,invstatuss,hidtxtcategory,check,uptodate)%>';
 }

$(document).ready(function () {
	var rendererstring=function (aggregates){
     	var value=aggregates['sum'];
     	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + ' ' + value + '</div>';
	}
     	
    
 
            
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
        	            {name : 'cldocno' , type: 'number' },
                        {name : 'acno' , type: 'number' },
                  		{name : 'clname', type: 'String'  },
                  		{name : 'clcategory',type:'string'},
                  		{name : 'dtype',type:'string'}, 
	                  	{name : 'noofveh', type: 'string'  },
						{name : 'revtotal', type: 'string'  },
						{name : 'rental',type:'string'},
						{name :'acctot',type:'string'},
						{name :'salik',type:'string'},
						{name :'traffic',type:'string'},
						{name :'insur',type:'string'},
						{name : 'vatamt',type:'string'},
						{name : 'other', type: 'string'  }
					
						],
				    localdata: invoicedata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     var cellclassname = function (row, column, value, data) {
        if(parseInt(data.status)==7){
        	return "yellowClass"; 
        }
        else{
        	
        };
          }; 
          
          
          
          $('#rentalInvoiceGrid').on('bindingcomplete', function (event) {
        	  
        	  
        var chk= $('#rentalInvoiceGrid').jqxGrid('getcellvalue', 0,"chk") ;
        
        if(parseInt(chk)==1)
        	{
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
        columnsresize :true,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        showfilterrow:true,
        selectionmode: 'singlerow',
        pagermode: 'default', 
        sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false, cellclassname:cellclassname,pinned:true,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
					    { text: 'Account', datafield: 'acno', width: '6%' , cellclassname:cellclassname,pinned:true},  						
						{ text: 'Client ID', datafield: 'cldocno', width: '6%' , cellclassname:cellclassname,pinned:true},
                        { text: 'Client', datafield: 'clname', width: '23%' , cellclassname:cellclassname,pinned:true},  						
						{ text: 'Category', datafield: 'clcategory', width: '15%' , cellclassname:cellclassname,pinned:true},
						{ text: 'No.of.Vehicle', datafield: 'noofveh', width: '7%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Revenue Total', datafield: 'revtotal', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Rental', datafield: 'rental', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Acc Total', datafield: 'acctot', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Salik', datafield: 'salik', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Traffic', datafield: 'traffic', width: '8%'  ,cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname },
						{ text: 'Insurance', datafield: 'insur', width: '8%' ,cellsformat:'d2',cellsalign:'right',align:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'VAT', datafield: 'vatamt', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						{ text: 'Others', datafield: 'other', width: '8%',cellsformat:'d2',cellsalign:'right',align:'right',aggregates: ['sum'],aggregatesrenderer:rendererstring , cellclassname:cellclassname},
						
						]

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

	
	
</script>
<div id="rentalInvoiceGrid"></div>