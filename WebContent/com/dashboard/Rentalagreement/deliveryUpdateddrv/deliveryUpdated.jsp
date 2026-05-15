
<jsp:include page="../../../../includes.jsp"></jsp:include>    
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GatewayERP(i)</title>
<% String contextPath=request.getContextPath();%>
<link href="../../../../css/dashboard.css" media="screen" rel="stylesheet" type="text/css" />  
<%-- <script type="text/javascript" src="../../js/dashboard.js"></script> --%> 
<style type="text/css">

html, body, #mainBG, .hidden-scrollbar {
    height: 100%;
    margin: 0;
    overflow: hidden;
}

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
    padding: 12px;
    margin-bottom: 12px;
}

.filter-table {
    width: 100%;
    border-spacing: 0 10px;
}

.label-cell {
    text-align: right;
    padding-right: 12px;
    font-size: 12px;
    font-weight: 600;
    color: #4e5e71;
    width: 90px;
}

input[type="text"], select {
    width: 100%;
    height: 24px !important;             
    padding: 2px 8px !important;         
    border: 1px solid #ccd6e0 !important;
    border-radius: 4px !important;       
    font-size: 12px !important;          
    background-color: #ffffff;
    box-sizing: border-box;
    color: #333;
}

.btn-submit, .myButton, .myButtons {
    width: 100%;
    height: 30px !important;            
    padding: 0 12px !important;
    background: #2563eb !important;
    color: #fff !important;
    border: none !important;
    border-radius: 4px !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    cursor: pointer;
    line-height: 30px !important;
    text-align: center;
    margin-top: 8px;
    transition: all 0.2s ease;
}

.btn-submit:hover, .myButton:hover {
    background: #1d4ed8 !important;
}

.main-content-wrapper {
    flex: 1;
    width: 100%;
    display: flex;
    flex-direction: column;
    padding: 15px 20px;
    background: #fff;
    height: 100vh;
    box-sizing: border-box;
}

.scrollable-grid-area {
    flex: 1;
    width: 100%;
    overflow: auto;
}
.input-search-container {
    position: relative;
    display: block; 
    width: 100%;
    min-width: 150px; 
    margin-right: 15px;
}

.input-search-container input {
    padding-right: 30px !important; 
    width: 100% !important;
    display: block;
    box-sizing: border-box !important;
}

.magnifier-icon {
    position: absolute;
    right: 8px; 
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #64748b; 
    z-index: 10;
    pointer-events: all; 
    
}
.magnifier-icon:hover {
    color: #2563eb; 
    transform: translateY(-50%) scale(1.1);
}
</style>




<script type="text/javascript">

