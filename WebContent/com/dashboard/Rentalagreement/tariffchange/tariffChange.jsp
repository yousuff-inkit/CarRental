
<jsp:include page="../../../../includeso.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxDaterentalout").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#fleetwindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Fleet Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#fleetwindow').jqxWindow('close');
	   $('#groupwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Group Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#groupwindow').jqxWindow('close');
	   $('#brandwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Brand Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#brandwindow').jqxWindow('close');
	   $('#modelwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Model Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#modelwindow').jqxWindow('close');
	   $('#usersearchwindow').jqxWindow({ width: '55%', height: '56%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'User Search' ,position: { x: 160, y: 150 }, keyboardCloseKey: 27});
	   $('#usersearchwindow').jqxWindow('close');
	   getConfigs();
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	   
	    $('#fleet').dblclick(function(){
	  	    $('#fleetwindow').jqxWindow('open');
	   
	       fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow')); 
       });
	    $('#group').dblclick(function(){
	  	    $('#groupwindow').jqxWindow('open');
	   
	       groupSearchContent('groupsearch.jsp?', $('#groupwindow')); 
       });
	    $('#brand').dblclick(function(){
	  	    $('#brandwindow').jqxWindow('open');
	   
	       brandSearchContent('brandsearch.jsp?', $('#brandwindow')); 
      });
	   $('#model').dblclick(function(){
	  	    $('#modelwindow').jqxWindow('open');
	   
	  	  modelSearchContent('modelsearch.jsp?', $('#modelwindow')); 
       }); 
	   
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
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
});

function getConfigs(){
	$.get('getConfigs.jsp',function(data){
		data=JSON.parse(data);
		var htmldata='';
			if(data.InvQuarterly=="1"){
				htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
				$('#cmbinvoicing_method').append($.parseHTML(htmldata));
				/* $('#invoice').append($('<option></option>').val("4").text("Quarterly"));
				$('#invoice').append($('<option></option>').val("5").text("Half Yearly"));
				$('#invoice').append($('<option></option>').val("6").text("Yearly"));*/
				if($('#cmbinvoicing_method').val()!="")
				{
					$('#cmbinvoicing_method').val($('#hidcmbinvoicing_method').val());
				} 
			}
	});
}

function getmodel(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#modelwindow').jqxWindow('open');
	modelSearchContent('modelsearch.jsp?', $('#modelwindow'));    }
	 else{
		 }
	 } 
function modelSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#modelwindow').jqxWindow('open');
		$('#modelwindow').jqxWindow('setContent', data);

	}); 
	} 
function getbrand(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#brandwindow').jqxWindow('open');
	brandSearchContent('brandsearch.jsp?', $('#brandwindow'));    }
	 else{
		 }
	 } 
function brandSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#brandwindow').jqxWindow('open');
		$('#brandwindow').jqxWindow('setContent', data);

	}); 
	} 
function getgroup(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#groupwindow').jqxWindow('open');


	groupSearchContent('groupsearch.jsp?', $('#groupwindow'));    }
	 else{
		 }
	 } 
function groupSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#groupwindow').jqxWindow('open');
		$('#groupwindow').jqxWindow('setContent', data);

	}); 
	} 
function getfleet(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#fleetwindow').jqxWindow('open');


	 fleetSearchContent('fleetsearch.jsp?', $('#fleetwindow'));    }
	 else{
		 }
	 } 
function fleetSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#fleetwindow').jqxWindow('open');
		$('#fleetwindow').jqxWindow('setContent', data);

	}); 
	} 
function getclinfo(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#clientwindow').jqxWindow('open');


	 clientSearchContent('clientsearch.jsp?', $('#clientwindow'));    }
	 else{
		 }
	 } 
function clientSearchContent(url) {
 	 //alert(url);
 		 $.get(url).done(function (data) {
 			 
 			 $('#clientwindow').jqxWindow('open');
 		$('#clientwindow').jqxWindow('setContent', data);
 
 	}); 
 	} 
