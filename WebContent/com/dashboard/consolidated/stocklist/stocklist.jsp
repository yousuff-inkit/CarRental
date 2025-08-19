<jsp:include page="../../../../includes.jsp"></jsp:include>    
 <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  

 <style type="text/css">
/* Modal background (gray out the screen) */
.modal {
    display: none;  /* Initially hidden */
    position: fixed;
    z-index: 1;  /* On top */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5);  /* Semi-transparent background */
}

/* Modal content */
.modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 60%;  /* Reduced width for the modal */
    max-width: 800px;  /* Maximum width to prevent it from being too large on wide screens */
    position: relative;  /* Needed for positioning the close button */
}

/* Close button */
.close-button {
    position: absolute;
    top: 10px;
    right: 10px;
    color: #aaa;
    font-size: 30px;
    font-weight: bold;
    cursor: pointer;
}

/* Close button hover effect */
.close-button:hover,
.close-button:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}

/* Table styles only for the table inside the modal */
.modal-table {
    width: 100%;
    border-collapse: collapse;  /* Ensure borders don't overlap */
    margin-top: 20px;  /* Add spacing between table and content */
}

.modal-table, .modal-table th, .modal-table td {
    border: 1px solid #ddd;  /* Border color for the table */
}

.modal-table th, .modal-table td {
    padding: 8px;
    text-align: left;  /* Align text to the left */
}

.modal-table th {
    background-color: #f2f2f2;  /* Light background for table headers */
    font-weight: bold;
}

.modal-table td {
    background-color: #fff;  /* White background for table rows */
}

.modal-table tbody tr:hover {
    background-color: #f5f5f5;  /* Highlight rows on hover */
}  



