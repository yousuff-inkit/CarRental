<%@page import="com.dashboard.analysis.taskmanagement.ClsTaskManagementDAO"%>
<%ClsTaskManagementDAO DAO= new ClsTaskManagementDAO(); %>
<%  String userid = request.getParameter("userid")==null?"0":request.getParameter("userid").toString();
    String id = request.getParameter("id")==null?"":request.getParameter("id").toString();
    String fromdate = request.getParameter("fromdate")==null?"":request.getParameter("fromdate").toString();
    String todate = request.getParameter("todate")==null?"":request.getParameter("todate").toString();
    String fromdtchk = request.getParameter("fromdtchk")==null?"":request.getParameter("fromdtchk").toString();%>                    
<script type="text/javascript">          
var pdata;         
  pdata='<%=DAO.pendingGrid(userid, fromdate, todate, fromdtchk, id) %>';                                          
 
$(document).ready(function(){  

        var source =
        {
            datatype: "json",            
            datafields: [   
                        {name : 'crtuser', type: 'string'},     
                        {name : 'userid', type: 'string'},      
                        {name : 'ass_user', type: 'string'},  
                      	{name : 'doc_no', type: 'string'},
 						{name : 'ref_type', type: 'string'},
 						{name : 'ref_no', type:'string'},
 						{name : 'edcdate',type:'date'},   
 						{name : 'strt_date',type:'date'},
 						{name : 'strt_time',type:'string'},
                      	{name : 'description', type: 'string'},      
                      	{name : 'status',type:'string'}, 
                      	{name : 'user',type:'string'}, 
                      	{name : 'slno',type:'string'}, 
             ],
             localdata: pdata,
            
            
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



        $("#pendingGrid").jqxGrid(  
                {
                	width: '100%',
                    height: 250,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                  	editable:false,
                    altrows:true,
                    enabletooltips:true,
                    columnsresize: true, 
                    columns: [            
                    	{ text: 'Sl.No',datafield: 'slno', width: '4%'},             
    					{ text: 'Doc No',datafield: 'doc_no', width: '4%',hidden:true},            
    					{ text: 'Type',datafield: 'ref_type', width: '6%'},            
    					{ text: 'Ref.No',datafield: 'ref_no', width: '4%'},  
    					{ text: 'User',datafield: 'user', width: '12%'}, 
    					{ text: 'EDC',datafield: 'edcdate', width: '6%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'St.Date',datafield: 'strt_date', width: '6%',cellsformat:'dd.MM.yyyy'},
    					{ text: 'St.Time',datafield: 'strt_time', width: '6%',cellsformat:'dd.MM.yyyy HH:mm:ss'},         
    					{ text: 'Description',datafield: 'description'},  
    					{ text: 'Created User',datafield: 'crtuser', width: '12%'}, 
    					{ text: 'Status',datafield: 'status', width: '8%'}, 
    					{ text: 'Assignuser',datafield: 'ass_user', width: '12%',hidden:true},  
    					{ text: 'createuser',datafield: 'userid', width: '12%',hidden:true},
    	              ]                                         
                }); 
	        $('#pendingGrid').on('rowdoubleclick', function (event) {      
	            
	            var rowindex2 = event.args.rowindex;                        
	            document.getElementById("docno").value = $('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "doc_no");
	            $('.textpanel p').text($('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "ref_type")+" - "+$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "ref_no")+" - "+$('#pendingGrid').jqxGrid('getcellvalue', rowindex2, "user"))
	            subLoad() 
	        });          
	});
</script>
<div id="pendingGrid"></div>