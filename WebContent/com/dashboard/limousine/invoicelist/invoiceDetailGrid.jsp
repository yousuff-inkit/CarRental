<%@page import="com.dashboard.limousine.invoicelist.ClsInvoiceListDAO" %>
<% ClsInvoiceListDAO dao=new ClsInvoiceListDAO();    
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String client=request.getParameter("client")==null?"":request.getParameter("client");
String check=request.getParameter("check")==null?"":request.getParameter("check");
%>
<script type="text/javascript">
var detdata,dataexcel;                     
detdata='<%=dao.gridDetailData(fromdate,todate,client,check)%>';      
$(document).ready(function () {      
        var source =
           {
           datatype: "json",
           datafields: [   
        	   				{name : 'doc_no',type:'string'},
        	              {name : 'voc_no',type:'string'},
       		              {name : 'refname', type:'string'},
			        	   {name:'guest',type:'string'},
			               {name:'guestno',type:'number'},
			               {name:'jobtype',type:'string'},
			               {name:'jobname',type:'string'},
			               {name:'jobnametemp',type:'string'},
			               {name:'jobdocno',type:'string'},
			               {name:'bookdocno',type:'string'},
			               {name:'tarif',type:'number'},
			               {name:'nighttarif',type:'number'},
			               {name:'excesskmchg',type:'number'},
			               {name:'excesshrchg',type:'number'},
			               {name:'excessnighthrchg',type:'number'},
			               {name:'fuelchg',type:'number'},
			               {name:'parkingchg',type:'number'},
			               {name:'otherchg',type:'number'},
			               {name:'greetchg',type:'number'},
			               {name:'vipchg',type:'number'},
			               {name:'boquechg',type:'number'},
			               {name:'total',type:'number'},
			               {name : 'vesselno',type:'string'},
			        		{name : 'vesselname',type:'string'},
			        		{name : 'pickuploc', type:'string'},
			        		{name:'bookno',type:'string'},
			        		{name:'dropoffloc',type:'string'},
			        		{name : 'vatpercent',type:'number'},
			        		{name : 'vatvalue',type:'number'},
			        		{name : 'nettotal',type:'number'},
			        		{name : 'refno',type:'string'},
     				   ],
					localdata:detdata,   
                
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
          $("#jqxinvoicedetailGrid").on("bindingcomplete", function (event) {
  		    var config = $('#hidetariff').val();
  		  	if (config == 1) {
		    	$("#jqxinvoicedetailGrid").jqxGrid('hidecolumn', 'vesselno');
		    	$("#jqxinvoicedetailGrid").jqxGrid('hidecolumn', 'vesselname');
		    } else {
		    	$("#jqxinvoicedetailGrid").jqxGrid('showcolumn', 'vesselno');
		    	$("#jqxinvoicedetailGrid").jqxGrid('showcolumn', 'vesselname');
		    }
  		});
            $("#jqxinvoicedetailGrid").jqxGrid(    
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
            	   { text: 'Sr. No.',datafield: '',columntype:'number', width: '6%', cellsrenderer: function (row, column, value) {
                       return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                }   },
                { text: 'Doc No', datafield: 'doc_no',width:'0%', hidden:true}, 
                { text: 'Doc No', datafield: 'voc_no',width:'6%'}, 
                { text: 'Client', datafield: 'refname',width:'10%'},
                { text: 'Guest',datafield:'guest',width:'10%'},
                { text: 'Guest No',datafield:'guestno',hidden:true},
                { text: 'Jobtype',datafield:'jobtype',width:'8%'},
                { text: 'Job Name',datafield:'jobname',width:'8%',hidden:true},
                { text: 'Job Doc No',datafield:'jobdocno',width:'20%',hidden:true},
                { text: 'Book Docno',datafield:'bookdocno',width:'10%',hidden:true},
                { text: 'Job Name',datafield:'jobnametemp',width:'6%'},
                { text: 'Ref No.',datafield:'refno',width:'6%'},
                { text: 'Booking No',datafield:'bookno',width:'8%'},
                { text: 'Dropoff Location',datafield:'dropoffloc',width:'8%'},
                { text: 'Pickup Loction',datafield:'pickuploc',width:'8%'},
                { text: 'V. No', datafield: 'vesselno',width:'8%'},
  	            { text: 'V. Name', datafield: 'vesselname',width:'10%'},
                { text: 'Total', datafield: 'total', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right',editable:false},
                { text: 'Tax', datafield: 'vatpercent',width:'5%',cellsalign:'right',align:'right',cellsformat:'d2',hidden:true},
  	            { text: 'Tax', datafield: 'vatvalue',width:'9%',cellsalign:'right',align:'right',cellsformat:'d2'},
  	            { text: 'Net Total', datafield: 'nettotal',width:'9%',cellsalign:'right',align:'right',cellsformat:'d2'},
                { text: 'Rental', datafield: 'tarif', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Night Tarif', datafield: 'nighttarif', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Excess Km Chg', datafield: 'excesskmchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Excess Hr Chg', datafield: 'excesshrchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Excess Night Hr chg', datafield: 'excessnighthrchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Fuel Chg', datafield: 'fuelchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Parking Chg', datafield: 'parkingchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Other Chg', datafield: 'otherchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Greet Chg', datafield: 'greetchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'VIP Chg', datafield: 'vipchg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'},
                { text: 'Boque Chg',datafield: 'boquechg', width: '8%' ,cellsalign:'right',cellsformat:'d2',align:'right'}
               
         	              ]   
            });     
    	    $("#overlay, #PleaseWait").hide(); 
    	    
    	    $("#jqxinvoicedetailGrid").on("rowdoubleclick", function (event){  
 			    var rowindex = event.args.rowindex;
				$("#invoicedocno").val($("#jqxinvoicedetailGrid").jqxGrid('getcellvalue', rowindex, 'doc_no')); 			  
				$('.textpanel p').text($('#jqxinvoicedetailGrid').jqxGrid('getcellvalue',rowindex,'voc_no')+' - '+$('#jqxinvoicedetailGrid').jqxGrid('getcellvalue', rowindex, "refname"));
 			}); 
   });    
 </script>
<div id="jqxinvoicedetailGrid"></div>