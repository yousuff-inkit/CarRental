
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
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
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
    .filter-card *, fieldset, legend, .branch, td, tr, label, span {
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
    .myButton {
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
    }

    .myButton:hover { background-color: #1d4ed8 !important; }

    fieldset {
        border: 1px solid #ccd6e0 !important;
        border-radius: 8px !important;
        padding: 12px !important;
        margin-top: 10px !important;
    }
    legend {
        font-weight: bold !important;
        padding: 0 5px !important;
        font-size: 13px !important;
    }
</style>

<script type="text/javascript">

$(document).ready(function () {
	
	 $("#jqxDateOut").jqxDateTimeInput({ width: '110px', height: '15px', formatString:"dd.MM.yyyy"});

      $("#jqxTimeOut").jqxDateTimeInput({ width: '80%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
      $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
 
	
    $('#vehinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '85%' ,maxWidth: '80%' ,title: 'Fleet Search' , position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#vehinfowindow').jqxWindow('close');
	  $('#Rentalagentinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Rental Agent Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Rentalagentinfowindow').jqxWindow('close');
		 
	 $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 120 }, keyboardCloseKey: 27});
	 $('#Checkoutinfowindow').jqxWindow('close');
	   $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');
     $('#driverinfowindow').jqxWindow({ width: '50%', height: '58%',  maxHeight: '62%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 250, y: 60 }, keyboardCloseKey: 27});
     $('#driverinfowindow').jqxWindow('close'); 	 	
	
	 $("#fromdate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#todate").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
	 var onemounth=new Date(new Date(fromdates).setMonth(fromdates.getMonth()-1)); 
	    
     $('#fromdate').jqxDateTimeInput('setDate', new Date(onemounth));
	 $("#date").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $('#todate').on('change', function (event) {
			
		   var fromdates=new Date($('#fromdate').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var todates=new Date($('#todate').jqxDateTimeInput('getDate')); //del date
		 	 
		   if(fromdates>todates){
			   
			   $.messager.alert('Message','To Date Less Than From Date  ','warning');   
			 
		   return false;
		  }   
	 });
	 
	   $('#ratariff_checkout').dblclick(function(){
	  	    $('#Checkoutinfowindow').jqxWindow('open');
	       $('#Checkoutinfowindow').jqxWindow('focus');
	       checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
     });


	   $('#rarenral_Agent').dblclick(function(){
	  	    $('#Rentalagentinfowindow').jqxWindow('open');
	       $('#Rentalagentinfowindow').jqxWindow('focus');
	      rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow')); 
     });
	   $('#txtfleetno').dblclick(function(){
	  	    $('#vehinfowindow').jqxWindow('open');
             $('#vehinfowindow').jqxWindow('focus');
            vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val()); 
            });
	     $('#radriverlist').dblclick(function(){
		  	    $('#chauffeurinfowindow').jqxWindow('open');
	  
	  chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow')); 
		 });
	     
	     $('#clientdrv').dblclick(function(){
		  	    $('#driverinfowindow').jqxWindow('open');
	  
		  	  driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val()); 
		 });
	     
	      
	          
});

function getcldrv(event){
	 var x= event.keyCode;
	 if(x==114){
	  $('#driverinfowindow').jqxWindow('open');

	  driverinfoSearchContent('clientDriverSearch.jsp?clientval='+$('#clientid').val());  }
	 else{
		 }
	 }
function driverinfoSearchContent(url) {
     	 //alert(url);
     		 $.get(url).done(function (data) {
     			 
     			 $('#driverinfowindow').jqxWindow('open');
     		$('#driverinfowindow').jqxWindow('setContent', data);
     
     	}); 
     	} 
function getcheckout(event){
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#Checkoutinfowindow').jqxWindow('open');
    
     checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow'));   }
    	 else{
    		 }
    	 }
	       function checkoutSearchContent(url) {
                 
	                 $.get(url).done(function (data) {
           
		           $('#Checkoutinfowindow').jqxWindow('setContent', data);

          	}); 
	           	}
	       
	       
	       function getrentalAgent(event){
    	       	 var x= event.keyCode;
    	       	 if(x==114){
    	       	  $('#Rentalagentinfowindow').jqxWindow('open');
    	       
    	          
    	       	rentalagentSearchContent('SearchRentalAgent.jsp?', $('#Rentalagentinfowindow'));  }
    	       	 else{
    	       		 }
    	       	 }

      function rentalagentSearchContent(url) {
             //alert(url);
               $.get(url).done(function (data) {
      //alert(data);
	           $('#Rentalagentinfowindow').jqxWindow('setContent', data);

     	}); 
         	}
      
      function getvehinfo(event){
	       	 var x= event.keyCode;
	       	 if(x==114){
	       	  $('#vehinfowindow').jqxWindow('open');
	       
	          
	          vehinfoSearchContent('vehinfo.jsp?groupid='+$('#grpid').val()+'&branchids='+$('#branchids').val());   }
	       	 else{
	       		 }
	       	 }
        
	        function vehinfoSearchContent(url) {
	      
	       		 $.get(url).done(function (data) {
	       		
	       		$('#vehinfowindow').jqxWindow('setContent', data);
	       
	       	}); 
	       	}
	        
	        function getchauffeur(event){
     	       	 var x= event.keyCode;
     	       	 if(x==114){
     	       	  $('#chauffeurinfowindow').jqxWindow('open');
     	       
     	          
     	        chauffeurSearchContent('SearchChauffeur.jsp?', $('#chauffeurinfowindow'));  	 }
     	       	 else{
     	       		 }
     	       	 }

            function chauffeurSearchContent(url) {
  	           
  		    $.get(url).done(function (data) {
  			
  		     $('#chauffeurinfowindow').jqxWindow('setContent', data);
   
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
		 $("#duedetailsgrid").jqxGrid('clear');
	 $("#bookfollowdiv").load("bookingfollowGrid.jsp?barchval="+barchval+"&fromdate="+fromdate+"&todate="+todate);

		   }
	
	}
	
function getinfo() {
	var x = new XMLHttpRequest();
	x.onreadystatechange = function() {
		if (x.readyState == 4 && x.status == 200) {
			var items = x.responseText;
		//alert(items);
			items = items.split('####');
			
			var srno  = items[0].split(",");
			var process = items[1].split(",");
			var optionsbranch = '<option value="" selected>-- Select -- </option>';
			for (var i = 0; i < process.length; i++) {
				optionsbranch += '<option value="' + srno[i].trim() + '">'
						+ process[i] + '</option>';
			}
			$("select#cmbinfo").html(optionsbranch);
			
		} else {
			//alert("Error");
		}
	}
	x.open("GET","getinfo.jsp", true);
	x.send();
}
function funupdate()
{
	
	
	 if(document.getElementById("cmbinfo").value=="")
	 {
		 $.messager.alert('Message','Select Process ','warning');   
					 
		 return 0;
	 }
	
	 if($('#remarks').val()=="")
	 {
		 $.messager.alert('Message','Enter Remarks ','warning');   
		 return 0;
	 }
	
	 var remarkss = document.getElementById("remarks").value;
	 var nmax = remarkss.length;
		
		
      if(nmax>99)
   	   {
   	  $.messager.alert('Message',' Remarks cannot contain more than 100 characters ','warning');   
   	
			return false; 
   	   
   	 
   	 
   	   } 
      
     var rdocno = document.getElementById("rdocno").value;
 	 var branchids = document.getElementById("branchids").value;
 	 var remarks = document.getElementById("remarks").value;
 	 var cmbinfo = document.getElementById("cmbinfo").value;
 	 var clname=document.getElementById("clname").value;
 	 var reftype=document.getElementById("reftype").value;
 	 var folldate =  $('#date').val();

	    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
	     	  
		        
	     	if(r==false)
	     	  {
	     		return false; 
	     	  }
	     	else{
	     		 savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype);	
	     	}
		     });
	
	
	
}
function savegriddata(rdocno,branchids,remarks,cmbinfo,folldate,clname,reftype)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText;
			 
			 document.getElementById("rdocno").value="";
			 document.getElementById("branchids").value="";
			 document.getElementById("remarks").value="";
			 document.getElementById("cmbinfo").value="";
			 document.getElementById("clname").value="";
			 document.getElementById("reftype").value=""; 
			 
			  $('#date').val(new Date());
			  
			  $.messager.alert('Message', '  Record Successfully Updated ', function(r){
		 		 
		 		 
			     
		     });
			 funreload(event); 
			 $("#duedetailsgrid").jqxGrid('clear');
			disitems();
			 
			
			}
	}
		
