<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.dashboard.importdata.productmaster.ClsProductmasterDAO"%>
<% ClsProductmasterDAO DAO= new ClsProductmasterDAO(); %>


 <script type="text/javascript">
 

	var data;
	var dataExcelExport;
 $(document).ready(function () { 	
 	
 		
 		data='<%=DAO.promasterGridLoading()%>';  
 	
     // prepare the data
     var source =
     {
         datatype: "json",
         datafields: [
						{ name: 'psrno', type: "int" },
						{ name: 'procode', type: "string" },
						{ name: 'proname', type: "string" },
	                    { name: 'dept', type: "string" },
	                    {name : 'category', type: "string" },
	                    {name : 'subcategory', type: "string" },
	                    {name : 'unit', type: "string" },
	                    {name : 'protype', type: "string" },
	                    {name : 'brand', type: "string" },
	                    {name : 'barcode', type: "string" },
	                    { name: 'unitprice', type: "string" },
	                    { name: 'star', type: "string" },
	                    { name: 'quantity', type: "string" },
	                    { name: 'value', type: "string" },
	                   
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


$("#promasterGrid").jqxGrid(
{
 
 width: '100%',
 height: 450,
 source: dataAdapter,
 editable: true,
 selectionmode: 'singlecell',
 localization: {thousandsSeparator: ""},
 showaggregates: true,
 rowsheight:25,
 enabletooltips:true,
 showfilterrow:true,
 enabletooltips:true,
 filterable:true,
 columns: [
					{ text: 'S#', pinned: true, sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,datafield: '',
                      columntype: 'number', width: '2%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }    
					},
					{ text: 'Psrno', datafield: 'psrno', editable: false , width: '5%' },
					{ text: 'Product Code',  datafield: 'procode', editable: false ,width: '7%' , width: '5%' },
					{ text: 'Product Name', datafield: 'proname',width: '10%' , editable: false},			
					{ text: 'Department',  datafield: 'dept',width: '10%' , editable: false },			
					{ text: 'Category', datafield: 'category',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Sub Category', datafield: 'subcategory',   width: '10%' ,  cellsalign: 'right', align: 'right'   },
					{ text: 'Unit', datafield: 'unit',   width: '5%' , cellsalign: 'right', align: 'right'  },
					{ text: 'Product Type', datafield: 'protype',   width: '8%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Brand', datafield: 'brand',   width: '10%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Bar Code', datafield: 'barcode',   width: '8%' ,  cellsalign: 'right', align: 'right'  },
					{ text: 'Unit Price', datafield: 'unitprice',   width: '5%' ,cellsformat:'d2',cellsalign: 'right', align: 'right'  },
					{ text: 'Star', datafield: 'star',   width: '5%'    },
					{ text: 'Quantity', datafield: 'quantity',   width: '8%'    },
					{ text: 'Price / Value', datafield: 'value',   width: '10%',cellsformat:'d2',cellsalign:'right',align:'right'   },
				
					],

    });
   
    
    

            
			$("#overlay, #PleaseWait").hide();
             
        });
 		
</script>

<div id="promasterGrid"></div>
