<%@page import="com.dashboard.audit.userroledetailed.ClsUserRoleDAO" %>
<%ClsUserRoleDAO urd=new ClsUserRoleDAO(); %>

<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<script type="text/javascript">
        
    var data1;
        $(document).ready(function () { 	
        	 
        	  
        	data1='<%=urd.userListLoading()%>';

         	var source =
            	{
                	datatype: "json",
                	datafields: [
     						{name : 'userid', type: 'string'},
     						{name : 'username', type: 'string'},
     						{name : 'email', type: 'string'},
     						{name : 'permission', type: 'string'},
     						{name : 'userrole', type: 'string'   },
     						{name : 'mobileno', type: 'string'   },
     						{name : 'discountlevel', type: 'string'   }
                            ],
                            localdata: data1,
                
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            });
            
            $("#jqxUserList").jqxGrid({
            	width: '100%',
                height: 540,
                source: dataAdapter,
                showfilterrow: true,
                filterable: true,
                selectionmode: 'singlecell',
                enabletooltips:true,
                editable: true,
                
                //Add row method
                handlekeyboardnavigation: function (event) {
                	var rows = $('#jqxUserList').jqxGrid('getrows');
                 	var rowlength= rows.length;
                    var cell = $('#jqxUserList').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'excel' && cell.rowindex == rowlength - 1) {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9) {                                                        
                            var commit = $("#jqxUserList").jqxGrid('addrow', null, {});
                            rowlength++;                           
                        }
                    }
                },
                
                       
                columns: [							
							{ text: 'Sr. No.', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'User Name', datafield: 'username', editable: false, width: '17%'},
							{ text: 'User ID', datafield: 'userid', editable: false, width: '10%'},
							{ text: 'User Role', datafield: 'userrole', width: '15%', align: 'left' },
							{ text: 'Email', datafield: 'email',  width: '17%', align: 'left' },
							{ text: 'Permission', datafield: 'permission',  width: '18%', align: 'left' },
							{ text: 'Mobile No', datafield: 'mobileno',  width: '10%', align: 'left' },
							{ text: 'Discount Level', datafield: 'discountlevel',  width: '8%', align: 'left' }
			              ]
            });
            $("#overlay, #PleaseWait").hide();
        });
</script>
<div id="jqxUserList"></div>
 