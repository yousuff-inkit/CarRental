<%@page import="com.dashboard.analysis.ratioanalysis.ClsRatioAnalysisDAO" %>  
<%ClsRatioAnalysisDAO cbs=new ClsRatioAnalysisDAO(); %>  
<%   String branchval = request.getParameter("branchval")==null?"NA":request.getParameter("branchval").trim();
	 String fromDate = request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").trim();
	 String toDate = request.getParameter("todate")==null?"0":request.getParameter("todate").trim();
	 String check = request.getParameter("check")==null?"0":request.getParameter("check");%>
	 
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
        .greenClass
        {
           background-color: #CEFFCE;
        }
        
</style>

 <script type="text/javascript">
 		var data;
        $(document).ready(function () {  
        	data = '<%=cbs.ratioAnalysisData(branchval, fromDate, toDate, check)%>';      
        	//console.log(data)
            var source =
             {
                 dataType: "json",
                 dataFields: [
                	  { name: 'id', type: 'string' },
                	  { name: 'parentid', type: 'string' },  
                      { name: 'description', type: 'string' },
                      { name: "group1", type: "number" },
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
            	 if (data.parentid == null) {
                     return "headClass";
                 } 
            	 if (data.parentid != null) {  
                     return "redClass";
                 }    
            };  
            
            $("#jqxRatioGrid").jqxTreeGrid(
            {
                source: dataAdapter,
                width: '99.5%',
                height: 520,
                ready: function() 
                {
                	var rows = $("#jqxRatioGrid").jqxTreeGrid('getRows');
                	for(var i=1;i <= rows.length; i++){
                		$("#jqxRatioGrid").jqxTreeGrid('expandRow',rows[i-1].id);
                		//$('#btnprint').attr("disabled",false);
                	}
                }, 
                
                columns: [
                	      { text: 'ID',  datafield: 'id', width:'5%', hidden:true }, 
                	      { text: 'Parent ID',  datafield: 'parentid', width:'5%', hidden:true },       
		                  { text: 'Description',  datafield: 'description', cellclassname: cellclassname }, 
		                  { text: 'Percentage',  datafield: 'group1' , cellsAlign: "right", align: "right", cellsFormat: "d2", width: '15%', cellclassname: cellclassname },
                       ]  
            });
            $("#overlay, #PleaseWait").hide();     
        });
    </script>
    <div id="jqxRatioGrid"></div>