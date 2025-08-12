<%@page import="com.limousine.limobooking.*" %>
<%
String docno=request.getParameter("docno")==null?"0":request.getParameter("docno");
String cldocno=request.getParameter("clientid")==null?"0":request.getParameter("clientid");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
ClsLimoBookingDAO limodao=new ClsLimoBookingDAO();
%> 


 <script type="text/javascript">
 var id='<%=id%>';
 if(id=="1"){
	 var guestdata='<%=limodao.getGuestGridData(docno,cldocno,id)%>'; 
 }
	 
        $(document).ready(function () { 
         //	var url1;
        	 
        		//  url1='disclient.jsp'; 
        		 
        	
            var source = 
            {
                datatype: "json",
                datafields: [

     						{name : 'doc_no', type: 'String'  },
     						{name : 'guest', type: 'String'  },
     						{name : 'guestcontactno', type: 'String'  }      						
      					
                          	],
                          	localdata: guestdata,
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
            $("#guestgrid").jqxGrid(
            {
                width: '100%',
                height: 120,
                source: dataAdapter,
                filterable: true,
                columnsresize: true,
                selectionmode: 'singlerow',
            
                columns: [
                	 { text: 'Sr. No.',datafield: '',columntype:'number', width: '5%',editable:false, cellsrenderer: function (row, column, value) {
                         return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                  	}},
					{ text: 'Doc No', datafield: 'doc_no', width: '20%',hidden:true },
					{ text: 'Guest', datafield: 'guest', width: '50%' },
					{ text: 'Contact No', datafield: 'guestcontactno', width: '44%'}
					]
            });
    
			$('#guestgrid').on('rowdoubleclick', function (event) 
				{ 
				
        
            }); 
			
			 /*Delete Row*/
            $("#popupWindow2").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
            
            // create context menu
               var contextMenu = $("#Menu2").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
               $("#guestgrid").on('contextmenu', function () {
                   return false;
               });
               
            $("#Menu2").on('itemclick', function (event) {
                var rowindex = $("#guestgrid").jqxGrid('getselectedrowindex');
                    
                var rowid = $("#guestgrid").jqxGrid('getrowid', rowindex);
                $("#guestgrid").jqxGrid('deleterow', rowid);
            });
            
            $("#guestgrid").on('cellclick', function (event) {
                if (event.args.rightclick) {
                    $("#guestgrid").jqxGrid('selectrow', event.args.rowindex);
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);

                    return false;
                }
            });
            /*Delete Row Ends*/
				       
        });               
    </script>
    <div id='jqxWidget'>
    <div id="guestgrid"></div>
     <div id="popupWindow2">
 
 <div id='Menu2'>
    <ul>
        <li>Delete Selected Row</li>
    </ul>
</div>       
</div>
</div>
<input type="hidden" id="rowindex"/> 
    