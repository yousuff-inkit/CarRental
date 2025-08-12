<%@page import="com.dashboard.workshop.dynamicloading.ClsDynamicloadingDAO" %>     
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
 <% ClsDynamicloadingDAO sd=new ClsDynamicloadingDAO(); %>       
 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); 
  String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); 
  String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
  String title =request.getParameter("formname")==null?"":request.getParameter("formname").toString();
  String formname = request.getParameter("name")==null?"":request.getParameter("name");%>
  <style>
        .columnStyle {
            background-color: rgba(254, 173, 117, 255);
        }

        .columnStyleSelected {
            background-color: rgba(234, 153, 87, 255);
        }

        .rowStyle {
            background-color: rgba(187, 232, 227, 255);
        }

        .rowStyleSelected {
            background-color: rgba(167, 212, 207, 255);
        }

        .cellStyle {
            background-color: rgba(255, 255, 255, 255);            
        }
       
        .cellStyleSelected {
            background-color: rgba(239, 249, 136, 255);
            color: rebeccapurple;
        }
	   .jqx-pivotgrid{
	        background-color: #f9f9f9;
	   }
	   .jqx-pivotgrid-item {
	   		font-size:10px;
	   }
	   .jqx-grid-cell-normal{
	   		font-size:10px;
	   }
    </style>
 
 <script type="text/javascript">
         var data;   
	     var formname = '<%=formname%>';  
	     var id = '<%=formname%>';  
	     $(document).ready(function () {
	    	
	    	 data= '<%= sd.loadGridData(session,id,fromdate,todate,title)%>';
	    
	  		
	    	 var titlename = $("#formname").val();
	    	 if(titlename!=""){
	    		 formname = titlename;  
	    	 }
	  		
	    	 console.log("logdetaillssss--"+getDatafields(formname));
	    	 var dataitems = getDatafields(formname).split('####');
	    	
	    	
	    	 /* var dataitems0=dataitems[0].replace(/"/g, "'");
		    	console.log(dataitems0);
		    	 var dataitems1=dataitems[1].replace(/"/g, "'"); */
		    	 
		    	 var dataitems0=JSON.parse(dataitems[0]);
			    	console.log("array-----"+dataitems0);
			    	 var dataitems1=JSON.parse(dataitems[1]);
	    	 console.log(dataitems1);
	    	 
	    	
	    	 var rendererstring=function (aggregates){
           	var value=aggregates['sum'];
           	if(typeof(value) == "undefined"){
           		value=0.00;
           	}
           	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
           }
    	
        
        
 		// prepare the data
         var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:dataitems0,  
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
            }
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
           
            $("#jqxFleetGrid").jqxGrid(
            {
                width: '99%',
                height: 530,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showfilterrow: true,
                columnsresize: true,
                showaggregates: true,
             	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25, 
             	enabletooltips:true,
                selectionmode: 'singlerow',
                editable: false,
				pagermode: 'default',
                localization: {thousandsSeparator: ""},
              

                  columns:dataitems1 ,
                	  
                  
	              
            });
           
       
            
            $("#overlay, #PleaseWait").hide();
 	});
 	
    </script>
    <div id="jqxFleetGrid"></div>


