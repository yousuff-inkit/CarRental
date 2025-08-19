
<%@page import="com.dashboard.operations.agmtpaymentupdate.*"%>
<%ClsAgmtPaymentupdateDAO updatedao=new ClsAgmtPaymentupdateDAO();%>
<%
String agmtno=request.getParameter("agmtno")==null?"":request.getParameter("agmtno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
String amount=request.getParameter("amount")==null?"0":request.getParameter("amount");

 /* String agmtno="2308";
String id="1";
String amount="160000"; */
 %>
 <style>
 .redClass
   		{
   		   background:#FA968F;
   		}
 </style>
 <script type="text/javascript">
 var id='<%=id%>';
 var data;
 var amount='<%=amount%>';	
 if(id=='1'){
	 data='<%=updatedao.getPaymentData(agmtno,amount,id)%>';
 }
 $(document).ready(function () { 	
	// Get the list element
	 var myList = document.getElementById('myList');

	 // Get all the list items within the list
	 var listItems = myList.getElementsByTagName('li');

	 // Attach a click event listener to each list item
	 for (var i = 0; i < listItems.length; i++) {
	   listItems[i].addEventListener('click', onItemClick);
	 }
	 
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + value + '</div>';
    }
            var source =
            {
                datatype: "json",
                datafields: [
     						{name : 'cldocno', type: 'int' },
     						{name : 'refname', type: 'string'    },
     						{name : 'agmtno',type: 'string'},
     						{name : 'agmtvocno',type:'string'},
     						{name : 'detaildocno', type: 'int'},
     						{name : 'chequedate', type: 'date'    },
     						{name : 'amount',type:'number'},
     						{name : 'date', type: 'date'   },
     						{name : 'bpvno',type:'string'},
     						{name : 'chequeno',type:'number'},
     						{name : 'srno',type:'number'},
     						{name : 'chqname',type:'string'},
     						{name : 'invstatus',type:'number'},
     							
                 ],
                 localdata: data,
                
                deleterow: function (rowid, commit) {
                   // synchronize with the server - send delete command
                   // call commit with parameter true if the synchronization with the server is successful 
                   // and with parameter false if the synchronization failed.
                	commit(true);
		        	
               },
               
              
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            $("#agmtPaymentUpdateGrid").on("bindingcomplete", function (event) {
            	$("#overlay, #PleaseWait").hide();
            	
            });  
            
             var cellclassname = function (row, column, value, data) {
	        	if(data.invstatus==1){
            		return "redClass";
            	}        	 
        	
        	};
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#agmtPaymentUpdateGrid").jqxGrid(
            {
                width: '98%',
                height: 250,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                showstatusbar:true,
                selectionmode: 'checkbox',
                editable: true,
                
                columns: [
							
							{ text: 'Agmt Original No',datafield:'agmtno',width:'7%',hidden:true,editable:false,cellclassname: cellclassname},
							{ text: 'Agmt No', datafield: 'agmtvocno', width: '7%' ,editable:false,cellclassname: cellclassname},
							{ text: 'Agmt Date', datafield: 'date', width: '10%' ,cellsformat:'dd.MM.yyyy',editable:false,cellclassname: cellclassname},
							{ text: 'Client #',datafield:'cldocno',width:'8%',editable:false,cellclassname: cellclassname},
							{ text: 'Client Name', datafield: 'refname', width: '25%' ,editable:false,cellclassname: cellclassname},
							{ text: 'Cheque Date',datafield:'chequedate',width:'10%',cellsformat:'dd.MM.yyyy',editable:true,cellclassname: cellclassname,columntype:'datetimeinput'},
							{ text: 'Detail Doc No',datafield:'detaildocno',width:'8%',hidden:false,editable:false,cellclassname: cellclassname},
							{ text: 'Amount',datafield:'amount',width:'10%',cellsformat:'d2',align:'right',cellsalign:'right',editable:true,cellclassname: cellclassname,aggregates: ['sum'],aggregatesrenderer:rendererstring},
							{ text: 'Cheque No', datafield: 'chequeno', width: '10%',editable:true,cellclassname: cellclassname},
							{ text: 'BPV No',datafield:'bpvno',width:'9%',editable:false,cellclassname: cellclassname},
							{ text: 'Inv Status', datafield: 'invstatus', width: '10%',hidden:true,cellclassname: cellclassname},
							{ text: 'Chqname', datafield: 'chqname', width: '10%',hidden:true,cellclassname: cellclassname},
								
							]
            });
            $('#agmtPaymentUpdateGrid').on('rowselect', function (event) 
    		{
    		    // event arguments.
    		    var args = event.args;
    		    // row's bound index.
    		    var rowBoundIndex = event.args.rowindex;
    		    // row's data. The row's data object or null(when all rows are being selected or unselected with a single action). If you have a datafield called "firstName", to access the row's firstName, use var firstName = rowData.firstName;
    		    var rowData = event.args.row;
    		    
    		    
    		  	var invstatus=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',rowBoundIndex,'invstatus');
    		    if(invstatus==1){
    		    	$('#agmtPaymentUpdateGrid').jqxGrid('unselectrow', rowBoundIndex);
    		    	$.messager.alert('Warning',"Transaction Exists");
    		    }
    		    
    		    document.getElementById("srno").value=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue', rowBoundIndex, "detaildocno");
      		  
    		});
    		$("#agmtPaymentUpdateGrid").on('cellbeginedit', function (event)    
			{
			    // event arguments.
			    var args = event.args;
			    // column data field.
			    var dataField = event.args.datafield;
			    // row's bound index.
			    var rowBoundIndex = event.args.rowindex;
			    // cell value
			    var value = event.args.value;
			    // row's data.
			    var rowData = event.args.row;
			    
			    var invstatus=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',rowBoundIndex,'invstatus');
    		    if(invstatus==1){
    		    	return false;
    		    }
			});
    		$("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    		// create context menu
       		var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 50, autoOpenPopup: false, mode: 'popup'});
       		$("#agmtPaymentUpdateGrid").on('contextmenu', function () {
           		return false;
       		});
    		 $("#agmtPaymentUpdateGrid").on('rowclick', function (event) {
    	           if (event.args.rightclick) {
    	               $("#agmtPaymentUpdateGrid").jqxGrid('selectrow', event.args.rowindex);
    	               var scrollTop = $(window).scrollTop();
    	               var scrollLeft = $(window).scrollLeft();
    	               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
    	              
    	               return false;
    			   }
    	       });
 });