x.open("GET","booksavedata.jsp?rdocno="+rdocno+"&branchids="+branchids+"&remarks="+remarks+"&cmbinfo="+cmbinfo+"&folldate="+folldate+"&clname="+clname+"&reftype="+reftype,true);

x.send();
		
}

function disitems()
{
	
	 $('#date').jqxDateTimeInput({ disabled: true});
	 $('#jqxDateOut').jqxDateTimeInput({ disabled: true});
	 $('#jqxTimeOut').jqxDateTimeInput({ disabled: true});
	 
	 
	  $("#delcharge").prop("disabled", true);
	
	 $('#cmbinfo').attr("disabled",true);
	 $('#remarks').attr("readonly",true);
	 $('#driverUpdate').attr("disabled",true);
	
	 $('#txtfleetno').attr("disabled",true);
	 $('#delivery_chk').attr("disabled",true);
	 $('#radrivercheck').attr("disabled",true);
	 $('#radriverlist').attr("disabled",true);
	 $('#clientdrv').attr("disabled",true);
	 $('#rarenral_Agent').attr("disabled",true);
	 $('#ratariff_checkout').attr("disabled",true);
	 $('#rentalcreate').attr("disabled",true);
	 
	 
	
	 

	
}


function funchangeinfo()
{
	
	 $('#date').jqxDateTimeInput( 'focus');
		
	
	}
	
