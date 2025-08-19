<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<%String formmain = request.getParameter("main")==null?"":request.getParameter("main");
String formname = request.getParameter("name")==null?"":request.getParameter("name");%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>-</title>                             
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="../../../../reportincludes.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css"> 
<link rel="stylesheet" type="text/css" href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css">
<link href="../../../../vendors/select2/select2.min.css" rel="stylesheet" />  
  <style type="text/css"> 
  #border1 {
	border-radius: 5px;
	height: 40px;
	width: 200px;
	-moz-box-shadow: inset 0 0 3px #000000;
	-webkit-box-shadow: inset 0 0 3px #000000;
	box-shadow: inset 0 0 3px #000000;
}

#btnadd {}

.btn-group>.btn:first-child:not(:last-child):not(.dropdown-toggle) {
	border-radius: 30px !important;
}

.btn:focus,
.btn:active {
	outline: none !important;
	box-shadow: none;
}

.modalStyle {
	background-color: #33b5e5;
	padding: 1px;
}

.borderStyle {
	margin-bottom: 0;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	border: none;
	line-height: 1.42857143;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	box-shadow: 1px 2px 7px 3px #d4cece;
	position: relative;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
}

.iconStyle {
	color: #000000 !important;
	display: inline-block;
	border: none;
	transition: all 0.4s ease 0s;
}

.btnStyle {
	display: inline-block;
	margin-bottom: 0;
	font-weight: 400;
	margin-right: 5px;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	background-image: none;
	border: none;
	padding: 3px 8px;
	font-size: 14px;
	line-height: 1.42857143;
	border-radius: 30px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	box-shadow: 0px 2px 3px 0.1px rgba(0, 0, 0, 0.6);
	position: relative;
	-webkit-transition: all 0.3s;
	-moz-transition: all 0.3s;
	transition: all 0.3s;
}

@media (min-width: 900px) {
	.modal-xl {
		width: 100%;
		max-width: 1200px;
	}
}

.textpanel p.h4 {
	margin-top: 8px;
	margin-bottom: 6px;
}

.custompanel {
	float: left;
	display: inline-block;
	margin-top: 3px;
	padding: 6px;
	border-radius: 25px;
	border: 1px solid #7B7878;
	 -moz-box-shadow:    inset 0 0 3px #000000;
      -webkit-box-shadow: inset 0 0 3px #000000;
      box-shadow:         inset 0 0 3px #000000; 
}

.badge-notify {
	position: absolute;
	right: -5px;
	top: -8px;
	z-index: 2;
	background-color: red;
}

.comment {
	background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: #fff;
	clear: both;
	float: right;
	display: block;
	padding-top: 8px;
	padding-bottom: 2px;
	padding-left: 10px;
	padding-right: 5px;
	border-radius: 12px;
	border-top-right-radius: 0;
	margin-bottom: 8px;
	transition: all 0.5s ease-in;
}

.msg-details {
	text-align: right;
}

.comments-container {
	height: 400px;
	overflow-y: auto;
	margin-bottom: 8px;
	padding-right: 5px;
}

.comments-outer-container {
	width: 100%;
	height: 100%;
}

.msg {
	word-break: break-all;
}

.rowgap {
	margin-bottom: 6px;
}

.select2-selection--single {
	width: 100%;
}

.hidden-scrollbar {
	/* // overflow: auto; */
	height: 530px;
	overflow-x: hidden;

}

#leadDiv div {
	box-sizing: content-box !important;
}
.padrow{
	padding-top:3px;
}
 .draggable-item {
      color: black;
      padding: 10px;
      margin: 5px;  
      cursor: move;
    }

    .droppable-container {
      border: 2px solid #EDEEF1;
      height: 123px;
      overflow: auto;
    }

    .dropped-item {
      margin-bottom: 1px;
      text-align:center;
      font-size:12px;
    }
  
 #draggable-container{  
     border: 2px solid #EDEEF1;
     width: 569px;
     height: 190px;
     overflow: auto;
 }   
 .draggable-item{
    padding:1px;
    text-align:center;
    font-size:12px;
 }
 h6{
 	text-align:center;
 	background-color: #C0F3FE;
 	margin:0px;
 	padding:5px;
 	font-weight: bold;
 	position: fixed;
 }
 .select2-selection__rendered{
  	font-size:10px;
 } 
 #pivotChart{  
   height:370px;
   width:650px;
 } 
