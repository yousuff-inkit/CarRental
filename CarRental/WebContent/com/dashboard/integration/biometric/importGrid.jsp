
 <%
  
	String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate");
  	String todate = request.getParameter("todate")==null?"0":request.getParameter("todate");
  	String brhid = request.getParameter("brhid")==null?"":request.getParameter("brhid");
  	String id = request.getParameter("id")==null?"":request.getParameter("id");
  	System.out.println("fromdate ="+fromdate+"todate = "+todate);
 %> 
           	  
 <style type="text/css">
        .redClass
        {
            background:#ec7063;
        }
        .greenClass
        {
            background: #a2d9ce;
        }
       </style>
<script type="text/javascript">
var id='<%=id%>';
var fromdate='<%=fromdate%>';
var todate='<%=todate%>';
var brhid='<%=brhid%>';
var importurl='getImportData.jsp?fromdate='+fromdate+'&todate='+todate+'&brhid='+brhid+'&id='+id;

$(document).ready(function () {
 
	var filterApplied=false;
    var source =
    {
        datatype: "json",
        datafields: [  
                        {name : 'doc_no', type: 'int'},
                        
                        {name : 'empid', type: 'string'  },
						{name : 'checkindate', type: 'date'  },
						{name : 'checkoutdate', type: 'date'  },
						{name : 'checkintime', type: 'date'  },
						{name : 'checkouttime', type: 'date'},
						{name : 'empdocno', type: 'String'  },
						{name : 'empname', type: 'string'  },
						{name : 'btnupdate',type:'string'},
						{name : 'attstatus',type:'int'},
						
					],
		url: importurl,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    $("#importGrid").on("bindingcomplete", function (event) {
    	var counter=0;
    	var rows=$("#importGrid").jqxGrid('getrows');
    	for(var i=0;i<rows.length;i++){
    		var checkoutdate=$('#importGrid').jqxGrid('getcellvalue',i,'checkoutdate');
    		if(checkoutdate==null || typeof(checkoutdate)=="undefined" || checkoutdate=="" ){
            	counter++;
    		};	
    	}
    	
    	$('#btnpendingcheckout').closest('.btn-group').find('.badge-notify').text(counter);
    	
    	$('#btnpendingcheckout').on('click', function () {
            // Clear previous filters
            if(filterApplied){
            	$("#importGrid").jqxGrid('clearfilters');	
            }
            else{
            	// Create a filter for rows without checkoutdate
                var filtergroup = new $.jqx.filter();
                var filter_or_operator = 1;
                var filtervalue = null; // Filter for null value in checkoutdate
                var filtercondition = 'NULL';
                var filter = filtergroup.createfilter('datefilter', filtervalue, filtercondition);

                filtergroup.addfilter(filter_or_operator, filter);

                // Apply the filter
                $("#importGrid").jqxGrid('addfilter', 'checkoutdate', filtergroup);
                $("#importGrid").jqxGrid('applyfilters');
                
                filterApplied=true;
            }

        });
    });                       

    var cellclassname = function (row, column, value, data) {
    	if(data.checkoutdate==null || typeof(data.checkoutdate)=="undefined" || data.checkoutdate=="" ){
        	return "redClass";
		}
    	else if(data.attstatus==1){
        	return "greenClass";
		};
	};
	
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    

    
    $("#importGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        filterable: true,
        sortable:true,
        selectionmode: 'checkbox',
        pagermode: 'default',
        editable:true,
        columnsresize: true,
        columns: [   
                  
                  { text: 'SL#', sortable: false, filterable: false, editable: false,cellclassname: cellclassname,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, 
					
              	 { text: 'Doc No', datafield: 'doc_no',  width: '11%' ,cellclassname: cellclassname}, 
              	 { text: 'Emp.#', datafield: 'empid',  width: '11%',cellclassname: cellclassname},
              	 { text: 'Emp.Name', datafield: 'empname' ,cellclassname: cellclassname}, 
				{ text: 'Check.In Date', datafield: 'checkindate', width: '7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname},
				{ text: 'Check.In Time', datafield: 'checkintime', width: '5%',cellclassname: cellclassname},
				{ text: 'Check.Out Date', datafield: 'checkoutdate', width: '7%',cellsformat:'dd.MM.yyyy',cellclassname: cellclassname,columntype:'datetimeinput'},
				{ text: 'Check.Out Time', datafield: 'checkouttime', width: '5%',cellclassname: cellclassname,columntype:'datetimeinput',cellsformat:'HH:mm',
					createEditor:function(row,cellvalue,editor){
						editor.jqxDateTimeInput({'showCalendarButton':false});
					}
				},
				{ text:'Action',datafield:'btnupdate',width:'5%',cellclassname:cellclassname,columntype:'button',cellsrenderer:function(){return "Update"}},
				{ text: 'Emp Doc No', datafield: 'empdocno', width: '7%',hidden:true},
				{ text: 'Att.Status', datafield: 'attstatus', width: '7%',hidden:true},
					 
					]
   
    });
    
    
    $("#importGrid").on("cellclick", function (event){
	    // event arguments.
	    var args = event.args;
	    // row's bound index.
	    var rowBoundIndex = args.rowindex;
	    // row's visible index.
	    var rowVisibleIndex = args.visibleindex;
	    // right click.
	    var rightclick = args.rightclick; 
	    // original event.
	    var ev = args.originalEvent;
	    // column index.
	    var columnindex = args.columnindex;
	    // column data field.
	    var dataField = args.datafield;
	    // cell value
	    var value = args.value;
    
	    if(dataField=="btnupdate"){
	    	var checkindate=$('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkindate');
	    	var checkoutdate=$('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkoutdate');
	    	var checkouttime=$('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkouttime');
	    	var checkintime=$('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkintime');
	    	
	    	if(checkoutdate==null || checkoutdate=="undefined" || checkoutdate=="" || typeof(checkoutdate)=="undefined"){
	    		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Checkout date mandatory'
				});
	    		return false;
	    	}
	    	
	    	if(checkouttime==null || checkouttime=="undefined" || checkouttime=="" || typeof(checkouttime)=="undefined"){
	    		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Checkout time mandatory'
				});
	    		return false;
	    	}	
	    
	    	checkindate=new Date($('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkindate'));
	    	checkoutdate=new Date($('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'checkoutdate'));
	    	
	    	checkindate.setHours(0,0,0,0);
	    	checkoutdate.setHours(0,0,0,0);
	    	if(checkoutdate<checkindate){
	    		Swal.fire({
					icon:'warning',
					title: 'Warning',
					text: 'Checkout date cannot be less than checkin date'
				});
	    		return false;
	    	}
	    	
	    	if(checkoutdate-checkindate==0){
	    		if(checkouttime.getHours()<parseInt(checkintime.split(":")[0])){
	    			Swal.fire({
						icon:'warning',
						title: 'Warning',
						text: 'Checkout time cannot be less than checkin time'
					});
		    		return false;
	    		}
	    		else if (checkouttime.getHours()==parseInt(checkintime.split(":")[0])){
	    			if(checkouttime.getMinutes()<parseInt(checkintime.split(":")[1])){
		    			Swal.fire({
							icon:'warning',
							title: 'Warning',
							text: 'Checkout time cannot be less than checkin time'
						});
			    		return false;
		    		}	
	    		}
	    	}
	    	

		    var strcheckoutdate=$('#importGrid').jqxGrid('getcelltext',rowBoundIndex,'checkoutdate');
	    	var strcheckouttime=$('#importGrid').jqxGrid('getcelltext',rowBoundIndex,'checkouttime');
	    	var docno=$('#importGrid').jqxGrid('getcellvalue',rowBoundIndex,'doc_no');
	    	updateBiometric(strcheckoutdate,strcheckouttime,docno);
	    }
    	
    	
    });    
  
});

function updateBiometric(checkoutdate,checkouttime,docno){
	$.post('updateBiometric.jsp',{'checkoutdate':checkoutdate,'checkouttime':checkouttime,'docno':docno},function(data,status){
		data=JSON.parse(data);
		if(data.errorstatus=="0"){
			Swal.fire({
				icon:'success',
				title: 'Success',
				text: 'Successfully updated'
			});
			$('#btnsubmit').trigger('click');
		}
		else{
			Swal.fire({
				icon:'warning',
				title: 'Warning',
				text: 'Not updated'
			});
			return false;
		}
	});
}
</script>
<div id="importGrid"></div>