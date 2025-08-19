<%@page import="com.humanresource.setup.hrsetup.terminationsetup.ClsTerminationSetupDAO"%>
<%@page import="com.humanresource.setup.hrsetup.leavesetup.ClsLeavesetupDAO"%>
<% ClsTerminationSetupDAO showDAO = new ClsTerminationSetupDAO(); %>  
<% String docnos = request.getParameter("docno")==null||request.getParameter("docno").equalsIgnoreCase("")?"0":request.getParameter("docno");
   String leaveid = request.getParameter("leaveid")==null?"0":request.getParameter("leaveid");
   String type = request.getParameter("type")==null?"0":request.getParameter("type");%>
   
 <style>
 .greenClass{
            background-color: #ACF6CB;
        }
.whiteClass{
           background-color: #fff;
        }
	        
.saveClass{
      /*   background-color: #ffa07a; */
       background-color: #d8bfd8;
        }     
        
 </style>

<script type="text/javascript">
       var leavegriddata;
       var docnoss='<%=docnos%>';
       var leaveid='<%=leaveid%>';
       var type='<%=type%>';
       
       leavegriddata='<%=showDAO.searchLeave(docnos)%>';  
    	console.log("leavegrid -- "+leavegriddata);
    	
       var cellclassname = function (row, column, value, data) {
    		    
    	  if(parseInt(data.checkclick)==0){
    			   return "whiteClass";   
    	  } else if(parseInt(data.checkclick)==1){
   	        	return "greenClass";
   	      } else if(document.getElementById("newmode").value=='Saved') {
   	    	  var leaveid=document.getElementById("leaveid").value;
			  if(parseInt(data.srno)==parseInt(leaveid) && type==='LEV') {
				return "saveClass";
			   }
		  } else {
    	        return "whiteClass"; 
    	  }
    	};   
			 
		$(document).ready(function () { 	
           
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'years', type:'number'},
                          	{name : 'days', type:'number'},
                        	{name : 'btnsave', type: 'String'}, 
                        	{name : 'srno', type: 'String'}, 
                        	{name : 'checkclick', type: 'String'}, 
                        ],
                        localdata: leavegriddata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#leavegrid").jqxGrid(
            {
            	 width: '100%',
                 height: 190,
                 source: dataAdapter,
                 editable: true,
                 selectionmode: 'singlecell',
                       
                 columns: [
					       { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '10%',cellclassname: cellclassname,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                     	   },	
						 { text: 'Upto Years', datafield: 'years', width: '35%',cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'Days/Year', datafield: 'days', width: '35%' ,cellclassname: cellclassname,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: ' ', datafield: 'btnsave', width: '20%',columntype: 'button',editable:false, filterable: false,cellclassname: cellclassname},
						 { text: 'srno', datafield: 'srno', width: '9%',hidden:true}, 
						 { text: 'checkclick', datafield: 'checkclick', width: '9%',hidden:true},
						]
            });
            
            $('#leavegrid').on('cellvaluechanged',function (event) {
           	 	var rowindex1 = event.args.rowindex;
           		var args = event.args;
             	var columnDataField = args.datafield;
     		
	 		 var rows = $('#leavegrid').jqxGrid('getrows');
             var rowlength= rows.length;
             if (rowindex1 == rowlength - 1) {
            	if(columnDataField !=='checkclick')
             	  $("#leavegrid").jqxGrid('addrow', null, {btnsave:"Apply"});	
    	     }});	
            
            $("#leavegrid").on('cellclick', function (event) {
           		    var datafield = event.args.datafield;
           		    var rowBoundIndex = event.args.rowindex;
           		    var columnindex = event.args.columnindex;
  
                    if(datafield=="btnsave"){

                    	if($('#leavegrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Apply"){
                 			var rows1 = $("#leavegrid").jqxGrid('getrows');      
                      	 
                  	   		for(var i=0;i<rows1.length;i++){
                  		   		$("#leavegrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                  	   		}
                	    
                			var rows = $("#leavegrid").jqxGrid('getrows');      
                	 
                	   		for(var i=0;i<rows.length;i++){

                           		if(i==rowBoundIndex){
                        	   
                        	   		$("#leavegrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   
                        	   		var disdata="show";
                        	   		$("#lsetup2").load("condtiongrid.jsp?disdata="+disdata);
                        	   		$("#condtiongrid").jqxGrid({ disabled: false});	
                          			$('#condtiongrid').jqxGrid('refresh');
                       	    		$('#savebtn').attr('disabled', false);
                       	    		$('#deltbtn').attr('disabled', false);
		                        	   return 0;
        		                   } else {
                        	   			$("#leavegrid").jqxGrid('setcellvalue', i , "checkclick", 0);
	                        	   }
                	   		}
                   	 	}
                	    
                 	 	if($('#leavegrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="View"){
	                   		 $("#condtiongrid").jqxGrid({ disabled: false});	
	                    	 $('#condtiongrid').jqxGrid('refresh');
                	    	 $('#savebtn').attr('disabled', false);
                	         $('#deltbtn').attr('disabled', false);
                	    
                			 var rows1 = $("#leavegrid").jqxGrid('getrows');      
                   	 
                 	   		 for(var i=0;i<rows1.length;i++){
	                 		   $("#leavegrid").jqxGrid('setcellvalue', i , "checkclick", 0);
     		            	 }
                 	   
    	            		var rows = $("#leavegrid").jqxGrid('getrows');      
                	 
	                	    for(var i=0;i<rows.length;i++){

                            if(i==rowBoundIndex){
                        	   
                        	   $("#leavegrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   $("#leavegrid").jqxGrid('setcellvalue', rowBoundIndex , "btnsave", "Apply");
                        	   var srno=$('#leavegrid').jqxGrid('getcellvalue',rowBoundIndex, "srno");
             				   var refno= document.getElementById("refno").value;
             				   var disdata="show";
             				   var type = "LEV";
                        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&refno="+srno+"&disdata="+disdata+"&type="+type);
                        	   return 0;
                            } else {
                        	   $("#leavegrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                        	}
                	   }
                   	  }
                   	 }
           		}); 
         
            
            var noofrows = $('#leavegrid').jqxGrid('getrows');
            if(noofrows.length<=0||docnoss>0){
            	 $("#leavegrid").jqxGrid('addrow', null, {btnsave:"Apply"});
            }
        });
		
</script>
<div id="leavegrid"></div>