<%@page import="com.dashboard.consolidated.vendor.ClsVendorDetailsDAO" %>
<%  ClsVendorDetailsDAO DAO=new ClsVendorDetailsDAO(); %>
<% String check = request.getParameter("check")==null?"0":request.getParameter("check");%>

<script type="text/javascript">   

var temp='<%=check%>';

var data;
	if(temp=="load") {
	 	data = '<%=DAO.vendorList(check)%>';   
	}
	
   $(document).ready(function () {  
        
     		var source =
            {
                localdata: data,
                datafields:
                [
                    { name: 'category', type: 'string' },
                    { name: 'doc_no', type: 'int' },
                    { name: 'codeno', type: 'string' },
                    { name: 'refname', type: 'string' },
                    { name: 'per_mob', type: 'string' },
                    { name: 'sal_name', type: 'string' },
                    { name: 'address', type: 'string' },
                    { name: 'mail1', type: 'string' },
                    { name: 'type', type: 'string' },
					{ name: 'trnnumber', type: 'string' },
					{ name: 'account', type: 'string' },
					{ name: 'accountgroup', type: 'string' },
					{ name: 'creditperiodmin', type: 'string' },
					{ name: 'creditperiodmax', type: 'string' },
					{name : 'dbname', type: 'String'  },
					{name : 'branch', type: 'String'  },
					{name : 'compname', type: 'String'  },
					{name : 'slno', type: 'number'    },
					{ name: 'creditlimit', type: 'string' }
                ],
                datatype: "json",
                updaterow: function (rowid, rowdata) {
                    // synchronize with the server - send update command   
                }
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            // initialize jqxGrid 
            $("#vendorgrid").jqxGrid(
            {
                width: '99%',
				height: 500,
                source: dataAdapter,
                showaggregates:true,
                enableAnimations: true,
                filtermode:'excel',
                filterable: true,
                sortable:true,
                columnsresize: true,
                selectionmode: 'singlerow',
                showfilterrow: true, 
                pagermode: 'default',
                editable:false,
                columns: [
                  { text: 'Sr.No', datafield: 'slno', width: '3%' }, 
                  { text: 'Category', groupable: true, datafield: 'category', width: '10%' },
                  { text: 'Doc No', groupable: false, datafield: 'doc_no', width: '5%' },
                  { text: 'Code', groupable: false, datafield: 'codeno', width: '5%' },
                  { text: 'Name', groupable: true, datafield: 'refname', width: '19%' },
                  { text: 'Company', datafield: 'compname', width: '19%'}, 
       	          { text: 'Branch', datafield: 'branch', width: '12%'},
                  { text: 'Mobile', groupable: true, datafield: 'per_mob', width: '9%' },
                  { text: 'Salesman', groupable: false, datafield: 'sal_name', width: '14%' },
                  { text: 'Address', groupable: false, datafield: 'address', width: '24%' },
                  { text: 'Email Id', groupable: false, datafield: 'mail1', width: '14%' },
                  { text: 'Type', groupable: false, datafield: 'type', width: '8%' },
				  { text: 'TRN No', groupable: false, datafield: 'trnnumber', width: '8%' },
				  { text: 'Account', groupable: false, datafield: 'account', width: '8%' },
				  { text: 'Account Group', groupable: false, datafield: 'accountgroup', width: '15%' },
				  { text: 'Credit Period(Min)', groupable: false, datafield: 'creditperiodmin', width: '8%' },
				  { text: 'Credit Period(Max)', groupable: false, datafield: 'creditperiodmax', width: '8%' },
				  { text: 'Credit Limit', groupable: false, datafield: 'creditlimit', width: '8%' },
				  { text: 'dbname', datafield: 'dbname', width: '0%',hidden:true},
                ],
				
            });
            $("#overlay, #PleaseWait").hide();
        });
    </script>
    
<div id="vendorgrid"></div>