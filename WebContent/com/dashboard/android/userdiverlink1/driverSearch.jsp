 <%@page import="com.dashboard.android.userdiverlink1.ClsUserDriverLinkDAO"%>
<%@ page import="com.controlcentre.masters.salesmanmaster.driver.ClsDriverAction" %>

<%
	//ClsDriverAction cda= new ClsDriverAction();
ClsUserDriverLinkDAO cda=new ClsUserDriverLinkDAO();
%> 

<script type="text/javascript">
  		
  	var data= '<%=cda.searchDetails() %>';
    
  	   $(document).ready(function () { 	
             
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'doc_no' , type: 'number' },
     						{name : 'sal_code', type: 'String'  },
                          	{name : 'sal_name', type: 'String'  },
                          	{name : 'date', type: 'String'  },
                          	{name : 'acc_no', type: 'String'  },
                          	{name : 'acdoc', type: 'String'  },
                          	{name : 'mail',type:'String'},
                          	{name : 'description', type: 'String'  },

				{name : 'external', type: 'int'  }

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
            $("#jqxDriverSearch").jqxGrid(
            {
            	width: '100%',
                height: 340,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'doc_no', width: '10%' },
					{ text: 'Code', datafield: 'sal_code', width: '15%' },
					{ text: 'Name', datafield: 'sal_name', width: '40%' },
					{ text: 'Acc No', datafield: 'acc_no', width: '40%' },
					{ text: 'Account Name', datafield: 'description', width: '35%' },
					{ text: 'Mail',datafield:'mail',width:'35%',hidden:true},
					{ text: 'Date',datafield:'date',width:'35%',cellsformat:'dd.MM.yyyy',hidden:true},

					{ text: 'External',datafield:'external',width:'35%',hidden:true}

					]
            });
            $('#jqxDriverSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
               
                
                
                document.getElementById("acno").value = $('#jqxDriverSearch').jqxGrid('getcellvalue', rowindex1, "doc_no");
            
             	document.getElementById("account").value = $('#jqxDriverSearch').jqxGrid('getcellvalue', rowindex1, "description");
              $('#accountSearchwindow').jqxWindow('close');  



                //document.getElementById("licenseno").value = $("#jqxDriverSearch").jqxGrid('getcellvalue', rowindex1, "lic_no");
              //  var code=$('#formdetailcode').val().trim();
               /*  var doc=document.getElementById("docno").value;
                if(document.getElementById("docno").value>0){
                	$('#driverdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
                } */
                
              /*   $("#driverdate").jqxDateTimeInput('val', $("#jqxDriverSearch").jqxGrid('getcellvalue', rowindex1, "date"));
               // $("#licenseexpiry").jqxDateTimeInput('val', $("#jqxDriverSearch").jqxGrid('getcellvalue', rowindex1, "lic_exp_dt"));
				document.getElementById("mail").value=$("#jqxDriverSearch").jqxGrid('getcellvalue', rowindex1, "mail"); */
               
                
            }); 
         
        });
</script>
<div id="jqxDriverSearch"></div>
