<%@page import="com.dashboard.trafficfine.satdaily.ClsSatDailyReport" %>
<%ClsSatDailyReport DAO=new ClsSatDailyReport(); %>
<%@page import="javax.servlet.http.HttpServletRequest" %> 
<%@page import="javax.servlet.http.HttpSession" %>
<% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString();%>
<% String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString();%>
<% String satcateg =request.getParameter("satcateg")==null?"0":request.getParameter("satcateg").toString();%>
<% String datefilter =request.getParameter("datefilter")==null?"0":request.getParameter("datefilter").toString();%>
<% String check =request.getParameter("check")==null?"0":request.getParameter("check").toString();%>
<% String saliksource=request.getParameter("saliksource")==null?"0":request.getParameter("saliksource").toString();%>
<% String username=request.getParameter("username")==null?"0":request.getParameter("username").toString();%>


 <script type="text/javascript">
	 var data;
  	 var salikdailyexceldata;       
 
 	 data= '<%= DAO.satDailyReportGridLoading(fromdate,todate,satcateg,datefilter,check,saliksource,username) %>';
	<%--  salikdailyexceldata= '<%= DAO.satDailyReportExcelExport(fromdate,todate,satcateg,datefilter,check) %>' ; --%>
   
        $(document).ready(function () { 	
            
            var source =
            {
                datatype: "json",
                datafields: [
                	        {name : 'type', type: 'string'  },
							{name : 'username', type: 'String'  },
     						{name : 'trans', type: 'String'  },
     						{name : 'salik_date', type: 'String' },
     						{name : 'salik_time', type: 'String' },
     						{name : 'sal_date', type: 'String' },
     						{name : 'regno', type: 'String' },
     						{name : 'source', type: 'String' },
     						{name : 'tagno', type: 'String' },
     						{name : 'location', type: 'String' },
     						{name : 'direction', type: 'String' },
     						{name : 'amount', type: 'number' },
     						{name : 'date', type: 'String' }
                 ],
                 localdata: data,
                
                
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
            $("#jqxloaddataGrid").jqxGrid(
            {
                width: '100%',
                height: 535,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
                showfilterrow:true,
                enabletooltips:true,
                sortable: true,

                columns: [
                	    { text: 'Type', datafield: 'type', width: '6%'   },
						{ text: '#Transaction',columntype: 'textbox', datafield: 'trans', width: '10%' },
						{ text: 'User Name',columntype: 'textbox', datafield: 'username', width: '11%' },
						{ text: 'Downloaded Date',columntype: 'textbox',  datafield: 'date', width: '10%' },
						{ text: 'Trip Date',columntype: 'textbox', datafield: 'salik_date', width: '6%' },
						{ text: 'Trip Time',columntype: 'textbox', datafield: 'salik_time', width: '6%' },
						{ text: 'Post Date',columntype: 'textbox', datafield: 'sal_date', width: '6%' },
						{ text: 'Plate',columntype: 'textbox',  datafield: 'regno', width: '6%' },
						{ text: 'Source',columntype: 'textbox',  datafield: 'source', width: '9%' },
						{ text: 'Tag',columntype: 'textbox',  datafield: 'tagno', width: '8%' },
						{ text: 'Location',columntype: 'textbox',  datafield: 'location', width: '10%' },
						{ text: 'direction',columntype: 'textbox',  datafield: 'direction', width: '10%' },
						{ text: 'Amount',columntype: 'textbox',  datafield: 'amount', width: '8%', cellsformat: 'd2', cellsalign:'right'},
					
	              ]
            });

            $("#overlay, #PleaseWait").hide();
        });
    </script>
    <div id="jqxloaddataGrid"></div>
