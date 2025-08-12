<%@page
	import="com.controlcentre.masters.satmasters.ClsSatMastersAction"%>
<%
	ClsSatMastersAction csa = new ClsSatMastersAction();
System.out.println("test on search");
%>
<script type="text/javascript">
  		
  		var data= '<%=csa.searchDetails()%>';
        
  		$(document).ready(function () { 
            var source =
            {
                datatype: "json",
                datafields: [
                          	{name : 'DOC_NO' , type: 'number' },
                          	{name : 'remarks',type:'String'},
     						{name : 'username', type: 'String'  },
     						{name : 'password',type:'String'},
                          	{name : 'tcno', type: 'String'  },
                          	{name : 'time_period', type: 'String'  },
                          	{name : 'Site', type: 'String'  },
                          	{name : 'iscaptcha',type:'number'},
                          	{name : 'sqno',type:'String'},
                          	{name : 'rta',type:'number'}
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
            $("#jqxStaffSearch").jqxGrid(
            {
            	width: '99%',
                height: 302,
                source: dataAdapter,
                sortable: true,
                filtermode:'excel',
                filterable: true,
                selectionmode: 'singlerow',
                columnsresize: true,
                showfilterrow:true,
                
                columns: [
					{ text: 'Doc No', datafield: 'DOC_NO', width: '10%' },
					{ text: 'Remarks',datafield:'remarks',width:'15%'},
					{ text: 'User Name', datafield: 'username', width: '36%' },
					{ text: 'Password',datafield:'password',width:'35%',hidden:true},
					{ text: 'TC No', datafield: 'tcno', width: '7%',hidden:true },
					{ text: 'Time Period', datafield: 'time_period', width: '18%' },
					{ text: 'Site', datafield: 'Site', width: '6%' },
					{ text: 'Is Captcha',datafield:'iscaptcha',width:'5%',hidden:true},
					{ text: 'Sq No',datafield:'sqno',width:'15%'},
					{ text: 'RTA',datafield:'rta',width:'5%',hidden:true}

					]
            });
            $('#jqxStaffSearch').on('rowdoubleclick', function (event) {
                var rowindex1=event.args.rowindex;
                document.getElementById("docno").value= $('#jqxStaffSearch').jqxGrid('getcellvalue', rowindex1, "DOC_NO"); 
                document.getElementById("txtuser").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "username");
                document.getElementById("txtusername").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "password");
                document.getElementById("remarks").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "remarks");
                document.getElementById("tcno").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "tcno");
                document.getElementById("hidCaptcha").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "iscaptcha");
                document.getElementById("sqno").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "sqno");
                document.getElementById("hidsite").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "hidsite");
                document.getElementById("hidRta").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "rta");
                document.getElementById("site").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "Site");
                document.getElementById("txtperiod").value = $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "time_period");
                var rta=$("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "rta");
                var capthc=$("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "iscaptcha");
                if(rta==1){
                 	   document.getElementById('rta').checked = true;
                
                }else{
                                 	   document.getElementById('rta').checked = false;
                
                }
                if(capthc==1){
                 	   document.getElementById('captch').checked = true;
                
                }else{
                                 	   document.getElementById('captch').checked = false;
                
                }
                var code=$('#formdetailcode').val().trim();
              //  var doc=document.getElementById("docno").value;
              /*  if(document.getElementById("docno").value>0){
                	$('#staffdiv').load("driver2.jsp?docno="+doc+"&dtype="+code);
                }*/

              //  $("#staffdate").jqxDateTimeInput('val', $("#jqxStaffSearch").jqxGrid('getcellvalue', rowindex1, "date"));
                
                $('#window').jqxWindow('hide');
            }); 
         
        });
</script>
<div id="jqxStaffSearch"></div>
