<%@page import="com.dashboard.vehicle.fleetlist.ClsFleetListDAO"%>
<% ClsFleetListDAO dao=new ClsFleetListDAO(); %>

 <%
 
 String chk = request.getParameter("chk")==null?"0":request.getParameter("chk");
 String brch = request.getParameter("brchid")==null?"0":request.getParameter("brchid");
 String date = request.getParameter("date")==null?"0":request.getParameter("date");
 %>

 <script type="text/javascript">

 
 var chk='<%=chk%>';
 var brch='<%=brch%>';
 var date='<%=date%>';
 
 var vehlistdata;
 if(chk=="load")
	{
	 
	 
 vehlistdata='<%=dao.vehicleListSearch(chk,brch,date)%>'; 

 <%-- vehicleexceldata='<%=cvd.vehicleexcelListSearch(chk)%>'; --%> 
	}
        $(document).ready(function () { 
        	
        	 var currentAccNo = null; // Store the currently selected dealer's acc_no
        	 var selectedRows = []; // Array to track selected rows
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            

                          
                             
                            //1
     						{name : 'doc_no', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						 {name : 'reg_no', type: 'String'  }, 
     						{name : 'fleet_no', type: 'String'  },
     						{name : 'flname', type: 'String'  },
     						 {name : 'prch_inv', type: 'String'  }, 
      						{name : 'prch_dte', type: 'date'  },
     						{name : 'prch_cost', type: 'String'  },
     						{name : 'inst_amt', type: 'String'  },
     						
     						{name : 'int_amt', type: 'String'},
     						{name : 'dn_pay', type: 'String'  },
     						{name : 'ins_comp', type: 'String'  },
     						 //2
                            {name : 'pno', type: 'string'  },
    						{name : 'ins_amt', type: 'String'  },
    						 {name : 'prmym_perc', type: 'String'  }, 
    						{name : 'prmym', type: 'String'  },
    						 {name : 'ins_exp', type: 'date'  }, 
     						{name : 'rel_date', type: 'date'  },
    						{name : 'reg_exp', type: 'date'  },
    						{name : 'depr', type: 'String'  },
    						
    						{name : 'eng_no', type: 'String'},
    						{name : 'ch_no', type: 'String'  },
    						{name : 'a_loc', type: 'String'  },
    						{name : 'tval', type: 'String'  },
     						
     						 //3
                            
                          	{name : 'status', type: 'String'  },
                          	{name : 'srvc_km', type: 'String'  },
                          
                          	{name : 'srvc_dte', type: 'String'  },
  						{name : 'lst_srv', type: 'String'  },
  						 {name : 'war', type: 'date'  }, 
  						{name : 'war_km', type: 'String'  },
  						 {name : 'cur_km', type: 'String'  }, 
   						{name : 'itype', type: 'String'  },
  						{name : 'add1', type: 'String'  },
  						{name : 'c_fuel', type: 'String'  },
  						
  						{name : 'tran_code', type: 'String'},
  						{name : 'yom', type: 'String'  },
  						{name : 'reg_date', type: 'date'  },
  						
  					  //4
                        {name : 'lpo', type: 'String'  },
 						{name : 'salik_tag', type: 'String'  },
 						 {name : 'no_inst', type: 'String'  }, 
 						{name : 'fstatus', type: 'String'  },
 						 {name : 'a_br', type: 'String'  }, 
  						{name : 'war_prd', type: 'String'  },
 						{name : 'curr_value', type: 'String'  },
 						{name : 'category', type: 'String'  },
 						
 						{name : 'renttype', type: 'String'},
 						{name : 'dtype', type: 'String'  },
 						{name : 'comp_id', type: 'String'  },
 						
 						{name : 'tcno', type: 'String'  },
 						{name : 'branded', type: 'String'  },
                        
 						 //5
                        {name : 'finname', type: 'String'  },
 						{name : 'authname', type: 'String'  },
 						 {name : 'pltname', type: 'String'  }, 
 						{name : 'vgrpname', type: 'String'  },
 						 {name : 'brdname', type: 'String'  }, 
  						{name : 'vmodname', type: 'String'  },
 						{name : 'dlrname', type: 'String'  },
 						{name : 'brhname', type: 'String'  },
 						
 						{name : 'costname', type: 'String'},
 						{name : 'clrname', type: 'String'  },
 						{name : 'warend', type: 'date'  },
 						
 						{name : 'statu', type: 'String'  },
 						{name : 'fueltype', type: 'String'  },
 						
                               {name : 'tcap', type: 'String'  },
 						
 						{name : 'cost', type: 'String'  },
 						{name : 'accdepr', type: 'String'  },
 						
 						{name : 'age', type: 'string'  },
 						{name : 'salik_tag', type: 'string'  },
 							
 						{name : 'currentkm', type: 'string'  },
 						
 						{name : 'st_desc', type: 'string'  },
 						{name : 'dlrid', type: 'string'  },
 						{name : 'acc_no', type: 'string'  },
 						{name : 'name', type: 'string'  },
 						{name : 'track_id', type: 'number'  },
 						{name : 'taxper', type: 'string'  },
 						{name : 'curid', type: 'string'  },
 						{name : 'rate', type: 'string'  },
 						{name : 'acno', type: 'string'  },
 						
 						
 							
     						
     						
                          	],
                          	localdata: vehlistdata,
                          //	 url: url1,
          
				
                
                pager: function (pagenum, pagesize, oldpagenum) {
                   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#fleetlist").jqxGrid(
            {
            	 width: '100%',
 				height: 500,
                 source: dataAdapter,
                 editable: true,
                // groupable: true,
                filterable: true,
                 showfilterrow: true,
                 enabletooltips:true,
                 columnsresize: true,
                  //sortable:true,
                 selectionmode: 'checkbox',
                 //groups: ['vgrpname','brdname','vmodname','yom'],
            
            
     					
                columns: [
 
                          
                          
				/* 	{ text: 'Doc No', datafield: 'doc_no', width: '3%' },
					{ text: 'Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' }, */
					
					{ text: 'SL#', sortable: false, filterable: false, editable: false, 
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
				
					
					     { text: 'Dealer Name',datafield: 'name', width: '6%' },    
					     { text: 'Fleet NO',datafield: 'fleet_no', width: '6%' },    
					     { text: 'Price',datafield: 'track_id', width: '6%',cellsalign: 'right', align:'right' },    
					     { text: 'Out Days',datafield: 'outdays', width: '6%',cellsalign: 'right', align:'right',editable:true},    
					     { text: 'Total Days',datafield: 'totaldays',  width: '6%',cellsalign: 'right', align:'right'},    
					     { text: 'Total Rent',datafield: 'totalrent', cellsformat:'d2', width: '6%',cellsalign: 'right', align:'right'},    
					     { text: 'Authority ', datafield: 'authname', width: '10%' }, 
					     { text: 'Reg_NO', datafield: 'reg_no', width: '6%' }, 
					     { text: 'Plate Code ', datafield: 'pltname', width: '8%' }, 
					     { text: 'Fleet Name', datafield: 'flname', width: '13%' },
						 { text: 'Tariff Group', datafield: 'vgrpname', width: '10%' },
						 { text: 'Brand', datafield: 'brdname', width: '10%' },
						 { text: 'Model', datafield: 'vmodname', width: '10%' },
						 { text: 'Engine No', datafield: 'eng_no', width: '10%' },
						 { text: 'Chassis No', datafield: 'ch_no', width: '10%' },
						 { text: 'Trancode', datafield: 'st_desc', width: '12%' } ,
						 { text: 'YOM', datafield: 'yom', width: '5%' }, 
						 { text: 'Color', datafield: 'clrname', width: '7%' },
						 { text: 'Current KM', datafield: 'currentkm', width: '7%' },
						 { text: 'Reg_Date', datafield: 'reg_date', width: '7%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Reg_Exp', datafield: 'reg_exp', width: '7%',cellsformat:'dd.MM.yyyy' },
						 
						 { text: 'Ins_Exp', datafield: 'ins_exp', width: '7%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Purchase Cost', datafield: 'prch_cost', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Additional Cost', datafield: 'add1', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Total cost', datafield: 'tval', width: '6%'  ,cellsalign: 'right', align:'right'},
						 { text: 'Depreciation %', datafield: 'depr', width: '7%',cellsalign: 'right', align:'right' },
						 { text: 'Age(months)', datafield: 'age', width: '6%' },
						 { text: 'Salik Tag', datafield: 'salik_tag', width: '8%' },
						 { text: 'Traffic Tcno', datafield: 'tcno', width: '8%' },
						 { text: 'accno', datafield: 'acc_no', width: '8%',hidden:true },
						 { text: 'curid', datafield: 'curid', width: '8%',hidden:true },
						 { text: 'rate', datafield: 'rate', width: '8%' },
						 { text: 'acno', datafield: 'acno', width: '8%',hidden:true }
						 
						 /* { text: 'Salik Tag',groupable: false, datafield: 'salik_tag', width: '8%', hidden:true } */
						 
					
		
					
							
					
					],
					  /* groupsrenderer: function (defaultText, group, state, params) {
							return false;
						}  */
            });
       
            $('.page-loader').hide();
            
            // Helper: Safely get acc_no (handles null/undefined)
            function getAccNo(row) {
                return (row && row.acc_no) ? row.acc_no.trim() : '';
            }
            // Individual Row Selection
            $("#fleetlist").on('rowselect', function (event) {
                var selectedRow = event.args.row;
                var newAccNo = getAccNo(selectedRow);
           

                if (currentAccNo === null) {
                    if($('#fleetlist').jqxGrid('getcellvalue', selectedRow, "name")==""){
                    	Swal.fire({
     	   					type: 'fail',
     	   				  	title: 'Warning',  
     	   				  	text: 'Dealers is Mandatory '
     	   				});
        $("#fleetlist").jqxGrid('unselectrow', event.args.rowindex);
         			  
                    }
                    if($('#fleetlist').jqxGrid('getcellvalue', selectedRow, "track_id")==""){
                    	Swal.fire({
     	   					type: 'fail',
     	   				  	title: 'Warning',  
     	   				  	text: 'Price is Mandatory '
     	   				});
        $("#fleetlist").jqxGrid('unselectrow', event.args.rowindex);
         			  
                    }
                    // If no row is selected, set the currentAccNo to the new row's acc_no
                    currentAccNo = newAccNo;
                    selectedRows.push(selectedRow); // Add the row to the selectedRows array
                } else if (newAccNo !== currentAccNo) {
                    // If the new row's acc_no is different from the currentAccNo, show an alert and unselect the row
                    Swal.fire({
			     	   					type: 'fail',
			     	   				  	title: 'Warning',  
			     	   				  	text: 'Different Dealers are Not Allowed '
			     	   				});
                    $("#fleetlist").jqxGrid('unselectrow', event.args.rowindex);
                } else {
                    if($('#fleetlist').jqxGrid('getcellvalue', selectedRow, "name")==""){
                    	Swal.fire({
     	   					type: 'fail',
     	   				  	title: 'Warning',  
     	   				  	text: 'Dealers is Mandatory '
     	   				});
        $("#fleetlist").jqxGrid('unselectrow', event.args.rowindex);
         			  
                    }
                    if($('#fleetlist').jqxGrid('getcellvalue', selectedRow, "track_id")==""){
                    	Swal.fire({
     	   					type: 'fail',
     	   				  	title: 'Warning',  
     	   				  	text: 'Price is Mandatory '
     	   				});
        $("#fleetlist").jqxGrid('unselectrow', event.args.rowindex);
         			  
                    }
                    // If the new row's acc_no matches the currentAccNo, add it to the selectedRows array
                    selectedRows.push(selectedRow);
                }
             // Call getAcno() and use the value once it's resolved
               /*  getAcno().then(function(acno) {
                    // Now 'acno' contains the value, and you can use it
                    var a = acno;
                    //alert(a)
                  //  $("#fleetlist").jqxGrid('unselectrow', rowIndex);
                    $('#fleetlist').jqxGrid('setcellvalue', selectedRow, "acno",a);
                }).catch(function(error) {
                    console.error(error); // Handle any error that occurs
                }); */
                console.log("Selected Rows:", selectedRows); // Debugging
            });

            // Row Unselection
            $("#fleetlist").on('rowunselect', function (event) {
                let unselectedRowIndex = event.args.rowindex;
                let unselectedRow = $("#fleetlist").jqxGrid('getrowdata', unselectedRowIndex);

                // Remove the unselected row from the selectedRows array
                selectedRows = selectedRows.filter(row => row.acc_no !== unselectedRow.acc_no);

                if (selectedRows.length === 0) {
                    // If no rows are selected, reset the currentAccNo to null
                    currentAccNo = null;
                } else {
                    // If rows are still selected, update the currentAccNo to the acc_no of the first selected row
                    currentAccNo = getAccNo(selectedRows[0]);

                    // Check if all remaining selected rows have the same acc_no
                    let allSameAccNo = selectedRows.every(row => getAccNo(row) === currentAccNo);

                    if (!allSameAccNo) {
                        // If any remaining row has a different acc_no, reset currentAccNo and unselect all rows
                         Swal.fire({
			     	   					type: 'fail',
			     	   				  	title: 'Warning',  
			     	   				  	text: 'Different Dealers are Not Allowed '
			     	   				});
                        $("#fleetlist").jqxGrid('clearselection');
                        selectedRows = []; // Clear the selectedRows array
                        currentAccNo = null;
                    }
                }

                console.log("Selected Rows after unselect:", selectedRows); // Debugging
                console.log("Current Acc No after unselect:", currentAccNo); // Debugging
            });
            
            // condition to calculate the rate 
            $('#fleetlist').on('cellvaluechanged', function (event) {
                var column = event.args.datafield; 
                var rowindex = event.args.rowindex;
                const oldValue = event.args.oldvalue;
                // Only trigger if the changed column is totaldays or outdays
                if (column === 'outdays') {
                    var rowData = $('#fleetlist').jqxGrid('getrowdata', rowindex);
                    let outdays=(!Number.isInteger(rowData.outdays) || rowData.outdays < 0)?0:rowData.outdays;
                    let prevdays=(!Number.isInteger(oldValue) || oldValue < 0)?0:oldValue;
                    let ogtotaldays = parseInt(rowData.totaldays);
                    let totaldays = parseInt(ogtotaldays)-parseInt(outdays)+parseInt(prevdays);
                    let monthlyrate =  parseFloat(rowData.track_id);
                    let datee=$('#formonth').val();
                    var dateParts = datee.split('.');  // Expecting format "DD.MM.YYYY"
                    var day = parseInt(dateParts[0], 10);   // Not used, but can be useful for validation
                    var month = parseInt(dateParts[1], 10); // Month (1-based: 1 = January, 12 = December)
                    var year = parseInt(dateParts[2], 10);  // Year
                    // Since the month is 1-based in the input, but 0-based in JavaScript's Date constructor
                    let monthdays = new Date(year, month, 0).getDate();
                    let rate = ((monthlyrate/parseInt(monthdays))*totaldays)
                    $('#fleetlist').jqxGrid('setcellvalue', rowindex, 'totaldays',totaldays);
                    $('#fleetlist').jqxGrid('setcellvalue', rowindex, 'outdays',outdays);
                    $('#fleetlist').jqxGrid('setcellvalue', rowindex, 'totalrent',rate);
                }
            });
            

            // "Unselect All" Event
            $("#fleetlist").on('rowunselectall', function () {
                // Reset the currentAccNo and selectedRows array when all rows are unselected
                currentAccNo = null;
                selectedRows = [];
                console.log("Current Acc No after unselect all:", currentAccNo); // Debugging
                console.log("Selected Rows after unselect all:", selectedRows); // Debugging
            });
            function getAcno() {
                return new Promise(function(resolve, reject) {
                    var acno = "";
                    $.get('getAcno.jsp', function(data) {
                        data = JSON.parse(data);
                        
                        $.each(data.obdata, function(index, value) {
                            acno = value.acno;
                        });

                        $('#acno').val(acno); // Optional, if you want to set it to an input field
                        resolve(acno); // Resolve the promise with acno value
                    }).fail(function() {
                        reject("Error fetching acno.");
                    });
                });
            }
            
            $("#overlay, #PleaseWait").hide();
				           
        
                  }); 
				       
                       
    </script>
    <div id="fleetlist"></div>