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
<jsp:include page="../../../reportincludes.jsp"></jsp:include>
<link rel="stylesheet" href="../../../../vendors/bootstrap-v3/css/bootstrap.min.css">   
<link href="../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../vendors/select2/css/select2.min.css" rel="stylesheet" />
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
                     <td align="right" ><label class="branch" style="font-size: 13px">&nbsp;From&nbsp;&nbsp;</label></td>
                     <td align="left"><div id='fromdate' ></div></td>
                     <td align="right" ><label class="branch" style="font-size: 13px">&nbsp;To&nbsp;&nbsp;</label></td>
                     <td align="left"> <div id='todate' ></div></td>
                  </tr>
               </table>
            </div>
 <div class="primarypanel custompanel" style="margin-left:6px;">
               <button type="button" class="btn btn-default btnStyle" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh iconStyle" aria-hidden="true"></i></button>    
               <button type="button" class="btn btn-default btnStyle" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>    
               </div>  
         </div>
      </div>
      <div class="row" style="padding-top: 5px;">
         <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <div id="dynloadDiv" style="height:455px; width: 1250px;">
               <jsp:include page="dynamicloadingGrid.jsp"></jsp:include>
            </div>
         </div>
         <br>
         </div>
     </div></div>    
         <input type="hidden" name="formname" id="formname">	  
 <script src="../../../vendors/bootstrap-v3/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="../../../vendors/select2/js/select2.min.js"></script>
<script type="text/javascript" src="../../../js/sweetalert2.all.min.js"></script>  
<!-- <script type="text/javascript" src="../../../../js/tableExport.min.js"></script>  
<script type="text/javascript" src="../../../../js/Chart.min.js"></script>   -->
<script type="text/javascript"> 
    var title = "";
    $(document).ready(function() {
        title = '<%=formname%>';
        $("#formname").val(title);
        
        
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
        
    }); 
    
    function funload() {
        var fromdate = $('#fromdate').val();
        var todate = $('#todate').val();
        $("#overlay, #PleaseWait").show();
        $('#jqxPivot').jqxPivotGrid('refresh');
        $("#leadDiv").load("dynamicloadingGrid.jsp?fromdate=" + fromdate + "&todate=" + todate + "&formname=" + encodeURIComponent($("#formname").val()) + "&id=1");
    }
         </script>   
</body>    
</html>