//Click event handler function
 function onItemClick(event) {
   var clickedItem = event.target;
   //alert('Clicked item:', clickedItem.textContent);
   var args = event.args;
  	var rowindex = $("#agmtPaymentUpdateGrid").jqxGrid('getselectedrowindex');
  	var invstatus=$('#agmtPaymentUpdateGrid').jqxGrid('getcellvalue',rowindex,'invstatus');
	    if(invstatus==1){
	    	//$('#agmtPaymentUpdateGrid').jqxGrid('unselectrow', rowBoundIndex);
	    	$.messager.alert('Warning',"Transaction Exists");            
	    	return false;
	    }    
   // Add your logic here
   if (clickedItem.textContent == "Add New Row") {
           		var selectedRowindex = $("#agmtPaymentUpdateGrid").jqxGrid('getselectedrowindex');
           		//alert("========"+selectedRowindex);
           		var rowid = $("#agmtPaymentUpdateGrid").jqxGrid('getrowid', selectedRowindex);
           		//alert("rowid"+rowid);
           		
           		$('#agmtPaymentUpdateGrid').jqxGrid('addrow', null, {});  
           		var rows = $('#agmtPaymentUpdateGrid').jqxGrid('getrows');
           		var lastrow = rows.length-1;
           		//alert(lastrow);  
           	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'agmtvocno',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'agmtvocno'));
         	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'date',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'date'));
         	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'cldocno',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'cldocno'));
         	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'refname',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'refname'));
         	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'agmtno',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'agmtno'));
         	 $("#agmtPaymentUpdateGrid").jqxGrid('setcellvalue',lastrow,'chqname',$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowid,'chqname'));
          	
     }
   
	if (clickedItem.textContent  == "Delete Selected Row") {
   		
   		var deletedrows=$('#deletedrows').val();
   		var detaildocno=$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowindex,'detaildocno');
   		if(detaildocno!="" && detaildocno!="undefined" && detaildocno!=null && typeof(detaildocno)!="undefined"){
		if(deletedrows==""){
       			deletedrows=$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowindex,'detaildocno');
       		}
       		else{
       			deletedrows+=","+$("#agmtPaymentUpdateGrid").jqxGrid('getcellvalue',rowindex,'detaildocno');
       		}
   			$('#deletedrows').val(deletedrows);
   		}
   		var rowid = $("#agmtPaymentUpdateGrid").jqxGrid('getrowid', rowindex);
    	$("#agmtPaymentUpdateGrid").jqxGrid('deleterow', rowid);
   
   	}
 }

    </script>
    <div id='jqxWidget'>
    	<div id="agmtPaymentUpdateGrid"></div>
    	<div id="popupWindow">
 			
 			<div id='Menu'>
        		<ul id="myList">
            		<li>Delete Selected Row</li>
            	    <li>Add New Row</li>
        		</ul>
       		</div>
       </div>
   </div>
   
    <input type="hidden" name="invoicerow" id="invoicerow">
    <input type="hidden" name="temprepno" id="temprepno">