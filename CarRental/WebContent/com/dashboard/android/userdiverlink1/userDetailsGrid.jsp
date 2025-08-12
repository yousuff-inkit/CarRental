
 
 <%@page import="com.dashboard.android.userdiverlink1.*"%>
 <%
 	ClsUserDriverLinkDAO searchDAO= new ClsUserDriverLinkDAO();
 	    //String barchval = request.getParameter("barchval")==null?"":request.getParameter("barchval").trim();
 	    String barchval = "1";
 	    String acno = request.getParameter("cldoc")==null?"":request.getParameter("cldoc").trim();
 	    String check = request.getParameter("check")==null?"":request.getParameter("check").trim();
 	    String rx = request.getParameter("rx")==null?"":request.getParameter("rx").trim();
 	    System.out.println("Acc no :"+check);
 %> 
       
 
<script type="text/javascript">
var datas;
var rx1='<%= rx%>'
$(document).ready(function () {
	
	 datas= '<%=searchDAO.userlistsearch(barchval,acno,check,rx) %>'; 
	 
    var source =
    {
        datatype: "json",
        datafields: [   
                     
 
                     {name : 'username', type: 'string'  },
                     {name : 'doc_no', type: 'int'  },
                     {name : 'email', type: 'string'  },
                     {name : 'mobile_no', type: 'number'  },
                     {name : 'sal_name', type: 'string'  },
                     
						 
						
						],
				    localdata: datas,
        
        
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
    
    
    $("#userlist").on("bindingcomplete", function (event) {
    
    	
    	
    	
    	
    });
   
    
    $("#userlist").jqxGrid(
    {
        width: '98%',
        height: 455,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        enabletooltips:true,
        showfilterrow:true,
        selectionmode: 'singlecell',
        pagermode: 'default',
        editable:true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                    { text: 'User Name',datafield: 'username', editable: false },
                    { text: 'userdoc',datafield: 'doc_no',hidden:true, width: '4%', editable: false },  
                    { text: 'Email',datafield: 'email',  editable: false },  
                    { text: 'Mobile No',datafield: 'mobile_no',  editable: false },  
                    { text: 'Driver Name',datafield: 'sal_name',  editable: false },  
                    
					]
   
    });
    $('#userlist').on('rowdoubleclick', function (event){
        var rowindex1=event.args.rowindex;
        document.getElementById("userid").value=$('#userlist').jqxGrid('getcellvalue', rowindex1, "doc_no");

    });
    
    $("#overlay, #PleaseWait").hide();
    
   
});


</script>
<div id="userlist"></div>