.myButtons {
	display: inline-block;
	margin-right:4px;
	margin-left:4px; 
  margin-bottom: 0;
  font-weight: normal;
  line-height: 1.3;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  -ms-touch-action: manipulation;
      touch-action: manipulation;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  color: #fff;
  background-color: grey;
}
.myButtons:hover {
	  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:active {
  color: #fff;
  background-color: #31b0d5;
  
}
.myButtons:focus {
  color: #fff;
  background-color: grey;
}
</style>


<script type="text/javascript">

	$(document).ready(function () {
		
		$('#stockLedgerDiv').show();
		 $('#stockLedgerDetDiv').hide();
		 
		  $('#summs').show();
			 $('#detial').hide();
		  $('#btnprint').hide(); 
		 
		 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $("#todate1").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	     $('#locationDetailsWindow').jqxWindow({width: '51%', height: '59%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Location Search',position: { x: 300, y: 87 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
		 $('#locationDetailsWindow').jqxWindow('close');
	       $('#ptypewindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Type Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#ptypewindow').jqxWindow('close');
		   $('#brandwindow').jqxWindow({ width: '49%', height: '65%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Brand Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#brandwindow').jqxWindow('close');
		   $('#modelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#modelwindow').jqxWindow('close');
		   $('#submodelwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Model Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#submodelwindow').jqxWindow('close');
		   $('#productwindow').jqxWindow({ width: '50%',height: '60%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow').jqxWindow('close');
		   $('#pcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pcategorywindow').jqxWindow('close');
		   $('#pdeptwindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Department Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#pdeptwindow').jqxWindow('close');
		   $('#psubcategorywindow').jqxWindow({ width: '50%', height: '60%',  maxHeight: '80%' ,maxWidth: '50%' , title: 'Sub Category Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#psubcategorywindow').jqxWindow('close');
		   $('#todate1').val(new Date());
	     
		   $('#productwindow1').jqxWindow({ width: '50%',height: '62%',  maxHeight: '80%'  ,maxWidth: '50%' , title: 'Product Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
		   $('#productwindow1').jqxWindow('close');   
		
		  
			
		   $('#txtlocation').dblclick(function(){
				 locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));
			 });
			   $('#name').dblclick(function(){
				 
					 productSearchContent1('productSearchdet.jsp','productwindow1');

				 });
			
	});

	function productSearchContent1(url,id) {
		$('#'+id).jqxWindow('open');
		$('#'+id).jqxWindow('focus');
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#'+id).jqxWindow('setContent', data);

		}); 
		}

	function getname(event)
	{ var x= event.keyCode;
	
	
	 if(x==114){
		 
		 productSearchContent1('productSearchdet.jsp','productwindow1');
	 
		
		}
	}

	function funExportBtn(){
		/* JSONToCSVCon(datass, 'Stock List', true); */
		$("#stockLedgerDiv").excelexportjs({    
			containerid: "stockLedgerDiv", 
			datatype: 'json', 
			dataset: null, 
			gridId: "stocklistgrid", 
			columns: getColumns("stocklistgrid") ,   
			worksheetName:"Stock list"
	     });
	}
	
	
	function funreload(event){
		var prodvalue=$('#prodsearchby').val().trim();
		var type;
		var branchid;
		var hidbrand;
		var hidtype;
		var hidproduct;
		var hidcat;
		var hidsubcat;
		
		var expupto=0;
		if(document.getElementById("expupto").checked){
			expupto=1;
		}
		var zeroqty;
		if(document.getElementById("chkzeroqty").checked){
			zeroqty=1;
		}
		else{
			zeroqty=0;
		}
		
		 	 branchid=document.getElementById("cmbbranch").value;
		 	 hidbrand=document.getElementById("hidbrandid").value;
			 hidtype=document.getElementById("hidtypeid").value;
			 hidproduct=document.getElementById("hidproductid").value;
			 hidcat=document.getElementById("hidcatid").value;
			 hidsubcat=document.getElementById("hidsubcatid").value;
			 var hidept=document.getElementById("hideptid").value;
			 var locid=$("#locid").val();
			 var compid=$("#compid").val();
			 var hidcompid = $("#hidcompid").val();
		//alert(locid);   
				 $('#stockLedgerDiv').show();	
				 $('#summs').show();
				 $("#overlay, #PleaseWait").show();   
				 var load="yes";
				 
				 
				 $("#stockLedgerDiv").load("stockGridSummary.jsp?hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&barchval="+branchid+"&hidept="+hidept+"&load="+load+"&type=1"+"&locid="+locid+"&zeroqty="+zeroqty+"&todate="+document.getElementById("todate1").value+"&expupto="+expupto+"&hidcompid="+encodeURIComponent(hidcompid));
		}
	function funPrint(){
		var branchid;
		var hidbrand;
		var hidtype;
		var hidproduct;
		var hidcat;
		var hidsubcat;
		var zeroqty;
			var expupto=0;
		if(document.getElementById("expupto").checked){
			expupto=1;
		}
		if(document.getElementById("chkzeroqty").checked){
			zeroqty=1;
		}
		else{
			zeroqty=0;
		}
		
		 	 branchid=document.getElementById("cmbbranch").value;
		 	 hidbrand=document.getElementById("hidbrandid").value;
			 hidtype=document.getElementById("hidtypeid").value;
			 hidproduct=document.getElementById("hidproductid").value;
			 hidcat=document.getElementById("hidcatid").value;
			 hidsubcat=document.getElementById("hidsubcatid").value;
			 var hidept=document.getElementById("hideptid").value;
			 var locid=$("#locid").val();
		 var url=document.URL;
		 var reurl=url.split("com");
		 var path= "com/dashboard/consolidated/stocklist/printstockdetails.action?hidbrand="+hidbrand+"&hidtype="+hidtype+"&hidcat="+hidcat+"&hidsubcat="+hidsubcat+"&hidproduct="+hidproduct+"&barchval="+branchid+"&hidept="+hidept+"&locid="+locid+"&zeroqty="+zeroqty+"&todate="+document.getElementById("todate1").value+"&expupto="+expupto;
		 var win= window.open(reurl[0]+path,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");		
		 win.focus();		
	}	
	
	function getPtype(){
		 
	 	  $('#ptypewindow').jqxWindow('open');
			$('#ptypewindow').jqxWindow('focus');
			typeSearchContent('typeSearch.jsp', $('#ptypewindow'));

	}


	function getPbrand(t){
		 
		  $('#brandwindow').jqxWindow('open');
			$('#brandwindow').jqxWindow('focus');
			brandSearchContent('brandSearch.jsp?id='+t, $('#brandwindow'));

	}


	function getPcategory(){

		  $('#pcategorywindow').jqxWindow('open');
			$('#pcategorywindow').jqxWindow('focus');
			 categorySearchContent('catSearch.jsp', $('#pcategorywindow'));
	}

	function getDept(){

		  $('#pdeptwindow').jqxWindow('open');
			$('#pdeptwindow').jqxWindow('focus');
			 deptSearchContent('deptSearch.jsp', $('#pdeptwindow'));
	}


	function getPsubcategory(){
		var catid=$('#hidcatid').val().trim();
		 $('#psubcategorywindow').jqxWindow('open');
			$('#psubcategorywindow').jqxWindow('focus');
			 subcategorySearchContent('subcatSearch.jsp?catid='+catid, $('#psubcategorywindow'));

	}


	function getProduct(){
		
		var brandid=$('#hidbrandid').val().trim();
		/* var catid=$('#hidcatid').val().trim();
		var subcatid=$('#hidsubcatid').val().trim(); */
		
 
			 productSearchContent1('productSearch.jsp?brandid='+brandid, 'productwindow');

	}


	function typeSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#ptypewindow').jqxWindow('setContent', data);

	}); 
	}
	function brandSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#brandwindow').jqxWindow('setContent', data);

	}); 
	}

	function modelSearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#modelwindow').jqxWindow('setContent', data);

	}); 
	}

	function subModelSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#submodelwindow').jqxWindow('setContent', data);

		}); 
		}

	function categorySearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#pcategorywindow').jqxWindow('setContent', data);

	}); 
	}

	function deptSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#pdeptwindow').jqxWindow('setContent', data);

		}); 
		}

	function subcategorySearchContent(url) {
	  //alert(url);
	    $.get(url).done(function (data) {
	//alert(data);
	  $('#psubcategorywindow').jqxWindow('setContent', data);

	}); 
	}

