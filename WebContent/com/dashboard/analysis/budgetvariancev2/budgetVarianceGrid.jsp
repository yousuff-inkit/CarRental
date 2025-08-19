<%@page import="com.dashboard.analysis.budgetvariancev2.ClsBudgetVarianceDAO" %>
<% ClsBudgetVarianceDAO cpl = new ClsBudgetVarianceDAO(); %>  
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String level1 = request.getParameter("level1")==null?"0":request.getParameter("level1").trim();
	 String level2 = request.getParameter("level2")==null?"0":request.getParameter("level2").trim();
	 String level3 = request.getParameter("level3")==null?"0":request.getParameter("level3").trim();
	 String level4 = request.getParameter("level4")==null?"0":request.getParameter("level4").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");
	 String onedaylessdt = request.getParameter("onedaylessdt")==null || request.getParameter("onedaylessdt").trim().equals("")?"0":request.getParameter("onedaylessdt");
	 double rate = request.getParameter("rate")==null || request.getParameter("rate").trim().equals("")?1.0:Double.parseDouble(request.getParameter("rate").trim());
	 String entrydate = request.getParameter("entrydate")==null?"0":request.getParameter("entrydate").trim(); 
%>   
	 
<style type="text/css">
        .headClass
        {
            background-color: #FFEBC2;
        }
        .redClass
        {
            background-color: #FFEBEB;
        }
        .violetClass
        {
            background-color: #EBD6FF;
        }
        .yellowClass
        {
            background-color: #FFFFD1;
        }
        .whiteClass
        {
           background-color: #FFF;
        }
        
</style>

 <script type="text/javascript">
 
 		var data;
 		var dataExcelExport;
 		var temp='<%=branchval%>';
 		var temp1='<%=fromDate%>';
 		var temp2='<%=toDate%>';    
 
 		data = '<%=cpl.budgetVarianceLoad(branchval, fromDate, toDate, level1, level2, level3, level4, check, rate, onedaylessdt, entrydate)%>';
 		dataExcelExport = '<%=cpl.budgetVarianceExcel(check, entrydate)%>'; 
        $(document).ready(function () {
      	  	
            var source =
             {
                 dataType: "json",
                 dataFields: [
					  { name: "id", type: "number" },
                      { name: 'description', type: 'string' },
                      { name: "parentid", type: "number" },
                      { name: "ordno", type: "number" },
                      { name: "groupno", type: "number" },
                      { name: "subac", type: "number" },
                      
                      { name: 'subchildamtba', type: 'number' },
                      { name: 'grpamtba', type: 'number' },
                      { name: 'childamtba', type: 'number' },
                      { name: 'netamtba', type: 'number' },
                      
                      { name: 'subchildamtam', type: 'number' },
                      { name: 'grpamtam', type: 'number' },
                      { name: 'childamtam', type: 'number' },
                      { name: 'netamtam', type: 'number' },
                      
                      { name: 'subchildamtva', type: 'number' },
                      { name: 'grpamtva', type: 'number' },
                      { name: 'childamtva', type: 'number' },
                      { name: 'netamtva', type: 'number' },  
                 ],
                 hierarchy:
                 {
                     keyDataField: { name: 'id' },
                     parentDataField: { name: 'parentid' }
                 },
                 id: 'id',
                 localData: data
             };
	        
            var dataAdapter = new $.jqx.dataAdapter(source, {
                loadComplete: function () {
                }
            });
            
            var cellclassname = function (row, column, value, data) {
            	 if (data.ordno == '5') {
                     return "headClass";
                 } else if (data.ordno == '3') {
                     return "redClass";
                 } else if (data.ordno == '4') {
                 	 return "violetClass";
                 }else if (data.ordno == '0'){
                 	 return "yellowClass";
                 }else{
                	 return "whiteClass";
                 };
            };
            
            $("#jqxBudgetGrid").jqxTreeGrid(
            {
                source: dataAdapter,
                width: '99.5%',
                height: 400,
                ready: function() 
                {
                	var rows = $("#jqxBudgetGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#jqxBudgetGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                	}
                }, 
                
                columns: [
						  { text: 'Id',  hidden: true, datafield: 'id', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Parent Id',  hidden: true, datafield: 'parentid', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Ord No',  hidden: true, datafield: 'ordno', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Group No',  hidden: true, datafield: 'groupno', cellclassname: cellclassname, width: '10%'  },
						  { text: 'Account',  hidden: true, datafield: 'subac', cellclassname: cellclassname, width: '10%'  },
		                  { text: 'Description',  datafield: 'description', cellclassname: cellclassname, width: '16%'  },
		                  
		                  { text: 'Detail',  datafield: 'subchildamtba', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'forecast' },
		                  { text: 'Main',  datafield: 'grpamtba', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'forecast' },
		                  { text: 'Group I',  datafield: 'childamtba', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'forecast' },
		                  { text: 'Group II',datafield: 'netamtba', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'forecast' },
		                  
		                  { text: 'Detail',  datafield: 'subchildamtam', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'actual' },
		                  { text: 'Main',  datafield: 'grpamtam', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'actual' },
		                  { text: 'Group I',  datafield: 'childamtam', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'actual' },
		                  { text: 'Group II',datafield: 'netamtam', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'actual' },
		                  
		                  { text: 'Detail',  datafield: 'subchildamtva', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'variance' },
		                  { text: 'Main',  datafield: 'grpamtva', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'variance' },
		                  { text: 'Group I',  datafield: 'childamtva', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'variance' },
		                  { text: 'Group II',datafield: 'netamtva', cellclassname: cellclassname, cellsAlign: "right", align: "right", cellsFormat: "d2", width: '7%',columngroup:'variance' },
                       ], columngroups:      
		                     [
			                       { text: 'Forecast', align: 'center', name: 'forecast',width: '20%' },
			                       { text: 'Actual', align: 'center', name: 'actual',width: '20%' },
			                       { text: 'Variance', align: 'center', name: 'variance',width: '20%' }
			                 ]
            });
            
            if(temp=='NA'){
                $("#jqxBudgetGrid").jqxGrid("addrow", null, {});
            }
            
            $("#overlay, #PleaseWait").hide();
        });
    </script>

    <div id="jqxBudgetGrid"></div>
