<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.employee.ClsEmployeeDAO"%>
<% ClsEmployeeDAO DAO= new ClsEmployeeDAO(); %>
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
 	
 		
 		data='<%=DAO.employeeListGridLoading(check)%>';      
 	
     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'doc_no', type: "int" },         
						{ name: 'date', type: "string" },
						{ name: 'codeno', type: "string" },
	                    { name: 'name', type: "string" },
	                    {name : 'cash_advance', type: "string" },
	                    {name : 'basic_salary', type: "string" },
	                    {name : 'hra', type: "string" },
	                    {name : 'ta', type: "string" },
	                    {name : 'others', type: "string" },
	                    {name : 'total', type: "string" },
	                    { name: 'dtjoin', type: "string" },
	                    { name: 'acno', type: "string" },
	                    { name: 'acc_curr', type: "string" },
	                    { name: 'pmaddr', type: "string" },
	                    { name: 'praddr', type: "string" },
	                    { name: 'pmmob', type: "string" },
	                    { name: 'prmob', type: "string" },
	                    { name: 'pmemail', type: "string" },
	                    { name: 'premail', type: "string" },
	                    { name: 'city', type: "string" },
	                    { name: 'state', type: "string" },
	                    { name: 'pincode', type: "string" },
	                    { name: 'nationality', type: "string" },
	                    { name: 'religion', type: "string" },
	                    { name: 'nearest', type: "string" },
	                    { name: 'pob', type: "string" },
	                    { name: 'dob', type: "string" },
	                    { name: 'dtype', type: "string" },
	                    { name: 'nation', type: "string" },
	                    { name: 'cmp', type: "string" },
	                    { name: 'mstatus', type: "string" },
	                    { name: 'gender', type: "string" },
	                    { name: 'age', type: "string" },
	                    { name: 'grpNo', type: "string" },
	                    { name: 'spouseName', type: "string" },
	                    { name: 'OTHER_DETAILS_IF_ANY', type: "string" },
	                    { name: 'curId', type: "string" },
	                    { name: 'active', type: "string" },
	                    { name: 'calendar', type: "string" },
	                    { name: 'lAnnLeave', type: "string" },
	                    { name: 'TER_DATE', type: "string" },
	                    { name: 'DT_RJOIN', type: "string" },
	                    { name: 'DT_LEV', type: "string" },
	                    { name: 'timeSheet', type: "string" },
	                    { name: 'curBrhId', type: "string" },
	                    { name: 'dt_close', type: "string" },
 						{name : 'category', type: "string"   },
 						{name : 'AGENT', type: "string"  },
 						{name : 'BANK_ACCOUNT_NO', type: "string"  },
 						{name : 'EMPLOYEE_ID', type: "string"  },
 						{name : 'BRANCH_NAME', type: "string"  },
 						{name : 'IFSC_CODE', type: "string"  },
 						{name : 'desig', type: "string"  },
 						{name : 'dept', type: "string"  },
 						{name : 'pay_cat', type: "string"  },
 						{name : 'TRAVELS', type: "string"  },
 						{name : 'salary_paid', type: "string"  },
 						{name : 'terminal_benefits', type: "string"  },
 						{name : 'terminated_date', type: "string"  },
 						{name : 'rdocno', type: "string"  },
 						{name : 'DOC_IDNO_PASSPORT', type: "string"  },
 						{name : 'PISSUE_DATE', type: "string"  },
 						{name : 'PEXP_DATE', type: "string"  },
 						{name : 'PPLACE_OF_ISSUE', type: "string"  },
 						{name : 'DOC_ID_NO_VISA', type: "string"  },
 						{name : 'VISSUE_DATE', type: "string"  },
 						{name : 'VEXP_DATE', type: "string"  },
 						{name : 'VPLACE_OF_ISSUE', type: "string"  },
 						{name : 'DOC_ID_NO_EMIRATES_ID', type: "string"  },
 						{name : 'EISSUE_DATE', type: "string"  },
 						{name : 'EEXP_DATE', type: "string"  },
 						{name : 'EPLACE_OF_ISSUE', type: "string"  },
 						{name : 'DOC_ID_NO_LABOURCARD', type: "string"  },
 						{name : 'LISSUE_DATE', type: "string"  },
 						{name : 'LEXP_DATE', type: "string"  },
 						{name : 'LPLACE_OF_ISSUE', type: "string"  },
 						{name : 'DOC_ID_NO_LICENSE', type: "string"  },
 						{name : 'LIISSUE_DATE', type: "string"  },
 						{name : 'LIEXP_DATE', type: "string"  },
 						{name : 'LIPLACE_OF_ISSUE', type: "string"  },
 						{name : 'DOC_ID_NO_MEDICAL_CARD', type: "string"  },
 						{name : 'MISSUE_DATE', type: "string"  },
 						{name : 'MEXP_DATE', type: "string"  },
 						{name : 'MPLACE_OF_ISSUE', type: "string"  },
 						{name : 'BASIC_SALARY1', type: "number"  },
 						{name : 'HRA1', type: "number"  },
 						{name : 'TRANSPORATION_ALLOWANCE', type: "number"  },
 						{name : 'FUEL_ALLOWANCE', type: "number"  },
 						{name : 'OVERTIME_ALLOWANCE', type: "number"  },
 						{name : 'OTHER_ALLOWANCE', type: "number"  },
 						{name : 'CARALLOWANCE', type: "number"  },
 						{name : 'est_code', type: "string"  },


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

	
	$("#employeeGrid").jqxGrid(
	{
	 width: '100%',
	 height: 550,
	 source: dataAdapter,
	 selectionmode: 'singlerow',
	 localization: {thousandsSeparator: ""},
	 showaggregates: true,
	 rowsheight:25,
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
					{ text: 'Doc_no', datafield: 'doc_no', editable: false , width: '3%' },
					{ text: 'Date',  datafield: 'date', editable: false ,width: '7%' , width: '3%' },
					{ text: 'codeNo', datafield: 'codeno',width: '4%' , editable: false},			
					{ text: 'Name',  datafield: 'name',width: '20%' , editable: false },	
					{ text: 'Designation', datafield: 'desig',   width: '10%'    },
					{ text: 'Nationality', datafield: 'nationality',   width: '10%'    },
					{ text: 'Cash_Advance', datafield: 'cash_advance',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Department', datafield: 'dept',   width: '10%'    },
					{ text: 'Payroll Category', datafield: 'pay_cat',   width: '10%'    },
					{ text: 'Basic Salary', datafield: 'basic_salary',   width: '10%' ,  cellsalign: 'right', align: 'right'   },
					{ text: 'HRA', datafield: 'hra',   width: '10%' , cellsalign: 'right', align: 'right'  },
					{ text: 'TA', datafield: 'ta',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Others', datafield: 'others',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Car Allowance', datafield: 'CARALLOWANCE',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Total', datafield: 'total',   width: '10%' , cellsalign: 'right', align: 'right'  },
					{ text: 'Dt Join', datafield: 'dtjoin',   width: '10%'    },
					{ text: 'Acno', datafield: 'acno',   width: '10%'    },
					{ text: 'Acc_Curr', datafield: 'acc_curr',   width: '10%'    },
					{ text: 'Permanent Address', datafield: 'pmaddr',   width: '10%'  },
					{ text: 'Present Address', datafield: 'praddr',   width: '10%'  },
					{ text: 'Permanent Mobile', datafield: 'pmmob',   width: '10%'    },
					{ text: 'Present Mobile', datafield: 'prmob',   width: '10%'    },
					{ text: 'Permanent Email', datafield: 'pmemail',   width: '10%'  },
					{ text: 'Present Email', datafield: 'premail',   width: '10%'    },
					{ text: 'City', datafield: 'city',   width: '10%'    },
					{ text: 'State', datafield: 'state',   width: '10%'    },
					{ text: 'Pincode', datafield: 'pincode',   width: '10%'    },
					{ text: 'Religion', datafield: 'religion',   width: '10%'    },
					{ text: 'Nearest Airport', datafield: 'nearest',   width: '10%'    },
					{ text: 'POB', datafield: 'pob',   width: '10%'    },
					{ text: 'DOB', datafield: 'dob',   width: '10%'    },
					{ text: 'Dtype', datafield: 'dtype',   width: '10%'    },
					{ text: 'Nation', datafield: 'nation',   width: '10%'    },
					{ text: 'Company', datafield: 'cmp',   width: '10%'    },
					{ text: 'Mstatus', datafield: 'mstatus',   width: '10%'    },
					{ text: 'Gender', datafield: 'gender',   width: '10%'    },
					{ text: 'Status', datafield: 'status',   width: '10%'    },
					{ text: 'Father Name', datafield: 'fatherName',  width: '10%'    },
					{ text: 'Mother Name', datafield: 'motherName',  width: '10%'    },
					{ text: 'Blood Group', datafield: 'bloodGroup',  editable: false ,width: '3%'},
					{ text: 'Age', datafield: 'age',  width: '3%'},
					//{ text: '', datafield: 'Field33', editable: false  ,  width: '17%' },			
					{ text: 'Grp No', datafield: 'grpNo' , editable: false, width: '3%'  },
					{ text: 'Spouse Name', datafield: 'spouseName', editable: false, width: '7%'  },
					{ text: 'Other Details', datafield: 'OTHER_DETAILS', editable: false, width: '7%' },
					{ text: 'Currency', datafield: 'curr', editable: false, width: '7%' },
					{ text: 'Active', datafield: 'active', editable: false   ,  width: '17%' },			
					{ text: 'Calendar', datafield: 'calendar', editable: false  ,  width: '17%' },			
					{ text: 'LAnnLeave', datafield: 'lAnnLeave', editable: false  ,  width: '17%' },			
					{ text: 'Ter_Date', datafield: 'TER_DATE', editable: false  ,  width: '17%' },			
					{ text: 'Dt_RJoin', datafield: 'DT_RJOIN', editable: false , width: '3%' },
					{ text: 'Dt_Lev',  datafield: 'DT_LEV', editable: false , width: '3%' },
					{ text: 'TimeSheet',  datafield: 'timeSheet', editable: false , width: '3%' },
					{ text: 'Current Branch', datafield: 'curBrhId', editable: false},			
					{ text: 'Dt_Close',  datafield: 'dt_close', editable: false  },			
					{ text: 'Category', datafield: 'category',   width: '10%'   },
					{ text: 'Agent', datafield: 'AGENT',   width: '10%'   },
					{ text: 'Bank Accno', datafield: 'BANK_ACCOUNT_NO',   width: '10%'    },
					{ text: 'Employee Id', datafield: 'EMPLOYEE_ID',   width: '10%'  },
					{ text: 'Branch Name', datafield: 'BRANCH_NAME',   width: '10%'  },
					{ text: 'IFSC Code', datafield: 'IFSC_CODE',   width: '10%'    },
					{ text: 'Est. Code', datafield: 'est_code',   width: '10%'    },
					{ text: 'Travels', datafield: 'travels',   width: '10%'  },
					{ text: 'Salary Paid', datafield: 'salary_paid',   width: '10%'  },
					{ text: 'Terminal Benefits', datafield: 'terminal_benefits',   width: '10%'    },
					{ text: 'Terminated Date', datafield: 'terminated_date',   width: '10%'    },
					{ text: 'RdocNo', datafield: 'rdocno',   width: '10%'  },
					{ text: 'DOC_IDNO_PASSPORT', datafield: 'DOC_IDNO_PASSPORT',   width: '10%'    },
					{ text: 'PISSUEDATE', datafield: 'PISSUEDATE',   width: '10%'    },
					{ text: 'PEXPDATE', datafield: 'PEXPDATE',   width: '10%'    },
					{ text: 'PPLACEOFISSUE', datafield: 'PPLACEOFISSUE',   width: '10%'    },
					{ text: 'DOC_IDNO_VISA', datafield: 'DOC_IDNO_VISA',   width: '10%'    },
					{ text: 'VISSUEDATE', datafield: 'VISSUEDATE',   width: '10%'    },
					{ text: 'VEXPDATE', datafield: 'VEXPDATE',   width: '10%'    },
					{ text: 'VPLACEOFISSUE', datafield: 'VPLACEOFISSUE',   width: '10%'    },
					{ text: 'DOC_IDNO_EMIRATESID', datafield: 'DOC_IDNO_EMIRATESID',   width: '10%'    },
					{ text: 'EISSUEDATE', datafield: 'EISSUEDATE',   width: '10%'    },
					{ text: 'EEXPDATE', datafield: 'EEXPDATE',   width: '10%'    },
					{ text: 'EPLACEOFISSUE', datafield: 'EPLACEOFISSUE',   width: '10%'    },
					{ text: 'DOC_IDNO_LABOURCARD', datafield: 'DOC_IDNO_LABOURCARD',   width: '10%'    },
					{ text: 'LISSUEDATE', datafield: 'LISSUEDATE',   width: '10%'    },
					{ text: 'LEXPDATE', datafield: 'LEXPDATE',   width: '10%'    },
					{ text: 'LPLACEOFISSUE', datafield: 'LPLACEOFISSUE',  width: '10%'    },
					{ text: 'DOC_IDNO_LICENSE', datafield: 'DOC_IDNO_LICENSE',  width: '10%'    },
					{ text: 'LIISSUEDATE', datafield: 'LIISSUEDATE',  editable: false ,width: '3%'},
					{ text: 'LIEXPDATE', datafield: 'LIEXPDATE', width: '3%'},
					{ text: 'LIPLACEOFISSUE', datafield: 'LIPLACEOFISSUE', editable: false  ,  width: '17%' },			
					{ text: 'DOC_IDNO_MEDICALCARD', datafield: 'DOC_IDNO_MEDICALCARD' , editable: false, width: '3%'  },
					{ text: 'MISSUEDATE', datafield: 'MISSUEDATE', editable: false, width: '7%'  },
					{ text: 'MEXPIRYDATE', datafield: 'MEXPIRYDATE', editable: false, width: '7%' },
					{ text: 'MPLACEOFISSUE', datafield: 'MPLACEOFISSUE', editable: false, width: '7%' },
					{ text: 'BASIC_SALARY1', datafield: 'BASIC_SALARY1', editable: false ,  cellsalign: 'right', align: 'right'   ,  width: '17%' },			
					{ text: 'HRA1', datafield: 'HRA1', editable: false ,  cellsalign: 'right', align: 'right'  ,  width: '17%' },			
					{ text: 'TRANSPORATION_ALLOWANCE', datafield: 'TRANSPORATION_ALLOWANCE',  cellsalign: 'right', align: 'right' , editable: false  ,  width: '17%' },			
					{ text: 'FUEL_ALLOWANCE', datafield: 'FUEL_ALLOWANCE',  cellsalign: 'right', align: 'right' , editable: false  ,  width: '17%' },			
					{ text: 'OVERTIME_ALLOWANCE', datafield: 'OVERTIME_ALLOWANCE',  cellsalign: 'right', align: 'right' , editable: false  ,  width: '17%' },			
					{ text: 'OTHER_ALLOWANCE', datafield: 'OTHER_ALLOWANCE',  cellsalign: 'right', align: 'right' , editable: false  ,  width: '17%' },			

					],

    });
   
    
    

            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="employeeGrid"></div>
