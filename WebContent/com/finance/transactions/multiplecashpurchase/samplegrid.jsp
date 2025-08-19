<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<script type="text/javascript">

var productdata ={
		  "vendor": 0,
		  "vendorid": "",
		  "invno": "",
		  "invdate(yyyy-mm-dd)": "",
		  "type": "",
		  "account": "",
		  "accountname": "",
		  "currencyid": 0,
		  "currency": "",
		  "rate": 0.0,
		  "costtype": "",
		  "costcode": 0,
		  "qty": 0,
		  "unitprice": 0.0,
		  "Amount": 0.0,
		  "taxper": 0.0,
		  "taxamt": 0.0,
		  "tot": 0.0,
		  "description": ""
		};

        $(document).ready(function () { 
                     
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                        {name: 'vendor', type: 'int' }, 
                        {name: 'vendorid', type: 'string' },
                        {name: 'invno', type: 'string' },
                        {name : 'invdate', type: 'date' },
  						{name : 'type', type: 'string' }, 
  						{name : 'account', type: 'string'   },
  						{name : 'accountname', type: 'string'  },
  						{name : 'currencyid', type: 'int'   },
  						{name : 'currency', type: 'string'   },
  						{name : 'rate', type: 'number' },
  						{name : 'costtype', type: 'string'  },
						{name : 'costcode', type: 'number'  },
  						{name : 'qty', type: 'number' },
  						{name : 'unitprice', type: 'number' },
  						{name : 'Amount', type: 'number' },
                        {name : 'taxper', type: 'number' },
  						{name : 'taxamt', type: 'number' },
  						{name : 'tot', type: 'number' },
  						{name : 'description', type: 'string'   },
                        ],
                		localdata: productdata, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#jqxSampleGrid").jqxGrid(
            {
                width: '0%',
                height: 0,
                source: dataAdapter,
                showfilterrow: true, 
                filterable: true, 
                selectionmode: 'singlerow',
                   
                columns: [ 
                	{ text: 'vendor', datafield: 'vendor'},
                	{ text: 'vendorid', datafield: 'vendorid'},
                	{ text: 'invno', datafield: 'tinno'},
                	{ text: 'invdate', datafield: 'invdate'},
                	{ text: 'type', datafield: 'type'},
                	{ text: 'account', datafield: 'account'},	
                	{ text: 'accountname', datafield: 'accountname'},	
                	{ text: 'currencyid', datafield: 'currencyid'},
                	{ text: 'currency', datafield: 'currency'},
                	{ text: 'rate', datafield: 'rate'},
                	{ text: 'costtype', datafield: 'costtype'},
                	{ text: 'costcode', datafield: 'costcode'},
                	{ text: 'qty', datafield: 'qty'},
                	{ text: 'unitprice', datafield: 'unitprice'},
                	{ text: 'Amount', datafield: 'Amount'},
                	{ text: 'taxper', datafield: 'taxper'},
                	{ text: 'taxamt', datafield: 'taxamt'},
                	{ text: 'tot', datafield: 'tot'},
                	{ text: 'description', datafield: 'description'}
					]
            });
            
    	});
    </script>
    <div id="jqxSampleGrid"></div>
 