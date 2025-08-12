<%@ page import="com.dashboard.vehicle.vehmgmt.*" %>
<%
ClsVehMgmtDAO dao=new ClsVehMgmtDAO();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
String brhid= request.getParameter("brhid")==null?"":request.getParameter("brhid");
%> 
<style type="text/css">
	.insurExpiryClass
    {
       background-color: #F99B7D; 
    }
    .regExpiryClass
    {
       background-color: #E76161; 
    }
</style>
<script type="text/javascript">

$(document).ready(function () {
   	var id='<%=id%>';
   	var brhid='<%=brhid%>';
	var vehurl='getVehData.jsp?id='+id+'&brhid='+brhid;
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
        	            {name : 'doc_no' , type: 'string' },
                  		{name : 'branchname' , type: 'string' },
                  		{name : 'brchgrid' , type: 'string' },
                  		{name : 'groupid' , type: 'string' },
						{name : 'loc_name', type: 'string'  },
						/* {name : 'branch', type: 'int'    }, */
						{name : 'brand_name', type: 'string'  },
						{name : 'fleet_no', type: 'string'  },
						{name : 'flname', type: 'string'  },
						{name : 'yom', type: 'string'  },
						{name : 'color', type: 'string'  },
						{name : 'reg_no', type: 'string'  },
						{name : 'vehiclenum', type: 'string'  },
						{name : 'authority',type:'string'},
						{name : 'platecode',type:'string'},
						{name : 'cur_km', type: 'int'  },
						{name : 'srvc_km', type: 'int'  },
						{name : 'c_fuel', type: 'string'  },
						{name : 'gname', type: 'string'  },
						{name : 'vrent', type: 'string'  },
						{name : 'renttype', type: 'string'  },
						{name : 'days', type: 'string'  },
						{name : 'empid', type: 'string'  },
						{name : 'empname', type: 'string'  },
						{name : 'grname', type: 'string'  },
						{name : 'dates', type: 'date'  },
						{name : 'movdocno',type:'number'},
						{name : 'outtimediff',type:'number'},
						{name : 'movrdocno',type:'number'},
						{name : 'movrdtype',type:'string'},
						{name : 'ch_no',type:'string'},
						{name : 'chkinsurexpiry',type:'number'},
						{name : 'chkregexpiry',type:'number'},
						{name : 'tran_code',type:'string'},
						{name : 'din',type:'date'},
						{name : 'tin',type:'string'},
						{name : 'kmin',type:'string'},
						{name : 'movtrancode',type:'string'},
						{name : 'fstatus',type:'string'},
						{name : 'status',type:'string'},
						{name : 'insexpdate', type: 'date'  },
						{name : 'regexpdate', type: 'date'  }

						],
				    url: vehurl,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    var cellclassname =  function (row, column, value, data) {
		if(data.chkinsurexpiry==1 || data.chkinsurexpiry=="1"){
			return "insurExpiryClass";
		}
		else if(data.chkregexpiry==1 || data.chkregexpiry=="1"){
			return "regExpiryClass";
		}
    }
    	        
    
    $("#vehGrid").jqxGrid(
    {
        width: '100%',
        height: 515,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
        filterable: true,
	    showfilterrow: true,
	    columnsresize:true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        showfilterrow: true,

        columns: [
                  
                       { text: 'SL#', sortable: false, filterable: false, editable: false, 
                       editable: false, draggable: false, resizable: false,
                         datafield: 'sl', columntype: 'number', width: '3%',cellclassname: cellclassname,
                         cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                          }  
                          },
                        { text: 'Doc No', datafield: 'doc_no',cellclassname: cellclassname ,  width: '4%' },
						{ text: 'Avail. Br', datafield: 'branchname',cellclassname: cellclassname ,  width: '4%'   },
						{ text: 'Avail. Br Id', datafield: 'brchgrid',cellclassname: cellclassname,  width: '8%'   ,hidden:true},
						{ text: 'Group Id', datafield: 'groupid',cellclassname: cellclassname,  width: '8%'   ,hidden:true},
						{ text: 'Location', datafield: 'loc_name' ,cellclassname: cellclassname , width: '10%' },
						{ text: 'Group', datafield: 'gname' ,cellclassname: cellclassname, width: '4%'  },
						{ text: 'Fleet', datafield: 'fleet_no' ,cellclassname: cellclassname , width: '4%'  },
						{ text: 'Fleet Name', datafield: 'flname' ,cellclassname: cellclassname, width: '20%'  },
						{ text: 'Type', datafield: 'empid',cellclassname: cellclassname,hidden:true , width: '4%'  },
						{ text: 'User Name', datafield: 'empname' ,cellclassname: cellclassname , width: '12%',hidden:true  },
						{ text: 'Garage', datafield: 'grname' ,cellclassname: cellclassname,hidden:true , width: '10%'  },
						{ text: 'YOM', datafield: 'yom' ,cellclassname: cellclassname , width: '3%' },
						{ text: 'Color', datafield: 'color' ,cellclassname: cellclassname , width: '4%'   },
						{ text: 'Reg No', datafield: 'reg_no' ,cellclassname: cellclassname , width: '5%'   },
						{ text: 'Vehicle Number', datafield: 'vehiclenum' ,cellclassname: cellclassname, width: '6%'},
						{ text: 'Authority', datafield: 'authority' ,cellclassname: cellclassname , width: '6%'    },
						{ text: 'Plate Code', datafield: 'platecode' ,cellclassname: cellclassname , width: '4%'   },
						{ text: 'Last TRN Date', datafield: 'dates' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy', width: '6%'   },

						{ text: 'Cur. KM', datafield: 'cur_km' ,cellclassname: cellclassname, width: '5%'   },
						{ text: 'Due Serv.', datafield: 'srvc_km' ,cellclassname: cellclassname , width: '5%' },
						{ text: 'Fuel  ', datafield: 'c_fuel' ,cellclassname: cellclassname , width: '6%'   },
						{ text: 'Rent Type', datafield: 'renttype' ,cellclassname: cellclassname , width: '5%'   },
						{ text: 'Chassis Number', datafield: 'ch_no' ,cellclassname: cellclassname, width: '10%'},
						{ text: 'days', datafield: 'days', width: '10%' ,hidden:true},
						{ text: 'Mov Doc No', datafield: 'movdocno',hidden:true},
						{ text: 'Out Time Diff', datafield: 'outtimediff',hidden:true},
						{ text: 'Mov Rdocno', datafield: 'movrdocno',hidden:true},
						{ text: 'Mov Rdtype', datafield: 'movrdtype',hidden:true},
						{ text: 'Trancode', datafield: 'tran_code',hidden:true},
						{ text: 'Last.In.Date', datafield: 'din',hidden:true,cellsformat:'dd.MM.yyyy'},
						{ text: 'Last.In.Time', datafield: 'tin',hidden:true},
						{ text: 'Last.In.Trancode', datafield: 'movtrancode',hidden:true},
						{ text: 'F Status', datafield: 'fstatus',hidden:true},
						{ text: 'Status', datafield: 'status',hidden:true},
						{ text: 'Ins E.Date', datafield: 'insexpdate' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy', width: '6%'   },
						{ text: 'Reg E.Date', datafield: 'regexpdate' ,cellclassname: cellclassname,cellsformat:'dd.MM.yyyy', width: '6%'  },
						{ text: 'Chk.Insur.Expry', datafield: 'chkinsurexpiry',hidden:true},
						{ text: 'Chk.Reg.Expiry', datafield: 'chkregexpiry',hidden:true},
						
						]
    
    });
 	
    $('#vehGrid').on('rowdoubleclick', function (event) 
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
    
    			$('#rowindex').val(boundIndex);
    			
    			var fleetdet="";
    			var fleetname=$('#vehGrid').jqxGrid('getcellvalue',boundIndex,'flname');
    			var vehnum=$('#vehGrid').jqxGrid('getcellvalue',boundIndex,'vehiclenum');
    				//alert(fleetname+" "+vehnum)
    			$('.fleetdet').text(fleetname+" "+vehnum);
    				
    			document.getElementById("fleetdets").value=fleetname+" "+vehnum;
    			document.getElementById("fleetshow").innerText=""+fleetname+" "+vehnum;
    		 	
    			  });
});

$(".page-loader").hide();

</script>
<div id="vehGrid"></div>
<input type="hidden" name="rightclickrow" id="rightclickrow">
<input type="hidden" name="rowindex" id="rowindex">
<input type="hidden" name="fleetdets" id="fleetdets">
