<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();%>
<script type="text/javascript">
var fleetdata='<%=dao.getFleetData()%>';  

$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'fleet_no' , type: 'number' },
                       	{name : 'flname' , type:'string'}
     				   ],
					localdata:fleetdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        var dataAdapter = new $.jqx.dataAdapter(source);
        // Create a jqxInput  
         
        $("#assignfleetSearchInput").jqxInput({ source: dataAdapter, displayMember: "flname", valueMember: "fleet_no", items: 20 ,width: '100%', height: 30});
        $("#assignfleetSearchInput").on('select', function (event) {      
        	  if (event.args) {
                  var item = event.args.item;                
                  if (item) {
                	  
                	  for (var i = 0; i < dataAdapter.records.length; i++) {             
                          if (item.value == dataAdapter.records[i].fleet_no) {   
                        	  document.getElementById("fleetnos").value=dataAdapter.records[i].fleet_no;
                        	  document.getElementById("fleetnames").value=dataAdapter.records[i].flname;
                        	  break;       
                          }
                      }
                    //alert('value: ' + item.value + " , " + "label: " + event.args.label);
                  //	document.getElementById("fleetnos").value=item.value;
                  //	document.getElementById("fleetnames").value=item.value;
                  }
              }   
            }); 
            });
            </script>
       <input type="text" id="assignfleetSearchInput" class="form-control"/>