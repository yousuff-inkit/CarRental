<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Invoice List</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">        
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../../../../vendors/bootstrap-v4/css/bootstrap.min.css">
<link rel="stylesheet" href="../../../../vendors/animate/animate.css">
<jsp:include page="../../../../reportincludes.jsp"></jsp:include>        
<link href="../../../../vendors/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="../../../../vendors/select2/css/select2.min.css" rel="stylesheet" />

  <style type="text/css">     
    .custompanel{
      border:1px solid #ccc;
      float: left;
      display: inline-block;
      margin-top: 10px; 
      margin-right: 10px;
      padding-right: 10px;
      padding-left: 10px;
      padding-top: 10px;
      padding-bottom: 10px;
      border-radius: 10px;
    }
    .badge-notify{
	   position:absolute;right:-5px;top:-8px;z-index:2;background-color:red;
	} 
	.comment{
      background-image: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: #fff;
      clear:both;
      float: right;
      display: block;
      padding-top: 8px;
      padding-bottom: 2px;
      padding-left: 10px;
      padding-right: 5px;
      border-radius: 12px;
      border-top-right-radius: 0;
      margin-bottom: 8px;
      transition:all 0.5s ease-in;
    }
    .msg-details{
      text-align: right;
    }
    .comments-container{
      height: 400px;
      overflow-y: auto;
      margin-bottom: 8px;
      padding-right: 5px;
    }
    .comments-outer-container{
      width: 100%;
      height: 100%;
    }
    .msg{
    	word-break:break-all;
    }
    .rowgap{
    	margin-bottom:6px;
    }
    .table-labels td {
    vertical-align: middle;  
}
  .todatepanel {
    display: flex;
    align-items: center; 
}  
  </style>
</head>       
<body >       
  <div class="container-fluid">
   <div class="row">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">  
		 <div class="todatepanel custompanel">
		    <form class="form-inline">
		        <div class="form-check mr-3">  
		            <input class="form-check-input" id="one" type="radio" name="radios" onchange="showGrids(1);" onclick="$(this).attr('value', this.checked ? 1 : 0)">
		            <label class="form-check-label" for="one">Summary</label>
		        </div>
		        <div class="form-check mr-3"> 
		            <input class="form-check-input" id="two" type="radio" name="radios" onchange="showGrids(2);" onclick="$(this).attr('value', this.checked ? 1 : 0)">
		            <label class="form-check-label" for="two">Detail</label>
		        </div>
		        <label class="mr-2" for="fromdate">From:</label>
		        <div id="fromdate" class="mr-3"></div>
		        <label class="mr-2" for="todate">To:</label>
		        <div id="todate"></div>
				<label class="mr-2" for="clientSearch">&nbsp;&nbsp;&nbsp;&nbsp;Client:</label>
		        <select id="cmbclient" name="cmbclient" style="width:170px;"></select> 
		    </form>
		</div>
		<div class="primarypanel custompanel">  
  			<button type="button" class="btn btn-default" id="btnsubmit"  data-toggle="tooltip" title="Submit" data-placement="bottom"><i class="fa fa-refresh" aria-hidden="true"></i></button>    
          	<button type="button" class="btn btn-default" id="btnexcel" data-toggle="tooltip" title="Excel Export" data-placement="bottom"><i class="fa fa-file-excel-o " aria-hidden="true"></i></button>
            <button type="button" class="btn btn-default" id="btnprint" data-toggle="tooltip" title="Print" data-placement="bottom"><i class="fa fa-print " aria-hidden="true"></i></button>   
        </div>
         <div class="textpanel custompanel" >
			<p  style="font-size:75%;padding-top:9px;padding-left:6px;">&nbsp;</p>
        </div>        
      </div>
    </div> 
    <div class="row">      
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">    
        <div id="sumdiv"><jsp:include page="invoiceSummaryGrid.jsp"></jsp:include></div>      
        <div id="detdiv"><jsp:include page="invoiceDetailGrid.jsp"></jsp:include></div>
      </div>
    </div>
  </div>        
  <input type="hidden" name="invoicedocno" id="invoicedocno">  
  <input type="hidden" name="txttrno" id="txttrno">  
  <input type="hidden" name="txtenqdate" id="txtenqdate">   
  <input type="hidden" name="txtdocno" id="txtdocno">
  <input type="hidden" name="hidetariff" id="hidetariff"> 
       
<script src="../../../../vendors/bootstrap-v4/js/bootstrap.min.js"></script>
<script src="../../../../vendors/sweetalert/sweetalert2.all.min.js"></script>
<script src="../../../../vendors/select2/js/select2.min.js"></script>
<script src="../../../../vendors/bootstrap-v4/js/popper.js"></script>    
<script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
       

