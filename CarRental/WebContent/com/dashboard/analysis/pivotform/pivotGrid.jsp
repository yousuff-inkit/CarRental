 <%@page import="com.dashboard.analysis.pivotform.ClsPivotFormDAO" %>     
 <%@page import="javax.servlet.http.HttpServletRequest" %>
 <%@page import="javax.servlet.http.HttpSession" %>
 <% ClsPivotFormDAO sd=new ClsPivotFormDAO(); %>       
 <% String fromdate =request.getParameter("fromdate")==null?"0":request.getParameter("fromdate").toString(); 
  String todate =request.getParameter("todate")==null?"0":request.getParameter("todate").toString(); 
  String id =request.getParameter("id")==null?"0":request.getParameter("id").toString();
  String title =request.getParameter("formname")==null?"":request.getParameter("formname").toString();
  String formname = request.getParameter("name")==null?"":request.getParameter("name");%>
  <style>
        .columnStyle {
            background-color: rgba(254, 173, 117, 255);
        }

        .columnStyleSelected {
            background-color: rgba(234, 153, 87, 255);
        }

        .rowStyle {
            background-color: rgba(187, 232, 227, 255);
        }

        .rowStyleSelected {
            background-color: rgba(167, 212, 207, 255);
        }

        .cellStyle {
            background-color: rgba(255, 255, 255, 255);            
        }

        .cellStyleSelected {
            background-color: rgba(239, 249, 136, 255);
            color: rebeccapurple;
        }
	   .jqx-pivotgrid{
	        background-color: #f9f9f9;
	   }
	   .jqx-pivotgrid-item {
	   		font-size:10px;
	   }
	   .jqx-grid-cell-normal{
	   		font-size:10px;
	   }
    </style>
 
 <script type="text/javascript">
         var data;   
	     var formname = '<%=formname%>';  
	     $(document).ready(function () {
	    	 data= '<%= sd.loadGridData(session,fromdate,todate,title)%>';
	    	 var titlename = $("#formname").val();
	    	 if(titlename!=""){
	    		 formname = titlename;  
	    	 }
	    	 var dataitems = getDatafields(formname).split('####');
	    	 var rendererstring1=function (aggregates){  
	             	var value=aggregates['sum'];
	             	if(typeof(value) == "undefined"){
	             		value=0.00;
	             	}
	             	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' + " " + '' + value + '</div>';
	             }
            // create a data source and data adapter
            var source =
            {
                localdata: data,  
                datatype: "json",
                datafields:  JSON.parse(dataitems[0].trim()),    
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            dataAdapter.dataBind();
            // create a pivot data source from the dataAdapter
            var pivotDataSource = new $.jqx.pivot(
                dataAdapter,
                {
                    customAggregationFunctions: {
                        'var': function (values) {
                            if (values.length <= 1)
                                return 0;
                            // sample's mean
                            var mean = 0;
                            for (var i = 0; i < values.length; i++)
                                mean += values[i];
                            mean /= values.length;
                            // calc squared sum
                            var ssum = 0;
                            for (var i = 0; i < values.length; i++)
                                ssum += Math.pow(values[i] - mean, 2)
                            // calc the variance
                            var variance = ssum / values.length;
                            return variance;
                        }
                    },
                    pivotValuesOnRows: false,
                    totals: {rows: {subtotals: true, grandtotals: true}, columns: {subtotals: false, grandtotals: true}},  
                    fields: JSON.parse(dataitems[1].trim()),
                    rows: JSON.parse(dataitems[2].trim()),
                    columns: JSON.parse(dataitems[3].trim()),
                    values: JSON.parse(dataitems[4].trim())                 
                });
            var localization = { 'var': 'Variance' };             
            // create a pivot grid
            $('#jqxPivot').jqxPivotGrid(
            {
                localization: localization,
                source: pivotDataSource,
                treeStyleRows: true,
                autoResize: false,   
                multipleSelectionEnabled: true,     
            });
            var pivotGridInstance = $('#jqxPivot').jqxPivotGrid('getInstance');
            
          /*   $('#jqxPivot').on('pivotcellclick', function (event) {
                alert('cell click, row: ' + event.args.pivotRow.text + ' , column:' + event.args.pivotColumn.text + ' , mouse button:' + event.args.mousebutton );
           });   */
            //alert("==="+pivotGridInstance)   
            //create a pivot grid
            $('#divPivotGridDesigner').jqxPivotDesigner(
            {
                type: 'pivotGrid',
                target: pivotGridInstance
            });
            $('#divPivotGridDesigner').jqxPivotDesigner('refresh');
      	    $("#overlay, #PleaseWait").hide();
        });
    </script>
       <div id="jqxPivot" style="height:435px" ></div>    