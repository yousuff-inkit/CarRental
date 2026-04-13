<%@page import="com.operations.clientrelations.client.ClsClientDAO"%>
<% ClsClientDAO DAO= new ClsClientDAO(); %>
<% String docNo = request.getParameter("txtclientdocno2")==null?"0":request.getParameter("txtclientdocno2"); 
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

<script type="text/javascript">
        var data,datas;      
        $(document).ready(function () { 	
           
           var temp='<%=docNo%>';
            
             if(temp>0)
          	 {   
           	     data='<%=DAO.creditCardGridReloading(docNo,check)%>';      
          	 
          	 }else{
          		 
          		datas='<%=DAO.getCardType()%>';
          	 
          	 }
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [                          	
     						{name : 'type', type: 'string' },
     						{name : 'cardno', type: 'string' },
     						{name : 'exp_date', type: 'date' },
     						{name : 'remarks', type: 'string' },
     						{name : 'defaultcard', type: 'bool' },
     						{name : 'hidexpdate', type: 'string' }
                 ],
                 localdata: data,
                                        
            };
            
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            var list = datas.split(","); 
            	
            $("#jqxCreditCardDetails").jqxGrid(
            {
                width: '70%',
                height: 200,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                
                //Add row method
                 handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxCreditCardDetails').jqxGrid('getrows');
                	var rowlength= rows.length;
                    var cell = $('#jqxCreditCardDetails').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'defaultcard' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {  
                            var commit = $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});
                            rowlength++; 
                        }
                    } 
                },
                
                columns: [							
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,datafield: '',
							    columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
							    cellsrenderer: function (row, column, value) {
							  	  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},
							{ text: 'Type', datafield: 'type', width: '15%',columntype:'dropdownlist',
                                createeditor: function (row, column, editor) {
                                                      editor.jqxDropDownList({ autoDropDownHeight: true, source: list });
                                }
                            },
                            { text: 'Card No.', datafield: 'cardno', width: '24%' },
                            { text: 'Exp-Date', datafield: 'exp_date', cellsformat: 'dd.MM.yyyy', columntype: 'datetimeinput', width: '13%',
                            	validation: function (cell, value) {
			                          var year = value.getFullYear();
			                          var cdate=new Date();
			                          var cyear=cdate.getFullYear();
			                          var year = value.getFullYear();
			                          if (year < cyear) {
			                        	  document.getElementById("chkcardvalid").value=1;
			                              return { result: false, message: "Card Expired." };
			                          }
			                          document.getElementById("chkcardvalid").value=0;
			                          return true;
								}	
                            },
                            { text: 'Remarks', datafield: 'remarks', width: '35%' },
                            { text: 'Default', datafield: 'defaultcard', columntype: 'checkbox', editable: true, checked: true, width: '8%',cellsalign: 'center', align: 'center' },
                            { text: 'Hid-Exp', datafield: 'hidexpdate', editable: false, hidden: true,  width: '10%' },
	              ]
            });
            
            //Add empty row
            if(temp==0){ 
       	      $("#jqxCreditCardDetails").jqxGrid('addrow', null, {});  
            }
            
          if(temp>0){  
        	  $("#jqxCreditCardDetails").jqxGrid({ disabled: true});
       	  }
          
          $("#jqxCreditCardDetails").on('cellvaluechanged', function (event){
          	var datafield = event.args.datafield;
            var rowBoundIndex = event.args.rowindex;
  	        
			if(datafield=="exp_date"){
  	            var expdate = $('#jqxCreditCardDetails').jqxGrid('getcelltext', rowBoundIndex, "exp_date");
  	            $('#jqxCreditCardDetails').jqxGrid('setcellvalue',rowBoundIndex, "hidexpdate",expdate);
  	         }
			 
			if(datafield=="cardno"){
	  	    	if(window.parent.cardnumbervalidator.value==1){
		            var cardno = $('#jqxCreditCardDetails').jqxGrid('getcelltext', rowBoundIndex, "cardno");
		            cardnumber(cardno);
	  	    	}
	         }
          });
          
          $("#jqxCreditCardDetails").bind('cellendedit', function (event) {
        	  var dataField = event.args.datafield;
        	  var rowIndex = event.args.rowindex;
        	  if(dataField=="defaultcard"){
	        	  if (event.args.value==true) {
	        	  
	        		  var rows = $("#jqxCreditCardDetails").jqxGrid('getrows');
	       				 for(var i=0 ; i < rows.length ; i++){
	       					 $('#jqxCreditCardDetails').jqxGrid('setcellvalue',i, "defaultcard","false");
	       				 }
	       			  $('#jqxCreditCardDetails').jqxGrid('setcellvalue',rowIndex, "defaultcard","true"); 
	        	  }
        	  }
        	});
       
});
        
