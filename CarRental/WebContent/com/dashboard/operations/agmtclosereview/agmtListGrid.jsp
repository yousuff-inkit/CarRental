<%@ page import="com.dashboard.operations.agmtclosereview.*"  %>
<%
	String branch = request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").trim();
String todate = request.getParameter("todate")==null?"":request.getParameter("todate").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
ClsAgmtCloseReviewDAO dao=new ClsAgmtCloseReviewDAO();
%> 
 
<style type="text/css">
    .redClass
    {
        background-color: #FFEBEB;
    }
    
       
    .whiteClass
    {
        background-color: #FFF;
    }
    
</style>
 
 
<script type="text/javascript">
	var id='<%=id%>';
	var agmtdata=[];
	if(id=="1"){
		 agmtdata='<%=dao.getAgmtData(branch,fromdate,todate,id)%>';
	}
	$(document).ready(function () { 
    	var source = 
            {
                datatype: "json",
                datafields: [
                	{name : 'slno',type:'number'},
					{name : 'doc_no', type: 'number'},
     				{name : 'voc_no', type: 'String'},
     				{name : 'fleet_no', type: 'String'}, 
     				{name : 'regdetails',type:'string'},
     				{name : 'flname', type: 'String'}, 
     				{name : 'cldocno', type: 'String'  },
     				{name : 'refname', type: 'String'  },
     				{name : 'agmttype', type: 'String'  },
     				{name : 'agmtbranch', type: 'String'  },
     				{name : 'closedate', type: 'date'  },
     				{name : 'indate',type:'date'},
     				{name : 'intime',type:'string'},
     				{name : 'inkm',type:'number'},
     				{name : 'infuel',type:'string'},
     				{name : 'strinfuel',type:'string'},
     				
     			],
                localdata: agmtdata,
                          	       
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            var cellclassname = function (row, column, value, data) {
               if (data.agmttype == 'RAG') {
                	return "redClass";
                } 
                
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }
            );
            $("#agmtListGrid").jqxGrid(
            { 
            	
            	
            	width: '100%',
                height: 300,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                selectionmode: 'singlerow',
                pagermode: 'default',
                editable:false,
                
     					
			         columns: [
			        	 	{ text: 'SL#', datafield: 'slno', width: '4%' ,cellclassname: cellclassname },
			        	 	{ text: 'Type', datafield: 'agmttype', width: '5%' ,cellclassname: cellclassname},
			        	 	{ text: 'Agmt #', datafield: 'doc_no', width: '6%' ,cellclassname: cellclassname,hidden:true },
							{ text: 'Agmt #', datafield: 'voc_no', width: '6%' ,cellclassname: cellclassname},
							{ text: 'Agmt Branch', datafield: 'agmtbranch', width: '10%',cellclassname: cellclassname },
							{ text: 'Close Date', datafield: 'closedate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							{ text: 'Fleet', datafield: 'fleet_no', width: '5%',cellclassname: cellclassname },
							{ text: 'Fleet Name', datafield: 'flname', width: '17%',cellclassname: cellclassname },
							{ text: 'Reg NO', datafield: 'regdetails', width: '8%',cellclassname: cellclassname },
							{ text: 'Client Name', datafield: 'refname', width: '18%',cellclassname: cellclassname },
							{ text: 'In Date', datafield: 'indate', width: '6%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
							{ text: 'In Time', datafield: 'intime', width: '5%',cellclassname: cellclassname },
							{ text: 'In Km', datafield: 'inkm', width: '5%',cellclassname: cellclassname },
							{ text: 'In Fuel', datafield: 'infuel', width: '5%',cellclassname: cellclassname ,hidden:true},
							{ text: 'In Fuel', datafield: 'strinfuel', width: '5%',cellclassname: cellclassname},
							
					]
            });
            $("#overlay, #PleaseWait").hide(); 
       
            $('#agmtListGrid').on('rowdoubleclick', function (event) 
            		{ 
            		    var args = event.args;
            		    // row's bound index.
            		    var boundIndex = args.rowindex;
            		    // row's visible index.
            		    var visibleIndex = args.visibleindex;
            		    // right click.
            		    var rightclick = args.rightclick; 
            		    // original event.
            		    var ev = args.originalEvent;
            		    
            		    var agmtdocno=$('#agmtListGrid').jqxGrid('getcellvalue',boundIndex,'doc_no');
            		    var agmttype=$('#agmtListGrid').jqxGrid('getcellvalue',boundIndex,'agmttype');
            		    
            		    $("#overlay, #PleaseWait").show(); 
            		    $('#invoicelist').load('invoiceGrid.jsp?agmtdocno='+agmtdocno+'&agmttype='+agmttype+'&id=1');
            		    
            		});
        });
        
        
				       
                       
    </script>
    <div id="agmtListGrid"></div>