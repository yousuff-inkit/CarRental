<%@page import="com.dashboard.marketing.crm.*"%>
<%
ClsCrmDAO cmd= new ClsCrmDAO();
%>
 <%
    String chk = request.getParameter("id")==null?"0":request.getParameter("id").trim();
    String salesmanid = request.getParameter("salesmanid")==null?"0":request.getParameter("salesmanid").trim();
 	String branchval = request.getParameter("brhid")==null?"0":request.getParameter("brhid").trim();
	String fromdate = request.getParameter("froms")==null?"0":request.getParameter("froms").trim();
  	String todate = request.getParameter("tos")==null?"0":request.getParameter("tos").trim();
  	String chkfollowup = request.getParameter("chkfollowup")==null?"0":request.getParameter("chkfollowup").trim();
    String followupdate = request.getParameter("followupdate")==null?"0":request.getParameter("followupdate").trim();
    String areaid =request.getParameter("areaid")==null?"0":request.getParameter("areaid").toString();
    String divname=request.getParameter("divname")==null?"":request.getParameter("divname").toString();
 %>  
           	  
<style type="text/css">
  .redClass {
       background-color: #FE9892; 
    }
    .blueClass {
       background-color: #B0E2FF; 
    }
     .pinkClass {
       background-color: #FBC4EC; 
    }
</style>

<script type="text/javascript">
var temp4='<%=branchval%>';
var enqdata,enqfollowupexcel;    

enqdata='<%=cmd.enquirylistsearch(session,branchval,fromdate,todate,chk,divname) %>';    

