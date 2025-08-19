 <%@ page import="com.dashboard.operations.driverchange.ClsDriverchangeDAO" %>
<%ClsDriverchangeDAO clad=new ClsDriverchangeDAO(); %>

  <%
 
  String barchval = request.getParameter("barchval")==null?"0":request.getParameter("barchval");
  String type = request.getParameter("type")==null?"0":request.getParameter("type");
  String uptodate = request.getParameter("uptodate")==null?"0":request.getParameter("uptodate");
 %> 
 <script type="text/javascript">
 
 var datass;


 
  datass='<%=clad.drvupgrid(barchval,type,uptodate)%>';
 	


         
        $(document).ready(function () { 
        	 var costtype='<%=type%>';
        	//alert(costtype)
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [

                             
                 			{name : 'doc_no', type: 'number'  },
                 			{name : 'agmtno', type: 'String'  },
                 			{name : 'voc_no', type: 'number'  },
                  		    {name : 'drvdate', type: 'date'  },
     						{name : 'type', type: 'String'},
     						{name : 'fleet_no', type: 'String'}, 
     						{name : 'flname', type: 'String'}, 
     						{name : 'reg_no', type: 'String'},
     						{name : 'clname', type: 'String'  },
     						{name : 'cldocno', type: 'String'  },
     						{name : 'drname', type: 'String'  },
     						{name : 'drid', type: 'String'  },
     						{name : 'brhid', type: 'String'  },
     						
      						
                          	],
                          	localdata: datass,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            
            $("#drvupdategrid").on("bindingcomplete", function (event) {
            	
		    	if (costtype =="4"){
            			$('#drvupdategrid').jqxGrid('hidecolumn', 'clname');
			    }else{
			    	
			    	$('#drvupdategrid').jqxGrid('showcolumn', 'clname');
			    
			    }
			    
			    
            });
            $("#drvupdategrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 600,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                showfilterrow:true,
     					
                columns: [
                          { text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							  },
							{ text: 'DOC NO', datafield: 'doc_no', width: '6%',hidden:true },
							{ text: 'agmtdocno', datafield: 'agmtno', width: '6%' ,hidden:true},
                           	{ text: 'DOC NO', datafield: 'voc_no', width: '6%' },
                           	{ text: 'Date', datafield: 'drvdate', width: '7%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Type', datafield: 'type', width: '5%'},
							{ text: 'Fleet', datafield: 'fleet_no', width: '9%' },
							{ text: 'Fleet name', datafield: 'flname', width: '18%' },
							{ text: 'Client Name', datafield: 'clname', width: '22%' },
							{ text: 'Client No', datafield: 'cldocno', width: '15%',hidden:true },
							{ text: 'Reg NO', datafield: 'reg_no', width: '8%'},
							{ text: 'Driver', datafield: 'drname' },
							{ text: 'drid', datafield: 'drid', width: '15%',hidden:true}, 
							{ text: 'brhid', datafield: 'brhid', width: '15%',hidden:true},
						
					
					
					]
            });
    
     	   $("#overlay, #PleaseWait").hide();
     	  $('#drvupdategrid').on('rowdoubleclick', function (event) 
     	      		{ 
     	  	  var rowindex1=event.args.rowindex;
     	      	 document.getElementById("doc_no").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
     	         document.getElementById("voc_no").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "voc_no");
     	         document.getElementById("hidtype").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "type");
     	         document.getElementById("fleet_no").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "fleet_no");
     	         document.getElementById("cldocno").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
     	         document.getElementById("drid").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "drid");
     	         document.getElementById("agmtno").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "agmtno");
     	        document.getElementById("hidbrhid").value=$('#drvupdategrid').jqxGrid('getcellvalue', rowindex1, "brhid");
            	    });	 
                  }); 
				       
                       
    </script>
    <div id="drvupdategrid"></div>