<%
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String brhid=request.getParameter("brhid")==null?"":request.getParameter("brhid");
%>
<style>
	.yellowClass{
		background-color:#FDFF79;
	}
	.greenClass{
		background-color:#79FFA0;
	}
	.blueClass{
		background-color:#79B6FF;
	}
	.redClass{
		background-color:#FF8579;
	}
	.violetClass{
		background-color:#ebdef0;
	}
</style>
<script type="text/javascript">
var id='<%=id%>';
var brhid='<%=brhid%>';
var gridurl='getRiderMgmtData.jsp?brhid='+brhid+'&id='+id;

	$(document).ready(function(){
        
        var source =
        {
            datatype: "json",
            datafields: [
                      	{name : 'branchname' , type: 'string'},
                      	{name : 'brhid' , type: 'string'},
                      	{name : 'empid',type:'string'},
                      	{name : 'saldocno',type:'string'},
 						{name : 'empname', type: 'string'},
 						{name : 'empdocno', type: 'string'},
 						{name : 'empdesig', type:'date'},
 						{name : 'empmobile',type:'string'},
 						{name : 'assignedcldocno',type:'string'},
                      	{name : 'assignedrefname', type: 'string'  },
                      	{name : 'assignedfleetno',type:'string'},
                      	{name : 'assignedflname',type:'string'},
                      	{name : 'clientacno',type:'int'},
                      	{name : 'curstatus',type:'string'},
                      	{name : 'empstatus',type:'string'},
                      	{name : 'movclstatus',type:'int'},
                      	{name : 'nrmdocno',type:'int'},
                      	{name : 'riderdocno',type:'int'},
                      	
             ],
             url: gridurl,
            
            
            pager: function (pagenum, pagesize, oldpagenum) {
                // callback called when a page or page size is changed.
            }
        };
        $("#riderGrid").on("bindingcomplete", function (event) {
        
        });
        
        var cellclassname = function (row, column, value, data) {
        	if(data.saldocno==null || data.saldocno=="" || data.saldocno=="undefined" || typeof(data.saldocno)=="undefined"){
        		return "redClass";
        	}
        	else if(data.clientacno>0){
        		return "violetClass";
        	}
        	else if(data.nrmdocno>0 && data.movclstatus==0){
        		return "greenClass";
        	}
        	
        };
        
        var dataAdapter = new $.jqx.dataAdapter(source,
        		 {
            		loadError: function (xhr, status, error) {
                    alert(error);    
                    }
	            }		
        );



        $("#riderGrid").jqxGrid(
                {
                	width: '100%',
                    height: 500,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    enabletooltips: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    columnsresize: true,
                    //Add row method
                    columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '4%',cellclassname: cellclassname,cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },      
    					{ text: 'Branch',datafield: 'branchname', width: '7%',cellclassname: cellclassname},
    					{ text: 'Branch Id',datafield: 'brhid', width: '7%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Emp Doc #',datafield: 'empdocno', width: '5%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Sal Doc #',datafield: 'saldocno', width: '5%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Emp.Id',datafield: 'empid', width: '5%',cellclassname: cellclassname},
    					{ text: 'Emp.Name', datafield: 'empname', width: '20%',cellclassname: cellclassname,hidden:false},
    					{ text: 'Emp.Designation', datafield: 'empdesig', width: '12%',cellclassname: cellclassname,hidden:false},
    					{ text: 'Emp.Mobile',datafield: 'empmobile', width: '7%',cellclassname: cellclassname},
    					{ text: 'Assigned Cldocno',datafield: 'assignedcldocno', width: '12%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Assigned Client Acno',datafield: 'clientacno', width: '12%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Assigned Client',datafield: 'assignedrefname', width: '17%',cellclassname: cellclassname},
    					{ text: 'Assigned Fleet #', datafield: 'assignedfleetno', width: '6%',cellclassname: cellclassname},
    					{ text: 'Assigned Fleet Name',datafield: 'assignedflname' ,cellclassname: cellclassname,width:'15%'},
    					{ text: 'Current Status', datafield: 'curstatus', width: '7%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Employee Status', datafield: 'empstatus', width: '7%',cellclassname: cellclassname},
    					{ text: 'Movement Status', datafield: 'movclstatus', width: '7%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Movement Doc No', datafield: 'nrmdocno', width: '7%',cellclassname: cellclassname,hidden:true},
    					{ text: 'Rider Log Doc No', datafield: 'riderdocno', width: '7%',cellclassname: cellclassname,hidden:true}
    	              ]
                });
				
				$('#riderGrid').on('rowdoubleclick', function (event) 
				{ 
				    var args = event.args;
				    // row's bound index.
				    var boundIndex = event.args.rowindex;
				    // row's visible index.
				    var visibleIndex = event.args.visibleindex;
				    // right click.
				    var rightclick = event.args.rightclick; 
				    // original event.
				    var ev = event.args.originalEvent;
				    
				 	$('#rowindex').val(boundIndex);
				 	var empdocno=$('#riderGrid').jqxGrid('getcellvalue',boundIndex,'empdocno');
				 	$('#empdocno').val(empdocno);
				 	$('.empid').text('');
				 	$('.empid').text($('#riderGrid').jqxGrid('getcellvalue',boundIndex,'empid'));
				 	$('.textpanel p').text($('#riderGrid').jqxGrid('getcellvalue',boundIndex,'empname'));
				 	getComments();
			       
				});
	});
	
</script>
<div id="riderGrid"></div>