$(document).ready(function () { 
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
                     
                        {name : 'doc_no', type: 'String'  },
                        {name : 'voc_no', type: 'number'  },
                        {name : 'qotno', type: 'number'  },
                        {name : 'qottrno', type: 'number'  },
						{name : 'date', type: 'date'  },
						{name : 'type', type: 'String'  },
						{name : 'name', type: 'String'  },
						{name : 'remarks', type: 'String'  },
						{name : 'mob', type: 'String'},
						{name : 'salm', type: 'String'  },
						{name : 'site', type: 'String' },
						{name : 'area', type: 'String' },
						{name : 'fdate', type: 'date' },
						{name : 'source', type: 'String'  },
						{name : 'brch', type: 'String'  },
						{name : 'enqstat', type: 'String'  },
						{name : 'qotval', type: 'number' },
						{name : 'age', type: 'String'  },
						{name : 'enqtype', type: 'String'  },
						{name : 'telno', type: 'String'  },
						{name : 'sourceid', type: 'String'  },
						{name : 'contrmode', type: 'String' },
						{name : 'sjobtype', type: 'String' },
						
						{name : 'address', type: 'String'  },
						{name : 'cpersonid' , type: 'String'},
		                {name : 'cperson' , type: 'String'},  
		                {name : 'cldocno' , type: 'String'},  
		                {name : 'email' , type: 'String'}, 
		                {name : 'user' , type: 'String'},
		                {name : 'priority' , type: 'String'},
		                {name : 'ftype', type: 'String'  },
		                {name : 'dtype', type: 'String'  },
		                {name : 'qtype', type: 'String'  },
		                {name : 'brhid', type: 'String'},
		                {name : 'surdoc', type: 'String' },
		                {name : 'address', type: 'String'  },
		                {name : 'smapproval', type: 'String'  },
		                {name : 'pertel', type: 'String'},
	 						
			            {name : 'per_mob', type: 'String' },
			            {name : 'mail1', type: 'String' },
			            {name : 'salname', type: 'String' },
			            {name : 'sal_id', type: 'String' },
			            {name : 'surtrno', type: 'number' },
			            {name : 'enqstatus', type: 'String' },
				        {name : 'contrtype', type: 'String' },
				        {name : 'contactdet', type: 'String' },
				        {name : 'taxper', type: 'number' },
				        {name : 'branchname', type: 'number' },
				        {name : 'enqtypenw', type: 'number' },
				        {name : 'industry', type: 'number' },
				        {name : 'fdate', type: 'date'  },
				        {name : 'fstatus', type: 'String'},
				        {name : 'email', type: 'String'},
				        {name : 'details', type: 'String'},
				        {name : 'contrno', type: 'String'},
				        {name : 'status', type: 'String'},
				        {name : 'condocno', type: 'String'},
				        {name : 'designation', type: 'String'}, 
				        {name : 'qotstatus', type: 'String'},
				        
				    	{name : 'payterms', type: 'String'  },
				    	{name : 'groupcompanies', type: 'String'  },
				    	{name : 'billingmethod', type: 'String'  },
				    	{name : 'returned', type: 'number' },
				    	{name : 'flwupremarks', type: 'String'  },
				    	{name : 'calcvoc', type: 'String'  },
                        {name : 'enqsource', type: 'String'  },
                        {name : 'enqdocno', type: 'String'  },


						],
				    localdata: enqdata,
        
        
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
	 var cellclassname =  function (row, column, value, data) {
           var cldocno= $('#enqlistgrid').jqxGrid('getcellvalue', row, "cldocno");
           var qotstatus= $('#enqlistgrid').jqxGrid('getcellvalue', row, "qotstatus");
           var returned= $('#enqlistgrid').jqxGrid('getcellvalue', row, "returned");
    	   if(parseInt(cldocno)==0) {
    		    return "blueClass";  
    	   } 
    	   if(parseInt(qotstatus)<3) {   
      		   return "redClass";  
      		} 
    	   if(parseInt(returned)>0) {    
      		   return "pinkClass";  
      	   }
     }   
    $("#enqlistgrid").jqxGrid(
    {
        width: '99%',
        height: 280,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        showfilterrow: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columnsresize: true,
        enabletooltips: true,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '2%',cellclassname: cellclassname,
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },
                    { text: 'LPR No',datafield: 'voc_no', width: '4%' ,cellclassname: cellclassname },  
                    { text: 'LPR Date', datafield: 'date', width: '7%',cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
                    { text: 'Branch',datafield: 'branchname', width: '10%' ,cellclassname: cellclassname },
					{ text: 'Client',datafield: 'name' ,cellclassname: cellclassname},  
					{ text: 'Client Details',datafield: 'details', width: '10%' ,cellclassname: cellclassname},
					{ text: 'Status', datafield: 'status', width: '10%',cellclassname: cellclassname },
				    { text: 'QOT Flwup Date', datafield: 'fdate', width: '5%',hidden:true,cellsformat:'dd.MM.yyyy' ,cellclassname: cellclassname },
				    { text: 'QOT Status', datafield: 'fstatus', width: '5%',hidden:true,cellclassname: cellclassname }, 
				    { text: 'Flwup Remarks', datafield: 'flwupremarks', hidden:true,width: '8%',cellclassname: cellclassname },  
					{ text: 'Age (Hrs)', datafield: 'age', width: '4%' , cellsalign:'right',cellclassname: cellclassname },
					{ text: 'Salesman', datafield: 'salm', width: '8%',cellclassname: cellclassname },
					{ text: 'Quote No',datafield: 'calcvoc', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Qot Value',datafield: 'qotval', width: '6%' ,cellclassname: cellclassname,cellsalign:'right',align:'right',cellsformat:'d2',hidden:true },
					{ text: 'Application No',datafield: 'condocno', width: '5%' ,cellclassname: cellclassname },
					{ text: 'Contact person', datafield: 'cperson',hidden:true, width: '9%',cellclassname: cellclassname },
					{ text: 'Designation', datafield: 'designation',hidden:true, width: '9%',cellclassname: cellclassname },
				    { text: 'hidDoc No',datafield: 'doc_no', width: '6%',hidden:true ,cellclassname: cellclassname },
					{ text: 'Branch', datafield: 'brch', width: '11%',hidden:true,cellclassname: cellclassname },
					{ text: 'contrmode', datafield: 'contrmode', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'sjobtype', datafield: 'sjobtype', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'cpersonid', datafield: 'cpersonid', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'cldocno', datafield: 'cldocno', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'qottrno', datafield: 'qottrno', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'dtype', datafield: 'dtype', width: '20%',hidden:true ,cellclassname: cellclassname },  
					{ text: 'MOB', datafield: 'per_mob', width: '5%',hidden:true,cellclassname: cellclassname  },
					{ text: 'pertel', datafield: 'pertel', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'address', datafield: 'address', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'salid', datafield: 'sal_id', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'email', datafield: 'mail1', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'sourceid', datafield: 'sourceid', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'brhid', datafield: 'brhid', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'contrno', datafield: 'contrno', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'qotstatus', datafield: 'qotstatus', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'payterms', datafield: 'payterms', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'groupcompanies', datafield: 'groupcompanies', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'billingmethod', datafield: 'billingmethod', width: '20%',hidden:true ,cellclassname: cellclassname }, 
					{ text: 'returned', datafield: 'returned', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'Source', datafield: 'source', width: '6%',hidden:true,cellclassname: cellclassname },
					{ text: 'Remarks', datafield: 'remarks', width: '11%',cellclassname: cellclassname },  
					{ text: 'calcvoc', datafield: 'qotno', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'enqsource', datafield: 'enqsource', width: '20%',hidden:true ,cellclassname: cellclassname },
					{ text: 'enqdocno', datafield: 'enqdocno', width: '20%',hidden:true ,cellclassname: cellclassname },

					]
   
    });
    $('.load-wrapp').hide();
    $('#enqlistgrid').on('rowdoubleclick', function (event) { 
   	  var rowindex1=event.args.rowindex;
   
   	 var cldoc=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
   	 document.getElementById("txtsource").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "source");
	 document.getElementById("sourceid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sourceid");
   	 if(parseInt(cldoc)==0){
   		 $('#btncreateclient').attr("disabled",false); 
   		 document.getElementById("txtclientnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
   	     document.getElementById("txtaddressnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
	     document.getElementById("txtmobnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");	  
	     document.getElementById("txtemailnw").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");  
	     document.getElementById("salmanid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id");    
   	  } else{
   		 $('#btncreateclient').attr("disabled",true);
   	  }  
   	
  	document.getElementById("ldate").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "date"); 
  	
  	document.getElementById("enqsource").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "enqsource"); 
  	document.getElementById("enqdoc").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "enqdocno"); 

	document.getElementById("lprvocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
    document.getElementById("lprdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
    document.getElementById("qotdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qotno");
    document.getElementById("appldocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "condocno"); 
	document.getElementById("qotvocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "calcvoc"); 

    document.getElementById("qottrno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
   	  document.getElementById("surveydocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "surdoc"); 
  	  document.getElementById("reportdocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "voc_no"); 
  
	  document.getElementById("brhid1").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "brhid");
	  
	  document.getElementById("client").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name");
	  document.getElementById("cldocno").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cldocno");
	  document.getElementById("address").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "address");
	  document.getElementById("hidremarks").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "remarks");

	  document.getElementById("pertel").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "pertel");
	  document.getElementById("per_mob").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "per_mob");
	  
	  document.getElementById("mail1").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "mail1");
	  document.getElementById("salname").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "salm");
	  document.getElementById("salid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "sal_id"); 
	  
	
	  document.getElementById("hidpayterms").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "payterms"); 
	  document.getElementById("hidgroupcompanies").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "groupcompanies"); 
	  document.getElementById("hidbillingmethod").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "billingmethod");  
	  document.getElementById("hidcperson").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cperson");   
	  document.getElementById("hidcpersonid").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "cpersonid");
	  document.getElementById("hiddesignation").value=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "designation");
	  
	  var enqdocno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "doc_no");  
	  var qottrno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "qottrno");
	  $("#detailDiv").load("detailGrid.jsp?doc="+qottrno+"&enqdocno="+enqdocno);       
	  
	  
	  var contrno=$('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "condocno");
	  if(contrno!="" && contrno!="0"){  
	     $('#btnconfirm').attr("disabled",false);  
      }
      $('.textpanel p').text( $('#enqlistgrid').jqxGrid('getcellvalue', rowindex1, "name"));

	  $('.comments-container').html('');  
      });   
});
</script>
<div id="enqlistgrid"></div>