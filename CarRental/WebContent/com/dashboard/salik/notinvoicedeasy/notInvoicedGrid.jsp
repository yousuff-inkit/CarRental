<%@page import="com.dashboard.salikeasy.*" %>
<%String branchval = request.getParameter("branchval")==null?"0":request.getParameter("branchval").trim();
 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String cldocno = request.getParameter("cldocno")==null?"0":request.getParameter("cldocno").trim();
 String rentalType = request.getParameter("rentaltype")==null?"0":request.getParameter("rentaltype").trim();
 String agmtNo = request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").trim();
 String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
 ClsSalikEasyDAO  salikdao=new ClsSalikEasyDAO();
 %>
 <script type="text/javascript">
 
 var data1=[];
 var temp='<%=branchval%>';
 
 	if(temp!='NA'){ 
 		data1='<%=salikdao.notInvoicedGridLoadingV2(branchval,fromDate, toDate, cldocno, rentalType, agmtNo,type)%>';
    }
 	
        $(document).ready(function () { 	
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
     						/* {name : 'regno', type: 'string'  },
     						{name : 'fleetno', type: 'string'    },
     						{name : 'location', type: 'string'    },
     						{name : 'direction', type: 'string'    },
     						{name : 'source', type: 'string'    },
     						{name : 'tagno', type: 'string'    }, */
     						{name : 'amount', type: 'number'    },
     						/* {name : 'ra_no',type:'string'},
     						{name : 'vocno',type:'string'},
     						{name :'rtype',type:'string'},
     						{name :'sal_date',type:'date'}, */
     						{name : 'saliksrvc',type:'number'},
     						{name : 'cldocno',type:'number'},
     						{name : 'refname',type:'number'},
     						{name : 'salikcount',type:'number'},
     						{name : 'salikauhcount',type:'number'},
     						{name : 'salikdxbcount',type:'number'},
     						{name : 'salikauhamt',type:'number'},
     						{name : 'salikdxbamt',type:'number'},
     						{name : 'salikdxbsrvc',type:'number'},
     						{name : 'salikauhsrvc',type:'number'}
     						
     						
                 ],
                 localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
                $("#jqxNotInvoiced").on("bindingcomplete", function (event) {
					$("#overlay, #PleaseWait").hide();
    	
				});
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxNotInvoiced").jqxGrid(
            {
                width: '98%',
                height: 500,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                showaggregates:true,
                selectionmode: 'singlerow',
                editable: false,
                localization: {thousandsSeparator: ""},
                
                columns: [
						{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%', cellsrenderer: function (row, column, value) {
						    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
						}   },
						/* { text: 'Original Agmt No.', datafield: 'ra_no', width: '7%',hidden:true },
						{ text: 'Agmt No.', datafield: 'vocno', width: '7%' },
						{ text: 'Agmt Type.', datafield: 'rtype', width: '7%' },
						{ text: 'Reg No.', datafield: 'regno', width: '8%' },
						{ text: 'Fleet No.', datafield: 'fleetno', width: '10%' },
						{ text: 'Salik Date', datafield: 'sal_date', width: '8%',cellsformat:'dd.MM.yyyy' },
						{ text: 'Location', datafield: 'location', width: '12.5%' },
						{ text: 'Direction', datafield: 'direction', width: '10%' },
						{ text: 'Source', datafield: 'source', width: '12.5%' },
						{ text: 'Tag No.', datafield: 'tagno', width: '10%' }, */
						{ text: 'Client #',datafield:'cldocno',width:'6%'},
						{ text: 'Client Name',datafield:'refname',width:'41%'},
						{ text: 'DARB Count',datafield:'salikauhcount',width:'8%',cellsformat:'d0',cellsalign:'right',align:'right'},
						{ text: 'DARB Amt',datafield:'salikauhamt',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'DARB Srv',datafield:'salikauhsrvc',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'DXB Count',datafield:'salikdxbcount',width:'8%',cellsformat:'d0',cellsalign:'right',align:'right'},
						{ text: 'DXB Amt',datafield:'salikdxbamt',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
						{ text: 'DXB Srv',datafield:'salikdxbsrvc',width:'8%',cellsformat:'d2',cellsalign:'right',align:'right'},
/* 						{ text: 'Salik Count',datafield:'salikcount',width:'10%',cellsformat:'d'},
						{ text: 'Amount', datafield: 'amount', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
						{ text: 'Service Charge', datafield: 'saliksrvc', width: '10%',cellsformat: 'd2',cellsalign: 'right', align:'right' },
 */						
	              ]
            });
            
            if(temp=='NA'){
                $("#jqxNotInvoiced").jqxGrid("addrow", null, {});
            }
        });
</script>
<div id="jqxNotInvoiced"></div>