function funreload(event)
{
	

	  var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
	  // out date
	 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
	 	 
	   if(fromdates>todates){
		   
		   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
		 
	   return false;
	  } 
	   else
		   {
	 var barchval = document.getElementById("cmbbranch").value;
     var fromdate= $("#fromdate").val();
	 var todate= $("#todate").val(); 
	   $("#overlay, #PleaseWait").show();
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&group="+document.getElementById("groupdoc").value+"&model="+document.getElementById("modelid").value+"&brand="+document.getElementById("brandid").value+"&fleet="+document.getElementById("fleet").value+"&status="+document.getElementById("status").value+"&type="+$("#rentaltype").val());
	
		   }
	 	 
	   disiem(); 
	       $("#rtaiff").jqxGrid('clear');

	      
	   }
	
function getuserchange(){
	   $('#usersearchwindow').jqxWindow('open');
       $('#usersearchwindow').jqxWindow('focus');     
   

  searchuserContent('searchotheruser.jsp?vehgpid='+2+"&tarifdoc="+1);  
	 
	 }



function searchuserContent(url) {
       //alert(url);
        $.get(url).done(function (data) {
          //alert(data);
      $('#usersearchwindow').jqxWindow('setContent', data);

	}); 
	}


function  funcleardata()
{
	
	document.getElementById("cldocno").value="";
	document.getElementById("groupdoc").value="";
	document.getElementById("groupdoc").value="";
	document.getElementById("brandid").value="";
	document.getElementById("modelid").value="";
	
	document.getElementById("model").value="";
	document.getElementById("brand").value="";
	document.getElementById("group").value="";
	document.getElementById("fleet").value="";
	document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="Daily";
	document.getElementById("status").value="0";
	
	
	
	$('#jqxDateOut').val(new Date());
	$('#jqxDaterentalout').val(new Date());
	
	

	document.getElementById("docnos").value="";
	document.getElementById("excessinsur").value="";
	document.getElementById("normalinsu").value="";
	document.getElementById("cdwinsu").value="";
	document.getElementById("supercdwinsu").value="";
	
	document.getElementById("gridlength").value="";
	document.getElementById("branchid").value="";
	
	
	
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("model").value == "") {
			
		 
	        $('#model').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("brand").value == "") {
			
		 
	        $('#brand').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("group").value == "") {
			
		 
	        $('#group').attr('placeholder', 'Press F3 TO Search'); 
	    }
	 if (document.getElementById("fleet").value == "") {
			
		 
	        $('#fleet').attr('placeholder', 'Press F3 TO Search'); 
	    }
		
	}
	
function funExportBtn(){
	  // $("#detailsgrid").jqxGrid('exportdata', 'xls', 'LAG-Short Term LA Extension');
	   
	  $("#detlist").excelexportjs({
			containerid: "detlist", 
			datatype: 'json', 
			dataset: null, 
			gridId: "detailsgrid", 
			columns: getColumns("detailsgrid") ,   
			worksheetName:"RA Tarif Change"
			});

}
	
	

function funupdatera()
{
	var row = $('#rtaiff').jqxGrid('getrows');  
	    for(var i=0 ; i < row.length ; i++){
	    	var nettotalrow = $('#rtaiff').jqxGrid('getcellvalue', row, "nettotalrow");
	    		 if(nettotalrow<0){
		    $.messager.alert('Message', 'please check correct value');	
			return false;
			}
	    }
    $.messager.confirm('Message', 'Do you want to Update?', function(r){
     	  
	        
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		 
     	   	 if(document.getElementById("configmethod").value>0)// in client search set this value 
		           
      	   {
      	    
			            		  if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value)
			            			  {
			            			  $.messager.alert('Message', ' Please check the client invoice rule ');	
			            			  
			            			return 0;
			            			  }
          		  
          	  
		            		  if(document.getElementById("invval").value!=document.getElementById("cmbinvoicing_method").value)
	            			  {
	            			  
		            			  $.messager.alert('Message', ' Please check the client invoice rule ');	
		            			  return 0;
	            			  }
          		  
          		 
      	 
      	   }
     		 
     	   	 
     	   	 var dataCount = $('#rtaiff').jqxGrid('getrows');  
     	   var len=dataCount.length; 
			 if(len>6)
			 {
				    $.messager.alert('Message', 'please check row count ');	
					//alert("Tariff Is Not Selected");  
			    	return 0;
					}
     		
     		
     	      var rows = $("#rtaiff").jqxGrid('getrows');
     	    for(var i=0 ; i < rows.length ; i++){
     		 if(i==3 || i==5)
			 {
     	
			 var rateval=rows[i].rate;
			
			if(rateval==""||typeof(rateval)=="undefined"||typeof(rateval)=="NaN"||rateval=="0.00")
				{
			    $.messager.alert('Message', ' Tariff Is Not Selected ');	
				//alert("Tariff Is Not Selected");  
		    	return 0;
				}
			 } 
	    }
     	
  		
     //var rows = $("#trafficGrid").jqxGrid('getrows');
     $('#gridlength').val(rows.length); 
     var listss = new Array();
	 	var a = 1;
	 	var nrentaltype="";
	   for(var i=0 ; i < rows.length ; i++){
		   
		   nrentaltype=rows[3].rentaltype;
		   listss.push(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].kmrest+"::"+
				   rows[i].exkmrte+"::"+rows[i].oinschg+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+a+"::");  
	   }
	 
	   save(listss,nrentaltype);

     	}
    });
}