<script type="text/javascript">   
    $(document).ready(function(){ 
    	getConfig();
    	document.getElementById("one").checked=true;
    	$("#fromdate").jqxDateTimeInput({
            width: '125px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
        $("#todate").jqxDateTimeInput({
            width: '125px',
            height: '22px',
            formatString: "dd.MM.yyyy"
        });
    	$('#sumdiv').show();
		$('#detdiv').hide();
    	$("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	    $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	   	 
	    getClient();
    	$('[data-toggle="tooltip"]').tooltip(); 
        $('#btnsubmit').click(function(){      
             var fromdate = $('#fromdate').val();
    		 var todate = $('#todate').val();
    		 var client = $('#cmbclient').val();
        	$("#overlay, #PleaseWait").show();
        	$('#sumdiv').load('invoiceSummaryGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&client='+client+'&check=1');
        	$('#detdiv').load('invoiceDetailGrid.jsp?fromdate='+fromdate+'&todate='+todate+'&client='+client+'&check=1');            

        });  
        
        $('#btnprint').click(function(){ 
        	var docno = $("#invoicedocno").val();
        	if(docno == "" || docno == null) {  
                Swal.fire({
                    icon: 'warning',
                    title: 'Warning',
                    text: 'Please select a Document!'
                });
                return false;
            }
        	funPrintInvoice();
        });
        
         $('#btnexcel').click(function(){ 
        	var sum = document.getElementById("one").checked;
        	var det = document.getElementById("two").checked;
        	if(sum){ 
        		$("#sumdiv").excelexportjs({
	 				containerid: "sumdiv",
	 				datatype: 'json',
	 				dataset: null,
	 				gridId: "jqxinvoiceGrid",
	 				columns: getColumns("jqxinvoiceGrid"),
	 				worksheetName: "Summary List"   
        	    });
        	}
        	if(det){
        		$("#detdiv").excelexportjs({
	  				containerid: "detdiv",
	  				datatype: 'json',
	  				dataset: null,
	  				gridId: "jqxinvoicedetailGrid",
	  				columns: getColumns("jqxinvoicedetailGrid"),
	  				worksheetName: "Detail List"   
	         	 });
        	}
        }); 
        
        $('.warningpanel div button').click(function(){
        	$(this).toggleClass('active');
        	if($(this).hasClass('active')){
        		addGridFilters($(this).attr('data-filtervalue'),$(this).attr('data-datafield'));
        	}
        	else{   
        		$('#UnderwriterGrid').jqxGrid('removefilter',$(this).attr('data-datafield'), true);
        	}
        });  
    });
   
    function showGrids(type){
    	if(type==1){
    		$('#sumdiv').show();
    		$('#detdiv').hide();
    	}else{
    		$('#sumdiv').hide();
    		$('#detdiv').show();
    	};
    }
    
    function getClient() {  
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText;
				
				items = items.split('####');
				var brnch = items[1].split(",");
				var brnchId = items[0].split(",");
				var optionsbrand = '<option value="">--- SELECT ---</option>';
				for (var i = 0; i < brnch.length; i++) {
					optionsbrand += '<option value="' + brnchId[i].trim() + '">'+ brnch[i].trim() + '</option>';
				}
				$("select#cmbclient").html(optionsbrand);
				$("#cmbclient").select2({
					 placeholder:"Select a Client",
					 allowClear:true
				 });   
			} else {
			}
		}
		x.open("GET", "getClient.jsp", true);   
		x.send();
	}
    
    function funPrintInvoice(){
    	var url=document.URL;
    	var reurl=url.split("/com");
    	var dtype="LIN";  
    	var docno = $("#invoicedocno").val();  
        var win= window.open(reurl[0]+"/com/limousine/limoinvoice/printLimoInvoice?docno="+docno+"&dtype="+dtype+"&bankdocno=1","_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
        win.focus();
}
    
    
    function getConfig() {  
		var x = new XMLHttpRequest();
		x.onreadystatechange = function() {
			if (x.readyState == 4 && x.status == 200) {
				items = x.responseText.trim();   
				
				if(parseInt(items)==0){
					 $('#hidetariff').val(1);
	        		 $("#jqxinvoiceGrid").jqxGrid('hidecolumn', 'vesselno');
	        		 $("#jqxinvoiceGrid").jqxGrid('hidecolumn', 'vesselname');
	        		 $("#jqxinvoicedetailGrid").jqxGrid('hidecolumn', 'vesselno');
	 		    	$("#jqxinvoicedetailGrid").jqxGrid('hidecolumn', 'vesselname');
	        		     
				 } else {
					 $('#hidetariff').val(0);
					 $("#jqxinvoiceGrid").jqxGrid('showcolumn', 'vesselno');
     		    	 $("#jqxinvoiceGrid").jqxGrid('showcolumn', 'vesselname');
     		    	$("#jqxinvoicedetailGrid").jqxGrid('showcolumn', 'vesselno');
    		    	$("#jqxinvoicedetailGrid").jqxGrid('showcolumn', 'vesselname');
				 }
			} else {
			}
		}
		x.open("GET", "getconfig.jsp", true);   
		x.send();
	}
  </script>
</body>  
</html>
