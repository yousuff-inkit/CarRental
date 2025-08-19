<%@page import="com.dashboard.limousine.booking.ClsLimoBookingDAO" %>
<% ClsLimoBookingDAO dao=new ClsLimoBookingDAO();%>
<script type="text/javascript">
var vendorrdata='<%=dao.getVendorData()%>';  

$(document).ready(function () { 
	
       
        var source =
           {
           datatype: "json",
           datafields: [

                       	{name : 'vendorid' , type: 'number' },
                       	{name : 'vendor' , type:'string'}
     				   ],
					localdata:vendorrdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or pagse size is changed.
                }
          };
        var dataAdapter = new $.jqx.dataAdapter(source);
        // Create a jqxInput  
         
        $("#vendorSearchInput").jqxInput({ source: dataAdapter, displayMember: "vendor", valueMember: "vendorid", items: 20 ,width: '100%', height: 30});
        $("#vendorSearchInput").on('select', function (event) {      
        	  if (event.args) {
        		  
                  var item = event.args.item;                
                  if (item) {
                      for (var i = 0; i < dataAdapter.records.length; i++) {           
                          if (item.value == dataAdapter.records[i].vendorid) {   
                        	  document.getElementById("vendorid").value=dataAdapter.records[i].vendorid;
                        	  break;       
                          }
                      }
                  }
                  
                /*   if (item) {
                    //alert('value: ' + item.value + " , " + "label: " + event.args.label);
                  	document.getElementById("vendorid").value=item.value;
                  } */
              }   
            }); 
            });
            </script>
       <input type="text" id="vendorSearchInput" class="form-control"/>