$(document).ready(function () {
	
	$("#jqxDeliveryOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy"});
    $("#jqxDelTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false, value: new Date()});
    $("#jqxDateOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: "dd.MM.yyyy"});
    $("#jqxTimeOut").jqxDateTimeInput({ width: '100%', height: '24px', formatString: 'HH:mm', showCalendarButton: false });
	$("#del_Driver").attr('disabled',false);
	  $('#ratariff_checkout').dblclick(function(){
	  	    $('#Checkoutinfowindow').jqxWindow('open');
	       $('#Checkoutinfowindow').jqxWindow('focus');
       checkoutSearchContent('searchCheckout.jsp?', $('#Checkoutinfowindow')); 
    });
	
	 $("#jqxDeliveryOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 
	 $("#jqxDelTimeOut").jqxDateTimeInput({  width: '30%', height: '17px', formatString: 'HH:mm', showCalendarButton: false ,value: new Date()});
	 $("#jqxDateOut").jqxDateTimeInput({ width: '125px', height: '15px',formatString:"dd.MM.yyyy"});
	 $("#jqxTimeOut").jqxDateTimeInput({  width: '20%', height: '17px', formatString: 'HH:mm', showCalendarButton: false });
	  $("body").prepend('<div id="overlay" class="ui-widget-overlay" style="z-index: 1; display: none;"></div>');
	     $("body").prepend("<div id='PleaseWait' style='display: none;position:absolute; z-index: 1;top:180px;right:550px;'><img src='../../../../icons/31load.gif'/></div>");
	     $('#chauffeurinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Driver Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
	     $('#chauffeurinfowindow').jqxWindow('close');
	     
	     $('#Checkoutinfowindow').jqxWindow({ width: '30%', height: '55%',  maxHeight: '75%' ,maxWidth: '50%' , title: 'Checkout Search' ,position: { x: 200, y: 70 }, keyboardCloseKey: 27});
		 $('#Checkoutinfowindow').jqxWindow('close');

	 $('#jqxDeliveryOut').on('change', function (event) {
		 if( $('#del_Driver').val()!="")
			{
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));
		 
		  // out date
		 	 var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
				
			  indate1.setHours(0,0,0,0);
			  agmtdate1.setHours(0,0,0,0); 
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			  /*  $.messager.alert('Warning', ' Delivery Date Cannot be Less than Out Date ', function(r){
				     
			     }); */
		   return false;
		  }   
		
			}
		  
	
	       });
	 
	 
	  $('#jqxDelTimeOut').on('change', function (event) {
		   
		  if( $('#del_Driver').val()!="")
			{  
		   var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
		  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
		 
		  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
		  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  
		  indate1.setHours(0,0,0,0);
		  agmtdate1.setHours(0,0,0,0); 
		  
		   if(indate1>agmtdate1){
			   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date','warning');   
			 
		//  alert("Delivery Date Cannot be Less than Out Date");
		   return false;
		  }   
		
		   if(indate1.valueOf()==agmtdate1.valueOf()){
		 
		  var out=intime1.getHours();
		  var del=agmttime1.getHours();
		
		  if(out > del){
			  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
			  
		  // alert("Delivery Time Cannot be Less than Out Time");
		    return false;
		   }
		   if(out==del){
		    if(intime1.getMinutes()>agmttime1.getMinutes()){
		    	  $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');   
		    	
		    // alert("Delivery Time Cannot be Less than Out Time");
		     return false;
		    }
		   }
		  }
		  
			}
		  
		  
	
	       });
	  
	  
      $('#del_Driver').dblclick(function(){
    	  /* if($("#chktype").val()=="VCU")
    		  { */
	  	    $('#chauffeurinfowindow').jqxWindow('open');
  chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow')); 
    		  /* } */
	 });
      
	  
    
});
function getchauffeur(event){
	 /*  if($("#chktype").val()=="VCU")
	  { */
    	 var x= event.keyCode;
    	 if(x==114){
    	  $('#chauffeurinfowindow').jqxWindow('open');
     chauffeurSearchContent('SearchDriver.jsp?', $('#chauffeurinfowindow'));  	 }
    	 else{
    		 }
	 /*  } */
    	 }

function chauffeurSearchContent(url) {
     
  $.get(url).done(function (data) {
	
   $('#chauffeurinfowindow').jqxWindow('setContent', data);

	   }); 
  }