function save(listss,nrentaltype){
	
	
	 var docnos= document.getElementById("docnos").value;       
	   var excessinsur=document.getElementById("excessinsur").value; 
	     
	     var jqxDateOut=document.getElementById("jqxDaterentalout").value; 
	     
	     
	     var branchid=document.getElementById("branchid").value; 
	     
	     var invoicevalue=document.getElementById("cmbinvoicing_method").value;
	     
	     
	     var advance=document.getElementById("advance_chk").value;
	     
	     var orentaltype=document.getElementById("orentaltype").value;
	     var oinvdate=document.getElementById("oinvdate").value;
	     var oadvchk=document.getElementById("oadvchk").value;
	     var oinvtype=document.getElementById("oinvtype").value;
	     var rvocno=document.getElementById("rvocno").value;
	     var rcldocno=document.getElementById("rcldocno").value;
	
	
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
			 var items= x.responseText;
			 	var itemval=items.trim();
			 	
			 	//alert(items);
			 	
  if(parseInt(itemval)==1)
  	{
	   $.messager.alert('Message', ' Tariff Change Effective from '+oinvdate+'' );
			 	$('#gridlength').val(""); 
		    	
		    	$('#jqxDateOut').val(new Date());
		    	$('#jqxDaterentalout').val(new Date());
		       	document.getElementById("docnos").value="";
		    	document.getElementById("excessinsur").value="";
		    	document.getElementById("normalinsu").value="";
		    	document.getElementById("cdwinsu").value="";
		    	document.getElementById("supercdwinsu").value="";
		    	 document.getElementById("gridlength").value="";
		    	document.getElementById("branchid").value="";
		    	document.getElementById("rvocno").value="";
		    	document.getElementById("rcldocno").value="";
		    	document.getElementById("orentaltype").value="";
			    document.getElementById("oinvdate").value="";
			    document.getElementById("oadvchk").value="";
			    document.getElementById("oinvtype").value="";
		    	
		    	document.getElementById("advchkval").value="";
		    	 document.getElementById("invval").value="";
		    	document.getElementById("configmethod").value="";
		    	
		       	document.getElementById("advance_chk").value="";
		    	 document.getElementById("cmbinvoicing_method").value="1";

		    	
				   document.getElementById("advance_chk").checked = false;
		   //	 advchkval invval configmethod   advance_chk cmbinvoicing_method
			 
		    	
		    	
		    	 funreload(event);
			 
			 	
			}
		else
			{
			$.messager.alert('Message', '  Not Updated ', function(r){
			     
		     });
			}  
	}
	}
	 
x.open("GET","savedata.jsp?list="+listss+"&docno="+docnos+"&excessinsur="+excessinsur+"&jqxDateOut="+jqxDateOut+"&branchid="+branchid+"&invoicevalue="+invoicevalue+"&advance="+advance+"&orentaltype="+orentaltype+"&oinvdate="+oinvdate+"&oadvchk="+oadvchk+"&oinvtype="+oinvtype+"&nrentaltype="+nrentaltype+"&rvocno="+rvocno+"&rcldocno="+rcldocno);
	x.send();
}


