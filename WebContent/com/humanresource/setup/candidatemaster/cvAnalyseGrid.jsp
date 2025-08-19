<%@page import="com.humanresource.setup.candidatemaster.ClsCandidateMasterDAO"%>
<%ClsCandidateMasterDAO DAO= new ClsCandidateMasterDAO(); %>
<% String mode = request.getParameter("mode")==null?"view":request.getParameter("mode");%>
<% String docNo = request.getParameter("docno")==null?"0":request.getParameter("docno"); %>
<style type="text/css">
  .statutoryDeductionClass
  {
      background-color: #FDF9EF;
  }
</style>
<script type="text/javascript">
		var tempMode='<%=mode%>';
		var tempDocNo='<%=docNo%>';
		var temp='0';
		var data4;
		var gridData = [];
		
        $(document).ready(function () { 	
        	
        	 <%-- if(tempDocNo>0 && tempMode=='E') {
         		 
         		data1='<%=DAO.allowanceEditReloading(docNo)%>';
         		
         	 } else  --%>
         	 if(tempDocNo>0) {
         		 data4='<%=DAO.cvGridReloading(docNo)%>';
          	 } else {
          		data4='<%=DAO.cvGridloading()%>';
         		 temp='1';
         	 }
         	 
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
							{name : 'questions', type: 'string' },
     						{name : 'remarks', type: 'string' },
     						{name : 'grade', type: 'string'   },
     						{name : 'srno', type: 'number'   },
     						{name : 'isnumber', type: 'number'   },
     						{name : 'formula', type: 'string'},
     						{name : 'isround', type: 'string'},
     						{name : 'roundto', type: 'string'},
                        ],
                		 localdata: data4, 
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
            
            var dropdownListSource=['Excellent','Good','Average','Poor'];
            
            var dataAdapter = new $.jqx.dataAdapter(source,{
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
			         });

            
            $("#cvAnalyseGridID").jqxGrid(
            {
            	width: '100%',
                height: 250,
                source: dataAdapter,
                editable: true,
                selectionmode: 'singlecell',
                localization: {thousandsSeparator: ""},
                handlekeyboardnavigation: function (event) {
                    var cell = $('#cvAnalyseGridID').jqxGrid('getselectedcell');
                    if (cell != undefined && cell.datafield == 'grade') {
                        var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                        if (key == 9 && chkcvconfig!=2) {   
                            $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
                            return true;                         
                        }
                    }
                    
                }, 
                
                columns: [
							{ text: 'S#', sortable: false, filterable: false, editable: false,
                              groupable: false, draggable: false, resizable: false,datafield: '',
                              columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
                              cellsrenderer: function (row, column, value) {
                                  return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                              }    
							},
							{ text: 'Questions', datafield: 'questions',  width: '40%'},
							{ text: 'Remarks', datafield: 'remarks',  width: '40%', validation: (cell, value) => {
								 let rowIndex = cell.row;
					             let rowData = $('#cvAnalyseGridID').jqxGrid('getrowdata', rowIndex);
					             //console.log("Entered - "+rowData.isnumber);
					             if(rowData.isnumber==1 && $('#hidcmbcvconfig').val()==2){
					            	 var decimalRegex = /^-?\d*\.?\d*$/;
					                 if(!decimalRegex.test(value)){
					                	 //console.log("if  -  "+decimalRegex.test(value));
					                	 return {result:false, message:'Invalid value!'}
					             	}
					             } 
					        	return true; 
							}},			
							{ text: 'srno', datafield: 'srno',  width: '40%', hidden:true},			
							{ text: 'Grade', datafield: 'grade', width: '15%',columntype: 'dropdownlist',
								initeditor: function (row, cellvalue, editor) {
			                          editor.jqxDropDownList({ source: dropdownListSource});
								}
							},	
						]
            });

            //Add empty row
            if(temp=='1'){
           	   $("#cvAnalyseGridID").jqxGrid('addrow', null, {});
             }
            
            if(tempDocNo>0 && tempMode=='view'){
            	$("#cvAnalyseGridID").jqxGrid('disabled', true);
            }


            $("#cvAnalyseGridID").on('cellvaluechanged', function (event) {
                var rowIndex = event.args.rowindex;
                let rowData = $('#cvAnalyseGridID').jqxGrid('getrowdata', rowIndex);
                if(chkcvconfig==2){
	                var rows = $('#cvAnalyseGridID').jqxGrid('getrows');
	                rows.forEach(item => {
	                	let placeholderRegex = /row\d+/g;
	                	let formula = item.formula;
	                	let isround = item.isround;
	                	let roundto = item.roundto;
	                	let evaluatedExpression = formula.replace(placeholderRegex, function (match) {
	                         // Extract the numeric part from "row1" -> 1, "row2" -> 2, etc.
	                         let rowNumber = parseInt(match.substring(3)); // Assuming row IDs are in the form of "row1", "row2", ...
	
	                         // Find the corresponding value from gridData
	                         let rowDat = rows.find(row =>row.srno == rowNumber);
	                         if (rowDat) {
	                         	 console.log("remarks"+rowNumber+" - "+rowDat.remarks)
	                             return rowDat.remarks==''||typeof(rowDat.remarks)=='undefined'||rowDat.remarks==null||isNaN(rowDat.remarks)?0:rowDat.remarks; // Replace placeholder with its value
	                         } else {
	                        	 console.log("match"+rowNumber+" - "+match);
	                             return match; // If no matching data found, return the original placeholder
	                         }
	                     });
	                	  try {
	                			let result = eval?.(evaluatedExpression);
	                			if(isround==1){
	                				result=result.toFixed(roundto);
	                			}
	                			item.remarks=isNaN(result)||!isFinite(result)?0:result;
	                			//console.log("remarks final - "+item.remarks);
	                	  } catch (error){
	                	  }
	                });
	                let dataAdapter = new $.jqx.dataAdapter({
	                    localdata: rows,
	                    datatype: "array"
	                });
	                $("#cvAnalyseGridID").jqxGrid({ source: dataAdapter });
                }
            });
        });
  </script>
<div id="cvAnalyseGridID"></div>
 