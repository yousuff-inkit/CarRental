<%@page import="com.dashboard.audit.prepaymentpostremove.ClsPrepaymentPostRemoveDAO"%>
<%ClsPrepaymentPostRemoveDAO cmd= new ClsPrepaymentPostRemoveDAO(); %>
 
<%
    String docno = request.getParameter("docno")==null?"":request.getParameter("docno").trim();
    String brhid = request.getParameter("brhid")==null?"":request.getParameter("brhid").trim();
	String id = request.getParameter("id")==null?"0":request.getParameter("id").trim();
%> 
           	  
<script type="text/javascript">
var id='<%=id%>';
var followupdata=[];
if(id=='1')
{ 
	followupdata='<%=cmd.getJvDetailData(docno,brhid,id)%>';
} 

$(document).ready(function () {
	var rendererstring=function (aggregates){
       	var value=aggregates['sum'];
       	if(typeof(value) == "undefined"){
       		value=0.00;
       	}
       	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
       }
	
	var rendererstring1=function (aggregates){
        var value1=aggregates['sum1'];
        return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + " Total : " + '</div>';
       }
	
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
        	 {name : 'branch', type: 'string'},
				 {name : 'transtype', type: 'string' },
				 {name : 'transno', type: 'int' },
				 {name : 'acno', type: 'int' },
				 {name : 'account', type: 'int' },
  		     	 {name : 'accountname', type: 'string' },
				 {name : 'postacno', type: 'int' },
				 {name : 'paccount', type: 'int' },
				 {name : 'paccountname', type: 'string' },
				 {name : 'date', type: 'date' },
				 {name : 'posteddate', type: 'date' },
				 {name : 'description', type: 'string' },
				 {name : 'dramount', type: 'number' },
				 {name : 'tobeposted', type: 'int' }				
						],
				    localdata: followupdata,
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
  
	var cellclassname1 = function (row, column, value, data) {
		if (data.tobeposted == '2') {
            return "toBePostedClass";
        } else{
        	return "postingClass";
        };
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
            {
            	loadError: function (xhr, status, error) {
    	        	alert(error);    
    	        }
    		});
    
    $("#detailGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: 'sl', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },	
                	{ text: 'Branch', datafield: 'branch',  width: '8%', cellclassname: cellclassname1 },
					{ text: 'Dtype', datafield: 'transtype',  width: '4%', cellclassname: cellclassname1 },
					{ text: 'Doc No.', datafield: 'transno',  width: '5%', cellclassname: cellclassname1 },	
					{ text: 'Account', hidden: true, datafield: 'acno',  width: '5%', cellclassname: cellclassname1 },
					{ text: 'A/C No.', datafield: 'account',  width: '5%', cellclassname: cellclassname1 },
					{ text: 'Account Name', datafield: 'accountname',  width: '15%', cellclassname: cellclassname1 },	
					{ text: 'Post A/C', hidden: true, datafield: 'postacno',  width: '5%', cellclassname: cellclassname1 },
					{ text: 'Post A/C No.', datafield: 'paccount',  width: '6%', cellclassname: cellclassname1 },
					{ text: 'Post A/C Name' , datafield: 'paccountname',  width: '16%', cellclassname: cellclassname1 },
					{ text: 'Date', datafield: 'date', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
					{ text: 'Posted Date', datafield: 'posteddate', cellsformat: 'dd.MM.yyyy',  width: '6%', cellclassname: cellclassname1 },
					{ text: 'Description' , datafield: 'description', aggregates: ['sum1'],aggregatesrenderer:rendererstring1, cellclassname: cellclassname1 },
					{ text: 'Amount', datafield: 'dramount',  width: '6%', cellsformat: 'd2', cellsalign: 'right', align: 'right', cellclassname: 'amountClass',aggregates: ['sum'],aggregatesrenderer:rendererstring },
					{ text: 'To Be Posted', hidden: true, datafield: 'tobeposted',  width: '5%' },
				 
					]
    
    });
});

</script>
<div id="detailGrid"></div>