function disiem()
{
	/* var aa="NA"; */
	
	
	/*   $("#tariff").load("tariff.jsp?branch="+0+"&tdocno="+0+"&revehGroup="+0);
	  
	  $("#rtariff").load("rtariffdetails.jsp?rdocno="+aa);  */
	  
	
	 $('#searchuser').attr("disabled",true);
		
	 $('#update').attr("disabled",true);
	 
		
	 $('#advance_chk').attr("disabled",true);
		
	 $('#cmbinvoicing_method').attr("disabled",true);
	 

	
	}
</script>
<style type="text/css">
    /* Layout & Sidebar Structure */
    .master-container {
        display: flex;
        font-family: 'Segoe UI', Tahoma, sans-serif !important;
        background-color: #f4f7f9;
        width: 100%;
        height: 100vh !important;
        overflow: hidden !important;
        color: black !important;
    }

    .sidebar-filters {
        width: 350px; 
        flex: 0 0 350px;
        background-color: #ffffff;
        border-right: 1px solid #e1e8ed;
        display: flex;
        flex-direction: column;
        z-index: 10;
        box-shadow: 2px 0 8px rgba(0,0,0,0.05);
        height: 100vh !important;
    }

    .sidebar-fixed-top {
        padding: 20px 20px 15px 20px;
        background-color: #ffffff;
        border-bottom: 1px solid #f0f4f8;
        flex-shrink: 0;
    }

    .sidebar-scroll-content {
        flex: 1;
        overflow-y: auto;
        padding: 15px 20px 25px 20px;
    }

    /* Cleaned Cards */
    .filter-card {
        background-color: #f8fafc !important;
        border: 1px solid #e3e8ee !important;
        border-radius: 12px !important;
        padding: 15px;
        margin-bottom: 12px;
    }

    /* Reset legacy styles and force black text */
    .filter-card *, fieldset, legend, .branch, td, tr, label, span, textarea {
        background-color: transparent !important;
        background: none !important;
        color: black !important;
    }

    .filter-table { 
        width: 100%; 
        border-spacing: 0 8px; 
    }

    .label-cell {
        text-align: right;
        padding-right: 10px;
        font-size: 13px;
        font-weight: 600;
        width: 90px;
    }

    /* Input & Select Styling */
    input[type="text"], select {
        width: 100%;
        border: 1px solid #ccd6e0;
        border-radius: 6px;
        padding: 6px 10px;
        font-size: 13px;
        color: black !important;
        box-sizing: border-box;
        background-color: #ffffff !important;
    }

    /* RHS Visibility */
    .main-content-wrapper {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100vh;
        width: 100%;
        max-width: calc(100vw - 350px);
        overflow: hidden !important; 
        position: relative;
        background-color: #ffffff;
    }

    .scrollable-grid-area {
        flex: 1;
        overflow-y: auto !important;
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* FINALIZED BUTTONS (#2563eb) */
    .myButtons, .myButton {
        background-color: #2563eb !important;
        color: #ffffff !important; 
        border: none !important;
        border-radius: 6px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        padding: 10px 15px;
        text-align: center;
        display: block;
        width: 100%;
        margin-top: 5px;
        transition: background 0.2s;
        text-decoration: none;
        text-shadow: none;
    }

    .myButtons:hover, .myButton:hover { 
        background-color: #1d4ed8 !important; 
    }

    .branch { font-size: 13px; font-weight: 600; }
</style>
</head>
<body onload="getBranch();disiem()">
<div id="mainBG" class="homeContent" data-type="background"> 
<div class='hidden-scrollbar'>
<div class="master-container">
    <div class="sidebar-filters">
        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

        <div class="sidebar-scroll-content">
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id='fromdate' name='fromdate' value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id='todate' name='todate' value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Status</td>
                        <td>
                            <select id="status" name="status" value='<s:property value="status"/>'>
                                <option value=0>Open</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td><input type="text" name="clientname" id="clientname" placeholder="Press F3 TO Search" readonly="readonly" onKeyDown="getclinfo(event);" onclick="this.placeholder='' " value='<s:property value="clientname"/>'></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fleet</td>
                        <td><input type="text" name="fleet" id="fleet" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getfleet(event)" onclick="this.placeholder='' " value='<s:property value="fleet"/>' ></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Group</td>
                        <td><input type="text" name="group" id="group" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getgroup(event)" onclick="this.placeholder='' " value='<s:property value="group"/>' ></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Brand</td>
                        <td><input type="text" name="brand" id="brand" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getbrand(event)" onclick="this.placeholder='' " value='<s:property value="brand"/>' ></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Model</td>
                        <td><input type="text" name="model" id="model" placeholder="Press F3 TO Search" readonly="readonly" onkeydown="getmodel(event)" onclick="this.placeholder='' " value='<s:property value="model"/>' ></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype" value='<s:property value="rentaltype"/>'>
                                <option value="Daily">Daily</option>
                                <option value="Weekly">Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select> 
                        </td>
                    </tr>
                </table>
                <input type="button" class="myButtons" name="clear" id="clear" value="Clear" onclick="funcleardata()">
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Advance</td>
                        <td><input type="checkbox" id="advance_chk" name="advance_chk" value="0" onclick="$(this).attr('value', this.checked ? 1 : 0)" ></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Invoice</td>
                        <td>
                            <select name="cmbinvoicing_method" id="cmbinvoicing_method" value='<s:property value="cmbinvoicing_method"/>'>
                                <option value="">--Select--</option>
                                <option value="1">Month End</option>
                                <option value="2">Period</option>
                            </select>
                        </td>
                    </tr>
                </table>
                <input type="button" class="myButton" name="update" id="update" value="Update" onclick="funupdatera()">
            </div>

            <div id='paychaaaaa' style="width: 100%; height: 40px; margin-top: 10px;"></div>

            <div hidden="true">
                <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                <div id='jqxDaterentalout' name='jqxDaterentalout' value='<s:property value="jqxDaterentalout"/>'></div> 
                <input type="hidden" name="hidcmbinvoicing_method" id="hidcmbinvoicing_method" value='<s:property value="hidcmbinvoicing_method"/>'/>
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" name="groupdoc" id="groupdoc" value='<s:property value="groupdoc"/>'>
                <input type="hidden" name="brandid" id="brandid" value='<s:property value="brandid"/>'>
                <input type="hidden" name="modelid" id="modelid" value='<s:property value="modelid"/>'> 
                <input type="hidden" name="docnos" id="docnos" value='<s:property value="docnos"/>'>
                <input type="hidden" id="excessinsur" name="excessinsur" value='<s:property value="excessinsur"/>' >
                <input type="hidden" name="normalinsu" id="normalinsu" value='<s:property value="normalinsu"/>' />
                <input type="hidden" name="cdwinsu" id="cdwinsu" value='<s:property value="cdwinsu"/>' /> 
                <input type="hidden" name="supercdwinsu" id="supercdwinsu" value='<s:property value="supercdwinsu"/>' />
                <input type="hidden" id="gridlength" name="gridlength">
                <input type="hidden" name="advchkval" id="advchkval" value='<s:property value="advchkval"/>' />  
                <input type="hidden" name="invval" id="invval" value='<s:property value="invval"/>' />
                <input type="hidden" id="configmethod" name="configmethod" value='<s:property value="configmethod"/>' />
                <input type="hidden" id="branchid" name="branchid" value='<s:property value="branchid"/>' >
                <input type="hidden" id="orentaltype" name="orentaltype" value='<s:property value="orentaltype"/>' >
                <input type="hidden" id="oinvdate" name="oinvdate" value='<s:property value="oinvdate"/>' >
                <input type="hidden" id="oadvchk" name="oadvchk" value='<s:property value="oadvchk"/>' >
                <input type="hidden" id="oinvtype" name="oinvtype" value='<s:property value="oinvtype"/>' >
                <input type="hidden" id="rvocno" name="rvocno" value='<s:property value="rvocno"/>' >
                <input type="hidden" id="rcldocno" name="rcldocno" value='<s:property value="rcldocno"/>' >
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="detlist">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
            <div id="rtariff">
                <jsp:include page="rtariffdetails.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="clientwindow">
   <div ></div>
</div>
<div id="fleetwindow">
   <div ></div>
</div>
<div id="groupwindow">
   <div ></div>
</div>
<div id="brandwindow">
   <div ></div>
</div>
<div id="modelwindow">
   <div ></div>
</div>
<div id="usersearchwindow">
   <div ></div>
</div>
</div>
</body>
</html>
	 