<%@page import="com.controlcentre.masters.vehiclemaster.vehtype.*" %>
<%ClsVehTypeDAO dao=new ClsVehTypeDAO();
String id=request.getParameter("chk")==null?"":request.getParameter("chk");
String rdocno=request.getParameter("rdocno")==null?"":request.getParameter("rdocno");
%>
<script type="text/javascript">
	var id='<%=id%>';
	var searchdata=[];
	var deleted = "";
	if(id=="1"){
		searchdata='<%=dao.getVehTypeDataDrid(rdocno,id)%>';
	}
    
    $(document).ready(function () { 	
   		var source =
        {
        	datatype: "json",
            datafields: [
            	{name : 'rowno' , type: 'number' },
     			{name : 'name', type: 'String'  },
                {name : 'tyre', type: 'number'  },
            ],
            localdata: searchdata,
            
            pager: function (pagenum, pagesize, oldpagenum) {
            	// callback called when a page or page size is changed.
            }
        };
        var dataAdapter = new $.jqx.dataAdapter(source,
        	{
            	loadError: function (xhr, status, error) {
	            	// alert(error);    
	        	}
			}		
        );
        $("#vehTypeGridDiv").jqxGrid(
        {
        	width: '50%',
            height: 300,
            source: dataAdapter,
            columnsresize: true,
            filterable:true,
            editable:true,
            showfilterrow: true,
            altRows: true,
            sortable: true,
            selectionmode: 'singlerow',
            pagermode: 'default',
            sortable: true,
            columns: [
            	{ text: 'SL#', sortable: false, filterable: false, editable: false,
				    groupable: false, draggable: false, resizable: false,
				    datafield: 'sl', columntype: 'number', width: '10%',
				    cellsrenderer: function (row, column, value) {
				        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				    }  
				  },
				{ text: 'Name', datafield: 'name', width: '45%' },
				{ text: 'Tyre', datafield: 'tyre', width: '45%'}
	        ]
        });
		
        if($("#mode").val()=="view") {
        	 $("#vehTypeGridDiv").jqxGrid({ disabled: true});
        }
        
        $("#vehTypeGridDiv").on('cellvaluechanged', function (event) {
        	 var args = event.args;
        	 var row = args.rowindex;
        	 var column = args.datafield;  
        	        var previousValue = $("#vehTypeGridDiv").jqxGrid('getcellvalue',row, 'axle');
        	 if (column === 'axle') {
        	        if (previousValue !== null || previousValue !== '') {
        	            // Enable editing in the next column
        	            $("#vehTypeGridDiv").jqxGrid('setcolumnproperty','tyre', 'editable', true);
        	           
        	        } else {
        	            // Disable editing in the next column
        	            $("#vehTypeGridDiv").jqxGrid('setcolumnproperty','tyre', 'editable', false);
        	        }
        	    }
        	 if(column==='tyre' && (previousValue !== null && previousValue !== '')){
           		 $("#vehTypeGridDiv").jqxGrid('addrow', null, {});
            }
        }); 
        
        $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
        // create context menu
           var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
           $("#vehTypeGridDiv").on('contextmenu', function () {
               return false;
           });
           
           $("#Menu").on('itemclick', function (event) {
        	   var args = event.args;
               var rowindex = $("#vehTypeGridDiv").jqxGrid('getselectedrowindex');
               var docno =  $('#vehTypeGridDiv').jqxGrid('getcellvalue', rowindex, "rowno"); 
               if ($.trim($(args).text()) == "Delete Selected Row") {
                 if(docno>0){  
                	deleted+=docno+",";
                 	var rowid = $("#vehTypeGridDiv").jqxGrid('getrowid', rowindex);
                     $("#vehTypeGridDiv").jqxGrid('deleterow', rowid);
                 }else{
                 	var rowid = $("#vehTypeGridDiv").jqxGrid('getrowid', rowindex);
                     $("#vehTypeGridDiv").jqxGrid('deleterow', rowid);
                 }
               }   
           });
           
           $("#vehTypeGridDiv").on('rowclick', function (event) {
               if (event.args.rightclick) {
    		   if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
                   $("#vehTypeGridDiv").jqxGrid('selectrow', event.args.rowindex);
                   var scrollTop = $(window).scrollTop();
                   var scrollLeft = $(window).scrollLeft();
                   contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                   return false;
               }
    		   }
           });
        
    });
</script>
<div id='jqxWidget'>
<div id="vehTypeGridDiv"></div>
<div id="popupWindow">
<div id='Menu'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>