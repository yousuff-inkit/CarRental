<%@page import="com.operations.setup.questionnaire.ClsquestionnaireDAO" %>
<%
 ClsquestionnaireDAO DAO= new ClsquestionnaireDAO();   

String docno = request.getParameter("docno")==null?"0":request.getParameter("docno").trim();

 %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<% String contextPath=request.getContextPath();%>
 

    <script type="text/javascript">
    var data;  
    data='<%=DAO.indGridLoad(session,docno)%>';     
    $(document).ready(function () {     	    
            var source =
            {
                datatype: "json",
                datafields: [      
                         	{name : 'srno',type:'String'},
                        	//{name : 'doc_no' , type: 'String' },
                          	{name : 'answer',type:'String'},
                          	{name : 'points',type:'String'},
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
            $("#jqxquesgrid").jqxGrid(
            {
                width: '100%', 
                height: 300,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                sortable: true,
                editable:true,
                //Add row method
	
                columns: [
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,
                              datafield: 'srno', columntype: 'number', width: '5%',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }
					},
					/* {text: 'DOC_NO',datafield:'doc_no',editable:false, width: '8%'},
					{text: 'date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy' ,editable:false }, */
					{text: 'Answer',datafield:'answer'},
					{text: 'Points',datafield:'points',width:'10%',hidden:true},   
					]
            });  
                 
            $('#jqxquesgrid').on('celldoubleclick', function (event) 
              		{
  		            	var rowindex1=event.args.rowindex;  
  		            	var datafield = event.args.datafield;
  		                if(datafield=="answer")
  		                {
  		            	 $("#jqxquesgrid").jqxGrid('addrow', null, {}); 
  		             }
              		}); 
          //$("#jqxquesgrid").jqxGrid('addrow', null, {});
        });    
    </script>
    <div id="jqxquesgrid"></div>