/* function funExportBtn(){
	   $("#qutfollowgrid").jqxGrid('exportdata', 'xls', 'Booking Follow Up');
	 }	
	 */
	
	 
	 function funExportBtn(){
			$("#bookfollowdiv").excelexportjs({
				containerid: "bookfollowdiv", 
				datatype: 'json', 
				dataset: null, 
				gridId: "qutfollowgrid", 
				columns: getColumns("qutfollowgrid") ,   
				worksheetName:"Booking Follow Up"
				});
			
		}
function fundriverdisable(){
	 
	   if (document.getElementById('delivery_chk').checked) {
		   
		   document.getElementById("radriverlist").value="";
		   $("#radriverlist").prop("disabled", false);
		  
		   document.getElementById("radrivercheck").checked = false;
		   $("#radrivercheck").prop("disabled", true);
		   document.getElementById("del_chaufferid").value="";
	       document.getElementById("delivery").value=1; 
	       $("#delcharge").prop("disabled", false);
		   
		  
	   }	else
		   
		   {   
		   $("#radriverlist").prop("disabled", true);
		   $("#delcharge").prop("disabled", true);
		   $("#radrivercheck").prop("disabled", false);
		
		   document.getElementById('radriverlist').value="";
		
		   document.getElementById("del_chaufferid").value="";
		   document.getElementById("delcharge").value="";

	       document.getElementById("delivery").value=0;
			   
		   
		   } 
         }


function funShaffurdisable(){
	  
	    if (document.getElementById('radrivercheck').checked) {
	    	document.getElementById("radriverlist").value="";
	    	
	    	
		   $("#radriverlist").prop("disabled", false);
		   document.getElementById("delivery_chk").checked = false;
		   $("#delivery_chk").prop("disabled", true);
		   
		 //  $("#delivery_chk").prop("clientdrv", true);
		 document.getElementById("clientdrvid").value="";
		 document.getElementById("clientdrv").value="";
		 document.getElementById("del_chaufferid").value="";
		  $("#clientdrv").prop("disabled", true);
		  
		  $("#delcharge").prop("disabled", true);
		     document.getElementById("chuef").value=1;
		     document.getElementById("delcharge").value="";
		  
		
	   }
	   else
		   {
		   $("#radriverlist").prop("disabled", true);
            $("#delivery_chk").prop("disabled", false);
		   document.getElementById('radriverlist').value="";
		   document.getElementById('delcharge').value="";
		   $("#delcharge").prop("disabled", true);

		   document.getElementById("del_chaufferid").value="";
		   $("#delivery_chk").prop("clientdrv", false);
			 document.getElementById("clientdrvid").value="";
			 document.getElementById("clientdrv").value="";
			 document.getElementById("del_chaufferid").value="";
			 
			 
			  $("#clientdrv").prop("disabled", false);
			 
			     document.getElementById("chuef").value=0; 
		   }
}