</style>
</head>       
<body>
<div class="hidden-scrollbar">
   <div class="container-fluid" >
      <div class="row" >
         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div class="primarypanel custompanel" style="margin-left:5px;">
               <table>
                  <tr>
                     <td align="right"><label class="branch" style="font-size: 13px">Pivot Designs&nbsp;</label></td>
                     <td align="left"><select class="form-control" name="cmbpivotdesigns" id="cmbpivotdesigns" onchange="funload();getDatafields('');"></select></td>
                     <td align="right" ><label class="branch" style="font-size: 13px">&nbsp;From&nbsp;&nbsp;</label></td>
                     <td align="left"><div id='fromdate' ></div></td>
                     <td align="right" ><label class="branch" style="font-size: 13px">&nbsp;To&nbsp;&nbsp;</label></td>
                     <td align="left"> <div id='todate' ></div></td>
                  </tr>
               </table>
            </div>
            <div class="primarypanel custompanel" style="margin-left:6px;">
               <button type="button" class="btn btn-default btnStyle" id="btnpivot" data-toggle="tooltip" title="Pivot Designer" data-placement="bottom"><i class="fa fa-product-hunt " aria-hidden="true"></i></button>    
               <button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>    
               <button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
               <button type="button" class="btn btn-default btnStyle" id="btnpivotdesignsave" data-toggle="tooltip" title="Save Pivot Design" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button>    
               <button type="button" class="btn btn-default btnStyle" id="btnpivotchart" data-toggle="tooltip" title="Charts" data-placement="bottom"><i class="fa fa-pie-chart " aria-hidden="true"></i></button>       
            </div>  
         </div>
      </div>
      <div class="row" style="padding-top: 5px;">
         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div id="leadDiv" style="height:455px; width: 1250px;">
               <jsp:include page="pivotGrid.jsp"></jsp:include>
            </div>
         </div>
         <br>
         <!-- Pivot modal-->                  
         <div id="modalpivot" class="modal fade" role="dialog">
            <div class="modal-dialog modal-sm">
               <div class="modal-content">
                  <div class="modal-header modalStyle" >
                     <button type="button" class="close" data-dismiss="modal">&times;</button>    
                     <h4 class="modal-title" style="text-align:center">Pivot Designer</h4>
                     <p id="lblname8" style="text-align:center;"></p>
                  </div>
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                           <div id="divPivotGridDesigner" style="height: 400px; width: 274px;"></div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- Save Pivot Design modal-->                    
         <div id="modalsavepivotdesign" class="modal fade" role="dialog">
            <div class="modal-dialog modal-md">
               <div class="modal-content">
                  <div class="modal-header modalStyle" >
                     <button type="button" class="close" data-dismiss="modal">&times;</button>    
                     <h4 class="modal-title" style="text-align:center">Save Pivot Design</h4>
                     <p id="lblname8" style="text-align:center;"></p>
                  </div>
                  <div class="modal-body">
                     <div class="row">  
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">    
                            <div class="form-group">
					            <label class="col-sm-4 control-label" for="textinput" style="text-align:right;">Name</label>
					            <div class="col-sm-8">
					              <input type="text" id="txtpivotdesignname" placeholder="Enter Pivot Design Name" class="form-control" style="height:25px;">
					            </div>    
				          </div>
                        </div>
                     </div>
                     <div class="row padrow">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">    
					            	 <div id="draggable-container">    
					            	    <h6>Fields</h6>
									    <div class="draggable-item" draggable="true" ondragstart="drag(event)">Brand</div>
									  </div>
                        </div>
                      </div>
                      <div class="row padrow">     
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">    
						          <div id="droppable-row-container" class="droppable-container" ondrop="drop(event, 'droppable-row-container')" ondragover="allowDrop(event)">
								    <h6>Rows</h6>
								    <br>
								  </div> 
				          </div>
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">    
                                  <div id="droppable-col-container" class="droppable-container" ondrop="drop(event, 'droppable-col-container')" ondragover="allowDrop(event)">
								    <h6>Columns</h6>
								    <br>
								  </div> 
                        </div>
                         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-4">    
                                  <div id="droppable-val-container" class="droppable-container" ondrop="drop(event, 'droppable-val-container')" ondragover="allowDrop(event)">  
								    <h6>Values</h6>
								    <br>
								  </div> 
                        </div>
                     </div>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-default btnStyle" id="btnpdsave" data-toggle="tooltip" title="Save" data-placement="bottom"><i class="fa fa-floppy-o " aria-hidden="true"></i></button> 
                     <button type="button" class="btn btn-default btnStyle" id="btnclose" data-toggle="tooltip" title="Close" data-placement="bottom" data-dismiss="modal"><i class="fa fa-times-circle " aria-hidden="true"></i></button>    
                  </div>
               </div>
            </div>
         </div>
         <!-- Charts modal-->                  
         <div id="modalcharts" class="modal fade" role="dialog">
            <div class="modal-dialog">
               <div class="modal-content">
                  <div class="modal-header modalStyle" >
                     <button type="button" class="close" data-dismiss="modal">&times;</button>    
                     <h4 class="modal-title" style="text-align:center">Charts</h4>
                     <p id="lblname8" style="text-align:center;"></p>
                  </div>
                  <div class="modal-body"> 
                     <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                           <canvas id="pivotChart" width="400" height="200"></canvas>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>  
         
      </div>
   </div>
