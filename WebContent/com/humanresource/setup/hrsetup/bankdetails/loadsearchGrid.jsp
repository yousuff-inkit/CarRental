 <%@page import="com.humanresource.setup.hrsetup.bankdetails.ClsBankdetailsDAO"%>
<% ClsBankdetailsDAO DAO = new ClsBankdetailsDAO(); %>


<script type="text/javascript"> 

	$(document).ready(function () {    
		
  var deptdata1= '<%=DAO.loadgrid() %>'; 
	  var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'ifsccode', type: 'String'  },
                          	{name : 'date', type: 'date'  },
                          	{name : 'brchname', type: 'String'  },
                        	{name : 'remarks', type: 'String'  }
                            
                 ],
               	 localdata: deptdata1,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
	    
	        var dataAdapter = new $.jqx.dataAdapter(source);
    
            $("#loadsearchgrid").jqxGrid(
                  {
                	  width: '100%',
                      height: 320,
                      source: dataAdapter,
                      selectionmode: 'singlerow',
                      localization: {thousandsSeparator: ""},
                      filterable:true,
                      showfilterrow:true,
                      
                    columns: [
	        					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
	        					{ text: 'Date', datafield: 'date', width: '12%',cellsformat:'dd.MM.yyyy' },
	        					{ text: 'IFSC Code', datafield: 'ifsccode', width: '15%' },
	        					{ text: 'Branch Name', datafield: 'brchname',width:'30%' },
	        					{ text: 'Remarks', datafield: 'remarks' },
	             	           
	        					]
                    });
            
            $('#loadsearchgrid').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
            
            $("#bankdate").jqxDateTimeInput('val', $("#loadsearchgrid").jqxGrid('getcellvalue', rowindex1, "date"));
            document.getElementById("docno").value= $('#loadsearchgrid').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
            document.getElementById("brchname").value = $("#loadsearchgrid").jqxGrid('getcellvalue', rowindex1, "brchname");
            document.getElementById("ifsccode").value = $("#loadsearchgrid").jqxGrid('getcellvalue', rowindex1, "ifsccode");
            document.getElementById("remarks").value = $("#loadsearchgrid").jqxGrid('getcellvalue', rowindex1, "remarks");
            
            $('#window').jqxWindow('close');
            }); 
	}); 
	</script>
	
	<div id="loadsearchgrid"></div>
 