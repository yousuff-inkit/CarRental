<%@page import="com.dashboard.operations.cnrefundrequest.ClsCNRefundRequestDAO" %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
 <%
 ClsCNRefundRequestDAO DAO= new ClsCNRefundRequestDAO();   
 %>
 <%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String apprtype = request.getParameter("apprtype")==null || request.getParameter("apprtype")==""?"0":request.getParameter("apprtype").trim();
 %> 
    <script type="text/javascript">
    var ccdata;  
    var id='<%=id%>';
    var fromdate='<%=fromdate%>';
    var todate='<%=todate%>';

    $(document).ready(function () { 
    	
    	ccdata='<%=DAO.cnrefundData(session, id, fromdate, todate, apprtype)%>';    
    	
            
             var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
		                	{name : 'doc_no', type: 'String'  },
		                	{name : 'client', type: 'String'  },
		                	{name : 'agmttype', type: 'string'  },
		                	{name : 'agmttypeid', type: 'string'  },
		                	{name : 'agmtdocno', type: 'string'  },
			      		    {name : 'amount', type: 'number'  },
		      	       	    {name : 'description', type: 'String'  },
							{name : 'edate', type: 'date'  },
		                	{name : 'cldocno', type: 'String'  },
		                	{name : 'agmtvocno', type: 'string'  },
		                	{name : 'type', type: 'string'  },
			      		    {name : 'status', type: 'string'  },
		      	       	    {name : 'apprrefno', type: 'String'  },
							{name : 'apprremarks', type: 'String'  },
							{name : 'user', type: 'String'  },  
							{name : 'appruser', type: 'String'  },  
							{name : 'account', type: 'String'  }, 
							{name : 'acno', type: 'String'  }, 
							{name : 'brhid', type: 'String'  }, 
							{name : 'statusid', type: 'string'  },
							{name : 'indate', type: 'date'  },
							{name : 'sal_name', type: 'string'  },
                          	],
                 localdata: ccdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxCRRGrid").jqxGrid(
            {
                width: '100%',
                height: 570,
                source: dataAdapter,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filterable: true, 
                filtermode: 'excel',
                enabletooltips:true,
                columnsresize: true,
                showfilterrow:true,
                //Add row method
	          
                columns: [
		                	{ text: 'SL#', sortable: false, filterable: false,  
		                    groupable: false, draggable: false, resizable: false,
		                    datafield: '', columntype: 'number', width: '5%',
		                    cellsrenderer: function (row, column, value) {
		                        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
		                    }
							},
							{ text: 'Doc No', datafield: 'doc_no', width: '4%' },
							{ text: 'Date', datafield: 'edate', width: '4%',cellsformat:'dd.MM.yyyy' },
							{ text: 'Type',datafield:'type',width:'5%'},  
							{ text: 'Client', datafield: 'client', width: '14%' },
							{ text: 'Agmt Type', datafield: 'agmttype', width: '3%' },
							{ text: 'Doc No',datafield:'agmtvocno',width:'4%'},  
							{ text: 'Amount',datafield:'amount',width:'4%',cellsformat:'d2',cellsalign:'right',align:'right'},
							{ text: 'Indate',datafield:'indate',width:'5%',cellsformat:'dd.MM.yyyy'},  
							{ text: 'Salesman',datafield:'sal_name',width:'5%'},  
							{ text: 'Status',datafield:'status',width:'7%',columngroup:'apprGrp'},  
							{ text: 'Ref No', datafield: 'apprrefno',width:'6%',columngroup:'apprGrp' },	
							{ text: 'Remarks', datafield: 'apprremarks', width: '14%',columngroup:'apprGrp'},
							{ text: 'User', datafield: 'appruser', width: '9%',columngroup:'apprGrp' },
							{ text: 'Description', datafield: 'description', width: '12%'  },
							{ text: 'Created User', datafield: 'user', width: '9%' },  
							{ text: 'cldocno', datafield: 'cldocno', width: '0%', hidden:true },
							{ text: 'agmtdocno',datafield:'agmtdocno',width:'0%', hidden:true}, 	
							{ text: 'account',datafield:'account',width:'0%', hidden:true},   	
							{ text: 'acno',datafield:'acno',width:'0%', hidden:true}, 
							{ text: 'brhid',datafield:'brhid',width:'0%', hidden:true}, 
							{ text: 'agmttype', datafield: 'agmttypeid', width: '0%', hidden:true },
							{ text: 'statusid', datafield: 'statusid', width: '0%', hidden:true },
					],columngroups: 
	                     [
		                      { text: 'Approve/Reject', align: 'center', name: 'apprGrp'},
		                     ]  
            });
          	$("#overlay, #PleaseWait").hide();
            
          	$('#jqxCRRGrid').on('rowdoubleclick', function (event) { 
          	   	  var rowindex1 = event.args.rowindex; 
          	      document.getElementById("hiddocno").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
          	      document.getElementById("hidaccount").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "account"); 
          	      document.getElementById("hidcldocno").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
          	      document.getElementById("hidclient").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "client"); 
          	      document.getElementById("hidacno").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "acno"); 
          	      document.getElementById("hidbrhid").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "brhid"); 
          	      document.getElementById("hidagmttype").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "agmttypeid"); 
          	      document.getElementById("hidagmtvocno").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "agmtvocno");
          	      document.getElementById("hiddescription").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "description"); 
          	      document.getElementById("hidamount").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "amount"); 
          	      document.getElementById("hidagmtdocno").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "agmtdocno");
          	      document.getElementById("hidtype").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "type");
          	      document.getElementById("hidstatus").value = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "statusid");
          	      actionPoints();
          	      checkUserRole();
          	      var desc = $('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "doc_no")+' - '+$('#jqxCRRGrid').jqxGrid('getcellvalue', rowindex1, "client");
          	      $(".textpanel p").text(desc);   
            }); 
          	   	  
     });
    </script>
    <div id="jqxCRRGrid"></div>   