</div>	
<input type="hidden" name="formname" id="formname">	  
<script src="../../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../../../../vendors/select2/select2.min.js"></script>
<script type="text/javascript" src="../../../../js/sweetalert2.all.min.js"></script>  
<script type="text/javascript" src="../../../../js/tableExport.min.js"></script>  
<script type="text/javascript" src="../../../../js/Chart.min.js"></script>  
<script type="text/javascript"> 
    var title = "";
    $(document).ready(function() {
        title = '<%=formname%>';
        $("#formname").val(title);
        getPivotDesigns(title)
        $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
        $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
        $('[data-toggle="tooltip"]').tooltip();
        $("#fromdate").jqxDateTimeInput({
            width: '110px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
        $("#todate").jqxDateTimeInput({
            width: '110px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
        var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
        var onemounth = new Date(new Date(fromdates).setMonth(fromdates.getMonth() - 1));

        $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
        $('#todate').on('change', function(event) {
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
            if (fromdates > todates) {
            	swal.fire({
    				icon: 'warning',
    				title: 'Warning',
    				text: 'To Date Is Less Than From Date!'
    			});
                return false;
            }
        });
        $('#fromdate').on('change', function(event) {
            var fromdates = new Date($('#fromdate').jqxDateTimeInput('getDate'));
            var todates = new Date($('#todate').jqxDateTimeInput('getDate'));
            if (fromdates > todates) {
            	swal.fire({
    				icon: 'warning',
    				title: 'Warning',
    				text: 'From Date Is Greater Than To Date!' 
    			});
                return false;
            }
        });

        $('#btnsubmit').click(function() {
            funload();
        });

        $('#btnexcel').click(function() {
        	var titlename = $("#formname").val();
	    	if(titlename!=""){
	    		title = titlename;  
	    	}
            //JSONToCSVCon(data, title, true);    
            var pivotRows = $('#jqxPivot').jqxPivotGrid('getPivotRows')
            var pivotColumns = $('#jqxPivot').jqxPivotGrid('getPivotColumns')
            var pivotCells = $('#jqxPivot').jqxPivotGrid('getPivotCells') 
            exportTable(pivotRows, pivotColumns, pivotCells, title)
        });

        $('#btnpivot').click(function() {
            $('#modalpivot').modal('toggle');
        });
        
        $('#btnpivotdesignsave').click(function() {
        	fetchDesignerFields()
        	funclear() 
            $('#modalsavepivotdesign').modal('toggle')
        });
        
        $('#btnpdsave').click(function() {
        	funPivotDesign()
        });
        
        $('#btnpivotchart').click(function() {
        	 var pivotRows = $('#jqxPivot').jqxPivotGrid('getPivotRows')
             var pivotColumns = $('#jqxPivot').jqxPivotGrid('getPivotColumns')
             var pivotCells = $('#jqxPivot').jqxPivotGrid('getPivotCells') 
        	 funChartLoad(pivotRows, pivotColumns, pivotCells)
        	 $('#modalcharts').modal('toggle')
        });
        
        $("#cmbpivotdesigns").select2({
		    placeholder: "Predefined Pivot Designs",      
		    allowClear: true,
		    width: '100%'
		});
        $("#cmbpivotfields").select2({
		    placeholder: "Pivot Fields",        
		    allowClear: true,
		    width: '100%'
		});
        
        $('#btnpdrow').click(function() {
            var pivotrow = $('#pivotrows').val();
        	var field = $("#cmbpivotfields").val();
        	var newval = "";
        	if(pivotrow==null || pivotrow==""){
        		newval = field;
        	}else{
        		newval = pivotrow+","+field;
        	}
        	$('#pivotrows').val(newval);
        });
        
        $('#btnpdcol').click(function() {
            var pivotcol = $('#pivotcols').val();
        	var field = $("#cmbpivotfields").val();
        	var newval = "";
        	if(pivotcol==null || pivotcol==""){
        		newval = field;
        	}else{
        		newval = pivotcol+","+field;
        	}
        	$('#pivotcols').val(newval);
        });
        
        $('#btnpdsaveval').click(function() {
            var pivotval = $('#pivotvals').val();
        	var field = $("#cmbpivotfields").val();
        	var newval = "";
        	if(pivotval==null || pivotval==""){
        		newval = field;
        	}else{
        		newval = pivotval+","+field;
        	}
        	$('#pivotvals').val(newval);
        });
    });

    function funload() {
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        $("#overlay, #PleaseWait").show();
        $('#jqxPivot').jqxPivotGrid('refresh');
        $("#leadDiv").load("pivotGrid.jsp?fromdate=" + fromdate + "&todate=" + todate + "&formname=" + encodeURIComponent($("#formname").val()) + "&id=1");
    }

    function JSONToCSVCon(JSONData, ReportTitle, ShowLabel) {
        var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
        var CSV = '';
        CSV += ReportTitle + '\r\n\n';
        if (ShowLabel) {
            var row = "";
            for (var index in arrData[0]) {
                row += index + ',';
            }
            row = row.slice(0, -1);
            CSV += row + '\r\n';
        }
        for (var i = 0; i < arrData.length; i++) {
            var row = "";
            for (var index in arrData[i]) {
                row += '"' + arrData[i][index] + '",';
            }
            row.slice(0, row.length - 1);
            CSV += row + '\r\n';
        }
        if (CSV == '') {
        	swal.fire({
				icon: 'warning',
				title: 'Warning',
				text: 'Invalid data!'
			});
            return;
        }
        var fileName = "";
        fileName += ReportTitle.replace(/ /g, "_");
        var temp = CSV;
        blob = new Blob([temp], {
            type: 'text/csv'
        });
        var bigcsv = window.webkitURL.createObjectURL(blob);
        var link = document.createElement("a");
        link.href = bigcsv;
        link.style = "visibility:hidden";
        link.download = fileName + ".csv";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    }

    function getDatafields(formname) {
    	var titlename = $("#formname").val();
    	if(titlename!=""){
    		formname = titlename;    
    	}
    	var pivotdesign = $("#cmbpivotdesigns").val()
    	if(typeof(pivotdesign)=="undefined" || typeof(pivotdesign)=="NaN" || pivotdesign==null || pivotdesign==""){
    		pivotdesign = "0";
    	}
        var items;
        var x = new XMLHttpRequest();
        x.onreadystatechange = function() {
            if (x.readyState == 4 && x.status == 200) {
                items = x.responseText.trim();
            }
        }
        x.open("GET", "getDatafields.jsp?formname=" + encodeURIComponent(formname)+"&pivotdesign="+pivotdesign, false);
        x.send();
        return items;
    }
    
    function funPivotDesign(){
    	var pdname = $("#txtpivotdesignname").val()
    	if(pdname=="" || pdname==null){
    		swal.fire({
				icon: 'warning',
				title: 'Warning',
				text: 'Please enter pivot design name!'
			});
    		return false;
    	}
    	
    	var rowmainDiv = document.getElementById('droppable-row-container');
		var rowfields = getDivContent(rowmainDiv)

		var colmainDiv = document.getElementById('droppable-col-container');
		var colfields = getDivContent(colmainDiv)
		  
		var valmainDiv = document.getElementById('droppable-val-container');
		var valfields = getDivContent(valmainDiv)
		
		if((rowfields=="" || rowfields==null) && (colfields=="" || colfields==null) && (valfields=="" || valfields==null)){
    		swal.fire({
				icon: 'warning',
				title: 'Warning',
				text: 'There is no content selected!'
			});
    		return false;
    	}  
		var titlename = $("#formname").val();
    	if(titlename!=""){
    		title = titlename;  
    	}
    	Swal.fire({
    		  icon: "question",
    		  title: "Do you want to save the changes?",
    		  showDenyButton: true,
    		  showCancelButton: true,
    		  confirmButtonText: "Save",
    		  denyButtonText: `Don't save`
    		}).then((result) => {
    		  if (result.isConfirmed) {
    			  savePivotDesign(pdname, rowfields, colfields, valfields, title)      			  
    		  } else if (result.isDenied) {  
    		    Swal.fire("Changes are not saved", "", "info");
    		  }
    		});
    }
    
    function getDivContent(mainDiv){
    	  var childDivs = mainDiv.getElementsByClassName('dropped-item');
		  var Array = [];
		  for (var i = 0; i < childDivs.length; i++) {
			  Array.push(childDivs[i].textContent.trim());
		  }
		  return Array.join(',');
    }
    
    function savePivotDesign(pdname, rowfields, colfields, valfields, title){
    	var x = new XMLHttpRequest()
    	x.onreadystatechange = function(){
    		if(x.readyState == 4 && x.status == 200){
    			var items = x.responseText.trim()
    			if(parseInt(items)>0){
    				$('#modalsavepivotdesign').modal('toggle');
    				getPivotDesigns(title)
    				Swal.fire("Saved!", "", "success"); 
    			}
    		}
    	}
    	x.open("GET", "savePivotDesign.jsp?name="+encodeURIComponent(pdname)+"&rowfields="+encodeURIComponent(rowfields)+"&colfields="+encodeURIComponent(colfields)+"&valfields="+encodeURIComponent(valfields)+"&formname="+encodeURIComponent(title))
    	x.send() 
    }
    
	function getPivotfields() {
		var titlename = $("#formname").val();
    	if(titlename!=""){
    		title = titlename;  
    	}
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				items = items.split('####');
				var brandidItems = items[0].split(",");
				var brandItems = items[1].split(",");
				var optionsbrand;
				for (var i = 0; i < brandItems.length; i++) {
					optionsbrand += '<option value="' + brandidItems[i] + '">'
							+ brandItems[i] + '</option>';
				}

				$("select#cmbpivotfields").html(optionsbrand);
			} else {
			}
		}
		x.open("GET", "getPivotfields.jsp?formname="+encodeURIComponent(formname), true);     
		x.send();
	}
	
	function allowDrop(event) {
	      event.preventDefault();
	}

	function drag(event) {
	      event.dataTransfer.setData("text", event.target.innerText);
	}

	function drop(event, droppableId) {
	      event.preventDefault();
	      var data = event.dataTransfer.getData("text");
	      var droppedItem = document.createElement("div");
	      droppedItem.className = "dropped-item";
	      droppedItem.innerText = data;
	      funShuffleDivs(data)
	      document.getElementById(droppableId).appendChild(droppedItem);
	 }
	
	function funShuffleDivs(divContent){
	    var rowsDiv = document.getElementById('droppable-row-container')
		shuffleRemove(rowsDiv, divContent)
		var colsDiv = document.getElementById('droppable-col-container')
		shuffleRemove(colsDiv, divContent)
		var valsDiv = document.getElementById('droppable-val-container')
		shuffleRemove(valsDiv, divContent)
	}
	
	function shuffleRemove(mainDiv, divContent){
		var childDivs = mainDiv.getElementsByClassName('dropped-item')
		for(var i=childDivs.length-1;i>=0;i--){
		    if(childDivs[i].textContent.trim() == divContent.trim()){
				mainDiv.removeChild(childDivs[i])
			}
		}
    }
	
	function fetchDesignerFields() { 
		var titlename = $("#formname").val();
    	if(titlename!=""){
    		title = titlename;  
    	}
        $.ajax({
            url: 'getPivotfields.jsp?formname='+title, 
            method: 'GET',
            dataType: 'json',
            success: function(data) {
                data.forEach(function(item) {
                    var newDiv = $('<div>').text(item.text);
                    $('#draggable-container').append(newDiv);  
                });
            },
            error: function(error) {
                console.error('Error fetching data:', error);
            }
        });
    }
	
	function fetchDesignerFields(){
			var titlename = $("#formname").val();
	    	if(titlename!=""){
	    		title = titlename;  
	    	}    
			var x = new XMLHttpRequest();
	  		x.onreadystatechange = function() {
	  			if (x.readyState == 4 && x.status == 200) {
	  				var items = x.responseText.trim();
	  				var fielddata = JSON.parse(items.trim());          
	  				var fieldshtml='<h6>Fields</h6>';    
	  				$.each(fielddata.datafields, function( index, value ) {     
	  					fieldshtml+='<div class="draggable-item" draggable="true" ondragstart="drag(event)">'+value.field+'</div>';     
	  				});
	  				$('#draggable-container').html($.parseHTML(fieldshtml));    
	  			}
	  		}
	  		x.open("GET", "getPivotfields.jsp?formname="+title, true);  
	  		x.send();
		} 
	
	function funclear(){
		$('#txtpivotdesignname').val('')  
		var rowsDiv = document.getElementById('droppable-row-container')
		divRemove(rowsDiv)
		var colsDiv = document.getElementById('droppable-col-container')
		divRemove(colsDiv)
		var valsDiv = document.getElementById('droppable-val-container')
		divRemove(valsDiv)  
	}
	
	function divRemove(mainDiv){
		var childDivs = mainDiv.getElementsByClassName('dropped-item')
		for(var i=childDivs.length-1;i>=0;i--){
			mainDiv.removeChild(childDivs[i])
		}
	}
	
	function getPivotDesigns(title) {
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				var itemss = x.responseText;
				itemss = itemss.split('####');
				var srno1  = itemss[0].split(",");
				var process1 = itemss[1].split(",");
				var optionsbranch1;
				for (var i = 0; i < process1.length; i++) {
					optionsbranch1 += '<option value="' + srno1[i].trim() + '">'
							+ process1[i].trim() + '</option>';
				}
				$("select#cmbpivotdesigns").html(optionsbranch1);
				
			} else {
			}
		}
		x.open("GET","getPivotDesigns.jsp?formname="+encodeURIComponent(title), true);  
		x.send();
	}
	
	function exportTable(pivotRows, pivotColumns, pivotCells, title){
    	var numRows = pivotRows.items.length
    	var rowArray = []
    	for (var i = 0; i < numRows; i++) {
    		  rowArray.push(pivotRows.items[i].text)
    	} 
    	//console.log(rowArray)
    	
    	var numCols = pivotColumns.items.length
    	var colArray = []
    	var colSubArray = []
    	for(var j=0;j<numCols;j++){
    		colArray.push(pivotColumns.items[j].adapterItem.text)
    	} 
    	for(var k=0;k<pivotColumns.items[0].valueItems.length;k++){
			colSubArray.push(pivotColumns.items[0].valueItems[k].text)  
		}  
    	//console.log(colArray)
    	//console.log(colSubArray)  
    	
        var cellData = pivotCells.cellProperties.namedPropertyTables.CellValue
        var sortedKeys = Object.keys(cellData).sort()
        var masterkeyArray = [], subkeyArray = []
    	var a=0, b=0, i = 0, d = 0; 
    	//console.log(sortedKeys)
    	//console.log(sortedKeys.length)
    	while(i < sortedKeys.length) {
    		var keys = sortedKeys[i].split("_")
    		a = keys[0]
    		d = keys[1]
    		if(i==0){
    			b = keys[0]  
    		}
    		if(a!=b){
    			masterkeyArray.push(b)
    			b = a;
    		} 
    		i++
    	}
    	masterkeyArray.push(a)
    	masterkeyArray.sort(function(a, b) {
		    return a - b;
		});
        //console.log(d+"=masterkeyArray="+masterkeyArray)
        var generateKey="";
    	var keyOuterArray = []
    	for(var j=0; j <= d; j++){
    		var keyInnerArray = []
        	for(var i=0; i < masterkeyArray.length; i++){
        		generateKey = masterkeyArray[i]+"_"+j
        		for (var k = 0; k < sortedKeys.length; k++) {
        			if(generateKey == sortedKeys[k]){
        				  var value = cellData[generateKey].formattedValue
        				  keyInnerArray.push(value)
        			}
  				}
            }
    		keyOuterArray.push(keyInnerArray) 
        }
        //console.log(keyOuterArray)
        //console.log("colSubArray.length="+colSubArray.length)
    	var tableHTML = '<table border="1" id="excelTable">';
    	tableHTML += '<tr><th></th>';
    	
    	colArray.forEach(col => {  
    		  tableHTML += '<th colspan="' + colSubArray.length + '">' + col + '</th>';
        });

        tableHTML += '</tr>';
        
        tableHTML += '<tr><th></th>';
    	
        colArray.forEach(col => {
            colSubArray.forEach(subCol => {
    		    tableHTML += '<th>' + subCol + '</th>';
    		});
        }); 
        
        tableHTML += '</tr>';
        
    	
        var level = 0;
        rowArray.forEach(row => {
        	  tableHTML += '<tr>';
        	  tableHTML += '<td>' + row + '</td>';

        	  var keyOut = keyOuterArray[level]
        	  
        	  keyOut.forEach( innerkey =>{
        				  tableHTML += '<td>' + innerkey + '</td>';
        	  })
        	  tableHTML += '</tr>';
        	  level++
        });

        	tableHTML += '</table>';
        	console.log(tableHTML);
        	
        	var hiddenDiv = document.createElement("div");
        	hiddenDiv.setAttribute("id", "excelDiv");
        	hiddenDiv.style.display = "none";
        	document.body.appendChild(hiddenDiv);
        	document.getElementById("excelDiv").innerHTML = tableHTML; 
        	 
        	$('#excelTable').tableExport({fileName: title});  //CSV 
        	//$('#excelTable').tableExport({type:'excel', escape: "false", fileName: title});  //XLS 
	}
	
	function funChartLoad(pivotRows, pivotColumns, pivotCells){
		var colors = ['#FFD1E3', '#FAEED1', '#C1F2B0', '#8ACDD7', '#6DB9EF', '#E7BCDE', '#DCBFFF', '#39A7FF', '#FFFB73', '#D0BFFF', '#CDFAD5', '#FF6AC2', '#93B1A6', '#FFE5E5', '#40F8FF']
		var numRows = pivotRows.items.length
    	var rowArray = []
		var rowsCount = 0;
    	for (var i = 0; i < numRows; i++) {
    		if(pivotRows.items[i].text.trim() != "Total"){
    		  rowArray.push(pivotRows.items[i].text)
    		  rowsCount++
    		}
    	} 
    	//console.log(rowArray)
    	
    	var numCols = pivotColumns.items.length
    	var labelsArray = []
    	var columnsCount = 0;
    	for(var j=0;j<numCols;j++){
			for(var k=0;k<pivotColumns.items[0].valueItems.length;k++){  
				var label = pivotColumns.items[j].adapterItem.text.trim() + " - " + pivotColumns.items[0].valueItems[k].text.trim();
				if(pivotColumns.items[j].adapterItem.text.trim() != "Total"){     
					labelsArray.push(label)
					columnsCount++
				}
			}
    	}
    	//console.log(labelsArray)  
    	
        var cellData = pivotCells.cellProperties.namedPropertyTables.CellValue
        var sortedKeys = Object.keys(cellData).sort()
        var masterkeyArray = [], subkeyArray = []
    	var a=0, b=0, i = 0, d = 0; 
    	//console.log(sortedKeys)
    	//console.log(sortedKeys.length)
    	while(i < sortedKeys.length) {
    		var keys = sortedKeys[i].split("_")
    		a = keys[0]
    		d = keys[1]
    		if(i==0){
    			b = keys[0]  
    		}
    		if(a!=b){
    			masterkeyArray.push(b)
    			b = a;
    		} 
    		i++
    	}
    	masterkeyArray.push(a)
    	masterkeyArray.sort(function(a, b) {
		    return a - b;
		});
        //console.log(d+"=masterkeyArray="+columnsCount)
        var generateKey="";
    	var keyOuterArray = []
    	for(var j=0; j < rowsCount; j++){
    		var keyInnerArray = []
        	for(var i=0; i < columnsCount; i++){  
        		generateKey = masterkeyArray[i]+"_"+j
        		for (var k = 0; k < sortedKeys.length; k++) {
        			if(generateKey == sortedKeys[k]){
        				  var value = cellData[generateKey].value
        				  keyInnerArray.push(value)
        			}
  				}
            }
    		keyOuterArray.push(keyInnerArray) 
        }
        //console.log(keyOuterArray)
        
        var chartDataSet = []
        for (var i = 0; i < rowArray.length; i++) {
        	var datasetObj = {}  
        	datasetObj.label = rowArray[i]
        	datasetObj.data = keyOuterArray[i]
        	datasetObj.backgroundColor = colors[i]  
        	datasetObj.borderColor = colors[i]
        	datasetObj.borderWidth = 1
        	chartDataSet.push(datasetObj)
        } 
        console.log(chartDataSet)
        
        
	    var chartdata = {
	    	    labels: labelsArray,  
	    	    datasets: chartDataSet
	    	  };

	    	  var options = {
	    	    scales: {
	    	      x: { stacked: false },
	    	      y: { stacked: false }
	    	    }
	    	  };

	    	  var ctx = document.getElementById('pivotChart').getContext('2d');
	    	  var pivotChart = new Chart(ctx, {
	    	    type: 'bar',
	    	    data: chartdata,
	    	    options: options
	    	  });
	}
  </script>   
</body>    
</html>