function chkavailable(valfleet,dateout,timeout)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
    			
			var items=x.responseText;
	var chkfleet=items.trim();
   
      	 if(chkfleet==1)
				 {
				 $.messager.alert('Message','Fleet Is Not Available ','warning');   
				 return 0;
				 }
			 else
				 {
				    var fleetnos = document.getElementById("txtfleetno").value;
					var rdocno = document.getElementById("rdocno").value;
					 var deldrvss = document.getElementById("del_chaufferid").value;
				 	 var clientdrs = document.getElementById("clientdrvid").value;
				 	 var rantalagt = document.getElementById("tariffrenral_Agentid").value;
				 	 var chkout = document.getElementById("ratariff_checkoutid").value;
				 	 var delivery = document.getElementById("delivery").value;
				 	 var chuef = document.getElementById("chuef").value;
				 	 var delcharge = document.getElementById("delcharge").value;
				 	 var mrano=document.getElementById("mrano").value;
				 	 var branchids = document.getElementById("branchids").value;
				 	 
				 	 
 
				 	 if(delcharge==""|| typeof(delcharge)=="undefined" ||typeof(delcharge)=="NaN")
				 	 {
				 		delcharge=0; 
				 		 
				 	 }
				 	 
				 	
				    $.messager.confirm('Message', 'Do you want to Create A Rental Agreement?', function(r){
				     	  
					        
				     	if(r==false)
				     	  {
				     		return false; 
				     	  }
				     	else{
				     		 creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano);	
				     	}
					     });
				
				 }
	
			
			}
		
	}
		
x.open("GET","chkavailablefleet.jsp?valfleet="+valfleet+"&dateout="+dateout+"&timeout="+timeout,true);

x.send();
		
}


function funrentalcreate()
{

	var fleetnos = document.getElementById("txtfleetno").value;
	var rdocno = document.getElementById("rdocno").value;
	 var deldrvss = document.getElementById("del_chaufferid").value;
 	 var clientdrs = document.getElementById("clientdrvid").value;
 	 var rantalagt = document.getElementById("tariffrenral_Agentid").value;
 	 var chkout = document.getElementById("ratariff_checkoutid").value;
 	 var delivery = document.getElementById("delivery").value;
 	 var chuef = document.getElementById("chuef").value;
 	 var mrano=document.getElementById("mrano").value;
	 var branchids=document.getElementById("branchids").value;
 	 
 	 if($('#txtfleetno').val()=="")
	 {
		 $.messager.alert('Message','Select Fleet','warning');   
		 return 0;
	 }
 	 
 	
 	 
 	  if ((document.getElementById('delivery_chk').checked)) {
		   
 	  	   var delchrg=document.getElementById("delcharge").value;
 				
 				if(delchrg=="")
 					{
 					 $.messager.alert('Message','Enter Delivery Charge ','warning');   
 		 
 					return 0;
 					}
 				
 		   }
     if ((document.getElementById('delivery_chk').checked)||(document.getElementById('radrivercheck').checked)) {
		   
  	   var drvname=document.getElementById("radriverlist").value;
			
			if(drvname=="")
				{
				 $.messager.alert('Message','Select Driver ','warning');   
	 
				return 0;
				}
			
	   }
 	 
 	if(rantalagt=="")
	 {
		 $.messager.alert('Message','Select Rental Agent ','warning');   
					 
		 return 0;
	 }
	
	 if(chkout=="")
	 {
		 $.messager.alert('Message','Select Checkout','warning');   
		 return 0;
	 }
 	 
	  var valfleetno=document.getElementById("txtfleetno").value;
		var dateout=$('#jqxDateOut').val();
		var timeout=$('#jqxTimeOut').val();
		

		var maindate = $('#jqxDateOut').jqxDateTimeInput('getDate');

		var currentDate = new Date(new Date());
	     
	        if(maindate>currentDate){
	        	 $.messager.alert('Message','Future Date, Transaction Restricted.','warning');   
	        
	        return 0;
	       } 
		
		
		
		chkavailable(valfleetno,dateout,timeout);

}