function funAttachBtn(){
	if ($("#rentaldoc").val()!="" && $("#chktype").val()=="RAG" ) {
		  $("#windowattach").jqxWindow('setTitle',"RAG - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	}
<%-- 	else if ($("#rentaldoc").val()!="" && $("#chktype").val()=="VCU" ) {
		  $("#windowattach").jqxWindow('setTitle',"VCU - "+document.getElementById("rentaldoc").value);
		changeAttachContent("<%=contextPath%>/com/dashboard/Attach.jsp?formCode=RAG&docno="+document.getElementById("rentaldoc").value+"&barchvals="+document.getElementById("branchids").value);		
	} --%>
	
	else {
		$.messager.alert('Message','Select a Document....!','warning');
		return;
	}
}
function changeAttachContent(url) {
	$.get(url).done(function (data) {
		    $('#windowattach').jqxWindow('open');
			$('#windowattach').jqxWindow('setContent',data);
			 $('#windowattach').jqxWindow('bringToFront');
}); 
}

function funreload(event)
{
	disitems();
	 var barchval = document.getElementById("cmbbranch").value;
	   $("#overlay, #PleaseWait").show();
 
	  $("#delupdiv").load("delupdateGrid.jsp?barchval="+barchval);
	
	
	}

function funupdate()
{
 
	 if(document.getElementById("ratariff_checkout").value=="")
	 {
		  $.messager.alert('Message',' Select Checkout','warning'); 
		 return 0;
	 }
	 if(document.getElementById("del_Driver").value=="")
	 {
		  $.messager.alert('Message',' Search Driver','warning'); 
		 return 0;
	 }
	
	 if(document.getElementById("del_KM").value=="")
	 {
		  $.messager.alert('Message',' Enter KM ','warning'); 
		 return 0;
	 }
	 if($('#del_Fuel').val()=="")
	 {
		 $.messager.alert('Message',' Select Fuel','warning'); 
		 return 0;
	 }
	 var outkm=document.getElementById("out_km").value;
		//alert("out"+outkm);
	 	var delkm=document.getElementById("del_KM").value;
	   if((parseFloat(delkm)<parseFloat(outkm)))
	 	{
		   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
		   return 0;
	 	}
	  var indate1=new Date($('#jqxDateOut').jqxDateTimeInput('getDate'));     // out date
	  var agmtdate1=new Date($('#jqxDeliveryOut').jqxDateTimeInput('getDate')); //del date
	  var intime1=new Date($('#jqxTimeOut').jqxDateTimeInput('getDate'));  //out time
	  var agmttime1=new Date($('#jqxDelTimeOut').jqxDateTimeInput('getDate')); // del time  

	  indate1.setHours(0,0,0,0);
	  agmtdate1.setHours(0,0,0,0); 
	  
	  
		var validdeldate=funDateInPeriod(agmtdate1);
		if(validdeldate==0){
			return 0; 
		}
		
		var curdate=new Date();
		curdate.setHours(0,0,0,0);
		
		if(agmtdate1-curdate==0){
        	var curtime=new Date();
        	if(agmttime1.getHours()>curtime.getHours()){
        		$.messager.alert('Warning','Future Time Restricted');
                return 0;	
        	}
        	else if(agmttime1.getHours()==curtime.getHours()){
        		if(agmttime1.getMinutes()>curtime.getMinutes()){
        			$.messager.alert('Warning','Future Time Restricted');
                    return 0;	
        		}
        	}
        }
		
	   if(indate1>agmtdate1){
		   $.messager.alert('Message',' Delivery Date Cannot be Less than Out Date ','warning');     
		 
	
	   return 0;
	  }   
	
	   if(indate1.valueOf()==agmtdate1.valueOf()){
	 
	  var out=intime1.getHours();
	  var del=agmttime1.getHours();
	
	  if(out > del){
		   $.messager.alert('Message',' Delivery Time Cannot be Less than Out Time ','warning');    
		 
	 
	    return 0;
	   }
	   if(out==del){
	    if(intime1.getMinutes()>agmttime1.getMinutes()){
	    	 $.messager.alert('Message','Delivery Time Cannot be Less than Out Time ','warning');    
	    	 
	     return 0;
	    }
	   }
	  }
	
	var rentaldoc=document.getElementById("rentaldoc").value;
	var rentaldate=document.getElementById("rentaldate").value;
	var fleetno=document.getElementById("fleetno").value;
	var del_Driverid=document.getElementById("del_Driverid").value;
	var del_KM=document.getElementById("del_KM").value;
	var del_Fuel=document.getElementById("del_Fuel").value;
	var jqxDeliveryOut= $('#jqxDeliveryOut').val();
	var jqxDelTimeOut= $('#jqxDelTimeOut').val();
	 var group=document.getElementById("group").value;
	var vlocation=document.getElementById("vehloca").value;
	
	var branchval=document.getElementById("branchids").value;
	var cldocno=document.getElementById("cldocno").value;
	var checkoutid=document.getElementById("ratariff_checkoutid").value;
    $.messager.confirm('Message', 'Do you want to save changes?', function(r){
     	if(r==false)
     	  {
     		return false; 
     	  }
     	else{
     		delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,checkoutid);
     	}
	     });
	
	
}
	function delsave(rentaldoc,rentaldate,fleetno,del_Driverid,del_KM,del_Fuel,jqxDeliveryOut,jqxDelTimeOut,group,vlocation,branchval,cldocno,checkoutid)
         {
		
		var x=new XMLHttpRequest();
		x.onreadystatechange=function(){
		if (x.readyState==4 && x.status==200)
			{
		
			 	var items= x.responseText;
			 	document.getElementById("cldocno").value="";
				document.getElementById("rentaldoc").value="";
				document.getElementById("chktype").value="";
				 $('#del_Driver').attr('placeholder', ''); 
				
				document.getElementById("rentaldate").value="";
			    document.getElementById("fleetno").value="";
				document.getElementById("del_Driverid").value="";
				document.getElementById("del_Driver").value="";
				document.getElementById("del_KM").value="";
				document.getElementById("del_Fuel").value="";
				$('#jqxDeliveryOut').val(new Date());
				$('#jqxDelTimeOut').val(new Date());
				document.getElementById("group").value="";
				document.getElementById("vehloca").value="";
				document.getElementById("out_km").value="";
				document.getElementById("out_fuel").value="";
				document.getElementById("branchids").value="";
				
				document.getElementById("ratariff_checkoutid").value="";
				
				$('#jqxDateOut').val(new Date());
				$('#jqxTimeOut').val(new Date());
				disitems();
				funreload(event);
			 	$.messager.alert('Message', '  Record successfully Updated ', function(r){
					     
				     });
	    }
		}
	     x.open("GET","savedeldate.jsp?rentaldoc="+rentaldoc+"&rentaldate="+rentaldate+"&fleetno="+fleetno+
	    		 "&del_Driverid="+del_Driverid+"&del_KM="+del_KM+"&del_Fuel="+del_Fuel+"&jqxDeliveryOut="+jqxDeliveryOut+
	    		 "&jqxDelTimeOut="+jqxDelTimeOut+"&group="+group+"&vlocation="+vlocation+"&branchval="+branchval+
	    		 "&cldocno="+cldocno+"&chktype="+document.getElementById("chktype").value+"&checkoutid="+checkoutid,true);
	     x.send();
		
		}
	
	function disitems()
	{
		document.getElementById("rentaldoc").value="";
		document.getElementById("chktype").value="";
		 $('#del_Driver').attr('placeholder', ''); 
		
		document.getElementById("rentaldate").value="";
	    document.getElementById("fleetno").value="";
		document.getElementById("del_Driverid").value="";
		document.getElementById("del_Driver").value="";
		document.getElementById("del_KM").value="";
		document.getElementById("del_Fuel").value="";
		$('#jqxDeliveryOut').val(new Date());
		$('#jqxDelTimeOut').val(new Date());
		document.getElementById("group").value="";
		document.getElementById("vehloca").value="";
		document.getElementById("out_km").value="";
		document.getElementById("out_fuel").value="";
		document.getElementById("branchids").value="";
		document.getElementById("cldocno").value="";
		$('#jqxDateOut').val(new Date());
		$('#jqxTimeOut').val(new Date());
		
		
		 $('#jqxDeliveryOut').jqxDateTimeInput({ disabled: true});
		 $('#jqxDelTimeOut').jqxDateTimeInput({ disabled: true});
		 
		 
		 $('#del_KM').attr("readonly",true);
		 $('#del_Fuel').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		 $('#driverUpdate').attr("disabled",true);
		
		 $('#attachbtns').attr("disabled",true);
		
	}
    function isNumber(evt) {
        var iKeyCode = (evt.which) ? evt.which : evt.keyCode
        if (iKeyCode != 46 && iKeyCode > 31 && (iKeyCode < 48 || iKeyCode > 57))
        	{
        	
        
        	 $.messager.alert('Message',' Enter Numbers Only ','warning');    
        	
        	 
            return false;
        	}
        
        return true;
    }	
	function funchkkm()
	{
		 var outkm=document.getElementById("out_km").value;
			//alert("out"+outkm);
		 	var delkm=document.getElementById("del_KM").value;
		   if((parseFloat(delkm)<parseFloat(outkm)))
			   
		 	
		 	{
			   
			   $.messager.alert('Message',' Delivery KM Less Than Out KM','warning'); 
			
			 
			   return 0;
		 	}
	
		
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
	
	function funExportBtn(){
		 //  $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		   
		   
		   
		   if(parseInt(window.parent.chkexportdata.value)=="1")
		    {
		    JSONToCSVCon(datasssss, 'RAG-Delivery Update', true);
		    }
		   else
		    {
		    $("#delupdategrid").jqxGrid('exportdata', 'xls', 'RAG-Delivery Update');
		    }
		   
		   
		   
		 }	
	
</script>
</head>
<body onload="getBranch();disitems();">
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
                        <td class="label-cell">Checkout</td>
                        <td>
                            <input type="text" id="ratariff_checkout" placeholder="Press F3 To Search" name="ratariff_checkout" value='<s:property value="ratariff_checkout"/>' onKeyDown="getcheckout(event);"/>
                            <input type="hidden" id="ratariff_checkoutid" name="ratariff_checkoutid" value='<s:property value="ratariff_checkoutid"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Driver</td>
                        <td>
                           <div class="input-search-container"> <input type="text" name="del_Driver" id="del_Driver"   onKeyDown="getchauffeur(event);" value='<s:property value="del_Driver"/>' readonly placeholder="Press F3 To Search"/>
                       <svg class="magnifier-icon" onclick="triggerToSearch();" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
        </svg>
        </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">KM</td>
                        <td>
                            <input type="text" name="del_KM" id="del_KM" value='<s:property value="del_KM"/>' onblur="funchkkm()" onkeypress="javascript:return isNumber (event)">
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Fuel</td>
                        <td>
                            <select name="del_Fuel" id="del_Fuel" value='<s:property value="del_Fuel"/>'>
                                <option value="" selected>-Select-</option>
                                <option value="0.000">Level 0/8</option>
                                <option value="0.125">Level 1/8</option>
                                <option value="0.250">Level 2/8</option>
                                <option value="0.375">Level 3/8</option>
                                <option value="0.500">Level 4/8</option>
                                <option value="0.625">Level 5/8</option>
                                <option value="0.750">Level 6/8</option>
                                <option value="0.875">Level 7/8</option>
                                <option value="1.000">Level 8/8</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Date</td>
                        <td>
                            <div id='jqxDeliveryOut' name='jqxDeliveryOut' value='<s:property value="jqxDeliveryOut"/>'></div>
                            <input type="hidden" id="hidjqxDeliveryOut" name="hidjqxDeliveryOut" value='<s:property value="hidjqxDeliveryOut"/>'/>
                        </td>
                    </tr>
                    <tr>
                        <td class="label-cell">Time</td>
                        <td>
                            <div id='jqxDelTimeOut' name='jqxDelTimeOut' value='<s:property value="jqxDelTimeOut"/>'></div>
                            <input type="hidden" id="hidjqxDelTimeOut" name="hidjqxDelTimeOut" value='<s:property value="hidjqxDelTimeOut"/>'/>
                        </td>
                    </tr>
                </table>
            </div>

          <div class="filter-card">

    <input type="button"
           name="driverUpdate"
           id="driverUpdate"
           class="myButton"
           value="Update"
           onclick="funupdate()"
           style="width:100%; margin-bottom:6px;">

    <input type="button"
           name="attachbtns"
           id="attachbtns"
           class="myButton"
           value="Attach"
           onclick="funAttachBtn()"
           style="width:100%;">

</div>
            <div style="display:none;">
                <input type="hidden" name="rentaldoc" id="rentaldoc" value='<s:property value="rentaldoc"/>' >
                <input type="hidden" name="chktype" id="chktype" value='<s:property value="chktype"/>' >
                <input type="hidden" name="rentaldate" id="rentaldate" value='<s:property value="rentaldate"/>' >
                <input type="hidden" name="fleetno" id="fleetno" value='<s:property value="fleetno"/>' >
                <input type="hidden" name="del_Driverid" id="del_Driverid" value='<s:property value="del_Driverid"/>' >
                <input type="hidden" name="out_km" id="out_km" value='<s:property value="out_km"/>' >
                <input type="hidden" name="out_fuel" id="out_fuel" value='<s:property value="out_fuel"/>' >
                <div id='jqxDateOut' name='jqxDateOut' value='<s:property value="jqxDateOut"/>'></div>
                <div id='jqxTimeOut' name='jqxTimeOut' value='<s:property value="jqxTimeOut"/>'></div>
                <input type="hidden" name="branchids" id="branchids" value='<s:property value="branchids"/>' >
                <input type="hidden" name="group" id="group" value='<s:property value="group"/>' >
                <input type="hidden" name="vehloca" id="vehloca" value='<s:property value="vehloca"/>' >
                <input type="hidden" name="cldocno" id="cldocno" value='<s:property value="cldocno"/>' >
            </div>
        </div>
    </div>

    <div class="main-content-wrapper">
        <div class="scrollable-grid-area">
            <div id="delupdiv">
                <jsp:include page="delupdateGrid.jsp"></jsp:include>
            </div>
        </div>
    </div>
</div>

     
</div>
<div id="chauffeurinfowindow">
   <div ></div>
</div>
<div id="Checkoutinfowindow">
   <div ></div>
</div>
</div>
</body>
