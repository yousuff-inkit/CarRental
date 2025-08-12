<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.driver.ClsIMDriverDAO"%>
<% ClsIMDriverDAO DAO= new ClsIMDriverDAO(); %> 
<% 
   String department = request.getParameter("department")==null?"0":request.getParameter("department");
   String category = request.getParameter("category")==null?"0":request.getParameter("category");
   String empId = request.getParameter("empId")==null?"0":request.getParameter("empId");
   String employeebranchchk = request.getParameter("employeebranchchk")==null?"0":request.getParameter("employeebranchchk"); 
   String branch = request.getParameter("branch")==null?"0":request.getParameter("branch");
   String check = request.getParameter("check")==null?"0":request.getParameter("check"); %> 

 <script type="text/javascript">
 

	var data;
	var dataExcelExport;
 $(document).ready(function () { 	  
 	
 		
 		data='<%=DAO.driverGridLoading()%>';   
 		<%-- dataExcelExport='<%=DAO.attendanceGridLoadingExcelExport(session,totDays,year,month,day,department,category,empId)%>'; --%>  
 	 
 	//alert(data);     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
        	 

                  	{ name: 'client', type: "String" },
					{ name: 'driverid', type: "string" },
					{ name: 'drivername', type: "string" },
					{ name: 'dob', type: "date" },
                    { name: 'nationality', type: "string" },
                    {name : 'mobileno', type: "string" },
                    {name : 'dlno', type: "string" },
                    {name : 'licensetype', type: "string" },
                    {name : 'licenseissuedfrom', type: "string" },
                    {name : 'licenseissueddate', type: "date" },
                    {name : 'licenseexpiry', type: "date" },
                    { name: 'srno', type: "string" },
                    { name: 'clientdocno', type: "string" },
                    { name: 'led', type: "string" },
                    { name: 'passportno', type: "string" },
                    { name: 'passportexpiry', type: "string" },
                    { name: 'idno', type: "string" },
                    { name: 'idexpiry', type: "string" },
                   
           	   ],
              		 localdata: data, 
              
              pager: function (pagenum, pagesize, oldpagenum) {
                  // callback called when a page or page size is changed.
              }
                                      
          };
          
            
     var dataAdapter = new $.jqx.dataAdapter(source,{
 		loadError: function (xhr, status, error) {
         alert(error);    
         }
      });


	$("#driverGrid").jqxGrid(
	{
		 width: '100%',
		 height: 550,
		 source: dataAdapter, 
		 selectionmode: 'singlerow',
		 localization: {thousandsSeparator: ""}, 
		 enabletooltips:true,
		 showfilterrow:true,
		 enabletooltips:true,
		 filterable:true,
		 columnsresize:true,
		 columns: [
						{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					
					
					{ text: 'Doc_no', datafield: 'driverid', editable: false , width: '3%' },
					{ text: 'Serial No', datafield: 'srno', editable: false , width: '3%' },
					{ text: 'Client',  datafield: 'client', editable: false , width: '10%' },
					{ text: 'Driver Name', datafield: 'drivername',width: '14%' , editable: false},			
					{ text: 'DOB',  datafield: 'dob',width: '10%' , editable: false },			
					{ text: 'Nationality', datafield: 'nationality',   width: '6%'  },
					{ text: 'Mobile', datafield: 'mobileno',   width: '6%'   },
					{ text: 'Driving License No', datafield: 'dlno',   width: '6%'   },
					{ text: 'License Type', datafield: 'licensetype',   width: '10%'  },
					{ text: 'License Issued From', datafield: 'licenseissuedfrom',   width: '6%'  },
					{ text: 'License Issued Date', datafield: 'licenseissueddate',   width: '7%'   },
					{ text: 'License Expiry', datafield: 'licenseexpiry',   width: '7%'  },
					{ text: 'Client Doc No', datafield: 'clientdocno',   width: '10%'    },
					{ text: 'LED', datafield: 'led',   width: '4%'    },
					{ text: 'Passport No', datafield: 'passportno',   width: '4%'    },
					{ text: 'Passport Expiry', datafield: 'passport Expiry',   width: '4%'  },
					{ text: 'ID No', datafield: 'idno',   width: '4%'  },
					{ text: 'ID Expiry', datafield: 'idexpiry',   width: '4%'    },
				
					],

    });
   
    
    

            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="driverGrid"></div>
