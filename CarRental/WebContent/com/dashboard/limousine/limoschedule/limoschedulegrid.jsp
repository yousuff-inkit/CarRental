<%@page import="com.dashboard.limousine.limoschedule.ClsLimoScheduleDAO" %>
<% ClsLimoScheduleDAO dao=new ClsLimoScheduleDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<style type="text/css">
	.ReservationClass{
		background-color:#FFEBEB;	
	}
	.JobAssignedClass{
		background-color:#e8d4b4;
	}
	.DriverAcceptedClass{
		background-color:#e8d4b4;
	}
	.ChangeinTimeClass{
		background-color:#c06c84;
	}
	.WaitingforguestClass{
		background-color:#F6F874;
	}
	.TripStartedClass{
		background-color:#B5E3AE;
	}
	.TripEndedClass{
		background-color:#CAF0F8;
		/* color:#fff;' */
	}
	.NoshowClass{
		background-color:#AEAF9D;
	}
	.cancelClass{
		background-color:#DBA67B;
	}
    .redClass
    {
        background-color: #EC7063;   
    }
    
    .blueClass
    {
        background-color: #42cef4;
    }
    .yellowClass
    {
        background-color: #FFFFD1;
    }
     .greyClass
    {
        background-color: #BDC3C7;
    }
    .NoVendorAmtClass{
    	background-color:#E88375;
    }
</style>
<script type="text/javascript">
var data,dataexcel;                   
	data='<%=dao.getSearchData(branch,id,fromdate,todate)%>';
$(document).ready(function () {    
        var source =
           {
           datatype: "json",
           datafields: [
                    	{name : 'refno',type:'number'},
                    	{name : 'vocno',type:'number'},
                    	{name : 'locationtype',type:'string'},
                     	{name : 'airport',type:'string'},
                     	{name : 'flightno',type:'string'}, 
                      	{name : 'hotel',type:'string'},  
                      	{name : 'roomno',type:'string'},
                      	{name : 'description',type:'string'},
                       	{name : 'docno' , type: 'string' },
                       	{name : 'date',type:'string'},
                       	{name : 'guestno',type:'string'},       
                       	{name : 'hidchknewguest' , type:'string'},
                       	{name : 'refname',type:'string'},
                       	{name : 'cldocno',type:'number'},
                       	{name : 'per_mob',type:'string'},
                       	{name : 'dlno',type:'string'},
                       	{name : 'guest',type:'string'},
                       	{name : 'guestcontactno',type:'string'},
     				   ],
					localdata:data,   
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        
			var cellclassname = function (row, column, value, data) {
          
       };
          var dataAdapter = new $.jqx.dataAdapter(source,
           		 {
               		loadError: function (xhr, status, error) {
	                 ///alert(error);    
	              }
			            
		        });

            $("#jqxLimoScheduleGrid").jqxGrid(
            {
               width: '100%',
               height: 520,
               source: dataAdapter,
               columnsresize: true,
               editable:false,  
               enabletooltips:true, 
               sortable:true,
               showfilterrow:true,
               filterable:true,       
               selectionmode: 'singlerow',                         
               columns: [
							{ text: 'SL#', sortable: false, filterable: false, editable: false,
							    groupable: false, draggable: false, resizable: false,
							    datafield: 'sl', columntype: 'number', width: '3%',
							    cellsrenderer: function (row, column, value) {
							        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
							    }  
							},  
							{ text: 'Date',datafield:'date',width:'5%',cellsformat:'dd.MM.yyyy',cellclassname:cellclassname},
							{ text: 'Doc No',datafield:'docno',width:'8%',cellclassname:cellclassname},
							{ text: 'Voc No',datafield:'vocno',width:'8%',cellclassname:cellclassname},
							{ text: 'Ref No',datafield:'refno',width:'3%',cellclassname:cellclassname},
							{ text: 'Location Type',datafield:'locationtype',width:'10%',cellclassname:cellclassname},
							{ text: 'Airport',datafield:'airport',width:'8%',cellclassname:cellclassname},
							{ text: 'Flight No',datafield:'flightno',width:'8%',cellclassname:cellclassname}, 
							{ text: 'Hotel',datafield:'hotel',width:'8%',cellclassname:cellclassname},  
							{ text: 'Room No',datafield:'roomno',width:'2%',cellclassname:cellclassname},
							{ text: 'Description',datafield:'description',width:'2%',cellclassname:cellclassname,hidden:true},
							{ text: 'Guest No',datafield:'guestno',width:'8%',cellclassname:cellclassname},
							{ text: 'New Guest',datafield: 'hidchknewguest',width:'8%',cellclassname:cellclassname},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'8%',cellclassname:cellclassname},
							{ text: 'Client',datafield:'refname',width:'8%',cellclassname:cellclassname},
							{ text: 'Mobile No',  datafield: 'per_mob',width:'6%',cellclassname:cellclassname},
							{ text: 'Guest', datafield: 'guest',width:'4%',hidden:true},
							{ text: 'Guest Contact No',  datafield: 'guestcontactno',width:'6%',cellclassname:cellclassname},
                            { text: 'Cl Docno', datafield: 'cldocno',width:'4%',hidden:true},
							{ text: 'brhid',datafield:'brhid',width:'4%',hidden:true}
         	              ]   
            });  
    	    $("#overlay, #PleaseWait").hide();    
            $("#jqxLimoScheduleGrid").on("celldoubleclick", function (event)      
            		{
            		    // event arguments.
            		    var args = event.args;
            		    // row's bound index.
            		    var rowBoundIndex = event.args.rowindex;
            		          
            		    $("#cldocno").val($('#jqxLimoScheduleGrid').jqxGrid('getcellvalue',rowBoundIndex,'cldocno'));
            		    $("#selectedrow").val($('#jqxLimoScheduleGrid').jqxGrid('getcellvalue',rowBoundIndex,'docno'));
            		   
            		});                          
            });    
 </script>
<div id="jqxLimoScheduleGrid"></div>