</script>
<style>
.jqx-grid-header {
    /* Shifted from #f8f9fa to #e9ecef (subtly darker gradient) */
    background: linear-gradient(180deg, #e9ecef 0%, #dee2e6 100%) !important;
    border-color: #ced4da !important;
    color: #212529 !important;
font-family: Arial, sans-serif;
}

.jqx-grid-column-header {
    background: transparent !important;
    color: #212529 !important;
    font-weight: 700 !important;
    font-size: 11px !important;
    text-align: left !important;
    border-color: #ced4da !important;
}

.jqx-grid-column-header a:link,
.jqx-grid-column-header a:visited {
    color: #212529 !important;
    text-align: left !important;
}

.jqx-grid-column-header > div > div {
    text-align: left !important;
    padding-left: 6px !important;
}

/* Cell Styling */
.jqx-grid-cell {
    background: #ffffff;
    border-color: #dee2e6 !important; /* Slightly darker grid lines */
    color: #1f2937;
    font-size: 11px !important;
    text-align: left !important;
}

.jqx-grid-cell-left-align {
    text-align: left !important;
    padding-left: 6px !important;
    margin-left: 0px !important;
}

.jqx-grid-cell-middle-align {
    text-align: left !important;
    padding-left: 6px !important;
}

.jqx-grid-cell-right-align {
    text-align: right !important;
    padding-right: 6px !important;
}

/* Zebra Striping (Alt Rows) */
.jqx-grid-cell-alt {
    background: #f1f3f5 !important; /* Darker than the previous #f8f9fa */
}

/* Hover & Selection States */
.jqx-grid-cell-hover {
    background: #dee2e6 !important; /* More pronounced hover */
    border-color: #ced4da !important;
    color: #000000 !important;
}

.jqx-grid-cell-selected {
    background: #adb5bd !important; /* Solid medium grey for selection */
    color: #ffffff !important;
    border-color: #868e96 !important;
}

.jqx-grid-table .jqx-grid-cell {
    border-width: 0px 0px 1px 0px !important;
    border-color: #dee2e6 !important;
}

/* Main Container */
.jqx-grid {
    border: 1px solid #adb5bd !important; /* Darker outer border */
    border-radius: 8px !important;
    overflow: hidden !important;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
}

/* Specialized Cell States */
.jqx-grid-cell-sort {
    background-color: #e9ecef !important;
}
.jqx-grid-cell-sort-alt {
    background-color: #dee2e6 !important;
}

.jqx-grid-cell-filter,
.jqx-grid-cell-filter-alt {
    background-color: #f1f3f5 !important;
}

.jqx-grid-cell-pinned,
.jqx-grid-cell-pinned-alt {
    background-color: #e9ecef !important;
}

/* Pager & UI Elements */
.jqx-grid-pager {
    background: #e9ecef !important; /* Darker pager background */
    border-top: 1px solid #ced4da !important;
    padding: 4px !important;
}

.jqx-grid-column-menubutton {
    opacity: 0.5;
    transition: opacity 0.2s;
}
.jqx-grid-column-menubutton:hover {
    opacity: 1;
}

/* Scrollbar Styling */
.jqx-scrollbar-state-normal {
    background: #f1f3f5 !important;
}
.jqx-scrollbar-thumb-state-normal,
.jqx-scrollbar-thumb-state-normal-horizontal {
    background: #868e96 !important; /* Steel grey thumb */
    border-color: #868e96 !important;
    border-radius: 4px !important;
}
.jqx-scrollbar-thumb-state-hover,
.jqx-scrollbar-thumb-state-hover-horizontal {
    background: #495057 !important; /* Deep grey on hover */
    border-radius: 4px !important;
}
</style>
<div id="jqxCreditCardDetails"></div>
<input type="hidden" id="chkcardvalid" name="chkcardvalid">