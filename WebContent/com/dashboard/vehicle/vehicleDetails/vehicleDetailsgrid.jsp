<%@ page import="com.dashboard.vehicle.ClsvehicleDAO" %>
<%ClsvehicleDAO cvd=new ClsvehicleDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

 <script type="text/javascript">
 var vehdetdata;
 var temp='<%= check %>';
 if(temp=="load") {
	 vehdetdata = '<%=cvd.vehicleDetailsSearch(check)%>';
<%--  var dataExcelExport='<%=cvd.vehicleDetailsExcel(check)%>';
 --%>	}
 else{
	 vehdetdata;
 }

 
        $(document).ready(function () { 
        	
        	
             var num = 0; 
            var source = 
            {
                datatype: "json",
                datafields: [
                            
                             
                          
                             
                            //1
     						{name : 'doc_no', type: 'String'  },
     						{name : 'date', type: 'date'  },
     						 {name : 'agmtno', type: 'number'  }, 
     						 {name : 'agmtype', type: 'String'  }, 
     						 {name : 'client', type: 'String'  }, 
     						 {name : 'branch', type: 'String'  }, 
     						 {name : 'trancode', type: 'String'  }, 
     						 {name : 'reg_no', type: 'number'  }, 
     						{name : 'fleet_no', type: 'number'  },
     						{name : 'flname', type: 'String'  },
     						 {name : 'prch_inv', type: 'String'  }, 
      						{name : 'prch_dte', type: 'date'  },
     						{name : 'prch_cost', type: 'number'  },
     						{name : 'inst_amt', type: 'String'  },
     						{name : 'dtype', type: 'String'  }, 
     						{name : 'int_amt', type: 'String'},
     						{name : 'dn_pay', type: 'String'  },
     						{name : 'ins_comp', type: 'String'  },
     						 //2
                            {name : 'pno', type: 'String'  },
    						{name : 'ins_amt', type: 'String'  },
    						 {name : 'prmym_perc', type: 'String'  }, 
    						{name : 'prmym', type: 'String'  },
    						 {name : 'ins_exp', type: 'date'  }, 
     						{name : 'rel_date', type: 'date'  },
    						{name : 'reg_exp', type: 'date'  },
    						{name : 'depr', type: 'number'  },
    						
    						{name : 'eng_no', type: 'String'},
    						{name : 'ch_no', type: 'String'  },
    						{name : 'a_loc', type: 'String'  },
    						{name : 'tval', type: 'number'  },
     						
     						 //3
                            
                          	{name : 'status', type: 'String'  },
                          	{name : 'srvc_km', type: 'number'  },
                          
                          	{name : 'srvc_dte', type: 'date'  },
  						{name : 'lst_srv', type: 'number'  },
  						 {name : 'war', type: 'date'  }, 
  						{name : 'war_km', type: 'number'  },
  						 {name : 'cur_km', type: 'number'  }, 
   						{name : 'itype', type: 'String'  },
  						{name : 'add1', type: 'number'  },
  						{name : 'c_fuel', type: 'String'  },
  						
  						{name : 'tran_code', type: 'String'},
  						{name : 'yom', type: 'number'  },
  						{name : 'reg_date', type: 'date'  },
  						
  					  //4
                        {name : 'lpo', type: 'number'  },
 						{name : 'salik_tag', type: 'number'  },
 						 {name : 'no_inst', type: 'String'  }, 
 						{name : 'fstatus', type: 'String'  },
 						 {name : 'a_br', type: 'String'  }, 
  						{name : 'war_prd', type: 'number'  },
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
 						
                               {name : 'tcap', type: 'number'  },
 						
 						{name : 'cost', type: 'String'  },
 						{name : 'accdepr', type: 'number'  },
 						{name : 'mortgage', type: 'String'  },
 						{name : 'slno', type: 'number'    },
     						
     						
     						
     						
                          	],
                          	localdata: vehdetdata,
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
            $("#vehicledetails").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: dataAdapter,
                showaggregates:true,
                columnsresize: true,
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                sortable:true,
                enabletooltips :true,
                selectionmode: 'singlerow',
                pagermode: 'default',
            
            
     					
                columns: [
                	
                     /*  { text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  }, */
					  
                          
                          
				/* 	{ text: 'Doc No', datafield: 'doc_no', width: '3%' },
					{ text: 'Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy' }, */
					     { text: 'Sr.No', datafield: 'slno', width: '3%' },
					     { text: 'Fleet NO', datafield: 'fleet_no', width: '4%', cellsalign:'right',align:'right' },
					     { text: 'Reg.NO', datafield: 'reg_no', width: '4%', cellsalign:'right',align:'right' }, 
					     { text: 'Agmt No', datafield: 'agmtno', width: '5%', cellsalign:'right',align:'right' }, 
					     { text: 'Agmt Type', datafield: 'agmtype', width: '4%' }, 
					     { text: 'Client', datafield: 'client', width: '15%' }, 
					     { text: 'Branch', datafield: 'a_br', width: '10%' },
					     { text: 'Branch', datafield: 'branch', width: '7%',hidden:true }, 
					     { text: 'Trancode', datafield: 'trancode', width: '8%' }, 
						 { text: 'Salik Tag', datafield: 'salik_tag', width: '4%', cellsalign:'right',align:'right' },
					     { text: 'TC No.', datafield: 'tcno', width: '5%'},
					     { text: 'Fleet Name', datafield: 'flname', width: '8%' },
					     { text: 'Type', datafield: 'dtype', width: '3%' },
						 { text: 'Authority', datafield: 'authname', width: '6%' },
						 { text: 'Plate code', datafield: 'pltname', width: '4%' }, 
						 { text: 'Tariff Group', datafield: 'vgrpname', width: '4%' },
						 { text: 'Brand', datafield: 'brdname', width: '4%' },
						 { text: 'Model', datafield: 'vmodname', width: '6%' },
						 { text: 'YOM', datafield: 'yom', width: '4%', cellsalign:'right',align:'right'  }, 
						 { text: 'Color', datafield: 'clrname', width: '4%' },
						 { text: 'Current KM', datafield: 'cur_km', width: '5%', cellsalign:'right',align:'right',cellsformat:'d0'  },
						 { text: 'Fueltype', datafield: 'fueltype', width: '3%' },
						 { text: 'T.Capacity', datafield: 'tcap', width: '4%', cellsalign:'right',align:'right' },
						 { text: 'Reg_Date', datafield: 'reg_date', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Reg_Exp', datafield: 'reg_exp', width: '5%',cellsformat:'dd.MM.yyyy'},
						 { text: 'Ins_Exp', datafield: 'ins_exp', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Release Date', datafield: 'rel_date', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Puchase Date', datafield: 'prch_dte', width: '5%',cellsformat:'dd.MM.yyyy' },	
						 { text: 'Purch. Order', datafield: 'lpo', width: '5%', cellsalign:'right',align:'right' },
						 { text: 'Dealer', datafield: 'dlrname', width: '5%' },
						 { text: 'Purchase Invoice', datafield: 'prch_inv', width: '7%' },
						 { text: 'Purchase cost', datafield: 'prch_cost', width: '6%', cellsalign:'right',align:'right',cellsformat:'d2' },
						 { text: 'Additional Cost', datafield: 'add1', width: '4%', cellsalign:'right',align:'right',cellsformat:'d2'},
						 { text: 'Total Cost ', datafield: 'tval', width: '5%', cellsalign:'right',align:'right',cellsformat:'d2' },
						 { text: 'Insurance Company', datafield: 'ins_comp', width: '10%' },
						 { text: 'Insurance Type', datafield: 'itype', width: '5%' },
						 { text: 'Prch_NO', datafield: 'pno', width: '5%' }, 
						 { text: 'Depreciation %', datafield: 'depr', width: '4%', cellsalign:'right',align:'right' },
						 { text: 'Acc. Depr.', datafield: 'accdepr', width: '4%', cellsalign:'right',align:'right'},
						 { text: 'Engine No', datafield: 'eng_no', width: '5%' },
						 { text: 'Chasis No', datafield: 'ch_no', width: '5%'},
						 { text: 'Service Interval', datafield: 'srvc_km', width: '5%', cellsalign:'right',align:'right' },
						 { text: 'Service Date', datafield: 'srvc_dte', width: '5%', cellsformat:'dd.MM.yyyy' }, 
						 { text: 'Last Service KM', datafield: 'lst_srv', width: '5%' , cellsalign:'right',align:'right' },
						 { text: 'Warranty_prd', datafield: 'war_prd', width: '5%' , cellsalign:'right',align:'right' },
						 { text: 'Warranty_Km', datafield: 'war_km', width: '5%' , cellsalign:'right',align:'right' },
						 { text: 'Mortgage', datafield: 'mortgage', width: '10%' },
						 { text: 'Fin_Name', datafield: 'finname', width: '5%' },
						 
			/* 		     { text: 'Inst_Amt', datafield: 'inst_amt', width: '5%'},
					     { text: 'Int_Amt', datafield: 'int_amt', width: '5%' },
						 { text: 'Down Pay', datafield: 'dn_pay', width: '5%' },
						 { text: 'Ins_Amt', datafield: 'ins_amt', width: '5%' },
						 { text: 'Premium %', datafield: 'prmym_perc', width: '5%' },
						 { text: 'premium', datafield: 'prmym', width: '5%' },
						 { text: 'Loc', datafield: 'a_loc', width: '5%' },
						 { text: 'Status', datafield: 'status', width: '5%' },
						 { text: 'Warranty', datafield: 'war', width: '5%', cellsformat:'dd.MM.yyyy'},
						 { text: 'Tran_code', datafield: 'tran_code', width: '5%' },
						 { text: 'Fuel', datafield: 'c_fuel', width: '5%'},
						 { text: 'No_Inst', datafield: 'no_inst', width: '5%' }, 
						 { text: 'Fstatus', datafield: 'fstatus', width: '5%' },
						 { text: 'Curr_value', datafield: 'curr_value', width: '5%' },
						 { text: 'Category', datafield: 'category', width: '5%' },
						 { text: 'Renttype', datafield: 'renttype', width: '5%'},
						 { text: 'Type', datafield: 'dtype', width: '5%' },
						 { text: 'Company', datafield: 'comp_id', width: '5%' },
						 { text: 'Branded', datafield: 'branded', width: '5%' },
						 { text: 'Fin_Name', datafield: 'finname', width: '5%' },
						 { text: 'Branch', datafield: 'brhname', width: '5%' },
						 { text: 'Costname', datafield: 'costname', width: '5%'},
						 { text: 'Warranty End', datafield: 'warend', width: '5%',cellsformat:'dd.MM.yyyy' },
						 { text: 'Status', datafield: 'statu', width: '5%'},
						 { text: 'Cost', datafield: 'cost', width: '5%'},
									 */
					
							
					
					]
            });
    
        	$("#overlay, #PleaseWait").hide();       
				           
        
                  }); 
				       
                       
    </script>
    <div id="vehicledetails"></div>