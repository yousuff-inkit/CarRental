<%@page import="com.dashboard.analysis.vehprofit.ClsVehProfitDAO" %>
<% ClsVehProfitDAO cvd=new ClsVehProfitDAO();%>

<%
String temp=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
String grpby1=request.getParameter("grpby1")==null?"":request.getParameter("grpby1");
String hidbrand=request.getParameter("hidbrand")==null?"":request.getParameter("hidbrand");
String hidmodel=request.getParameter("hidmodel")==null?"":request.getParameter("hidmodel");
String hidgroup=request.getParameter("hidgroup")==null?"":request.getParameter("hidgroup");
String hidyom=request.getParameter("hidyom")==null?"":request.getParameter("hidyom");
String gridtype=request.getParameter("gridtype")==null?"":request.getParameter("gridtype");
String hidfleet=request.getParameter("hidfleet")==null?"":request.getParameter("hidfleet");
%>

<script type="text/javascript">
 
$(document).ready(function () {
   var id='<%=temp%>';
var vehprofitdata;
   if(id=='1'){
	vehprofitdata='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>'; 
	<%-- summaryExcelExport='<%=cvd.getVehProfit(branch,fromdate,todate,grpby1,hidbrand,hidmodel,hidgroup,hidyom,temp,gridtype,hidfleet)%>'; --%>
   }
else{
	vehprofitdata;
}
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'refno',type:'number'},
                  		{name : 'description',type:'String'},
                  		{name : 'income',type:'number'},
                  		{name : 'expenses',type:'number'},
                  		{name : 'netamount',type:'number'},
						{name : 'returnprice',type:'number'},
						{name : 'purcost',type:'number'},
                  		
						{name : 'reg_no',type:'String'}, 
						{name : 'code_name',type:'String'},
						{name : 'authname',type:'String'},
						{name : 'age',type:'number'},
                  		/* {name : 'brand',type:'string'},
                  		{name : 'model',type:'string'},
                  		{name : 'gname',type:'string'},
                  		{name : 'yom',type:'string'} */
                  		/* {name : 'salesman',type:'string'},
                  		{name : 'rentalagent',type:'string'},
                  		{name : 'yom',type:'string'}
                  		 */
                  		],
				    localdata: vehprofitdata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#vehProfitGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	var grp = $("#grpby1").val();
    	console.log(grp)
    	if(grp!="" && grp!="0"){
    	    $("#vehProfitGrid").jqxGrid('hidecolumn','age');
    	}else{
    		$("#vehProfitGrid").jqxGrid('showcolumn','age');
    	}
     });        
    
    
    var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + '' + value + '</div>';
    }
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    $("#vehProfitGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        source: dataAdapter,
        showaggregates:true,
        filterable: true,
        showfilterrow: true,
        enabletooltips:true,
        columnsresize: true,
        selectionmode: 'singlerow',
        showaggregates:true,
        showstatusbar:true,
        //localization: {thousandsSeparator: ""},
        sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
		             groupable: false, draggable: false, resizable: false,datafield: '',
		             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
		             cellsrenderer: function (row, column, value) {
		              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Ref No',datafield:'refno',width:'8%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'8%'},
       				{ text: 'Plate',datafield:'code_name',width:'8%'},
       				{ text: 'Authority',datafield:'authname',width:'8%'},
       				{ text: 'Age',datafield:'age',width:'6%'},
       				{ text: 'Description',datafield:'description' },
       				{ text: 'Income',datafield:'income',width:'7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Expense',datafield:'expenses',width:'7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Purchase Cost',datafield:'purcost',width:'7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Contribution',datafield:'netamount',width:'7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring},
       				{ text: 'Ret on P. Price',datafield:'returnprice',width:'7%',cellsalign:'right',cellsformat:'d2',aggregates: ['sum'],aggregatesrenderer:rendererstring}
       				]

    });
});
</script>
<div id="vehProfitGrid"></div>