 <%@page import="com.dashboard.rectification.clientchange.ClsClientchangeDAO" %>
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
String contextPath=request.getContextPath();
%>
<%
ClsClientchangeDAO DAO= new ClsClientchangeDAO();   
 %>
 <%
 int id=request.getParameter("id")==null || request.getParameter("id")==""?0:Integer.parseInt(request.getParameter("id").trim().toString());            
 String fromdate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
 String todate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
 String agmttype = request.getParameter("agmttype")==null || request.getParameter("agmttype")==""?"0":request.getParameter("agmttype").trim();
 String branch = request.getParameter("branch")==null || request.getParameter("branch")==""?"":request.getParameter("branch").trim();
 String client = request.getParameter("client")==null || request.getParameter("client")==""?"":request.getParameter("client").trim();
 %> 
 <script type="text/javascript">
    var ccdata; 
    
     $(document).ready(function () { 
    	 var agmttype='<%=agmttype%>';   
    	 ccdata='<%=DAO.clientchangeData(session, id, fromdate, todate, agmttype,branch,client)%>';       
     	
         
    	  var num = 0; 
            var source =
            {
                datatype: "json",
                datafields: [
                	    {name : 'date', type: 'date'  },
						{name : 'doc_no', type: 'String'  },
	                	{name : 'voc_no', type: 'String'  },
	                	{name : 'brhid', type: 'string'  },
	                	{name : 'branch', type: 'string'  },
	                	{name : 'type', type: 'string'  },
		      		    {name : 'vehdet', type: 'number'  },
						{name : 'cldocno', type: 'String'  },
	      	       	    {name : 'client', type: 'String'  },
	                	{name : 'salesman', type: 'String'  },
	                	{name : 'renttype', type: 'string'  },
	                	{name : 'tarifrate', type: 'string'  },
                          	],
                 localdata: ccdata,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            
            $("#jqxccDivGrid").on("bindingcomplete", function (event) {
		    	if (agmttype =="RAG"){
            		$('#jqxccDivGrid').jqxGrid('showcolumn', 'renttype');
			    } 
		    	
		    	if (agmttype =="LAG"){
            		$('#jqxccDivGrid').jqxGrid('hidecolumn', 'renttype');
			    }
            });
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
            $("#jqxccDivGrid").jqxGrid(
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
							{ text: 'Date', datafield: 'date', width: '5%',cellsformat:'dd.MM.yyyy',columngroup:'agmtdet'  },
							{ text: 'Doc No', datafield: 'doc_no', width: '4%',columngroup:'agmtdet' ,hidden:true },
							{ text: 'Doc No', datafield: 'voc_no', width: '8%',columngroup:'agmtdet'  },
							{ text: 'BranchId', datafield: 'brhid', width: '4%',columngroup:'agmtdet',hidden:true   },
							{ text: 'Branch', datafield: 'branch', width: '4%',columngroup:'agmtdet',hidden:true   },
							{ text: 'Type',datafield:'type',width:'5%',columngroup:'agmtdet' },  
							{ text: 'Fleet Details', datafield: 'vehdet', width: '14%' ,columngroup:'clientdet' },
							{ text: 'Cldocno', datafield: 'cldocno', width: '14%' ,columngroup:'clientdet',hidden:true  },
							{ text: 'Client', datafield: 'client',columngroup:'clientdet' },
							{ text: 'Salesman', datafield: 'salesman', width: '15%',columngroup:'clientdet'  },
							{ text: 'Rental Type',datafield:'renttype',width:'8%',columngroup:'tarifdet' },  
							{ text: 'Tarif Amt',datafield:'tarifrate',width:'9%',cellsformat:'d2',cellsalign:'right',align:'right',columngroup:'tarifdet' },
						
							],
							columngroups: 
	                     [
		                      { text: 'Agreement Details', align: 'center', name: 'agmtdet'},
		                      { text: 'Client Details', align: 'center', name: 'clientdet'},
		                      { text: 'Tariff Details', align: 'center', name: 'tarifdet'},
		                     ]  
            });
          	$("#overlay, #PleaseWait").hide();
        	$('#jqxccDivGrid').on('rowdoubleclick', function (event) { 
        		 var rowindex1 = event.args.rowindex; 
        		 var desc = $('#jqxccDivGrid').jqxGrid('getcellvalue', rowindex1, "voc_no")+' - '+$('#jqxccDivGrid').jqxGrid('getcellvalue', rowindex1, "client");
         	      $(".textpanel p").text(desc); 
         	     document.getElementById("hiddocno").value = $('#jqxccDivGrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
         	    document.getElementById("hidclient").value = $('#jqxccDivGrid').jqxGrid('getcellvalue', rowindex1, "cldocno"); 
             	   
        	 }); 
              }); 
    
    </script>
    <div id="jqxccDivGrid"></div> 