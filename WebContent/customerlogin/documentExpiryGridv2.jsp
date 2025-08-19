<%@page import="customerlogin.ClsCustomerLoginDAO"%>


<% String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
String acno = request.getParameter("acno")==null?"0":request.getParameter("acno").trim();
String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();  
ClsCustomerLoginDAO cild=new ClsCustomerLoginDAO();%>            
<style>
 		.redClass
        {
            background-color: #FFEBEB;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .orangeClass
        {
            background-color: #FFEBC2;
        }
        .violetClass
        {
            background-color: #F5EEF8;
        }
        .whiteClass
        {
           background-color: #fff;
        }
        .folllowUpClass
	    {
	      background-color: #E0F8F1;
	    }
	    	    
</style>
        
<script type="text/javascript">
      var docexpdata;
      var id='<%=id%>';
      if(id=="1"){
    	  docexpdata='<%=cild.documentExpiryGridv2(fromDate,toDate,acno,id)%>';    
      }
      
      var dochtml='';
      $.each(JSON.parse(docexpdata),function(index,value){
      	dochtml+='<tr>';
      	dochtml+='<td>'+value.name+'</td>';
      	dochtml+='<td>'+value.per_mob+'</td>';
      	dochtml+='<td>'+value.sal_name+'</td>';
      	dochtml+='<td>'+value.document+'</td>';
      	dochtml+='<td>'+value.expirydate+'</td>';
      	dochtml+='</tr>';
      });
      $('.tbl-docexlist tbody').html($.parseHTML(dochtml));

      
      
      
        $(document).ready(function () {
        	
        	
        	var source =
            {
                datatype: "json",
                datafields: [
                	{name : 'refname', type: 'String'  },
                	{name : 'name', type: 'String'  },
				    {name : 'per_mob' , type: 'String' },
				    {name : 'sal_name', type: 'String'  },
				    {name : 'document' , type: 'String' },
				    {name : 'expirydate', type: 'date'  },
				    {name : 'followupdate', type: 'date'  },
				    {name : 'cldocno', type: 'int'  },
				    {name : 'sr_no', type: 'int'  },
				    {name : 'brhid', type: 'int'  },
				    {name : 'clientinfo', type: 'string'  }
				
	            ],
                localdata: docexpdata,
               
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
        	
        	var cellclassname = function (row, column, value, data) {
        		if (data.document == 'Licence Expired') {
                    return "redClass";
                } else if (data.document == 'Passport Expired') {
                    return "yellowClass";
                } else if (data.document == 'Trade Licence Expired') {
                    return "orangeClass";
                } else if (data.document == 'ID Expired') {
                    return "violetClass";
                } else{
                	return "whiteClass";
                };
            };
        	
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
         /*   $("#documentExpiry").jqxGrid(
            {
                width: '98%',
                height: 400,
                source: dataAdapter,
                filtermode:'excel',
                filterable: true,
                sortable: true,
                rowsheight:25,
                selectionmode: 'singlerow',
                editable: false,
                
                columns: [
                	{ text: 'Client', datafield: 'refname' , width: '30%',hidden:true},
					{ text: 'Doc No', datafield: 'cldocno', width: '10%',hidden:true },
					{ text: 'Name', datafield: 'name', width: '30%' },
					{ text: 'Mobile No.', datafield: 'per_mob', width: '15%' },
					{ text: 'Salesman', datafield: 'sal_name', width: '12%' },
					{ text: 'Document', datafield: 'document', cellclassname: cellclassname,  width: '30%' },
					{ text: 'Expiry Date', datafield: 'expirydate', cellclassname: cellclassname,  cellsformat: 'dd.MM.yyyy' , width: '13%' },
					{ text: 'Follow-Up Date', datafield: 'followupdate', cellclassname: 'folllowUpClass',  cellsformat: 'dd.MM.yyyy' , width: '10%',hidden:true },
					{ text: 'Driver SrNo.', datafield: 'sr_no', hidden: true, width: '10%' },
					{ text: 'Branch Id', datafield: 'brhid', hidden: true, width: '10%' },
					{ text: 'Client Info', datafield: 'clientinfo', hidden:true, width: '10%' },
					 ]
            });*/
            
            
            $("#overlay, #PleaseWait").hide();
       
  });
                       
</script>
<div id="documentExpiry"></div>