<%@page import="com.dashboard.leaseagreement.ClsleaseagreementDAO" %>
<%ClsleaseagreementDAO crad=new ClsleaseagreementDAO(); %>

   	<%
   	String rdocno = request.getParameter("rdocno")==null?"NA":request.getParameter("rdocno").trim();
   	
	
   	%>

 
<script type="text/javascript">

var rtariffs;

var tepss='<%=rdocno%>';

if(tepss!='NA')
	{
	 rtariffs='<%=crad.latariffchangegrid(rdocno)%>';
	
	}
else
	{
	
	rtariffs;
	}


$(document).ready(function () { 
	
	var cellclassname;
	// var cellclass ;
    var num = 0; 
    
    
var source =
  {
  datatype: "json",
  datafields: [
              /* {name : 'available' , type: 'bool' }, */
              	{name : 'rate' , type:'number'},
              	{name : 'cdw' , type:'number'},
              	{name : 'pai' , type:'number'},
              	{name : 'cdw1' , type:'number'},
              	{name : 'pai1' , type:'number'},
              	{name : 'gps' , type:'number'},
              	{name : 'babyseater' , type:'number'},
              	{name : 'cooler' , type:'number'},
              	 {name : 'kmrest' , type:'number'},
              	{name : 'exkmrte' , type:'number'},
              	{name : 'oinschg' , type:'number'},
              	{name : 'exhrchg' , type:'number'},
              	{name : 'chaufchg' , type:'number'},
              	{name : 'chaufexchg' , type:'number'},
              	{name : 'status' , type:'number'},
              	{name : 'disclevel' , type:'number'},
               	
              	
			   ],
			   localdata: rtariffs,
       
			   
       pager: function (pagenum, pagesize, oldpagenum) {
           // callback called when a page or pagse size is changed.
       }
 };
    $('#rtaiff').on('bindingcomplete', function (event) {
    	
    
    	
  if(tepss!="NA")
	  {

    
    /*   $("#rtaiff").jqxGrid('addrow', null,  {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
      

    $("#rtaiff").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
    
    $("#rtaiff").jqxGrid('addrow', null, {"rentaltype": "","tarif": "","cdw": "","pai": "","cdw1": "","pai1": "","gps": "","babyseater": "","cooler": "","kmrest": "","exkmrte": "","oinschg": "","exhrchg": "","chaufchg": "","chaufexchg": "","status": ""});
	  */ } 
  
  
});
	 
    var rowEdit = function (row) {
    	/* var rows11 = $("#rtaiff").jqxGrid('getrows');
    	
    	var rowval=rows11.length;
    //	alert(rowval);
    	var eidtval=rowval-2;
    	//alert(eidtval);
    		 if (row != eidtval){
    			 
     */
    			 return true;
    	
    }
    var cellsrenderer = function (row, column, value, defaultHtml) {
    				var rows11 = $("#rtaiff").jqxGrid('getrows');
    					var rowval=rows11.length;
    				/* var row1=rowval-1;
    				var row2=rowval-2;
    				 */
    				 if ( row == 0) {
      			    	//alert("row3"+row3);
      			        var element = $(defaultHtml);
      			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
      			        return element[0].outerHTML;
      			    }
    				/* if ( row == 0 || row == 1 || row == 2) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
     				 if ( row == row2 ) {
      			    	//alert("row3"+row3);
      			        var element = $(defaultHtml);
      			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
      			        return element[0].outerHTML;
      			    }
     			    var row3=rowval-3;
     			   
     			    if (row == row3 || row == row1 ) {
     			    	//alert(row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#FFE87C', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    				 */
    			   /*  if ( row == row1 ) {
    			    	//alert("row3"+row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#e6e6fa', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    }
    				 if ( row == row2 ) {
     			    	//alert("row3"+row3);
     			        var element = $(defaultHtml);
     			        element.css({ 'background-color': '#ffffe0', 'width': '100%', 'height': '100%', 'margin': '0px' });
     			        return element[0].outerHTML;
     			    }
    			    var row3=rowval-3;
    			   
    			    if (row == row3) {
    			    	//alert(row3);
    			        var element = $(defaultHtml);
    			        element.css({ 'background-color': '#ffe4e1', 'width': '100%', 'height': '100%', 'margin': '0px' });
    			        return element[0].outerHTML;
    			    } */
    			    return defaultHtml;
    			}


 var dataAdapter = new $.jqx.dataAdapter(source,
  		 {
      		loadError: function (xhr, status, error) {
            alert(error);    
         }
	            
       });


 
   $("#rtaiff").jqxGrid(
   {
      width: '100%',
      height: 100,
      source: dataAdapter,
      columnsresize: true,
      rowsheight:20,


      editable:true,
      selectionmode: 'singlecell',
      pagermode: 'default',
      theme: theme,
     
   
       columns: [  
            
					 { text: '      '+document.getElementById("mainrate").value,     datafield: 'rate', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincdw").value,        datafield: 'cdw',  editable:true ,cellsformat: 'd2' , cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai").value,     	 datafield: 'pai',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit, cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincdw1").value,    	 datafield: 'cdw1',  editable:true ,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainpai1").value,    	 datafield: 'pai1',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maingps").value,      	 datafield: 'gps',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("mainbabyseater").value,  	 datafield: 'babyseater',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '      '+document.getElementById("maincooler").value,          datafield: 'cooler',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: '  '+document.getElementById("mainkmrest").value,          datafield: 'kmrest',  editable:true, cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainexkmrte").value,         datafield: 'exkmrte', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainoinschg").value,         datafield: 'oinschg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer,hidden:true},
					{ text: ''+document.getElementById("mainexhrchg").value,         datafield: 'exhrchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer,hidden:true},
					{ text: ''+document.getElementById("mainchaufchg").value,        datafield: 'chaufchg',  editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: ''+document.getElementById("mainchaufexchg").value,      datafield: 'chaufexchg', editable:true,cellsformat: 'd2', cellsalign: 'right', align:'right',cellbeginedit: rowEdit,cellsrenderer: cellsrenderer},
					{ text: 'Status', datafield: 'status', editable:false,hidden:true},
					{ text: 'disclevel', datafield: 'disclevel', editable:false,hidden:true},
										]
      
        
					 }); 
   
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subrate").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcdw").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subpai").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcdw1").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subpai1").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subgps").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subbabyseater").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subcooler").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subkmrest").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subexkmrte").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("suboinschg").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subexhrchg").value); 
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subchaufchg").value);
   $('#rtaiff').jqxGrid('hidecolumn', ''+document.getElementById("subchaufexchg").value);
  

});


 </script>

           
   <div id="rtaiff"> </div>
   

<input type="hidden" id="calcuvals">

 <jsp:include  page="..\..\..\common\commonGrid.jsp"></jsp:include>   