function creategriddata(rdocno,deldrvss,clientdrs,rantalagt,chkout,delivery,chuef,fleetnos,branchids,dateout,timeout,delcharge,mrano)
{
	
	var x=new XMLHttpRequest();
	x.onreadystatechange=function(){
	if (x.readyState==4 && x.status==200)
		{
		
     			
			var items=x.responseText.trim();
		
			if(items=='NO') 
				{
				
				  $.messager.alert('Message', 'Not Create ', function(r){
				 		 
				 		 
					     
				     });
				
			  
				}
			
			
			else
				{
				  document.getElementById("rdocno").value="";
					 document.getElementById("txtfleetno").value="";
					 document.getElementById("rdocno").value="";
					  document.getElementById("del_chaufferid").value="";
				 	  document.getElementById("clientdrvid").value="";
				 	  document.getElementById("tariffrenral_Agentid").value="";
				 	  document.getElementById("ratariff_checkoutid").value="";
				 	  document.getElementById("delivery").value="";
				 	  document.getElementById("chuef").value="";
				 	 document.getElementById("radriverlist").value="";
				 	 document.getElementById("delcharge").value="";
				 	document.getElementById("mrano").value="";
				 	 
						 document.getElementById("clientdrv").value="";
						  document.getElementById("rarenral_Agent").value="";
					 	  document.getElementById("ratariff_checkout").value="";
					 	 document.getElementById("delivery_chk").checked=false; 
					 
					 	 document.getElementById("radrivercheck").checked=false; 
					 	  $('#jqxDateOut').val(new Date());
					 	  $('#jqxTimeOut').val(new Date());
			

				  $.messager.alert('Message', ' Successfully Created '+'RA NO Is '+items);
				 funreload(event); 
		
				disitems();
				
				}
			
			
			}
	}
		
x.open("GET","rentalagmtsavedata.jsp?docno="+rdocno+"&deldrvss="+deldrvss+"&clientdrs="+clientdrs+"&rantalagt="+rantalagt+"&chkout="+chkout+"&delivery="+delivery+"&chuef="+chuef+'&fleetnos='+fleetnos+'&branchids='+branchids+'&dateout='+dateout+'&timeout='+timeout+'&delcharge='+delcharge+"&mrano="+mrano,true);

x.send();
		
}

