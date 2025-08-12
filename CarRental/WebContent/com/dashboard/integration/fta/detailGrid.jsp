<%
  
	String month = request.getParameter("month")==null?"0":request.getParameter("month");
  	String year = request.getParameter("year")==null?"0":request.getParameter("year");
  	String id = request.getParameter("id")==null?"0":request.getParameter("id");
%> 
           	  
 <style type="text/css">
        .greenClass
        {
            background-color: #8AEEB7;
        }
        .redClass
        {
            background-color: #F59387;
        }
       </style>
<script type="text/javascript">
var month='<%=month%>';
var year='<%=year%>';
var id='<%=id%>';
var dataurl='getGridData.jsp?month='+month+'&year='+year+'&id='+id;

$(document).ready(function () {
 
    var source =
    {
        datatype: "json",
        datafields: [  
        				{name : 'sl', type: 'number'},
                        {name : 'logdocno', type: 'number'},
                        {name : 'userid', type: 'number'  },
						{name : 'username', type: 'string'  },
						{name : 'message', type: 'String'  },
						{name : 'logtype', type: 'number'  },
						{name : 'logdate', type: 'date'}
						],
				    url: dataurl,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
    var cellclassname = function (row, column, value, data) {
        if(data.logtype==1 || data.logtype=="1" ){
        	return "greenClass"; 
        }
        else if(data.logtype==0 || data.logtype=="0" ){
        	//alert(data.amount);
        	return "redClass";
        };
	};

    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#detailGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips:true,
        columns: [   
                  
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '5%',cellclassname:cellclassname,
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
					
              	 { text: 'Entered By', datafield: 'username',  width: '15%' ,cellclassname:cellclassname}, 
              	 { text: 'Date', datafield: 'logdate',  width: '10%',cellsformat:'dd.MM.yyyy HH:mm' ,cellclassname:cellclassname}, 
           	     { text: 'Message', datafield: 'message',  width: '70%' ,cellclassname:cellclassname}				 
		]
   
    });
    
/*     dateout timeout outkm outfuel datein timeout inkm infuel */
    $("#overlay, #PleaseWait").hide();
    
  
    
  
});


</script>
<div id="detailGrid"></div>