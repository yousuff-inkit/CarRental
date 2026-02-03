<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>
<% String contextPath=request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />
<style>
/* ===== MASTER LAYOUT ===== */
.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', Tahoma, sans-serif;
    background-color: #f4f7f9;
}

/* Sidebar */
.sidebar-filters {
    width: 330px;
    flex: 0 0 330px;
    background: #fff;
    border-right: 1px solid #e1e8ed;
    display: flex;
    flex-direction: column;
    height: 100vh;
    box-shadow: 2px 0 8px rgba(0,0,0,.05);
}

.sidebar-fixed-top {
    padding: 15px 20px;
    border-bottom: 1px solid #f0f4f8;
}

.sidebar-scroll-content {
    flex: 1;
    overflow-y: auto;
    padding: 15px 20px 25px;
}

/* Cards */
.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

/* Tables */
.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

/* Inputs */
input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
}

/* Buttons */
.btn-submit {
    width: 100%;
    padding: 11px;
    margin-top: 10px;
    background: #2563eb;
    color: #fff;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
}

.btn-submit:hover {
    background: #1d4ed8;
}

/* Page height fix */
html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

td[width="80%"] {
    height: 100vh;
    vertical-align: top;
    background: #fff;
}
</style> 

<script type="text/javascript">

$(document).ready(function () {
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	 $('#clientDetailsWindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' , theme: 'energyblue', position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	 $('#clientDetailsWindow').jqxWindow('close');
	 
	 $('#agreementDetailsWindow').jqxWindow({width: '51%', height: '58%',  maxHeight: '70%' ,maxWidth: '51%' , title: 'Agreement Search',position: { x: 250, y: 120 } , theme: 'energyblue', showCloseButton: true, keyboardCloseKey: 27});
	 $('#agreementDetailsWindow').jqxWindow('close');
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));

	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	  $('#txtclientname').dblclick(function(){
		  clientSearchContent('clientDetailsSearchGrid.jsp');
		});
	  
	  $('#vocnos').dblclick(function(){
		  var branchval = document.getElementById("cmbbranch").value; 
		  agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval); 
		});
});

	function clientSearchContent(url) {
	    $('#clientDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#clientDetailsWindow').jqxWindow('setContent', data);
		$('#clientDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function agreementSearchContent(url) {
	 	$('#agreementDetailsWindow').jqxWindow('open');
		$.get(url).done(function (data) {
		$('#agreementDetailsWindow').jqxWindow('setContent', data);
		$('#agreementDetailsWindow').jqxWindow('bringToFront');
	}); 
	}
	
	function getClient(event){
	    var x= event.keyCode;
	    if(x==114){
	    	clientSearchContent('clientDetailsSearchGrid.jsp');
	    }
	    else{}
	    }
	
	function getAgreement(event){
	    var x= event.keyCode;
	    if(x==114){
	    	var branchval = document.getElementById("cmbbranch").value; 
  		    agreementSearchContent('agreementDetailsSearch.jsp?branchval='+branchval);
	    }
	    else{}
	    }
	
/* 	function funSearchdblclick(){
		
	}
	 */
	/*  function funExportBtn(){
		   $("#rentalInvoiceGrid").jqxGrid('exportdata', 'xls', 'Invoices List');
		 } */

	function  funClearData(){
		 $('#txtclientname').val('');$('#txtcldocno').val('');$('#rentaltype').val('');$('#txtagreementno').val('');$('#vocnos').val('');$('#todate').val(new Date());$('#clstatuss').val('');
		
		 var onemounth=new Date(new Date((new Date())).setMonth(new Date().getMonth()-1)); 
		
		 $('#fromdate').val(onemounth);
           $('#todate').val(new Date());
	     
		 if (document.getElementById("txtclientname").value == "") {
		        $('#txtclientname').attr('placeholder', 'Press F3 to Search'); 
		    }
		 if (document.getElementById("vocnos").value == "") {
		        $('#vocnos').attr('placeholder', 'Press F3 to Search'); 
		    }
	 }
	
	function funreload(event){
		

		  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
			 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  } 
		   else
			   {
		
		 var branchval = document.getElementById("cmbbranch").value;
		 var fromdate = $('#fromdate').val();
		 var todate = $('#todate').val();
		 var cldocno = $('#txtcldocno').val();
		 var rentaltype = $('#rentaltype').val();
		 var agmtno = $('#txtagreementno').val();
		 var clstatuss= $('#clstatuss').val();
		   $("#overlay, #PleaseWait").show();
		 $("#notInvoicedDiv").load("detailInvoiceGrid.jsp?branchval="+branchval+'&fromdate='+fromdate+'&todate='+todate+'&cldocno='+cldocno+'&rentaltype='+rentaltype+'&agmtno='+agmtno+'&clstatuss='+clstatuss);
			   
			   }
			   }
	function chktype()
	{
		
		
		 if($('#rentaltype').val()=="")
		  {
			  $.messager.alert('Message','Select Type  ','warning');   
				 document.getElementById("rentaltype").focus(); 
			   return false;
	
		  }
		
		
	}
	
	
	function clearagno()
	{
		$('#txtagreementno').val('');
		$('#vocnos').val('');
		
	}
	
	
	


	function funExportBtn(){
		    
		//	var title=document.getElementById("lbldetailname").innerText;
	//	   JSONToCSVConvertor(invoiceexceldata, title , true);
		   $("#notInvoicedDiv").excelexportjs({  
       		containerid: "notInvoicedDiv", 
       		datatype: 'json', 
       		dataset: null, 
       		gridId: "detailInvoiceGrid", 
       		columns: getColumns("detailInvoiceGrid") , 
       		worksheetName:"Detail Invoice List"
       		}); 
		   }
		  
		  
		  function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
	
		      var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
		      
		     // alert("arrData");
		      var CSV = '';    
		      //Set Report title in first row or line
		      
		      CSV += ReportTitle + '\r\n\n';

		      //This condition will generate the Label/Header
		      if (ShowLabel) {
		          var row = "";
		          
		          //This loop will extract the label from 1st index of on array
		          for (var index in arrData[0]) {
		              
		              //Now convert each value to string and comma-seprated
		              row += index + ',';
		          }

		          row = row.slice(0, -1);
		          
		          //append Label row with line break
		          CSV += row + '\r\n';
		      }
		      
		      //1st loop is to extract each row
		      for (var i = 0; i < arrData.length; i++) {
		          var row = "";
		          
		          //2nd loop will extract each column and convert it in string comma-seprated
		          for (var index in arrData[i]) {
		              row += '"' + arrData[i][index] + '",';
		          }

		          row.slice(0, row.length - 1);
		          
		          //add a line break after each row
		          CSV += row + '\r\n';
		      }

		      if (CSV == '') {        
		          alert("Invalid data");
		          return;
		      }   
		      
		      //Generate a file name
		      var fileName = "";
		      //this will remove the blank-spaces from the title and replace it with an underscore
		      fileName += ReportTitle.replace(/ /g,"_");   
		      
		      //Initialize file format you want csv or xls
		      var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
		      
		      // Now the little tricky part.
		      // you can use either>> window.open(uri);
		      // but this will not work in some browsers
		      // or you will not get the correct file extension    
		      
		      //this trick will generate a temp <a /> tag
		      var link = document.createElement("a");    
 			  var blobdata = new Blob([CSV],{type : 'text/csv'});
		      
		      link.href = window.URL.createObjectURL(blobdata);
		      
		      //set the visibility hidden so it will not effect on your web-layout
		      link.style = "visibility:hidden";
		      link.download = fileName + ".csv";
		      
		      //this part will append the anchor tag and remove it after automatic click
		      document.body.appendChild(link);
		      link.click();
		      document.body.removeChild(link);
		  }
	
	
	
	
	
	
	

