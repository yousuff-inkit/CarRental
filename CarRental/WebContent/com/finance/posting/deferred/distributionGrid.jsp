<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.finance.posting.deferred.ClsDeferredDAO"%>
<% ClsDeferredDAO DAO= new ClsDeferredDAO(); %>
<% 
String startdate1 = request.getParameter("startdate")==null?"0":request.getParameter("startdate"); 
String enddate1 = request.getParameter("enddate")==null?"0":request.getParameter("enddate");
String cmbfrequency1 = request.getParameter("cmbfrequency")==null?"0":request.getParameter("cmbfrequency");
String amount1 = request.getParameter("amount")==null?"0":request.getParameter("amount");
String instno1 = request.getParameter("instno")==null?"0":request.getParameter("instno");
String instamt1 = request.getParameter("instamt")==null?"0":request.getParameter("instamt");
String dueafter1 = request.getParameter("dueafter")==null?"0":request.getParameter("dueafter");
String tranId = request.getParameter("tranId")==null?"0":request.getParameter("tranId");
String check = request.getParameter("check")==null?"0":request.getParameter("check");
%>

<style type="text/css">
        .disableClass{
            color: #999;
        }
</style>
<script type="text/javascript">
        
        var data3;  
        $(document).ready(function () { 
            var temp1='<%=instamt1%>';
            var temp2='<%=tranId%>';
            
            if(temp1!="0"){
            	data3 = '<%=DAO.distributionGrid(startdate1, enddate1, cmbfrequency1, amount1, instno1, instamt1, dueafter1, check) %>';
            }
            else if(parseInt(temp2)>0){
            	data3 = '<%=DAO.distributionGridReloading(session, tranId, check) %>';
            }

            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                            {name : 'sr_no', type: 'int'  },
     						{name : 'date', type: 'date'   },
     						{name : 'amount', type: 'number'  },
     						{name : 'posted', type: 'int'  },
     						{name : 'rowno', type: 'int'  }
                        ],
                		  localdata: data3, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
      
            var cellbeginedit = function (row, datafield, columntype, value) {
                var rowindexestemp = row;
                //event.args.rowindex;
                var value = $('#jqxDistributionGrid').jqxGrid('getcellvalue', rowindexestemp, "posted");	
               //alert("value"+value);
                if(value>0)
    				return false;
            }
            
            var cellclassname = function (row, column, value, data) {
                if (data.posted > 0) {
                    return "disableClass";
                };
            }; 

            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxDistributionGrid").jqxGrid(
            {
                width: '95%',
                height: 180,
                source: dataAdapter,
                editable: true,
                enabletooltips:true,
                showaggregates: true,
               	showstatusbar:true,
             	rowsheight:25,
             	statusbarheight:25,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxDistributionGrid').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxDistributionGrid').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'amount' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                       // alert(key);
                        if (key == 9) {                                                        
                            var commit = $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },   
                
                columns: [                { text: 'SL#', sortable: false, filterable: false,            
				                              groupable: false, draggable: false, resizable: false,
				                              datafield: 'sl', columntype: 'number', width: '4%',
				                              cellsrenderer: function (row, column, value) {
				                              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
				                             }  
				                          },
				        	{ text: 'Sr. No.', datafield: 'sr_no',  width: '10%', cellsalign: 'center', align: 'center', editable: false,hidden:true, cellclassname: cellclassname},
							{ text: 'Date', datafield: 'date', columntype: 'datetimeinput',editable: true, cellsformat: 'dd.MM.yyyy', width: '40%', cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Amount', datafield: 'amount', editable: true, cellsformat: 'd2', cellsalign: 'right', align: 'right', cellbeginedit: cellbeginedit, cellclassname: cellclassname, aggregates: ['sum']  },
							{ text: 'Posted', datafield: 'posted',  hidden: true, width: '10%',editable: false, cellbeginedit: cellbeginedit, cellclassname: cellclassname },
							{ text: 'Row No', datafield: 'rowno',  hidden: true, width: '10%', editable: false,cellbeginedit: cellbeginedit, cellclassname: cellclassname },
						]
            });
            
          //Add empty row
          if(temp1 == "0"){
       	   $("#jqxDistributionGrid").jqxGrid('addrow', null, {});
          } 
          
          if(temp2>0){
        	  $("#jqxDistributionGrid").jqxGrid('disabled', true);
          }
          
           var total1="";
       	   $("#jqxDistributionGrid").on('cellvaluechanged', function (event){
       		 var amount = document.getElementById("txtamount").value;
             var total=$('#jqxDistributionGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
             total1=total.sum;
             document.getElementById("txtinstamttotal").value=total1;
             
       			if((parseFloat(total1)>parseFloat(amount)) || (parseFloat(total1)<parseFloat(amount))){ 
       				document.getElementById("errormsg").innerText="Invalid Transaction,Sum of Distribution is not Valid.";
       		        $('#txtvalidation').val(1);
       		         return 0;  
       			}
       			else{
       				document.getElementById("errormsg").innerText="";
       				$('#txtvalidation').val(0);
      		         return 1;
       			}
       			
           }); 

       	 var total=$('#jqxDistributionGrid').jqxGrid('getcolumnaggregateddata', 'amount', ['sum'], true);
         document.getElementById("txtinstamttotal").value=total.sum;
        
         var rows = $("#jqxDistributionGrid").jqxGrid('getrows');
         var value = $('#jqxDistributionGrid').jqxGrid('getcellvalue', (rows.length-1), "sr_no");
         document.getElementById("txtinstnos").value=value;

        
         $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
         // create context menu  
            var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
            $("#jqxDistributionGrid").on('contextmenu', function () {
                return false;
            });
                
            $("#Menu2").on('itemclick', function (event) {
         	   var args = event.args;
                var rowindex = $("#jqxDistributionGrid").jqxGrid('getselectedrowindex');
                if ($.trim($(args).text()) == "Edit Selected Row") {
                    editrow = rowindex;
                    var offset = $("#jqxDistributionGrid").offset();
                    $("#popupWindow2").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
                    // get the clicked row's data and initialize the input fields.
                    var dataRecord = $("#jqxDistributionGrid").jqxGrid('getrowdata', editrow);
                    // show the popup window.
                    $("#popupWindow2").jqxWindow('show');
                }
                else {
                    var rowid = $("#jqxDistributionGrid").jqxGrid('getrowid', rowindex);
                    var rowno=$('#jqxDistributionGrid').jqxGrid('getcellvalue', rowid, "rowno");
                    if(typeof(rowno) != "undefined" && typeof(rowno) != "NaN" && rowno != ""){   
                  	  funDelete(rowno);    
                    }
                    $("#jqxDistributionGrid").jqxGrid('deleterow', rowid);
                }
            });
            
            $("#jqxDistributionGrid").on('rowclick', function (event) {
                if (event.args.rightclick) {
     		   
                    $("#jqxDistributionGrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
                    return false;
                
     		   }
            });       
         var rows=$("#jqxDistributionGrid").jqxGrid("getrows");
         if(rows.length==0){
      	   $("#jqxDistributionGrid").jqxGrid("addrow", null, {});   
         } 
      });
       
        function funDelete(rowno){            
    	    var x=new XMLHttpRequest();
    			x.onreadystatechange=function(){
    				if (x.readyState==4 && x.status==200)
    				{  
    					var items=x.responseText.trim();     
    				}
    				else    
    				{       
    				}                     
    			}
    			x.open("GET","deleterows.jsp?rowno="+rowno,true);                                          
    			x.send();      
    	} 
    </script>
    <div id="jqxDistributionGrid"></div>
    
     <div id='jqxWidget'>
     <div id="jqxDistributionGrid"></div>  
    <div id="popupWindow2">
        <div id='Menu2'>
        <ul>
            <li>Delete Selected Row</li>
        </ul>
       </div>
       </div>
       </div>
 