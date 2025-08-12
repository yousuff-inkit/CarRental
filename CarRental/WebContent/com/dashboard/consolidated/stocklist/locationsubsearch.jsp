<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 <%@page import="com.dashboard.consolidated.stocklist.ClsStocklistDAO"%>
 <% ClsStocklistDAO searchDAO = new ClsStocklistDAO(); 
 
String locname=request.getParameter("locname")==null?"0":request.getParameter("locname");
String aa=request.getParameter("aa")==null?"0":request.getParameter("aa");

//System.out.println("---aa--"+aa);


%>
<%-- <jsp:include page="../../../../includes.jsp"></jsp:include>  --%>
<script type="text/javascript">
 
$(document).ready(function () {
 
   var locurl;
   var temp='<%=aa%>';
   var locname='<%=locname%>';
   
   if(temp=='yes')
	   {
	   <%-- proddata='<%=searchDAO.locationSearch(session,docnoss,locname,aa)%>'; --%>
	   locurl = 'getlocationData.jsp?locname='+locname+'&aa='+temp;  
		 
	   }
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'loc_name',type:'String'},
                  		{name : 'address',type:'String'},
                  		{name : 'tel',type:'String'},
                  		{name : 'branchname',type:'String'},
                  		{name : 'company',type:'String'},

                  		
                  		
                  		],
				   // localdata: proddata,
				   url : locurl,    
        
        
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
    
    
    $("#locationSearch").jqxGrid(
    {
        width: '100%',
        height: 310,
        source: dataAdapter,
        showaggregates:true,
        filtermode:'excel',
       /*  showfilterrow: true,
        filterable: true, */
        enabletooltips:true,
        columnsresize:true,
        sortable:false,
        columns: [
               
				
       				{ text: 'Doc No',datafield:'doc_no',width:'10%',hidden:true},
       				{ text:'Location Name',datafield:'loc_name',width:'20%'},
       				{ text:'Address ',datafield:'address',width:'25%'},
       				{ text:'Telephone',datafield:'tel',width:'20%'},
       				{ text:'Branch',datafield:'branchname',width:'15%'},
       				{ text:'Company',datafield:'company',width:'20%'}
       
                  /* { text: 'Idle Days', datafield: 'vrent', width: '8%' }, */   
					]

    });
    
    $('#locationSearch').on('rowdoubleclick', function (event) 
    		{ 
    	
    	 var rowindex1 = event.args.rowindex;
         
            
        
         document.getElementById("txtlocation").value = $('#locationSearch').jqxGrid('getcellvalue', rowindex1, "loc_name");
         document.getElementById("locid").value = $('#locationSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");     
         document.getElementById("hidcompid").value = $('#locationSearch').jqxGrid('getcellvalue', rowindex1, "company");     
    	$('#locationDetailsWindow').jqxWindow('close');   
    	});
    

});

	
	
</script>
<!-- <div align="center" style="padding-bottom:4px;"><button type="button" id="btnproduct" name="btnok" class="myButton">OK</button>&nbsp;&nbsp;<button type="button" id="btncancel" name="btncancel" class="myButton" >Cancel</button></div> -->
<div id="locationSearch"></div>