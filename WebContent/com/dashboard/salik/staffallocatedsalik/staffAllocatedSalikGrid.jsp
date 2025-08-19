 <%@page import="com.dashboard.salik.ClsSalikDAO" %>
<% ClsSalikDAO csd=new ClsSalikDAO(); %>
 
 <%String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String type = request.getParameter("emptype")==null?"0":request.getParameter("emptype").trim();
 String saliktype = request.getParameter("saliktype")==null?"0":request.getParameter("saliktype").trim();
 String employee = request.getParameter("empname")==null?"0":request.getParameter("empname").trim();%>
<style>
	.greenClass{
		background-color: #ACF6CB;
	}
</style>
 <script type="text/javascript">
 
 var data1;
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		data1='<%=csd.staffAllocatedGridLoading(branchval,fromDate, toDate, type, employee,saliktype)%>';
    }
 	
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'type', type: 'string'  },
     						{name : 'regno', type: 'string'  },
     						{name : 'platecode', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    },
     						{name : 'emp_type', type: 'string'    },
     						{name : 'sal_name', type: 'string'    },
     						{name : 'totalamount', type: 'string'   },
     						{name : 'st_desc', type: 'string'  },
     						{name : 'salikacc', type: 'int'  },
     						{name : 'expacc', type: 'int'    },
     						{name : 'mainbranch', type: 'int'  },
     						{name : 'doc_no', type: 'int'  },
     						{name : 'sr_no', type: 'int'  },
     						{name : 'emp_id', type: 'string'  },
     						{name : 'amountcount', type: 'int'  },
     						{name : 'empinfo', type: 'string'  },
     						{name : 'auhsalikcount', type: 'number'  },
     						{name : 'auhsalikamt', type: 'number'  },
     						{name : 'dxbsalikcount', type: 'number'  },
     						{name : 'dxbsalikamt', type: 'number'  },
     						{name : 'savestatus', type: 'number'  },
     						{name : 'salikparkamt',type:'number'},
     						{name : 'salikparkcount',type:'number'},
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var cellclassname = function (row, column, value, data) {
            	if(data.savestatus!=null && data.savestatus!="" && data.savestatus!="undefined" && typeof(data.savestatus)!="undefined" && data.savestatus!="0"){
            		return "greenClass";	
            	}
            };
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxstaffAllocatedSalik").jqxGrid(
            {
                width: '98%',
                height: 480,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'checkbox',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
                	        { text: 'Type', datafield: 'type', width: '6%' ,cellclassname:cellclassname  },
							{ text: 'Reg No.', datafield: 'regno', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Fleet No.', datafield: 'fleetno', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Location', datafield: 'location', width: '16%' ,cellclassname:cellclassname},
							{ text: 'Direction', datafield: 'direction', width: '12%' ,cellclassname:cellclassname},
							{ text: 'Source', datafield: 'source', width: '16%' ,cellclassname:cellclassname},
							{ text: 'Tag No.', datafield: 'tagno', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Emp. Type', datafield: 'emp_type', width: '7%' ,cellclassname:cellclassname},
							{ text: 'Emp. Name', datafield: 'sal_name', width: '18%' ,cellclassname:cellclassname},
							{ text: 'Amount', datafield: 'totalamount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Status', datafield: 'st_desc', hidden: true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Salik Account', datafield: 'salikacc', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Expense Account', datafield: 'expacc', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Main Branch', datafield: 'mainbranch', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Doc No', datafield: 'doc_no', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Sr No', datafield: 'sr_no', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Emp Id', datafield: 'emp_id', hidden: true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Amt Count', datafield: 'amountcount', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Emp Info', datafield: 'empinfo', hidden:true, width: '10%' ,cellclassname:cellclassname},
							{ text: 'Salik AUH Count', datafield: 'auhsalikcount', width: '10%',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Salik AUH Amount', datafield: 'auhsalikamt', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Salik DXB Count', datafield: 'dxbsalikcount', width: '10%',cellsalign: 'right', align:'right',cellclassname:cellclassname },
							{ text: 'Salik DXB Amount', datafield: 'dxbsalikamt', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Salik Park Amount', datafield: 'salikparkamt', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Salik PArk Count', datafield: 'salikparkcount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' ,cellclassname:cellclassname},
							{ text: 'Save Status', datafield: 'savestatus', width: '10%',hidden:true ,cellclassname:cellclassname},
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxstaffAllocatedSalik").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
            
            $('#jqxstaffAllocatedSalik').on('rowdoubleclick', function (event) {
                var rowindex1 = event.args.rowindex;
                $('#gridrowindex').val(rowindex1);
                $('.togglehidden').attr('type','text');
                document.getElementById("txtsalikaccount").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "salikacc");
                document.getElementById("txtexpenseaccount").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "expacc");
                document.getElementById("txtrano").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "st_desc");
                document.getElementById("txtfleetno").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "fleetno");
                document.getElementById("txtamount").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "totalamount");
                document.getElementById("txtamountcount").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "amountcount");
                document.getElementById("txtmainbranch").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "mainbranch");
                document.getElementById("txtdocno").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "doc_no");
                document.getElementById("txtsrno").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "sr_no");
                document.getElementById("txttagno").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "tagno");
                document.getElementById("txtemployeeid").value = $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue', rowindex1, "emp_id");
                
                var values= $('#jqxstaffAllocatedSalik').jqxGrid('getcellvalue',rowindex1, "empinfo");
                
                var sum2 = values.toString().replace(/\*/g, '\n');
             
                document.getElementById("vehinfo").value=sum2;
            });  
        });
    </script>
    <div id="jqxstaffAllocatedSalik"></div>
<input type="hidden" id="gridrowindex" name="gridrowindex">