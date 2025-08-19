<%@page import="com.dashboard.client.clientiddetails.ClsClientidDetailsDAO" %>
<% ClsClientidDetailsDAO DAO=new ClsClientidDetailsDAO(); %> 
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%
 String check = request.getParameter("check")==null?"0":request.getParameter("check");
 String client = request.getParameter("client")==null?"0":request.getParameter("client").trim();
 %>
 
<script type="text/javascript">
     
       var data1= '<%=DAO.clientiddetgrid(client,check)%>';    
       $(document).ready(function () { 

    	   // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'doc_no', type: 'int'   },
							{name : 'acno', type: 'int'   },
     						{name : 'clname', type: 'string'   },
     						{name : 'refid', type: 'string'   },
     						{name : 'id1', type: 'string'   },
     						{name : 'id2', type: 'string'   },
     						{name : 'id3', type: 'string'   },
     						{name : 'id4', type: 'string'   },
     						{name : 'id5', type: 'string'   },
     						{name : 'id6', type: 'string'   },
     						{name : 'id7', type: 'string'   },
     						{name : 'id8', type: 'string'   },
     						{name : 'id9', type: 'string'   },
     						{name : 'id10', type: 'string'   },
     						{name : 'id11', type: 'string'   },
     						{name : 'id12', type: 'string'   },
     						{name : 'id13', type: 'string'   },
     						{name : 'id14', type: 'string'   },
                        ],
                		 localdata: data1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#cliddetsearch").jqxGrid(
            {
                width: '99.5%',
                height: 450,
                source: dataAdapter,
                filterable: true,
                showfilterrow: true,
                enabletooltips:true,
                columnsresize: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                columns: [
                	{ text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',cellsrenderer: function (row, column, value) {
					    return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					}   },
							{ text: 'Doc No',  datafield: 'doc_no',width: '5%',hidden:true },
							{ text: 'Ac No',  datafield: 'acno',width: '5%' },
							{ text: 'Client Name', datafield: 'clname', width: '27%' },
							{ text: 'Uber ID D1', datafield: 'id1', width: '9%' }, 
							{ text: 'Careem ID D1', datafield: 'id2', width: '9%' }, 
							{ text: 'TID D1', datafield: 'id3', width: '9%' }, 
							{ text: 'Yango ID D1', datafield: 'id4', width: '9%' }, 
							{ text: 'DTC ID D1', datafield: 'id5', width: '9%' }, 
							{ text: 'Tally Ledger ID D1', datafield: 'id6', width: '9%' }, 
							{ text: 'Other ID D1', datafield: 'id7', width: '9%' }, 
							{ text: 'Uber ID D2', datafield: 'id8', width: '9%' }, 
							{ text: 'Careem ID D2', datafield: 'id9', width: '9%' }, 
							{ text: 'TID D2', datafield: 'id10', width: '9%' }, 
							{ text: 'Yango ID D2', datafield: 'id11', width: '9%' }, 
							{ text: 'DTC ID D2', datafield: 'id12', width: '9%' }, 
							{ text: 'Tally Ledger ID D2', datafield: 'id13', width: '9%' }, 
							{ text: 'Other ID D2', datafield: 'id14', width: '9%' }, 
						]
            });
            

        	$('.load-wrapp').hide();
          
        });
    </script>
    <div id="cliddetsearch"></div>
 