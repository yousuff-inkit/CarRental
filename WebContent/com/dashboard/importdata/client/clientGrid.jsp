<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.client.ClsIMClientDAO"%>
<% ClsIMClientDAO DAO= new ClsIMClientDAO(); %>
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
 		data='<%=DAO.clientListGridLoading()%>';   
     var source =
     {
         datatype: "json",
         datafields: [
        	 
  
						{ name: 'id', type: "int" },
						{ name: 'serial_no', type: "String" },
						{ name: 'refname', type: "string" },
						{ name: 'salutation', type: "string" },
	                    { name: 'address', type: "string" },
	                    {name : 'com_mob', type: "string" },
	                    {name : 'per_mob', type: "string" },
	                    {name : 'opt_mob', type: "string" },
	                    {name : 'salesman', type: "string" },
	                    {name : 'taxable', type: "string" },
	                    {name : 'trnnumber', type: "string" },
	                    { name: 'category', type: "string" },
	                    { name: 'areaname', type: "string" },
	                    { name: 'areaid', type: "string" },
	                    { name: 'doc_no', type: "string" },
	                    { name: 'atype', type: "string" },
	                    { name: 'acno', type: "string" },
	                    { name: 'parentco', type: "string" },
	                    { name: 'fax1', type: "string" },
	                    { name: 'fax2', type: "string" },
	                    { name: 'web1', type: "string" },
	                    { name: 'active', type: "string" },
	                    { name: 'codeno', type: "string" },
	                    { name: 'dtype', type: "string" },
	                    { name: 'date', type: "string" },
	                    { name: 'curid', type: "string" },
	                    { name: 'designation', type: "string" },
	                    { name: 'refno', type: "string" },
	                    { name: 'dtjoin', type: "string" },
	                    { name: 'basic', type: "string" },
	                    { name: 'contactperson', type: "string" },
	                    { name: 'period', type: "string" },
	                    { name: 'period2', type: "string" },
	                    { name: 'credit', type: "string" },
	                    { name: 'address2', type: "string" },
	                    { name: 'isagent', type: "string" },
	                    { name: 'salid', type: "string" },
	                    { name: 'agent', type: "string" },
	                    { name: 'catid', type: "string" },
	                    { name: 'brhid', type: "string" },
	                    { name: 'cmpid', type: "string" },
	                    { name: 'cstno', type: "string" },
	                    { name: 'taxid', type: "string" },
	                    { name: 'pricegroup', type: "string" },
	                    { name: 'remarks', type: "string" },
	                    { name: 'deliveryaddress', type: "string" },
	                    { name: 'deliveryaddress2', type: "string" },
	                    { name: 'deliverytelno', type: "string" },
	                    { name: 'deliveryfax', type: "string" },
	                    { name: 'deliverycontactno', type: "string" },
	                    { name: 'deliverymob', type: "string" },
	                    { name: 'bankname', type: "string" },
	                    { name: 'branchname', type: "string" },
	                    { name: 'branchaddress', type: "string" },
	                    { name: 'ibanno', type: "string" },
	                    { name: 'acden', type: "string" },
	                    { name: 'cgroup', type: "string" },
	                    { name: 'advance', type: "string" },
	                    { name: 'invcmethod', type: "string" },
	                    { name: 'delcharge', type: "string" },
	                    { name: 'paymode', type: "string" },
	                    { name: 'accgroup', type: "string" },
	                    { name: 'serdefault', type: "string" },
	                    { name: 'persalikrate', type: "string" },
	                    { name: 'pertrafficcharge', type: "string" },
	                    { name: 'reftype', type: "string" },
	                    { name: 'extno', type: "string" },
	                    { name: 'contractupto', type: "string" },
	                    { name: 'auditt', type: "string" },
	                    { name: 'spclnotes', type: "string" },
	                    { name: 'status', type: "string" },
	                    { name: 'rostatus', type: "string" },
	                    { name: 'lostatus', type: "string" },
	                    { name: 'pcase', type: "string" },
	                    { name: 'contractno', type: "string" },
	                    { name: 'conremarks', type: "string" },
	                    { name: 'tinno', type: "string" },
	                    { name: 'accno', type: "string" },
	                    { name: 'bankswiftno', type: "string" },
	                    { name: 'bankcity', type: "string" },
	                    { name: 'bankcountry', type: "string" },
	                    { name: 'finname', type: "string" },
	                    { name: 'finaddress', type: "string" },
	                    { name: 'olddocno', type: "string" },
	                    { name: 'contactperno', type: "string" },
	                    { name: 'nontax', type: "string" },
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


	$("#clientGrid").jqxGrid(
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
					{ text: 'Salutation', datafield: 'salutation',width: '2%' , editable: false},	
					{ text: 'Client',  datafield: 'refname', editable: false , width: '10%' },
					{ text: 'Address',  datafield: 'address',width: '10%' , editable: false },			
					{ text: 'Mobile', datafield: 'com_mob',   width: '6%'  },
					{ text: 'Per_Mob', datafield: 'per_mob',   width: '6%'   },
					{ text: 'Opt_Mob', datafield: 'opt_mob',   width: '6%'   },
					{ text: 'Salesman', datafield: 'salesman',   width: '10%'  },
					{ text: 'Taxable', datafield: 'taxable',   width: '6%'  },
					{ text: 'TRN Number', datafield: 'trnnumber',   width: '7%'   },
					{ text: 'Category', datafield: 'category',   width: '7%'  },
					{ text: 'Area', datafield: 'areaname',   width: '10%'    },
					{ text: 'Parent Co', datafield: 'parentco',   width: '4%'    },
					{ text: 'Fax1', datafield: 'fax1',   width: '5%'    },
					{ text: 'Fax2', datafield: 'fax2',   width: '5%'  },
					{ text: 'Web1', datafield: 'web1',   width: '5%'    },
					{ text: 'Mail', datafield: 'mail1',   width: '5%'    },
					{ text: 'Active', datafield: 'active',   width: '5%'    },
					{ text: 'Codeno', datafield: 'codeno',   width: '5%'    },
					{ text: 'Date', datafield: 'date',   width: '5%'    },
					{ text: 'Designation', datafield: 'designation',   width: '5%'    },
					{ text: 'Refno', datafield: 'refno',   width: '5%'    },
					{ text: 'Dt Join', datafield: 'dtjoin',   width: '5%'    },
					{ text: 'Basic', datafield: 'basic',   width: '5%'    },
					{ text: 'Contact Person', datafield: 'contactperson',   width: '6%'    },
					{ text: 'Contact Person No', datafield: 'contactperno',   width: '6%'    },
					{ text: 'Period', datafield: 'period',   width: '5%'    },
					{ text: 'Period2', datafield: 'period2',   width: '5%'    },
					{ text: 'Credit', datafield: 'credit',   width: '5%'    },
					{ text: 'Address2', datafield: 'address2',   width: '5%'    },
					{ text: 'Isagent', datafield: 'isagent',   width: '5%'    },
					{ text: 'Agent', datafield: 'agent',   width: '5%'    },
					{ text: 'Cstno', datafield: 'cstno',   width: '5%'    },
					{ text: 'Taxid', datafield: 'taxid',   width: '5%'    },
					{ text: 'Price Group', datafield: 'pricegroup',   width: '5%'    },
					{ text: 'Remarks', datafield: 'remarks',   width: '5%'    },
					{ text: 'Delivery Address', datafield: 'deliveryaddress',   width: '5%'    },
					{ text: 'Delivery Address 2', datafield: 'deliveryaddress2',   width: '5%'    },
					{ text: 'Delivery Telno', datafield: 'deliverytelno',   width: '5%'    },
					{ text: 'Delivery Fax', datafield: 'deliveryfax',   width: '5%'    },
					{ text: 'Delivery Contact No', datafield: 'deliverycontactno',   width: '5%'    },
					{ text: 'Delivery Mob', datafield: 'deliverymob',   width: '5%'    },
					{ text: 'Bank Name', datafield: 'bankname',   width: '5%'    },
					{ text: 'Branch Name', datafield: 'branchname',   width: '5%'    },
					{ text: 'Branch Address', datafield: 'branchaddress',   width: '5%'    },
					{ text: 'Ibanno', datafield: 'ibanno',   width: '5%'    },
					{ text: 'Ac Den', datafield: 'acden',   width: '5%'    },
					{ text: 'C group', datafield: 'cgroup',   width: '5%'    },
					{ text: 'Advance', datafield: 'advance',   width: '5%'    },
					{ text: 'Invc Method', datafield: 'invcmethod',   width: '5%'    },
					{ text: 'Del Charge', datafield: 'delcharge',   width: '5%'    },
					{ text: 'Pay Mode', datafield: 'paymode',   width: '5%'    },
					{ text: 'Acc Group', datafield: 'accgroup',   width: '5%'    },
					{ text: 'Ser Default', datafield: 'serdefault',   width: '5%'    },
					{ text: 'Persalikrate', datafield: 'persalikrate',   width: '5%'    },
					{ text: 'Per Traffic Charge', datafield: 'pertrafficcharge',   width: '5%'    },
					{ text: 'Reftype', datafield: 'reftype',   width: '5%'    },
					{ text: 'Extno', datafield: 'extno',   width: '6%'    },
					{ text: 'Contract Upto', datafield: 'contractupto',   width: '6%'    },
					{ text: 'Audit', datafield: 'auditt',   width: '6%'    },
					{ text: 'Special Notes', datafield: 'specialnotes',   width: '6%'    },
					{ text: 'Status', datafield: 'status',   width: '6%'    },
					{ text: 'Ro Status', datafield: 'rostatus',   width: '6%'    },
					{ text: 'Lo Status', datafield: 'lostatus',   width: '6%'    },
					{ text: 'P Case', datafield: 'pcase',   width: '6%'    },
					{ text: 'Contract No', datafield: 'contractno',   width: '6%'    },
					{ text: 'Con Remarks', datafield: 'conremarks',   width: '6%'    },
					{ text: 'Tinno', datafield: 'tinno',   width: '6%'    },
					{ text: 'Accno', datafield: 'accno',   width: '6%'    },
					{ text: 'Bank Swift No', datafield: 'bankswiftno',   width: '6%'    },
					{ text: 'Bank City', datafield: 'bankcity',   width: '6%'    },
					{ text: 'Bank Country', datafield: 'bankcountry',   width: '6%'    },
					{ text: 'Fin Name', datafield: 'finname',   width: '6%'    },
					{ text: 'Fin Address', datafield: 'finaddress',   width: '6%'    },
					{ text: 'Non Tax', datafield: 'nontax',   width: '6%'    },
					{ text: 'Old Docno', datafield: 'olddocno',   width: '6%',hidden:true      },
					{ text: 'Area Id', datafield: 'areaid',   width: '4%',hidden:true    },
					{ text: 'Catid', datafield: 'catid',   width: '5%' ,hidden:true   },
					{ text: 'Brhid', datafield: 'brhid',   width: '5%' ,hidden:true   },
					{ text: 'Salid', datafield: 'salid',   width: '5%'  ,hidden:true  },
					{ text: 'Cmpid', datafield: 'cmpid',   width: '5%'   ,hidden:true },
					{ text: 'Doc_no', datafield: 'id', editable: false , width: '3%' ,hidden:true},
					{ text: 'Serial No', datafield: 'serial_no', editable: false , width: '3%',hidden:true },
					{ text: 'Doc_no', datafield: 'doc_no',   width: '4%',hidden:true    },
			        { text: 'Atype', datafield: 'atype',   width: '4%',hidden:true  },
					{ text: 'Acno', datafield: 'acno',   width: '4%',hidden:true  },
					{ text: 'Dtype', datafield: 'dtype',   width: '5%',hidden:true    },
					{ text: 'Curid', datafield: 'curid',   width: '5%',hidden:true    },
					],

    });
   
    
    

            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="clientGrid"></div>