/* 	function productSearchContent(url) {
		  //alert(url);
		    $.get(url).done(function (data) {
		//alert(data);
		  $('#productwindow').jqxWindow('setContent', data);

		}); 
		}
	 */
	function setprodSearch(){
		var value=$('#prodsearchby').val().trim();

		if(value=="ptype"){
			getPtype();
		}
		else if(value=="pbrand"){
			getPbrand(2);
		}
		else if(value=="pdept"){
			getDept();
		}
		else if(value=="product"){
			getProduct();
		}
		else if(value=="pcategory"){
			getPcategory();
		}
		else if(value=="psubcategory"){
			getPsubcategory();
		}
		
		
		else{
			
		}
	}
	
	function fundisable(){
		
		//funClearData();
		
		if (document.getElementById('rsumm').checked) {
			
			  $('#stockLedgerDiv').show();
			   $('#stockLedgerDetDiv').hide();
			   
				  $('#summs').show();
				  $('#detial').hide();
				  
				 
			  
			}
		 else if (document.getElementById('rdet').checked) {
			 
			  $('#stockLedgerDiv').hide();
			  $('#stockLedgerDetDiv').show();
			  
			  
			  $('#summs').hide();
			  $('#detial').show();
			  
		 
			 
			}
		 }
	
	function funClearData(){
		document.getElementById("cmbbranch").value="a";
		 
		 document.getElementById("hidbrandid").value="";
		 document.getElementById("hidtypeid").value="";
		 document.getElementById("hidproductid").value="";
		 document.getElementById("hidcatid").value="";
		 document.getElementById("hidsubcatid").value=""; 
		 document.getElementById("hidbrand").value="";
		 document.getElementById("hidtype").value="";
		 document.getElementById("hidproduct").value="";
		 document.getElementById("hidcat").value="";
		 document.getElementById("hidsubcat").value="";
		 document.getElementById("prodsearchby").value="";
		 document.getElementById("searchdetails").value="";
		 document.getElementById("hideptid").value="";
		 document.getElementById("hidept").value="";
		 
		 document.getElementById("searchdetails1").value="";
		 document.getElementById("name").value="";
		 document.getElementById("psrno").value="";
		 document.getElementById("locid").value="";
		 document.getElementById("txtlocation").value="";   
		 
		 //$("#partSearchdiv").load("partSearchGrid.jsp");
		
	}
	function setRemove(){
		
		var suitvalue="";
		var prodvalue=$('#prodsearchby').val().trim();
		
		if(prodvalue=="ptype"){
			 document.getElementById("hidtypeid").value="";
			 document.getElementById("hidtype").value="";
		}
		else if(prodvalue=="pbrand"){
			document.getElementById("hidbrandid").value="";
			document.getElementById("hidbrand").value="";
		}
		else if(prodvalue=="product"){
			document.getElementById("hidproductid").value="";
			document.getElementById("hidproduct").value="";
		}
		else if(prodvalue=="pcategory"){
			 document.getElementById("hidcatid").value="";
			 document.getElementById("hidcat").value="";
			 
		}
		else if(prodvalue=="psubcategory"){
			document.getElementById("hidsubcatid").value="";
			document.getElementById("hidsubcat").value="";
		}
		else if(prodvalue=="pdept"){
			document.getElementById("hideptid").value="";
			document.getElementById("hidept").value="";
		}
		
		/* if(suitvalue=="sbrand"){
			 document.getElementById("hidsbrandid").value="";
			 document.getElementById("hidsbrand").value="";
			 
		}
		else if(suitvalue=="smodel"){
			document.getElementById("hidsmodelid").value="";
			document.getElementById("hidsmodel").value="";
			
		}
		else if(suitvalue=="syom"){
			document.getElementById("hidyomid").value="";
			 document.getElementById("hidyom").value="";
			 
		}
		
		else if(suitvalue=="spec1"){
			document.getElementById("hidspec1id").value="";
			document.getElementById("hidspec1").value="";
			 
		}
		else if(suitvalue=="spec2"){
			document.getElementById("hidspec2id").value="";
			document.getElementById("hidspec2").value="";
			 
		}
		else if(suitvalue=="spec3"){
			document.getElementById("hidspec3id").value="";
			document.getElementById("hidspec3").value="";
		} */
		document.getElementById("searchdetails").value="";
		
/* 		if(document.getElementById("hidsbrand").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsbrand").value;	
		}
		if(document.getElementById("hidsmodel").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsmodel").value;	
		}
		if(document.getElementById("hidyom").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidyom").value;	
		}
		if(document.getElementById("hidspec1").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec1").value;	
		}
		if(document.getElementById("hidspec2").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec2").value;	
		}
		if(document.getElementById("hidspec3").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidspec3").value;	
		} */
		if(document.getElementById("hidbrand").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidbrand").value;	
		}
		if(document.getElementById("hidtype").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidtype").value;	
		}
		if(document.getElementById("hidcat").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidcat").value;	
		}
		if(document.getElementById("hidsubcat").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidsubcat").value;	
		}
		if(document.getElementById("hidproduct").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidproduct").value;	
		}
		if(document.getElementById("hidept").value!=""){
			document.getElementById("searchdetails").value+="\n"+document.getElementById("hidept").value;	
		}
	}
	function getLocation(){
		 $('#locationDetailsWindow').jqxWindow('open');
			$('#locationDetailsWindow').jqxWindow('focus');
			locationSearchContent('locationSearch.jsp', $('#locationDetailsWindow'));
	}
	function locationSearchContent(url) {
	    $('#locationDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
			$('#locationDetailsWindow').jqxWindow('setContent', data);
			$('#locationDetailsWindow').jqxWindow('bringToFront');
		}); 
	}   
	 
	function showSalesmanDetails(psrno) {
	    $.ajax({
	        url: 'getSalesmanDetails.jsp',
	        type: 'GET',
	        data: { psrno: psrno },
	        dataType: 'json',
	        success: function(data) {
	            if (data && data.length > 0) {
	                var tableHtml = '<table class="modal-table">' +      
	                                '<thead>' +      
	                                '<tr>' +
	                                '<th>Sl. No</th>' +
	                                '<th>Client</th>' +   
	                                '<th>Salesman</th>' +
	                                '<th>Res. Qty</th>' +
	                                '</tr>' +
	                                '</thead>' +
	                                '<tbody>';

	                data.forEach(function(item) {
	                    tableHtml += '<tr>' +
	                                 '<td>' + item.slno + '</td>' +
	                                 '<td>' + item.refname + '</td>' +   
	                                 '<td>' + item.salesman + '</td>' +
	                                 '<td>' + item.resQty + '</td>' +
	                                 '</tr>';
	                });

	                tableHtml += '</tbody></table>';

	                $('#rowDetails').html(tableHtml);

	                $('#detailsModal').fadeIn();
	            } else {
	                $('#rowDetails').html('<p>No data available.</p>');
	                $('#detailsModal').fadeIn();
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error('Error fetching data:', error);
	            $('#rowDetails').html('<p>Error fetching data.</p>');
	            $('#detailsModal').fadeIn();
	        }
	    });
	}


	function closeModal() {
	    $('#detailsModal').fadeOut();
	}

	

</script>
</head>
<body onload="getBranch();">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<table width="100%" >
<tr>
<td width="20%" >
    <fieldset style="background: #ECF8E0;">
	<table width="100%"  >
	<jsp:include page="../../heading.jsp"></jsp:include>
					<tr>
	<td align="center" colspan="2"><label class="branch"> Expiry UP To</label> <input type="checkbox" id="expupto" name="expupto"></td>
	</tr>  
		
			<tr>
	<td align="right"><label class="branch">UP To</label></td>
    <td align="left"><div id="todate1" name="todate1" value='<s:property value="todate1"/>'></div></td>
	</tr>  
		
		
	 <tr><td colspan="2" align="center">
	 <input type="radio" id="rsumm" name="stkled" onchange="fundisable();" hidden="true" value="rsumm">&nbsp;&nbsp;
	 <input type="checkbox" id="chkzeroqty" name="chkzeroqty"><label for="chkzerqty" class="branch">With Zero Quantity</label>
	 </td></tr>
	 <tr>
	 <tr><td align="right"><label class="branch">Location</label></td>
	<td align="left"><input type="text" id="txtlocation" name="txtlocation" style="width:90%;height:20px;" readonly="readonly" placeholder="Press F3 to Search" value='<s:property value="txtlocation"/>' onKeyDown="getLocation(event);"/>
	<input type="hidden" id="locid" name="locid" value='<s:property value="locid"/>' />
	</td></tr> 
	  
	
	  <tr >
	  <td colspan="2">
	  	  
	  <div id="detial" >   
	  <table width="100%">
	    <tr>  <td align="right"><label class="branch">Product</label></td> <td  align="left"  ><input type="text" id="name" style="width: 100%;height:20PX;"  style="width: 40%;"  placeholder="Press F3 for Search" readonly="readonly" onKeyDown="getname(event);" name="name"  value='<s:property value="name"/>'> </td></tr>
       <tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails1" name="searchdetails1" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr>
	  </table>
	  </div>
	  
	  <div id="summs">
	  <table width="100%">
	  <tr>
	  <td align="right"><label class="branch">Product</label></td>
	  <td  align="left"><select name="prodsearchby" id="prodsearchby" style="width:52%;">
<option value="">--Select--</option>
    <option value="ptype">TYPE</option>
    <option value="pbrand">BRAND</option>
    <option value="pdept">DEPARTMENT</option>
    <option value="pcategory">CATEGORY</option>
    <option value="psubcategory">SUB CATEGORY</option>
    <option value="product">PRODUCT</option>
    </select>&nbsp;&nbsp;<button type="button" name="btnadditem" id="additem" class="myButtons" onClick="setprodSearch();">+</button>&nbsp;&nbsp;<button  type="button" name="btnremoveitem" id="btnremoveitem" class="myButtons" onclick="setRemove();">-</button></td>
	  
	</tr> 
	<tr >
	  <td colspan="2"
      align="right" ><textarea id="searchdetails" name="searchdetails" style="resize:none;font: 10px Tahoma;width:100%;" rows="18"  readonly></textarea></td>
	  </tr>
	  <tr >
	  
	   </tr></table>
	 </div>
	  </td>
	  </tr>
	  <tr>
	  
	<td colspan="2" style="border-top:2px solid #DCDDDE;"><center><input type="button" name="btnclear" id="btnclear" value="Clear" class="myButtons" onclick="funClearData();"></center>
    </td>
	<tr><td colspan="2" align="center"><button type="button" class="myButtons" id="btnprint" onclick="funPrint();">Print</button></td></tr>
	</tr>
	<!--<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr> 
	<tr><td colspan="2">&nbsp;</td></tr>	
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr>
	<tr><td colspan="2">&nbsp;</td></tr> -->
			<tr><td>
			  <input type="hidden" name="hidbrandid" id="hidbrandid">
			  <input type="hidden" name="hidtypeid" id="hidtypeid">
			  <input type="hidden" name="hideptid" id="hideptid">
			  <input type="hidden" name="hidcatid" id="hidcatid">
			  <input type="hidden" name="hidsubcatid" id="hidsubcatid">
			  <input type="hidden" name="hidproductid" id="hidproductid">
			  
			  <input type="hidden" name="hidbrand" id="hidbrand">
			  <input type="hidden" name="hidept" id="hidept">
			  <input type="hidden" name="hidtype" id="hidtype">
			  <input type="hidden" name="hidcat" id="hidcat">
			  <input type="hidden" name="hidsubcat" id="hidsubcat">
			  <input type="hidden" name="hidproduct" id="hidproduct">
			  <input type="hidden" name="hidcompid" id="hidcompid">
			   <input type="hidden" name="psrno" id="psrno"></td></tr>
	</table>
	</fieldset>
</td>
<td width="80%">
	<table width="100%">
		<tr>
			 <td><div id="stockLedgerDiv"><jsp:include page="stockGridSummary.jsp"></jsp:include></div></td>
		</tr>
		<tr><td><div id="stockLedgerDetDiv">
				 <jsp:include page="stockGridSummary.jsp"></jsp:include> 
		</div></td></tr> 
	</table></td>
</tr>
</table>  
<div id="detailsModal" class="modal">
    <div class="modal-content">
        <span class="close-button" onclick="closeModal()">&times;</span>
        <h2>Salesman Details</h2>  <!-- Add header for context -->
        <div id="rowDetails"></div>
    </div>
</div>

<div id="ptypewindow">
<div></div>
</div>
<div id="brandwindow">
<div></div>
</div>
<div id="modelwindow">
<div></div>
</div>
<div id="submodelwindow">
<div></div>
</div>
<div id="productwindow">
<div></div>
</div>
<div id="pcategorywindow">
<div></div>
</div>
<div id="pdeptwindow">
<div></div>
</div>
<div id="psubcategorywindow">
<div></div>
</div>
<div id="productwindow1">
<div></div>
</div>
<div id="locationDetailsWindow">
	<div></div><div></div>
</div>
</div>
</div>
</body>
</html>