</script>

</head>
<body onload="getBranch();">

<div id="mainBG" class="homeContent">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<!-- ================= LEFT SIDEBAR ================= -->
<td width="20%">
<div class="master-container">
<div class="sidebar-filters">

    <!-- Fixed Header -->
    <div class="sidebar-fixed-top">
        <div class="filter-card">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>
    </div>

    <!-- Scrollable Filters -->
    <div class="sidebar-scroll-content">
        <div class="filter-card">

            <table class="detail-invoice-table">

                <tr>
                    <td class="label-cell">From</td>
                    <td><div id="fromdate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">To</td>
                    <td><div id="todate"></div></td>
                </tr>

                <tr>
                    <td class="label-cell">Client</td>
                    <td>
                        <input type="text"
                               id="txtclientname"
                               name="txtclientname"
                               readonly
                               placeholder="Press F3 to Search"
                               onkeydown="getClient(event);"
                               value='<s:property value="txtclientname"/>'>
                        <input type="hidden"
                               id="txtcldocno"
                               name="txtcldocno"
                               value='<s:property value="txtcldocno"/>'>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Status</td>
                    <td>
                        <select id="clstatuss" name="clstatuss">
                            <option value="">--Select--</option>
                            <option value="0">Open</option>
                            <option value="1">Close</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Type</td>
                    <td>
                        <select id="rentaltype"
                                name="rentaltype"
                                onchange="clearagno();">
                            <option value="">--Select--</option>
                            <option value="RAG">Rental</option>
                            <option value="LAG">Lease</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td class="label-cell">Agreement</td>
                    <td>
                        <input type="text"
                               id="vocnos"
                               name="vocnos"
                               readonly
                               placeholder="Press F3 to Search"
                               onfocus="chktype();"
                               ondblclick="funSearchdblclick();"
                               onkeydown="getAgreement(event);"
                               value='<s:property value="vocnos"/>'>
                        <input type="hidden"
                               id="txtagreementno"
                               name="txtagreementno"
                               value='<s:property value="txtagreementno"/>'>
                    </td>
                </tr>

            </table>

            <!-- Actions -->
            <div class="detail-invoice-actions">
                <button type="button"
                        class="btn-submit"
                        onclick="funClearData();">
                    Clear
                </button>
            </div>

        </div>
    </div>

</div>
</div>
</td>

<!-- ================= RIGHT GRID ================= -->
<td width="80%">
    <div id="notInvoicedDiv">
        <jsp:include page="detailInvoiceGrid.jsp"></jsp:include>
    </div>
</td>

</tr>
</table>

</div>
</div>

<!-- POPUPS -->
<div id="clientDetailsWindow"><div></div><div></div></div>
<div id="agreementDetailsWindow"><div></div><div></div></div>

</body>
</html>