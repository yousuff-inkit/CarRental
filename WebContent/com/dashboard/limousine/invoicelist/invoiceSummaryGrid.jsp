<%@page import="com.dashboard.limousine.invoicelist.ClsInvoiceListDAO" %>
<% ClsInvoiceListDAO dao=new ClsInvoiceListDAO();    
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String check=request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
var sumdata,dataexcel;                   
$(document).ready(function () { 
	sumdata='<%=dao.gridData(fromdate,todate,client,check)%>';    
        var source =
           {
           datatype: "json",
           datafields: [
        	                {name : 'total',type:'number'},
			        	    {name : 'doc_no',type:'string'},
			        	    {name : 'voc_no',type:'string'},
			        		{name : 'refname', type:'string'},
			        		{name : 'date',type:'date'},
			        		{name : 'ledgernote',type:'string'},
			        		{name : 'invoicenote',type:'string'},
			        		{name : 'veseelno',type:'string'},
			        		{name : 'vesselname',type:'string'},
			        		{name : 'bookno',type:'string'},
			        		{name : 'refno',type:'string'},
			        		{name : 'vatpercent',type:'number'},
			        		{name : 'vatvalue',type:'number'},
			        		{name : 'nettotal',type:'number'},
     				   ],
					localdata:sumdata,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });
          
       
        	  $("#jqxinvoiceGrid").on("bindingcomplete", function (event) {
        		    var config = $('#hidetariff').val();
        		    if (config == 1) {
        		    	$("#jqxinvoiceGrid").jqxGrid('hidecolumn', 'vesselno');
        		    	$("#jqxinvoiceGrid").jqxGrid('hidecolumn', 'vesselname');
        		    } else {
        		    	$("#jqxinvoiceGrid").jqxGrid('showcolumn', 'vesselno');
        		    	$("#jqxinvoiceGrid").jqxGrid('showcolumn', 'vesselname');
        		    }
        		});

            $("#jqxinvoiceGrid").jqxGrid(
            {
               width: '100%',
               height: 500,
               source: dataAdapter,
               columnsresize: true,
               editable:false,  
               enabletooltips:true, 
               sortable:true,
               showfilterrow:true,
               filterable:true,       
               selectionmode: 'singlerow',                         
               columns: [
		            	   { text: 'Sr. No.',datafield: '',columntype:'number', width: '4%', cellsrenderer: function (row, column, value) {
		                       return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		                }   },
		                  { text: 'Doc No', datafield: 'doc_no',width:'0%', hidden:true}, 
            	          { text: 'Doc No', datafield: 'voc_no',width:'6%'}, 
            	          { text: 'Date', datafield: 'date',width:'8%',cellsformat:'dd.MM.yyyy'},
            	          { text: 'Client', datafield: 'refname',width:'19%'},
            	          { text: 'Booking No', datafield: 'bookno',width:'6%'},
            	          { text: 'Ref No', datafield: 'refno',width:'6%'},
            	          { text: 'V. no', datafield: 'vesselno',width:'9%'},
            	          { text: 'V. Name', datafield: 'vesselname',width:'12%'},
            	          { text: 'Ledger Note', datafield: 'ledgernote',width:'17%'},
            	          { text: 'Invoice Note', datafield: 'invoicenote',width:'19%'},
            	          { text: 'Total Amount', datafield: 'total',width:'10%',cellsalign:'right',align:'right',cellsformat:'d2',editable:false},
            	          { text: 'Tax', datafield: 'vatpercent',width:'5%',cellsalign:'right',align:'right',cellsformat:'d2',hidden:true},
            	          { text: 'Tax', datafield: 'vatvalue',width:'9%',cellsalign:'right',align:'right',cellsformat:'d2'},
            	          { text: 'Net Total', datafield: 'nettotal',width:'9%',cellsalign:'right',align:'right',cellsformat:'d2'}       
         	              ]   
            });  
    	    $("#overlay, #PleaseWait").hide();
    	    
    	    $("#jqxinvoiceGrid").on("rowdoubleclick", function (event){
 			    var rowindex = event.args.rowindex;
				$("#invoicedocno").val($("#jqxinvoiceGrid").jqxGrid('getcellvalue', rowindex, 'doc_no')); 			  
				$('.textpanel p').text($('#jqxinvoiceGrid').jqxGrid('getcellvalue',rowindex,'voc_no')+' - '+$('#jqxinvoiceGrid').jqxGrid('getcellvalue', rowindex, "refname"));
 			});  
    });    
 </script>
<div id="jqxinvoiceGrid"></div>