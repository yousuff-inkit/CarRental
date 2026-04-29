<jsp:include page="../../../../includes.jsp"></jsp:include>    
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
<style>

.master-container {
    display: flex;
    width: 100%;
    height: 100%;
    font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
    background-color: #f4f7f9;
}

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

.filter-card {
    background: #f8fafc;
    border: 1px solid #e3e8ee;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 12px;
}

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

input[type="text"], select {
    width: 100%;
    padding: 7px 10px;
    border: 1px solid #ccd6e0;
    border-radius: 6px;
    font-size: 13px;
    height: 24px !important;  
}

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
     height: 30px !important;  
}

.btn-submit:hover {
    background: #1d4ed8;
}

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

  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<script type="text/javascript">

$(document).ready(function () {
	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
	 $("#jqxDaterentalout").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});
		
	   $('#clientwindow').jqxWindow({ width: '20%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'Client Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#clientwindow').jqxWindow('close');
	   $('#ranowindow').jqxWindow({ width: '30%', height: '60%',  maxHeight: '62%' ,maxWidth: '60%' , title: 'RA No. Search' ,position: { x: 250, y: 120 }, keyboardCloseKey: 27});
	   $('#ranowindow').jqxWindow('close');
	   getConfigs();
	   $('#clientname').dblclick(function(){
	  	    $('#clientwindow').jqxWindow('open');
	   
	       clientSearchContent('clientsearch.jsp?', $('#clientwindow')); 
      });
	   $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");


	   
	    $('#rano').dblclick(function(){
	  	    $('#ranowindow').jqxWindow('open');
	   
	       ranoSearchContent('ranosearch.jsp?', $('#ranowindow')); 
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

 function getrano(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#ranowindow').jqxWindow('open');


	 ranoSearchContent('ranosearch.jsp?', $('#ranowindow'));    }
	 else{
		 }
	 } 
function ranoSearchContent(url) {
	 //alert(url);
		 $.get(url).done(function (data) {
			 
			 $('#ranowindow').jqxWindow('open');
		$('#ranowindow').jqxWindow('setContent', data);

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
 	
function getConfigs(){
	$.get('getConfigs.jsp',function(data){
		data=JSON.parse(data);
		var htmldata='';
			if(data.InvQuarterly=="1"){
				htmldata+='<option value="4">Quarterly</option><option value="5">Half Yearly</option><option value="6">Yearly</option>';
				$('#invoice').append($.parseHTML(htmldata));
				/* $('#invoice').append($('<option></option>').val("4").text("Quarterly"));
				$('#invoice').append($('<option></option>').val("5").text("Half Yearly"));
				$('#invoice').append($('<option></option>').val("6").text("Yearly"));*/
				if($('#invoice').val()!="")
				{
					$('#invoice').val($('#hidinvoice').val());
				} 
			}
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
	  $("#detlist").load("detailsGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate+"&cldocno="+document.getElementById("cldocno").value+"&rano="+document.getElementById("hidrano").value+"&type="+$("#rentaltype").val());
	
		   }
	 	 
	   disiem(); 
	       $("#rtaiffchange").jqxGrid('clear');

	      
	   }
	


function  funcleardata()
{
	
	document.getElementById("cldocno").value="";
	
	document.getElementById("rano").value="";
	document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="";
	//document.getElementById("status").value="0";
	$('#jqxDateOut').val(new Date());
	$('#jqxDaterentalout').val(new Date());
	
		document.getElementById("docnos").value="";
	document.getElementById("branchid").value="";
	document.getElementById("hidrano").value="";
	
	
	
	
	 if (document.getElementById("clientname").value == "") {
			
		 
	        $('#clientname').attr('placeholder', 'Press F3 TO Search'); 
	    }
	
	 if (document.getElementById("rano").value == "") {
			
		 
	        $('#rano').attr('placeholder', 'Press F3 TO Search'); 
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
			worksheetName:"RA Tarif Change Approval"
			});

}
	
function funApprove()
{
 var invdat=document.getElementById("invdate").value;
  $.messager.confirm('Message', 'Tariff Change Effective from '+invdat+'', function(r){
	        
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		 
     	   	 if(document.getElementById("configmethod").value>0)// in client search set this value 
		           
      	   {
      	    
			            		  if(document.getElementById("advchkval").value!=document.getElementById("advance_chk").value)
			            			  {
			            			  $.messager.alert('Message', ' Please check the client advance rule ');	
			            			  
			            			return 0;
			            			  }
          		  
          	  
		            		  if(document.getElementById("invval").value!=document.getElementById("invoice").value)
	            			  {
	            			  
		            			  $.messager.alert('Message', ' Please check the client invoice rule ');	
		            			  return 0;
	            			  }
       	 
      	   }
     	    var rows = $("#rtaiffchange").jqxGrid('getrows'); 
     	    var listss = new Array();
    	 	var a = 1;
    	   for(var i=0 ; i < rows.length ; i++){
    		if(i>2)
    			{
    		   listss.push(rows[i].rentaltype+"::"+rows[i].rate+"::"+rows[i].cdw+"::"+rows[i].pai+"::"+rows[i].cdw1+"::"+rows[i].pai1+"::"+rows[i].gps+"::"+rows[i].babyseater+"::"+rows[i].cooler+"::"+rows[i].kmrest+"::"+
    				   rows[i].exkmrte+"::"+rows[i].oinschg+"::"+rows[i].exhrchg+"::"+rows[i].chaufchg+"::"+rows[i].chaufexchg+"::"+a+"::");  
    	   }
     	   	 
    	   }
    	 
     	   	save(listss); 
    
     	}
    });
}

function save(listss)
{
	
	    var invoicevalue=document.getElementById("invoice").value;
  	     var advance=document.getElementById("advance_chk").value;
    	   	 var btnclick="approve";
    	   var brexid=document.getElementById("brexid").value;
    		var rdocno=document.getElementById("docnos").value;
    	   	 var invdate=document.getElementById("invdate").value;
    	   	 var branchid=document.getElementById("branchid").value; 
    		   	var x=new XMLHttpRequest();
    		x.onreadystatechange=function(){
    			if (x.readyState==4 && x.status==200)
    				{
    				 var itemsapprove= x.responseText;
    				 	var itemvalappr=itemsapprove.trim();
    				 	
    				 	//alert(items);
    				 	
    	  if(parseInt(itemvalappr)==1)
    	  	{
    		  $.messager.alert('Message', ' Record Approved Successfully ');
    				 
    		 document.getElementById("brexid").value="";
    		document.getElementById("docnos").value="";
    			    	document.getElementById("advchkval").value="";
    			    	 document.getElementById("invval").value="";
    			    	document.getElementById("configmethod").value="";
    			    	
    			       	document.getElementById("advance_chk").value="";
    			    	 document.getElementById("invoice").value="1";

    			    	
    					   document.getElementById("advance_chk").checked = false;
    			   //	 advchkval invval configmethod   advance_chk invoice
    				 document.getElementById("cldocno").value="";
	
    			   document.getElementById("clientname").value="";
	document.getElementById("rentaltype").value="";
	
	document.getElementById("docnos").value="";
	document.getElementById("branchid").value="";
	document.getElementById("hidrano").value="";
	document.getElementById("rano").value="";
	
	document.getElementById("invdate").value="";	    	
    			    	
    			    	 funreload(event);
    				}
    			else
    				{
    				$.messager.alert('Message', '  Not Approved ', function(r){
    				     
    			     });
    				}  
    		}
    		}
    		 
    	x.open("GET","savedata.jsp?list="+listss+"&invoicevalue="+invoicevalue+"&advance="+advance+"&brexid="+brexid+"&rdocno="+rdocno+"&btnclick="+btnclick+"&invdate="+invdate+"&branchid="+branchid);
    		x.send();
	
	
	}
function funCancel()
{

	 
    $.messager.confirm('Message', 'Do you want to Cancel?', function(r){
     	  
	        
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		 
     	  
     	   	 var btnclick="cancel";
     	   var brexid=document.getElementById("brexid").value;
     		var rdocno=document.getElementById("docnos").value;
     	   	 
     		   	var x=new XMLHttpRequest();
     		x.onreadystatechange=function(){
     			if (x.readyState==4 && x.status==200)
     				{
     				 var itemscancel= x.responseText;
     				 	var itemvalcan=itemscancel.trim();
     				 	
     				 	//alert(items);
     				 	
     	  if(parseInt(itemvalcan)==1)
     	  	{
     		  $.messager.alert('Message', ' Record Cancelled ');
     				 
     		 document.getElementById("brexid").value="";
     		document.getElementById("docnos").value="";
     			    	document.getElementById("advchkval").value="";
     			    	 document.getElementById("invval").value="";
     			    	document.getElementById("configmethod").value="";
     			    	
     			       	document.getElementById("advance_chk").value="";
     			    	 document.getElementById("invoice").value="1";

     			    	
     					   document.getElementById("advance_chk").checked = false;
     					  document.getElementById("cldocno").value="";
     						
     	     			   document.getElementById("clientname").value="";
     		document.getElementById("rentaltype").value="";
     		
     		document.getElementById("docnos").value="";
     		document.getElementById("branchid").value="";
     		document.getElementById("hidrano").value="";
     		document.getElementById("rano").value="";
     			    	 funreload(event);
     			 	
     				}
     			else
     				{
     				$.messager.alert('Message', '  Not Cancelled ', function(r){
     				     
     			     });
     				}  
     		}
     		}
     		 
     	x.open("GET","savedata.jsp?brexid="+brexid+"&rdocno="+rdocno+"&btnclick="+btnclick);
     		x.send();

     	}
    });
}

function disiem()
{
		
	 $('#searchuser').attr("disabled",true);
		
	 $('#approve').attr("disabled",true);
	 $('#cancel').attr("disabled",true);
		
	 $('#advance_chk').attr("disabled",true);
		
	 $('#invoice').attr("disabled",true);
	 

	
	}
</script>
</head>
<body onload="getBranch();disiem()">

<div id="mainBG" class="homeContent" data-type="background">
<div class="hidden-scrollbar">

<table width="100%">
<tr>

<td width="20%" valign="top">

<div class="master-container">
    <div class="sidebar-filters">

        <div class="sidebar-fixed-top">
            <jsp:include page="../../heading.jsp"></jsp:include>
        </div>

 
            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">From</td>
                        <td><div id="fromdate" name="fromdate" value='<s:property value="fromdate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">To</td>
                        <td><div id="todate" name="todate" value='<s:property value="todate"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Client</td>
                        <td>
                            <input type="text"
                                   name="clientname"
                                   id="clientname"
                                   readonly
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getclinfo(event);"
                                   value='<s:property value="clientname"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">RA No.</td>
                        <td>
                            <input type="text"
                                   name="rano"
                                   id="rano"
                                   readonly
                                   placeholder="Press F3 TO Search"
                                   onkeydown="getrano(event)"
                                   value='<s:property value="rano"/>'>
                            <input type="hidden" name="hidrano" id="hidrano"
                                   value='<s:property value="hidrano"/>'>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Type</td>
                        <td>
                            <select id="rentaltype" name="rentaltype">
                                <option value="">--Select--</option>
                                <option value="Daily">Daily</option>
                                <option value="Weekly">Weekly</option>
                                <option value="Monthly">Monthly</option>
                            </select>
                        </td>
                    </tr>
                </table>

                <button type="button"
                        class="btn-submit"
                        onclick="funcleardata()">
                    Clear
                </button>
            </div>

            <div class="filter-card">
                <table class="filter-table">
                    <tr>
                        <td class="label-cell">Advance</td>
                        <td>
                            <input type="checkbox"
                                   id="advance_chk"
                                   name="advance_chk"
                                   value="0"
                                   onclick="$(this).attr('value', this.checked ? 1 : 0)">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Invoice</td>
                        <td>
                            <select name="invoice" id="invoice">
                                <option value="">--Select--</option>
                                <option value="1">Month End</option>
                                <option value="2">Period</option>
                            </select>
                            <input type="hidden" id="hidinvoice" name="hidinvoice"
                                   value='<s:property value="hidinvoice"/>'/>
                        </td>
                    </tr>
                </table>

                <div style="display:flex; gap:8px; margin-top:10px;">
                    <button type="button"
                            class="btn-submit"
                            style="flex:1"
                            onclick="funApprove()">
                        Approve
                    </button>
                    <button type="button"
                            class="btn-submit"
                            style="flex:1"
                            onclick="funCancel()">
                        Cancel
                    </button>
                </div>
            </div>

            <div id="paychaaaaa" style="height:90px;"></div>

            
            <div hidden>
                <div id="jqxDateOut" value='<s:property value="jqxDateOut"/>'></div>
                <div id="jqxDaterentalout" value='<s:property value="jqxDaterentalout"/>'></div>
                <input type="hidden" id="docnos" value='<s:property value="docnos"/>'>
                <input type="hidden" id="cldocno" value='<s:property value="cldocno"/>'>
                <input type="hidden" id="advchkval" value='<s:property value="advchkval"/>'>
                <input type="hidden" id="invval" value='<s:property value="invval"/>'>
                <input type="hidden" id="configmethod" value='<s:property value="configmethod"/>'>
                <input type="hidden" id="branchid" value='<s:property value="branchid"/>'>
                <input type="hidden" id="brexid" value='<s:property value="brexid"/>'>
                <input type="hidden" id="invdate" value='<s:property value="invdate"/>'>
                <input type="hidden" id="excessinsur" value='<s:property value="excessinsur"/>'>
                <input type="hidden" id="normalinsu" value='<s:property value="normalinsu"/>'>
                <input type="hidden" id="cdwinsu" value='<s:property value="cdwinsu"/>'>
                <input type="hidden" id="supercdwinsu" value='<s:property value="supercdwinsu"/>'>
            </div>

        </div>
    </div>
</div>

</td>

<td width="80%" valign="top">

<table width="100%">
    <tr>
        <td>
            <div id="detlist">
                <jsp:include page="detailsGrid.jsp"></jsp:include>
            </div>
        </td>
    </tr>
    <tr>
        <td>
            <div id="rtariffchange">
                <jsp:include page="rtariffdetails.jsp"></jsp:include>
            </div>
        </td>
    </tr>
</table>

</td>

</tr>
</table>

</div>

<div id="clientwindow"><div></div></div>
<div id="ranowindow"><div></div></div>

</div>
</body>
</html>
	 