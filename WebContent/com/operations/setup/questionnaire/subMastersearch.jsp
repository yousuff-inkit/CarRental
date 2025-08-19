<%-- <%
String item = request.getParameter("item")==null?"NA":request.getParameter("item");

%> --%>
<%@page import="com.operations.setup.questionnaire.ClsquestionnaireDAO" %>
<%
 ClsquestionnaireDAO DAO= new ClsquestionnaireDAO();        
 %>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %> 
<%

String msdocno = request.getParameter("msdocno")==null?"0":request.getParameter("msdocno");
 String enqdate = request.getParameter("enqdate")==null?"0":request.getParameter("enqdate");
 String aa = request.getParameter("aa")==null?"NA":request.getParameter("aa"); 
%> 

 <script type="text/javascript">
 
 var enqmasterdata; 
 
 
  enqmasterdata='<%=DAO.searchMaster(session,msdocno,enqdate,aa)%>';

  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                   	{name : 'doc_no' , type: 'number' },
                   	{name : 'date' , type: 'date' },
                    {name : 'questionnaire' , type: 'String' },
                    {name : 'chkbx' , type: 'String' },
                 
						
                   	],
          localdata: enqmasterdata,
         
         
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
     $("#subEnqirySearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
       
         altRows: true,
        
         selectionmode: 'singlerow',
         pagermode: 'default',
      

         columns: [
              
                 
				{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
				{ text: 'Date', datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
				/* { text: 'Typeid', datafield: 'typeid', width: '20%',hidden:true },  
				{ text: 'Type', datafield: 'type', width: '25%' },
				 */{ text: 'Questionnaire', datafield: 'questionnaire' },
				{ text: 'chkbox', datafield: 'chkbx', width: '20%',hidden:true},
				]
     });
     

     $('#subEnqirySearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
      
   		$('#date').jqxDateTimeInput({ disabled: false});
      	 $('#date').val($("#subEnqirySearch").jqxGrid('getcellvalue', rowindex1, "date")) ;
             document.getElementById("txtquestion").value=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "questionnaire"); 
             document.getElementById("docno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
              document.getElementById("chkcomagent").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "chkbx");
              var chkamagent=$('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "chkbx");
  			if(chkamagent>0){
  				document.getElementById("chkcomagent").checked=true;
  			}
            /*   document.getElementById("servicedocno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "servicetypeid");
              document.getElementById("servicetype").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "groupname");
              document.getElementById("txttype").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "type");
              document.getElementById("txtdocno").value= $('#subEnqirySearch').jqxGrid('getcellvalue', rowindex1, "typeid");
        */  /*  document.getElementById("gridval").value=1; */                  
         $('#window').jqxWindow('close');      
     	 $('#date').jqxDateTimeInput({ disabled: false}); 
     	$("#inddiv").load("questionnaireGrid.jsp?docno="+$("#subEnqirySearch").jqxGrid('getcellvalue',rowindex1,"doc_no"));
         document.getElementById("frmQuestionnaire").submit();          
      });	 
     
     
 });
</script>
<div id="subEnqirySearch"></div>

    
    </body>
</html>