function isNumber(evt) {
    var iKeyCode = (evt.which) ? evt.which : evt.keyCode
    if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
    	{
    	
    	
  	  $.messager.alert('Message', 'Enter Numbers Only');
    	
 	  
       
        return false;
    	}
  
    return true;
}
</script>
</head>
<body onload="getBranch();getinfo();disitems();">
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
                        <td class="label-cell">Process</td>
                        <td>
                            <select id="cmbinfo" name="cmbinfo" value='<s:property value="cmbinfo"/>' onchange="funchangeinfo()">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td><div id='date' name='date' value='<s:property value="date"/>'></div></td>
                    </tr>
                    <tr>
                        <td class="label-cell">Remarks</td>
                        <td><input type="text" id="remarks" name="remarks" value='<s:property value="remarks"/>'></td>
                    </tr>
                </table>
                <input type="Button" name="driverUpdate" id="driverUpdate" class="myButton" value="Update" onclick="funupdate()">
            </div>

            <div id='cpppp'>
                <fieldset>
                    <legend>Rental Agreement Create</legend>
                    <table class="filter-table">
                        <tr>
                            <td class="label-cell">Fleet</td>
                            <td><input type="text" id="txtfleetno" name="txtfleetno" readonly placeholder="Press F3 To Search" value='<s:property value="txtfleetno"/>' onKeyDown="getvehinfo(event);" onfocus="this.placeholder = ''" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center" style="padding: 10px 0;">
                                <label class="branch">Delivery</label>
                                <input type="checkbox" id="delivery_chk" name="delivery_chk" value="0" onchange="fundriverdisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                                &nbsp;&nbsp;
                                <label class="branch">Chauffeur</label>
                                <input type="checkbox" id="radrivercheck" name="radrivercheck" value="0" onchange="funShaffurdisable()" onclick="$(this).attr('value', this.checked ? 1 : 0)">
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Del Charge</td>
                            <td><input type="text" id="delcharge" name="delcharge" style="text-align: right;" value='<s:property value="delcharge"/>' onblur="funRoundAmt(this.value,this.id);" onkeypress="javascript:return isNumber(event);"/></td>
                        </tr>
                        <tr>
                            <td class="label-cell">Driver</td>
                            <td>
                                <input type="text" readonly id="radriverlist" name="radriverlist" placeholder="Press F3 To Search" value='<s:property value="radriverlist"/>' onKeyDown="getchauffeur(event);" />
                                <input type="hidden" id="del_chaufferid" name="del_chaufferid" value='<s:property value="del_chaufferid"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Client Drv</td>
                            <td>
                                <input type="text" id="clientdrv" readonly name="clientdrv" placeholder="Press F3 To Search" value='<s:property value="clientdrv"/>' onKeyDown="getcldrv(event);" />
                                <input type="hidden" id="clientdrvid" name="clientdrvid" value='<s:property value="clientdrvid"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Agent</td>
                            <td>
                                <input type="text" id="rarenral_Agent" name="rarenral_Agent" readonly placeholder="Press F3 To Search" value='<s:property value="rarenral_Agent"/>' onKeyDown="getrentalAgent(event);" onfocus="this.placeholder = ''"/>
                                <input type="hidden" id="tariffrenral_Agentid" name="tariffrenral_Agentid" value='<s:property value="tariffrenral_Agentid"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">Checkout</td>
                            <td>
                                <input type="text" id="ratariff_checkout" placeholder="Press F3 To Search" readonly="readonly" name="ratariff_checkout" value='<s:property value="ratariff_checkout"/>' onKeyDown="getcheckout(event);" onfocus="this.placeholder = ''"/>
                                <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>
                            </td>
                        </tr>
                        <tr>
                            <td class="label-cell">DateOut</td>
                            <td><div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">TimeOut</td>
                            <td><div id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div></td>
                        </tr>
                        <tr>
                            <td class="label-cell">MRA No</td>
                            <td><input type="text" id="mrano" name="mrano" value='<s:property value="mrano"/>'/></td>
                        </tr>
                    </table>
                    <input type="Button" name="rentalcreate" id="rentalcreate" class="myButton" value="Create" onclick="funrentalcreate()">
                </fieldset>
            </div>

            <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
            <input type="hidden" name="rdocno" id="rdocno" value='<s:property value="rdocno"/>' >
            <input type="hidden" name="clname" id="clname" value='<s:property value="clname"/>' >
            <input type="hidden" name="reftype" id="reftype" value='<s:property value="reftype"/>' >
            <input type="hidden" name="clientid" id="clientid" value='<s:property value="clientid"/>' >
            <input type="hidden" name="delivery" id="delivery" value='<s:property value="delivery"/>' >
            <input type="hidden" name="chuef" id="chuef" value='<s:property value="chuef"/>' >
            <input type="hidden" name="grpid" id="grpid" value='<s:property value="grpid"/>' >
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="bookfollowdiv">
                <jsp:include page="bookingfollowGrid.jsp"></jsp:include>
            </div>
            <div id="detaildiv">
                <jsp:include page="detailgrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>
</div>
<div id="vehinfowindow">
   <div ></div>
</div> 
<div id="Rentalagentinfowindow">
   <div ></div>
</div>
<div id="Checkoutinfowindow">
   <div ></div>
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
<div id="driverinfowindow">
   <div ></div>
</div>
</div>
</body>
</html>