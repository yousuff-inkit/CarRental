<%@page import="com.humanresource.setup.hrsetup.terminationsetup.ClsTerminationSetupDAO"%>
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
       var leavedata;
       var docnoss='<%=docnos%>';
       var leaveid='<%=leaveid%>';
       var type='<%=type%>';
    	
       resigdata='<%=showDAO.searchResignation(docnos)%>';  
		
       var cellclassnamer = function (row, column, value, data) {
    		    
    	  if(parseInt(data.checkclick)==0){
    			   return "whiteClass";   
    	  } else if(parseInt(data.checkclick)==1){
   	        	return "greenClass";
   	      } else if(document.getElementById("newmode").value=='Saved') {
			  var leaveid=document.getElementById("leaveid").value;
			 
			  if(parseInt(data.srno)==parseInt(leaveid) && type==='RES') {
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
                localdata: resigdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxresignationgrid").jqxGrid(
            {
            	 width: '100%',
                 height: 190,
                 source: dataAdapter,
                 editable: true,
                 selectionmode: 'singlecell',
                       
                 columns: [
					       { text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'sl', columntype: 'number', width: '10%',cellclassname: cellclassnamer,
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }  
                     	   },	
						 { text: 'Upto Years', datafield: 'years', width: '35%',cellclassname: cellclassnamer,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: 'Days/Year', datafield: 'days', width: '35%' ,cellclassname: cellclassnamer,cellsformat: 'd2',cellsalign: 'right', align: 'right'},
						 { text: ' ', datafield: 'btnsave', width: '20%',columntype: 'button',editable:false, filterable: false,cellclassname: cellclassnamer},
						 { text: 'checkclick', datafield: 'checkclick', width: '9%',hidden:true},
						 { text: 'srno', datafield: 'srno', width: '9%',hidden:true}, 
						]
            });
            
            $('#jqxresignationgrid').on('cellvaluechanged',function (event) {
           	 var rowindex1 = event.args.rowindex;
           	var args = event.args;
           	var columnDataField = args.datafield;
	 		 var rows = $('#jqxresignationgrid').jqxGrid('getrows');
             var rowlength= rows.length;
             if (rowindex1 == rowlength - 1) {
            	 if(columnDataField !=='checkclick')	 
               $("#jqxresignationgrid").jqxGrid('addrow', null, {btnsave:"Apply"});	
    	     }});	
            
            $("#jqxresignationgrid").on('cellclick', function (event) {
           		 
           		    var datafield = event.args.datafield;
           		    var rowBoundIndex = event.args.rowindex;
           		    var columnindex = event.args.columnindex;
  
                    if(datafield=="btnsave"){

                    	if($('#jqxresignationgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="Apply"){
                   	 
                 			var rows1 = $("#jqxresignationgrid").jqxGrid('getrows');      
                      	 
                  	   		for(var i=0;i<rows1.length;i++){
                  		   		$("#jqxresignationgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                  	   		}
                	    
                			var rows = $("#jqxresignationgrid").jqxGrid('getrows');      
                	 
                	   		for(var i=0;i<rows.length;i++){

                           		if(i==rowBoundIndex){
                        	   
                        	   		$("#jqxresignationgrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   
                        	   		var disdata="show";
                        	   		$("#lsetup2").load("condtiongrid.jsp?disdata="+disdata);
                        	   		$("#condtiongrid").jqxGrid({ disabled: false});	
                          			$('#condtiongrid').jqxGrid('refresh');
                       	    		$('#savebtn').attr('disabled', false);
                       	    		$('#deltbtn').attr('disabled', false);
		                        	   return 0;
        		                   } else {
                        	   			$("#jqxresignationgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
	                        	   }
                	   		}
                   	 	}
                	    
                 	 	if($('#jqxresignationgrid').jqxGrid('getcellvalue',rowBoundIndex, "btnsave")=="View"){
	                   		 $("#condtiongrid").jqxGrid({ disabled: false});	
	                    	 $('#condtiongrid').jqxGrid('refresh');
                	    	 $('#savebtn').attr('disabled', false);
                	         $('#deltbtn').attr('disabled', false);
                	    
                			 var rows1 = $("#jqxresignationgrid").jqxGrid('getrows');      
                   	 
                 	   		 for(var i=0;i<rows1.length;i++){
	                 		   $("#jqxresignationgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
     		            	 }
                 	   
    	            		var rows = $("#jqxresignationgrid").jqxGrid('getrows');      
                	 
	                	    for(var i=0;i<rows.length;i++){

                            if(i==rowBoundIndex){
                        	   
                        	   $("#jqxresignationgrid").jqxGrid('setcellvalue', rowBoundIndex , "checkclick", 1); 
                        	   $("#jqxresignationgrid").jqxGrid('setcellvalue', rowBoundIndex , "btnsave", "Apply");
                        	   var srno=$('#jqxresignationgrid').jqxGrid('getcellvalue',rowBoundIndex, "srno");
             				   var refno= document.getElementById("refno").value;
             				   var disdata="show"; 
             				   var type = "RES"
                        	   $("#lsetup2").load("condtiongrid.jsp?docno="+refno+"&refno="+srno+"&disdata="+disdata+"&type="+type);
                        	   return 0;
                            } else {
                        	   $("#jqxresignationgrid").jqxGrid('setcellvalue', i , "checkclick", 0);
                        	}
                	   }
                   	  }
                   	 }
           		}); 
         
            var noofrows = $('#jqxresignationgrid').jqxGrid('getrows');
            if(noofrows.length<=0||docnoss>0){
            	 $("#jqxresignationgrid").jqxGrid('addrow', null, {btnsave:"Apply"});
            	 
            }
            
        });
		
</script>
<div id="jqxresignationgrid"></div>