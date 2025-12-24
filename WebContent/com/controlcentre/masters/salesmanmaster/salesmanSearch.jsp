<%@page import="com.controlcentre.masters.salesmanmaster.salesman.ClsSalesmanDAO" %>

<%ClsSalesmanDAO csd=new ClsSalesmanDAO(); %>

<style type="text/css">
/* --- MASTER UI STYLES APPLIED FOR CONSISTENCY --- */


table {
  border-collapse: separate;
  border-spacing: 15px 18px;  
}


td[align="right"] {
  font-weight: 700;
  font-size: 14px;
  color: #222;
}


input[type="text"] {
  font-weight: 600;
  font-size: 14px;
  padding: 8px 12px;
  width: 95%;               /* Prevent overflow */
  max-width: 100%;
  box-sizing: border-box;   /* Include padding in width */
}


#bankdate, #chqdate, .jqx-datetimeinput { /* Added .jqx-datetimeinput for grid compatibility */
  font-weight: 600;
  font-size: 14px;
}

/* Bold button text */
.myButton {
  font-weight: 700;
  font-size: 14px;
}

/* Additional spacing for rows */
tr {
  line-height: 1.8;
}

/* --- GRID SPECIFIC STYLES TO MATCH MASTER FONT/LOOK --- */
/* Ensure the grid area itself inherits reasonable padding/margins */
#jqxSalesmanSearch {
    margin-top: 10px;
    font-family: Arial, sans-serif; /* Use a common font for jqxGrid */
    font-size: 13px;
}

/* You might need additional jqx styles if the master font isn't being applied to the grid cells */

</style>



<script type="text/javascript">

 

  var datasm= '<%=csd.list()%>';

        

  $(document).ready(function () {

         

            var source =

            {

           

                datatype: "json",

                datafields: [

                          {name : 'doc_no' , type: 'int' },

      {name : 'sal_id', type: 'String'  },

                          {name : 'sal_name', type: 'String'  },

                          {name : 'acc_no', type: 'String'  },

                          {name : 'description', type: 'String' },

                          {name : 'mob_no', type: 'String'  },

                          {name : 'mail',type:'String'},

                          {name : 'date',type:'String'},

                          {name :  'acdoc',type:'String'}

                         

                 ],

               localdata: datasm,

        

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

            $("#jqxSalesmanSearch").jqxGrid(

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

{ text: 'Doc No', datafield: 'doc_no', width: '20%' },

{ text: 'Salesman Name', datafield: 'sal_name', width: '40%' },

{ text: 'Account No', datafield: 'acc_no', width: '40%',hidden:true },

{ text: 'Account Name', datafield: 'description', width: '40%',hidden:true},

  { text: 'Mobile', datafield: 'mob_no', width: '40%' },

  { text: 'Mail',datafield:'mail',width:'40%',hidden:true},

  { text: 'Date',datafield:'date',width:'40%',hidden:true},

  { text: 'Ac Doc',datafield:'acdoc',width:'40%',hidden:true}

              ]

            });

            

            $('#jqxSalesmanSearch').on('rowdoubleclick', function (event) {

                var rowindex1=event.args.rowindex;

                document.getElementById("docno").value= $('#jqxSalesmanSearch').jqxGrid('getcellvalue', rowindex1, "doc_no"); 

                document.getElementById("salesmanid").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "sal_id");

                document.getElementById("salesmanname").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "sal_name");

                document.getElementById("txtaccno").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "acc_no");

                document.getElementById("txtaccname").value= $('#jqxSalesmanSearch').jqxGrid('getcellvalue', rowindex1, "description"); 

                document.getElementById("telephone").value = $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "mob_no");

                document.getElementById("salesmanmail").value= $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "mail");

                $("#salesmandate").jqxDateTimeInput('val', $("#jqxSalesmanSearch").jqxGrid('getcellvalue', rowindex1, "date"));

                document.getElementById("hidacno").value = $("#jqxSalesmanSearch1").jqxGrid('getcellvalue', rowindex1, "acdoc");

               

                $('#window').jqxWindow('close');

            }); 

           

        });

    </script>

    <div id="jqxSalesmanSearch"></div>