<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.operations.agreementdriverlist.ClsAgreementDriverListDAO" %>
 <%
 ClsAgreementDriverListDAO viewDAO= new ClsAgreementDriverListDAO();
	 
   	String type = request.getParameter("type")==null?"0":request.getParameter("type").trim();
   	String multidriver = request.getParameter("multidriver")==null?"":request.getParameter("multidriver")==""?"0":request.getParameter("multidriver").trim();
   	String id = request.getParameter("id")==null?"":request.getParameter("id")==""?"0":request.getParameter("id").trim();

  %> 

 <script type="text/javascript">
 
 var temp1='<%=multidriver%>';
 var id='<%=id%>';
var aa=0;
 var datadri="";
 
  if(temp1=="1")
	  {
//alert("in");
	  datadri= '<%=viewDAO.loadMultiDriver(multidriver,type)%>';  
	  }
   else 
	  {

		  datadri= '<%=viewDAO.reloadDriver(type,multidriver)%>'; 
 
	  }
	 
 
  $(document).ready(function(){
        
        var source = 
        {
            datatype: "json",
            datafields: [
           	 {name : 'agmtno', type: 'string'  },
        	 {name : 'refname', type: 'string'  },
			 {name : 'odate', type: 'date'    },
           	 {name : 'otime', type: 'string'  },
           	 {name : 'type', type: 'string'  },

            	 {name : 'name1', type: 'string'  },
					{name : 'dob1', type: 'date'    },
					{name : 'nation1', type: 'string'    },
					{name : 'mobno1', type: 'string'    },
					{name : 'dlno1', type: 'string'    },
					{name : 'issdate1', type: 'date'    },
					{name : 'led1', type: 'date' },
					{name : 'ltype1', type: 'string'    },
					{name : 'issfrm1', type: 'string'    },
					{name : 'passport_no1', type: 'string' },
					{name : 'pass_exp1', type: 'date'    },
					{name : 'visano1', type: 'string'    },
					{name : 'visa_exp1', type: 'date'    },
					{name : 'hcdlno1', type: 'string'    },
					{name : 'hcissdate1', type: 'date'    },
					{name : 'hcled1', type: 'string'    },
					{name : 'age1', type: 'number'    },
					{name : 'drage1', type: 'number'    },
					{name : 'licyr1', type: 'number'    },
					{name : 'expiryear1', type: 'number'},
					{name : 'doc_no1', type: 'number'},
					{name : 'counts', type: 'number'},

                      	
                      	
                      	
             ],
             localdata: datadri,
            
            
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



        $("#jqxgrid2").jqxGrid(
                {
                	width: '100%',
                    height: 550,
                    source: dataAdapter,
                    showfilterrow: true,
                    filterable: true,
                    selectionmode: 'singlerow',
                    sortable: true,
                    editable: false,
                    altrows:true,
                    enabletooltips:true,
                    //Add row method
                    columns: [
                    	 { text: 'SL#', sortable: false, filterable: false, editable: false,
                             groupable: false, draggable: false, resizable: false,
                             datafield: '', columntype: 'number', width: '4%',
                             cellsrenderer: function (row, column, value) {
                                 return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                             }  
                           },	
							{ text: 'Agreement No', datafield: 'agmtno', width: '6%', },
							{ text: 'Client ', datafield: 'refname',  },
							{ text: 'Out Date', datafield: 'odate', width: '6%',cellsformat: 'dd-MM-yyyy'},
							{ text: 'Out Time', datafield: 'otime', width: '4%'},
							{ text: 'Type', datafield: 'type', width: '3%'},
							{ text: 'Name', datafield: 'name1', width: '12%', },
							{ text: 'Date of Birth', datafield: 'dob1', width: '5%',cellsformat: 'dd-MM-yyyy'},
							{ text: 'Age', datafield: 'age1', width: '3%'},
							{ text: 'dbage', datafield: 'drage1', width: '3%' ,hidden:true },
							{ text: 'Nationality', datafield: 'nation1', width: '5%' },
							{ text: 'Mob No', datafield: 'mobno1', width: '5%' },
							{ text: 'Licence#', datafield: 'dlno1', width: '5%' },
							{ text: 'Lic Issued', datafield: 'issdate1', width: '5%',cellsformat: 'dd-MM-yyyy' },
							{ text: 'dbLic Issued', datafield: 'licyr1', width: '9%' ,hidden:true },
							{ text: 'calcuLic Issued', datafield: 'expiryear1', width: '9%' ,hidden:true },
							{ text: 'Lic Expiry', datafield: 'led1', width: '5%',cellsformat: 'dd-MM-yyyy' },
							{ text: 'Lic Type', datafield: 'ltype1', width: '4%' },
							{ text: 'Iss From', datafield: 'issfrm1', width: '5%' },
							{ text: 'Passport#', datafield: 'passport_no1', width: '5%' },
							{ text: 'Pass Exp.', datafield: 'pass_exp1', width: '5%',cellsformat: 'dd-MM-yyyy' }, 
						 	{ text: 'doc_no', datafield: 'dr_id1', width: '2%',hidden:true},
						 	{ text: 'count', datafield: 'counts', width: '2%',hidden:true},
    	              ]
                });
        $('.load-wrapp').hide(); 
        if(aa==1)
        	{
   	 $("#jqxgrid2").jqxGrid('addrow', null, {}); 
        	}
    	
	});
</script>
<div id="jqxgrid2"></div>